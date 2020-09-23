Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26485C4727F
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7972145D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RKR7oI1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7972145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 00BB386119;
	Wed, 23 Sep 2020 10:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FKSYhSMouMF5; Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49FB185546;
	Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C32DC0859;
	Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADA9FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A2B7E86E2C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MhemU-hPcWnW for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 888E2866B3
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxsFtm5gafbPdfJBz6omnGXIBRduCFvZqdfiRl88CGsuiLauYalDrX5yPgHR83uVx5/TQVGVqy5uqM9en2sKkpg4SLEvdESe16/3HGi1hqwJRw2DKZ0OFEg4z6U1BBClcWPm8Riz+l6OwmMw+On7hqSZgJpGh0uuOvLN/ucp+4zHQyVtNG7rf5dcZ9tx1uc9FloadiSyWwwFRSi8BIJjRq+XeYK7271XOW+wwRqhbo2E4f7KyIDR0gUNG/ABtt3WbOXSBY7tj96nUnt3W+5pgEnFWpI/pAl4lSMOaWPdsFNMi5rP4KtVDKvIlIK/WJdJx0unyFKnbU3B0S9JL/EElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMjt4bR8ugA/pWY6sFhpNVjNoB52xbnYhgA8Yyx8vB4=;
 b=AQGRP+mgCrev+NbWq9PRgzM5k07EI/Pl0q63qxBVi+/7IrrwOUxW5J5K4vEZy3hjTFoGSrKwvRY7AUwqC4EPra4zYeO+ZpWBSuABRaIBSXeKtl7WFiCmupqs03ebWocMX0Onh/X2RCi3G2kUiwMOBXIK9Fwt1MzLEqcNB/wyDzqmPEeArl2K53jFebcMi9Qe1dyGCY/2MW7tTzS+gJVOGoIn++/Bh8dz9uNE/nnEtaIF5Tt0I9hjVx9OHPJaoT1WiY7pywDGL5t/VkU9TLa+AdgssWos5vuHwnoS1B4V4uDXJeCqoXNEpXxO0qgUcnEJNCqE62vWLMvyYecbFVaJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMjt4bR8ugA/pWY6sFhpNVjNoB52xbnYhgA8Yyx8vB4=;
 b=RKR7oI1Zgft1dYqC4By6aooBHvjXs4vJP8iLITBGqW2FIgVbKA+dQ8WbTZVP1SWsyibg0ONIjZ7k4vRgvomzaBs+7j1LG8JaPPiql+jNHa29ubN2VT+vXOuqqIKgzYTxQr2IpRWn7+ldH0482gQjVDkvs81yALBHM/p4uawb55w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:41 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:41 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 00/13] iommu: amd: Add Generic IO Page Table Framework Support
Date: Wed, 23 Sep 2020 10:14:29 +0000
Message-Id: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0601CA0003.namprd06.prod.outlook.com (2603:10b6:803:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 10:11:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 311f2f8c-63fa-41e8-1456-08d85fa910b5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34665D7049CCEB153FE48E8EF3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y970hZbylwMdxokbEtSp/mb8Yhtcp+vHRRHCTqHVQ2yHKioJg2rs05aIJZRR8ewMn/eaUMLiKWOAUeO2B7AoZYnpVA7UZpmR6cHCVgt5+gvcr78hktdFmTg0kfYxDKW+GqU37Goce7Xly3HNwIV5TMkhhMwR+PezGtN1RCXMfhZ5xx2NBtVjH+lPVPiwQ9czAD5XMcWrwp/TdluAa0HpnjQUUaKlJqO2Fdbr7IXGCT9QeywvbEoXjmq6qZOgN9aMryKUdi0wg0BrTmc90RvM3YlnL8hh18ySnaW5KnV4SeVh2dG8T4/5kcp8Eu4YzKRI+SPuuTBIexxCzA3IoIj7gdM/uZC5HtlcvfLzqDHaTsUeeDr7HYtKkKRHp6u+1DRy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 95BItsgXFaIGOnF3IIggX23Mfj7cWxUn4yMDJZ4TC4v2wDQ70R5ob3XBeioNeXVM2BoPJmhMOPcZICmLuxmrMyiEzch5tipZAvXcoK7ucPfxAp598dYeanRdLq76owtXc/jivPsJpsOdfF//f/2TqJbnTWRGmH9ckLK/jHaUCvxYf23R2PClVaCCW0wXIURTBgZ2+U1/N/tYafZ/9RicD+ioyARkXie9in8+1sP19ZkHO7VK2K/zUPrWYHKaqDr5FyYtNT5TXkX6OFiyyFiwPcqCuFHj8K7GVFbxUub8PjF9QHrql9ixz5x6RZT6+7fZ35yMRK6cAL30AsIPt3+crdhcEwxbaGOkE5b7y/LFdtLHUrDFgQMZwVvURwOtP5jYcj97PjmqpmkZMK/YI6wuOcy9jH3dTTQngk0nHiRiXC2fDNvVeFEO7AqxkUIJfNV7481yILUcyJRST5zF9fay/UktaY+XxFtU/NZF51LvZX8HnRLqFxM+6QoQa2Gcy00afojURa3RouZKe/sK6s4A7LnbZbHuWArz3FFH2B5iQYmoiTPtyZQZY0v4KqvaWa3AL9DuIC7guAUM9x3xmFobluWN7NhvzTKkNAhPGX0BkfcWo6LHbLU309IcudPS8Kn632jB6xQOMAxCih8rCqIS7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311f2f8c-63fa-41e8-1456-08d85fa910b5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:41.1517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFw2MI3VcOFraJIIKkrbqId97qA7I7vNDcbdwCXgz2WzY5r/mXQTnafTzH+M1+Im0E3aFVCBQZHBxWdECfPx6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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

The framework allows callable implementation of IO page table.
This allows AMD IOMMU driver to switch between different types
of AMD IOMMU page tables (e.g. v1 vs. v2).

This series refactors the current implementation of AMD IOMMU v1 page table
to adopt the framework. There should be no functional change.
Subsequent series will introduce support for the AMD IOMMU v2 page table.

Thanks,
Suravee

Suravee Suthikulpanit (13):
  iommu: amd: Re-define amd_iommu_domain_encode_pgtable as inline
  iommu: amd: Prepare for generic IO page table framework
  iommu: amd: Move pt_root to to struct amd_io_pgtable
  iommu: amd: Convert to using amd_io_pgtable
  iommu: amd: Declare functions as extern
  iommu: amd: Move IO page table related functions
  iommu: amd: Restructure code for freeing page table
  iommu: amd: Remove amd_iommu_domain_get_pgtable
  iommu: amd: Rename variables to be consistent with struct
    io_pgtable_ops
  iommu: amd: Refactor fetch_pte to use struct amd_io_pgtable
  iommu: amd: Introduce iommu_v1_iova_to_phys
  iommu: amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
  iommu: amd: Adopt IO page table framework

 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  25 ++
 drivers/iommu/amd/amd_iommu_types.h |  40 +-
 drivers/iommu/amd/io_pgtable.c      | 580 +++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           | 630 ++--------------------------
 drivers/iommu/io-pgtable.c          |   3 +
 include/linux/io-pgtable.h          |   2 +
 8 files changed, 691 insertions(+), 592 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable.c

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
