Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF6CC47096
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 02:54:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1296140B
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 02:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1296140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 265E16F948;
	Fri,  4 Jun 2021 02:54:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PqfVt7TL1GpW; Fri,  4 Jun 2021 02:54:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC0F76F944;
	Fri,  4 Jun 2021 02:54:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7E6BC000D;
	Fri,  4 Jun 2021 02:54:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FBEAC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 02:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12B2640694
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 02:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4NjGvYJpptu9 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:54:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03F034068F
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 02:54:44 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fx6hY2SGcz68Tn;
 Fri,  4 Jun 2021 10:50:53 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 10:54:32 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 4 Jun 2021
 10:54:32 +0800
Subject: Re: [PATCH v10 1/3] iommu: Enhance IOMMU default DMA mode build
 options
To: John Garry <john.garry@huawei.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
References: <1622728715-209296-1-git-send-email-john.garry@huawei.com>
 <1622728715-209296-2-git-send-email-john.garry@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0e54ff0f-c668-354e-1ec8-7536c701d3a8@huawei.com>
Date: Fri, 4 Jun 2021 10:54:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1622728715-209296-2-git-send-email-john.garry@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021/6/3 21:58, John Garry wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> First, add build options IOMMU_DEFAULT_{LAZY|STRICT}, so that we have the
> opportunity to set {lazy|strict} mode as default at build time. Then put
> the two config options in an choice, as they are mutually-exclusive.
> 
> [jpg: Make choice between strict and lazy only (and not passthrough)]
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/Kconfig | 34 ++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c |  3 ++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1f111b399bca..12ef90256df8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -90,6 +90,40 @@ config IOMMU_DEFAULT_PASSTHROUGH
>  
>  	  If unsure, say N here.
>  
> +choice
> +	prompt "IOMMU default DMA mode"
> +	depends on IOMMU_API

config INTEL_IOMMU
        depends on PCI_MSI && ACPI && (X86 || IA64)

config AMD_IOMMU
        depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE

config ARM_SMMU_V3
        depends on ARM64

"depends on ARM_SMMU_V3 || INTEL_IOMMU || AMD_IOMMU" may need to be added, because it doesn't work on other platforms.

or "depends on X86 || IA64 || X86_64 || ARM64"

> +
> +	default IOMMU_DEFAULT_STRICT
> +	help
> +	  This option allows an IOMMU DMA mode to be chosen at build time, to
> +	  override the default DMA mode of each ARCH, removing the need to
> +	  pass in kernel parameters through command line. It is still possible
> +	  to provide ARCH-specific or common boot options to override this
> +	  option.
> +
> +	  If unsure, keep the default.
> +
> +config IOMMU_DEFAULT_LAZY
> +	bool "lazy"
> +	help
> +	  Support lazy mode, where for every IOMMU DMA unmap operation, the
> +	  flush operation of IOTLB and the free operation of IOVA are deferred.
> +	  They are only guaranteed to be done before the related IOVA will be
> +	  reused.
> +
> +config IOMMU_DEFAULT_STRICT
> +	bool "strict"
> +	help
> +	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
> +	  the free operation of IOVA are guaranteed to be done in the unmap
> +	  function.
> +
> +	  This mode is safer than the two above, but it maybe slower in some
> +	  high performace scenarios.
> +
> +endchoice
> +
>  config OF_IOMMU
>  	def_bool y
>  	depends on OF && IOMMU_API
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 966426a96520..177b0dafc535 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -29,7 +29,8 @@ static struct kset *iommu_group_kset;
>  static DEFINE_IDA(iommu_group_ida);
>  
>  static unsigned int iommu_def_domain_type __read_mostly;
> -static bool iommu_dma_strict __read_mostly = true;
> +static bool iommu_dma_strict __read_mostly =
> +			IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);

Currently, a maximum of 100 columns are allowed in a row.

>  static u32 iommu_cmd_line __read_mostly;
>  
>  struct iommu_group {
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
