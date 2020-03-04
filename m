Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC9FC3F2CD
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 10:12:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5572E20848
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 10:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dSRV7c1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5572E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2DA2E1FF98;
	Wed,  4 Mar 2020 10:12:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Y06ORqBh02r; Wed,  4 Mar 2020 10:12:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 03C5220423;
	Wed,  4 Mar 2020 10:12:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE5FAC089F;
	Wed,  4 Mar 2020 10:12:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87603C013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 740E620423
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f8HUFnQL8n7l for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 10:12:35 +0000 (UTC)
X-Greylist: delayed 18:01:43 by SQLgrey-1.7.6
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
 by silver.osuosl.org (Postfix) with ESMTPS id B57A41FF98
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLYvFd0IbXBDhrjPdaaDY2EHTlzPlACFRojUGNU7w2Whb6LtYHCsI8MxIHnqq1lSicYQ951qPEWypv0sdo00yTAh9YT+s8MlROscw4O/IyMsEaVUoCpIi+rN7evxdZ3H1EBAZ+PFBWkVb1DwnAKEDosGI2bz6i7fQhfbIbII8ioa8oKWVA5FXhheJOpZmF9g161yhJxzzhp/O21ADFeTn81h+mT9ER/J2O5ztGAgZRiKgQNbJfjt9aZt7BkgdbmMtbM6pfD/i5P8r7OrrE/aFp6kfioNSI5bfBZ2y+RZ52zwj4DDIdUR4IGS+yO0R7NFdYXO+e93E5R5l/P5julLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkoP4L0icoJ4edAo87cgRWmy38i8Y0lPVS9Cru0qu8Y=;
 b=cVZgVnrdnJRMQKfUljF/AOYug72/MOCWwz8Nzjbnjtw89ZAqvmt6icjyhYHlsT0Y+YufyJ+U3wjbwwJMeXc/W1zESInqeMRC08UCWhxFUZ8t99910FTSwC38Y/ali/78IdJ1ZwT3/Hmh7rSodBU3QMFnYy2DDPUBv1hlMXOWgJYAkXEwUqCwwrJpouzRI4Dn8ZW82J1x5bI+9YU7tikd+H5fe+FEi2HbHNTzHlBcGge9bW9LMaDJ8JdeIBT2xeQJSo43cMvxcvWgCxOqJWf7OiJ7X/LM9EDfrL/OX8t0rbU7qz/4VFzJRGkWphibiMjUCQtjOWibyqg1nMyh0SYWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkoP4L0icoJ4edAo87cgRWmy38i8Y0lPVS9Cru0qu8Y=;
 b=dSRV7c1SwBwsYSFANYQG3eXhP4xEla5ahOSmMGvTGneUuVbC6QxNdRvZ0KSZQOHK/m3uVTDutzcI36U2XFGKeN6eyMNztozN9zG11esY37BCMbSm+q72VF8hhwjgLmsmsuzMW+gumSffWJ9k7pTrq/TYgikDAeJCsghAaVDkmQ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com (52.132.213.205) by
 AM0PR04MB4705.eurprd04.prod.outlook.com (20.176.214.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Wed, 4 Mar 2020 09:56:54 +0000
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528]) by AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 09:56:54 +0000
Subject: Re: [PATCH] iommu: silence iommu group prints
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <b4029a97-ac80-484f-9d01-d7f4eb174cdd@huawei.com>
 <20200228100644.GT25745@shell.armlinux.org.uk>
 <95af8fc3-d7b1-3b58-afc1-d203d7538b95@arm.com>
 <bcb9fbab-2943-3207-b69d-e7ce9e3e3a8e@nxp.com>
 <20200303154959.GR25745@shell.armlinux.org.uk>
 <ac9dc4b1-e3a4-2b69-7c61-d94e082cef30@nxp.com>
 <20200303221745.GV25745@shell.armlinux.org.uk>
 <62b3d48a-af5f-b44b-07cd-83aa7663c45f@nxp.com>
 <20200304093330.GX25745@shell.armlinux.org.uk>
 <78f175be-0701-b6cd-8feb-1343f9982d4c@nxp.com>
 <20200304095112.GY25745@shell.armlinux.org.uk>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <b9f4e9ad-033f-b5cf-9578-38f8367ef8cd@nxp.com>
Date: Wed, 4 Mar 2020 11:56:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200304095112.GY25745@shell.armlinux.org.uk>
Content-Type: multipart/mixed; boundary="------------015B7DA56638A6B39ED7F2A6"
Content-Language: en-US
X-ClientProxiedBy: AM6PR10CA0059.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::36) To AM0PR04MB6897.eurprd04.prod.outlook.com
 (2603:10a6:208:184::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.171.82.13] (89.37.124.34) by
 AM6PR10CA0059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 09:56:54 +0000
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0378382e-525c-4a58-1987-08d7c0225eb2
X-MS-TrafficTypeDiagnostic: AM0PR04MB4705:|AM0PR04MB4705:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4705851E91E1BB1B7107E48EECE50@AM0PR04MB4705.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(54906003)(6486002)(235185007)(31686004)(16526019)(16576012)(8936002)(52116002)(316002)(33964004)(186003)(2906002)(5660300002)(44832011)(8676002)(81156014)(2616005)(81166006)(86362001)(956004)(4326008)(66946007)(31696002)(36756003)(66476007)(26005)(478600001)(66576008)(6916009)(53546011)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4705;
 H:AM0PR04MB6897.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtuAWvevfjKKKsD/iAH58fi4JCYyRk8xiiuKAFl5ZSQLfdprCRUuq8o+pHD4IgdzfkdU5D9MHFPexjiIigeNm6l+Xgq6Yl+/ysgFBcoslmvk6h93I8HRQDfXq1xh6lCWNUAWIwFdNMh795umJzhwh0+AYis4iV1e/RKhgWc9s0MT2MrYV8uIT3dkSvR29hIahp2CJC9JN9n4YGIfuOOYbb302dVdjtWq0KzLD4wR9g5cvT7Roa6Q2X6Hg0Rp+ECGOuJpDJg5/zoNb8mKPETeEUh5Gk8E6qJFxhTlDBw3R6eZvbLDGdSnPsIfdDV8sanQIE/2WuyL3mMa/lmYyun/qcjTkAWalKWj9kLmoIxlkD1rZpGA1UAU0H/sdQLEzg1Ff9N5+916g3LPIwXJ/gC1eUyWly2oKdUeML1D4AW3H9RLaR7pUaUXIPXy51JSwIec
X-MS-Exchange-AntiSpam-MessageData: K9ra3woPm7/P6fii0633KilzDGjlG8Y/YLWls0N+p7hU4urB1yjpfWvwkGbjrW86HZo5bTya75E0cfT6QrEkHEEr8vFq8ZKpWTRU8Hnt12Ul8+K0yc1mnWfwG2WCwk0ZjGfPomTiH077TBWVDFoF2A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0378382e-525c-4a58-1987-08d7c0225eb2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 09:56:54.8038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuDydPGEcmsR0W4qKUtJkhdMt5OjXNUVjiNdHONB/ts+O2MwmQ3BMeN1BCtJqReZaNn9zST0sIhRCflwYP2GBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4705
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

--------------015B7DA56638A6B39ED7F2A6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04.03.2020 11:51, Russell King - ARM Linux admin wrote:
> On Wed, Mar 04, 2020 at 11:42:16AM +0200, Laurentiu Tudor wrote:
>> On 04.03.2020 11:33, Russell King - ARM Linux admin wrote:
>>> On Wed, Mar 04, 2020 at 10:56:06AM +0200, Laurentiu Tudor wrote:
>>>>
>>>> On 04.03.2020 00:17, Russell King - ARM Linux admin wrote:
>>>>> On Tue, Mar 03, 2020 at 05:55:05PM +0200, Laurentiu Tudor wrote:
>>>>>>    From c98dc05cdd45ae923654f2427985bd28bcde4bb2 Mon Sep 17 00:00:00 2001
>>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>> Date: Thu, 13 Feb 2020 11:59:12 +0200
>>>>>> Subject: [PATCH 1/4] bus: fsl-mc: add custom .dma_configure implementation
>>>>>> Content-Type: text/plain; charset="us-ascii"
>>>>>>
>>>>>> The devices on this bus are not discovered by way of device tree
>>>>>> but by queries to the firmware. It makes little sense to trick the
>>>>>> generic of layer into thinking that these devices are of related so
>>>>>> that we can get our dma configuration. Instead of doing that, add
>>>>>> our custom dma configuration implementation.
>>>>>
>>>>> Firstly, applying this to v5.5 results in a build failure, due to a
>>>>> missing linux/iommu.h include.
>>>>>
>>>>> Secondly, this on its own appears to make the DPAA2 network interfaces
>>>>> completely disappear.  Looking in /sys/bus/fsl-mc/drivers/*, none of
>>>>> the DPAA2 drivers are bound to anything, and looking in
>>>>> /sys/bus/fsl-mc/devices/, there is:
>>>>>
>>>>> lrwxrwxrwx 1 root root 0 Mar  3 22:06 dprc.1 -> ../../../devices/platform/soc/80c000000.fsl-mc/dprc.1
>>>>>
>>>>> This is booting with u-boot, so using DT rather than ACPI.
>>>>>
>>>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>> ---
>>>>>>     drivers/bus/fsl-mc/fsl-mc-bus.c | 42 ++++++++++++++++++++++++++++++++-
>>>>>>     1 file changed, 41 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>>> index 36eb25f82c8e..3df015eedae4 100644
>>>>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>>> @@ -132,11 +132,51 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>>>>>>     static int fsl_mc_dma_configure(struct device *dev)
>>>>>>     {
>>>>>>     	struct device *dma_dev = dev;
>>>>>> +	struct iommu_fwspec *fwspec;
>>>>>> +	const struct iommu_ops *iommu_ops;
>>>>>> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
>>>>>> +	int ret;
>>>>>> +	u32 icid;
>>>>>> +
>>>>>> +	/* Skip DMA setup for devices that are not DMA masters */
>>>>>> +	if (dev->type == &fsl_mc_bus_dpmcp_type ||
>>>>>> +	    dev->type == &fsl_mc_bus_dpbp_type ||
>>>>>> +	    dev->type == &fsl_mc_bus_dpcon_type ||
>>>>>> +	    dev->type == &fsl_mc_bus_dpio_type)
>>>>>> +		return 0;
>>>>>>     	while (dev_is_fsl_mc(dma_dev))
>>>>>>     		dma_dev = dma_dev->parent;
>>>>>> -	return of_dma_configure(dev, dma_dev->of_node, 0);
>>>>>> +	fwspec = dev_iommu_fwspec_get(dma_dev);
>>>>>> +	if (!fwspec)
>>>>>> +		return -ENODEV;
>>>>>
>>>>> The problem appears to be here - fwspec is NULL for dprc.1.
>>>>
>>>> Ok, that's because the iommu config is missing from the DT node that's
>>>> exposing the MC firmware. I've attached a fresh set of patches that include
>>>> on top the missing config and a workaround that makes MC work over SMMU.
>>>> Also added the missing #include, thanks for pointing out.
>>>> Let me know how it goes.
>>>
>>> Shouldn't patch 6 should be first in the series, so that patch 1 does
>>> not cause a regression and bisectability damage?
>>>
>>
>> Correct, width one comment: both 5 and 6 should go first. Once iommu-map is
>> added in the device tree the workaround for MC with the
>> arm-smmu.disable_bypass boot arg will no longer work.
> 
> So, wouldn't it be reasonable to arrange the patch series like that?
> 

Sure, please see attached.

---
Best Regards, Laurentiu

--------------015B7DA56638A6B39ED7F2A6
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-bus-fsl-mc-make-mc-work-with-smmu-disable-bypass-on.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-bus-fsl-mc-make-mc-work-with-smmu-disable-bypass-on.pat";
 filename*1="ch"

From 44ae46501b5379bd0890df87fd3827248626ed03 Mon Sep 17 00:00:00 2001
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Tue, 1 Oct 2019 16:22:48 +0300
Subject: [PATCH 1/6] bus: fsl-mc: make mc work with smmu disable bypass on
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
 drivers/bus/fsl-mc/fsl-mc-bus.c | 53 +++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index a0f8854acb3a..683a6401ffe8 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -18,6 +18,8 @@
 #include <linux/bitops.h>
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu.h>
+#include <linux/io.h>
 
 #include "fsl-mc-private.h"
 
@@ -889,6 +891,12 @@ static int get_mc_addr_translation_ranges(struct device *dev,
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
@@ -906,6 +914,21 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	struct mc_version mc_version;
 	struct resource res;
 
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
@@ -990,6 +1013,13 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
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
@@ -1018,6 +1048,8 @@ static struct platform_driver fsl_mc_bus_driver = {
 static int __init fsl_mc_bus_driver_init(void)
 {
 	int error;
+	struct device_node *np;
+	struct resource res;
 
 	error = bus_register(&fsl_mc_bus_type);
 	if (error < 0) {
@@ -1039,9 +1071,30 @@ static int __init fsl_mc_bus_driver_init(void)
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


--------------015B7DA56638A6B39ED7F2A6
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-arm64-dts-lx2160a-add-iommus-property-for-mc-node.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-arm64-dts-lx2160a-add-iommus-property-for-mc-node.patch"

From 5d497723fb1695d1e880cfdb7b2f32fbd0e9ecc7 Mon Sep 17 00:00:00 2001
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Tue, 19 Nov 2019 17:01:39 +0200
Subject: [PATCH 2/6] arm64: dts: lx2160a: add iommus property for mc node
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


--------------015B7DA56638A6B39ED7F2A6
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-bus-fsl-mc-add-custom-.dma_configure-implementation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-bus-fsl-mc-add-custom-.dma_configure-implementation.pat";
 filename*1="ch"

From b226e187452cb2b75bd8a3ebb239c6320022c89b Mon Sep 17 00:00:00 2001
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Thu, 13 Feb 2020 11:59:12 +0200
Subject: [PATCH 3/6] bus: fsl-mc: add custom .dma_configure implementation
Content-Type: text/plain; charset="us-ascii"

The devices on this bus are not discovered by way of device tree
but by queries to the firmware. It makes little sense to trick the
generic of layer into thinking that these devices are of related so
that we can get our dma configuration. Instead of doing that, add
our custom dma configuration implementation.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 42 ++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 683a6401ffe8..665893058004 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -132,11 +132,51 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
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


--------------015B7DA56638A6B39ED7F2A6
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-irqchip-fsl-mc-Change-the-way-the-IRQ-domain-is-set-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-irqchip-fsl-mc-Change-the-way-the-IRQ-domain-is-set-.pa";
 filename*1="tch"

From 8b6bf2096ff2ec99f477a8bd43c590d4876ea21e Mon Sep 17 00:00:00 2001
From: Diana Craciun <diana.craciun@oss.nxp.com>
Date: Fri, 14 Feb 2020 16:28:45 +0200
Subject: [PATCH 4/6] irqchip/fsl-mc: Change the way the IRQ domain is set for
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


--------------015B7DA56638A6B39ED7F2A6
Content-Type: text/x-patch; charset=UTF-8;
 name="0005-bus-fsl-mc-Add-ACPI-support-for-fsl-mc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0005-bus-fsl-mc-Add-ACPI-support-for-fsl-mc.patch"

From d52fffe8be38ccaa040e56b9ca2b58db1a0fe742 Mon Sep 17 00:00:00 2001
From: Makarand Pawagi <makarand.pawagi@nxp.com>
Date: Thu, 23 Jan 2020 10:48:42 +0530
Subject: [PATCH 5/6] bus: fsl-mc: Add ACPI support for fsl-mc
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
index 665893058004..8a385df3e25c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -952,7 +952,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	phys_addr_t mc_portal_phys_addr;
 	u32 mc_portal_size;
 	struct mc_version mc_version;
-	struct resource res;
+	struct resource *plat_res;
 
 	/*
 	 * The MC firmware requires full access to the whole address space plus
@@ -978,16 +978,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
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
@@ -1004,11 +997,13 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
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
@@ -1035,6 +1030,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 		goto error_cleanup_mc_io;
 
 	mc->root_mc_bus_dev = mc_bus_dev;
+	mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
 	return 0;
 
 error_cleanup_mc_io:
@@ -1075,11 +1071,18 @@ static const struct of_device_id fsl_mc_bus_match_table[] = {
 
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


--------------015B7DA56638A6B39ED7F2A6
Content-Type: text/x-patch; charset=UTF-8;
 name="0006-iommu-of-get-rid-of-fsl-mc-specific-code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0006-iommu-of-get-rid-of-fsl-mc-specific-code.patch"

From ff42f0b4375aff9e351817db1e28fa4b3e6211d4 Mon Sep 17 00:00:00 2001
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Wed, 26 Feb 2020 17:31:49 +0200
Subject: [PATCH 6/6] iommu/of: get rid of fsl-mc specific code
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


--------------015B7DA56638A6B39ED7F2A6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------015B7DA56638A6B39ED7F2A6--
