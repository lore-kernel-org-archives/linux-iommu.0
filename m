Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD377C2D0A3
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 01:47:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18AB520715
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 01:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AB520715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7BC6A8455E;
	Thu,  5 Nov 2020 01:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id toSCk-d8Uxkl; Thu,  5 Nov 2020 01:47:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BBA8684415;
	Thu,  5 Nov 2020 01:47:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A610CC0893;
	Thu,  5 Nov 2020 01:47:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 652F1C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 01:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4FF8C8452A
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 01:47:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rg4wGFUYAbi1 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 01:47:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A258184415
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 01:47:34 +0000 (UTC)
IronPort-SDR: BKgv7va7koMhbKB86iOwUeHXLAiUKsxWHXZuiAS8CJiQqILM6GlH/K1II/WehKK5ioIE/FAQsY
 qfbsnmhTso9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="233472500"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; d="scan'208";a="233472500"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 17:47:32 -0800
IronPort-SDR: /dnO9v06xkWam6UrXoGlF/a/lC9EVW6p+asIKYYtQRW2QqAda0Ae+uOC1lmXLRK8YZLMgPP4Hd
 iyZ2uyOB5zAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; d="scan'208";a="426853938"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2020 17:47:30 -0800
Subject: Re: [PATCH] iommu/vt-d: remove redundant variable no_platform_optin
To: Zhenzhong Duan <zhenzhong.duan@gmail.com>, linux-kernel@vger.kernel.org
References: <20201104081936.2128-1-zhenzhong.duan@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <67fd98a2-23a9-b69a-4d60-a0698e243a85@linux.intel.com>
Date: Thu, 5 Nov 2020 09:40:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104081936.2128-1-zhenzhong.duan@gmail.com>
Content-Language: en-US
Cc: dwmw2@infradead.org, iommu@lists.linux-foundation.org
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

Hi Zhenzhong,

On 11/4/20 4:19 PM, Zhenzhong Duan wrote:
> no_platform_optin is redundant with dmar_disabled and it's only used in
> platform_optin_force_iommu(), remove it and use dmar_disabled instead.

It's actually not.

If CONFIG_INTEL_IOMMU_DEFAULT_ON is not set, we will get "dmar_disable =
1" and "no_platform_optin = 0". In this case, we must force the iommu on
and set dmar_disable = 0.

The real use case: if a kernel built with [CONFIG_INTEL_IOMMU_DEFAULT_ON
= n] running on a platform with thunderbolt ports, we must force IOMMU
on so that the system could be protected from possible malicious
peripherals.

Best regards,
baolu


> 
> Meanwhile remove all the dead code in platform_optin_force_iommu().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>   drivers/iommu/intel/iommu.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8651f6d4dfa0..a011d1ed63ef 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -180,7 +180,6 @@ static int rwbf_quirk;
>    */
>   static int force_on = 0;
>   int intel_iommu_tboot_noforce;
> -static int no_platform_optin;
>   
>   #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
>   
> @@ -440,7 +439,6 @@ static int __init intel_iommu_setup(char *str)
>   			pr_info("IOMMU enabled\n");
>   		} else if (!strncmp(str, "off", 3)) {
>   			dmar_disabled = 1;
> -			no_platform_optin = 1;
>   			pr_info("IOMMU disabled\n");
>   		} else if (!strncmp(str, "igfx_off", 8)) {
>   			dmar_map_gfx = 0;
> @@ -4810,20 +4808,12 @@ static inline bool has_external_pci(void)
>   
>   static int __init platform_optin_force_iommu(void)
>   {
> -	if (!dmar_platform_optin() || no_platform_optin || !has_external_pci())
> +	if (!dmar_platform_optin() || dmar_disabled || !has_external_pci())
>   		return 0;
>   
> -	if (no_iommu || dmar_disabled)
> +	if (no_iommu)
>   		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
>   
> -	/*
> -	 * If Intel-IOMMU is disabled by default, we will apply identity
> -	 * map for all devices except those marked as being untrusted.
> -	 */
> -	if (dmar_disabled)
> -		iommu_set_default_passthrough(false);
> -
> -	dmar_disabled = 0;
>   	no_iommu = 0;
>   
>   	return 1;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
