Return-Path: <SRS0=AOw0=DX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AAEC433DF
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 07:34:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CC620848
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 07:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CC620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4FA0C888CA;
	Fri, 16 Oct 2020 07:34:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oWT7tP7FIEWC; Fri, 16 Oct 2020 07:34:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B8171888D2;
	Fri, 16 Oct 2020 07:34:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C67EC0052;
	Fri, 16 Oct 2020 07:34:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E4D1C0051
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 07:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2E02B2E3E9
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 07:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VvANixWmqLmz for <iommu@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 07:34:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by silver.osuosl.org (Postfix) with ESMTPS id 39E452E352
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 07:34:27 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C7DCF20730CFDFF190F3;
 Fri, 16 Oct 2020 15:34:21 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 15:34:11 +0800
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
From: Hanjun Guo <guohanjun@huawei.com>
To: Ard Biesheuvel <ardb@kernel.org>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de>
 <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
 <20201015180340.GB2624@gaia>
 <35faab1c-5c32-6cd3-0a14-77057dd223f5@huawei.com>
 <CAMj1kXFzYbr_mYm-zhsio2XV+KGgDBjtgy_NWNYnanyfU-U-Nw@mail.gmail.com>
 <89ed58a5-b3ca-e361-94d8-b6754ce5eb34@huawei.com>
Message-ID: <6efd3623-e758-30a7-b798-c06a624bed4e@huawei.com>
Date: Fri, 16 Oct 2020 15:34:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <89ed58a5-b3ca-e361-94d8-b6754ce5eb34@huawei.com>
Content-Language: en-GB
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Linuxarm <linuxarm@huawei.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
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

On 2020/10/16 15:27, Hanjun Guo wrote:
>> The patch only takes the address limit field into account if its value 
>> > 0.
> 
> Sorry I missed the if (*->memory_address_limit) check, thanks
> for the reminding.
> 
>>
>> Also, before commit 7fb89e1d44cb6aec ("ACPI/IORT: take _DMA methods
>> into account for named components"), the _DMA method was not taken
>> into account for named components at all, and only the IORT limit was
>> used, so I do not anticipate any problems with that.
> 
> Then this patch is fine to me.

Certainly we need to address Lorenzo's comments.

Thanks
Hanjun
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
