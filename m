Return-Path: <SRS0=rc6t=FM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A71C433FE
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 14:20:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D0823A5B
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 14:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D0823A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4167F86D05;
	Tue,  8 Dec 2020 14:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aUrYy6y70ZGr; Tue,  8 Dec 2020 14:20:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D8D486CED;
	Tue,  8 Dec 2020 14:20:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CA33C0893;
	Tue,  8 Dec 2020 14:20:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 283E3C013B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 14:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 14C3B86CED
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 14:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4imUGBZutT6W for <iommu@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 14:20:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id ED27586CC7
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 14:20:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4401930E;
 Tue,  8 Dec 2020 06:20:31 -0800 (PST)
Received: from [10.57.61.6] (unknown [10.57.61.6])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D72C23F718;
 Tue,  8 Dec 2020 06:20:27 -0800 (PST)
Subject: Re: [PATCH v2] iommu: Defer the early return in arm_(v7s/lpae)_map
To: Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
References: <20201207115758.9400-1-zhukeqian1@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ebf1f2cc-b6bf-90b2-8a1c-535fc242d6da@arm.com>
Date: Tue, 8 Dec 2020 14:20:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207115758.9400-1-zhukeqian1@huawei.com>
Content-Language: en-GB
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>,
 jiangkunkun@huawei.com, Sean Christopherson <sean.j.christopherson@intel.com>,
 Alexios Zavras <alexios.zavras@intel.com>, Mark Brown <broonie@kernel.org>,
 James Morse <james.morse@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 wanghaibin.wang@huawei.com, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-12-07 11:57, Keqian Zhu wrote:
> Although handling a mapping request with no permissions is a
> trivial no-op, defer the early return until after the size/range
> checks so that we are consistent with other mapping requests.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 8 ++++----
>   drivers/iommu/io-pgtable-arm.c     | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index a688f22cbe3b..359b96b0fa3e 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -522,14 +522,14 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
>   	struct io_pgtable *iop = &data->iop;
>   	int ret;
>   
> -	/* If no access, then nothing to do */
> -	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> -		return 0;
> -
>   	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
>   		    paddr >= (1ULL << data->iop.cfg.oas)))
>   		return -ERANGE;
>   
> +	/* If no access, then nothing to do */
> +	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> +		return 0;
> +
>   	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd, gfp);
>   	/*
>   	 * Synchronise all PTE updates for the new mapping before there's
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index a7a9bc08dcd1..8ade72adab31 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -444,10 +444,6 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>   	arm_lpae_iopte prot;
>   	long iaext = (s64)iova >> cfg->ias;
>   
> -	/* If no access, then nothing to do */
> -	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> -		return 0;
> -
>   	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
>   		return -EINVAL;
>   
> @@ -456,6 +452,10 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>   	if (WARN_ON(iaext || paddr >> cfg->oas))
>   		return -ERANGE;
>   
> +	/* If no access, then nothing to do */
> +	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> +		return 0;
> +
>   	prot = arm_lpae_prot_to_pte(data, iommu_prot);
>   	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
>   	/*
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
