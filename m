From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC][PATCH 2/2] Add support of the IOMMU_DEVICE flag.
Date: Mon, 6 Oct 2014 11:34:43 +0000
Message-ID: <dfcc738d7a7c4121b76789f6998e5394@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1412591296-31934-1-git-send-email-Varun.Sethi@freescale.com>
	<1412591296-31934-2-git-send-email-Varun.Sethi@freescale.com>
	<20141006111716.GF12935@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141006111716.GF12935-5wv7dgnIgG8@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: Monday, October 06, 2014 4:47 PM
> To: Sethi Varun-B16395
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: Re: [RFC][PATCH 2/2] Add support of the IOMMU_DEVICE flag.
> 
> On Mon, Oct 06, 2014 at 11:28:16AM +0100, Varun Sethi wrote:
> > This flag is used for specifying access to device memory. SMMU would
> > apply device memory attributes for a DMA transaction. This is required
> > for setting access to GIC registers, for generating message
> > interrupts. This would ensure that transactions targetting device memory are
> not gathered or reordered.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> > ca18d6d..f8338d6 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1263,6 +1263,10 @@ static int arm_smmu_alloc_init_pte(struct
> arm_smmu_device *smmu, pmd_t *pmd,
> >  		if (prot & IOMMU_CACHE)
> >  			pteval |= (MAIR_ATTR_IDX_CACHE <<
> >  				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
> > +
> > +		if (prot & IOMMU_DEVICE)
> > +			pteval |= (MAIR_ATTR_IDX_DEV <<
> > +				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
> 
> This is slightly odd, as I could in theory pass IOMMU_CACHE | IOMMU_DEVICE
> to iommu_map.
Agreed, this should only be relevant for the non-cacheable case.

-Varun
