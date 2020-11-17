Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFBBC56202
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 23:32:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0102417E
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 23:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0102417E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4AFA20398;
	Tue, 17 Nov 2020 23:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FNCwUUza+nIX; Tue, 17 Nov 2020 23:32:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B86D2203B2;
	Tue, 17 Nov 2020 23:32:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CBE6C0800;
	Tue, 17 Nov 2020 23:32:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB163C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 23:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 980E586679
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 23:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ob6TqGJHTbD1 for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 23:32:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C63568666B
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 23:32:31 +0000 (UTC)
IronPort-SDR: 8tmb3t2YbwLAeajIGLGO1gJ+TuzZ1bpl3OIQ3wkQkWa3W3n/WJURLBsNk5lCsNIQ8JYFRNNcje
 Lj/g5VqgvuyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="235182074"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; d="scan'208";a="235182074"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 15:32:31 -0800
IronPort-SDR: 5382oeKWx+HYT1RMhyNPodt0b+9JjqrE65FbskKgyoQWOCiOkPDwmesPlkd4bELgNbAbYweNIN
 IIUaC5ZVD7Zw==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; d="scan'208";a="532413741"
Received: from jli128-mobl1.ccr.corp.intel.com (HELO [10.254.209.252])
 ([10.254.209.252])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 15:32:28 -0800
Subject: Re: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init fail
 in tboot system
To: Zhenzhong Duan <zhenzhong.duan@gmail.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>
References: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <34e8f6c6-e9f7-634b-8f68-3645261fd882@linux.intel.com>
Date: Wed, 18 Nov 2020 07:32:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
Content-Language: en-US
Cc: x86@kernel.org, tboot-devel@lists.sourceforge.net, ning.sun@intel.com,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 tglx@linutronix.de, dwmw2@infradead.org
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

+Will

Please consider this patch for v5.10.

Best regards,
baolu

On 2020/11/10 15:19, Zhenzhong Duan wrote:
> "intel_iommu=off" command line is used to disable iommu but iommu is force
> enabled in a tboot system for security reason.
> 
> However for better performance on high speed network device, a new option
> "intel_iommu=tboot_noforce" is introduced to disable the force on.
> 
> By default kernel should panic if iommu init fail in tboot for security
> reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
> 
> Fix the code setting force_on and move intel_iommu_tboot_noforce
> from tboot code to intel iommu code.
> 
> Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
> v2: move ckeck of intel_iommu_tboot_noforce into iommu code per Baolu.
> 
>   arch/x86/kernel/tboot.c     | 3 ---
>   drivers/iommu/intel/iommu.c | 5 +++--
>   include/linux/intel-iommu.h | 1 -
>   3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index 992fb14..420be87 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -514,9 +514,6 @@ int tboot_force_iommu(void)
>   	if (!tboot_enabled())
>   		return 0;
>   
> -	if (intel_iommu_tboot_noforce)
> -		return 1;
> -
>   	if (no_iommu || swiotlb || dmar_disabled)
>   		pr_warn("Forcing Intel-IOMMU to enabled\n");
>   
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1b1ca63..4d9b298 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -179,7 +179,7 @@ static inline unsigned long virt_to_dma_pfn(void *p)
>    * (used when kernel is launched w/ TXT)
>    */
>   static int force_on = 0;
> -int intel_iommu_tboot_noforce;
> +static int intel_iommu_tboot_noforce;
>   static int no_platform_optin;
>   
>   #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
> @@ -4885,7 +4885,8 @@ int __init intel_iommu_init(void)
>   	 * Intel IOMMU is required for a TXT/tboot launch or platform
>   	 * opt in, so enforce that.
>   	 */
> -	force_on = tboot_force_iommu() || platform_optin_force_iommu();
> +	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
> +		    platform_optin_force_iommu();
>   
>   	if (iommu_init_mempool()) {
>   		if (force_on)
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index fbf5b3e..d956987 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -798,7 +798,6 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>   extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>   extern int dmar_disabled;
>   extern int intel_iommu_enabled;
> -extern int intel_iommu_tboot_noforce;
>   extern int intel_iommu_gfx_mapped;
>   #else
>   static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
