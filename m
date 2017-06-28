From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Wed, 28 Jun 2017 10:36:59 +0200
Message-ID: <20170628083659.GA30388@8bytes.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498580675.10525.3.camel-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, "Nath,
	Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[Adding Alex Deucher]

Hey Alex,

On Tue, Jun 27, 2017 at 12:24:35PM -0400, Jan Vesely wrote:
> On Mon, 2017-06-26 at 14:14 +0200, Joerg Roedel wrote:

> > How does that 'dGPU goes to sleep' work? Do you put it to sleep manually
> > via sysfs or something? Or is that something that amdgpu does on its
> > own?
> 
> AMD folks should be able to provide more details. afaik, the driver
> uses ACPI methods to power on/off the device. Driver routines wake the
> device up before accessing it and there is a timeout to turn it off
> after few seconds of inactivity.
> 
> > 
> > It looks like the GPU just switches the ATS unit off when it goes to
> > sleep and doesn't answer the invalidation anymore, which explains the
> > completion-wait timeouts.
> 
> Both MMIO regs and PCIe config regs are turned off so it would not
> surprise me if all PCIe requests were ignored by the device in off
> state. it should be possible to request device wake up before
> invalidating the relevant IOMMU domain. I'll leave to more
> knowledgeable ppl to judge whether it's a good idea (we can also
> postpone such invalidations until the device is woken by other means)

Can you maybe sched some light on how the sleep-mode of the GPUs work?
Is it initiated by the GPU driver or from somewhere else? In the case
discussed here it looks like the ATS unit of the GPU is switched of,
causing IOTLB invalidation timeouts on the IOMMU side.

If that is the case we might need some sort of dma-api extension so that
the GPU driver can tell the iommu driver that the device is going to be
quiet.


Thanks,

       Joerg
