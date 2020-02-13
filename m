Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317BCC3B18B
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 15:50:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F54020661
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 15:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F54020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B853D2048E;
	Thu, 13 Feb 2020 15:50:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsGvr3uOhiUp; Thu, 13 Feb 2020 15:50:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AA91A2001C;
	Thu, 13 Feb 2020 15:50:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0997C08A4;
	Thu, 13 Feb 2020 15:50:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26777C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 15:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1532C87DAF
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 15:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ar9lk8Pt4Mn9 for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 15:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BC12687D5E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 15:49:58 +0000 (UTC)
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 030678FC6DCF329403B6;
 Thu, 13 Feb 2020 15:49:55 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Feb 2020 15:49:54 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 13 Feb
 2020 15:49:53 +0000
Subject: Re: arm64 iommu groups issue
From: John Garry <john.garry@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>, "Will
 Deacon" <will@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, "Guohanjun (Hanjun Guo)"
 <guohanjun@huawei.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
 <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
 <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
Message-ID: <ddc7eaff-c3f9-4304-9b4e-75eff2c66cd5@huawei.com>
Date: Thu, 13 Feb 2020 15:49:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Saravana Kannan <saravanak@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 iommu <iommu@lists.linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>,
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

>>
>> The underlying issue is that, for historical reasons, OF/IORT-based
>> IOMMU drivers have ended up with group allocation being tied to endpoint
>> driver probing via the dma_configure() mechanism (long story short,
>> driver probe is the only thing which can be delayed in order to wait for
>> a specific IOMMU instance to be ready).However, in the meantime, the
>> IOMMU API internals have evolved sufficiently that I think there's a way
>> to really put things right - I have the spark of an idea which I'll try
>> to sketch out ASAP...
>>
> 
> OK, great.

Hi Robin,

I was wondering if you have had a chance to consider this problem again?

One simple idea could be to introduce a device link between the endpoint 
device and its parent bridge to ensure that they probe in order, as 
expected in pci_device_group():

Subject: [PATCH] PCI: Add device link to ensure endpoint device driver 
probes after bridge

It is required to ensure that a device driver for an endpoint will probe
after the parent port driver, so add a device link for this.

---
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312ddd..4b832ad25b20 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2383,6 +2383,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
  {
  	int ret;
+	struct device *parent;

  	pci_configure_device(dev);

@@ -2420,6 +2421,10 @@ void pci_device_add(struct pci_dev *dev, struct 
pci_bus *bus)
  	/* Set up MSI IRQ domain */
  	pci_set_msi_domain(dev);

+	parent = dev->dev.parent;
+	if (parent && parent->bus == &pci_bus_type)
+		device_link_add(&dev->dev, parent, DL_FLAG_AUTOPROBE_CONSUMER);
+
  	/* Notifier could use PCI capabilities */
  	dev->match_driver = false;
  	ret = device_add(&dev->dev);
-- 

This would work, but the problem is that if the port driver fails in 
probing - and not just for -EPROBE_DEFER - then the child device will 
never probe. This very thing happens on my dev board. However we could 
expand the device links API to cover this sort of scenario.

As for alternatives, it looks pretty difficult to me to disassociate the 
group allocation from the dma_configure path.

Let me know.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
