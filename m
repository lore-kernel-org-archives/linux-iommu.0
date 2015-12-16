From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] IOMMU: arm-smmu-v3: fix broken S2PS and AARCH64 in
	Broadcom Vulcan
Date: Wed, 16 Dec 2015 10:17:35 +0000
Message-ID: <20151216101735.GB4308@arm.com>
References: <1450110687-32207-1-git-send-email-pmallapp@broadcom.com>
	<20151215134010.GH9452@arm.com>
	<CC0BC9CB4553B146B290EC1D4DC5C35901094BCE@SJEXCHMB15.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CC0BC9CB4553B146B290EC1D4DC5C35901094BCE-HXj2mutaA2rOzKo2G4nwXJr/X4hKkxxPpWgKQ6/u3Fg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Prem (Premachandra) Mallappa" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jayachandran Chandrashekaran Nair <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 16, 2015 at 04:37:07AM +0000, Prem (Premachandra) Mallappa wrote:
> > On Mon, Dec 14, 2015 at 10:01:27PM +0530, Prem Mallappa wrote:
> > > Vulcan SMMUv3 looks for AARCH64 and S2PS inroder to validate the STE
> > > entry,
> > 
> > 'inroder' ?
> >
> In order

Got it!

> > > which is a overkill, but when proper encoding not found; the SMMU
> > > stops processing PCIe read/write requests. Giving the h/w what it wants.
> > >
> > > Signed-off-by: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > > ---
> > >  drivers/iommu/arm-smmu-v3.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> > v3.c
> > > index d4af50d..dfda564 100644
> > > --- a/drivers/iommu/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > @@ -260,6 +260,7 @@
> > >  #define STRTAB_STE_2_S2VMID_MASK	0xffffUL
> > >  #define STRTAB_STE_2_VTCR_SHIFT		32
> > >  #define STRTAB_STE_2_VTCR_MASK		0x7ffffUL
> > > +#define STRTAB_STE_2_S2PS_SHIFT        48
> > >  #define STRTAB_STE_2_S2AA64		(1UL << 51)
> > >  #define STRTAB_STE_2_S2ENDI		(1UL << 52)
> > >  #define STRTAB_STE_2_S2PTW		(1UL << 54)
> > > @@ -577,6 +578,7 @@ struct arm_smmu_device {
> > >  	u32				features;
> > >
> > >  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> > > +#define ARM_SMMU_OPT_BROKEN_STE_VALID	(1 << 1)
> > >  	u32				options;
> > >
> > >  	struct arm_smmu_cmdq		cmdq;
> > > @@ -641,6 +643,7 @@ struct arm_smmu_option_prop {
> > >
> > >  static struct arm_smmu_option_prop arm_smmu_options[] = {
> > >  	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-
> > cmd" },
> > > +	{ ARM_SMMU_OPT_BROKEN_STE_VALID, "broadcom,broken-ste-
> > valid-check"
> > > +},
> > 
> > This looks like a more specific problem than "broken ste valid check".
> > Maybe we could call the prop
> > ARM_SMMU_OPT_BCOM_BROKEN_STE_VALID?
> > 
> > You also need to update the devicetree binding in
> > Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt.
> > 
> Sure I'll send out v2.
> 
> > >  	{ 0, NULL},
> > >  };
> > >
> > > @@ -1046,6 +1049,15 @@ static void arm_smmu_write_strtab_ent(struct
> > arm_smmu_device *smmu, u32 sid,
> > >  				      : STRTAB_STE_0_CFG_BYPASS;
> > >  		dst[0] = cpu_to_le64(val);
> > >  		dst[2] = 0; /* Nuke the VMID */
> > > +
> > > +		if (smmu && (smmu->options &
> > ARM_SMMU_OPT_BROKEN_STE_VALID)) {
> > > +#define SMMU_STE_OAS_44_BITS 0x4UL
> > 
> > Please don't add a #define here. Can we instead use the oas field that we've
> > extracted from IDR5? I think we need to be doing that anyway when we're
> > using stage-2 translation, looking at the spec...
> > 
> As you mentioned in other email, "OAS" is already taken care by io-pgtable
> vtcr.

Ok -- so what is the value reported by your IDR5?

> > > +			WARN_ON(smmu->oas != 44);
> > > +			dst[1] = STRTAB_STE_1_EATS_TRANS <<
> > STRTAB_STE_1_EATS_SHIFT;
> > 
> > Why are you enabling ATS?
> > 
> Again, based on feedback from h/w team which expects these fields
> populated (hence broken :) ), 

Ok, I just didn't see any mention of that in the commit message and
wanted to make sure it wasn't an accidental unrelated change.

Will
