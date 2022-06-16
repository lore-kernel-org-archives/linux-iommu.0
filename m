Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679D5C43334
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 01:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0036140C35;
	Thu, 16 Jun 2022 01:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EHpDxsy4zNrS; Thu, 16 Jun 2022 01:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9EFE640194;
	Thu, 16 Jun 2022 01:56:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80907C0039;
	Thu, 16 Jun 2022 01:56:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF06CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A3B2610EB
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gzz9KOJHYGg7 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 01:56:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1985E60EBE
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iazJ+1jula/OEQMxd0WktFaGWq9LAkwWibNzZFispOXzQ1MZgxgB20aY4Njxnsrni5nDmrAQ2aaEGnaDN8tKZo6cnjcad8MirDbqpgAkMeO8sl7BI6bIHPrPM5Cju9g8Zz7Y9S0wCxgBZrnyJJs8gWyxsaAhJCRZhIPtQqycHVad8opXvwfpOdHaYHcXd8lUScYpsraFOfVJQX1lDiSSXjGWiyl07O4QV0W6TIc/8ThV6qTkCfAPZVT2VB+C4jDS+3ozyhv0Gk3JZvFeVwo7KQxqQ4U8NMCyLFrrpLAABpSbFqUQpJu8Cz18K+ZGrU7LQXbaj1E4cryu97bbNXO7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6it8o0CDHikSuJ2grZSx+kk1l7QzP9Ktlo/z7ttUkSc=;
 b=iI7dRR/Rf2NSd/QKPk51mTQ/5pGvnaDTWpIhBRVa1/7iU/WrrJE9Ba0K9kGQE0N76zESLY1ncO9D577XwWCHgha5fUpXdMa+/sZkiXmTjnhX25fXAx1s1sRS8C+Bmaqt7eCa77/YBmYA50j8SX64lkzyFCFupf8JhcykB3CyBU1yK0F/ClBoVt1MEMa2FnJhPHXEvRjnPs/DDTiBCvqqjs1DUi9IOOZaCyS7R4ZGLHRK+MccaaeYByKlojU1W09uTi6B6JipKazUGlIEpmsFKQFX6pPS99yUFQZgw4+T42DfXflKa4CKkq/cH8OxNETD/avLgeRH7zy2iaOkX4RA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6it8o0CDHikSuJ2grZSx+kk1l7QzP9Ktlo/z7ttUkSc=;
 b=tNQXZKQ7JCkntZ6x04klp4CpUa7uj45r51Gd27d2Ou2ijgJGcOSiLINF/zHhGd1ULoXfo3oPdh3cERbOJkBSvS5da8de6khcTkjiC16Tk7WJU1xgBV9SQIZ/Wjq0FQo1hrfUqKREHXZuKKaizgDLwCx7/l5u+EM4q4iK/mxfde0=
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Thu, 16 Jun 2022 01:56:23 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::18) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 01:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 01:56:21 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 20:55:54 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 0/7] iommu/amd: Enforce IOMMU restrictions for SNP-enabled
 system
Date: Wed, 15 Jun 2022 20:55:34 -0500
Message-ID: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29b7fab9-110d-4b48-d167-08da4f3b6986
X-MS-TrafficTypeDiagnostic: DS7PR12MB5936:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB59368CDF264AD7C8922D38E9F3AC9@DS7PR12MB5936.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjs99w1SEfDsul2qHVzVOz8HLsw5zyhkhxwUTm7T6EqyQ7gOBdEmq2cbWUqZbHwUuSIZVAfNHslX95drpq7mm5HGQnpbFh8xCbliO3g0FtBUG5PZWxxQrWxQNmzLC/6gHZVIQti03xkjXCXbhXStWW+FBIqsV+8RkSeQKgy7YCgQe7bS0i0/3X1V5fZR/HUVuS8oYCdpTlmshyR/z26GsXSPn/Z1rx6WforTUJKY2SHnZKgeTao1ZgpQWXp0zlKsCMv4LLAPypUO2Lu++Cub/tcKq+6NGogLum+3+dy+0bUYZPGC5wPPMUQ9hLIJWJLOL973RRiHdvqNb0mSrhirKKHJyqzi3oJWemi+pT9blvxpWewQdos05kBL5llr5U/t13N5a8Ev7qpvel1DBjEYvku9sJBRgiqDcGKS2trVhkBGDUtXxRc7Dc2qZYdxAGTuPWnPfrzOzpxOcUnkR+eNi6GO6pVK/xnkwYkCS5RLdFOhcqyV/SExEH7thq+zNKjTiFXzStEaNQUKccokw9KDi4NyJrXDNjvDWm8uizht+hv0WYD4QL28AQ5v3rkfP5Qv/bx2ZOnahlTwdEpFAzCyIJXCxyQ55m1Pztv0Qi4X/3GeSMfAzbZ+3JLIHUUeooVGHbyLtdJTD4gBWpPSKJbJV0sCLtiAa+NQI7Ejg+ZB15BOY7bUZiKJXZomEEuY3XiMUomwOWsn5jmir3iPhkQb+uhJ/dObxbELBQWPdEbIVT7aBUDj3DsoEe/HarYgpp6cWtyoXEQk0e3P/r2/4441cwOTB/qPFQ9U7/5M1Y5AkjcuhVlqhUS8gb7ZzLOv31Tojr+s92Gm/hBUyiCJHrbrpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(7696005)(356005)(6666004)(2906002)(40460700003)(8676002)(86362001)(966005)(83380400001)(508600001)(8936002)(5660300002)(186003)(70586007)(26005)(44832011)(54906003)(2616005)(1076003)(81166007)(336012)(6916009)(16526019)(36756003)(70206006)(47076005)(426003)(82310400005)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 01:56:21.6423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b7fab9-110d-4b48-d167-08da4f3b6986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
Cc: thomas.lendacky@amd.com, ashish.kalra@amd.com, vasant.hegde@amd.com,
 robin.murphy@arm.com
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
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SNP-enabled system requires IOMMU v1 page table to be configured with
non-zero DTE[Mode] for DMA-capable devices. This effects a number of
usecases such as IOMMU pass-through mode and AMD IOMMUv2 APIs for
binding/unbinding pasid.

The series introduce a global variable to check SNP-enabled state
during driver initialization, and use it to enforce the SNP restrictions
during runtime.

Also, for non-DMA-capable devices such as IOAPIC, the recommendation
is to set DTE[TV] and DTE[Mode] to zero on SNP-enabled system.
Therefore, additinal checks is added before setting DTE[TV].

Testing:
  - Tested booting and verify dmesg.
  - Tested booting with iommu=pt
  - Tested loading amd_iommu_v2 driver
  - Tested changing the iommu domain at runtime
  - Tested booting SEV/SNP-enabled guest
  - Tested when CONFIG_AMD_MEM_ENCRYPT is not set

Pre-requisite:
  - [PATCH v3 00/35] iommu/amd: Add multiple PCI segments support
    https://lore.kernel.org/linux-iommu/20220511072141.15485-29-vasant.hegde@amd.com/T/

Chanages from V1:
(https://lore.kernel.org/linux-iommu/20220613012502.109918-1-suravee.suthikulpanit@amd.com/T/#t )
  - Remove the newly introduced domain_type_supported() callback.
  - Patch 1: Modify existing check_feature_on_all_iommus() instead of
             introducing another helper function to do similar check.
  - Patch 3: Modify to use check_feature_on_all_iommus().
  - Patch 4: Add IOMMU init_state check before enabling SNP.
             Also move the function declaration to include/linux/amd-iommu.h 
  - Patch 6: Modify amd_iommu_domain_alloc() to fail when allocating identity
             domain and SNP is enabled.

Best Regards,
Suravee

Brijesh Singh (1):
  iommu/amd: Introduce function to check and enable SNP

Suravee Suthikulpanit (6):
  iommu/amd: Warn when found inconsistency EFR mask
  iommu/amd: Process all IVHDs before enabling IOMMU features
  iommu/amd: Introduce an iommu variable for tracking SNP support status
  iommu/amd: Set translation valid bit only when IO page tables are in
    use
  iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY after SNP is enabled
  iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled

 drivers/iommu/amd/amd_iommu_types.h |   5 ++
 drivers/iommu/amd/init.c            | 110 +++++++++++++++++++++++-----
 drivers/iommu/amd/iommu.c           |  28 ++++++-
 include/linux/amd-iommu.h           |   6 ++
 4 files changed, 127 insertions(+), 22 deletions(-)

-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
