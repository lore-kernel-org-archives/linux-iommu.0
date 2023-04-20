Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1EB8F44
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 17:30:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJnBWktAD3+F3KAFee/EAUstfkN9s76FpOy4YwZxvcewh0IX1PtzQzwpC0eD5oduzIXo8fNJRtNtePiFHK7xyt00LFR3yTfLV2phcWEqaVqZtwyI+VdL/AqWY3TYpC51hvvCRtE97spZsFWv0Z0LtTDHhUUKVZFNiEvVTNPBiHLNDyqMWNBmap842QNC/JSmWmO5FlNOJwl9trGnUjAxxWbTvWc2T972l7DOxOS4Wl6ptzB0dbe9TTUJFzjij8iTJIbOabER9KwBCyDndoX81eXlhC9zwYHoltrH6E3b61YsZnHBCfVrqnNrVKXtuGzmvKkzsKPn3Rs9to7dFBlF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3QjYbRbfFp8IM48Nzsav3e7KxL/HwLzekkGloaAaC0=;
 b=hLUwS5HrWOu/cdRHWZGiQmsOas0QLrXOIJQKEaFRASjoeEGQ2fsRDZK5nUjC30LTlazW3i3gURSCvpfAcEuWCYezPAqia5pRB6VFM1EQS1GIbfdFQveBs82Kj7/RVqGUTWpkbCevQAkBgZqf32RGXmoGqZeYNUeX5k2FKViIh0lumuWh7yFJVw0MGgP4KPVFZ8S+ZAHQsTesRIcKWhTb6bdJwhTZJwJ24lU9Qx1B5zZ3JZ3PMrybKSu/Dgek3lH9L6+x/U8XKiJu3LC45ji6otIXo3kX1dRmFEyiSctS+UUkuf1m7mKYLsvfV2I1FNwO+uA4GW/Us/E5pUtejv2phA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3QjYbRbfFp8IM48Nzsav3e7KxL/HwLzekkGloaAaC0=;
 b=rigxXTtgjuz9WOcuP0dCKG5/h4x0heM6q4bF2AXVRktZepOA/SS8aRPQF7MmKy4BlqQ0oCRKYgtoJ8Ixsv7vX+w88pNGWr+Jn4+37/YzEAfuX9L57fYBQx/P6Ys8ucIYJsyIUX9dO0Q+6gWcYc2syloUwiy2x/D3gymysjY7NX8=
Received: from BN1PR14CA0003.namprd14.prod.outlook.com (2603:10b6:408:e3::8)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 17:30:12 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::26) by BN1PR14CA0003.outlook.office365.com
 (2603:10b6:408:e3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 17:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.23 via Frontend Transport; Thu, 20 Apr 2023 17:30:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 12:30:12 -0500
Received: from ethanolx1adehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 20 Apr 2023 12:30:11 -0500
From: Carlos Bilbao <carlos.bilbao@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>
CC: Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] iommu/amd: Update copyright notice
Date: Thu, 20 Apr 2023 17:30:06 +0000
Message-ID: <20230420173006.3100682-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 3884f2a8-2cc7-4a0d-c850-08db41c4e5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1OgsYOvh3yag0D8n/8AHhOYsC1xo/evnUlOj/0hp2+Lak5JY3kGgKiB5jJJnnrCVSzlSSYJqXJUGxEPVpNvg7ScgNa8qmYEauMtEJrmoNphfvBc0IV+iuTXZxuVxDfBDYzvShoCF32rA+jc7iBHJHnepJYibpGXXYTSOdySrafA+exwB//diKvqZxnNzDApPABTx1tXCupCkn7ncYDVMqdTRdV53LYtUPSzhA89wEH87I4sX1XEVnvksdDcGvSdtP0u4fYLd3JhDIq8RjDMCG/uZfjkZRX5yuM91WA3o8u59Uj+yyzn/dUqm8PBAG+zfSMOkdFBAFIupFuc2rYB5Rml/7eE+xI9BgvSSvO+e4diUvoYWlmncExWaVU1q/vVD0YywSS2QZyS0dz4mRf2S5nOMYaCmb0+9zV75314Vvn3JKQzHS5hcCAGiF9VxLfQToDaMH6tz4lMizIv+aFiAAI/cwHD7g697mJlnQ9gLvR6688uFyw4E+44X4MviNgX3GbLL4b1iFOQs4XVVrbn068FJVlZZ4prk4mnhO2pfUs39qPWpTXOEyPut9xb3V/bELQ7+ZJxGYr17rGTb419DdoU5fn3r7Jead7dDuNY4NXDy4zel6SBw711F9zXyMmz4T+raJvJNG/jwAs2WLMpPpB8dxsL8SiwCX3R9l45rCutbtMq5J/g++7crw3822O4aELkOeamtepQBM5eKbpNH2iONYeSEWPW6evDTJ4YkRPQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(15650500001)(2906002)(4744005)(8936002)(8676002)(356005)(86362001)(81166007)(44832011)(5660300002)(82310400005)(36756003)(41300700001)(40480700001)(7696005)(1076003)(6666004)(26005)(82740400003)(478600001)(2616005)(36860700001)(83380400001)(47076005)(426003)(336012)(186003)(316002)(110136005)(70586007)(70206006)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 17:30:12.4700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3884f2a8-2cc7-4a0d-c850-08db41c4e5a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912

The most recent changes to AMD'S IOMMU, such as level 5 guest page table
support date to the year 2023. Update copyright statement accordingly.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
---
 drivers/iommu/amd/io_pgtable_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 8638ddf6fb3b..bae4f3910563 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -2,7 +2,7 @@
 /*
  * CPU-agnostic AMD IO page table v2 allocator.
  *
- * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ * Copyright (C) 2022, 2023 Advanced Micro Devices, Inc.
  * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
  * Author: Vasant Hegde <vasant.hegde@amd.com>
  */
-- 
2.34.1

