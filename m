Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD790C34021
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 15:50:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFB3214D8
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 15:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFB3214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BA95220020;
	Mon, 17 Feb 2020 15:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EzNO31K4bw2n; Mon, 17 Feb 2020 15:50:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B5EC92001D;
	Mon, 17 Feb 2020 15:50:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8885C089F;
	Mon, 17 Feb 2020 15:50:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6697C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 15:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A532886981
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 15:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4zahu7nFyPDd for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 15:50:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id B0373862B1
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 15:50:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14BF430E;
 Mon, 17 Feb 2020 07:50:51 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C9833F6CF;
 Mon, 17 Feb 2020 07:50:50 -0800 (PST)
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
To: Christoph Hellwig <hch@infradead.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
Date: Mon, 17 Feb 2020 15:50:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200217080138.GB10342@infradead.org>
Content-Language: en-GB
Cc: kernel-team@android.com, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-kernel@vger.kernel.org,
 Liam Mark <lmark@codeaurora.org>
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

On 17/02/2020 8:01 am, Christoph Hellwig wrote:
> On Fri, Feb 14, 2020 at 02:58:16PM -0800, Isaac J. Manjarres wrote:
>> From: Liam Mark <lmark@codeaurora.org>
>>
>> Some devices have a memory map which contains gaps or holes.
>> In order for the device to have as much IOVA space as possible,
>> allow its driver to inform the DMA-IOMMU layer that it should
>> not allocate addresses from these holes.
> 
> Layering violation.  dma-iommu is the translation layer between the
> DMA API and the IOMMU API.  And calls into it from drivers performing
> DMA mappings need to go through the DMA API (and be documented there).

+1

More than that, though, we already have "holes in the address space" 
support for the sake of PCI host bridge windows - assuming this is the 
same kind of thing (i.e. the holes are between memory regions and other 
resources in PA space, so are only relevant once address translation 
comes into the picture), then this is IOMMU API level stuff, so even a 
DMA API level interface would be inappropriate.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
