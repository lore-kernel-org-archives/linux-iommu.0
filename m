Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556BEC4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:34:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB2A2228A
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB2A2228A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6288886C7A;
	Tue, 15 Dec 2020 07:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4aWAVH4__rta; Tue, 15 Dec 2020 07:34:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C07DF86A73;
	Tue, 15 Dec 2020 07:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9189BC0893;
	Tue, 15 Dec 2020 07:34:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2878BC013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0724F204A9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U9cq7wSIdMJP for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 07:34:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by silver.osuosl.org (Postfix) with ESMTPS id 9D81220451
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjbY7F1oU8giI1EMpmA0OmNL3V0hrhfIJUKCAy+8efcaDQV4p/7ZgR7p2+01a/F0FkZcdWMfMDEsoRAbAZN+DgKvPr/TQl+JlnnobNmLyNaq9D+Qgp8yc8L3wYTFpl3jtuUIsJnVmTeun/ewgBxsMg4S/oDzR2NStQoCSkObmdK5zqNhHc+82/luSJ92K/Y/qsD8Fiu9iqz7fySHk/8Y2NjSk25dbJHcQDIpyj6veTYxL7f2IsvHnNWjViodlmzTo3izT8lC6avrlZZ+x22mWeZgggaaZj5Dnx6sUMMFfFGvjYeFVa35/XWwHd0/dmofyqhhyQucLIwyTdwiwlSiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XigMkIA509ljhQtbENzcu9iLwhB5cNvW6KYPq0b0z44=;
 b=JLtiLhwJDdSN2GPwp9ad7b7QVtUexOdRzvLwwxdc01SkMf+2RtDqPWPkuvheLEwEE1XsNJ8vODfOsvoQvBoRx5aAPMRi/J44kLukFFwhzIMGJKKmPDw5lhFRSs8PkA2ajI0sVRenwjxi6zCXUTJ1CvQBUri4KJ0sL4poVtwQ2qaRsyE6zLqjhLaeXPKi12xadb4lHs8ENQLyHwuejfoCSwsiLtjt+ZU/16lLjVWsrYVSxdD65d4mYaEzO37rZs2PPD06rqM1KPcDmvYFclq3Cl7/HqBn9S+O4Dj75eKmyvW/Ftr7ApOI2i4EBY6HnMECkIQWnoW5Qq3UHxi3a5OhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XigMkIA509ljhQtbENzcu9iLwhB5cNvW6KYPq0b0z44=;
 b=MY9xUsyo+QgnVv2HkFEuvQQ1Ev+laoL6yhJExc7a5DQRWSid0Mo7R0L+uxABggk8l4wTbb6puQEEhJlEPRxQhzMzLv1qaddIX51qjzG5txOCrJ4VfJRu/jXVrzm/BNiRmmoAy976otDaokKqw4jYYasngqK+ACMUI8YEkzsEKzU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 07:34:34 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:34 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 00/13] iommu/amd: Add Generic IO Page Table Framework
 Support
Date: Tue, 15 Dec 2020 01:36:52 -0600
Message-Id: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) To
 BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60de447e-dda5-4362-e43e-08d8a0cbde9e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37944257B7EEB290104EE19FF3C60@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hEcVyGGEtCrZ2ibdEd0aw/XXB7BAUaO5foQ/EbHIzQoXcvlpFG7kTc6ELUFHhTXi5L5zhjRCK8FjlnwTtvJkjQQAuRnjHcUksZ3AQDJ3gxFovy1tsb11ldx62mO5NSOkPZ5Z2CmRMw1VWTfKV0vzhfHRAHhdblXvbFTnJnkz0x2XU3VzuZmHp0rC45L3g14CurSvJH/vkdHCfN6iJwU2W29cn3+KizlfwIrqUajXrYNEDK3m4114j1yAxnrRhR1oBvMHmbDcqCcOfZaINwDHiHcS0MeWSQoCkmxt2IgLwH+5xEd7/EhGDGSGrtIiJanKo+IzYl9RpnTBOlpOB+1gUPThlEO83OwrPXA0KPpry0Pik4/7+ZzKy57Q+2GyXQoSRZOX7DFsBBaF1D+gKksUb57Gbzq+bmegCzMcMSsQxqiXe2UJXCN+58lBQQiIyLLvbHjb8AFLSdFnmmpoPhsKMFZZhNQMngvbWvYREFk7Vxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(6666004)(2616005)(66556008)(16526019)(86362001)(956004)(66946007)(6486002)(34490700003)(26005)(52116002)(186003)(66476007)(1076003)(7696005)(36756003)(83380400001)(5660300002)(44832011)(2906002)(8676002)(508600001)(8936002)(4326008)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ba/+uChY99AODYPc/LWUN8cJIrBXatWxZqnJMa6vaKfmeSY5K622LV6lXcCO?=
 =?us-ascii?Q?PX94KasX77Aa9uwjYrNCQNT3+xX0YM14H4uTGduyBP/SP99SdDf3w01qiR/L?=
 =?us-ascii?Q?pNUbFV08RFwkG2H8sWMPD6ocHBEwiHNBZysI1a1TsxtjmrP15lBynqrwRpRi?=
 =?us-ascii?Q?CV/cHT545Ni2mgzXOCMcgwlxgrcCJtUJ0WsFyt5pJryGspCedhxz0TXrKpCn?=
 =?us-ascii?Q?sXcvsSZpPwoebij9cwvUZXpdwU0lSQPsJZjXiYQiGR6qgK4MbrIXgkWz7Mn7?=
 =?us-ascii?Q?QjiVgfBfHeAqbx/8FwLzG/E/8bz4McP2TmXZJl3ZfSVuIu38MgKjj1VtxyLz?=
 =?us-ascii?Q?T+8vFMvIWwtnaQHj3WZhcwp/HKcp87aDpfOTT7E6qfHralv8A1VMKl2pw6R/?=
 =?us-ascii?Q?8u/X/D44avLwrVdaW2kpVNBN/yFGQfAs1z52ERlOxzSOmQX0gWY7VVk6vnfu?=
 =?us-ascii?Q?gd3uTKRS0hZ8AQLfjB+DMlV6O3eOgiqW6ekkbxPqhJp1CbDzO4g0FtDev/a4?=
 =?us-ascii?Q?OF7g/AzfcQTBDDBkGstV8iYhNAw4XQ/1EZxxAo/9+tHtP1mi6YtMmlCiymQQ?=
 =?us-ascii?Q?dkbIcpFK94vtx6p2gIhUPYa7/PZgBe87cB2BaRmnPhw6pF92qXx/1K8GhSsf?=
 =?us-ascii?Q?2Jpbe+NJvi9v48rjcHQi4C/Z7PEWIydsdYlhZn+tKMoJNWRnxBd+SYyuuoxN?=
 =?us-ascii?Q?aIYtcnf7qqm3hIU1q5DEn6GoLzV7i2UQ7B72e1Ln31yYLCl281RXbHkCuxIB?=
 =?us-ascii?Q?w8eFgNegeWssqGH0x0VreMck5Uy5nueJfZ0+XK9W3yMnomTzTZSh+ANW2iat?=
 =?us-ascii?Q?jn8G9aqtzWhVBEp73TWYC+hfE4trl4GoVj0CL1xhZw5h9wXnbu4c/kbDv1Wj?=
 =?us-ascii?Q?CA8+EHRlopoeMZMyZ8O42seyDvRcxBczqDQVI0dCU9UFZUFVoXosi9uGz0DU?=
 =?us-ascii?Q?6bVx3eXkfJTmTO5SxtuUJITUb/c0ECsNwmyJuvvvAv0TLP2JFLzeY2HehHgX?=
 =?us-ascii?Q?RU6f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:33.6681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 60de447e-dda5-4362-e43e-08d8a0cbde9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48YPaP2CJJSem4Jf+29+qfBAZOJmlNc+8r7g1jpXrPWpiRc9cod/7M8dl6jPSYrpETqBMXdgTkiSpCUafmhQzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
Cc: will@kernel.org
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

Change from V3 (https://lore.kernel.org/linux-iommu/20201004014549.16065-1-suravee.suthikulpanit@amd.com/)
  - Rebase to v5.10
  - Patch  2: Add struct iommu_flush_ops (previously in patch 13 of v3)
  - Patch  7: Consolidate logic into v1_free_pgtable() instead of amd_iommu_free_pgtable()
  - Patch 12: Check ops->[map|unmap] before calling.
  - Patch 13: Setup page table when allocating domain (instead of when attaching device).

Change from V2 (https://lore.kernel.org/lkml/835c0d46-ed96-9fbe-856a-777dcffac967@amd.com/T/#t)
  - Patch  2: Introduce helper function io_pgtable_cfg_to_data.
  - Patch 13: Put back the struct iommu_flush_ops since patch v2 would run into
    NULL pointer bug when calling free_io_pgtable_ops if not defined.

Change from V1 (https://lkml.org/lkml/2020/9/23/251)
  - Do not specify struct io_pgtable_cfg.coherent_walk, since it is
    not currently used. (per Robin)
  - Remove unused struct iommu_flush_ops.  (patch 2/13)
  - Move amd_iommu_setup_io_pgtable_ops to iommu.c instead of io_pgtable.c
    patch 13/13)

Suravee Suthikulpanit (13):
  iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
  iommu/amd: Prepare for generic IO page table framework
  iommu/amd: Move pt_root to struct amd_io_pgtable
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
  iommu/amd: Adopt IO page table framework for AMD IOMMU v1 page table

 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  22 +
 drivers/iommu/amd/amd_iommu_types.h |  43 +-
 drivers/iommu/amd/init.c            |   2 +
 drivers/iommu/amd/io_pgtable.c      | 564 +++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           | 672 ++++------------------------
 drivers/iommu/io-pgtable.c          |   3 +
 include/linux/io-pgtable.h          |   2 +
 9 files changed, 707 insertions(+), 604 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable.c

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
