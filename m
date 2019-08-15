Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAD0C433FF
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 05:05:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2978E208C2
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 05:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2978E208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 07A99B09;
	Thu, 15 Aug 2019 05:05:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 39EC2AD8
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 05:05:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CDC8B8AC
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 05:05:34 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 Aug 2019 22:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; d="scan'208";a="171013666"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 14 Aug 2019 22:05:30 -0700
Subject: Re: [PATCH 07/10] iommu: Print default domain type on boot
To: Joerg Roedel <joro@8bytes.org>
References: <20190814133841.7095-1-joro@8bytes.org>
	<20190814133841.7095-8-joro@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <39163f22-0c22-ccae-84df-e65f53aa1a82@linux.intel.com>
Date: Thu, 15 Aug 2019 13:04:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814133841.7095-8-joro@8bytes.org>
Content-Language: en-US
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	corbet@lwn.net, Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
	Thomas.Lendacky@amd.com, hpa@zytor.com, tglx@linutronix.de
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

On 8/14/19 9:38 PM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Introduce a subsys_initcall for IOMMU code and use it to
> print the default domain type at boot.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/iommu.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e1feb4061b8b..233bc22b487e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -93,12 +93,40 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
>   static LIST_HEAD(iommu_device_list);
>   static DEFINE_SPINLOCK(iommu_device_lock);
>   
> +/*
> + * Use a function instead of an array here because the domain-type is a
> + * bit-field, so an array would waste memory.
> + */
> +static const char *iommu_domain_type_str(unsigned int t)
> +{
> +	switch (t) {
> +		case IOMMU_DOMAIN_BLOCKED:
> +			return "Blocked";
> +		case IOMMU_DOMAIN_IDENTITY:
> +			return "Passthrough";
> +		case IOMMU_DOMAIN_UNMANAGED:
> +			return "Unmanaged";
> +		case IOMMU_DOMAIN_DMA:
> +			return "Translated";
> +		default:
> +			return "Unknown";
> +	}
> +}

Run scripts/checkpatch.pl:

ERROR: switch and case should be at the same indent
#28: FILE: drivers/iommu/iommu.c:102:
+	switch (t) {
+		case IOMMU_DOMAIN_BLOCKED:
[...]
+		case IOMMU_DOMAIN_IDENTITY:
[...]
+		case IOMMU_DOMAIN_UNMANAGED:
[...]
+		case IOMMU_DOMAIN_DMA:
[...]
+		default:

Best regards,
Lu Baolu

> +
> +static int __init iommu_subsys_init(void)
> +{
> +	pr_info("Default domain type: %s\n",
> +		iommu_domain_type_str(iommu_def_domain_type));
> +
> +	return 0;
> +}
> +subsys_initcall(iommu_subsys_init);
> +
>   int iommu_device_register(struct iommu_device *iommu)
>   {
>   	spin_lock(&iommu_device_lock);
>   	list_add_tail(&iommu->list, &iommu_device_list);
>   	spin_unlock(&iommu_device_lock);
> -
>   	return 0;
>   }
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
