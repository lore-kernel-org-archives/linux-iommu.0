Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CE6C433DF
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 09:38:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A2B207E8
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 09:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KeWoQCJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A2B207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A42F88677;
	Wed, 17 Jun 2020 09:38:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QbEXS+4yQlbL; Wed, 17 Jun 2020 09:38:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 74E3F88652;
	Wed, 17 Jun 2020 09:38:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52182C07FF;
	Wed, 17 Jun 2020 09:38:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10ABAC016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 09:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EE3718778C
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 09:38:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id moCgeUy16jzZ for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 09:38:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id ED3998777D
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 09:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtHitlVuqS1ccxRV6RSFIithpWIinnF49ep4Sf4kETAFyU3cKhlqmGREv1cqcDqKIihKv8WwvJoevzxDlyEw+3DZbMbQHM8AmAqrICrgueX8sk9mYRt9YCS8RoGONcJcnY736yHuMxAHrxc9f0AIVhqd4BTdobWtXfpKdyaryh7uzX67TCeoQqIPmIY6msBoYPoeQTk3gQ1x07Grv76BoCSDMrSC2nZO1Cg6n4YdqM4Uw9/vfpKV1lN3ZV6tYf4Gmx3k7zwkEGyFmKuoo5AtlVyXzDBcNhtcRTtAOkEDrto1u4EDftAF0en7vwTb0Fxa5nJ6CgZ5/pbESUOAa135OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu92nTxobvAJtjnQ/c7Gy6Os60UMOGVIfb4f/SrYR2w=;
 b=jjAbyTWRvl+BiyCJ1tFAgwKhvzVis6I4JuvreG+hxgwq5OkC1d1tEFPVFFBj3KcI+mD/bB8Mq5rgrSMghOkoQZWPdHBPUMDUWNUtXo4CNgxt6YWuxhm6S8zjaWXxKpARY/mQ/jSiBgczHi5KDD+pIFhtMnouB3VrQTAS1Ed4+tjA2tsssYMBmI+PdjlqKpk0ZXziF5ggpAMo9oCIHfvAiav/hWTXfwRuS05f2iYdA3rVa+BF54Hkx9XIJq28OAbBWwxAX7Ezn88jAjolEVZYYyIthPMLJy8XabGrpVMewkgTtcL19lYcKt0RR7Rk+2qj/FG0aeIUxefyCdcPZmcA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu92nTxobvAJtjnQ/c7Gy6Os60UMOGVIfb4f/SrYR2w=;
 b=KeWoQCJCV1DireJOBXrlGK3D16f6J8TjZjvccqzEssJhfpdu1LrpSqdU0xc42tL59IEPITQwisIHocg+LW8qD4krRWuLozlPDHQ4vtj97rwxvc5X4Ct22CF5cp8elfp82CcTBCK0Xtmr3AnsDpHEHhxvedqGbFVnzPr7IEZfAYA=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.23; Wed, 17 Jun 2020 09:23:11 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::c1bc:8ef9:9ba3:99bf]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::c1bc:8ef9:9ba3:99bf%10]) with mapi id 15.20.3109.021; Wed, 17 Jun
 2020 09:23:11 +0000
Subject: Re: [PATCH] iommu/amd: Print extended features in one line to fix
 divergent log levels
To: Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>
References: <20200616220420.19466-1-pmenzel@molgen.mpg.de>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <8250b9fa-b62b-7d80-d2b6-99b8587f4df4@amd.com>
Date: Wed, 17 Jun 2020 16:23:02 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200616220420.19466-1-pmenzel@molgen.mpg.de>
Content-Language: en-US
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.140.250) by
 SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 09:23:10 +0000
X-Originating-IP: [165.204.140.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2765826d-9fce-4fed-f977-08d812a00e47
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:
X-Microsoft-Antispam-PRVS: <DM6PR12MB308375BAFD5CCE5F3C472477F39A0@DM6PR12MB3083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztsbFglI0ACWZiobPLqfJvNB3lqOqX5J3B4EfyWy54bFYQrooQTG+V9WJpFm1Pi4ZdodWF0tKxMiEXvdam6nla3xMAh9CKzPMcUnxjtN4a9Wxi7vU1OXVJXYVa41yqJ5l5EtsvjMphtCXT7WX15gFLnHdUri6v2yb23EflChobxI80RXxUAyBe8QTIEp0E2AIYQELwqot9TvYm01MJYlhZSUG2Us/L6X8yPXXURUAZM4Tuvlk3e5twGL0Bc49DMgfM2xnMuKDt9I83lRNHzCE9gmHtHYpC7TB1dUYZKqBpwCc/pvmBNeWcOD5I+QXisX0pDs7+3pRe6fU1kXUk0YyuNEDl4/4ZY8q8qWPv3jUu6Y7jlL/Oc0Bm12jKqdae80
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(4326008)(16526019)(186003)(36756003)(5660300002)(8676002)(52116002)(66946007)(2906002)(66476007)(26005)(66556008)(31686004)(6512007)(8936002)(6486002)(31696002)(316002)(110136005)(6506007)(44832011)(2616005)(956004)(86362001)(6666004)(53546011)(478600001)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 41ommfsIDAQwj/eCf/YyXtSbGXXhF9pzZ32q7sCe1iF+Yb1rkD5ltoYQJvLDbAS5rO9RFzPC4fW7OByMJbS1ea7anC7wuzxITUB4wYqVO1HJt5MzRfy4fotIwcemuC+LL+ulSlI/PfEq5/KSdRlnWERQZ0v11rGA/lfonw4HfxX0AfhpqALgop2MdG9H+gtgzkK//MA7Q0gc7tYXk0kXIAhxrG4niLqJZ4E90Z1eRI5a8VtiWr5xUmlQEQkKZeIi0ZqbjJHqDkT1TcYulsBjxsq2qb5/htATgQ+hQZ1K5YF+3LueM81wbBRaQSHPXqrWCvdY1ht/VfXvgEz9jBzWo1wpCCz83LvBxU+UZNaSATEvmg6Zz3fuzrtyHN0YlfRyCOvuvaoUA0MPabNImP3YmnI8+Myburjrc6KC17Bvc7V0E0i/gYkmQgo+ISN61PDaP2mUhiIFacpf8GaN5H/ILGxDiwFDI9vHn0jBc1YObwIno7Fe1SHBlFoARJQ2JBTI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2765826d-9fce-4fed-f977-08d812a00e47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 09:23:11.8829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8vqcxTI853Zbvpq9qTbXbv+uyCLXo5Jmngp/7zkxZxlGIC2W/zQGKRqlABOTYbPJgVKt7Wo5K6thQ3ENsawVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
Cc: iommu@lists.linux-foundation.org
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



On 6/17/20 5:04 AM, Paul Menzel wrote:
> Currently, Linux logs the two messages below.
> 
>      [    0.979142] pci 0000:00:00.2: AMD-Vi: Extended features (0xf77ef22294ada):
>      [    0.979546]  PPR NX GT IA GA PC GA_vAPIC
> 
> The log level of these lines differs though. The first one has level
> *info*, while the second has level *warn*, which is confusing.
> 
>      $ dmesg -T --level=info | grep "Extended features"
>      [Tue Jun 16 21:46:58 2020] pci 0000:00:00.2: AMD-Vi: Extended features (0xf77ef22294ada):
>      $ dmesg -T --level=warn | grep "PPR"
>      [Tue Jun 16 21:46:58 2020]  PPR NX GT IA GA PC GA_vAPIC
> 
> The problem is, that commit 3928aa3f57 ("iommu/amd: Detect and enable
> guest vAPIC support") introduced a newline, causing `pr_cont()`, used to
> print the features, to default back to the default log level.
> 
>      /**
>       * pr_cont - Continues a previous log message in the same line.
>       * @fmt: format string
>       * @...: arguments for the format string
>       *
>       * This macro expands to a printk with KERN_CONT loglevel. It should only be
>       * used when continuing a log message with no newline ('\n') enclosed. Otherwise
>       * it defaults back to KERN_DEFAULT loglevel.
>       */
>      #define pr_cont(fmt, ...) \
>              printk(KERN_CONT fmt, ##__VA_ARGS__)
> 
> So, remove the line break, so only one line is logged.
> 
> Fixes: 3928aa3f57 ("iommu/amd: Detect and enable guest vAPIC support")
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>   drivers/iommu/amd_iommu_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 5b81fd16f5faf8..8d9b2c94178c43 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1844,7 +1844,7 @@ static void print_iommu_info(void)
>   		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
>   
>   		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):\n",
> +			pci_info(pdev, "Extended features (%#llx):",
>   				 iommu->features);
>   			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
>   				if (iommu_feature(iommu, (1ULL << i)))
> 

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
