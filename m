Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB70C433F5
	for <iommu@archiver.kernel.org>; Sat, 18 Dec 2021 05:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C158684E05;
	Sat, 18 Dec 2021 05:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K7WCY1XZwqlz; Sat, 18 Dec 2021 05:56:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9312584DFB;
	Sat, 18 Dec 2021 05:56:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7223BC002F;
	Sat, 18 Dec 2021 05:56:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8323C0012
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 05:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AFB30403CF
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 05:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yb6XVb_-QCSf for <iommu@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 05:56:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60A1740010
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 05:56:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="303266975"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; d="scan'208";a="303266975"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 21:56:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; d="scan'208";a="520056486"
Received: from weizhuoz-mobl.ccr.corp.intel.com (HELO [10.254.215.142])
 ([10.254.215.142])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 21:56:11 -0800
Message-ID: <73bdc4a3-6028-2ab5-f9a6-dbad15effad4@linux.intel.com>
Date: Sat, 18 Dec 2021 13:56:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] iommu/vt-d: Use bitmap_zalloc() when applicable
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org
References: <367914663187b8fe043e31b352cd6ad836088f0a.1639778255.git.christophe.jaillet@wanadoo.fr>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <367914663187b8fe043e31b352cd6ad836088f0a.1639778255.git.christophe.jaillet@wanadoo.fr>
Cc: iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

On 2021/12/18 5:58, Christophe JAILLET wrote:
> 'ommu->domain_ids' is a bitmap. So use 'bitmap_zalloc()' to simplify
> code and improve the semantic, instead of hand writing it.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/iommu/intel/iommu.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b6a8f3282411..4acc97765209 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1878,17 +1878,16 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
>   
>   static int iommu_init_domains(struct intel_iommu *iommu)
>   {
> -	u32 ndomains, nlongs;
> +	u32 ndomains;
>   	size_t size;
>   
>   	ndomains = cap_ndoms(iommu->cap);
>   	pr_debug("%s: Number of Domains supported <%d>\n",
>   		 iommu->name, ndomains);
> -	nlongs = BITS_TO_LONGS(ndomains);
>   
>   	spin_lock_init(&iommu->lock);
>   
> -	iommu->domain_ids = kcalloc(nlongs, sizeof(unsigned long), GFP_KERNEL);
> +	iommu->domain_ids = bitmap_zalloc(ndomains, GFP_KERNEL);
>   	if (!iommu->domain_ids)
>   		return -ENOMEM;
>   
> @@ -1903,7 +1902,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>   	if (!iommu->domains || !iommu->domains[0]) {
>   		pr_err("%s: Allocating domain array failed\n",
>   		       iommu->name);
> -		kfree(iommu->domain_ids);
> +		bitmap_free(iommu->domain_ids);
>   		kfree(iommu->domains);
>   		iommu->domain_ids = NULL;
>   		iommu->domains    = NULL;
> @@ -1964,7 +1963,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>   		for (i = 0; i < elems; i++)
>   			kfree(iommu->domains[i]);
>   		kfree(iommu->domains);
> -		kfree(iommu->domain_ids);
> +		bitmap_free(iommu->domain_ids);
>   		iommu->domains = NULL;
>   		iommu->domain_ids = NULL;
>   	}

This patch has been merged to Joerg's tree through

https://lore.kernel.org/linux-iommu/20211217083817.1745419-2-baolu.lu@linux.intel.com/

Are there any extra changes in this one?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
