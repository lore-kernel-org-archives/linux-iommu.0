Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1C9FC6194
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 03:09:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E567021882
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 03:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E567021882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B6BC8CA6;
	Fri,  8 Nov 2019 03:09:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9AA67C6F
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 03:09:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 241B5712
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 03:09:00 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Nov 2019 19:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,280,1569308400"; d="scan'208";a="228055533"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga004.fm.intel.com with ESMTP; 07 Nov 2019 19:08:58 -0800
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To: Deepa Dinamani <deepa.kernel@gmail.com>, joro@8bytes.org,
	linux-kernel@vger.kernel.org
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f3d7138b-b254-3c6d-b865-d3b6889aa896@linux.intel.com>
Date: Fri, 8 Nov 2019 11:06:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107205914.10611-1-deepa.kernel@gmail.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On 11/8/19 4:59 AM, Deepa Dinamani wrote:
> The intel-iommu driver assumes that the iommu state is
> cleaned up at the start of the new kernel.
> But, when we try to kexec boot something other than the
> Linux kernel, the cleanup cannot be relied upon.
> Hence, cleanup before we go down for reboot.
> 
> Keeping the cleanup at initialization also, in case BIOS
> leaves the IOMMU enabled.
> 
> I considered turning off iommu only during kexec reboot,
> but a clean shutdown seems always a good idea. But if
> someone wants to make it conditional, we can do that.
> 
> Tested that before, the info message
> 'DMAR: Translation was enabled for <iommu> but we are not in kdump mode'
> would be reported for each iommu. The message will not appear when the
> DMA-remapping is not enabled on entry to the kernel.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>   drivers/iommu/intel-iommu.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index fe8097078669..f0636b263722 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4764,6 +4764,26 @@ static void intel_disable_iommus(void)
>   		iommu_disable_translation(iommu);
>   }
>   
> +static void intel_iommu_shutdown(void)
> +{
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu = NULL;
> +
> +	if (no_iommu || dmar_disabled)
> +		return;
> +
> +	down_write(&dmar_global_lock);
> +
> +	/* Disable PMRs explicitly here. */
> +	for_each_iommu(iommu, drhd)
> +		iommu_disable_protect_mem_regions(iommu);
> +
> +	/* Make sure the IOMMUs are switched off */
> +	intel_disable_iommus();
> +
> +	up_write(&dmar_global_lock);
> +}
> +
>   static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)
>   {
>   	struct iommu_device *iommu_dev = dev_to_iommu_device(dev);
> @@ -5013,6 +5033,8 @@ int __init intel_iommu_init(void)
>   	}
>   	up_write(&dmar_global_lock);
>   
> +	x86_platform.iommu_shutdown = intel_iommu_shutdown;

How about moving it to detect_intel_iommu() in drivers/iommu/dmar.c? And
make sure that it's included with CONFIG_X86_64.

Best regards,
baolu

> +
>   #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
>   	/*
>   	 * If the system has no untrusted device or the user has decided
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
