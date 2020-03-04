Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3147AC3F2CD
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 11:27:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FA220848
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 11:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VVMq8njN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FA220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 805B086A16;
	Wed,  4 Mar 2020 11:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MvpWw7OrDAto; Wed,  4 Mar 2020 11:27:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AE5EB86388;
	Wed,  4 Mar 2020 11:27:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E4A1C1AE2;
	Wed,  4 Mar 2020 11:27:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3B53C013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 11:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A6FA686373
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 11:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CpBCGRn72rJ0 for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 11:27:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CCEE486322
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 11:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTlxOOFqYg863sGAn+5OSu2oINvHwYo1mOYqancyk5kcU8EWmt0gIQvo8HCyXpbLpZhfVRg+Rte8SC6f17gLT9F3C6k/QgSKYm/oCtBs4bim84k3T162bsW1g9lB2/+ZzlipB4Pm1YmSJL+jw8xa8y9yj2BJK6r5rPcIIC5bckZURovkVCOOt+rWdguxX16aFnzh3sR92kq16imn3Eb5lyYBbHNA3BE4AG2SD1SnxyK+EW2ujYdQ6TUp2Z8H/U/6mPOYFNBg8Cl1SVeyhW0JoEtluwQ+403FV8eX8dbAO4n/9qcjahAvWRRRi5EPM5y7xNPuB42jKcQiNzCXT6Uwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHT2BnfQ8PYYmC1paXHCXnzY6yd+eC7Ba95jHaZQf14=;
 b=HsecsEnrKtwcl9WeU6cyjBsqvkypL1e85uaGZdi8A2cdmHyIZ7hJSUsXHE+tiMmdV9PFSINqC+RhkqquRbT9ma2ocTPaORSIex1La3iVSX8IUY6FgkE3ZArYd3oMtQ49XEiciEP+YrmKMxgqe7u6cbAASJpW7dsCnzNHI3biuDCyWfNwK0TVjGnrjCTeHYrFFnDZuDrJNrIxCrKMcG/NwnXHjgCCC3rCLGzglRl1R3H3en0dy9qtRIiscIxaifouXGk2VW+lH5UUWYQNn51ARm2Z1kfcyi0SeF6TljGSTRcIlmGNeMMmnpJ6+9GQHdFWDV08oJpozKbAY2PzWgiybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHT2BnfQ8PYYmC1paXHCXnzY6yd+eC7Ba95jHaZQf14=;
 b=VVMq8njN4uN6P+p88Su5CM6XUhCLku8F1tWp3xTHn59MCP7p042lJzYo05/haO8I/L6y6fUusOf51RnKVr5DRjzlal/AB6whcTdV8XVsGZ9WevG82nN2YUZLCCfb2H+mcYTf20SndQn9DkYnw6C5USR0RP8Ne6iJIdo/MgBxND8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com (52.132.213.205) by
 AM0PR04MB4369.eurprd04.prod.outlook.com (52.135.146.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Wed, 4 Mar 2020 11:26:58 +0000
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528]) by AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 11:26:58 +0000
Subject: Re: [PATCH] iommu: silence iommu group prints
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <20200303154959.GR25745@shell.armlinux.org.uk>
 <ac9dc4b1-e3a4-2b69-7c61-d94e082cef30@nxp.com>
 <20200303221745.GV25745@shell.armlinux.org.uk>
 <62b3d48a-af5f-b44b-07cd-83aa7663c45f@nxp.com>
 <20200304093330.GX25745@shell.armlinux.org.uk>
 <78f175be-0701-b6cd-8feb-1343f9982d4c@nxp.com>
 <20200304095112.GY25745@shell.armlinux.org.uk>
 <b9f4e9ad-033f-b5cf-9578-38f8367ef8cd@nxp.com>
 <20200304100713.GZ25745@shell.armlinux.org.uk>
 <6dd33f8d-0eee-83ad-a257-878e9ef83721@nxp.com>
 <20200304105249.GA25745@shell.armlinux.org.uk>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <3028812b-ad59-9740-b402-c1717344ee81@nxp.com>
Date: Wed, 4 Mar 2020 13:26:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200304105249.GA25745@shell.armlinux.org.uk>
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0007.eurprd05.prod.outlook.com
 (2603:10a6:208:55::20) To AM0PR04MB6897.eurprd04.prod.outlook.com
 (2603:10a6:208:184::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.171.82.13] (89.37.124.34) by
 AM0PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:208:55::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 11:26:58 +0000
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 599fd18c-af30-4671-aee4-08d7c02ef3b3
X-MS-TrafficTypeDiagnostic: AM0PR04MB4369:|AM0PR04MB4369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4369921895B10E0DA640081DECE50@AM0PR04MB4369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(52116002)(6486002)(54906003)(16576012)(66556008)(5660300002)(316002)(53546011)(66946007)(66476007)(86362001)(478600001)(2616005)(956004)(44832011)(26005)(2906002)(4326008)(31686004)(81156014)(31696002)(186003)(81166006)(8936002)(8676002)(6916009)(16526019)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4369;
 H:AM0PR04MB6897.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xywsx/Ld/4VIkw5E4n+/ZDlTxS7xcIDrS6o63+evdtUliOQf5PCNkQQI0UdBMh0nhisSRRGP/8oKSvDGVfpmr8CR5MAVFqGzQifZf5vKU3Vn8QKXNJ4ZtlI7hRwTcU/gZwP4bkJ6fJIEtTE/b+IrKGEcbGDS6pSv1lRItZU+LceqcG4MwDnX+GFsZpDfg90zrywu5rDMrpbhx2uFAv/Urgxr5MlM9s6iN0JdDwD5F+mnPAh6Z4LhLDQXOfdQmd+rDCIpYlTOgH8vM3JPlS0f9s0p9C1AdTQ/efqt/gWdguv5BBm4PEhcVJQADbgInuNCPOgzfyXx4kWmJTVebmd34zGyGqLCM9SYfyH724qI5C+DK6GVXUFa9xZgYlqpEDAro/Fn8RLv3Tv10Tg60Ch7q56ME5L+zT6VdF3uUJRaK7xx8C69TjngTPe7/KIxNZd
X-MS-Exchange-AntiSpam-MessageData: NVWnL/9Bl0StvvHnz1uEqtLms0/2PzIjU0DQivaNJ+SgeWQyaXmECHWLsP08VP73bB2Q9ucMzRH7B5BnPBqcxTf37imDhtW6STG4TkNo4pDNyrD6EcWoDLDMAjZ2/NBC2B/hDxLCzYg2DZz6OD4+1g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599fd18c-af30-4671-aee4-08d7c02ef3b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 11:26:58.7554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7msNXpk8P0C3LaJCu8OYeOG/w8or6tPp00hxL33NfOiiu7jSvBOugCFF1+zhoVcGQSZxh4ajTInVjUZoP9dxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4369
Cc: Diana Madalina Craciun <diana.craciun@nxp.com>,
 iommu@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Robin Murphy <robin.murphy@arm.com>
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



On 04.03.2020 12:52, Russell King - ARM Linux admin wrote:
> On Wed, Mar 04, 2020 at 12:33:14PM +0200, Laurentiu Tudor wrote:
>>
>>
>> On 04.03.2020 12:07, Russell King - ARM Linux admin wrote:
>>> On Wed, Mar 04, 2020 at 11:56:53AM +0200, Laurentiu Tudor wrote:
>>>>   From 44ae46501b5379bd0890df87fd3827248626ed03 Mon Sep 17 00:00:00 2001
>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>> Date: Tue, 1 Oct 2019 16:22:48 +0300
>>>> Subject: [PATCH 1/6] bus: fsl-mc: make mc work with smmu disable bypass on
>>>> Content-Type: text/plain; charset="us-ascii"
>>>>
>>>> Since this commit [1] booting kernel on MC based chips started to
>>>> fail because this firmware starts before the kernel and as soon as
>>>> SMMU is probed it starts to trigger contiguous faults.
>>>
>>> I think you mean "continuous" here.
>>
>> Yes, thanks.
>>
>>>> This is a workaround that allows MC firmware to run with SMMU
>>>> in disable bypass mode. It consists of the following steps:
>>>>    1. pause the firmware at early boot to get a chance to setup SMMU
>>>>    2. request direct mapping for MC device
>>>>    3. resume the firmware
>>>> The workaround relies on the fact that no state is lost when
>>>> pausing / resuming firmware, as per the docs.
>>>> With this patch, platforms with MC firmware can now boot without
>>>> having to change the default config to set:
>>>>     CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT=n
>>>
>>> This alone is a definite improvement, and has been needed for a while.
>>> Please submit this patch with an appropriate Fixes: tag so stable trees
>>> can pick it up.
>>
>> The thing is that probably this workaround will never make it in the kernel
>> because it questionable to say the least, e.g. see [1]. My plan is to give
>> this approach [2] a try sometime soon.
>>
> So, if we want to reduce the iommu noise, we need to completely break
> the ability to use a mainline kernel on the LX2160A.  This doesn't
> seem practical nor sensible.  Someone has to give.
> 

Well, I think it's a bit too early for such conclusions. I'd consider 
this stuff early / experimental work, probably will take quite a while 
for the dust to settle. Anyway, I'll take care not to break the kernel 
when I'll start submitting more official patches.
For now, I'm just hoping that this stuff helps fixing your local tree.

---
Best Regards, Laurentiu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
