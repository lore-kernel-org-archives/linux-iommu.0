Return-Path: <SRS0=Ewjr=LG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5B4C48BE5
	for <iommu@archiver.kernel.org>; Sat, 12 Jun 2021 02:22:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8D5610C7
	for <iommu@archiver.kernel.org>; Sat, 12 Jun 2021 02:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8D5610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C53696066A;
	Sat, 12 Jun 2021 02:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AX9cUsiprruu; Sat, 12 Jun 2021 02:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C76A160661;
	Sat, 12 Jun 2021 02:22:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97AA2C000D;
	Sat, 12 Jun 2021 02:22:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A49FC000B
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 02:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 286C383D71
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 02:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LLLFSM131cZv for <iommu@lists.linux-foundation.org>;
 Sat, 12 Jun 2021 02:22:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 32B7583D6A
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 02:22:10 +0000 (UTC)
IronPort-SDR: mbQswgfgtHGBls7wl5RoGz3MIokhfFytOLQjKK686Pw/jrzWf6ILWDrKGk0UDr4r0sszeepXVu
 FvVcr+arBTaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="291271308"
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; d="scan'208";a="291271308"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2021 19:22:10 -0700
IronPort-SDR: ZysiFsrZ4pWagwIqIBTg+k5Dg7ZjYlOieEOa6PckGcJsI4HMKNINe3ACibzjyuLSMgliM25Mcf
 JpQJPXoZnuVQ==
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; d="scan'208";a="483473788"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.238.4.20])
 ([10.238.4.20])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2021 19:22:07 -0700
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
Message-ID: <4f2cec34-bad9-e1bf-85c1-04d1a0c1aecf@linux.intel.com>
Date: Sat, 12 Jun 2021 10:22:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623414043-40745-4-git-send-email-john.garry@huawei.com>
Content-Language: en-US
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

On 2021/6/11 20:20, John Garry wrote:
> @@ -453,8 +452,7 @@ static int __init intel_iommu_setup(char *str)
>   			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
> -			pr_info("Disable batched IOTLB flush\n");
> -			intel_iommu_strict = 1;
> +			iommu_set_dma_strict(true);

I would like to deprecate this command line and ask users to use
iommu.strict instead.

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -436,7 +436,7 @@ static int __init intel_iommu_setup(char *str)
                         pr_warn("intel_iommu=forcedac deprecated; use 
iommu.forcedac instead\n");
                         iommu_dma_forcedac = true;
                 } else if (!strncmp(str, "strict", 6)) {
-                       pr_info("Disable batched IOTLB flush\n");
+                       pr_warn("intel_iommu=strict deprecated; use 
iommu.strict instead\n");
                         intel_iommu_strict = 1;

Also update Documentation/admin-guide/kernel-parameters.txt accordingly.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
