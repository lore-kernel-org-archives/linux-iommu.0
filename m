Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F62C5519F
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 04:19:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95CE2237B
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 04:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YTopuf67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95CE2237B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 159A72D946;
	Fri, 20 Nov 2020 04:19:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UinYEjtAyKpH; Fri, 20 Nov 2020 04:19:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6217C2A12C;
	Fri, 20 Nov 2020 04:19:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46EB6C1825;
	Fri, 20 Nov 2020 04:19:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6076FC0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 04:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 543352D946
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 04:19:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZObytIkWQOs for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 04:19:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by silver.osuosl.org (Postfix) with ESMTPS id 5045C2A12C
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 04:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJpj9GT+sBfzTjtbG63bBtpnASeX54e4lJGofATZNxp7uBdF8wjMj+IAY9Vzhp9RMZBixfML4EEnEjp2jP/j9NRBRQrayx+d3Bs4933Euh4u/nuf9q9MoI0X0urVse9zaliTrbZA19brfJqpdPOGV13ENoPxH9e/hwlURRj02+cqqgPCFz2ffvj9wwKDcUW9W28o2mON9Zqqlp9wjnUqzUEIYn55eC/vlxeVFZyy7M03UpTCUsMR0gVHS2OFC6wyfvpH6pTcVC6Ou95/8AnWbYWGc+iNjRmH/Lkx6o8ng7Q0BF90+aSN5OIrfgQuxguESzpH1T/1JvSRRE/4iQfmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKjTiIj0SVxRu9BJQyfbAJEwpy1uz4AUVDm+R6YX+TI=;
 b=iJr3iiHt8DW0tl+cy6ki4aGfqz/0FvkbEKAoFcdsO75tIRXQ7EFBigsF9RT6s/Qz1kv9tgHQ+DFGXS57q2tJQxK4SKf1WADEFJcPTMo1R6erkzNEo5yR1GZCNHrNIYlKRjSEuMhede4o3cL/GeCFYmdFtmRrjLkZYBD9exUp0pZdbvp/11u6IgHGE6SsB2bj4cyAQpz4VrGmePpgE1rmDxQRTOdgfNKoOaMwQGTBe8SKtyk5FK9Dv6pC6IySL2nCZpLVrn28FSEIc0hM+Qd6Q63UN3NfT8/AM8s0Lubq+KKpgyktOWkm1zMVAKfSAUGq9wdMJLKK9SGlObLxdtqgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKjTiIj0SVxRu9BJQyfbAJEwpy1uz4AUVDm+R6YX+TI=;
 b=YTopuf67/U6SG31Vx/0ZwIKlQrnW9L8aietVR7ht4Ka6Rycch81rYw5JzT2IO9XomsVK6T7odIV+4U9hQT770zx/XJa4mOaYUsDwBKwjlGMptNnipGgKhN+Yn2fdl0MvlH0cqwYYM2PoEpDRu0CFTA8gXt2jdvt4SO6CeftKYNs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 04:19:03 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::18a2:699:70b3:2b8a]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::18a2:699:70b3:2b8a%6]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 04:19:02 +0000
Subject: Re: [PATCH v2] iommu/amd: Enforce 4k mapping for certain IOMMU data
 structures
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
References: <20201105145832.3065-1-suravee.suthikulpanit@amd.com>
 <c189684a-27e5-c0c2-1629-063b9fb16957@amd.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <35c6f7d8-f889-8c3c-2e01-1a9226babf0a@amd.com>
Date: Thu, 19 Nov 2020 22:19:01 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
In-Reply-To: <c189684a-27e5-c0c2-1629-063b9fb16957@amd.com>
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA9PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:806:23::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 SA9PR13CA0062.namprd13.prod.outlook.com (2603:10b6:806:23::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.13 via Frontend Transport; Fri, 20 Nov 2020 04:19:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ba7db2f-69eb-4dcc-c2af-08d88d0b6962
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB441333C64B650A40AA274C89E5FF0@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0APLS97wMbKvj0UFNCBcHMHWwAfu/TQDwfh28ZYIjEnase23SFygRs1mH+j5dY3jplmnrd9BheGON4a//ifAGwldA9BFKmeJFTjyddayilwcTe/7X5JEWq9UcY+M/1Jz0shFuATcrTKB8XmcoEIms0p1n9m27BrAjfCiB0MmQRwCZXdpsQMeJq8aqRJL4rq2XYN8wczUAjAuNCUPL++NbVnsvgr+PBqrh9tHE7u8qzY+2rjHNF4d55YyAP+4WXRdF1LWhM65LSQSVDddKw5GbfUOnfA5YvGomLi2XyFzjexJ8jOlmRpb4DjbKGDsD3Xs0dhLph76rYTn/k0uGU5kJaVNT9crviIQ5D+lz481S6tH7fFD260vt7D7yeR7bYUnc4qE6Bj4rm3YJFELcsBxSPL7+5pF+nbysoQGt3iPEd0mGkAaAv7Sdj6vzRw4ssp2qOMD0ftaXE69gaUvEDGpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2718.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(2616005)(86362001)(956004)(66476007)(31686004)(44832011)(6512007)(2906002)(31696002)(66946007)(478600001)(52116002)(4326008)(53546011)(6506007)(5660300002)(36756003)(66556008)(83380400001)(26005)(16526019)(8676002)(316002)(8936002)(186003)(110136005)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SaQCS2ZyEKo7R775N/pbl6cXunTcY/J+4m1cD7RGkKHMH+F5WL+I+ERB8WHeFl/XM8QS7U+Pd+mIMqbiKhMEr9VAJ0cidE1USC7y4VxHkpGeMfsXAKgmdshfrnPPeqEnPaENVLYStzrq1e57N9h64+zcTMoLtgFXNnpKux3LHzLhkjmqAZ9XIcKJqAc55mi9UZHkvClT6LP1hm+TPcfATfjmB7tB0n/woMpP70DJGmVRFw+yqrIaSgEpZf+kR8eDZoq5PfewcOrgV2e6vkc3H/XfqBsgPNHQyLPCv2FPULHQcwTUgmEKzx8YDlTtGj/Xtmkgrnn8+rdK/4EXpMnAuwt4+uSpJv94vdBiF8TALibz50YXk1h42BLmBTwce+LkQOqRJjP0STv0iw6YG1H84aGlzjpCPVcbm9xQ+4BZHFli/jm8jtUIm1p6W6rZk3zvQXG6OYyTtPGHWYEoqXnSCUQgZ9+c4n3rKI+D80bOAaD1kqkJI6orHCehvwib9mIUnOyTn9HDi0YApGtY8YlgHWsda+YTQpan5phgUl92WroXEL0MciGaK0tRSrrtLrbdC+CSt7Rv4wi7rnPlzX+uRZK+7mmdo04GK16H6TLP1ffOO+K97rtvA5cLE7HRtEooud+WQnOV2danlaSzuxa/gw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba7db2f-69eb-4dcc-c2af-08d88d0b6962
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 04:19:02.8869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SL4lEg4H3QfEeWCY2VO3ns+8FN8u1mMW2rcJ5N0yC2HAfDUxz/Ks8daWdaEpllrfIDV73rS/fQtt5GSdvokjIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
Cc: Jon.Grimm@amd.com, brijesh.singh@amd.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


On 11/19/20 8:30 PM, Suravee Suthikulpanit wrote:
> Will,
>
> To answer your questions from v1 thread.
>
> On 11/18/20 5:57 AM, Will Deacon wrote:
> > On 11/5/20 9:58 PM, Suravee Suthikulpanit wrote:
> >> AMD IOMMU requires 4k-aligned pages for the event log, the PPR log,
> >> and the completion wait write-back regions. However, when allocating
> >> the pages, they could be part of large mapping (e.g. 2M) page.
> >> This causes #PF due to the SNP RMP hardware enforces the check based
> >> on the page level for these data structures.
> >
> > Please could you include an example backtrace here?
>
> Unfortunately, we don't actually have the backtrace available here.
> This information is based on the SEV-SNP specification.
>
> >> So, fix by calling set_memory_4k() on the allocated pages.
> >
> > I think I'm missing something here. set_memory_4k() will break the
> kernel
> > linear mapping up into page granular mappings, but the IOMMU isn't
> using
> > that mapping, right?
>
> That's correct. This does not affect the IOMMU, but it affects the PSP
> FW.
>
> > It's just using the physical address returned by
> iommu_virt_to_phys(), so why does it matter?
> >
> > Just be nice to capture some of this rationale in the log,
> especially as
> > I'm not familiar with this device.
>
> According to the AMD SEV-SNP white paper
> (https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf),
> the Reverse Map Table (RMP) contains one entry for every 4K page of
> DRAM that may be used by the VM. In this case, the pages allocated by
> the IOMMU driver are added as 4K entries in the RMP table by the
> SEV-SNP FW.
>
> During the page table walk, the RMP checks if the page is owned by the
> hypervisor. Without calling set_memory_4k() to break the mapping up
> into 4K pages, pages could end up being part of large mapping (e.g. 2M
> page), in which the page access would be denied and result in #PF.


Since the page is added as a 4K page in the RMP table by the SEV-SNP FW,
so we need to split the physmap to ensure that this page will be access
with a 4K mapping from the x86. If the page is part of large page then
write access will cause a RMP violation (i.e #PF), this is because SNP
hardware enforce that the CPU page level walk must match with page-level
programmed in the RMP table.


>
> >> Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion
> wait write-back semaphore")
> >
> > I couldn't figure out how that commit could cause this problem.
> Please can
> > you explain that to me?
>
> Hope this helps clarify. If so, I'll update the commit log and send
> out V3.
>
> Thanks,
> Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
