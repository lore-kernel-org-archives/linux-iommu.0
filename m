Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E9C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:58:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1C9206DC
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U8f9wL8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1C9206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5D13886924;
	Fri,  2 Oct 2020 12:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GvYKiwNihMsm; Fri,  2 Oct 2020 12:58:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2701868FF;
	Fri,  2 Oct 2020 12:58:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFE3FC016F;
	Fri,  2 Oct 2020 12:58:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35D37C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1F714869BF
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:58:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mswCwrN+80Oz for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 12:57:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750074.outbound.protection.outlook.com [40.107.75.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BAF25868FF
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cntq5P7DFgvzdiSj3k7yrxxK26XtBdDVW+cRsEoySxdyeFNFSA4pXv7Dlv5PT3gV2vN5ZPpYfNw6yloUx+BfrzbKiM1xcCtO6asbPtNXyTPi24F13/lv0cd7kM+cVAYMbxibu0QdxAuJnS8KvuZzo6yZbyfWWG7QsFx0JjBKcLidWXYNN03lxBojYPt5IOANE+xjk4bzKw2mWmE1pXqH58UkgJ8x1j/8boSczK+MzVlXbe4zvVCQ4Zc9aNeCjqVOC86BHfWosQBjqbb2Os9j+2z23rQAFKJwrpvI39Vn91FizkGDbfsnDY7pCZiaKOrcLWRlsvorFJX6tu4bXEwMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xAMjgU4/Jb+5YynW/R6bSmnTNyy0QnHfpYcyjB58zA=;
 b=Vamw4ghgyYrmsxRVIUKUDouN2mTBYDfxOesaWOzVp/Q5UL9B6D1Zu7lGMfbDRo0OFPAOeKGho46znnmeYPkn/tixbuxaDmz2VphSFReL4Re+Hr6ASW4WF3E2phUZG4CPFDfLhgXbJEVvjRb72MVkXgG9SujrEFT5KgMF/z2gev/cNAZhxD9YrXIuhRb7kZDPB17qDikhxajAWv5Y5HUHBIHcFHcmuxJmn/8C82uwtQdPe1J0hmBBrD0AHzuztVKiNRv+M15CUreKtFHQ0X18Sw1kXpBH8Z/VI2qMBH4i0GO+yU5ggRFqMxv5ZYvq+V+IhegDFlPr6TlG4xr87rOHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xAMjgU4/Jb+5YynW/R6bSmnTNyy0QnHfpYcyjB58zA=;
 b=U8f9wL8Uos1fc9SqvZ2VjlZPGusEYbrSqu+VTpcwEOqZ6Lw5LPiGfy3DTxMRWxt5HJOBgKKHW8Ewu/NsaqnqItO2XlW/tUfC6YSyhxiCEQzztMeE/yzZ43aWvQXKd/j8FJ5kkjgNVKggSIkwzCZW3veVCjcEdXC3RGwWJtARHmQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:47 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:47 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 00/13] iommu/amd: Add Generic IO Page Table Framework
 Support
Date: Fri,  2 Oct 2020 12:28:17 +0000
Message-Id: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3459bcdb-5cc4-4ee0-d3f5-08d866ce26ab
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1163345D82063D554A798863F3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYCuJ/3B1Dt/fSnJLuGgNKTO0r9uWCq53WX5PVBY2VTSbmSfEqVEeS4slzI8uplR8eOjelnmjCXV2hqbrBS0XRxIxu+fDQPrOO+j45vw4piGCHUwYz8detULxH59POcTwTFVRJ0/P+YecI7rl+4KqK98cR52dTxRJrYPnNo3y4IGZxOJI/2c9AZ57LhTEpCDCAdpUCIKYNdkVE9mgCiwC78PMEugjeZKU1/71ySbOpYiqcU9zxnPp+BC5ZUz108zJ3sF/f8dkYGd4p7GT2cfBvSM62jhskPNYDrs1XruqJl1EndabmS7IvGSQohW9YOLKhusENWy4PWaDoJ4d5QSfg5/Lsjz7rsG72v2hojMe98v25lDJO+/YrW/sEHuUJWKLZMs6h/KhaDfPzIjSvveqsvLxMXFUTMQkw/ks+ZO7yudNcXXtvHQ03q2LHcV3t2DOfCvF3q90RiZ+TfYF8s0Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(83080400001)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AyitTRIa/l1MnEmZXL1EjQn2fE1/Ec3GAnsH9sKzvxX8c3f/ybuIJzaSH7e2B6UxtBd3xo0094U6UQ4e5+RN8F+xGNzTWRYrWSa0BPdsG+szpatDBWUnrxl6fQt8XFvgKIbJhe2kVvz0GS8hfeFdn35Zp0W9gWpEAYPAcYuN2MWDJNPu41+iivfPnyd2suadqlJzFqJResqv4ElpnB1sXeOVtVrT9uj4/QmV5gfDocbfjf1ZpljsxOy78s9djga2ZAxqUPBUIwLpsQ+ghkpJgIhASJglb23IH1vQIOyTSUObDIjdFLM8sIx9lMih0sluCwZrCzPflc3VtXVepSfxU29/PQtImVKYP7ZIopSBnIH0BTJU3Aj9hwzAJ97g48QnygHqFKgKtpgJqxhjQDV9v9KidrO1sTFUdQPUI30sT/c/WWmhFzF8vV2G32yBTO7ZAvo6FFSsVipdixJDPWnRuVgvAjG/jCBV/u5+6MAbmaSu2g0vuFaFA9na1MdhHqHPnfUj+/+0iRQPdgjbrB48tPwVfDZccartLcXA8ZONvIHqVrbALoUnRDWfok/HKLLbICcqcgCxqK50NJuOhMKwf2tduSdcg+YFTXv+aXVMJ8xfxVB0KFTT4YqJA2Fpuog/w736JxR/GWXWey8PZtL2dg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3459bcdb-5cc4-4ee0-d3f5-08d866ce26ab
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:47.4015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjjfmfXmimdBqUlaq75P0kryBndQV1kJ+7LPmCb4A/SX7Wtmvy2oko8lNCLsOf0hJh+CpGV4cIpgYEk6L05sjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
Cc: robin.murphy@arm.com
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

Change from V1 (https://lkml.org/lkml/2020/9/23/251)
  - Do not specify struct io_pgtable_cfg.coherent_walk, since it is
    not currently used. (per Robin)
  - Remove unused struct iommu_flush_ops.  (patch 2/13)
  - Move amd_iommu_setup_io_pgtable_ops to iommu.c instead of io_pgtable.c
    patch 13/13)

Suravee Suthikulpanit (13):
  iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
  iommu/amd: Prepare for generic IO page table framework
  iommu/amd: Move pt_root to to struct amd_io_pgtable
  iommu/amd: Convert to using amd_io_pgtable
  iommu/amd: Declare functions as extern
  iommu/amd: Move IO page table related functions
  iommu/amd: Restructure code for freeing page table
  iommu/amd: Remove amd_iommu_domain_get_pgtable
  iommu/amd: Rename variables to be consistent with struct
    io_pgtable_ops
  iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
  iommu/amd: Introduce iommu_v1_iova_to_phys
  iommu/amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
  iommu/amd: Adopt IO page table framework

 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  22 +
 drivers/iommu/amd/amd_iommu_types.h |  40 +-
 drivers/iommu/amd/io_pgtable.c      | 534 +++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           | 644 +++-------------------------
 drivers/iommu/io-pgtable.c          |   3 +
 include/linux/io-pgtable.h          |   2 +
 8 files changed, 656 insertions(+), 592 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable.c

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
