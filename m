Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0C1C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 05:03:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0B0214E0
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 05:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0B0214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 063B7C79;
	Mon, 11 Nov 2019 05:03:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 36B54B5F
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 05:03:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B89A14C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 05:03:13 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Nov 2019 21:03:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; d="scan'208";a="228820825"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2019 21:03:12 -0800
Subject: Re: [PATCH v2] iommu/vt-d: Turn off translations at shutdown
To: Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org,
	joro@8bytes.org
References: <20191110172744.12541-1-deepa.kernel@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9f6b30fd-a827-c555-cc8f-f182e1be711f@linux.intel.com>
Date: Mon, 11 Nov 2019 13:00:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191110172744.12541-1-deepa.kernel@gmail.com>
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

On 11/11/19 1:27 AM, Deepa Dinamani wrote:
> The intel-iommu driver assumes that the iommu state is
> cleaned up at the start of the new kernel.
> But, when we try to kexec boot something other than the
> Linux kernel, the cleanup cannot be relied upon.
> Hence, cleanup before we go down for reboot.
> 
> Keeping the cleanup at initialization also, in case BIOS
> leaves the IOMMU enabled.
> 
> I considered turning off iommu only during kexec reboot, but a clean
> shutdown seems always a good idea. But if someone wants to make it
> conditional, such as VMM live update, we can do that.  There doesn't
> seem to be such a condition at this time.
> 
> Tested that before, the info message
> 'DMAR: Translation was enabled for <iommu> but we are not in kdump mode'
> would be reported for each iommu. The message will not appear when the
> DMA-remapping is not enabled on entry to the kernel.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

This patch looks good to me.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> Changes since v1:
> * move shutdown registration to iommu detection
> 
>   drivers/iommu/dmar.c        |  5 ++++-
>   drivers/iommu/intel-iommu.c | 20 ++++++++++++++++++++
>   include/linux/dmar.h        |  2 ++
>   3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index eecd6a421667..3acfa6a25fa2 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -895,8 +895,11 @@ int __init detect_intel_iommu(void)
>   	}
>   
>   #ifdef CONFIG_X86
> -	if (!ret)
> +	if (!ret) {
>   		x86_init.iommu.iommu_init = intel_iommu_init;
> +		x86_platform.iommu_shutdown = intel_iommu_shutdown;
> +	}
> +
>   #endif
>   
>   	if (dmar_tbl) {
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index fe8097078669..7ac73410ba8e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4764,6 +4764,26 @@ static void intel_disable_iommus(void)
>   		iommu_disable_translation(iommu);
>   }
>   
> +void intel_iommu_shutdown(void)
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
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index a7cf3599d9a1..f64ca27dc210 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -129,6 +129,7 @@ static inline int dmar_res_noop(struct acpi_dmar_header *hdr, void *arg)
>   #ifdef CONFIG_INTEL_IOMMU
>   extern int iommu_detected, no_iommu;
>   extern int intel_iommu_init(void);
> +extern void intel_iommu_shutdown(void);
>   extern int dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg);
>   extern int dmar_parse_one_atsr(struct acpi_dmar_header *header, void *arg);
>   extern int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void *arg);
> @@ -137,6 +138,7 @@ extern int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert);
>   extern int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info);
>   #else /* !CONFIG_INTEL_IOMMU: */
>   static inline int intel_iommu_init(void) { return -ENODEV; }
> +static inline void intel_iommu_shutdown(void) { }
>   
>   #define	dmar_parse_one_rmrr		dmar_res_noop
>   #define	dmar_parse_one_atsr		dmar_res_noop
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
