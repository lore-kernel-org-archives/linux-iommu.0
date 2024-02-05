Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5433E199A1
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134200; cv=fail; b=CUivK4x693rpESAt2vJjPAhSkfMrzJCQEwnosgoihxXu1BkfLEozaixQeov2IZekMECgAqvX59lmhtuaJESx5W88hWdo6+rMldPBqgW6tY/0EWXJ/IaDb0bNc9iAhe0pblna/4BKYSSEWman4y6YcBV+TdnWhQbQltkyDnBHjic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134200; c=relaxed/simple;
	bh=5cvuwqj1cpaeVzuTULfDYQt6EcNEt/DS4Et8NJdN2z0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AK07aAAyxH+kORbR/5MuDD0QXr+L6vjvmW/no0uAftghDKiJcfPCRZdKdjaPqXr2gDG+qzeYLuT2+fsvDK9DqnF2SKcDE57tWixFrQ9JyCr2ik4Ra0yjCqvcFwel3hHOWJE3mlEv/fvxwWe+sAPaZr8qOn090uBzqgntQqWzQZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cFKRJitV; arc=fail smtp.client-ip=40.107.212.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cFKRJitV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlGXG5TWVHol9Td2qjz3eBoJKqFSgGAPhFIX6CwRRA6o4wYmYLNxi4Rxp95+ZM4Hi/jNrSh8kBIyvRyveQ6WDart7nkKXNld/HhIqXgO7foTNR46ckvLCUB8ixBj1e3mG3KOnLifrz7WUOd3xAu04i2bn+d5aSKd7UMVXPEH/02jjF/X5tmvl5aSvKs7Kkl7VmvffMpVh8tIrh1TYisMZAfP40bcpkSH5MwGhVuQVXBOnAV2apxzlCn6hm61tmStJ4d157vFagt42YsUKQB1q/W2bvhYJroQKKjvuK6x5FVSUVB8BJSRFqkLOngZ70Jzpd+4ktvOmsqqdjKk/eI/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovvXk4lLT5flyTCYWQrXqGiRFDGTcSISn6GNqTqUj+c=;
 b=ob9ehfRnfsAhO85CZzyUAslJVW5rBOlYPPb8Hpr2dhawjoK8+FABKO+7vGW8eF5UC5+8R8B0tfceSp0QQJVUcMwE3EQ5y3a9OPvuleeB+ThklH6kKy/jWx9RT0JSL1hIDmwcXL8TuYoeG9lsrbjVToUeCP2WXWOHUGrm6A3mhkvVfm22Y+05gpyZgQVVJKu2BpBOO/a/OoKGvXn31l2p+snmhZjnsi/2jrGBUd7Gjv7+8GQQ3tWmXkrr61CBhEr2D31o5ups4QgO/nr2zLV2TGjvlKERbfwVQmtUbkXlVL0aLPO2nltQT3I1hEBXM7SfBEXavviVGqSkouaIUmLwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovvXk4lLT5flyTCYWQrXqGiRFDGTcSISn6GNqTqUj+c=;
 b=cFKRJitVkt8fsbuhpDFWk+7coz7Ygn/P/nVkQw6wLa6pHIvgLPh+SgOBi/yLXzwJYA+jMoSMffJ71yRy5gtFF0+cHGjX5co0dM/ZV1zhCqa8aAe8W7so40De/7a9ud/tGl2kpQH9+wBOL/LZ0YxJonGMvG/uuFLFHV9aeafPkuA=
Received: from CYXPR02CA0095.namprd02.prod.outlook.com (2603:10b6:930:ce::24)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Mon, 5 Feb
 2024 11:56:35 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::d4) by CYXPR02CA0095.outlook.office365.com
 (2603:10b6:930:ce::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 11:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 11:56:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 05:56:31 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v7 00/17] iommu/amd: SVA Support (part 3) - refactor support for GCR3 table
Date: Mon, 5 Feb 2024 11:55:58 +0000
Message-ID: <20240205115615.6053-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe51b04-c41a-4e53-04a5-08dc264180c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E0QXxgxOSylebKAtiXleaJfkqVzh0W294UrptE7FrLJutRttIIEfKfyRQIq7c1uVeHbRRBbZkbjMWgdAAkbB/BahjV0W3qKbfn0Y+EPSXYo3HMDqfDI0NOW3ToHafexnPQBt+De02WrIDvRXDguBviibo5xLi7iqklA/HrJzUuyxWkzZ0MdN6B6LZbxaESip4YifkZ2Q1HsjWLUNUGB921+4ZtOU+tFRjoT4dG7TxlCVqOhlZv67Q7LYDi4Eq0vfdNuqJZ55Ww4G76kT0aYtgb+7pawiYEQWy+fY+SmwiNhQA3+VSZYnnOmvKqPUQSaEkrqPbFU8P2P8/sF7dM8CkNIvU2JPrp9kUbI4wOJs6yHrgxWTqh+yhxO/jrpjEI2WpW9NQw2S/lteeKaImkPH+nTtYoDqkExDip3S1z/Yt0Nr4yEgVK9Z01hImHrhR4PImUfbQjJr3xLC+4QBDmoeY0WQ7/XujXWFwTZDiIafmPX6tRfamNbK2B3D7V8RfNOIimWrYHMZ0H8G8E29ea05HfzYwEHquHD1skb6Is5sms9nYO5g677yBtVmnWLq8ECQZqhQ+Qm+Pm5Wlh7kgX9SUDBr+fcqJKnJTQDwbgPiXKFGSchbFlqDeU0h19NNcYw0ZzWiWf/fz1LF+Tx+UuyUud2IUDHSnDf7z2BBCF2VtoXZnS66mqYa+4qgjL3uSw8oRHCYsaCZehBEi8QTWrGwdRN+Nwao1W0uG6L59dWJShpnYw2T37bJKaKzZg4fPKR6gYVfu0SZMeoBOysLYa05Rl2R+KOFfzHvHNefuE57rb4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(4326008)(8936002)(8676002)(5660300002)(44832011)(2906002)(40460700003)(40480700001)(70206006)(54906003)(110136005)(70586007)(316002)(966005)(47076005)(478600001)(2616005)(36756003)(7696005)(1076003)(6666004)(336012)(81166007)(426003)(83380400001)(26005)(16526019)(36860700001)(356005)(86362001)(82740400003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:56:35.3693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe51b04-c41a-4e53-04a5-08dc264180c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133

This is part 3 of the 4-part series to introduce Share Virtual
Address (SVA) support, which focuses on refactoring GCR3 table.
This moves GCR3 related information from protection domain
structure to iommu_dev_data (per device) structure.

It contains the following enhancements:

* Patch 1 - 3:
  Cleanup and introduce helper function

* Patch 4 - 13:
  Introduce per device GCR3 table, invalidation based on per device and
  code refactoring. Also introduce iommu_group_mutex_assert.

* Patch 14 - 16:
  Remove unused variable, rearrange functions to make it easy to maintain

* Patch 17:
  Introduce per device domain ID.

This patch series is based on top of iommu/next branch (commit d2d00e15808).

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part3_v7_v6.8_rc2

Thanks Jason for reviewing previous versions and providing valuable feedbacks.

Changes from v6 -> v7:
  - Added Reviewed-by tags
  - Rebased on top of iommu/next branch
  - iommu: Introduce iommu_group_mutex_assert()
    Removed 'extern' from iommu_group_mutex_assert() declaration
  - iommu/amd: Refactor helper function for setting / clearing GCR3
    Followed-success oriented flow
  - Minor update to patch 11/17 description

v6: https://lore.kernel.org/linux-iommu/20240125121135.8217-1-vasant.hegde@amd.com/T/#t

Changes from v5 -> v6:
  - Moved per-device-domain-ID patch to end
  - Added condition check for iommu_group_mutex_assert()
  - Moving per-device-domain-id allocation/free to setup_gcr3_table()/free_gcr3_table
  - Pass iommu to setup_gcr3_table instead of passing nid

v5: https://lore.kernel.org/linux-iommu/20240116165335.6043-1-vasant.hegde@amd.com/T/#t

Changes from v4 -> v5:
  - Added get_amd_iommu_from_dev_data()
  - pass gcr3_info instead of dev_data to setup/free_gcr3_table()
  - Added path to EXPORT iommu_group_mutex_assert
  - Moved dev_data->domid to gcr3_info->domid


v4: https://lore.kernel.org/linux-iommu/20231212085224.6985-1-vasant.hegde@amd.com/T/#t

Changes from v3 -> v4:
  - Added new patch to enable IOMMU GT feature early
  - Fixed dirty tracking path to use get_amd_iommu_from_dev()
  - Fixed duplicate flush issue in do_attach() path
  - Removed gcr3_info->giov variable. Instead we use domain page table mode to decide
    DTE[GIOV] bit.
  - Free gcr3_table before calling set_dte_entry (otherwise there is a possibility
    of its setting up gcr3 table with glx 0)
  - Adjusted gfp_t flag for GCR3 table allocation (GPF_ATOMIC -> GFP_KERNEL)
  - Moved below patches from invalidation improvement series to this series
    * Remove unused flush_pasid() related functions
      (Originally it was part of Invalidation improvement series, I had to push it to
       this series as set_gcr3() was still using __amd_iommu_flush_tlb()).
    * Added patch to Rearrange device flush code

v3 : https://lore.kernel.org/linux-iommu/20231013151652.6008-1-vasant.hegde@amd.com/T/#t

Changes from v2 -> v3:
  - Dropped "iommu/amd: Use struct protection_domain in helper functions" as flush related
    functions are already fixed and set_gcr3 related functions is reworked in this series.
  - Removed moving to_pdomain() function from this series. It will be introduced
    in SVA series where it will be used.
  - Added per device domain ID and per device invalidation functions
  - Added functions to flush TLB for the given device
  - Added Review-by tags

v2 : https://lore.kernel.org/linux-iommu/20230816174031.634453-1-vasant.hegde@amd.com/T/#t

Changes from v1 - v2:
  - Dropped iommu_v2 module related support as newly introduced Part2
    removed iommu_v2 module.
  - Moved Patch 'Use struct protection_domain in helper functions' from Part1 to
    Part3
  - Updated get_amd_iommu_from_dev() to retrieve iommu from device structure
  - Removed 'PD_MODE_PT'

v1 : https://lore.kernel.org/linux-iommu/20230808100232.5977-1-vasant.hegde@amd.com/T/#t

Thank you,
Vasant / Suravee

Suravee Suthikulpanit (8):
  iommu/amd: Introduce get_amd_iommu_from_dev()
  iommu/amd: Introduce struct protection_domain.pd_mode
  iommu/amd: Introduce per-device GCR3 table
  iommu/amd: Refactor helper function for setting / clearing GCR3
  iommu/amd: Refactor attaching / detaching device functions
  iommu/amd: Refactor protection_domain helper functions
  iommu/amd: Refactor GCR3 table helper functions
  iommu/amd: Remove unused GCR3 table parameters from struct protection_domain

Vasant Hegde (9):
  iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
  iommu/amd: Enable Guest Translation before registering devices
  iommu/amd: Use protection_domain.flags to check page table mode
  iommu/amd: Add support for device based TLB invalidation
  iommu/amd: Rearrange GCR3 table setup code
  iommu: Introduce iommu_group_mutex_assert()
  iommu/amd: Remove unused flush pasid functions
  iommu/amd: Rearrange device flush code
  iommu/amd: Introduce per-device domain ID to fix potential TLB
    aliasing issue

 drivers/iommu/amd/amd_iommu.h       |  29 +-
 drivers/iommu/amd/amd_iommu_types.h |  26 +-
 drivers/iommu/amd/init.c            |   6 +-
 drivers/iommu/amd/io_pgtable_v2.c   |  21 +-
 drivers/iommu/amd/iommu.c           | 627 +++++++++++++---------------
 drivers/iommu/iommu.c               |  19 +
 include/linux/iommu.h               |  24 ++
 7 files changed, 376 insertions(+), 376 deletions(-)

-- 
2.31.1

