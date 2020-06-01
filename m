Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC704C433DF
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 07:37:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718FF206E2
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 07:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mHAS9FsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718FF206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE79A8A222;
	Mon,  1 Jun 2020 07:37:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRrYy1pcGg1K; Mon,  1 Jun 2020 07:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2FB128A210;
	Mon,  1 Jun 2020 07:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 235C6C0178;
	Mon,  1 Jun 2020 07:37:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74769C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 07:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 624DA87E9E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 07:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fkMNeNKdNPQm for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 07:37:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3CA9487E6D
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 07:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgVazTal5SsPFvnD6Novf/y6s9O77aYiz/FS9Xxfs8YyqDhuiAVX/+hS7r4nIs6JbLYiXfD2KIfuOtLYmPHVKe0osfYZquhL+jNsmpZr7fd0xwwPSsWeAhokfs+4frh5WuJgrb8hR5Efwk+adv3H6nSaF3vGdeQC4eckRU27cYlpml4EaGr1b2EsHUbAO0m2p3NO8pHnUOKxIV9xCPeKfxQxKdvOymuTuk0dRKa5aU5dBC1XSDopIWIToWxlWxhzcVIfUkroK3ry2UfvmwnN+UplhMPi4BApBycf5dpONztT0YRrokKNhGLzCf6HkadZGGGpn8Cw/v8mSseoBCwvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBtg4roFctlyhfPWFp6F3S8UVuy0dBTSMx1gwzga8/8=;
 b=hb4K8weu1oS7zmluir53sCaFGT3Qb4J5yl6qqUma6e5ldMcpIMXi23L+qvwJZhFv18qlc/sJZGDBPhzxFxR8m6Gp+I4mu8+uxYTeRUlSxcFHs3W8JSZOAq8f2ZgU5Bl1Z7tt0eCKtfxXI0fBosHwkRu5N8FReffCjGHC0iqJb90tgwLJEy/sj3Sz7gz62LJg5vlvLyZtGeyaNM9FBceShcj4cffqsCGjOR9Sdsyhc7hrFzsn3Rjg2IHPJXfMm8hmjEXpbczTGH7t9o4ulR4ES968iuGntstcB1jb61g/UTIKpcTxFqcMHO+M6obOyWtJky1eJ6voPUd3ExzgK0eT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBtg4roFctlyhfPWFp6F3S8UVuy0dBTSMx1gwzga8/8=;
 b=mHAS9FsXBNFW66R5DcsvrDvwa/zhd40i4Zx5x2PtC7r1lRLD+ZjKS18XYJjOrWYmFY/l6PCrz1O3Y5XHiettZpNTO9rxOJ02xIQm2k2Jr12YYy4yMIBlZDdygYVm/nizF6RID3iwi2q2wjN8qGSv8jDAOh58ZBT+0yHcMlpKbsg=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1819.namprd12.prod.outlook.com (2603:10b6:3:113::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.21; Mon, 1 Jun 2020 07:37:52 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 07:37:52 +0000
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To: Alexander Monakov <amonakov@ispras.ru>, linux-kernel@vger.kernel.org
References: <20200529200738.1923-1-amonakov@ispras.ru>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com>
Date: Mon, 1 Jun 2020 14:37:46 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
In-Reply-To: <20200529200738.1923-1-amonakov@ispras.ru>
Content-Language: en-US
X-ClientProxiedBy: SN4PR0501CA0093.namprd05.prod.outlook.com
 (2603:10b6:803:22::31) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local
 (2405:9800:b521:3edb:253c:7990:e60b:5077) by
 SN4PR0501CA0093.namprd05.prod.outlook.com (2603:10b6:803:22::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.8 via Frontend
 Transport; Mon, 1 Jun 2020 07:37:50 +0000
X-Originating-IP: [2405:9800:b521:3edb:253c:7990:e60b:5077]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eed48cd2-2a79-45ab-2834-08d805feb100
X-MS-TrafficTypeDiagnostic: DM5PR12MB1819:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18193845D03B207D4069CA60F38A0@DM5PR12MB1819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqjhsQdUN1yTrTJgaOw7tDfHzFWEqZFx6GzR/jtq5ppn8CZm5Og1yBpXCIOS/e3zNRKNgXkVohNoL7j5iy3Mz5dB0RnbnOL5Bt+qNdiE4VcPlXioNQFcqRmeQrRW42cR0ej/r+cJqvfnL/q33eZCb0NlOcQh5nRgFY1FUjq62KaCRgtwX53cTYj5s1mVcZ15DLciKvm5jd9JJP8cDWEEx+q+tGpyhEDU1u/Wol3wKnOWzn95oZEOjeG1DCbkZG8CQ84HtOhYoo8dbLbZsfKaitDrmbSYFMNl7gfHOHqGOUpabREOSvJRhVTyQ78egcIyZ/2W/MngGw8THr2lEfp1QhePhroJ3woICxTAoEACzGTgWOcdFEtFW/yo0xRBaItx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(36756003)(31686004)(6486002)(8676002)(83380400001)(52116002)(6512007)(44832011)(478600001)(5660300002)(4326008)(53546011)(6506007)(86362001)(2616005)(8936002)(186003)(16526019)(66946007)(6666004)(66556008)(66476007)(2906002)(31696002)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4E57VEbGr6UhP1LoacAIvkaOtQIDz+HIc1ZY9WGE23xANNDQR6A59hdNyvEz7PAwk6Wy0/nwCiVHd1gWf+RVxpfgTCZaGhjt/OiSyQBuGe/HDAGgLG7D9N90kY2tSVwtv7tdkID2nl8Ui3WaYVxtw++ZU+3wTLIFADSXtiWycETjBuwRvQiqgxT+fu7HdK/Oyzu//g4AIGU56xmoQ9TVIBLbrLhx3Vh5atTMGreWY+LKYxLhR7+KpVKwlQvzoVRnbBeGNTfYBPiAtNsMXd+7fqQBGFckb//rusgkrMt8+9kZGzs6Rq1bDknS9bya7gdpeuPA4VTSoh90qi6poLdv78zWMBn05GrNSEDJm6fGtXtvL8I3FM/uoydMt4em7iwKLkWOVCUNRKXJmo3blOxG6dg9G5aITHxUMk4UkCOFx3/dKfWc6oznl+wrSfQfpjU68uce9KqoRubBwZDfw5mNDgyPdLdWILJuGitbvLeRUpem9hVau/D8SNyKBoTCbFG26dSBvjd5kQ8cLf6GNTdwg+yzSHsnKHf0v6NcSeSO97OxFt3UkN+TSqXGXfg6T8k/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed48cd2-2a79-45ab-2834-08d805feb100
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:37:52.4163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN+/bQmiLszc8SQOs6DMwzWR6SJ6JfVMonsne8GgB76h+bLcIH1uib5WHjg9D4jrJPQaY+ObZ7c2doq/nC7Vjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1819
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

Hi Alexander,

On 5/30/20 3:07 AM, Alexander Monakov wrote:
> The driver performs an extra check if the IOMMU's capabilities advertise
> presence of performance counters: it verifies that counters are writable
> by writing a hard-coded value to a counter and testing that reading that
> counter gives back the same value.
> 
> Unfortunately it does so quite early, even before pci_enable_device is
> called for the IOMMU, i.e. when accessing its MMIO space is not
> guaranteed to work. On Ryzen 4500U CPU, this actually breaks the test:
> the driver assumes the counters are not writable, and disables the
> functionality.
> 
> Moving init_iommu_perf_ctr just after iommu_flush_all_caches resolves
> the issue. This is the earliest point in amd_iommu_init_pci where the
> call succeeds on my laptop.

According to your description, it should just need to be anywhere after the pci_enable_device() is called for the IOMMU 
device, isn't it? So, on your system, what if we just move the init_iommu_perf_ctr() here:

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5b81fd16f5fa..17b9ac9491e0 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1875,6 +1875,7 @@ static int __init amd_iommu_init_pci(void)
                 ret = iommu_init_pci(iommu);
                 if (ret)
                         break;
+               init_iommu_perf_ctr(iommu);
         }

         /*
--
2.17.1


Does this works?

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
