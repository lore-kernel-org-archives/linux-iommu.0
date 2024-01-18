Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E021F5F7
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568619; cv=fail; b=WqiILIfiGEXqx+3wotx1wI3iP3dhLZHra+yoUrPJWGuXJY7qOQBGLIGsqo3d0dmkh7fuoWVEmZRWge/0iBdfxjNXZ/lEA3fHfidJ3wZDxhV2VhQ/HuN/GQwgFcTj0TTaZSBOgwj27NV2Bzvnv/1IlrkZ5K1GhuMYTgYn0JQXuoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568619; c=relaxed/simple;
	bh=VAMGgKVn90JZwAWXHd9vFehuxppqpEGGuIdKO2UCySg=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=JpLj35cnVIEOQOuIHrC616BLwU/c2fBdtsfnkAkvGPuck/DHrBDYyVHqOvfFx3zqIaaHpy0kWnjb77cy+QVlVYQRqDjUMljNSbEn4sYmG9N6WWi0oPXCvPI7QMMkQdsTD8//eq1zu7UyG7qOvUep6r7kPKGqEJOTaAYu19vF2A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w3TvoXh9; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w3TvoXh9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+hmfGO6lPvvlTQ4XANXFi8PyD6OhXdqBAMzvRyyoP68gHj+/kCM6bWbCia8+Yv1gkMl7JtUDncIa3OcKoF9AvM15PpZ0PpZGyHnri+yqQZzIAVIJ371rGjXBJwMvzkJgcItjsaGZHKS2XgOoXiKCxifSiXzWeAmwpWpKeMf+g7wBXggVzDzKE9bA5Q3snAURbRtTIvaDuLk6/CfpUErAZplTBG96GEz2aFvcoHT6eFB/FxEXlyllFkwSfyFGJemsCIsYybi6sgb4sqX1AMghUCcyI5+80oAT0xQw9qIi2j+pt5FvJGWKF/7wklrtC0a3xFeINjRhMXwa9pIDddJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yei1M6yY/SpUnLV3t8CaV8xX8EqD6uvzLymFKhonjWc=;
 b=mpjzX7/DiXkHyPPsChJiQBWNSIcPRl77xgOGoqWTwxC8/+pMY6aCYxbGaifRYpJEfO5w4TGnm3kwOXfLRuz1HaOVlg4rHiCXHggYz8v04CSxVbLXxwVP0y6+nY/++6gqY25aI0aqE9rHlwPS8rNqteI6L6FDEkJ4O657Up1GMDiMOGVWMaRzbe/VmovVL4pzBxH2zxeqI0DmOHXrZ7q+ElP3VBrzuqUshLu8LHa1qKaloxJDym4sqV5K7NvmnDI8EljVMtgoVXuGQI/urNIlAH23qreXMpgsj8CZIVRqsVXabHAcbUvud7gQOJYtxpXjTpVfJOa5dzzFFuFXlkyQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yei1M6yY/SpUnLV3t8CaV8xX8EqD6uvzLymFKhonjWc=;
 b=w3TvoXh9d4v5L7z2k3qF2WCNKgKOWABjCvm/fzzSliADX3U5oeGxBdQ9GAHd56zw5LYYti2EEIODm5pjnfmZjYGQA8CxZWLKFvvnhVd72xJw/mQoJDtYlaw5n3WWMrqnUeFNEez/7Mx/iPKimDzv8DEkG7pQmoJE1vwOoRpIZoo=
Received: from DS7PR07CA0019.namprd07.prod.outlook.com (2603:10b6:5:3af::7) by
 DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 09:03:35 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::c9) by DS7PR07CA0019.outlook.office365.com
 (2603:10b6:5:3af::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 09:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 09:03:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 03:03:32 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 4/6] iommu/amd: Remove duplicate function declarations from amd_iommu.h
Date: Thu, 18 Jan 2024 09:01:03 +0000
Message-ID: <20240118090105.5864-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118090105.5864-1-vasant.hegde@amd.com>
References: <20240118090105.5864-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b13399-9d7f-4652-18db-08dc18045a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l24bZ0ksl89/GEYxb8j0FSfsbfiPXg1C+IRQWyb+e6K0p8DZ08UKP/wKWNMrBtSLTsm10Z3QVTK4CgEgSRZs2ZLPNE+g9yk04Vo3vVOpFHYT6aCQY5N9E3grryMk664aTC0e9RT/nslNBXNVdSzewhxqRdSge28xMIodk1O58rT3AkT0txZmr5VzE95iZz0UR0ycxjZ24/va4n26ha+lGgQfDHvZ/iEr/f7lZjdnFsslMsEYLo5QW8h3J+Ar0mqodrTHuj3e6qVKP4+VpAUwFpnHbFwU1zJiT/IjylqSSViLu2vQqZL5vbrL9l7l2xpZP7MxvrntmtXtChusOxAQW7mJGKRtrMm2s6KPbHWFhTGE1qNSiFCpU8keaXiuhKYwN1jJJD2Hq2TPy+IKvkohdRuEwY9NhYiE7BLMCKRD5yt0vtZuWPpursRn8D7AkLAobd+BBOX38lm1S/RBEHJ5gMWi9dJkdmmjoF6f+Cm6R5Qb8pazmPHfUA4Y9HyxfmApD8h1o5mNRRy+CHXzSPgsDhqC8UNoRsSuOhsObiY4R0Z+q9Idy8XixXauwZD+nhqJFJpLrd+3d2FL/pGeLytujXoifgp5bo1WhduKIabvmWVxhbWyiW8N9vHScvuYocz4dixVLsNBF4LxWCQKTiZ0peM3G+WhbUQz6+NbCQG0fCt1OEx4sgmJbfBUgJA1GDpM2xW8vDMjSoChdYfnU1WVWMO/MQ4BC8yRjKSzYxbyhiiH451NJsVsZw3hWDZ7IIwNg8855dE1hYi9srOZnIXxYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(426003)(336012)(4326008)(8676002)(8936002)(26005)(1076003)(2616005)(316002)(70586007)(70206006)(54906003)(478600001)(41300700001)(44832011)(16526019)(36756003)(40460700003)(40480700001)(86362001)(36860700001)(82740400003)(81166007)(7696005)(6666004)(356005)(83380400001)(5660300002)(110136005)(47076005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:03:35.2324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b13399-9d7f-4652-18db-08dc18045a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

Perf counter related functions are defined in amd-iommu.h as well.
Hence remove duplicate declarations.

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index db983b8e572b..c2ab07d364dd 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -70,15 +70,6 @@ int amd_iommu_page_response(struct device *dev,
 int amd_iommu_iopf_enable_device(struct device *dev);
 int amd_iommu_iopf_disable_device(struct device *dev);
 
-struct amd_iommu *get_amd_iommu(unsigned int idx);
-u8 amd_iommu_pc_get_max_banks(unsigned int idx);
-bool amd_iommu_pc_supported(void);
-u8 amd_iommu_pc_get_max_counters(unsigned int idx);
-int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-			 u8 fxn, u64 *value);
-int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-			 u8 fxn, u64 *value);
-
 /* Device capabilities */
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
-- 
2.31.1

