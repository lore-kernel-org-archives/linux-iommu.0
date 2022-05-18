Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405F4C433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 13:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D803060EB8;
	Wed, 18 May 2022 13:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pB3L4nk8zfKd; Wed, 18 May 2022 13:45:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6FEF360EA0;
	Wed, 18 May 2022 13:45:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48728C0039;
	Wed, 18 May 2022 13:45:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E037DC002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 13:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF9074067B
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 13:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AaDqJPMYVRo1 for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 13:45:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93E924064D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 13:45:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C350923A;
 Wed, 18 May 2022 06:45:14 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EB493F73D;
 Wed, 18 May 2022 06:45:13 -0700 (PDT)
Message-ID: <f88ea085-2161-02ff-ee36-a004b9e48338@arm.com>
Date: Wed, 18 May 2022 14:45:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
 <20220518131237.GA26019@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220518131237.GA26019@lst.de>
Cc: liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org
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

On 2022-05-18 14:12, Christoph Hellwig wrote:
> On Tue, May 17, 2022 at 11:40:52AM +0100, Robin Murphy wrote:
>> Indeed, sorry but NAK for this being nonsense. As I've said at least once
>> before, if the unnecessary SAC address allocation attempt slows down your
>> workload, make it not do that in the first place. If you don't like the
>> existing command-line parameter then fine, there are plenty of other
>> options, it just needs to be done in a way that doesn't break x86 systems
>> with dodgy firmware, as my first attempt turned out to.
> 
> What broke x86?

See the thread at [1] (and in case of curiosity the other IVRS patches I 
refer to therein were at [2]). Basically, undescribed limitations lead 
to DMA address truncation once iommu-dma starts allocating from what it 
thinks is the full usable IOVA range. Your typical desktop PC is 
unlikely to have enough concurrent DMA-mapped memory to overflow the 
32-bit IOVA space naturally, so this has probably been hiding an untold 
multitude of sins over the years.

Robin.

[1] 
https://lore.kernel.org/linux-iommu/e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com/
[2] 
https://lore.kernel.org/linux-iommu/20200605145655.13639-1-sebott@amazon.de/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
