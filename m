From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC 0/6] vSMMU initialization
Date: Wed, 15 Jul 2015 17:28:54 +0000
Message-ID: <BN1PR0301MB0627944BCFB295564CA1F7AAEA9A0@BN1PR0301MB0627.namprd03.prod.outlook.com>
References: <1434118810-28219-1-git-send-email-b.reynal@virtualopensystems.com>
	<20150612142328.GF12174@arm.com>
	<BN1PR0301MB06274ACB3A193799F40BE9F4EA9B0@BN1PR0301MB0627.namprd03.prod.outlook.com>
	<20150714110416.GD16213@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150714110416.GD16213-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: Tuesday, July 14, 2015 4:34 PM
> To: Sethi Varun-B16395
> Cc: Baptiste Reynal; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
> Subject: Re: [RFC 0/6] vSMMU initialization
> 
> On Tue, Jul 14, 2015 at 03:21:03AM +0100, Varun Sethi wrote:
> > Hi Will,
> 
> Hi Varun,
> 
> > > On Fri, Jun 12, 2015 at 03:20:04PM +0100, Baptiste Reynal wrote:
> > > > The ARM SMMU has support for 2-stages address translations,
> > > > allowing a virtual address to be translated at two levels:
> > > > - Stage 1 translates a virtual address (VA) into an intermediate
> > > > physical address (IPA)
> > > > - Stage 2 translates an IPA into a physical address (PA)
> > > >
> > > > Will Deacon introduced a virtual SMMU interface for KVM, which
> > > > gives a virtual machine the possibility to use an IOMMU with native
> drivers.
> > > > While the VM will program the first stage of translation (stage
> > > > 1), the interface will program the second (stage 2) on the physical
> SMMU.
> > >
> > > Please note that I have no plans to merge the kernel-side of this at
> > > the moment. It was merely an exploratory tool to see what a non-PV
> > > vSMMU implementation might look like and certainly not intended to
> > > be used in anger.
> > How do you see the context fault reporting work for the PV interface?
> 
> We could have an interrupt, for the PV IOMMU and have the hypervisor
> inject that, no?
> 
Can you please elaborate on the PV IOMMU interface. I want to understand how context fault information would be communicated to the guest.

-Varun
