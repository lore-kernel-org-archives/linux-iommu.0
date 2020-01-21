Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DADDC33CAA
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 07:45:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9262253D
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 07:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BGcGfD3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9262253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DEA2A87880;
	Tue, 21 Jan 2020 07:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mG83+nLjwrZq; Tue, 21 Jan 2020 07:44:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 28C2B86DD6;
	Tue, 21 Jan 2020 07:44:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A9E5C0176;
	Tue, 21 Jan 2020 07:44:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB9EC0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 07:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7583C87368
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 07:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g6EIORGwVuhH for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 07:44:48 +0000 (UTC)
X-Greylist: delayed 05:33:53 by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3DE5686DD6
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 07:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsVNmDEWWsbvQiqDCLSuC6u8tCoDxuWMJQhcxPq2OqRIK6SYtXxBhuTqBRVP6tktnGzbg7ZbVwnOSldRbMUDT1Y3GM7ytuZ4XOD26gzAZ0sl0QPd0HNj8wUVMrXmWgo3j6R2KfEFWxlv/YpZR+aoV+KEEQ8mLdqkrQb5+Qabmg/rd/ekBwnTmbdvg+z7eqee2Mce+esIwdRMnqHJmOp61+REOWFSh+mc0HUzJpRvTfr4D+qnjffsoCta+OVsqkXDo0fi1eA7YE0iTusRZIp8Qzlkn+p2kVijKQ0pLWtZRUqZjSVqFxXR6G9RVE/Z7P0EMlHnWoxvEcthStC2SqxqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnvXIv/3ZVbXAl4FUa2YZjdkBF5cE9dElVs7TGy2lA4=;
 b=esj9oAcHlver08Er/gOgp32GxhY1dnPoTL8XlXqW7eSJSpbCF1X2KfvhrZr06tgSTpA+E978EFGEFLNLB+8BJEYVp0m4hBSv+ANQcxaHu5cjBgxa3BVMSMDnPzykd1BIJgOYA17kBPDA0wEuEgQn718BonTsKDViWRfp80oXVqi81T1RyHi4VngfDrpDdqKgTPazc+mPl6Kq6PVZ8Sn/4EYFrnoL3nFhAV/9Kq2dFIwKihycTiAp8tqly9jsi1WFrplCUAhdWsh0CP/sHV2/j8vGnpGWRZ3DKj2L18Im5tBZO8u+S+XQPx4skaMLeGGnPNp1CJlMGwg+ojP2WVse1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnvXIv/3ZVbXAl4FUa2YZjdkBF5cE9dElVs7TGy2lA4=;
 b=BGcGfD3PZo4ygnyvO8YoCRoTNe6kcD9FDNbxjKWzRy8KA+ky3obYU9RyF43w44zpAl7/5qmKo29FG1f98CDn81l9a+Gn+1KeKNkOwTHId/rmgtJdTEdJNWoRe7ZBvjh6B9a0mF7RjXyGmj071RcpUZLWHxI/TOZr/U6NWsAmlz8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from DM6PR12MB3865.namprd12.prod.outlook.com (10.255.172.206) by
 DM6PR12MB3513.namprd12.prod.outlook.com (20.179.106.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 02:10:53 +0000
Received: from DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::fdd1:4a97:85cc:d302]) by DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::fdd1:4a97:85cc:d302%3]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 02:10:53 +0000
Subject: Re: [PATCH] iommu: amd: Fix IOMMU perf counter clobbering during init
To: Joerg Roedel <joro@8bytes.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20200114151220.29578-1-skhan@linuxfoundation.org>
 <20200117100829.GE15760@8bytes.org>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <42c0a806-9947-1401-9754-8aa88bd7062f@amd.com>
Date: Tue, 21 Jan 2020 09:10:41 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <20200117100829.GE15760@8bytes.org>
Content-Language: en-US
X-ClientProxiedBy: KL1PR01CA0102.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::18) To DM6PR12MB3865.namprd12.prod.outlook.com
 (2603:10b6:5:1c4::14)
MIME-Version: 1.0
Received: from [10.252.73.101] (165.204.80.7) by
 KL1PR01CA0102.apcprd01.prod.exchangelabs.com (2603:1096:820:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 21 Jan 2020 02:10:51 +0000
X-Originating-IP: [165.204.80.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52a1de49-a639-4ac7-fe64-08d79e172449
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3513F405794340A7E33A9651F30D0@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(6486002)(44832011)(2616005)(4744005)(956004)(36756003)(66476007)(66556008)(66946007)(5660300002)(4326008)(16526019)(31696002)(478600001)(8676002)(8936002)(6666004)(86362001)(186003)(31686004)(53546011)(52116002)(16576012)(26005)(81156014)(81166006)(316002)(110136005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3513;
 H:DM6PR12MB3865.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZWP2E2Ls+Zea27XzaJLipftiiFDee2xlwU3ty7BDj5rcsIuhm9jo2oYWBST9P65Y/QkltoS2uDi0pBapy2TipmKxLAQinyCI/c/uMF07N3nEict+GHExYtQOY3Ag5V6+b2ZQszAQZJ8XPzc9HxLIzxZz505qhQ4L2mq5q3YZOmDuloh75PJluhE33Ey54IkRhm/7+9YDodvaKdpFgGRNL8fgywawBEKbFqSv32KB7X3WsVun6WUH1APvnfuRPAN0LF+V/dwQYSUms8KjHjT8uqR+k7302j6P/jBxdKh90R+QQspkLLW0vSaRINZYMyQ2gH+DO13FdmxH9Gjc0f9nYRNPiLCtzdcM33kwx3O4IWojnNL7uoQS+sWmss7aAOpr4cLA4YSQ1Rb3a9at4sIOsjvCLzDBMQiv46lcaoOiZi2Vu1SNJS93Yst91EzmR1i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a1de49-a639-4ac7-fe64-08d79e172449
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 02:10:52.9708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpR8fkVUvZRbygqcT085MhmO9RAsMBeMpC0fLYgrUdnY/ps4KTE0Tiw2ytPJjXV8iBhX2BG86M+Xf8SB8CMSeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 1/17/2020 5:08 PM, Joerg Roedel wrote:
> Adding Suravee, who wrote the IOMMU Perf Counter code.
> 
> On Tue, Jan 14, 2020 at 08:12:20AM -0700, Shuah Khan wrote:
>> init_iommu_perf_ctr() clobbers the register when it checks write access
>> to IOMMU perf counters and fails to restore when they are writable.
>>
>> Add save and restore to fix it.
>>
>> Signed-off-by: Shuah Khan<skhan@linuxfoundation.org>
>> ---
>>   drivers/iommu/amd_iommu_init.c | 22 ++++++++++++++++------
>>   1 file changed, 16 insertions(+), 6 deletions(-)
> Suravee, can you please review this patch?
> 

This looks ok. Does this fix certain issues? Or is this just for sanity.

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
