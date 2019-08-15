Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49EEC31E40
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 04:54:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DBC2171F
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 04:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DBC2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8A4E5B4B;
	Thu, 15 Aug 2019 04:54:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0D972B09
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 04:54:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DE2E58AC
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 04:54:32 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 Aug 2019 21:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; d="scan'208";a="171011114"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 14 Aug 2019 21:54:28 -0700
Subject: Re: [PATCH 04/10] x86/dma: Get rid of iommu_pass_through
To: Joerg Roedel <joro@8bytes.org>
References: <20190814133841.7095-1-joro@8bytes.org>
	<20190814133841.7095-5-joro@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ef941cbd-07dc-ac93-e5b2-f30ac4a55bc2@linux.intel.com>
Date: Thu, 15 Aug 2019 12:53:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814133841.7095-5-joro@8bytes.org>
Content-Language: en-US
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	tglx@linutronix.de, corbet@lwn.net, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
	bp@alien8.de, hpa@zytor.com, Thomas.Lendacky@amd.com, mingo@redhat.com
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
> This variable has no users anymore. Remove it and tell the
> IOMMU code via its new functions about requested DMA modes.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

This will also simplify the procedures in iommu_probe_device() on x86
platforms.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

> ---
>   arch/x86/include/asm/iommu.h |  1 -
>   arch/x86/kernel/pci-dma.c    | 11 +++--------
>   2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index baedab8ac538..b91623d521d9 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -4,7 +4,6 @@
>   
>   extern int force_iommu, no_iommu;
>   extern int iommu_detected;
> -extern int iommu_pass_through;
>   
>   /* 10 seconds */
>   #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index f62b498b18fb..a6fd479d4a71 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <linux/dma-direct.h>
>   #include <linux/dma-debug.h>
> +#include <linux/iommu.h>
>   #include <linux/dmar.h>
>   #include <linux/export.h>
>   #include <linux/memblock.h>
> @@ -43,12 +44,6 @@ int iommu_detected __read_mostly = 0;
>    * It is also possible to disable by default in kernel config, and enable with
>    * iommu=nopt at boot time.
>    */
> -#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
> -int iommu_pass_through __read_mostly = 1;
> -#else
> -int iommu_pass_through __read_mostly;
> -#endif
> -
>   extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
>   
>   void __init pci_iommu_alloc(void)
> @@ -120,9 +115,9 @@ static __init int iommu_setup(char *p)
>   			swiotlb = 1;
>   #endif
>   		if (!strncmp(p, "pt", 2))
> -			iommu_pass_through = 1;
> +			iommu_set_default_passthrough();
>   		if (!strncmp(p, "nopt", 4))
> -			iommu_pass_through = 0;
> +			iommu_set_default_translated();
>   
>   		gart_parse_options(p);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
