From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Wed, 28 Jun 2017 22:14:47 +0000
Message-ID: <BN6PR12MB16525D2E89F4AB61DC36EFBEF7DD0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1496954035.4188.1.camel@rutgers.edu>
	<1498062018.17007.6.camel@rutgers.edu>
	<bf685f44-019c-4c21-25d4-6a6ea647b7cc@amd.com>
	<1498079371.17007.18.camel@rutgers.edu>
	<20170622092053.GV30388@8bytes.org>
	<1498144389.17007.25.camel@rutgers.edu>
	<20170622215735.GW30388@8bytes.org>
	<1498227647.17007.31.camel@rutgers.edu>
	<20170626121430.GX30388@8bytes.org>
	<1498580675.10525.3.camel@rutgers.edu>
	<20170628083659.GA30388@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170628083659.GA30388-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Joerg Roedel' <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Cc: "Lendacky, Thomas" <Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org>, "Nath,
	Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Wednesday, June 28, 2017 4:37 AM
> To: Jan Vesely; Deucher, Alexander
> Cc: Lendacky, Thomas; Nath, Arindam; Craig Stein; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; Duran, Leo; Suthikulpanit, Suravee
> Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
> 
> [Adding Alex Deucher]
> 
> Hey Alex,
> 
> On Tue, Jun 27, 2017 at 12:24:35PM -0400, Jan Vesely wrote:
> > On Mon, 2017-06-26 at 14:14 +0200, Joerg Roedel wrote:
> 
> > > How does that 'dGPU goes to sleep' work? Do you put it to sleep
> manually
> > > via sysfs or something? Or is that something that amdgpu does on its
> > > own?
> >
> > AMD folks should be able to provide more details. afaik, the driver
> > uses ACPI methods to power on/off the device. Driver routines wake the
> > device up before accessing it and there is a timeout to turn it off
> > after few seconds of inactivity.
> >
> > >
> > > It looks like the GPU just switches the ATS unit off when it goes to
> > > sleep and doesn't answer the invalidation anymore, which explains the
> > > completion-wait timeouts.
> >
> > Both MMIO regs and PCIe config regs are turned off so it would not
> > surprise me if all PCIe requests were ignored by the device in off
> > state. it should be possible to request device wake up before
> > invalidating the relevant IOMMU domain. I'll leave to more
> > knowledgeable ppl to judge whether it's a good idea (we can also
> > postpone such invalidations until the device is woken by other means)
> 
> Can you maybe sched some light on how the sleep-mode of the GPUs work?
> Is it initiated by the GPU driver or from somewhere else? In the case
> discussed here it looks like the ATS unit of the GPU is switched of,
> causing IOTLB invalidation timeouts on the IOMMU side.
> 
> If that is the case we might need some sort of dma-api extension so that
> the GPU driver can tell the iommu driver that the device is going to be
> quiet.

I assume you are talking about Hybrid/PowerXpress laptops where the dGPU can be powered down dynamically?  That is done via the runtime pm subsystem in the kernel.  We register several callbacks with that, and then it takes care of the power down auto timers and such.  The actual mechanism to power down the GPU varies for platform to platform (platform specific ACPI methods on early systems, D3cold on newer ones).

Alex
