Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93F74420
	for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644680; cv=none; b=NqTYQapi5kXKc/oPxa+niZO99hszy2d1yVYpp9Mo7yzhpIr1pNKzYeC23FRjt0zxPQR46ZidKUrETuRa9v6QoU2+xinlpVUoN0mt/3TYCzdR5fEmqIq8/lkEOYc+nwjGmsJvqSgmRdOb7t+Aa0603Avf5XfGyJiDCYM5DB84QSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644680; c=relaxed/simple;
	bh=s5wQXk3xcxlg5JVEy33+/yU0i4Bvd7nsTV60XP0MDAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2QgW+gGI3vt09A+ZLkd7+MtywIO+ltCt6R33za/VXH2exCXhsorQ+2VfEulV3XEyQyjKYeWizSOHHbqkaduOBx5Exrh1IF2KvhDe4t7gSSiD9iMSIRGNCReeoJQvv1JRuvBfwL44avIJr5TCFEpbcfUIXWNONkqlRx2JgJ3e/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSHbuZHW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSHbuZHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757644679; x=1789180679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s5wQXk3xcxlg5JVEy33+/yU0i4Bvd7nsTV60XP0MDAc=;
  b=fSHbuZHWZPTd0+ZHDmSxibOeRzIRPTBkkK5xX6vxFjb1DzKoqDdAFWZ7
   B3qI05pFbpnwRMZMEPvpr/wzdgy9RnY35FWKJke3ZiiTXB6UJvJDc1JQB
   jqV58cB7tEORmmjxdeOI9EjSIGc0CX2e06miwbfoc6YlVqFP90TMMSvIQ
   /3x1Yd7gGnrXksqGOMZ08DfOaIsMq/LetqeoZ3FkIDiR1ocRawK7uC9LW
   41w2CzBkPdeP3H6nU6PFdpXyRRZWxD0/yEihz8jxGZZ6io7QbUh/nOf2F
   Dt7HXb/tGpjpNjfnudV/VmZd+rLxDcA4ygyWAf+FX3EMCktUP/S+T6H2H
   w==;
X-CSE-ConnectionGUID: g6OaLavGSraETegkSjdJ0g==
X-CSE-MsgGUID: 0B5AXk3iQiKGAKfzAPeGlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="47557657"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="47557657"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 19:37:59 -0700
X-CSE-ConnectionGUID: YluQkVDsRYuJ476nqehz5Q==
X-CSE-MsgGUID: /x1QXRLqTCambOYh8RnIPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="211007182"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 19:37:54 -0700
Message-ID: <e82c300e-9d68-4270-a4ea-10bea20b1169@linux.intel.com>
Date: Fri, 12 Sep 2025 10:35:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel/vt-d: Send Page Request Drain only if supported
To: Joel Granados <joel.granados@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250909-jag-pds-v1-1-ad8cba0e494e@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250909-jag-pds-v1-1-ad8cba0e494e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 16:58, Joel Granados wrote:
> The intel_iommu_drain_pasid_prq function sends QI_OPT_WAIT_DRAIN to
> hardware without verifying Page Request Drain Support (PDS). According
> to VT-d specification section 6.5.2.8, PRQ drain functionality should
> only be used when PDS (bit 42) is set in the extended capability
> register. Add ecap_pds() check to conditionally use QI_OPT_WAIT_DRAIN
> based on hardware capability.
> 
> Signed-off-by: Joel Granados<joel.granados@kernel.org>
> ---
>   drivers/iommu/intel/prq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> index 52570e42a14c05b7492957909568805dc9c7b6ef..f89916de31a3439866f059f5400e45fb362a6a7d 100644
> --- a/drivers/iommu/intel/prq.c
> +++ b/drivers/iommu/intel/prq.c
> @@ -119,7 +119,7 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
>   	}
>   qi_retry:
>   	reinit_completion(&iommu->prq_complete);
> -	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
> +	qi_submit_sync(iommu, desc, 3, ecap_pds(iommu->ecap) ? QI_OPT_WAIT_DRAIN : 0);

I'm afraid that draining page requests and responses won't work as
expected without the PDS capability. We should perhaps fail to enable
IOPF if the PDS capability isn't supported.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9c3ab9d9f69a..ca6a6eaea62c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3983,6 +3983,10 @@ int intel_iommu_enable_iopf(struct device *dev)
         if (!info->pri_enabled)
                 return -ENODEV;

+       /* PDS is required to drain page requests and responses. */
+       if (!ecap_pds(iommu->ecap))
+               return -ENODEV;
+
         /* pri_enabled is protected by the group mutex. */
         iommu_group_mutex_assert(dev);
         if (info->iopf_refcount) {

At the same time, qi_submit_sync() should not set PD bit in the wait
descriptor as the spec Section 6.5.2.9 "Invalidation Wait Descriptor"
states:

  Page-request Drain (PD): Remapping hardware implementations reporting
  Page-request draining as not supported (PDS = 0 in ECAP_REG) treats
  this field as reserved.

therefore,

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ec975c73cfe6..e38af2274032 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1427,7 +1427,7 @@ int qi_submit_sync(struct intel_iommu *iommu, 
struct qi_desc *desc,

         wait_desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
                         QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
-       if (options & QI_OPT_WAIT_DRAIN)
+       if ((options & QI_OPT_WAIT_DRAIN) && 
!WARN_ON_ONCE(!ecap_pds(iommu->ecap)))
                 wait_desc.qw0 |= QI_IWD_PRQ_DRAIN;
         wait_desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
         wait_desc.qw2 = 0;

?

>   	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
>   		wait_for_completion(&iommu->prq_complete);
>   		goto qi_retry;

Thanks,
baolu
