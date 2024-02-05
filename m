Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741218EB2
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134409; cv=fail; b=cOsTu8I3qoXQl8XuCxqdVhGlLFjN8F0JEcAaXIAOzIOUjtvds+D6lDFB6QeCGWM6stredldXgnXYFqTpribL42yTHilZtDKMqr/y4q046LL/pDG2Ia9cqaZYeYyisOsbuzjQ0414ZuPuE1s3Z+usSZNeXr2PHFQZbi6t82nspPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134409; c=relaxed/simple;
	bh=JndDSn13RdVMciXNrYL483MStEuCJ8gWpFhNJNobqf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIStl9Rm/6arpEZGHyQKQEy6641qXN3/cJRn4Fm/S31fADfBWlmLffmN/4AYb9Iv+fPMl+YkOu5sk1DLMYNv0nRxrBD31BakDLYcGbS9c3zpaZ64GE3b+gvfsXMFMf4wcddkUbRYzVtI+TmNh4ixLx83ciLjdnifqPJnsySpSUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PBiNQy89; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PBiNQy89"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b08kEkMPLfANuxF+QxJ5KxJHLyT/JECnT2r8zRGFm7/snriJK+CaUfFb/n1TVMEcSrB5HFTjFpD3VnUBqJ5QuLWq5vECO5D1/7wgsEyKOt+uWn6xYMwJdlL3AqhRrOp0xqStDA9kTHO8QCPpkpmdaePBUGTunM1NBpzi2CzaVb5gDPkx6QqCM8i0SqgiGffjCpn0QJQ4HE2pRaZvqdD9Ebu5FXKmGdH1MY0Il8pg72omGbU9ZxQ1Tv2jtrnbso/R7+xFXDmjdC9BLdGolnLDM+4BnO2uE9L5E9k94HUk20UPEWzMpEkQd/iTO5JZBxyLXMDbpULADw4+fz+IJuOfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/Yy6XeBoE3DeYiWNLYN3W6B1FVuaBbbz7qJtVfqtEs=;
 b=KOdqH+K0ssQzTDvfPkGHvde2q20iLdCUD2m4tO/1w2hVoZXi0Wyq6YzwJa6JCZPM1oG+vclBtX3eYIZ/cgfwleJBMIkPsD9420oKGDubHDmNWrpiIiyDvingG1v7kVFW2GpddC5tgJIYa8aSNRtGwnCq16LSncZ95HjGUEr6XwPUQftWixQJ273bfJFmsuJ0OIOY19Wq7/Fs5Zs0AGSN62L7RT8X5Pn1O1xiIf0dH8e17xvs98Q4KhL59cwGe809la+SmHZ0XdaltJ5xND87u7O3STV3Ks9ffRllGt9bzKC3jbkOlpuDb1KqNhKWIQhuv3kD9kqceNtd8W0hAZHz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/Yy6XeBoE3DeYiWNLYN3W6B1FVuaBbbz7qJtVfqtEs=;
 b=PBiNQy89oSyueRzPdJ95OpVYX52h7HpBVJcAuXewbgPSGmbWdG1M2mmJc8Ep2Ropp/Q1jjOc3W1rw3yJy4xSZRZ8mVqzIJRFDOJ36/BHVJAedOpBAGumoPkc433ik3r6DMnVvyLq0c5SQipknMJcSGXUl4kC8oLZalX6LkYDU1U=
Received: from BN0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:141::26)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 5 Feb
 2024 12:00:04 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::75) by BN0PR07CA0026.outlook.office365.com
 (2603:10b6:408:141::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 12:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 12:00:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 06:00:00 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 08/17] iommu/amd: Rearrange GCR3 table setup code
Date: Mon, 5 Feb 2024 11:56:06 +0000
Message-ID: <20240205115615.6053-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f294e8c-9a10-41e2-a733-08dc2641fd19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sBFt8Jii97qLns1FStj34W3dUAtof+lOzsOftPzlKidhZ3a89lxJOaFJYt6Uwr0WpNF13He2kRoK4NaOZWoOzfWZ9tyhstPBbDpAJ8iB1eyxdkr66EK3ii8evZuYbVhl654+wKWmDIJgQPFTnjKwNsQTgGM+j7+PCoFyZDzqeRRQ/3Vu6bQxYKDMVFBwC2htHh794MK489zH1C7pomxXqP8NnlVLlsTyEs7kISX7C8dixcEPeTtueHQqoXxZa7eGhDsTTaGcIjxuzkrtFOlNZ3VJ1nM3mq4Cc3FOHUbfzxE84irvK+TF8C8J8VuViGGqf8qNufwwqWri5VEdzpzY1oyRrIBNvqiTbbQJWBnhwLRF010cgwJ4q1TEOgeeXbwe0INrqI+hQT0lg4K1z7IGnVb9x7fvrGgspgz+d/bF0y2ADMg6cdjlRv6JKs2VNamEhgahjK4nlV1AE0H0+amTcBOLc6xL/RiDphUuyZSew6suterwcQ0f16r8Z7A2PVnMUYDhkF3ULY4MjYr3KjCQKrxhec74gbAdr9xLaS7VGNeAyRi0dWi/LAR4GW2Cl1P+Uq+JF2lMojtFGqcw9L+nKrZ9Q8hJtLjgqosHmI1805n39jCpumNiuPsbAu8KrY+hserjkxB+NtF4eIqyshrubWSu3lc2/wWJoPZ4ZJjJhkbHy8N6saQWto2jCiqEDj/ZhAWQHAHtm97Kb2c3bqlUrQai+pfyEOw5jnSMQYF1m2SPZ1S1stBZ66lOI7TNgiQxDRO6MqCMKYiPAwc1rit3tQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(36860700001)(336012)(47076005)(83380400001)(1076003)(2616005)(426003)(16526019)(26005)(40460700003)(86362001)(7696005)(40480700001)(478600001)(70586007)(8676002)(4326008)(8936002)(54906003)(316002)(110136005)(70206006)(81166007)(356005)(82740400003)(44832011)(36756003)(41300700001)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:00:04.0345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f294e8c-9a10-41e2-a733-08dc2641fd19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034

Consolidate GCR3 table related code in one place so that its easy
to maintain.

Note that this patch doesn't move __set_gcr3/__clear_gcr3. We are moving
GCR3 table from per domain to per device. Following series will rework
these functions. During that time I will move these functions as well.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 64 +++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 617942c9a97f..c0c5f6b3d4f4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1718,6 +1718,38 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 	return 0;
 }
 
+static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
+{
+	int index;
+	u64 *pte;
+
+	while (true) {
+
+		index = (pasid >> (9 * level)) & 0x1ff;
+		pte   = &root[index];
+
+		if (level == 0)
+			break;
+
+		if (!(*pte & GCR3_VALID)) {
+			if (!alloc)
+				return NULL;
+
+			root = (void *)get_zeroed_page(GFP_ATOMIC);
+			if (root == NULL)
+				return NULL;
+
+			*pte = iommu_virt_to_phys(root) | GCR3_VALID;
+		}
+
+		root = iommu_phys_to_virt(*pte & PAGE_MASK);
+
+		level -= 1;
+	}
+
+	return pte;
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
@@ -2742,38 +2774,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
 	return ret;
 }
 
-static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
-{
-	int index;
-	u64 *pte;
-
-	while (true) {
-
-		index = (pasid >> (9 * level)) & 0x1ff;
-		pte   = &root[index];
-
-		if (level == 0)
-			break;
-
-		if (!(*pte & GCR3_VALID)) {
-			if (!alloc)
-				return NULL;
-
-			root = (void *)get_zeroed_page(GFP_ATOMIC);
-			if (root == NULL)
-				return NULL;
-
-			*pte = iommu_virt_to_phys(root) | GCR3_VALID;
-		}
-
-		root = iommu_phys_to_virt(*pte & PAGE_MASK);
-
-		level -= 1;
-	}
-
-	return pte;
-}
-
 static int __set_gcr3(struct protection_domain *domain, u32 pasid,
 		      unsigned long cr3)
 {
-- 
2.31.1

