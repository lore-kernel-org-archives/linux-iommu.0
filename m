Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF87EC3F2CD
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 08:56:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB8720870
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 08:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KsRdTwPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB8720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3E39720437;
	Wed,  4 Mar 2020 08:56:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bGD3J3CITiFS; Wed,  4 Mar 2020 08:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2D548203A7;
	Wed,  4 Mar 2020 08:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10994C089F;
	Wed,  4 Mar 2020 08:56:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1A71C013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 08:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CF60385582
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 08:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id clKrakbte2+h for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 08:56:12 +0000 (UTC)
X-Greylist: delayed 18:21:05 by SQLgrey-1.7.6
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130079.outbound.protection.outlook.com [40.107.13.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9333B84798
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 08:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUgZMusfvAbvTqFjvOcocNw6Ck/jZEX0vhSY0DRGnGumq0bSjKyw7CTrLE0eXygR5d2T+C/7NRD98mJ9piofeImkEBn7iPZ9Fj4xGn4mp9OGCjvBAk7jBWE52+JxD08/gA3rwf7eP3p+VxqI0XDqArGqtFOyeanwAMmH2uRIa962RH8hUYV+M2ay0QbdxWwSH9MpX9vUaLDs4bhut07CQ6cnV7kcflx7Um9BbeQoEAPUX3zpjhGMuLHG+/a6JPME1utYL490Iw0a/gPC1+UlwifpLzRRqUO5sTotNu93LuIdqnBoeXqaMRcMbbwPYfsAkOUT84pjtLr1rkatdZBM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9kXjfmBZKWI2iw1onmaV9c+iDhEW/74vScuTGCwFI8=;
 b=XWigVxrnvEMQiia7ywGChwh/YgjUfFn5C9mZpQQb/I7J3o+3qMRWeqZQWLyMkT53obBmTYSThduhxjUIWA46dGzhsbclxj5arHBQ+cWCge3qxi9cSLDOXB/3AOr/0M7pA+1IjdhfCzNQMFYNl7Iu8eISw7LoXi1A25esbZVKWr/4I/FPUqnMeSlk5U7rNlRstUhGSs4H1J4QwHdvJMIuPxCnyZTf47WfxooXrc8h8pfVhdZZKzB94Y+bf5rmRJog6aLlXgaTAnGcKHNHkv2DE1IUE6tcgZLtloXJJ1bPukqW6NQmmtzsKVrIv5/584S2CTp/urb72WV0+oX1yL/+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9kXjfmBZKWI2iw1onmaV9c+iDhEW/74vScuTGCwFI8=;
 b=KsRdTwPGsipc3lmMp44ywNuBvLE3FWD0AHCu1rPSpbgHH1lNn9mAl4KUU4ycirRb8fDQjr0uolzrzlXSk06goBlUtru9q4Ls//URjTuMh4eQI1bkeZhcWEoMMtNQjatMrpR3HwE9WtQpJDonV5CAFt3l2HjtG7Onz/RFqQmGvC8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com (52.132.213.205) by
 AM0PR04MB5364.eurprd04.prod.outlook.com (20.178.116.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 08:56:08 +0000
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528]) by AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 08:56:08 +0000
Subject: Re: [PATCH] iommu: silence iommu group prints
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <E1j7Hnc-0004Bm-Kn@rmk-PC.armlinux.org.uk>
 <f0fc4c8c-4475-e77f-da6d-e068e7993568@linux.intel.com>
 <b4029a97-ac80-484f-9d01-d7f4eb174cdd@huawei.com>
 <20200228100644.GT25745@shell.armlinux.org.uk>
 <95af8fc3-d7b1-3b58-afc1-d203d7538b95@arm.com>
 <bcb9fbab-2943-3207-b69d-e7ce9e3e3a8e@nxp.com>
 <20200303154959.GR25745@shell.armlinux.org.uk>
 <ac9dc4b1-e3a4-2b69-7c61-d94e082cef30@nxp.com>
 <20200303221745.GV25745@shell.armlinux.org.uk>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <62b3d48a-af5f-b44b-07cd-83aa7663c45f@nxp.com>
Date: Wed, 4 Mar 2020 10:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200303221745.GV25745@shell.armlinux.org.uk>
Content-Type: multipart/mixed; boundary="------------8CD201A0B064CDDCE3F466E1"
Content-Language: en-US
X-ClientProxiedBy: AM0PR0402CA0036.eurprd04.prod.outlook.com
 (2603:10a6:208:15::49) To AM0PR04MB6897.eurprd04.prod.outlook.com
 (2603:10a6:208:184::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.171.82.13] (89.37.124.34) by
 AM0PR0402CA0036.eurprd04.prod.outlook.com (2603:10a6:208:15::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Wed, 4 Mar 2020 08:56:07 +0000
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fab28ba5-d416-4940-35d8-08d7c019e10b
X-MS-TrafficTypeDiagnostic: AM0PR04MB5364:|AM0PR04MB5364:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB53646006A722C9D8264B7D5AECE50@AM0PR04MB5364.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(66476007)(66576008)(2906002)(16526019)(66946007)(478600001)(6486002)(31686004)(8936002)(31696002)(66556008)(33964004)(86362001)(4326008)(52116002)(81156014)(81166006)(8676002)(186003)(26005)(54906003)(6916009)(16576012)(53546011)(235185007)(956004)(36756003)(44832011)(2616005)(316002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5364;
 H:AM0PR04MB6897.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3s16c1Esfev18IPma4C/weB3jxuTp5p/eF05klEE2wbGlBVTjyjGjMYFVTUO4zT3x/YGp2CKrsTLxOVqsrVxRdk8+w38gVWs7ncmYg/ETN8mSOr92GYJBitOy894cEYnVAw0umv/iP7G+/V81QvGq/zTC5xlYNY/+KDs3kUS73LUYv0RioYRnUwxoi6J3USC8n3wQJS1OztmxruqG5huh/lcjsubG2YgYfT2CloZA1T8LfLIZWnho2fBilIkeozUUwdDqVwUN+LE8Jzb6DMLpqi6xoSqdbgpXKxMuhUt+Ho8o6k/PDExNzuFlcz/RA7cP1US3arYONnWM5JHEMtsdzgT5kpHpCimRV34COWmxXA8BMK7H+AHofoZgCVo+O0+6uoBnVJc1QTo+y5yBMJPqK4sYwW9CeIsyvAEkavLoTfUeygnKakWAynEMBcLuXg8
X-MS-Exchange-AntiSpam-MessageData: G9WLOdn9ErMOScFlJolpXNum/461+f1PwsP2MqsWFVA3nM0HWac1Cr17Ei0C8hoQWsB1Z7V9eCIcMq/VeI32kljwbtmlzB1KdrEV+eId1G5+p7ATkqhgyH/ABpHHmrCFcBOKN8nHCzPsgDSF8gvx7A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab28ba5-d416-4940-35d8-08d7c019e10b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 08:56:08.0967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5JPcxVeEEUi9jpucKsnIbKu/61nMoA8itY2Gf8VoQUXPXrpIzr+9yUmhKjvM7RREKKUCABzjrgV+3k3OTJFgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5364
Cc: Diana Madalina Craciun <diana.craciun@nxp.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--------------8CD201A0B064CDDCE3F466E1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04.03.2020 00:17, Russell King - ARM Linux admin wrote:
> On Tue, Mar 03, 2020 at 05:55:05PM +0200, Laurentiu Tudor wrote:
>>  From c98dc05cdd45ae923654f2427985bd28bcde4bb2 Mon Sep 17 00:00:00 2001
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Date: Thu, 13 Feb 2020 11:59:12 +0200
>> Subject: [PATCH 1/4] bus: fsl-mc: add custom .dma_configure implementation
>> Content-Type: text/plain; charset="us-ascii"
>>
>> The devices on this bus are not discovered by way of device tree
>> but by queries to the firmware. It makes little sense to trick the
>> generic of layer into thinking that these devices are of related so
>> that we can get our dma configuration. Instead of doing that, add
>> our custom dma configuration implementation.
> 
> Firstly, applying this to v5.5 results in a build failure, due to a
> missing linux/iommu.h include.
> 
> Secondly, this on its own appears to make the DPAA2 network interfaces
> completely disappear.  Looking in /sys/bus/fsl-mc/drivers/*, none of
> the DPAA2 drivers are bound to anything, and looking in
> /sys/bus/fsl-mc/devices/, there is:
> 
> lrwxrwxrwx 1 root root 0 Mar  3 22:06 dprc.1 -> ../../../devices/platform/soc/80c000000.fsl-mc/dprc.1
> 
> This is booting with u-boot, so using DT rather than ACPI.
> 
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>>   drivers/bus/fsl-mc/fsl-mc-bus.c | 42 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> index 36eb25f82c8e..3df015eedae4 100644
>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> @@ -132,11 +132,51 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   static int fsl_mc_dma_configure(struct device *dev)
>>   {
>>   	struct device *dma_dev = dev;
>> +	struct iommu_fwspec *fwspec;
>> +	const struct iommu_ops *iommu_ops;
>> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
>> +	int ret;
>> +	u32 icid;
>> +
>> +	/* Skip DMA setup for devices that are not DMA masters */
>> +	if (dev->type == &fsl_mc_bus_dpmcp_type ||
>> +	    dev->type == &fsl_mc_bus_dpbp_type ||
>> +	    dev->type == &fsl_mc_bus_dpcon_type ||
>> +	    dev->type == &fsl_mc_bus_dpio_type)
>> +		return 0;
>>   
>>   	while (dev_is_fsl_mc(dma_dev))
>>   		dma_dev = dma_dev->parent;
>>   
>> -	return of_dma_configure(dev, dma_dev->of_node, 0);
>> +	fwspec = dev_iommu_fwspec_get(dma_dev);
>> +	if (!fwspec)
>> +		return -ENODEV;
> 
> The problem appears to be here - fwspec is NULL for dprc.1.

Ok, that's because the iommu config is missing from the DT node that's 
exposing the MC firmware. I've attached a fresh set of patches that 
include on top the missing config and a workaround that makes MC work 
over SMMU. Also added the missing #include, thanks for pointing out.
Let me know how it goes.

---
Best Regards, Laurentiu

--------------8CD201A0B064CDDCE3F466E1
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-bus-fsl-mc-add-custom-.dma_configure-implementation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-bus-fsl-mc-add-custom-.dma_configure-implementation.pat";
 filename*1="ch"

From 3d418f04fed9c10b64b3b861d66378a8f7514cc4 Mon Sep 17 00:00:00 2001
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Thu, 13 Feb 2020 11:59:12 +0200
Subject: [PATCH 1/6] bus: fsl-mc: add custom .dma_configure implementation
Content-Type: text/plain; charset="us-ascii"

The devices on this bus are not discovered by way of device tree
but by queries to the firmware. It makes little sense to trick the
generic of layer into thinking that these devices are of related so
that we can get our dma configuration. Instead of doing that, add
our custom dma configuration implementation.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 43 ++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index a0f8854acb3a..e2682fbefb42 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu.h>
 
 #include "fsl-mc-private.h"
 
@@ -130,11 +131,51 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 static int fsl_mc_dma_configure(struct device *dev)
 {
 	struct device *dma_dev = dev;
+	struct iommu_fwspec *fwspec;
+	const struct iommu_ops *iommu_ops;
+	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	int ret;
+	u32 icid;
+
+	/* Skip DMA setup for devices that are not DMA masters */
+	if (dev->type == &fsl_mc_bus_dpmcp_type ||
+	    dev->type == &fsl_mc_bus_dpbp_type ||
+	    dev->type == &fsl_mc_bus_dpcon_type ||
+	    dev->type == &fsl_mc_bus_dpio_type)
+		return 0;
 
 	while (dev_is_fsl_mc(dma_dev))
 		dma_dev = dma_dev->parent;
 
-	return of_dma_configure(dev, dma_dev->of_node, 0);
+	fwspec = dev_iommu_fwspec_get(dma_dev);
+	if (!fwspec)
+		return -ENODEV;
+	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
+	if (!iommu_ops)
+		return -ENODEV;
+
+	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
+	if (ret)
+		return ret;
+
+	icid = mc_dev->icid;
+	ret = iommu_fwspec_add_ids(dev, &icid, 1);
+	if (ret) {
+		iommu_fwspec_free(dev);
+		return ret;
+	}
+
+	if (!device_iommu_mapped(dev)) {
+		ret = iommu_probe_device(dev);
+		if (ret) {
+			iommu_fwspec_free(dev);
+			return ret;
+		}
+	}
+
+	arch_setup_dma_ops(dev, 0, *dma_dev->dma_mask + 1, iommu_ops, true);
+
+	return 0;
 }
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
-- 
2.17.1


--------------8CD201A0B064CDDCE3F466E1
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-irqchip-fsl-mc-Change-the-way-the-IRQ-domain-is-set-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-irqchip-fsl-mc-Change-the-way-the-IRQ-domain-is-set-.pa";
 filename*1="tch"

From 8b7576f002fab8471e907621a4debbdfb5635101 Mon Sep 17 00:00:00 2001
From: Diana Craciun <diana.craciun@oss.nxp.com>
Date: Fri, 14 Feb 2020 16:28:45 +0200
Subject: [PATCH 2/6] irqchip/fsl-mc: Change the way the IRQ domain is set for
 MC devices
Content-Type: text/plain; charset="us-ascii"

In ACPI the MC bus is represented as a platform device and a named
component in the IORT table. The mc-bus devices are discovered
dynamically at runtime but they share the same fwnode with the parent
platfom device. This patch changes the way the IRQ domain is searched
for the MC devices: it takes the fwnode reference from the parent and
uses the fwnode reference to find the MC IRQ domain.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 8b9c66d7c4ff..1e2e97329781 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -182,16 +182,23 @@ int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
 {
 	struct irq_domain *msi_domain;
 	struct device_node *mc_of_node = mc_platform_dev->of_node;
+	struct fwnode_handle *fwnode;
 
-	msi_domain = of_msi_get_domain(mc_platform_dev, mc_of_node,
-				       DOMAIN_BUS_FSL_MC_MSI);
+	msi_domain = dev_get_msi_domain(mc_platform_dev);
 	if (!msi_domain) {
 		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
 		       mc_of_node);
 
 		return -ENOENT;
 	}
+	fwnode = msi_domain->fwnode;
+	msi_domain = irq_find_matching_fwnode(fwnode, DOMAIN_BUS_FSL_MC_MSI);
+	if (!msi_domain) {
+		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
+		       mc_of_node);
 
+		return -ENOENT;
+	}
 	*mc_msi_domain = msi_domain;
 	return 0;
 }
-- 
2.17.1


--------------8CD201A0B064CDDCE3F466E1
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-bus-fsl-mc-Add-ACPI-support-for-fsl-mc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0003-bus-fsl-mc-Add-ACPI-support-for-fsl-mc.patch"

From f63813721d58059ee52b38bdd5b584694e9205cd Mon Sep 17 00:00:00 2001
From: Makarand Pawagi <makarand.pawagi@nxp.com>
Date: Thu, 23 Jan 2020 10:48:42 +0530
Subject: [PATCH 3/6] bus: fsl-mc: Add ACPI support for fsl-mc
Content-Type: text/plain; charset="us-ascii"

ACPI support is added in the fsl-mc driver. Driver will parse
MC DSDT table to extract memory and other resorces.

Interrupt (GIC ITS) information will be extracted from MADT table
by drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.

IORT table will be parsed to configure DMA.

Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c             | 35 ++++++-----
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 69 ++++++++++++++++++++-
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index e2682fbefb42..485a70b7360d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -945,7 +945,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	phys_addr_t mc_portal_phys_addr;
 	u32 mc_portal_size;
 	struct mc_version mc_version;
-	struct resource res;
+	struct resource *plat_res;
 
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
@@ -956,16 +956,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	/*
 	 * Get physical address of MC portal for the root DPRC:
 	 */
-	error = of_address_to_resource(pdev->dev.of_node, 0, &res);
-	if (error < 0) {
-		dev_err(&pdev->dev,
-			"of_address_to_resource() failed for %pOF\n",
-			pdev->dev.of_node);
-		return error;
-	}
-
-	mc_portal_phys_addr = res.start;
-	mc_portal_size = resource_size(&res);
+	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mc_portal_phys_addr = plat_res->start;
+	mc_portal_size = resource_size(plat_res);
 	error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
 				 mc_portal_size, NULL,
 				 FSL_MC_IO_ATOMIC_CONTEXT_PORTAL, &mc_io);
@@ -982,11 +975,13 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
 		 mc_version.major, mc_version.minor, mc_version.revision);
 
-	error = get_mc_addr_translation_ranges(&pdev->dev,
-					       &mc->translation_ranges,
-					       &mc->num_translation_ranges);
-	if (error < 0)
-		goto error_cleanup_mc_io;
+	if (dev_of_node(&pdev->dev)) {
+		error = get_mc_addr_translation_ranges(&pdev->dev,
+						&mc->translation_ranges,
+						&mc->num_translation_ranges);
+		if (error < 0)
+			goto error_cleanup_mc_io;
+	}
 
 	error = dprc_get_container_id(mc_io, 0, &container_id);
 	if (error < 0) {
@@ -1013,6 +1008,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 		goto error_cleanup_mc_io;
 
 	mc->root_mc_bus_dev = mc_bus_dev;
+	mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
 	return 0;
 
 error_cleanup_mc_io:
@@ -1046,11 +1042,18 @@ static const struct of_device_id fsl_mc_bus_match_table[] = {
 
 MODULE_DEVICE_TABLE(of, fsl_mc_bus_match_table);
 
+static const struct acpi_device_id fsl_mc_bus_acpi_match_table[] = {
+	{"NXP0008", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, fsl_mc_bus_acpi_match_table);
+
 static struct platform_driver fsl_mc_bus_driver = {
 	.driver = {
 		   .name = "fsl_mc_bus",
 		   .pm = NULL,
 		   .of_match_table = fsl_mc_bus_match_table,
+		   .acpi_match_table = fsl_mc_bus_acpi_match_table,
 		   },
 	.probe = fsl_mc_bus_probe,
 	.remove = fsl_mc_bus_remove,
diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 606efa64adff..6d67834722c9 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -4,9 +4,11 @@
  *
  * Copyright (C) 2015-2016 Freescale Semiconductor, Inc.
  * Author: German Rivera <German.Rivera@freescale.com>
+ * Copyright 2020 NXP
  *
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/irq.h>
@@ -66,7 +68,65 @@ static const struct of_device_id its_device_id[] = {
 	{},
 };
 
-static int __init its_fsl_mc_msi_init(void)
+static int __init its_fsl_mc_msi_init_one(struct fwnode_handle *handle,
+					  const char *name)
+{
+	struct irq_domain *parent;
+	struct irq_domain *mc_msi_domain;
+
+	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		pr_err("%s: Unable to locate ITS domain\n", name);
+		return -ENXIO;
+	}
+
+	mc_msi_domain = fsl_mc_msi_create_irq_domain(handle,
+						     &its_fsl_mc_msi_domain_info,
+						     parent);
+	if (!mc_msi_domain)
+		pr_err("ACPIF: unable to create fsl-mc domain\n");
+
+	pr_info("fsl-mc MSI: domain created\n");
+
+	return 0;
+}
+
+static int __init
+its_fsl_mc_msi_parse_madt(union acpi_subtable_headers *header,
+			  const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *dom_handle;
+	const char *node_name;
+	int err = -ENXIO;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
+			      (long)its_entry->base_address);
+
+	dom_handle = iort_find_domain_token(its_entry->translation_id);
+	if (!dom_handle) {
+		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
+		goto out;
+	}
+
+	err = its_fsl_mc_msi_init_one(dom_handle, node_name);
+	if (!err)
+		pr_info("fsl-mc MSI: %s domain created\n", node_name);
+
+out:
+	kfree(node_name);
+	return err;
+}
+
+static int __init its_fsl_mc_acpi_msi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+			      its_fsl_mc_msi_parse_madt, 0);
+	return 0;
+}
+
+static int __init its_fsl_mc_of_msi_init(void)
 {
 	struct device_node *np;
 	struct irq_domain *parent;
@@ -100,4 +160,11 @@ static int __init its_fsl_mc_msi_init(void)
 	return 0;
 }
 
+static int __init its_fsl_mc_msi_init(void)
+{
+	its_fsl_mc_of_msi_init();
+	its_fsl_mc_acpi_msi_init();
+
+	return 0;
+}
 early_initcall(its_fsl_mc_msi_init);
-- 
2.17.1


--------------8CD201A0B064CDDCE3F466E1
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-iommu-of-get-rid-of-fsl-mc-specific-code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0004-iommu-of-get-rid-of-fsl-mc-specific-code.patch"

From 268e57107bcc31cec9722382326bd282985eb4c7 Mon Sep 17 00:00:00 2001
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Wed, 26 Feb 2020 17:31:49 +0200
Subject: [PATCH 4/6] iommu/of: get rid of fsl-mc specific code
Content-Type: text/plain; charset="us-ascii"

Changing the way we configure dma for fsl-mc devices allows
us to get rid of our fsl-mc specific code in the generic
of iommu code.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/iommu/of_iommu.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 20738aacac89..332072ada474 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -15,7 +15,6 @@
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
-#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -139,23 +138,6 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return err;
 }
 
-static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
-				struct device_node *master_np)
-{
-	struct of_phandle_args iommu_spec = { .args_count = 1 };
-	int err;
-
-	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
-			 "iommu-map-mask", &iommu_spec.np,
-			 iommu_spec.args);
-	if (err)
-		return err == -ENODEV ? NO_IOMMU : err;
-
-	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
-	of_node_put(iommu_spec.np);
-	return err;
-}
-
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -188,8 +170,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
-	} else if (dev_is_fsl_mc(dev)) {
-		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
2.17.1


--------------8CD201A0B064CDDCE3F466E1
Content-Type: text/x-patch; charset=UTF-8;
 name="0005-bus-fsl-mc-make-mc-work-with-smmu-disable-bypass-on.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0005-bus-fsl-mc-make-mc-work-with-smmu-disable-bypass-on.pat";
 filename*1="ch"

From 68abcd76ce8cd1c368a4b7ee45f72f02b80c33b3 Mon Sep 17 00:00:00 2001
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Tue, 1 Oct 2019 16:22:48 +0300
Subject: [PATCH 5/6] bus: fsl-mc: make mc work with smmu disable bypass on
Content-Type: text/plain; charset="us-ascii"

Since this commit [1] booting kernel on MC based chips started to
fail because this firmware starts before the kernel and as soon as
SMMU is probed it starts to trigger contiguous faults.
This is a workaround that allows MC firmware to run with SMMU
in disable bypass mode. It consists of the following steps:
 1. pause the firmware at early boot to get a chance to setup SMMU
 2. request direct mapping for MC device
 3. resume the firmware
The workaround relies on the fact that no state is lost when
pausing / resuming firmware, as per the docs.
With this patch, platforms with MC firmware can now boot without
having to change the default config to set:
  CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT=n

[1] 954a03be033 ("iommu/arm-smmu: Break insecure users by disabling bypass by default")

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 52 +++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 485a70b7360d..8a385df3e25c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -19,6 +19,7 @@
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
+#include <linux/io.h>
 
 #include "fsl-mc-private.h"
 
@@ -930,6 +931,12 @@ static int get_mc_addr_translation_ranges(struct device *dev,
 	return 0;
 }
 
+#define FSL_MC_GCR1	0x0
+#define GCR1_P1_STOP	BIT(31)
+
+static u32 boot_gcr1;
+static void __iomem *fsl_mc_regs;
+
 /**
  * fsl_mc_bus_probe - callback invoked when the root MC bus is being
  * added
@@ -947,6 +954,21 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	struct mc_version mc_version;
 	struct resource *plat_res;
 
+	/*
+	 * The MC firmware requires full access to the whole address space plus
+	 * it has no way of dealing with any kind of address translation, so
+	 * request direct mapping for it.
+	 */
+	error = iommu_request_dm_for_dev(&pdev->dev);
+	if (error)
+		dev_warn(&pdev->dev, "iommu_request_dm_for_dev() failed: %d\n",
+			 error);
+
+	if (fsl_mc_regs) {
+		/* Resume the firmware */
+		writel(boot_gcr1 & ~GCR1_P1_STOP, fsl_mc_regs + FSL_MC_GCR1);
+	}
+
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
 		return -ENOMEM;
@@ -1027,6 +1049,13 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
 	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
 		return -EINVAL;
 
+	/*
+	 * Pause back the firmware so that it doesn't trigger faults by the
+	 * time SMMU gets brought down.
+	 */
+	writel(boot_gcr1 | GCR1_P1_STOP, fsl_mc_regs + FSL_MC_GCR1);
+	iounmap(fsl_mc_regs);
+
 	fsl_mc_device_remove(mc->root_mc_bus_dev);
 
 	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
@@ -1062,6 +1091,8 @@ static struct platform_driver fsl_mc_bus_driver = {
 static int __init fsl_mc_bus_driver_init(void)
 {
 	int error;
+	struct device_node *np;
+	struct resource res;
 
 	error = bus_register(&fsl_mc_bus_type);
 	if (error < 0) {
@@ -1083,9 +1114,30 @@ static int __init fsl_mc_bus_driver_init(void)
 	if (error < 0)
 		goto error_cleanup_dprc_driver;
 
+	np = of_find_matching_node(NULL, fsl_mc_bus_match_table);
+	if (np && of_device_is_available(np)) {
+		error = of_address_to_resource(np, 1, &res);
+		if (error)
+			goto error_cleanup_dprc_driver;
+		fsl_mc_regs = ioremap(res.start, resource_size(&res));
+		if (!fsl_mc_regs) {
+			error = -ENXIO;
+			goto error_cleanup_dprc_driver;
+		}
+
+		boot_gcr1 = readl(fsl_mc_regs + FSL_MC_GCR1);
+		/*
+		 * If found running, pause MC firmware in order to get a chance
+		 * to setup SMMU for it.
+		 */
+		if (!(boot_gcr1 & GCR1_P1_STOP))
+			writel(boot_gcr1 | GCR1_P1_STOP,  fsl_mc_regs + FSL_MC_GCR1);
+	}
+
 	return 0;
 
 error_cleanup_dprc_driver:
+	iounmap(fsl_mc_regs);
 	dprc_driver_exit();
 
 error_cleanup_driver:
-- 
2.17.1


--------------8CD201A0B064CDDCE3F466E1
Content-Type: text/x-patch; charset=UTF-8;
 name="0006-arm64-dts-lx2160a-add-iommus-property-for-mc-node.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0006-arm64-dts-lx2160a-add-iommus-property-for-mc-node.patch"

From 20d7ad3cb903d834dbb281f77ffa9074ab7fe65b Mon Sep 17 00:00:00 2001
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Tue, 19 Nov 2019 17:01:39 +0200
Subject: [PATCH 6/6] arm64: dts: lx2160a: add iommus property for mc node
Content-Type: text/plain; charset="us-ascii"

Enable SMMU management for the MC firmware by adding the required
iommus property in the device tree node.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index aee2810d91cc..e9bf3f6e670a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -967,6 +967,7 @@
 			msi-parent = <&its>;
 			/* iommu-map property is fixed up by u-boot */
 			iommu-map = <0 &smmu 0 0>;
+			iommus = <&smmu 0x4000>;
 			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
-- 
2.17.1


--------------8CD201A0B064CDDCE3F466E1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------8CD201A0B064CDDCE3F466E1--
