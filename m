Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC0CC433EF
	for <iommu@archiver.kernel.org>; Mon, 31 Jan 2022 13:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5FA584014;
	Mon, 31 Jan 2022 13:53:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aXCbM9o4TFwz; Mon, 31 Jan 2022 13:53:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 84A6B83337;
	Mon, 31 Jan 2022 13:53:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56E11C001A;
	Mon, 31 Jan 2022 13:53:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4479C000B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 13:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DA3184014
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 13:53:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ZC41P8r6QsC for <iommu@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 13:53:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8C2483337
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 13:53:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDA27D6E;
 Mon, 31 Jan 2022 05:53:14 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A70763F774;
 Mon, 31 Jan 2022 05:53:13 -0800 (PST)
Message-ID: <d9c35bb7-e6f5-a439-505b-5352c34f5621@arm.com>
Date: Mon, 31 Jan 2022 13:53:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI bus rescan device hot add
Content-Language: en-GB
To: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>
References: <20220128031002.2219155-1-baolu.lu@linux.intel.com>
 <20220128031002.2219155-2-baolu.lu@linux.intel.com>
 <YfZBlzYTN/RfCGnE@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YfZBlzYTN/RfCGnE@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Guoqing Jiang <guoqing.jiang@linux.dev>,
 Bernice <bernice.zhang@intel.com>, Zhang@8bytes.org
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

On 2022-01-30 07:43, Joerg Roedel wrote:
> Hi Jacob, Baolu,
> 
> On Fri, Jan 28, 2022 at 11:10:01AM +0800, Lu Baolu wrote:
>> During PCI bus rescan, adding new devices involve two notifiers.
>> 1. dmar_pci_bus_notifier()
>> 2. iommu_bus_notifier()
>> The current code sets #1 as low priority (INT_MIN) which resulted in #2
>> being invoked first. The result is that struct device pointer cannot be
>> found in DRHD search for the new device's DMAR/IOMMU. Subsequently, the
>> device is put under the "catch-all" IOMMU instead of the correct one.
> 
> There are actually iommu_ops pointers invoked from iommu_bus_notifier()
> into IOMMU driver code. Can those be used to enforce the ordering in a
> more reliable way?

Indeed I very nearly asked whether we couldn't just call these from 
intel_iommu_{probe,release}_device() directly, but it looks like they 
also interact with the interrupt remapping stuff which can be built 
independently of the IOMMU API :(

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
