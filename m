Return-Path: <SRS0=cE/7=NY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E605BC432BE
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 13:07:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F3196108B
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 13:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F3196108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 633794256B;
	Thu,  2 Sep 2021 13:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KvKUEBYmYrQx; Thu,  2 Sep 2021 13:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E404142559;
	Thu,  2 Sep 2021 13:07:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAB5BC001A;
	Thu,  2 Sep 2021 13:07:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 519D2C000E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 13:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41300614CF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 13:07:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I6as68RCUz2g for <iommu@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 13:07:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4004A606E6
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 13:07:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FBE51FB;
 Thu,  2 Sep 2021 06:07:19 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B0D3F5A1;
 Thu,  2 Sep 2021 06:07:17 -0700 (PDT)
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
To: Anders Roxell <anders.roxell@linaro.org>
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
 <CGME20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2@eucas1p2.samsung.com>
 <01314d70-41e6-70f9-e496-84091948701a@samsung.com>
 <f3087045-1f0e-aa1a-d3f7-9e88bccca925@arm.com>
 <CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <25b0b214-b9b4-4066-3912-a5bcb054dc0d@arm.com>
Date: Thu, 2 Sep 2021 14:07:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com>
Content-Language: en-GB
Cc: xieyingtai@huawei.com, Rob Herring <robh@kernel.org>,
 Wang Xingang <wangxingang5@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 helgaas@kernel.org, Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On 2021-09-02 13:51, Anders Roxell wrote:
> On Wed, 1 Sept 2021 at 11:58, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-09-01 09:59, Marek Szyprowski wrote:
>>> On 21.05.2021 05:03, Wang Xingang wrote:
>>>> From: Xingang Wang <wangxingang5@huawei.com>
>>>>
>>>> When booting with devicetree, the pci_request_acs() is called after the
>>>> enumeration and initialization of PCI devices, thus the ACS is not
>>>> enabled. And ACS should be enabled when IOMMU is detected for the
>>>> PCI host bridge, so add check for IOMMU before probe of PCI host and call
>>>> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
>>>> devices.
>>>>
>>>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>>>> configuring IOMMU linkage")
>>>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
>>>
>>> This patch landed in linux-next as commit 57a4ab1584e6 ("iommu/of: Fix
>>> pci_request_acs() before enumerating PCI devices"). Sadly it breaks PCI
>>> operation on ARM Juno R1 board (arch/arm64/boot/dts/arm/juno-r1.dts). It
> 
> We've seen this on ARM Juno R2 boards too in the Linaro testfarm.
> 
> The problem is that the device can't get the "SATA link up" while booting.
> 
> see https://lkft.validation.linaro.org/scheduler/job/3416767#L577

Hmm, what's odd there is that you don't seem to be even detecting any of 
the endpoints there. Notably, the switch (which both the slots and the 
on-board endpoints are behind) *does* support ACS even though the Root 
Complex doesn't, so I wonder if it's getting enabled there and causing 
it to forward TLPs with ACS bits set which the RC doesn't like?

I'm far from a PCI expert, but I might try running this patch on my 
board to see if anything else stands out.

Robin.

> When reverting this patch we are able to see the "SATA link up".
> 
> Cheers,
> Anders
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
