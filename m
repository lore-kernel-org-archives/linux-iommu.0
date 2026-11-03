Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729267;
	b=Xafn6sahz3XwTYvHuS1vJo4vveda1L3Lo1C3/LzCYnkxlHAVnwN0+7LiGHTgM5PJxfap
	 P4gdHpPZU6qWo25k1amNIwhqqdcde830nQVU9Q4z/hiVp7la+uKa0/JE/8yHOg8XU4z5M
	 abDyiyRzOvTA5uHtmkETn7XpaeW2ts1y8d3Lw2pCs+2Okt+Y20iFWanjtMInpVK/t1db0
	 yGjXYjcO1/sjpdp+2kJbfu1oXPupUA4K7rgLsmcrVstwvc9wBpYB71U7++KVTN5RpT1Rv
	 ZWfk9zY13csyAeT5ECYqzhp3pkAhlv9qOAh+jtpg0QK18xJpSIY2OqPqJ2sPNqbmjqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729267;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bd5FfoFP4odr9pPO3unZdQ+hEqMlsTWNyuwc7CRXAwk=;
	b=Yt9Ajlk34Ohe56i6YhLzV7vjqZELytORdPeGDOhSP4Gf3vPQXP+RHMGGa0XByt2xAfBV
	 TCgD+wf1Bbft46Y4bYEkH1oNC4OAKZBGfQxMDZVyWwVrnTmOzvEDmsce95uiQfXAJoyoe
	 jn//4JzLWurBo+O3x0JK4X28CsO4zcc1zVSy060FIGkVHk0ByrpOA3vAJjhFuwxsxdXG0
	 QhdbPGzfSYvcBmQo5yIBm2zcToYt5qTfu/BcQC0ohDnKOMy+AU25NAXdXnn8L1uzOYTOs
	 tb8jiDiowVOQVzwyeUhkGgkPIKVIK4wmikBveKQQsMWwXrAXbTzXKu/80tMmD9xdc3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DzRQRfT5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.43
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE04606A337
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 18:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE04606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DzRQRfT5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZBtsOS3plNE3MsB7UlFkdBzNPPJi8L4MaeOaUC18xZDkjHvJTYlR+ZQJ/wj7/jd8M5AnnK5xbuoWIRa70cEpN4jxzO1rdBCfrRHCAMWoHUsokoRJjA11K3rtAiSEw82dECY53y4wS3O6vFJdZ4ZB2Ku6KuNoN2PX9FfEIUbby+10DWZt0XRvBAxwyXLhjbGmKmG7C4FglZqmbBTxNQ6xmAfnoXYas8yVxbZSjwQeJ0AiwoDE5HnLGEx6phcd29WFKVONSr4RodUnDZj+zfQs21lSinZlS29J8zAd8rmYAsSzRWijg3F/vycZ6sj+uMVVyst3n15YmzWxIW2psxKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd5FfoFP4odr9pPO3unZdQ+hEqMlsTWNyuwc7CRXAwk=;
 b=d27ynEmRH6hHtnlSQlGpV7Y1Gjey8u6js+4lJSM+AKlfCjlmGWxZn6wgsoimdhrbt0GtJ2PlJba02sVmBneIjzwXd3V6LtYF51rT+ftzSj3h5Nr9rDJ+GyqS6U+bgQQ/SYhOVlxXgMlHZDMYR3Kq/9OL0TogLhjsjoe4wZKjBaKHP7ASxdJ0HqqflMU79oYEnKvwoTb3BTLPavTzq5sTlayvLmmudpiIwe0gueJcgEpbAuLO/ZNemy9P45TmHlEYZNpLnrKDZmKXDDN6s4+KRZJl7yopPBLze1BdA34KO2xjFxX9sJDTeQ4Nwxy330wZ5LtDrI80GlYN2BpKn1J9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd5FfoFP4odr9pPO3unZdQ+hEqMlsTWNyuwc7CRXAwk=;
 b=DzRQRfT59arKh8HPT+6Swqv6TD8+CuVGqpfWaAnf5RsCnhEVR79pwEZF8wRJmqoZo2LKuUWeg3JBV0rRLdyPMHy5Z3Oubf0GDFBL+NYB5++G9WAqgJxgpV6F+yvOYXrcpMc6geqg8cqJ8391HkmZKvIxJgAER+jAq3OPgm0vQ+UpQj4/4fGfk4pmP4piNo4VmYHpiW99oJMwprzk1ZKLWM5YbV3ONAyKN5lIZJEhqsiF3u+U/8euaf4VXIt/gXnGG3D/l2vzDMw2IIKFxNB8/PBmER+2Vw7essiAs83TTGx0aXvGf4V938cNffolmPkeZVbgbMpG6Zui5iNc9wukGQ==
Received: from PH0PR07CA0089.namprd07.prod.outlook.com (2603:10b6:510:f::34)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:07:39 +0000
Received: from CO1PEPF00018865.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::2a) by PH0PR07CA0089.outlook.office365.com
 (2603:10b6:510:f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:07:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00018865.mail.protection.outlook.com (10.167.249.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:07:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:07:10 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:07:10 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:07:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] iommu: Fix attach handle publication ordering
Date: Tue, 3 Nov 2026 10:06:59 -0800
Message-ID: <cover.1793729087.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018865:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: a905e479-d2a9-4324-5591-08df39d557fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|6133799003|260925021911599003|260925022911599003|18002099003|260925021311599003|261102123227099003|13003099007|56012099006|10067099003|261009223027099003|261022115727099003|261022113327099003|261022105027099003|261021121427099003|261021130227099003|261021123027099003|261021135927099003|261022075727099003|5023799004|11063799006|261026130827099003|261026121527099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	HA7Vf0U54wIDJYkSl+6EX6rQteLKgCP8HtMum7OBxqr0lWoHH3qlfMrRa/1iIStZcU99JBollXLj0y1JHPAdnAgdAwIK5HOFYTTN0gkt/UX9bGzjHOtQ1/9EpGaqoirWpxIjAV5YfYzeSx+7SX6hVVKeIzyRNmIwYvPIS+xqH1xWTDTrQU4vs0mfpTV/OiERG8lqjDA9JydXXAucmDRyf7OOhLAjXvsnsIj4TMEoQy9vC/e1mDqZMJ9baWN7GC8Zk/Z54kXSomnzlGqY06nEQ++PXZcA2g6URRvnexF6q6srcpGr7WuW8gRew9/Bt4xEuFReEXL0iHQLAtfLO8wlqnQEvaYJjAXC5ieF1YssJop9l6dXNT7ODsPz7ddryvNcrFibNv5D6bAkfLGysoUOdkzNqBbESVMm5vbyJO5gItEVHYBnbjXnYCBT15Ed7arN+18/adQKLRyCqcZRnYrMJaA6Y963PmFhgAcyeu8Li+72RssJkNQI8yB0mCdPSbDb2D/DryLiAUrG+lEK60unE0+RF5mdVkQLMhOnVwOQldVS0enJaDScH09lpqY1s/kc5y6x6/XnA/61jzsghPbg9GeV78guPJgncicOWkQWlAjd/KWS8UgZvIiHSSUTVfzdmCa8WFlsC5WKaQPi3zFtrlifcDgVOdjsPzZW6orosu72D7TrPCd8MfzLJFuI/OzTKKcRd3GcestyMr7D0S5Cug==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(6133799003)(260925021911599003)(260925022911599003)(18002099003)(260925021311599003)(261102123227099003)(13003099007)(56012099006)(10067099003)(261009223027099003)(261022115727099003)(261022113327099003)(261022105027099003)(261021121427099003)(261021130227099003)(261021123027099003)(261021135927099003)(261022075727099003)(5023799004)(11063799006)(261026130827099003)(261026121527099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vSCDjiSa+ODfQsZ/SiE9olH6KG+LApQGgoYodsnOFTjjv7mxte9fwZVmz60l8apsH18P4q7NMKmVz6dJvORAoXiQ+4FxqqSpjSPLQDayfox1PSucOBD50R5O9oWKzqcvnvdnYwP/IVuwp5Dga9tX4SprTDqw3fA3B7w15WkGHMengEktDZXaRUGjnEK7bKgyYyecAWCSPr31njZV4wxD1PQfrbwytR+OCdmFMoKoMw1d03yOw/t6b+p8uF35U3k/Bblw6TFJfuCskFcb0usmlbnYVxx08cNR5gT+dKHBjpbJ5U/iS8q3DMNDTLYkjiZ/FQzMuzZ5KsdXxvZA38oMXBdPXS225C2N4uf/E74L2HB3u1MnZsseKSCao58u8DJEPxxuT4lADewqXhLdpXlS3VwzMtNK5c/cxansjKJj46T39qNjL3dSjZQLDF/V5KO1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:07:37.5952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a905e479-d2a9-4324-5591-08df39d557fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018865.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

Jason pointed out an issue in the attach handle replacing path:
https://lore.kernel.org/linux-iommu/20260923233920.GJ2545495@nvidia.com/

When an attachment is detached or replaced, the IOMMU core can still leave
the outgoing attach handle published while calling into the driver. A fault
report looks up the handle without the group mutex, so it can find the old
handle after the driver's fault flush and just before the caller frees it.

Patches 1-4 unpublish the outgoing handle before calling into the driver,
for both group and PASID detach and replace operations. Both replace paths
store XA_ZERO_ENTRY to reserve the slot and restore the old entry on error.

This blocks new lookups, but does not retire a fault that already obtained
the old handle. The driver must still synchronize those readers before the
handle is freed.

Patch 5 rejects a same-domain replace in both of the replace APIs. Such a
replace skips the driver callback. So, nothing would ever flush the pending
faults before the caller frees the old handle.

This is on GitHub:
https://github.com/nicolinc/iommufd/commits/fix_iommu_attach_handle-v3

Changelog
v3
 * Add Reviewed-by from Yi
 * Make the use-after-free hazard explicit in the same-domain comments
v2
 https://lore.kernel.org/all/cover.1793602084.git.nicolinc@nvidia.com/
 * Rebase on v7.4-rc1
 * Drop "Assisted-by: LLM" tags
 * Add Reviewed-by from Kevin, Yi and Baolu
 * New patch: reject a same-domain replace in the attach handle APIs
v1
 https://lore.kernel.org/all/cover.1790718296.git.nicolinc@nvidia.com/

Nicolin Chen (5):
  iommu: Unpublish the attach handle before the group detach callback
  iommu: Unpublish the attach handle before the PASID detach callback
  iommu: Unpublish the old attach handle before the group replace
    callback
  iommu: Unpublish the old attach handle before the PASID replace
    callback
  iommu: Reject a same-domain replace in the attach handle APIs

 drivers/iommu/iommu.c | 88 +++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 25 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

