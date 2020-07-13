Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1FFC433E6
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 20:22:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EFF2075D
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 20:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiFwI26T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EFF2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4311387DB7;
	Mon, 13 Jul 2020 20:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bjxVoddsCpK5; Mon, 13 Jul 2020 20:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 97B44870D2;
	Mon, 13 Jul 2020 20:22:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 808C3C088E;
	Mon, 13 Jul 2020 20:22:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6232C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 20:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B24388A091
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 20:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E6IPDcdIoN4Q for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 20:22:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 16BAA8A08E
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 20:22:43 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 628A52075B;
 Mon, 13 Jul 2020 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594671762;
 bh=tM1FG+INMniDO2N5XmTmfJsq0UrVrFhjB9hPE3JBaRI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oiFwI26TXEaKYwiXAkSUdtnF6xjknVkYaPt5FiaBfoFvuqmyN4pT7MpgNbZGtVlTf
 GNimjfAn28yXttkqcq6BhRH+mWq/kz5JNKQYSZyPpswpDRY2/1nb11twItEbbpn7dJ
 sKniyzq9REWXMHQ55HYbTFFb9Nb/cSJHS3EBb3k0=
Date: Mon, 13 Jul 2020 21:22:37 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v8 07/12] iommu/arm-smmu-v3: Share process page tables
Message-ID: <20200713202236.GA3575@willie-the-truck>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
 <20200618155125.1548969-8-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618155125.1548969-8-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: fenghua.yu@intel.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 catalin.marinas@arm.com, zhengxiang9@huawei.com, hch@infradead.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Thu, Jun 18, 2020 at 05:51:20PM +0200, Jean-Philippe Brucker wrote:
> With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
> MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
> into two sets, shared and private. Shared ASIDs correspond to those
> obtained from the arch ASID allocator, and private ASIDs are used for
> "classic" map/unmap DMA.
> 
> A possible conflict happens when trying to use a shared ASID that has
> already been allocated for private use by the SMMU driver. This will be
> addressed in a later patch by replacing the private ASID. At the
> moment we return -EBUSY.
> 
> Each mm_struct shared with the SMMU will have a single context
> descriptor. Add a refcount to keep track of this. It will be protected
> by the global SVA lock.
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 150 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 937aa1af428d5..cabd942e4cbf3 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -22,6 +22,7 @@
>  #include <linux/iommu.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> +#include <linux/mmu_context.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -33,6 +34,8 @@
>  
>  #include <linux/amba/bus.h>
>  
> +#include "io-pgtable-arm.h"
> +
>  /* MMIO registers */
>  #define ARM_SMMU_IDR0			0x0
>  #define IDR0_ST_LVL			GENMASK(28, 27)
> @@ -589,6 +592,9 @@ struct arm_smmu_ctx_desc {
>  	u64				ttbr;
>  	u64				tcr;
>  	u64				mair;
> +
> +	refcount_t			refs;
> +	struct mm_struct		*mm;
>  };
>  
>  struct arm_smmu_l1_ctx_desc {
> @@ -727,6 +733,7 @@ struct arm_smmu_option_prop {
>  };
>  
>  static DEFINE_XARRAY_ALLOC1(asid_xa);
> +static DEFINE_MUTEX(sva_lock);
>  
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
> @@ -1662,7 +1669,8 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
>  #ifdef __BIG_ENDIAN
>  			CTXDESC_CD_0_ENDI |
>  #endif
> -			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
> +			CTXDESC_CD_0_R | CTXDESC_CD_0_A |
> +			(cd->mm ? 0 : CTXDESC_CD_0_ASET) |
>  			CTXDESC_CD_0_AA64 |
>  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
>  			CTXDESC_CD_0_V;
> @@ -1766,12 +1774,144 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
>  	cdcfg->cdtab = NULL;
>  }
>  
> -static void arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
> +static void arm_smmu_init_cd(struct arm_smmu_ctx_desc *cd)
>  {
> +	refcount_set(&cd->refs, 1);
> +}
> +
> +static bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
> +{
> +	bool free;
> +	struct arm_smmu_ctx_desc *old_cd;
> +
>  	if (!cd->asid)
> -		return;
> +		return false;
> +
> +	free = refcount_dec_and_test(&cd->refs);
> +	if (free) {
> +		old_cd = xa_erase(&asid_xa, cd->asid);
> +		WARN_ON(old_cd != cd);
> +	}
> +	return free;
> +}
> +
> +static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
> +{
> +	struct arm_smmu_ctx_desc *cd;
>  
> -	xa_erase(&asid_xa, cd->asid);
> +	cd = xa_load(&asid_xa, asid);
> +	if (!cd)
> +		return NULL;
> +
> +	if (cd->mm) {
> +		/* All devices bound to this mm use the same cd struct. */
> +		refcount_inc(&cd->refs);
> +		return cd;
> +	}

How do you handle racing against a concurrent arm_smmu_free_asid() here?

> +__maybe_unused
> +static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
> +{
> +	u16 asid;
> +	int ret = 0;
> +	u64 tcr, par, reg;
> +	struct arm_smmu_ctx_desc *cd;
> +	struct arm_smmu_ctx_desc *old_cd = NULL;
> +
> +	lockdep_assert_held(&sva_lock);

Please don't bother with these for static functions (but I can see the
value in having them for functions with external callers).

> +
> +	asid = mm_context_get(mm);
> +	if (!asid)
> +		return ERR_PTR(-ESRCH);
> +
> +	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
> +	if (!cd) {
> +		ret = -ENOMEM;
> +		goto err_put_context;
> +	}
> +
> +	arm_smmu_init_cd(cd);
> +
> +	old_cd = arm_smmu_share_asid(asid);
> +	if (IS_ERR(old_cd)) {
> +		ret = PTR_ERR(old_cd);
> +		goto err_free_cd;
> +	} else if (old_cd) {

Don't need the 'else'

> +		if (WARN_ON(old_cd->mm != mm)) {
> +			ret = -EINVAL;
> +			goto err_free_cd;
> +		}
> +		kfree(cd);
> +		mm_context_put(mm);
> +		return old_cd;

This is a bit messy. Can you consolidate the return path so that ret is a
pointer and you have an 'int err', e.g.:

	return err < 0 ? ERR_PTR(err) : ret;

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
