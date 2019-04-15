Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EABC10F11
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 09:41:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F48206BA
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 09:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F48206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8DEFBEA5;
	Mon, 15 Apr 2019 09:41:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CAC06E9D
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 09:41:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 673F12C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 09:41:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D49380D;
	Mon, 15 Apr 2019 02:41:41 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2F0E3F557;
	Mon, 15 Apr 2019 02:41:39 -0700 (PDT)
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add SID information to context fault
	log
To: Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
	will.deacon@arm.com, iommu@lists.linux-foundation.org
References: <20190415080734.6843-1-vivek.gautam@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e5945adb-a1a3-1743-e671-39707276fad6@arm.com>
Date: Mon, 15 Apr 2019 10:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415080734.6843-1-vivek.gautam@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190415094138.viLNn5ebaCeD1Zg_IgAM0WICNsWJdebaj8JbUQm2oOI@z>

On 15/04/2019 09:07, Vivek Gautam wrote:
> Extract the SID and add the information to context fault log.
> This is specially useful in a distributed smmu architecture
> where multiple masters are connected to smmu. SID information
> helps to quickly identify the faulting master device.

Hmm, given how it's UNKNOWN for translation faults, which are arguably 
the most likely context fault, I reckon it probably makes more sense to 
just dump the raw register value for the user to interpret, as we do for 
fsr/fsynr.

Robin.

> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu-regs.h |  4 ++++
>   drivers/iommu/arm-smmu.c      | 14 ++++++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index a1226e4ab5f8..e5be0344b610 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -147,6 +147,10 @@ enum arm_smmu_s2cr_privcfg {
>   #define CBAR_IRPTNDX_SHIFT		24
>   #define CBAR_IRPTNDX_MASK		0xff
>   
> +#define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
> +#define CBFRSYNRA_V2_SID_MASK		0xffff
> +#define CBFRSYNRA_V1_SID_MASK		0x7fff
> +
>   #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
>   #define CBA2R_RW64_32BIT		(0 << 0)
>   #define CBA2R_RW64_64BIT		(1 << 0)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 045d93884164..aa3426dc68d0 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -575,7 +575,10 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
>   	void __iomem *cb_base;
> +	u32 cbfrsynra;
> +	u16 sid;
>   
>   	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
>   	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
> @@ -586,9 +589,16 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>   	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
>   	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
>   
> +	cbfrsynra = readl_relaxed(gr1_base +
> +				  ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
> +	if (smmu->version > ARM_SMMU_V1)
> +		sid = cbfrsynra & CBFRSYNRA_V2_SID_MASK;
> +	else
> +		sid = cbfrsynra & CBFRSYNRA_V1_SID_MASK;
> +
>   	dev_err_ratelimited(smmu->dev,
> -	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> -			    fsr, iova, fsynr, cfg->cbndx);
> +	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d sid = %u\n",
> +			    fsr, iova, fsynr, cfg->cbndx, sid);
>   
>   	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>   	return IRQ_HANDLED;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
