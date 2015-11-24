From: "Prem (Premachandra) Mallappa" <prem.mallappa@broadcom.com>
Subject: RE: [PATCH] IOMMU: arm-smmu-v3: Use STE.S1STALLD only when supported
Date: Tue, 24 Nov 2015 05:30:37 +0000
Message-ID: <CC0BC9CB4553B146B290EC1D4DC5C359010924D5@SJEXCHMB15.corp.ad.broadcom.com>
References: <1447663700-13309-1-git-send-email-pmallapp@broadcom.com>
 <20151117174636.GO30101@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151117174636.GO30101@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Jayachandran Chandrashekaran Nair <jchandra@broadcom.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: 17 November 2015 11:17 PM
> To: Prem (Premachandra) Mallappa
> Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> Jayachandran Chandrashekaran Nair
> Subject: Re: [PATCH] IOMMU: arm-smmu-v3: Use STE.S1STALLD only when
> supported
> 
> Hi Prem,
> 
> Thanks for the patch. Just a few minor comments...
> 
> On Mon, Nov 16, 2015 at 02:18:20PM +0530, pmallapp@broadcom.com
> wrote:
> > From: Prem Mallappa <pmallapp@broadcom.com>
> >
> > Also fix the STALLD check.
> 
> Can you extend the commit message please to explain that it is ILLEGAL to
> set STE.S1STALLD to 1 if stage 1 is enabled and either the stall or terminate
> models are not supported?
> 
> > Signed-off-by: Prem Mallappa <pmallapp@broadcom.com>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> v3.c
> > index ed409cb..804671c 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -38,7 +38,9 @@
> >  #define IDR0_ST_LVL_SHIFT		27
> >  #define IDR0_ST_LVL_MASK		0x3
> >  #define IDR0_ST_LVL_2LVL		(1 << IDR0_ST_LVL_SHIFT)
> > -#define IDR0_STALL_MODEL		(3 << 24)
> > +#define IDR0_STALL_SHIFT		24
> 
> To keep the style consistent, can you also add IDR0_STALL_MASK please...
> 
> > +#define IDR0_STALL_MODEL_STALL		0x0
> > +#define IDR0_STALL_MODEL_FORCE		0x2
> 
> ... and shift these guys left by IDR0_STALL_SHIFT?
> 
> >
> >  #define IDR0_TTENDIAN_SHIFT		21
> >  #define IDR0_TTENDIAN_MASK		0x3
> >  #define IDR0_TTENDIAN_LE		(2 << IDR0_TTENDIAN_SHIFT)
> > @@ -1051,12 +1053,14 @@ static void arm_smmu_write_strtab_ent(struct
> arm_smmu_device *smmu, u32 sid,
> >  			 STRTAB_STE_1_S1C_CACHE_WBRA
> >  			 << STRTAB_STE_1_S1COR_SHIFT |
> >  			 STRTAB_STE_1_S1C_SH_ISH <<
> STRTAB_STE_1_S1CSH_SHIFT |
> > -			 STRTAB_STE_1_S1STALLD |
> >  #ifdef CONFIG_PCI_ATS
> >  			 STRTAB_STE_1_EATS_TRANS <<
> STRTAB_STE_1_EATS_SHIFT |  #endif
> >  			 STRTAB_STE_1_STRW_NSEL1 <<
> STRTAB_STE_1_STRW_SHIFT);
> >
> > +		if (smmu->features & ARM_SMMU_FEAT_STALLS)
> > +			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
> > +
> >  		val |= (ste->s1_cfg->cdptr_dma &
> STRTAB_STE_0_S1CTXPTR_MASK
> >  		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
> >  			STRTAB_STE_0_CFG_S1_TRANS;
> > @@ -2483,8 +2487,14 @@ static int arm_smmu_device_probe(struct
> arm_smmu_device *smmu)
> >  		dev_warn(smmu->dev, "IDR0.COHACC overridden by dma-
> coherent property (%s)\n",
> >  			 coherent ? "true" : "false");
> >
> > -	if (reg & IDR0_STALL_MODEL)
> > +	switch ((reg >> IDR0_STALL_SHIFT) & 0x3) {
> 
> Then structure this more like the TTENDIAN code:
> 
>   switch (reg & IDR0_STALL_MASK << IDR0_STALL_SHIFT) {
> 
> > +	case IDR0_STALL_MODEL_STALL:
> > +	case IDR0_STALL_MODEL_FORCE:
> >  		smmu->features |= ARM_SMMU_FEAT_STALLS;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> 
> I think you can drop the default case, or does GCC complain?
> 
> Will


Thanks for comments, I was on holiday, I'll send updated patch along with 2 more soon.

/Prem
