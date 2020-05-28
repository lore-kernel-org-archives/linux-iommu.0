Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3A9C433DF
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 06:59:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D840208E4
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 06:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D840208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5CBD386D92;
	Thu, 28 May 2020 06:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlVf2v5Nv5aT; Thu, 28 May 2020 06:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C9C5586CDD;
	Thu, 28 May 2020 06:59:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDDF2C088D;
	Thu, 28 May 2020 06:59:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6604EC016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 06:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 53C1C87D58
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 06:59:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tpHo-WH7zqWZ for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 06:59:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A4F9687C12
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 06:59:03 +0000 (UTC)
IronPort-SDR: gv/okOCCozGnTKzaBEEJzPMEvlIOEYl3Z1AmMBBxxScMLaP1g4F5HkSxy35J2U8boMJYRyiuly
 KxBNZoh456hw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 23:59:03 -0700
IronPort-SDR: r3uhcUHtN+Unc52bFgwWqmKLrtoPUpmFeeXHBuq20TESLN6GFaH9ys0ak/J+baCfJQerDF+RNU
 55MC0i4pjCow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; d="scan'208";a="442844492"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.30.232])
 ([10.255.30.232])
 by orsmga005.jf.intel.com with ESMTP; 27 May 2020 23:59:00 -0700
Subject: Re: [PATCH v1 1/3] iommu/vt-d: Only clear real DMA device's context
 entries
To: Jon Derrick <jonathan.derrick@intel.com>, iommu@lists.linux-foundation.org
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
 <20200527165617.297470-2-jonathan.derrick@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <199f788c-f00e-6bd9-49fe-9fcc06bef431@linux.intel.com>
Date: Thu, 28 May 2020 14:59:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527165617.297470-2-jonathan.derrick@intel.com>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org
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

On 2020/5/28 0:56, Jon Derrick wrote:
> Domain context mapping can encounter issues with sub-devices of a real
> DMA device. A sub-device cannot have a valid context entry due to it
> potentially aliasing another device's 16-bit ID. It's expected that
> sub-devices of the real DMA device uses the real DMA device's requester
> when context mapping.
> 
> This is an issue when a sub-device is removed where the context entry is
> cleared for all aliases. Other sub-devices are still valid, resulting in
> those sub-devices being stranded without valid context entries.
> 
> The correct approach is to use the real DMA device when programming the
> context entries. The insertion path is correct because device_to_iommu()
> will return the bus and devfn of the real DMA device. The removal path
> needs to only operate on the real DMA device, otherwise the entire
> context entry would be cleared for all sub-devices of the real DMA
> device.
> 
> This patch also adds a helper to determine if a struct device is a
> sub-device of a real DMA device.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Fixes: 2b0140c69637e ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
