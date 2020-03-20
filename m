Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07775C4332B
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 13:57:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE4920709
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 13:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE4920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BBDB28721A;
	Fri, 20 Mar 2020 13:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Js99atE2-Zgv; Fri, 20 Mar 2020 13:57:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9E0C0874C9;
	Fri, 20 Mar 2020 13:57:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B21EC089E;
	Fri, 20 Mar 2020 13:57:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DC75C07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 13:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6C22E88699
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 13:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h5P-3QA1gfr8 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 13:57:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CBE8388686
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 13:57:46 +0000 (UTC)
IronPort-SDR: G6gcMbidSmcJ0B4kgeR1ZQ16CtLa8/5XGNBpI0JCfjIXhqh81bunczFyjn6UNEGTJivqO/Gy/E
 xWPGy7ZZ+vEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 06:57:46 -0700
IronPort-SDR: yvjBrOOURHBM8gKE88ZBhZ2rJoI18IPpRiP27yzmUiPEWVEgOAj16RYPXYrxFI+vXBm/9akVmd
 rIZ7tv9WassQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; d="scan'208";a="237235659"
Received: from che5-mobl.ccr.corp.intel.com (HELO [10.254.213.15])
 ([10.254.213.15])
 by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2020 06:57:44 -0700
Subject: Re: [PATCH 3/3] iommu/vt-d: Add build dependency on IOASID
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584678751-43169-4-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2f2b5c45-552f-1399-ad7d-0c460ab783f4@linux.intel.com>
Date: Fri, 20 Mar 2020 21:57:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584678751-43169-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: Raj Ashok <ashok.raj@intel.com>
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

On 2020/3/20 12:32, Jacob Pan wrote:
> IOASID code is needed by VT-d scalable mode for PASID allocation.
> Add explicit dependency such that IOASID is built-in whenever Intel
> IOMMU is enabled.
> Otherwise, aux domain code will fail when IOMMU is built-in and IOASID
> is compiled as a module.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Fixes: 59a623374dc38 ("iommu/vt-d: Replace Intel specific PASID 
allocator with IOASID")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d2fade984999..25149544d57c 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -188,6 +188,7 @@ config INTEL_IOMMU
>   	select NEED_DMA_MAP_STATE
>   	select DMAR_TABLE
>   	select SWIOTLB
> +	select IOASID
>   	help
>   	  DMA remapping (DMAR) devices support enables independent address
>   	  translations for Direct Memory Access (DMA) from devices.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
