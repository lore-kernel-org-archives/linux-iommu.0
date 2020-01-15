Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2D3C33CB1
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 14:02:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A370222C3
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 14:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="htoTppDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A370222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6912085F51;
	Wed, 15 Jan 2020 14:02:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OEt-SfTbGJ-i; Wed, 15 Jan 2020 14:02:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8A6BF85F49;
	Wed, 15 Jan 2020 14:02:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52AC0C1D83;
	Wed, 15 Jan 2020 14:02:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C146BC077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 14:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A88122050B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 14:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mwtfHtiUiuwo for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 14:02:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 5E0BE20517
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 14:02:34 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0B2AC222C3
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579096954;
 bh=IaBwdiDgwCIx5BuPQB2+IqtMn+SaycRtfHqCIpsVFb0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=htoTppDa67SpEBkWpOJkMNyOkvAIkppVDquQhnGk5qkzQDBEhzQannWa5D9eguHhH
 1a5n8eJPWHJ7A7dYL8H2DZ31QHZk4bziE7YPDk0gfmU1gr4l/xHd6sS47Kd4RD75p7
 sr/dwsN4i7Dc58ySFewX2+wJSdcYrXmETW1h8m3U=
Received: by mail-qv1-f48.google.com with SMTP id l14so7366475qvu.12
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 06:02:33 -0800 (PST)
X-Gm-Message-State: APjAAAW59dHJexOLtQsSfqMz5Qn1+mtsntthZXdCJ7brL/5wdemUR39G
 13cFv7Y9X7QzGSPcdbT8rfIVYatDkNXPin81BA==
X-Google-Smtp-Source: APXvYqyTO5ScFKQX7y6OlWvH+iZhwV9J4A3B9PFR1YHjDWpvx4cGMN9sSfATF4v/fRml/9x75CiZVoWPo/lcDZgSL34=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr24687823qvu.136.1579096953208; 
 Wed, 15 Jan 2020 06:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20200113143924.11576-1-robh@kernel.org>
 <2ee87a12-1a0e-bd48-0209-b5e205342d44@redhat.com>
In-Reply-To: <2ee87a12-1a0e-bd48-0209-b5e205342d44@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 15 Jan 2020 08:02:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKrh0nLuoRgi1-bKyEErwCFpWPRPNVDuoeJrbFMCz60KQ@mail.gmail.com>
Message-ID: <CAL_JsqKrh0nLuoRgi1-bKyEErwCFpWPRPNVDuoeJrbFMCz60KQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support
To: Auger Eric <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jan 15, 2020 at 3:21 AM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Rob,
>
> On 1/13/20 3:39 PM, Rob Herring wrote:
> > Arm SMMUv3.2 adds support for TLB range invalidate operations.
> > Support for range invalidate is determined by the RIL bit in the IDR3
> > register.
> >
> > The range invalidate is in units of the leaf page size and operates on
> > 1-32 chunks of a power of 2 multiple pages. First we determine from the
> > size what power of 2 multiple we can use and then adjust the granule to
> > 32x that size.
> >
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 53 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index e91b4a098215..8b6b3e2aa383 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -70,6 +70,9 @@
> >  #define IDR1_SSIDSIZE                        GENMASK(10, 6)
> >  #define IDR1_SIDSIZE                 GENMASK(5, 0)
> >
> > +#define ARM_SMMU_IDR3                        0xc
> > +#define IDR3_RIL                     (1 << 10)
> > +
> >  #define ARM_SMMU_IDR5                        0x14
> >  #define IDR5_STALL_MAX                       GENMASK(31, 16)
> >  #define IDR5_GRAN64K                 (1 << 6)
> > @@ -327,9 +330,14 @@
> >  #define CMDQ_CFGI_1_LEAF             (1UL << 0)
> >  #define CMDQ_CFGI_1_RANGE            GENMASK_ULL(4, 0)
> >
> > +#define CMDQ_TLBI_0_NUM                      GENMASK_ULL(16, 12)
> > +#define CMDQ_TLBI_RANGE_NUM_MAX              32
> > +#define CMDQ_TLBI_0_SCALE            GENMASK_ULL(24, 20)
> >  #define CMDQ_TLBI_0_VMID             GENMASK_ULL(47, 32)
> >  #define CMDQ_TLBI_0_ASID             GENMASK_ULL(63, 48)
> >  #define CMDQ_TLBI_1_LEAF             (1UL << 0)
> > +#define CMDQ_TLBI_1_TTL                      GENMASK_ULL(9, 8)
> > +#define CMDQ_TLBI_1_TG                       GENMASK_ULL(11, 10)
> >  #define CMDQ_TLBI_1_VA_MASK          GENMASK_ULL(63, 12)
> >  #define CMDQ_TLBI_1_IPA_MASK         GENMASK_ULL(51, 12)
> >
> > @@ -455,9 +463,13 @@ struct arm_smmu_cmdq_ent {
> >               #define CMDQ_OP_TLBI_S2_IPA     0x2a
> >               #define CMDQ_OP_TLBI_NSNH_ALL   0x30
> >               struct {
> > +                     u8                      num;
> > +                     u8                      scale;
> >                       u16                     asid;
> >                       u16                     vmid;
> >                       bool                    leaf;
> > +                     u8                      ttl;
> > +                     u8                      tg;
> >                       u64                     addr;
> >               } tlbi;
> >
> > @@ -595,6 +607,7 @@ struct arm_smmu_device {
> >  #define ARM_SMMU_FEAT_HYP            (1 << 12)
> >  #define ARM_SMMU_FEAT_STALL_FORCE    (1 << 13)
> >  #define ARM_SMMU_FEAT_VAX            (1 << 14)
> > +#define ARM_SMMU_FEAT_RANGE_INV              (1 << 15)
> >       u32                             features;
> >
> >  #define ARM_SMMU_OPT_SKIP_PREFETCH   (1 << 0)
> > @@ -856,13 +869,21 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> >               cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
> >               break;
> >       case CMDQ_OP_TLBI_NH_VA:
> > +             cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
> > +             cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
> >               cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
> >               cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
> > +             cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
> > +             cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
> >               cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
> >               break;
> >       case CMDQ_OP_TLBI_S2_IPA:
> > +             cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
> > +             cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
> >               cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
> >               cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
> > +             cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
> > +             cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
> >               cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_IPA_MASK;
> >               break;
> >       case CMDQ_OP_TLBI_NH_ASID:
> > @@ -2022,12 +2043,39 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> >               cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
> >       }
> >
> > +     if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> > +             unsigned long tg, scale;
> > +
> > +             /* Get the leaf page size */
> > +             tg = __ffs(smmu_domain->domain.pgsize_bitmap);
> it is unclear to me why you can't set tg with the granule parameter.

granule could be 2MB sections if THP is enabled, right?

> > +
> > +             /* Determine the power of 2 multiple number of pages */
> > +             scale = __ffs(size / (1UL << tg));
> > +             cmd.tlbi.scale = scale;
> > +
> > +             cmd.tlbi.num = CMDQ_TLBI_RANGE_NUM_MAX - 1;
> Also could you explain why you use CMDQ_TLBI_RANGE_NUM_MAX.

How's this:
/* The invalidation loop defaults to the maximum range */

And perhaps I'll move it next to setting granule.

> > +
> > +             /* Convert page size of 12,14,16 (log2) to 1,2,3 */
> > +             cmd.tlbi.tg = ((tg - ilog2(SZ_4K)) / 2) + 1;
> > +
> > +             /* Determine what level the granule is at */
> > +             cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
> > +
> > +             /* Adjust granule to the maximum range */
> > +             granule = CMDQ_TLBI_RANGE_NUM_MAX * (1 << scale) * (1UL << tg);
> spec says
> Range = ((NUM+1)*2 ^ SCALE )*Translation_Granule_Size

(NUM+1) can be 1-32. I went with the logical max for
CMDQ_TLBI_RANGE_NUM_MAX rather than the NUM field value max.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
