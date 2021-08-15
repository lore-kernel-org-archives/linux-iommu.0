Return-Path: <SRS0=nnIB=NG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF4FC4338F
	for <iommu@archiver.kernel.org>; Sun, 15 Aug 2021 05:00:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803B361040
	for <iommu@archiver.kernel.org>; Sun, 15 Aug 2021 05:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 803B361040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D0AF80D43;
	Sun, 15 Aug 2021 05:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jdkwV4Ssyy6O; Sun, 15 Aug 2021 05:00:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 19A8180D3F;
	Sun, 15 Aug 2021 05:00:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCF73C0010;
	Sun, 15 Aug 2021 05:00:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9531C000E
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 05:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C471280D43
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 05:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dPbUxR0e-aJI for <iommu@lists.linux-foundation.org>;
 Sun, 15 Aug 2021 05:00:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E2CE80D3F
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 05:00:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10076"; a="276746561"
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; d="scan'208";a="276746561"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2021 22:00:17 -0700
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; d="scan'208";a="518804598"
Received: from jifangxi-mobl2.ccr.corp.intel.com (HELO [10.254.214.216])
 ([10.254.214.216])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2021 22:00:15 -0700
Subject: Re: [PATCH] iommu/vt-d: Fix PASID reference leak
To: Fenghua Yu <fenghua.yu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>, Ashok Raj <ashok.raj@intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Jacob Jun Pan
 <jacob.jun.pan@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20210813181345.1870742-1-fenghua.yu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <51d97b07-5d72-771b-f437-c04e2596c4b0@linux.intel.com>
Date: Sun, 15 Aug 2021 13:00:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813181345.1870742-1-fenghua.yu@intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

On 2021/8/14 2:13, Fenghua Yu wrote:
> A PASID reference is increased whenever a device is bound to an mm (and
> its PASID) successfully (i.e. the device's sdev user count is increased).
> But the reference is not dropped every time the device is unbound
> successfully from the mm (i.e. the device's sdev user count is decreased).
> The reference is dropped only once by calling intel_svm_free_pasid() when
> there isn't any device bound to the mm. intel_svm_free_pasid() drops the
> reference and only frees the PASID on zero reference.
> 
> Fix the issue by dropping the PASID reference and freeing the PASID when
> no reference on successful unbinding the device by calling
> intel_svm_free_pasid() .
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Nice catch! Thanks!

Fixes: 4048377414162 ("iommu/vt-d: Use iommu_sva_alloc(free)_pasid() 
helpers")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/svm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 9b0f22bc0514..4b9b3f35ba0e 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -675,7 +675,6 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
>   			kfree_rcu(sdev, rcu);
>   
>   			if (list_empty(&svm->devs)) {
> -				intel_svm_free_pasid(mm);
>   				if (svm->notifier.ops) {
>   					mmu_notifier_unregister(&svm->notifier, mm);
>   					/* Clear mm's pasid. */
> @@ -690,6 +689,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
>   				kfree(svm);
>   			}
>   		}
> +		/* Drop a PASID reference and free it if no reference. */
> +		intel_svm_free_pasid(mm);
>   	}
>   out:
>   	return ret;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
