Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C90C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 14:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF7BF817E4;
	Wed,  4 May 2022 14:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c9qpLo6LNriQ; Wed,  4 May 2022 14:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AEDAE8174C;
	Wed,  4 May 2022 14:35:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76059C0039;
	Wed,  4 May 2022 14:35:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB9C9C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5EA840128
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:35:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AKmywCPqJOJm for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 14:35:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EDD3400D8
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651674917; x=1683210917;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VqEF+I2JhyCEa/bTGHue02o+KpB16bydfKDQLPVYL4c=;
 b=VG5TI/CVUMrW+CCxXyEboqx/TgmVbbByaJ3/cegUYmaxX512I+7DI0fT
 WUqkUVZXr0qi0pReM8Xfnfp9Ha2QTA5OaDkDzliKM3C476yi6K60CnhAE
 eWuJLXiwoXIL/tyjBEjw5ybaaebCdVmuSogVyWLmGCS0dyfAiEDUDRdFY
 uCdDL1blH0QVWoNjyyJ9bBw0UwqfY1uEduE0cVOZ8ArqEWWEWSAfPrsvi
 Afj6ikA858mCl+AiyC1QwJwqS3opCLPEadsJRKJXmSSGU1ExXZLo3H794
 6MBCLFmj1VLxOr8ToS35NPO+UNU3z0DqfVEz2olqGBtUgda0f+CcAQbts Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="249765062"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; d="scan'208";a="249765062"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 07:35:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; d="scan'208";a="734422577"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223])
 ([10.255.30.223])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 07:35:14 -0700
Message-ID: <8449a6fd-32f1-7cd3-6a4f-31f71df606a1@linux.intel.com>
Date: Wed, 4 May 2022 22:35:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign a
 domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux-foundation.org,
 Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>
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

Hi Jason,

On 2022/5/4 08:11, Jason Gunthorpe wrote:
> Once the group enters 'owned' mode it can never be assigned back to the
> default_domain or to a NULL domain. It must always be actively assigned to
> a current domain. If the caller hasn't provided a domain then the core
> must provide an explicit DMA blocking domain that has no DMA map.
> 
> Lazily create a group-global blocking DMA domain when
> iommu_group_claim_dma_owner is first called and immediately assign the
> group to it. This ensures that DMA is immediately fully isolated on all
> IOMMU drivers.
> 
> If the user attaches/detaches while owned then detach will set the group
> back to the blocking domain.
> 
> Slightly reorganize the call chains so that
> __iommu_group_attach_core_domain() is the function that removes any caller
> configured domain and sets the domains back a core owned domain with an
> appropriate lifetime.
> 
> __iommu_group_attach_domain() is the worker function that can change the
> domain assigned to a group to any target domain, including NULL.
> 
> Add comments clarifying how the NULL vs detach_dev vs default_domain works
> based on Robin's remarks.
> 
> This fixes an oops with VFIO and SMMUv3 because VFIO will call
> iommu_detach_group() and then immediately iommu_domain_free(), but
> SMMUv3 has no way to know that the domain it is holding a pointer to
> has been freed. Now the iommu_detach_group() will assign the blocking
> domain and SMMUv3 will no longer hold a stale domain reference.
> 
> Fixes: 1ea2a07a532b ("iommu: Add DMA ownership management interfaces")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 112 +++++++++++++++++++++++++++++++-----------
>   1 file changed, 82 insertions(+), 30 deletions(-)
> 
> This is based on Robins draft here:
> 
> https://lore.kernel.org/linux-iommu/18831161-473f-e04f-4a81-1c7062ad192d@arm.com/
> 
> With some rework. I re-organized the call chains instead of introducing
> iommu_group_user_attached(), fixed a recursive locking for
> iommu_group_get_purgatory(), and made a proper commit message.
> 
> Still only compile tested, so RFCish.
> 
> Nicolin/Lu? What do you think, can you check it?

Thank you for the patch.

With below additional changes, this patch works on my Intel test
machine.

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 513da82f2ed1..7c415e9b6906 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2063,7 +2063,8 @@ static int __iommu_attach_group(struct 
iommu_domain *domain,
  {
         int ret;

-       if (group->domain && group->domain != group->default_domain)
+       if (group->domain && group->domain != group->default_domain &&
+           group->domain != group->blocking_domain)
                 return -EBUSY;

         ret = __iommu_group_for_each_dev(group, domain,
@@ -2125,7 +2126,7 @@ static int __iommu_group_attach_domain(struct 
iommu_group *group,
          * Note that this is called in error unwind paths, attaching to a
          * domain that has already been attached cannot fail.
          */
-       ret = __iommu_group_for_each_dev(group, group->default_domain,
+       ret = __iommu_group_for_each_dev(group, new_domain,
                                          iommu_group_do_attach_device);
         if (ret)
                 return ret;
@@ -3180,7 +3181,9 @@ int iommu_group_claim_dma_owner(struct iommu_group 
*group, void *owner)
                 ret = -EPERM;
                 goto unlock_out;
         } else {
-               if (group->domain && group->domain != 
group->default_domain) {
+               if (group->domain &&
+                   group->domain != group->default_domain &&
+                   group->domain != group->blocking_domain) {
                         ret = -EBUSY;
                         goto unlock_out;

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
