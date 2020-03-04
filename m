Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474D4C3F2CD
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 09:42:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B6420848
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 09:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nx9XSoe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B6420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CC1022047E;
	Wed,  4 Mar 2020 09:42:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Za-yC-d7gC3; Wed,  4 Mar 2020 09:42:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BAC972044A;
	Wed,  4 Mar 2020 09:42:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0396C1AE2;
	Wed,  4 Mar 2020 09:42:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0C94C013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 09:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BA2DF87889
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 09:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dXqrCq3bFGqI for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 09:42:21 +0000 (UTC)
X-Greylist: delayed 17:12:59 by SQLgrey-1.7.6
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140073.outbound.protection.outlook.com [40.107.14.73])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F1E5685B3C
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 09:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB587ge6DYoU+4X9brKqDXXy1Rf4V2R8IRaxwxivxAnc7jW204XdF+JOTJPRiQu55Fy4LSKZko8Ap/xH1lQQ4SO9ERTUfs/erFq9cdh9Q7RYiktzpeqHJSdR6UqAXyjEt9kxraDdiAtSEeEtEEJsh8o+hxe+CynUCNdzxvDEANn1hZN1BaShrRg4Qch62jV7D3JBQXPytCj89Coob0aixq8PcSvDdv4+K+x66Vs56Ul+T11Gc+Lwd2RGpzeI0sawGy7sDZL2GPJ4tmxpsFA0uxbmMR+yVD8qprq4TDLqr3HVeC1dLsoQkSR7pZrna0xolmWhDVAdzEoyWpeVdySkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGOE8K24tCrRAse2dkT3cF5iHM4zBKB2KwDkjQAzgNM=;
 b=KEd7g5MN0vQ8W7Xmt1WjFffsM/n2WHZcfDKccg2ibGBO+onV9QLjCAxeLNQSY2U34GnPDHFYO/uFiVwO8aez8Rdn9+npMgxSC7hkUiLMTyDic+ZACMFUUxSQeDxnXOsW/l6+1b/TeTsoxPNZkLjNLvaipluM5UrLgqkOeWWdlRXqVsF4amBDyhYlEUdLU4ABSwMUd2jNrBLegxaGHe/w9PpJ7qOVgQzm9gqPLauDpvzdiEJnQseMvG3naqYTqnQ7xwbhN9+9cqe1C5NpBghS2Ts2gvNb4JTKGaCTAT46G6LM9nZUz9LRBcHml8B6RMyefIXJKwFvZTQRD0uY1e80Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGOE8K24tCrRAse2dkT3cF5iHM4zBKB2KwDkjQAzgNM=;
 b=nx9XSoe+9ANacxxwtfOzIVw2RBYkyFsNxTASuXlYRMeSizFacj5u6qKluP3S7ORfFvqoNBmi6c9x16TCKVVbuEJHiRyob3x4XfDzu133yrOfq67a8pq9cFyUYenzympGa4J0sEccm0lEDA/mJ/SxBJ3yt3jVaOVZAlg6YhvLc0E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com (52.132.213.205) by
 AM0PR04MB4260.eurprd04.prod.outlook.com (52.134.124.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 09:42:18 +0000
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528]) by AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 09:42:18 +0000
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
 <62b3d48a-af5f-b44b-07cd-83aa7663c45f@nxp.com>
 <20200304093330.GX25745@shell.armlinux.org.uk>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <78f175be-0701-b6cd-8feb-1343f9982d4c@nxp.com>
Date: Wed, 4 Mar 2020 11:42:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200304093330.GX25745@shell.armlinux.org.uk>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0902CA0007.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::17) To AM0PR04MB6897.eurprd04.prod.outlook.com
 (2603:10a6:208:184::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.171.82.13] (89.37.124.34) by
 AM4PR0902CA0007.eurprd09.prod.outlook.com (2603:10a6:200:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Wed, 4 Mar 2020 09:42:17 +0000
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c34e0283-ce62-4ac3-3c53-08d7c0205431
X-MS-TrafficTypeDiagnostic: AM0PR04MB4260:|AM0PR04MB4260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB42606C6F4FD523061FBC3472ECE50@AM0PR04MB4260.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(189003)(199004)(316002)(4326008)(478600001)(16576012)(2906002)(54906003)(52116002)(86362001)(31686004)(31696002)(6916009)(36756003)(16526019)(5660300002)(8676002)(956004)(44832011)(26005)(53546011)(2616005)(186003)(81156014)(66476007)(8936002)(66556008)(81166006)(66946007)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4260;
 H:AM0PR04MB6897.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8KqOMiDueQsmJoV1N3kj6Wz4heqqsc27nncNOSMjpSH7ysso2pyEl84TXLJbHHRQ8btswUi3Ny0a0sBVyIpC2h5h3TjKsiOsn+en3Y11oEWQl+CeOUv9YLQXvbO6IK/YUirpcnZUk+yapFZ4XQeT6ltMzZvg3OM/eLZJwQMp4f+8rZp6YPj0/aB6+QlpqeLZ6XwNt0e2/nxaPfBoe5n/3P7MJP+neg7ijDIEns+e2fcT6BxEJ9kOiJuaZe9LYhSZPpGXWZrhLBntZsYoGPf918Xc3firaC0fGXYOGV6X+/QmderKL1T5Vbth3FSZzjvt0TVuV1QwnvlsFLEOVxtrhSqPIeB1exfqQ3T0sWepp3Hm0hqCJWqnxrDOROvVhX5SUt0Qy6JMJf9G/OvVs8YRVtTXO5WDXONppnQum8YsC2za4qUfamObsZzGCxda6ya
X-MS-Exchange-AntiSpam-MessageData: 8b7Z/KepoG7BBSrDxGza6W18C2ylJhQFQJ90vGZTjbD5F4J+drjKe8KkocQK4ACM00q3qUASPe0QwqzpjYaxqeZ+sRd0Zg89ABi06LMWTQLumlgX2d91+dFv/Y/aI2P+rVv37e5tsxp5y3M+0pJyJA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34e0283-ce62-4ac3-3c53-08d7c0205431
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 09:42:18.1946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCXe5RU8IkMbLumrxDtKMXiiOga2abrsHs2kTtaESmwTmGGWSspW9Hi7r8cubTigXlpu8nQWlhmaiCPCmk4HtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4260
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



On 04.03.2020 11:33, Russell King - ARM Linux admin wrote:
> On Wed, Mar 04, 2020 at 10:56:06AM +0200, Laurentiu Tudor wrote:
>>
>> On 04.03.2020 00:17, Russell King - ARM Linux admin wrote:
>>> On Tue, Mar 03, 2020 at 05:55:05PM +0200, Laurentiu Tudor wrote:
>>>>   From c98dc05cdd45ae923654f2427985bd28bcde4bb2 Mon Sep 17 00:00:00 2001
>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>> Date: Thu, 13 Feb 2020 11:59:12 +0200
>>>> Subject: [PATCH 1/4] bus: fsl-mc: add custom .dma_configure implementation
>>>> Content-Type: text/plain; charset="us-ascii"
>>>>
>>>> The devices on this bus are not discovered by way of device tree
>>>> but by queries to the firmware. It makes little sense to trick the
>>>> generic of layer into thinking that these devices are of related so
>>>> that we can get our dma configuration. Instead of doing that, add
>>>> our custom dma configuration implementation.
>>>
>>> Firstly, applying this to v5.5 results in a build failure, due to a
>>> missing linux/iommu.h include.
>>>
>>> Secondly, this on its own appears to make the DPAA2 network interfaces
>>> completely disappear.  Looking in /sys/bus/fsl-mc/drivers/*, none of
>>> the DPAA2 drivers are bound to anything, and looking in
>>> /sys/bus/fsl-mc/devices/, there is:
>>>
>>> lrwxrwxrwx 1 root root 0 Mar  3 22:06 dprc.1 -> ../../../devices/platform/soc/80c000000.fsl-mc/dprc.1
>>>
>>> This is booting with u-boot, so using DT rather than ACPI.
>>>
>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>> ---
>>>>    drivers/bus/fsl-mc/fsl-mc-bus.c | 42 ++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 41 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>> index 36eb25f82c8e..3df015eedae4 100644
>>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>> @@ -132,11 +132,51 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>>>>    static int fsl_mc_dma_configure(struct device *dev)
>>>>    {
>>>>    	struct device *dma_dev = dev;
>>>> +	struct iommu_fwspec *fwspec;
>>>> +	const struct iommu_ops *iommu_ops;
>>>> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
>>>> +	int ret;
>>>> +	u32 icid;
>>>> +
>>>> +	/* Skip DMA setup for devices that are not DMA masters */
>>>> +	if (dev->type == &fsl_mc_bus_dpmcp_type ||
>>>> +	    dev->type == &fsl_mc_bus_dpbp_type ||
>>>> +	    dev->type == &fsl_mc_bus_dpcon_type ||
>>>> +	    dev->type == &fsl_mc_bus_dpio_type)
>>>> +		return 0;
>>>>    	while (dev_is_fsl_mc(dma_dev))
>>>>    		dma_dev = dma_dev->parent;
>>>> -	return of_dma_configure(dev, dma_dev->of_node, 0);
>>>> +	fwspec = dev_iommu_fwspec_get(dma_dev);
>>>> +	if (!fwspec)
>>>> +		return -ENODEV;
>>>
>>> The problem appears to be here - fwspec is NULL for dprc.1.
>>
>> Ok, that's because the iommu config is missing from the DT node that's
>> exposing the MC firmware. I've attached a fresh set of patches that include
>> on top the missing config and a workaround that makes MC work over SMMU.
>> Also added the missing #include, thanks for pointing out.
>> Let me know how it goes.
> 
> Shouldn't patch 6 should be first in the series, so that patch 1 does
> not cause a regression and bisectability damage?
> 

Correct, width one comment: both 5 and 6 should go first. Once iommu-map 
is added in the device tree the workaround for MC with the 
arm-smmu.disable_bypass boot arg will no longer work.

---
Best Regards, Laurentiu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
