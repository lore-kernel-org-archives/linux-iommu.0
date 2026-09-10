Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2839D3FD;
	Thu, 10 Sep 2026 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011279; cv=fail; b=Mfjg44cAEEkne8TMHHL7YCekLrIofw0dBWoI3I/tYK5ukq6xwavNsqbEWfs9gJ6rI4PgnYW1F4MYvnZpCNQYA1gmkw6F2Gnw8j/g0Y2HYBEM+QWgw8cCwoxopyL6DBLDr7KLbbNlWbHmHDsLtuKpW8vWWNuzCCm7XTSQz1TcaA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011279; c=relaxed/simple;
	bh=ATDYHncYMCPkvW3NVLxWOUFcz+l6U+ageQjwK6RyPl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFIIoHtYILAoXjua5iRSWs6QClR31FMlUg4SNsoxcbV/onYShIUMPVCLab7e3Nl3f1fCR9CPBe/07itWNsLNI2W2a2VKjaFWrIiDlHaLA7XpYTjR3oo9RBZQQTCAp9nkKRcLly0gEGtZ37oggv9WbeoT22jGnmQuxA0BvbWXj04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AfvzQQPC; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AfvzQQPC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdAR7igF/Qlm3QAqah/vA7PBhgFm1M8CA3czjYcBeNvL/ogjAe/9nfzLr47fx45Trp2mTnRyRejg+FWrOTxuod5bGc1hPDMRfapmBdw/JSNmjpqDYGHbLeRa/8RKR0VTlGcmoQu4Qn+X03cTmqfHLzwzDDkEl0YhMPGj6uDBMx+rrk6nFBvo1EVHFGOIYuT89OH/8sybeT2vlCDStaXwJ49xJ/agAnxF3ya49PwrClBSiFhlL9eeJHIyPYNAtvqBzTENE4bG4Jw599pC9NznIaIVLyq8RZdHZAAYb3unQYpwZIdNK/HNB8l2lUNX6j04JmQT8uQfc0TYd0EOiXUFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR7rMdEFTQNYMRzOAZb2SqWfOzcx0BhWw6w7SMZW5fk=;
 b=i5M40sFXCwAs36Tw7v7mQYiMF6hmTrJrc0UdVNzi42YimDsKszYiaBP0UNBteqV4ASPryEDRPbOhVQyMl/9ZpBPUvof2g6oPZMeA/gZSaTs0hmsFngRcp8xCZhVCNnkN87mhLylY+Sxtvm4k2+6k16Q2q+GvziPTD0IH/v68kaB/V5Q886AQs9O4dv/P0UzVBPey4nFM5lHS2R80V4788mne7PtfRLRxMZ31xAKuQk4yderTRNDMeZPZQWkTX+VEH1yhyqA9StpMMer2wS2bBPGZ4yDxNS71BH3lFZmuBgUN3WJ4GVIzGYhapRMsOf6UmwYZNLMROOi8lT8UhH/DyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR7rMdEFTQNYMRzOAZb2SqWfOzcx0BhWw6w7SMZW5fk=;
 b=AfvzQQPCNwzAnInQIpFbE7j1cWSkbceaIAv04liT91/mWv1lKl/b14H+0AsPKuPsW6mAinoqNwonO5uMJ/PT2Q0rVYk7OekG+FjnxCiO3wNgiVgeayXmt1udT0DOm7iIu+Vqhq7NmV0pQj1tVwcNfm1qy1KpgljaLN/v2VncYE/8hLJveo0ZnDs9BSnozbqn2uaVLc4BRUrDg+AYKCRUH9WyuFDfIbWbT3gfsKIPXWR6U3p01jbp+drnZ0zf1bZUMajUsXyvQTBxE66kf0P+P2+L6gRYPOBQmhYGp2uVyw6fts5BVD2HINaL2FplbHVHQ2XvDY5YnhEocl7VNxBw1w==
Received: from DS2PEPF00004561.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::505) by SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 03:34:25 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:92f::1006:0:b) by DS2PEPF00004561.outlook.office365.com
 (2603:10b6:f:fc00::505) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Thu, 10
 Sep 2026 03:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 03:34:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 20:34:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:34:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 20:34:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	<aneesh.kumar@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>, "Anshuman
 Khandual" <anshuman.khandual@arm.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
	<rppt@kernel.org>, Thomas Huth <thuth@redhat.com>, Marc Zyngier
	<maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, <kas@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Ard Biesheuvel <ardb@kernel.org>, James Morse
	<james.morse@arm.com>, Steven Price <steven.price@arm.com>, Sang-Heon Jeon
	<ekffu200098@gmail.com>, Omar Sandoval <osandov@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>, Sam Edwards
	<cfsworks@gmail.com>, Douglas Anderson <dianders@chromium.org>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
Subject: [PATCH v1 7/8] iommu: Park TDISP T=0 devices in the blocking domain
Date: Wed, 9 Sep 2026 20:32:50 -0700
Message-ID: <0d57c59aa3cae891e9d3e07e939e13918a4e99a0.1789010941.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789010941.git.nicolinc@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b20b06-b649-4e0c-a446-08df0eec694c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	YYwnoETDeB29vWKFMVvg7RO2Pd7rdeuRPp3YJFsEnq1UDBdFwKP/S7/tWsYWzzXkS3DFR6e5Xz+XorgPLHL4wTUaj7YWRr5xCGYG712xKkJ2TAfIHW8dL+DGQO9V7GrVI8N4X2nP1zEc6wpb/k4TlUmR4HTyidT1G5wm0K7ue0dqMjVse8d7WF3HyyotM/nE/yAoen9jt7nsojSamEs3cE9xX5WiEt8ro1FSClWDIZFru8dN8xniu46jAhkAGLe2Mq3exiImDz9KCU+t8Ebn9dwTQK3toC4jpbRGRaUmlNPs3GbO1YryaHDN+VMMezdUZ3qdMS5YUF4vTBSbl9byO63blls7p220YiCIOQFGc8rXOPjJvr7XRUF/ps7FvD2+j80nyLf7wRJyywPHAfEfzAuM7Z/rxF8aH2xuUyj1UvRlsTkK4gcdGdN0qY97GwNKEkI4BZ994vg6frkzlAoeQTw02DaEHyoiUzyWBXkz8yvgtOmArrAhdGYKKyA5OfJyz0jEluPWqqVcy04I7LQnfI6L/hZkA0Tx4INV8U6LxTw1tgBxfxsJnmmi3Jg9Uslyxn9rAHUP3/A2SMLArb0Zyjl+uee3LXW6NYmpLPWc3VH9TkBrk55mMhPQC+uoxX1anr84jAtWnsjwRbHfAjteLfc4xv6I66bd0x7Ow1eFMx7d1WeS9F/b464aNQmJhf4wS0gwvOczAJR61l+vMtfhJA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HG0HAuL0wF2B5+nr3w59B7NSXSt8RvQVq7qna2F5jF+SIefitmyUt5lkmAE8MAdjtEdqsbU6LqjIqydbjhuHJf1bpggihiTbJbpuwqlzvg/1jClO7GV/meITRqKkV+JFWZF4Zy6giIDPJ7C06IIh4UPbtrVgMwCvdKeCyqWcqxmikXf2aUmwsuPBWFVOh5ziJWdLa1hpACLTVAmEx9k2wurLc3go39DR/hYQS17FkQ6NSNO1oVIIzg8e1OcJhOuEPMJPd9+rygyQo0shoaDsjC/Uy/Vig83pDHzxCMdpJKSyLIo+d5orrIb4ipTELX9IWIbh+TYFlnY+zwoyMwtTg2nq3+oUPeTcuN7ViGwjCioiiZiOGsGqrN8U2EjH1h3yExMR3APO+ZEk11RsY759t0b30km33AcfglzHUnWVtGGwDE7DL5g6JiudkDnxFvfn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:34:25.0672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b20b06-b649-4e0c-a446-08df0eec694c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690

A TDISP T=0 device stays associated with its guest T=1 vIOMMU, yet doesn't
use that IOMMU for DMA translation. Instead, park its guest-visible stream
in the driver's blocking domain.

Linux's model requires a device to either use T=0 or T=1. Aside from MSI,
it cannot use T=0 for normal DMA once moved into T=1 mode, since the device
will have IOVA's that are not valid in T=0.

Select the blocking domain before normal default-domain policy is applied.

Direct-map reserved regions are still fine, because the T=0 stream always
goes to an identity mapping. Skip them here, as recording the request would
only refuse the device its blocking domain.

Reject sysfs domain changes, driver-managed group attachment, and any PASID
attachments that would install a translating domain. The state is uniform
across each group because all devices on a confidential IOMMU start in T=0.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 49 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7ac6569af6773..d6b00e0373f5c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1238,6 +1238,14 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 	unsigned long pg_size;
 	int ret = 0;
 
+	/*
+	 * The direct-map reserved regions are still fine because the T=0 stream
+	 * always goes to an identity mapping. Skip them: recording the request
+	 * would only refuse the device its blocking domain.
+	 */
+	if (iommu_using_t0_stream(dev))
+		return 0;
+
 	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
 
 	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
@@ -1790,11 +1798,22 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 static struct iommu_domain *
 iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
-	const struct iommu_ops *ops = dev_iommu_ops(iommu_group_first_dev(group));
+	struct device *first = iommu_group_first_dev(group);
+	const struct iommu_ops *ops = dev_iommu_ops(first);
 	struct iommu_domain *dom;
 
 	lockdep_assert_held(&group->mutex);
 
+	/*
+	 * When in T=0 mode the T=1 vIOMMU must always be set to BLOCKED to
+	 * release control of ATS.
+	 */
+	if (iommu_using_t0_stream(first)) {
+		if (!ops->blocked_domain)
+			return ERR_PTR(-EINVAL);
+		return ops->blocked_domain;
+	}
+
 	/*
 	 * Allow legacy drivers to specify the domain that will be the default
 	 * domain. This should always be either an IDENTITY/BLOCKED/PLATFORM
@@ -2399,6 +2418,10 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 	    !domain_iommu_ops_compatible(dev_iommu_ops(dev), domain))
 		return -EINVAL;
 
+	/* A domain cannot be attached while using the T=0 stream. */
+	if (iommu_using_t0_stream(dev))
+		return -EINVAL;
+
 	return __iommu_group_set_domain(group, domain);
 }
 
@@ -3325,6 +3348,12 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		goto out_unlock;
 	}
 
+	/* Default domain changes are not allowed while using the T=0 stream. */
+	if (iommu_using_t0_stream(iommu_group_first_dev(group))) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	ret = iommu_setup_default_domain(group, req_type);
 	if (ret)
 		goto out_unlock;
@@ -3690,6 +3719,12 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		goto out_unlock;
 	}
 
+	/* PASID cannot be used on the T=0 stream. */
+	if (iommu_using_t0_stream(dev)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	for_each_group_device(group, device) {
 		/*
 		 * Skip PASID validation for devices without PASID support
@@ -3783,6 +3818,12 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 		goto out_unlock;
 	}
 
+	/* PASID cannot be used on the T=0 stream. */
+	if (iommu_using_t0_stream(dev)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	entry = iommu_make_pasid_array_entry(domain, handle);
 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
 			  XA_ZERO_ENTRY, GFP_KERNEL);
@@ -4017,6 +4058,12 @@ int iommu_replace_group_handle(struct iommu_group *group,
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
+	/* Like attach, replacement is not allowed when using the T=0 stream. */
+	if (iommu_using_t0_stream(iommu_group_first_dev(group))) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
 	entry = iommu_make_pasid_array_entry(new_domain, handle);
 	ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
 	if (ret)
-- 
2.43.0

