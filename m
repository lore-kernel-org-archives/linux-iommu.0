Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F373C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 15:01:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0421760EE5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 15:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0421760EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C468E80F51;
	Mon, 11 Oct 2021 15:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6KEhv4-wG4qW; Mon, 11 Oct 2021 15:01:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A32D880F28;
	Mon, 11 Oct 2021 15:01:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68683C0011;
	Mon, 11 Oct 2021 15:01:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6A14C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 15:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B880F4049B
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 15:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yYq6x6L8k4rW for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 15:00:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFB0C40496
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 15:00:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EB10101E;
 Mon, 11 Oct 2021 08:00:57 -0700 (PDT)
Received: from [10.57.95.157] (unknown [10.57.95.157])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1E353F694;
 Mon, 11 Oct 2021 08:00:54 -0700 (PDT)
Subject: Re: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated with
 a dev
To: Jon Nettleton <jon@solid-run.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com>
 <44e00e32-be89-1174-beb5-9a2fca85a683@arm.com>
 <CABdtJHv+SZ15RcBaFt0w4iTsMMbAjGB2Wm4GST3cNw+2Q=OeVw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <706e2dc8-37af-2344-0d99-6da1f27ba0fb@arm.com>
Date: Mon, 11 Oct 2021 16:00:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABdtJHv+SZ15RcBaFt0w4iTsMMbAjGB2Wm4GST3cNw+2Q=OeVw@mail.gmail.com>
Content-Language: en-GB
Cc: Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>, Sami Mujawar <Sami.Mujawar@arm.com>,
 Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On 2021-10-09 08:07, Jon Nettleton wrote:
> On Fri, Oct 8, 2021 at 3:10 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-08-05 09:07, Shameer Kolothum wrote:
>>> Get ACPI IORT RMR regions associated with a dev reserved
>>> so that there is a unity mapping for them in SMMU.
>>
>> This feels like most of it belongs in the IORT code rather than
>> iommu-dma (which should save the temporary list copy as well).
> 
> See previous comment.  The original intent was for device-tree to also
> be able to use these mechanisms to create RMR's and support them
> in the SMMU.

Can you clarify how code behind an "if (!is_of_node(...))" check 
alongside other IORT-specific code is expected to be useful for DT?

Yes, iommu_dma_get_resv_regions() itself wants to end up serving as an 
abstraction layer, but that still doesn't mean it has to do much more 
than dispatch into firmware-specific backends as appropriate.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
