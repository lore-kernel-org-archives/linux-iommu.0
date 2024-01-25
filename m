Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15C4439F
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184746; cv=fail; b=q0Jbah3h5PHW7zopF1XyCF9KxQBKgmL2wvMfE0xBBCA+7Vphe6w/Z6Gs9eHn5YdDR+fna1z3enJkX87Ji+gSwLfZlXYPI2/aIp7aUFy1iPXDWyWgcdJNW7GLoLAY4ScpkJehQP6UjYELSdYl6iCwyMEkEcUX1V8vI7GnFsVcy9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184746; c=relaxed/simple;
	bh=LdvVehSX/sBTbG4RiIFs0DgoJpCXjXTdnO7X8FWbqWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tHNirfx2Vz6eGwAImT5CFSt7tz8vpDo63AeRU+GpSvaZCzknuFM5kOEineZy5s+CdvpxrrN69KaQ2xyeHBHcSU/UfDMHErUmMhc2QKgIBrYHIJYFLNIIHqJkh+XZC5zOyNT9vZo1YD9S5SFMGezOR1EBR3hZGdDgcltBvHxtvLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SCv9kGHI; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SCv9kGHI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0v6YvQ2IiflCI79XQmqlV5kzI0qPjR9TjA+vThWDObVh7xZKhcRhPLN8p/3nOF7CGXYK0iVgw+W5t4ZhpDLAfQP+lNbCnYpLyRUTEXui53aarC8HHx1rxPcIRL2mYsviAZtxoutumJSJMQYF0CpBoPqNuaZLbsvQZgRr9mcg52TzjBDaXjVPFZl8Zth/4iKO787o7M5zHaKiP9Fu34Vs5WDvKYxsW8zZXhzo0vsVpqzoZM3qB+zl6kjCLQ+tAEu0HezXIDjvSgvPdjcWWB3W5sQXOPD7j1GhkXMAm3Pc9N2XglJwyLnOUTp1ZADSJ1vXS/Ssh6npGc4Z+VaE4owMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82/z+lUWjFXxE3mHLkOeeUjGwajzAaqLwuO2cz7bAek=;
 b=Vu6PmL5R2IwYsi4QjhGuQ/n4bCwg2dVfSQ7gppxLhd4fzd/UYHRzaszUofbqQwEAXYjss6NJRvnJ5VGF2WhP8l956z7GD29JThslAIXg49tOGiYtdtB+TtXKtX1wo63qiBojvd30LfqEQmXUysvEatPTu1tgfHdTCoSoBkaTmmKIEF4Y6QN8basELgs9o/JVCOjMwl7Q6fnI5N6SV97HeVfO1Z0hB+4cOSHQ7xWZUus+5pB2I+Ga72QZaMd0OfoZxPEe5nUO3iY8+exrX9dImRlWvGFCu0m+YfsSpEvQwhiacubQqbAsf/rMpKqrifAoqgBNkn668gjyabnOMUZn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82/z+lUWjFXxE3mHLkOeeUjGwajzAaqLwuO2cz7bAek=;
 b=SCv9kGHIp+lPU84fRde9b2FVXMbYq8KXnQ8w+WM+N5K0gUhS/GM2dqDKiqtPgGsl5qega4Yd4BPzz+vrWOyzxtK/TrTtgS5uITCuKslhsatAiG4GMjykaiVNt9O/sm46hrl4CgAmVKb7KlfKs1E4tjCHnQM61IKM3V2NLP3TCuw=
Received: from SA0PR12CA0014.namprd12.prod.outlook.com (2603:10b6:806:6f::19)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Thu, 25 Jan
 2024 12:12:21 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::fc) by SA0PR12CA0014.outlook.office365.com
 (2603:10b6:806:6f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 12:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 12:12:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:12:15 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 00/17] iommu/amd: SVA Support (part 3) - refactor support for GCR3 table
Date: Thu, 25 Jan 2024 12:11:18 +0000
Message-ID: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 351801a7-91bd-4953-d097-08dc1d9ee1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c2ltmbDeM1XPC4CV/5SjscV+VNOSOOdcx00U7SdrdATVKRRwzFLlLgi9Hqv3H3Kk9Bw16nckAzSy/4Gaa7SOOtNyWJEcIIHMDLnqv3AtdO1f4aXKtYcvfA9f+Sm0rFy/8Eg/0NKX+GtepkMZXZGZes/PZkXLxyy5W6SYtffUZV199LPLgiAn8zGHelyVm9Er+2u8EEc5aL8o9lIkN5txDwuFVkytQUe3LjQbu1xQWncPuI5fiWHhUMrYlT/iqx3a5tw+7kwFensGGKglzL2cwMsSZ/gcBfdtCbV4y+hAiPR7Tm8qgYS0hd2mjCS8ZwuX2ChJ1HO7O/x6b2S4I+tbeIMGvyxERSkjJHKvZQ11USzgcEvN7wkMyS1rTbVta/+1gfdgUVwvtvbmyOg0LQfMJrzhbFxrY+2SsfyPhz78vX6Ka9qy1MKfrwPHAH87lT5xW20EO2vQv5wVaDgrFBsNQPY5MS8xLxbyhodY6yLYYy+oGrTP/GvOXNwruYNEIpgvXKkMYJ9jSMzx1hU6Kn6sCPWj0zEg7O91Flihu/H4CgJ3j7mzydZG2YjiaThk6GcVa2aNPi1x+fjdUL7bzD27xGzHiDVhffYl9cIl9aCMaGZs8Y74uE3KW6lS7qH+EmiOQkdij+/bip1gyJTUTgKXzbtSvV5FPkJJEfK9L6VzncxpNe/EZDf6hoomAnZUdX7RdLueiZJWwBDgcxNMX8W+acH+Q2CzVd93/AUYuVG82FJgzFq1YP0FuPZcDebIHH2KJy/pnHDu1jfGgKpaYacy70Kq6xv69HhAFZKimcL26ZY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(2906002)(16526019)(81166007)(4326008)(82740400003)(478600001)(83380400001)(86362001)(356005)(36756003)(36860700001)(47076005)(336012)(316002)(426003)(8676002)(70586007)(966005)(54906003)(26005)(70206006)(7696005)(44832011)(1076003)(2616005)(8936002)(41300700001)(5660300002)(110136005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:12:20.8867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351801a7-91bd-4953-d097-08dc1d9ee1d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

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

This patch series is based on top of iommu/next branch (commit 75f74f85a42e).

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part3_v6_v6.7_rc8

Thanks Jason for reviewing previous versions and providing valuable feedbacks.

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
  iommu/amd: Introduce per-device domain ID to workaround potential TLB aliasing issue

 drivers/iommu/amd/amd_iommu.h       |  29 +-
 drivers/iommu/amd/amd_iommu_types.h |  26 +-
 drivers/iommu/amd/init.c            |   6 +-
 drivers/iommu/amd/io_pgtable_v2.c   |  21 +-
 drivers/iommu/amd/iommu.c           | 625 +++++++++++++---------------
 drivers/iommu/iommu.c               |  19 +
 include/linux/iommu.h               |  24 ++
 7 files changed, 374 insertions(+), 376 deletions(-)

-- 
2.31.1

