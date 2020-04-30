Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC6C47254
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 15:15:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D877120661
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 15:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D877120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AEDC186DEA;
	Thu, 30 Apr 2020 15:15:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QUKwHLVCy_VU; Thu, 30 Apr 2020 15:15:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 246A086DC9;
	Thu, 30 Apr 2020 15:15:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A1B9C0889;
	Thu, 30 Apr 2020 15:15:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A9A5C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 15:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 42FC786DEA
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 15:13:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5X0gu7O7tKjd for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 15:13:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 699F786DC9
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 15:13:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B73B4101E;
 Thu, 30 Apr 2020 08:13:44 -0700 (PDT)
Received: from [10.37.12.139] (unknown [10.37.12.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DCB23F68F;
 Thu, 30 Apr 2020 08:13:36 -0700 (PDT)
Subject: Re: [PATCH v6 10/25] arm64: cpufeature: Export symbol
 read_sanitised_ftr_reg()
To: jean-philippe@linaro.org, iommu@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-11-jean-philippe@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ecec4f36-041f-0068-3863-106f9a082c62@arm.com>
Date: Thu, 30 Apr 2020 16:18:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200430143424.2787566-11-jean-philippe@linaro.org>
Content-Language: en-US
X-Mailman-Approved-At: Thu, 30 Apr 2020 15:14:59 +0000
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, felix.kuehling@amd.com, will@kernel.org,
 christian.koenig@amd.com
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

On 04/30/2020 03:34 PM, Jean-Philippe Brucker wrote:
> The SMMUv3 driver would like to read the MMFR0 PARANGE field in order to
> share CPU page tables with devices. Allow the driver to be built as
> module by exporting the read_sanitized_ftr_reg() cpufeature symbol.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   arch/arm64/kernel/cpufeature.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9fac745aa7bb2..5f6adbf4ae893 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -841,6 +841,7 @@ u64 read_sanitised_ftr_reg(u32 id)
>   	BUG_ON(!regp);
>   	return regp->sys_val;
>   }
> +EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
>   
>   #define read_sysreg_case(r)	\
>   	case r:		return read_sysreg_s(r)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
