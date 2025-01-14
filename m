Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38CB2139C7
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897356; cv=fail; b=K5aXFKbvJga1kx3jlakG35CfF8yRd271ztHbx4pcx66P8kgHD++BDnyVkPtm7x0RJ5HbomZpjA/131I5GRzfWM9nLvL442Rkef5bGCSs3pQDCP/pPB6OBJbgvZ4eB64na10REhrV3tg3cbhKlRJRqKd4pd8DtIOseNKHLGLKEIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897356; c=relaxed/simple;
	bh=4bLFP3MASfMfay673L52XV9gf7dgB5ZNZPg8cvE1u0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHnehsxT2nDnXiuBvSPv9797iUFdwatadUoOvxYX8vFz1NYHayFpGor07RFxvjW7Xs9ww+X6CGRdDBzGIJUZ9J0EBpkwgyLQLpC2zYN/cIYfSSnKFOeYv9pGJCFYXOYS3P+tHwsDC8PVouC1dp8PGbTXTajbRS8VWGqnLmT6Va0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QIf6d5IX; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QIf6d5IX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8AFO59/0OK2G8+DTJr5Wpbk2U5ysq1QY83k5E+EpQ+K/RK6psJeMTPfT58pPIBpw4dTeQ1QZkIhwWDcvnSUNs67s76Y4qDkb0L3eLcChgz414SqwMuJAyiXIj1UI053LdIJlHK36GLg3kkv0uCzwHqP/wU0d9MWYTq+OYfg8d2mFU8/ubr4TEuq9gP7D+it6nVy7D4wghfXftZV2QEpEtuFUVZwahE4dpzxMXIJAj3L9L6c7LzhdptR0zlhmEo1Nwlnd8fvGoKZhp7UvuNchbb/nNWUoBrkbR1ub2vOVAe4JvhTUZSbHDtkJGK8XXWmUwwZZwvf32zFjaX9GWw5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPVoGV6VlmDmlGTc2wxRpBC8dHu7wnuxfydOXhQhtlY=;
 b=EVQEA/OU+pkulQBXyfA1b3+lB0JyHQM8qJCKemXKqq3LFCS1ItJuxaDAonZYZxmCUBREWmc2H2/08S+H/c10fxIUCOLa7iHTrOlIcZhKM12iYiMOofPIrNEdobKg3hwqUk1C4mB3RzyIR1fVcAN8XiveB3O/l0rO5O9IXHKCbA0SMu/V98sz2jGHim3SDWg1lXv5sQRTYeDxYNYxa+yReeNrC/w4T0E05JuACZpkxnDY7ZSd3dauWAeB438PIKc5oJTlcoG22hNipCeF/WQLxIqvhJZF8/1314mmGXTRVTeJnYDx9IB7rhW9O+foVXvEiEAhSBY4PBBAehpggNTKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPVoGV6VlmDmlGTc2wxRpBC8dHu7wnuxfydOXhQhtlY=;
 b=QIf6d5IXqiuMkfeWkTavRuhkbMzQfkFg7lF96SsC+ibgKjRaV7f6dGrzUYph+v6jq8UvkC+Ujq3HqtXJfSQy7OINEEJotMIBgKS57qwmSgk8DaiuIlK1fYZ1YAXKYhpgNj5ibgJBSaiB+Qa+64Jxv9pDFccru5qQXG6h5SfGq5E+lfkn7VBVICelMEXlIDlH2vxL+BeF1fKe/glNA02jiAAniArKN4KGlel85dlJQlYWpeXbiFfHa0/VUrij87sx9vKTtuKmCjBbRCOUfi9snrUO/ZYhpXbJjpDcJry97woSHtCwNqQLf3rWniCwD8afFA/q4eC0qg9N5wn63KOIxA==
Received: from BY3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:254::31)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 23:29:08 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::af) by BY3PR05CA0026.outlook.office365.com
 (2603:10b6:a03:254::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Tue,
 14 Jan 2025 23:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 23:29:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 15:29:04 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 14 Jan 2025 15:29:03 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 14 Jan 2025 15:29:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
Subject: [PATCH rc 1/2] iommufd/fault: Destroy response and mutex in iommufd_fault_destroy()
Date: Tue, 14 Jan 2025 15:28:44 -0800
Message-ID: <5e78ecaa3f731c782785de7b1aa5cc535f3cb0a1.1736894696.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736894696.git.nicolinc@nvidia.com>
References: <cover.1736894696.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa8d1c9-97e4-482d-a330-08dd34f33e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iqKPjMlX+j4UOrMi+yIV9EjF3BQbqWWO7QRhDl0WaL4MFCitDoFpvGqxvX4y?=
 =?us-ascii?Q?tjGQqP12+66E5ch+AMccK7KnjFAwgG+gQtHLgZ7cLUiehvCc+Qm/T3Tju/XE?=
 =?us-ascii?Q?ryiTvxC5VobtKJvlaISJAvfQjwRyvdvVRbCY5zLg22jBkoTvaQKDOfkchsIh?=
 =?us-ascii?Q?+PMc1hydKJPNJmSWdDDwn3t45v7p4TN8+cWzxeTIxCtTNpOGo8S8dkIqoxA4?=
 =?us-ascii?Q?cY6N5WUNenyx1IcPfpsErQNRoT7cS7LgnJd+eL/Z2Z/7keziVQ53lm7nx/WV?=
 =?us-ascii?Q?NVyi34IuWYNPLxFlyg14N94IheubZdN1RY5e9Hz7TzvejbOkE8cMVZPtcc6c?=
 =?us-ascii?Q?XC3o0B0oNF1Bjjhm9Ok2imKeL62apEDEnmAnkvN/X5+hiT1edsHUX5oMhM0v?=
 =?us-ascii?Q?SfSS7zexJbeJjSVbC0eSQTVNAej7TG3SS6pG+pOsP8VLKtVVtw6zxyj1VZ7v?=
 =?us-ascii?Q?zSv6kpZIBdsYei+tBKXvhrlYGN5pk09vkYqdCEmvmeKgCbgEglfzeO7zC1PR?=
 =?us-ascii?Q?Wb1TNoz2f3NdF1j1pHoY9ku076h+feZtVNGyZA2b9cooc+EKECWAFz0sGO6k?=
 =?us-ascii?Q?5ZLUAly4KpUgORD6CdVULK+jCIW09JbvBuJIpt3lKd/+nJDOgIHQRz/ab8ep?=
 =?us-ascii?Q?mK1OqWSwGX5SFrTfIlY7amdIndmYIXP92YHm6ZAhB1ohNZYwIAWRznNlX43w?=
 =?us-ascii?Q?AF3XMLIsH1kAPSU34itO+xDSTyfSlChZ43GFmYm6R79FaFVVex1WgEiDRSIV?=
 =?us-ascii?Q?i8c9pZLXbxk4XS1hMrkjBqFjhjHk1tAOEr4vUIPhDmy0DNaXt3NT9pMm3zmN?=
 =?us-ascii?Q?xt63q5da0fgGGwyYg4GSKwBm4iD8kHbURkzKaL6lFd6A76HKK7nYOap6UVC8?=
 =?us-ascii?Q?rQ3rjKar5h0nfoezGFaYjo7tHQ7KJ4xWjm5q7icqhne9GhRtqIt09WHySxwh?=
 =?us-ascii?Q?xE9FDAqQS5/vJPw/nPV1GUdqjb+uaLLazC4SP0bQ5yaz376vdrRy/bZUFGYR?=
 =?us-ascii?Q?55z8L80L44Sq9eFUiAiJ14A32KaGhNLpWRO+pvotaA7nRkFgExIyXdTattbU?=
 =?us-ascii?Q?+bhFdxOx1bPcl1pelwpCl5pJ1/DWVMaOGns5KSi2yVdL4IzmN31l9dmhVk7e?=
 =?us-ascii?Q?xxbln11TNfi4IZD/84KFzuBO31D7JTZtVvK2QiJsuUM0bMcac5n39HzcNfgA?=
 =?us-ascii?Q?hLo/r1iTMR8jlQC2fgV+ZflPMBgasiGsNs31xwzIDw7lFoKVGyRY4R/l2ivE?=
 =?us-ascii?Q?baL+gUxYevUQMQJ692Rk9hBsUtGlQ6zePKGFUE+wItC1uO4twq0jsEelM3W4?=
 =?us-ascii?Q?MPmDFhinYuxevpkfSwMnPfixRtANdhqoORCfEdcSZ+bPyJ5OtqPMfu4TJVIG?=
 =?us-ascii?Q?bDOWOMNqiK6J/vdqLZ5qxQEohd8Krz9Ceq9jmSIa9U5EiixRKYanSgAlPAR7?=
 =?us-ascii?Q?Z0rr9wp1lcMIwRd/fHT4/bC71xyrv1hriD+/gz9alJeR36nWlq5D3AiP9UHL?=
 =?us-ascii?Q?OvflzLKbU+AxDTs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:29:08.1369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa8d1c9-97e4-482d-a330-08dd34f33e32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

Both were missing in the initial patch.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 1fe804e28a86..685510224d05 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -213,6 +213,7 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
 	struct iopf_group *group, *next;
+	unsigned long index;
 
 	/*
 	 * The iommufd object's reference count is zero at this point.
@@ -225,6 +226,13 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
+	xa_for_each(&fault->response, index, group) {
+		xa_erase(&fault->response, index);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+	xa_destroy(&fault->response);
+	mutex_destroy(&fault->mutex);
 }
 
 static void iommufd_compose_fault_message(struct iommu_fault *fault,
-- 
2.43.0

