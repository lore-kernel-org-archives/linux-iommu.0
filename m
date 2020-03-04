Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9124C3F2D8
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 10:47:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D00320732
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 10:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l7ipG4Cu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D00320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 334FA2043E;
	Wed,  4 Mar 2020 10:47:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZe9+2Eg80FW; Wed,  4 Mar 2020 10:47:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1186020373;
	Wed,  4 Mar 2020 10:47:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06CFAC089F;
	Wed,  4 Mar 2020 10:47:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D795AC013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D33688671B
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id clm3V09BvU9e for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 10:47:28 +0000 (UTC)
X-Greylist: delayed 20:28:25 by SQLgrey-1.7.6
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10041.outbound.protection.outlook.com [40.107.1.41])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2CB828263D
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7p+rLLkdHNE+U/8fOGaD/VcvfjYUryBLyF9zVBQwu3ohCnEgcPHKPPS2/OKN6xpnkv038WRS+8PZxACPxxAKdWQZuPTqINAs1qbcfn7II3KQPNxImeOtUAbiTCNxFEvZEv5xvKHrYWXGQuDh0JGN5rMFXvSNXcsWqIijLX2tmJT95SJCbD06nqYaenerR5+IwXuDTUe4xieObefYzvfT5T+8nPYBdt/+VeCGx05On5WMFiJVsAhh1/sFD/tb1lIcsdtnjwy5pkubnPvjADfmuDtSiT/d+v3rhYykBHVZeygKVR6If4Vo3TNpx0yf4TPomiANF5VJSb/Doc6PUcx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELiDfDytnsh7avmZ81fpAnSrpiYhyO+ZrBw8KdmMfL0=;
 b=bKCD2PMfM/lw8tIBScV0wktBZtCqjVDFDiODUy5EcCaW8eN0/iuChJEXkhME+7wDSuykRUPWWzCWNJdFwjhtfrhqoSUC4jalYHEQA3RoKPDqwoyUQPURJoaIrfolQ8WjPDTWLnlvL/VR8zPjqpDUNYtvVKn1p5o1iovSJBdqOLdh725lMwVjzLqzCnBCabAE9TsibcvyT4CyrqQfwPxbXR5TaqYTp9Oe6gMcFqyNHLL98Yj1omye2BO+YmbeSMn7o4BFYs0LR92KqvdiG9fOg6BZGRRUNAF0wNKIgn905xViLLLQ1QirtrCBihLHqnG6fi5unB1FRjSzGombNmIEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELiDfDytnsh7avmZ81fpAnSrpiYhyO+ZrBw8KdmMfL0=;
 b=l7ipG4CuQAofPWkVYx2HY5Fhz32j9scl0u6EHczby4xiGOk1HF7prkUncbPX5xWRg9vnWtNpBNo+Z1FU3+Yea9qM3Ahgig91Jn3Z6v2Jw1odvNMq66tedmbHp05dCEN4DSKB9WQvFLCxljO1L1SH7PnxIs+utEoWI98feWjEed4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com (52.132.213.205) by
 AM0PR04MB4882.eurprd04.prod.outlook.com (20.176.215.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Wed, 4 Mar 2020 10:33:16 +0000
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528]) by AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 10:33:15 +0000
Subject: Re: [PATCH] iommu: silence iommu group prints
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Olof Johansson <olof@lixom.net>
References: <95af8fc3-d7b1-3b58-afc1-d203d7538b95@arm.com>
 <bcb9fbab-2943-3207-b69d-e7ce9e3e3a8e@nxp.com>
 <20200303154959.GR25745@shell.armlinux.org.uk>
 <ac9dc4b1-e3a4-2b69-7c61-d94e082cef30@nxp.com>
 <20200303221745.GV25745@shell.armlinux.org.uk>
 <62b3d48a-af5f-b44b-07cd-83aa7663c45f@nxp.com>
 <20200304093330.GX25745@shell.armlinux.org.uk>
 <78f175be-0701-b6cd-8feb-1343f9982d4c@nxp.com>
 <20200304095112.GY25745@shell.armlinux.org.uk>
 <b9f4e9ad-033f-b5cf-9578-38f8367ef8cd@nxp.com>
 <20200304100713.GZ25745@shell.armlinux.org.uk>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <6dd33f8d-0eee-83ad-a257-878e9ef83721@nxp.com>
Date: Wed, 4 Mar 2020 12:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200304100713.GZ25745@shell.armlinux.org.uk>
Content-Language: en-US
X-ClientProxiedBy: AM6PR04CA0035.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::48) To AM0PR04MB6897.eurprd04.prod.outlook.com
 (2603:10a6:208:184::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.171.82.13] (89.37.124.34) by
 AM6PR04CA0035.eurprd04.prod.outlook.com (2603:10a6:20b:92::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 10:33:15 +0000
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af84b0f2-400d-447d-4aed-08d7c02772af
X-MS-TrafficTypeDiagnostic: AM0PR04MB4882:|AM0PR04MB4882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4882475AE491B12E46DA9CD2ECE50@AM0PR04MB4882.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:191;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(110136005)(54906003)(956004)(44832011)(6486002)(26005)(36756003)(81166006)(2616005)(2906002)(186003)(31696002)(478600001)(52116002)(81156014)(31686004)(66946007)(966005)(86362001)(8936002)(5660300002)(66476007)(66556008)(16526019)(8676002)(16576012)(316002)(4326008)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4882;
 H:AM0PR04MB6897.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JPkOz49ho9sV8fmHwZWM/pF10cXi24RV86177BKxDxd9B5ThxgTSGeMr6aIf8X5dg4LAkVhDgEnTR8Vwj0EWOBOtF4hi0m835u7aahm3NO4Zd/fDBkFXyMyqCxS6R3brwg7Uc+oLAbuO9bWE4tFzyEI6/CQfkntjqZxFmbjOmcW3UjCdBrbgBE7qB4gReE/TRedqbdacLyMxU1Sh+Ol5kFumZzTiYjVPgNMhh+2vmXR8IYrPFZxgv6HoZ5//fA3w2qPj6paCLm8J+VGEPijtnmll2930TTF6LPkWOj4KS3R6IUPr/MMjl8EUb9J8j2svB0Z9i2mMRT8BInZif9RT6UZsm8OTeqJ+vkoWByMBVoq9xMfGIXJPHQe1rFKOxKeGO4s0IFjIJpBSAkuDtPkKBYo1veSs3MLFTnO4n9XGQ3dntU4ZV+RbeFsHxt9FONdWvoneKOTrSKj9QCQC5fv1uetU4tEOMESPGgCmZs7Az8R8q2gS44xBkoRd9Du+Z+75RWH6oEymTPg1PnjtFQuEg==
X-MS-Exchange-AntiSpam-MessageData: YcDMjwSb7ReRvYapX71hquxgia7f02WOUGoz/nudxk4fn8VVdqsWDlp5Z91nskdVnPzdLchgKE5gR23eBgYJftCFQrfFDIiKoDU1YifbOObNB0EOifjgar2hpP2C/O5YlLaimdrdCJ70O/7+N1uL6g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af84b0f2-400d-447d-4aed-08d7c02772af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 10:33:15.7916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjcXJTmDrMoSvantQkN+3GfoHQ/xOiL+Jhp3rp22PUYi8NtY7cKdeduNg+yNs+I+XlUaDdwizXMaFLBw9EMg9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4882
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 04.03.2020 12:07, Russell King - ARM Linux admin wrote:
> On Wed, Mar 04, 2020 at 11:56:53AM +0200, Laurentiu Tudor wrote:
>>  From 44ae46501b5379bd0890df87fd3827248626ed03 Mon Sep 17 00:00:00 2001
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Date: Tue, 1 Oct 2019 16:22:48 +0300
>> Subject: [PATCH 1/6] bus: fsl-mc: make mc work with smmu disable bypass on
>> Content-Type: text/plain; charset="us-ascii"
>>
>> Since this commit [1] booting kernel on MC based chips started to
>> fail because this firmware starts before the kernel and as soon as
>> SMMU is probed it starts to trigger contiguous faults.
> 
> I think you mean "continuous" here.

Yes, thanks.

>> This is a workaround that allows MC firmware to run with SMMU
>> in disable bypass mode. It consists of the following steps:
>>   1. pause the firmware at early boot to get a chance to setup SMMU
>>   2. request direct mapping for MC device
>>   3. resume the firmware
>> The workaround relies on the fact that no state is lost when
>> pausing / resuming firmware, as per the docs.
>> With this patch, platforms with MC firmware can now boot without
>> having to change the default config to set:
>>    CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT=n
> 
> This alone is a definite improvement, and has been needed for a while.
> Please submit this patch with an appropriate Fixes: tag so stable trees
> can pick it up.

The thing is that probably this workaround will never make it in the 
kernel because it questionable to say the least, e.g. see [1]. My plan 
is to give this approach [2] a try sometime soon.

[1] https://patchwork.kernel.org/comment/23149049/
[2] https://patchwork.kernel.org/cover/11279577/

---
Best Regards, Laurentiu

>> [1] 954a03be033 ("iommu/arm-smmu: Break insecure users by disabling bypass by default")
> 
> Please put this where you're referencing it above - it's fine to wrap
> the description of the commit when using it in the body of the commit
> message.  However, that should _never_ when providing a Fixes: tag
> (linux-next has a script which will detect and complain about broken
> Fixes: tags.)
> 
> Thanks.
> 
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>>   drivers/bus/fsl-mc/fsl-mc-bus.c | 53 +++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> index a0f8854acb3a..683a6401ffe8 100644
>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> @@ -18,6 +18,8 @@
>>   #include <linux/bitops.h>
>>   #include <linux/msi.h>
>>   #include <linux/dma-mapping.h>
>> +#include <linux/iommu.h>
>> +#include <linux/io.h>
>>   
>>   #include "fsl-mc-private.h"
>>   
>> @@ -889,6 +891,12 @@ static int get_mc_addr_translation_ranges(struct device *dev,
>>   	return 0;
>>   }
>>   
>> +#define FSL_MC_GCR1	0x0
>> +#define GCR1_P1_STOP	BIT(31)
>> +
>> +static u32 boot_gcr1;
>> +static void __iomem *fsl_mc_regs;
>> +
>>   /**
>>    * fsl_mc_bus_probe - callback invoked when the root MC bus is being
>>    * added
>> @@ -906,6 +914,21 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>>   	struct mc_version mc_version;
>>   	struct resource res;
>>   
>> +	/*
>> +	 * The MC firmware requires full access to the whole address space plus
>> +	 * it has no way of dealing with any kind of address translation, so
>> +	 * request direct mapping for it.
>> +	 */
>> +	error = iommu_request_dm_for_dev(&pdev->dev);
>> +	if (error)
>> +		dev_warn(&pdev->dev, "iommu_request_dm_for_dev() failed: %d\n",
>> +			 error);
>> +
>> +	if (fsl_mc_regs) {
>> +		/* Resume the firmware */
>> +		writel(boot_gcr1 & ~GCR1_P1_STOP, fsl_mc_regs + FSL_MC_GCR1);
>> +	}
>> +
>>   	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
>>   	if (!mc)
>>   		return -ENOMEM;
>> @@ -990,6 +1013,13 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
>>   	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
>>   		return -EINVAL;
>>   
>> +	/*
>> +	 * Pause back the firmware so that it doesn't trigger faults by the
>> +	 * time SMMU gets brought down.
>> +	 */
>> +	writel(boot_gcr1 | GCR1_P1_STOP, fsl_mc_regs + FSL_MC_GCR1);
>> +	iounmap(fsl_mc_regs);
>> +
>>   	fsl_mc_device_remove(mc->root_mc_bus_dev);
>>   
>>   	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
>> @@ -1018,6 +1048,8 @@ static struct platform_driver fsl_mc_bus_driver = {
>>   static int __init fsl_mc_bus_driver_init(void)
>>   {
>>   	int error;
>> +	struct device_node *np;
>> +	struct resource res;
>>   
>>   	error = bus_register(&fsl_mc_bus_type);
>>   	if (error < 0) {
>> @@ -1039,9 +1071,30 @@ static int __init fsl_mc_bus_driver_init(void)
>>   	if (error < 0)
>>   		goto error_cleanup_dprc_driver;
>>   
>> +	np = of_find_matching_node(NULL, fsl_mc_bus_match_table);
>> +	if (np && of_device_is_available(np)) {
>> +		error = of_address_to_resource(np, 1, &res);
>> +		if (error)
>> +			goto error_cleanup_dprc_driver;
>> +		fsl_mc_regs = ioremap(res.start, resource_size(&res));
>> +		if (!fsl_mc_regs) {
>> +			error = -ENXIO;
>> +			goto error_cleanup_dprc_driver;
>> +		}
>> +
>> +		boot_gcr1 = readl(fsl_mc_regs + FSL_MC_GCR1);
>> +		/*
>> +		 * If found running, pause MC firmware in order to get a chance
>> +		 * to setup SMMU for it.
>> +		 */
>> +		if (!(boot_gcr1 & GCR1_P1_STOP))
>> +			writel(boot_gcr1 | GCR1_P1_STOP,  fsl_mc_regs + FSL_MC_GCR1);
>> +	}
>> +
>>   	return 0;
>>   
>>   error_cleanup_dprc_driver:
>> +	iounmap(fsl_mc_regs);
>>   	dprc_driver_exit();
>>   
>>   error_cleanup_driver:
>> -- 
>> 2.17.1
>>
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
