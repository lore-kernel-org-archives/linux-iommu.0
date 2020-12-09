Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D043C433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 08:59:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A51623A79
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 08:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A51623A79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E08FD8545B;
	Wed,  9 Dec 2020 08:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ar8cMxd1krlM; Wed,  9 Dec 2020 08:59:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6CBFC85081;
	Wed,  9 Dec 2020 08:59:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 466CEC0FA7;
	Wed,  9 Dec 2020 08:59:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE05CC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 08:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BCA93869F4
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 08:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Ak3aULzvPKG for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:59:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4A21B84FF9
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 08:59:09 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CrWDT6szNz15YnX;
 Wed,  9 Dec 2020 16:58:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Dec 2020
 16:58:56 +0800
Subject: Re: [RESEND PATCH v3 1/4] iommu/iova: Add free_all_cpu_cached_iovas()
To: John Garry <john.garry@huawei.com>, <robin.murphy@arm.com>,
 <joro@8bytes.org>, <will@kernel.org>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <1605608734-84416-2-git-send-email-john.garry@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0ae7688c-10b7-aa6b-c398-ac0917f7ae71@huawei.com>
Date: Wed, 9 Dec 2020 16:58:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1605608734-84416-2-git-send-email-john.garry@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Cc: xiyou.wangcong@gmail.com, iommu@lists.linux-foundation.org,
 linuxarm@huawei.com, linux-kernel@vger.kernel.org
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

On 2020/11/17 18:25, John Garry wrote:
> Add a helper function to free the CPU rcache for all online CPUs.
> 
> There also exists a function of the same name in
> drivers/iommu/intel/iommu.c, but the parameters are different, and there
> should be no conflict.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/iova.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 30d969a4c5fd..81b7399dd5e8 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -227,6 +227,14 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	return -ENOMEM;
>  }
>  
> +static void free_all_cpu_cached_iovas(struct iova_domain *iovad)
> +{
> +	unsigned int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		free_cpu_cached_iovas(cpu, iovad);
> +}
> +
>  static struct kmem_cache *iova_cache;
>  static unsigned int iova_cache_users;
>  static DEFINE_MUTEX(iova_cache_mutex);
> @@ -422,15 +430,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>  retry:
>  	new_iova = alloc_iova(iovad, size, limit_pfn, true);
>  	if (!new_iova) {
> -		unsigned int cpu;
> -
>  		if (!flush_rcache)
>  			return 0;
>  
>  		/* Try replenishing IOVAs by flushing rcache. */
>  		flush_rcache = false;
> -		for_each_online_cpu(cpu)
> -			free_cpu_cached_iovas(cpu, iovad);
> +		free_all_cpu_cached_iovas(iovad);
>  		goto retry;
>  	}
>  

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
