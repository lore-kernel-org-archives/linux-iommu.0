Return-Path: <SRS0=myD+=SV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43FDC282DA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 05:34:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909752087F
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 05:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n28YC/1X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n28YC/1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909752087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 503C81F25;
	Fri, 19 Apr 2019 05:34:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 336CA1EBC
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 05:34:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B986B108
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 05:34:14 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 740B1615BF; Fri, 19 Apr 2019 05:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1555652054;
	bh=ynX1XiN+F09ar8DitQQHvhoLDOwf4suTYCkS8lWqtOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n28YC/1XscTnbcd2PndXOSwiZ8LP7lf8E6TmR4IFeUuHDxvFs/cU07lt8T1iA24eT
	8HCE7/WCqq4dXGlK5q82Nc2BXJ8tRQs/+L8rZqpTULXtvAWz3EMGqg4x8VV52DR+d1
	d4S4JhSUjnm6fD2i2U94Z5Kx8Lj7HmYftndqihn0=
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
	[209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id AE9AE61576
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 05:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1555652054;
	bh=ynX1XiN+F09ar8DitQQHvhoLDOwf4suTYCkS8lWqtOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n28YC/1XscTnbcd2PndXOSwiZ8LP7lf8E6TmR4IFeUuHDxvFs/cU07lt8T1iA24eT
	8HCE7/WCqq4dXGlK5q82Nc2BXJ8tRQs/+L8rZqpTULXtvAWz3EMGqg4x8VV52DR+d1
	d4S4JhSUjnm6fD2i2U94Z5Kx8Lj7HmYftndqihn0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE9AE61576
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f50.google.com with SMTP id d1so3570259edd.13
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 22:34:13 -0700 (PDT)
X-Gm-Message-State: APjAAAXMl5A268XF22rCD0UhzEQ+18O4Dcj38ySnBNypleOhbSHLkVWG
	oeMHSyDmm0bWKtFhPhVN1aMXwRpHk+aDG0h7BTs=
X-Google-Smtp-Source: APXvYqxKBkj/cAGFLjJH0WBxF78ZtkgeIy6ptaKEC1snAwaCsNqTXmJNxY1CDdKIh3zm81v36mBP2LJKptmGM5OShm8=
X-Received: by 2002:a50:b51b:: with SMTP id y27mr1157250edd.251.1555652052483; 
	Thu, 18 Apr 2019 22:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <4cfc7b3b-bc74-6b37-19f5-40b6394fa762@codeaurora.org>
	<20190415173758.22112-1-vivek.gautam@codeaurora.org>
	<20190419002457.GA3137@builder>
In-Reply-To: <20190419002457.GA3137@builder>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Fri, 19 Apr 2019 11:04:01 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFSeOLh-RE2GM_Yah+ANmVUQZjuyH7zF9qOOSLxhGbdvw@mail.gmail.com>
Message-ID:
 <CAFp+6iFSeOLh-RE2GM_Yah+ANmVUQZjuyH7zF9qOOSLxhGbdvw@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Log CBFRSYNRA register on context
	fault
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190419053401.PRPHyi--LSMKk2pH_RoKgUSs1YN8vKgjRa-aaJsYztM@z>

On Fri, Apr 19, 2019 at 5:55 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 15 Apr 10:37 PDT 2019, Vivek Gautam wrote:
>
> > Bits[15:0] in CBFRSYNRA register contain information about
> > StreamID of the incoming transaction that generated the
> > fault. Dump CBFRSYNRA register to get this info.
> > This is specially useful in a distributed SMMU architecture
> > where multiple masters are connected to the SMMU.
> > SID information helps to quickly identify the faulting
> > master device.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > ---
> >
> > V1 of the patch available @
> > https://lore.kernel.org/patchwork/patch/1061615/
> >
> > Changes from v1:
> >  - Dump the raw register value of CBFRSYNRA register in the
> >    context fault log rather than extracting the SID inforamtion
> >    and dumping that.
> >
> >  drivers/iommu/arm-smmu-regs.h | 2 ++
> >  drivers/iommu/arm-smmu.c      | 8 ++++++--
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> > index a1226e4ab5f8..e9132a926761 100644
> > --- a/drivers/iommu/arm-smmu-regs.h
> > +++ b/drivers/iommu/arm-smmu-regs.h
> > @@ -147,6 +147,8 @@ enum arm_smmu_s2cr_privcfg {
> >  #define CBAR_IRPTNDX_SHIFT           24
> >  #define CBAR_IRPTNDX_MASK            0xff
> >
> > +#define ARM_SMMU_GR1_CBFRSYNRA(n)    (0x400 + ((n) << 2))
> > +
> >  #define ARM_SMMU_GR1_CBA2R(n)                (0x800 + ((n) << 2))
> >  #define CBA2R_RW64_32BIT             (0 << 0)
> >  #define CBA2R_RW64_64BIT             (1 << 0)
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 045d93884164..a4773e8c6b0e 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -575,7 +575,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> >       struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +     void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
> >       void __iomem *cb_base;
> > +     u32 cbfrsynra;
> >
> >       cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
> >       fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
> > @@ -585,10 +587,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >
> >       fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
> >       iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
> > +     cbfrsynra = readl_relaxed(gr1_base +
> > +                               ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
>
> The 80 char limit is more like a guideline anyways...please don't wrap
> this.
>
> >
> >       dev_err_ratelimited(smmu->dev,
> > -     "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> > -                         fsr, iova, fsynr, cfg->cbndx);
> > +     "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra = 0x%x, cb=%d\n",
>
> Drop the spaces around '='.
>
> With those addressed, you have my
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks for the review Bjorn. Will address above comments and respin.

Best regards
Vivek

>
> Regards,
> Bjorn
>
> > +                         fsr, iova, fsynr, cbfrsynra, cfg->cbndx);
> >
> >       writel(fsr, cb_base + ARM_SMMU_CB_FSR);
> >       return IRQ_HANDLED;
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
