From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 0/6] vSMMU initialization
Date: Tue, 14 Jul 2015 12:04:16 +0100
Message-ID: <20150714110416.GD16213@arm.com>
References: <1434118810-28219-1-git-send-email-b.reynal@virtualopensystems.com>
	<20150612142328.GF12174@arm.com>
	<BN1PR0301MB06274ACB3A193799F40BE9F4EA9B0@BN1PR0301MB0627.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BN1PR0301MB06274ACB3A193799F40BE9F4EA9B0-RQSpjbwlmjSD1ymB6+i1+JwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 14, 2015 at 03:21:03AM +0100, Varun Sethi wrote:
> Hi Will,

Hi Varun,

> > On Fri, Jun 12, 2015 at 03:20:04PM +0100, Baptiste Reynal wrote:
> > > The ARM SMMU has support for 2-stages address translations, allowing a
> > > virtual address to be translated at two levels:
> > > - Stage 1 translates a virtual address (VA) into an intermediate
> > > physical address (IPA)
> > > - Stage 2 translates an IPA into a physical address (PA)
> > >
> > > Will Deacon introduced a virtual SMMU interface for KVM, which gives a
> > > virtual machine the possibility to use an IOMMU with native drivers.
> > > While the VM will program the first stage of translation (stage 1),
> > > the interface will program the second (stage 2) on the physical SMMU.
> > 
> > Please note that I have no plans to merge the kernel-side of this at the
> > moment. It was merely an exploratory tool to see what a non-PV vSMMU
> > implementation might look like and certainly not intended to be used in
> > anger.
> How do you see the context fault reporting work for the PV interface?

We could have an interrupt, for the PV IOMMU and have the hypervisor
inject that, no?

> Currently the vSMMU interface does seem quiet restrictive and it may
> simplify things by having PV iommu interface. But, do you see this even
> true in case of SMMUv3?

I think SMMUv3 is *far* more amenable to the vSMMU approach, largely
because it moves many of the data structures into memory, but also because
it has support for things like ATS and PRI, so sharing page tables with
the CPU becomes a real possibility (and is something that doesn't work
well with a PV model).

> Just wondering if we can give more control with respect memory transaction
> attributes to the guest. Also, would it make sense to give guest control
> of the fault handling attributes i.e. fault/terminate model.

I'd like to see the basics prototyped before we start trying to design
for these more advanced use-cases. I'm confident there are plenty of things
we haven't even considered at the moment.

Will
