Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653CAC47082
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 12:58:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B8060C41
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 12:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B8060C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0E71605CC;
	Mon,  7 Jun 2021 12:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WdH-y8TpNDxH; Mon,  7 Jun 2021 12:58:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB30A605FA;
	Mon,  7 Jun 2021 12:58:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83D24C000D;
	Mon,  7 Jun 2021 12:58:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16599C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 12:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F325640360
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 12:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Xq6S46pH06r for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 12:58:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9917740320
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 12:58:17 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzCyj1nQbzYsb8;
 Mon,  7 Jun 2021 20:55:25 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 20:58:13 +0800
Received: from [10.174.185.226] (10.174.185.226) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 20:58:12 +0800
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20210604190430.GA2220179@bjorn-Precision-5520>
From: Xingang Wang <wangxingang5@huawei.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
Message-ID: <7cd2f48a-8cb5-d290-7187-267d92e9a595@huawei.com>
Date: Mon, 7 Jun 2021 20:58:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210604190430.GA2220179@bjorn-Precision-5520>
Content-Language: en-US
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Cc: xieyingtai@huawei.com, robh@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-pci@vger.kernel.org, will@kernel.org
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

On 2021/6/5 3:04, Bjorn Helgaas wrote:
> [+cc John, who tested 6bf6c24720d3]
> 
> On Fri, May 21, 2021 at 03:03:24AM +0000, Wang Xingang wrote:
>> From: Xingang Wang <wangxingang5@huawei.com>
>>
>> When booting with devicetree, the pci_request_acs() is called after the
>> enumeration and initialization of PCI devices, thus the ACS is not
>> enabled. And ACS should be enabled when IOMMU is detected for the
>> PCI host bridge, so add check for IOMMU before probe of PCI host and call
>> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
>> devices.
> 
> I'm happy to apply this, but I'm a little puzzled about 6bf6c24720d3
> ("iommu/of: Request ACS from the PCI core when configuring IOMMU
> linkage").  It was tested and fixed a problem, but I don't understand
> how.
> 
> 6bf6c24720d3 added the call to pci_request_acs() in
> of_iommu_configure() so it currently looks like this:
> 
>    of_iommu_configure(dev, ...)
>    {
>      if (dev_is_pci(dev))
>        pci_request_acs();
> 
> pci_request_acs() sets pci_acs_enable, which tells us to enable ACS
> when enumerating PCI devices in the future.  But we only call
> pci_request_acs() if we already *have* a PCI device.
> 
> So maybe 6bf6c24720d3 fixed a problem for *some* PCI devices, but not
> all?  E.g., did we call of_iommu_configure() for one PCI device before
> enumerating the rest?
> 
I test the kernel on an arm platform with qemu:

qemu-system-aarch64 \
  -cpu host \
  -kernel arch/arm64/boot/Image \
  -enable-kvm \
  -m 8G \
  -smp 2,sockets=2,cores=1,threads=1 	\
  -machine virt,kernel_irqchip=on,gic-version=3,iommu=smmuv3\
  -initrd rootfs.cpio.gz \
  -nographic \
  -append "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 nokaslr" \
  -device pcie-root-port,port=0x1,chassis=1,id=pci.1,addr=0x8 \
  -netdev user,id=hostnet0 \
  -device 
virtio-net-pci,netdev=hostnet0,id=net0,mac=08:13:3a:5a:22:5b,bus=pci.1,addr=0x0 
\

And find that the of_iommu_configure is called after the enumeration
of the pcie-root-port. And this might only infect the first device, when 
enumerating
the rest devices, the pci_acs_enable has already be enabled.

But to make sure that the pci_acs_enable will always be set before all 
PCI devices,
it would be better to set it in initialization of PCI bridges.

Thanks

Xingang

>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>> configuring IOMMU linkage")
>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
>> ---
>>   drivers/iommu/of_iommu.c | 1 -
>>   drivers/pci/of.c         | 8 +++++++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index a9d2df001149..54a14da242cc 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>   			.np = master_np,
>>   		};
>>   
>> -		pci_request_acs();
>>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>>   					     of_pci_iommu_init, &info);
>>   	} else {
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index da5b414d585a..2313c3f848b0 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>>   
>>   int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>>   {
>> -	if (!dev->of_node)
>> +	struct device_node *node = dev->of_node;
>> +
>> +	if (!node)
>>   		return 0;
>>   
>> +	/* Detect IOMMU and make sure ACS will be enabled */
>> +	if (of_property_read_bool(node, "iommu-map"))
>> +		pci_request_acs();
>> +
>>   	bridge->swizzle_irq = pci_common_swizzle;
>>   	bridge->map_irq = of_irq_parse_and_map_pci;
>>   
>> -- 
>> 2.19.1
>>
> .
> 

.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
