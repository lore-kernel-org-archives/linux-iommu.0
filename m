Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A187C2D0E4
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 11:21:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D6A246B2
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 11:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zFFi1S3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D6A246B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 193B8873E9;
	Thu, 19 Nov 2020 11:21:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H4Ff7hSuVFKF; Thu, 19 Nov 2020 11:21:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61AF88731B;
	Thu, 19 Nov 2020 11:21:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3249FC163C;
	Thu, 19 Nov 2020 11:21:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B097EC0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 11:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9297186CFD
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 11:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LKmd8XSbZQvv for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 11:21:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A5AB086DEC
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 11:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gcb6mpqRyJDCe+lxBwNppw2xZmHcQj5yamlm7yg/7xLZNxvmXhxy6Os/N23ZCoBG/97fJxczQdkOfFFnNgVql2wySL2H7avwELWKUL26YU4iK5ZvCsHJfhgkpRRrzPpG++tsh/smm+3a2+ZfxpzZZEte3++u0mYbXIBaA+/cPdI9uC3KbfRDrywQbtKDmOd4fTLfMeEyn6TqRHSiuUZu/KBEzk3NUeo6KrrZZrBtYkryHO18DhHNXXiSIMizvls2Ffbe88TifCrX4Ijet/KPYDNa3fcumhZQsgrt7HxmNB4aAYkZ5jx0WPUTFGmddIxCAROyBx8bH5oOG7X3CmJP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUm6hmy2/PaLX1q5VosdEqImBYX/q7smwnPEC2hzuEA=;
 b=kIdSztfwzKP8asC1zsF+AKqkTqb3cOYFOeyTAMv8wl/lcd6MyR292jkPdGevjMOWxOn72suPxgxWPCXwTDHhd1rQMBzw8PitsXis5hyz29YsuXiXWRMAv7/lCB8LaBtLu6l3IPEGrR0ZDQWJzMUnNBzheZV2tDNKo/n0pJKc2boJ7VdDhxWtU1nNcSe8KAqKF+tQ0oI0pf73/y2pwNc4mRKJ+8e193IDYlhAfNd8L2Tm9d/ZZVdeCf0Avh5dtjz8CjsWNESTFpP7vt1AsGmcOJS4HCkDi3mntpi+ZwXqpeABDrBSlA692EoMk01rCtMmiami44al+SupC8nq6HoZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUm6hmy2/PaLX1q5VosdEqImBYX/q7smwnPEC2hzuEA=;
 b=zFFi1S3bjO8OP8YIDF6cADD3gAZpYgElxvcWEi41VADgWNLacUMBCC7Ub7jul+oN27WMx+WLZrPnOIbDVjVZbtwaHEmrFfClAODapZcyv84/dlEMchXmSTM/pt8xrutZT6dkmfyaH0eMf2JIwxTwe5BdO1bg3EWb5jPmHnIyWZg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3061.namprd12.prod.outlook.com (2603:10b6:a03:a8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 11:07:15 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3564.033; Thu, 19 Nov 2020
 11:07:15 +0000
Subject: Re: [PATCH] iommu/amd: Enforce 4k mapping for certain IOMMU data
 structures
To: Will Deacon <will@kernel.org>
References: <20201028231824.56504-1-suravee.suthikulpanit@amd.com>
 <20201117225717.GF524@willie-the-truck>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <f66874bd-7396-1a6e-4175-f3dca9642894@amd.com>
Date: Thu, 19 Nov 2020 18:07:05 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201117225717.GF524@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [2405:9800:b530:f552:3c90:71a9:614d:285]
X-ClientProxiedBy: SG2PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:54::22) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local
 (2405:9800:b530:f552:3c90:71a9:614d:285) by
 SG2PR02CA0058.apcprd02.prod.outlook.com (2603:1096:4:54::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 11:07:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2aea9dd5-d300-408f-a52d-08d88c7b456c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3061B1560B452B08B187FF21F3E00@BYAPR12MB3061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2aP3XjMY6IbtV3nFJ9h1AqTifQxlwJYnDCW94OKlT94iMI4Q9JSOlFlY/+eFL9v7KxFq2SSxNxI+ygN/cuHkJKCRaUv1eBlfgpV+zrWDHXoIVLASWkhcJTqLY92uvth4xGmOkO6uxogANsqNgy2ZYAtOtNFShK6fU0x+opcb+1a6ifvYntVHsLiIMOg1bSitbcGPEkPewKD1Dh+5iog2t80cvVzObCCnS8tZNT7BxeFmh4SvOqNsaiQf+hSIr7xzIAZsZ340YZyUZ4OgDQ2yhfy7QafVBfuSQgd+5ZWGnuO86WdIDQCA7PF5iFfozQybwnaH+tbjFU7lTPaPwZ6qn3YmFHiy8AHSkZ8mi+QT4ehyzGjv39rHEI1GHQpsSFHsInF3oloJYtGycFFFhM5BGnI1xrPftksSHrP1uKfrfe5+lTW8py4WL3lg8AFETgVMiIZE5otbQq5zLpNRy1k0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(44832011)(6916009)(52116002)(6512007)(186003)(86362001)(16526019)(4326008)(2616005)(36756003)(6506007)(53546011)(6486002)(31686004)(8936002)(316002)(8676002)(478600001)(5660300002)(2906002)(6666004)(66946007)(66476007)(31696002)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0Q63rETMi/9E57xQwUnZI6Wm17ESiqbPAQO4hB0lcvdSgu46CQFrEEWEzI5ZOj8YneS3cPLgNfAkO3P+PzKJthwA8lnXpsIHFmIE9uLmI8uPAqg1t0UDCgcpBD/641nSglz4ajnIGbGoeILi+3/5FzPv9oq6C1qsNApBO3CYSZkrj5EroZifHSXBkztft2498fxz/k5eDpDgGKu1yIv/9ZJWRQfGW092cwMbaw/qoaMVaQMO0asS7trqtDrvTQQc5XhgDjj6cepb+04oYXOIcKzlaekSum6+hTwq8B02rpWLvxoS1THT2bI1XFmubXjuirRnMHZiJH95o1yUUEjpw1xhQE1z4sN8mnT8IkiMYqYsWlbeO1FB1mKWuPHKNn0nIo7SVTId3w6NM5VMeKcB3hN4IduGTOU9g5VsfpOQC/8SZD8tMtSDS1I3Hyr2mRsUgsrTGSx6It15U0wyA61rSScE8I2++GqaRsjp5iV6o0Nn58gHtljVgim+g0ol5c1mdcu37llYMNA1UPSZRNZGeARAToKs2eZTgRoyYjVu1bq54pog2kdbiAxWZhjuQUR4P1DdFuoFIoTNVj0abRWG3VEpFzfvkw91cNZS5Cl4kBgcpyUtWxxkqglVRHWXdZXBNXzpVbLyk5MqsWIiOI6q2Ma0mdAohO+lHRf8/530yIbsmyVU9YazHtrWMCBMOdYLrpbvsmPOAwqA1gmGBHj+BA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aea9dd5-d300-408f-a52d-08d88c7b456c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 11:07:15.6743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ehQrQ1isB5hWxa9zwHXsKTqMx3JuP4qFB2SFjs/ZkTbrOsAMv9uJ7WYR1SF9xqNi748it6bZgLxc82iZYpVEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3061
Cc: iommu@lists.linux-foundation.org, Jon.Grimm@amd.com, brijesh.singh@amd.com,
 linux-kernel@vger.kernel.org
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

Will,

I have already submitted v2 of this patch. Let me move the discussion there instead ...
(https://lore.kernel.org/linux-iommu/20201105145832.3065-1-suravee.suthikulpanit@amd.com/)

Suravee

On 11/18/20 5:57 AM, Will Deacon wrote:
> On Wed, Oct 28, 2020 at 11:18:24PM +0000, Suravee Suthikulpanit wrote:
>> AMD IOMMU requires 4k-aligned pages for the event log, the PPR log,
>> and the completion wait write-back regions. However, when allocating
>> the pages, they could be part of large mapping (e.g. 2M) page.
>> This causes #PF due to the SNP RMP hardware enforces the check based
>> on the page level for these data structures.
> 
> Please could you include an example backtrace here?
> 
>> So, fix by calling set_memory_4k() on the allocated pages.
> 
> I think I'm missing something here. set_memory_4k() will break the kernel
> linear mapping up into page granular mappings, but the IOMMU isn't using
> that mapping, right? It's just using the physical address returned by
> iommu_virt_to_phys(), so why does it matter?
> 
> Just be nice to capture some of this rationale in the log, especially as
> I'm not familiar with this device.
> 
>> Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion wait write-back semaphore")
> 
> I couldn't figure out how that commit could cause this problem. Please can
> you explain that to me?
> 
> Cheers,
> 
> Will
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
