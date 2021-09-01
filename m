Return-Path: <SRS0=1qmC=NX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F9C432BE
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 09:58:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B790760F23
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 09:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B790760F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83E618249C;
	Wed,  1 Sep 2021 09:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gpENCWvXwj0V; Wed,  1 Sep 2021 09:58:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3B3CF8249B;
	Wed,  1 Sep 2021 09:58:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08543C001A;
	Wed,  1 Sep 2021 09:58:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A78CC000E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 09:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1B1E8249C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 09:58:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dAnHNM8fbNGh for <iommu@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 09:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECE8C8249B
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 09:58:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 176E61042;
 Wed,  1 Sep 2021 02:58:36 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A5AC3F766;
 Wed,  1 Sep 2021 02:58:34 -0700 (PDT)
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Wang Xingang <wangxingang5@huawei.com>, robh@kernel.org, will@kernel.org,
 joro@8bytes.org, helgaas@kernel.org
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
 <CGME20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2@eucas1p2.samsung.com>
 <01314d70-41e6-70f9-e496-84091948701a@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f3087045-1f0e-aa1a-d3f7-9e88bccca925@arm.com>
Date: Wed, 1 Sep 2021 10:58:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <01314d70-41e6-70f9-e496-84091948701a@samsung.com>
Content-Language: en-GB
Cc: xieyingtai@huawei.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-pci@vger.kernel.org,
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

On 2021-09-01 09:59, Marek Szyprowski wrote:
> On 21.05.2021 05:03, Wang Xingang wrote:
>> From: Xingang Wang <wangxingang5@huawei.com>
>>
>> When booting with devicetree, the pci_request_acs() is called after the
>> enumeration and initialization of PCI devices, thus the ACS is not
>> enabled. And ACS should be enabled when IOMMU is detected for the
>> PCI host bridge, so add check for IOMMU before probe of PCI host and call
>> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
>> devices.
>>
>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>> configuring IOMMU linkage")
>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> 
> This patch landed in linux-next as commit 57a4ab1584e6 ("iommu/of: Fix
> pci_request_acs() before enumerating PCI devices"). Sadly it breaks PCI
> operation on ARM Juno R1 board (arch/arm64/boot/dts/arm/juno-r1.dts). It
> looks that the IOMMU controller is not probed for some reasons:
> 
> # cat /sys/kernel/debug/devices_deferred
> 2b600000.iommu

That IOMMU belongs to the CoreSight debug subsystem and often gets stuck 
waiting for a power domain (especially if you have a mismatch of 
SCPI/SCMI expectations between the DT and SCP firmware). Unless you're 
trying to use CoreSight trace that shouldn't matter.

The PCIe on Juno doesn't support ACS anyway, so I'm puzzled why this 
should make any difference :/

Robin.

> Reverting this patch on top of current linux-next fixes this issue. If
> you need more information to debug this issue, just let me know.
> 
>> ---
>>    drivers/iommu/of_iommu.c | 1 -
>>    drivers/pci/of.c         | 8 +++++++-
>>    2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index a9d2df001149..54a14da242cc 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>    			.np = master_np,
>>    		};
>>    
>> -		pci_request_acs();
>>    		err = pci_for_each_dma_alias(to_pci_dev(dev),
>>    					     of_pci_iommu_init, &info);
>>    	} else {
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index da5b414d585a..2313c3f848b0 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>>    
>>    int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>>    {
>> -	if (!dev->of_node)
>> +	struct device_node *node = dev->of_node;
>> +
>> +	if (!node)
>>    		return 0;
>>    
>> +	/* Detect IOMMU and make sure ACS will be enabled */
>> +	if (of_property_read_bool(node, "iommu-map"))
>> +		pci_request_acs();
>> +
>>    	bridge->swizzle_irq = pci_common_swizzle;
>>    	bridge->map_irq = of_irq_parse_and_map_pci;
>>    
> 
> Best regards
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
