Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01157C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 07:35:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FC7613D1
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 07:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99FC7613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61AFD8272C;
	Wed, 29 Sep 2021 07:35:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u12rMhVLykWH; Wed, 29 Sep 2021 07:35:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 25C3F80DC1;
	Wed, 29 Sep 2021 07:35:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D558AC0011;
	Wed, 29 Sep 2021 07:35:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D027C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86AB9414B9
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:34:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SMWVc42GfHU2 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 07:34:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5B404148C
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:34:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="285896100"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="285896100"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 00:34:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="563039522"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.53])
 ([10.254.210.53])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 00:34:53 -0700
Subject: Re: [PATCH 1/8] iommu/vt-d: Clean up unused PASID updating functions
To: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, Tony Luck <tony.luck@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>, Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-2-fenghua.yu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2f2ab378-9967-ff84-18f1-c48ddeb0ceb6@linux.intel.com>
Date: Wed, 29 Sep 2021 15:34:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210920192349.2602141-2-fenghua.yu@intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Fenghua,

On 2021/9/21 3:23, Fenghua Yu wrote:
> update_pasid() and its call chain are currently unused in the tree because
> Thomas disabled the ENQCMD feature. The feature will be re-enabled shortly
> using a different approach and update_pasid() and its call chain will not
> be used in the new approach.
> 
> Remove the useless functions.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Thanks for this cleanup. I have queued it for v5.16.

Best regards,
baolu

> ---
>   arch/x86/include/asm/fpu/api.h |  2 --
>   drivers/iommu/intel/svm.c      | 24 +-----------------------
>   2 files changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index 23bef08a8388..ca4d0dee1ecd 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -106,6 +106,4 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
>    */
>   #define PASID_DISABLED	0
>   
> -static inline void update_pasid(void) { }
> -
>   #endif /* _ASM_X86_FPU_API_H */
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 0c228787704f..5b5d69b04fcc 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -505,21 +505,6 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
>   	return ret;
>   }
>   
> -static void _load_pasid(void *unused)
> -{
> -	update_pasid();
> -}
> -
> -static void load_pasid(struct mm_struct *mm, u32 pasid)
> -{
> -	mutex_lock(&mm->context.lock);
> -
> -	/* Update PASID MSR on all CPUs running the mm's tasks. */
> -	on_each_cpu_mask(mm_cpumask(mm), _load_pasid, NULL, true);
> -
> -	mutex_unlock(&mm->context.lock);
> -}
> -
>   static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
>   				 unsigned int flags)
>   {
> @@ -614,10 +599,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>   	if (ret)
>   		goto free_sdev;
>   
> -	/* The newly allocated pasid is loaded to the mm. */
> -	if (!(flags & SVM_FLAG_SUPERVISOR_MODE) && list_empty(&svm->devs))
> -		load_pasid(mm, svm->pasid);
> -
>   	list_add_rcu(&sdev->list, &svm->devs);
>   success:
>   	return &sdev->sva;
> @@ -670,11 +651,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
>   			kfree_rcu(sdev, rcu);
>   
>   			if (list_empty(&svm->devs)) {
> -				if (svm->notifier.ops) {
> +				if (svm->notifier.ops)
>   					mmu_notifier_unregister(&svm->notifier, mm);
> -					/* Clear mm's pasid. */
> -					load_pasid(mm, PASID_DISABLED);
> -				}
>   				pasid_private_remove(svm->pasid);
>   				/* We mandate that no page faults may be outstanding
>   				 * for the PASID when intel_svm_unbind_mm() is called.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
