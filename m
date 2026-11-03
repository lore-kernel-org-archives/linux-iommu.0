Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729268;
	b=jRqZ3Dapd+XmoXUuWLzA+g6iMpe4kDHkk4tuVz4ywz5eTcKH1Cy7TnoazB9r9uZ/r7yk
	 opCpE9YWdTc1M9UntD4RhahjmeVZGDloJ7mCbctJwWRmsUtgiiw21ZMA7j6tH0xEW7kN0
	 n8h2JJeIBKk2sy5+eijyKJrfCNY3R5/MauQeqv+PSyN5Sb/gdihsJDGI7mWHmLmKgPjyk
	 XOScKcAklfw2ja289hZ7hhP6zyttww3NqED8UEEOXL4aQb0+ZJQNfe9fY8P+lwivOhnJr
	 ph5ilVZlXA8KG6Lr0t1LMJc3aZ9i+RTzbNtdCA3rACNVAAo2G2ZThYmAy382ka95CSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729268;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SHUQVauUsEy3W4aHNa9Q1L5FKYOrniGTbv9sWAYs++s=;
	b=ujG0ifx8No1hBSnz1SFiru+Eqga0HYkVPwBf7Pm/7i7GL8v7i233ErhdkuPo/axJzA7f
	 oBhtbLMOb7U6BNqb9TjLLlLsSWG6Qy3ognvaDh1cVNp6fBHM4oIsJ2qY19aZAQbXj2Qwe
	 2kVogLm+rOQCxmkYxBRdnvh9yKbOpMHnxfE5j+39LF6oBqqRcBFt53cmaD0iGwQpePgzL
	 JA5BVQlGlX6P2iTb5uq/eLqs+NBs0F6GtZTELctxQRSZvHHUqZJgb43BEhVTA6Xe5HUGG
	 nrNGy7X9rQBPGLrDUewSdGwWRrgMWe7wc5qE9sf796uUvB7ra45u8lKS/4pPMp4yQ0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mllESzom;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.42
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489A606D80E
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 18:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D489A606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mllESzom
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CS9Qdu4i06meQQxsmJTgO8ZkTnY7WdvSwNb+vwfpK24RulQ4GrNQN2pWmuPEKFz7lhonK8Qvx11UE7L4N6BUBnQaJ1Jz4VLvAyjumAO9y7GdEHYkQ2ODQ7dk2GOvi6i06bxCs9HfC7wp8SJcLtlboGJBG9aJ4mSSKhfoFZoAN4V+tQVg7hjXMZDSTSF07aRx7WFW2WyLWQVKQFMqR+g7/cvHnxF0sNbAj5TfTdXeYBk23Uiw7oDJWa55pd1JXyEbYwR8MtfHxL7XdB1jaXmtNhoXWzOlxRKKuyZ71tldDtcDsuJjs7VX7E1VDy4r1zjjAJQwScF4K8fvNu9FxyxoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHUQVauUsEy3W4aHNa9Q1L5FKYOrniGTbv9sWAYs++s=;
 b=QdECii/RWsl8qchJz/HU4T07pgp/ilY+HynHZMMifzKABpGIOoy/NUarDIWR71qXFB/Vn3mmkA8KXxLvo0YkHekgPYM/oDtVOKhaMErbkowuPpF7Dsn4ruHKXbJxJLVRskTgQYhNep2266NVA681l4lYPAajCeUfIYhJW8bJSgMj/CaZkDcHOgcQvb/vmqOepWKpLYjKyggPAU10SCpE0niU7Xd9UermzOCUZzvGgKXbLrRYa3wXfOYcEVWH8lUgEYEZh/qWhmxxA83w4nLaDli2Z/4Wpe5pHnLnD+6ivr4g4d8NMarPAok8+s2VKFX6GoXT+Y7DPQ4stKWeDqtBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHUQVauUsEy3W4aHNa9Q1L5FKYOrniGTbv9sWAYs++s=;
 b=mllESzomK7AVNz25rEcK/KbFne/uaXtoJLx8Mfyw0TnYG39PGNVWHHcFx2FR4PaGjUkFUmonWOlE+B6abkZ4ehdU+TM/ok/0x/akg3wCp55fEWubyEtYW6UC2mwtLoyvR5QOYlpFCD7mY4DfzgTdltDboagaO7LzfO8XpV4xdLrKpaDpkF6tuYbABsghd2alLsCz5/2cvObIU7KpbacBbV/4y0WPXSQaEvU30Fk8QRkpV900k6Y0u/CayOGHkwvabzLtzggf1WvI7Gz/Zlzkr3Ohdvr5+/djQL/7citTcPKrwmuzq5AMw9yOsblWvtq6UC5WuEDoNZJWJqT4FquajA==
Received: from SJ0PR13CA0126.namprd13.prod.outlook.com (2603:10b6:a03:2c6::11)
 by DSAPR12MB520039.namprd12.prod.outlook.com (2603:10b6:8:518::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 18:07:44 +0000
Received: from CO1PEPF0001886A.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::6b) by SJ0PR13CA0126.outlook.office365.com
 (2603:10b6:a03:2c6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:07:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF0001886A.mail.protection.outlook.com (10.167.249.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:07:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:07:15 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:07:15 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:07:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/5] iommu: Reject a same-domain replace in the attach handle APIs
Date: Tue, 3 Nov 2026 10:07:04 -0800
Message-ID: <1b3a334eade93a5047d51af040f1400cd563189d.1793729087.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793729087.git.nicolinc@nvidia.com>
References: <cover.1793729087.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF0001886A:EE_|DSAPR12MB520039:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3cb266-bf25-4519-9f09-08df39d55bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|261022075727099003|11063799006|5023799004|261022113327099003|261021135927099003|56012099006|261022105027099003|261009223027099003|261021123027099003|261028144727099003|261021121427099003|261021130227099003|261022115727099003|261102130727099003|261026121527099003|261102123227099003|261026130827099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	gFkI0wSk5eoLxYkD4pY8t+Yezim88qAfcGpUV/AdXtV+8fHw21se1J/x9D4XeZ1uMA8RSyrbmTKYJocwJi1iD6h6+4NZOTM+511J6hdStHIeQUytVtO49C+SK7wdiwhj0+aFlby8O+6fhWoI0ZN3dKUGDML4/jDFQLqrzAGzFON2Kafywf2Lfcshq72yv1nbZ8NMxLKs/rGDo8KZ3FD8jSeAbCkv2MTCmenpposQqc9paaOzFEgiM1z71sPhO0zsb3IpRDy5wzkN1xxAGz6BXj5mfjIqju33caXzJBXTZEdmohRUgRIPsgJBiYUVoJgEKgQBpBz2xq++xXAGS4h1RqT+NKAXvFWVN4nKuYD0u9Kn5+qglyEfG0N9dYmd2h/ExDIZMrhsCiGqqqCwz4tGLGOfslfHw0tZHuwT2y5ha4LSylasxuzILuROaZ4oEQA6Bnq3h7iUvgWdcYAaoLnDhBMZCzyMyJicCQUuZDs9WicXunns60PIyJJAqHT+howgzyk92xQp+TBHYB3d7RswLSMEIYOHp8gjnl+85vIxSRIa3tpFF8Fp6QIuUJZGmRFRr0nvK0T5OpFG4Evrgd0SBUu4y5M5i4lfQ4YKkX5ChWjWFU+UM/wKhf7lGV+FYg/KBTHjIGE3/aetdGZVTTdjWOfSG8xeV5+qPpALpRHOTJdZaDy0VRWzRczSJMbEt+xN2FMm/7AnWjye7w4pjczm1A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(261022075727099003)(11063799006)(5023799004)(261022113327099003)(261021135927099003)(56012099006)(261022105027099003)(261009223027099003)(261021123027099003)(261028144727099003)(261021121427099003)(261021130227099003)(261022115727099003)(261102130727099003)(261026121527099003)(261102123227099003)(261026130827099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R1r3suXO8JPml9GiJCoZUc+16FYdTQyntrRoKWHnWz9FbiNKqc5Q0yjy/vver/UkKDqCEBMQe8KSslGa6/UeLjqix0j7H570uVonfb1XxOy2vInwd8GuHcAtrcDz/OIh+5+dN4I5argG82/BaECPaJAFtKTbFBcqNuO7LpsN2Zki1CH+cSrJWB3dI+ilHE5ZBopMPyW7+zVGDp7SZ2IJnPG3gW3HW6lW/sD636UmxRw5JdGWpHJSPTHnGH3HLG6o6Dh5tbtGVvjGZfXh+/lD1OuBzOs6srAubW7Bg4XGBxnqUrhVqydRvb/JIJLGBHSJn8s4zWx9OqEtSQMnNBBy6r9gvPxsijy2emKMRREWEjA4j35HYFXd2zcVfTXHOoLwRdHIrLotEKCVraPpY35ky/iBSTm+2dVCxa4P71VNYvWbkKafAJJmTPe5sw6AZNHJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:07:44.2385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3cb266-bf25-4519-9f09-08df39d55bf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001886A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR12MB520039

Both iommu_replace_group_handle() and iommu_replace_device_pasid() skip the
driver callback when the new domain is the one currently attached. In that
case, nothing flushes the pending faults that may still be holding the old
handle. Then, the caller frees the old handle once the replace returns, so
such a fault would hit a use-after-free.

No caller does this today, since iommufd_device_do_replace() returns early
when the new hwpt is the old one. However, it is only a caller convention,
which neither API enforces.

Reject a same-domain replace in both APIs with a WARN_ON, and document it
in their kernel-docs.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3fea48d3538ad..2dbf691dfb581 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3716,6 +3716,11 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
  * Caller should always provide a new handle to avoid race with the paths
  * that have lockless reference to handle if it intends to pass a valid handle.
  *
+ * The @domain must not be the domain currently attached to the @pasid. Such a
+ * same-domain replace would skip the driver callback that flushes all pending
+ * faults. That is a use-after-free hazard: any fault that still holds the old
+ * handle could dereference it after the caller frees it.
+ *
  * Return 0 on success, or an error.
  */
 int iommu_replace_device_pasid(struct iommu_domain *domain,
@@ -3785,15 +3790,17 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 	}
 
 	curr_domain = pasid_array_entry_to_domain(curr);
-	ret = 0;
-
-	if (curr_domain != domain) {
-		ret = __iommu_set_group_pasid(domain, group,
-					      pasid, curr_domain);
-		if (ret)
-			entry = curr; /* restore the old handle */
+	/* Same as iommu_replace_group_handle(), reject a same-domain replace */
+	if (WARN_ON(curr_domain == domain)) {
+		entry = curr; /* restore the old handle */
+		ret = -EINVAL;
+		goto out_store;
 	}
 
+	ret = __iommu_set_group_pasid(domain, group, pasid, curr_domain);
+	if (ret)
+		entry = curr; /* restore the old handle */
+
 out_store:
 	/*
 	 * The xa_store() above reserved the memory, and the group->mutex
@@ -3985,6 +3992,11 @@ EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
  *
  * Caller should always provide a new handle to avoid race with the paths
  * that have lockless reference to handle.
+ *
+ * The @new_domain must not be the domain currently attached to the group. Such
+ * a same-domain replace would skip the driver callback that flushes all pending
+ * faults. That is a use-after-free hazard: any fault that still holds the old
+ * handle could dereference it after the caller frees it.
  */
 int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
@@ -3997,6 +4009,16 @@ int iommu_replace_group_handle(struct iommu_group *group,
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
+	/*
+	 * A same-domain replace would skip the driver callback that flushes all
+	 * pending faults. That is a use-after-free hazard: a fault that still
+	 * holds the old handle could dereference it after the caller frees it.
+	 */
+	if (WARN_ON(group->domain == new_domain)) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
 	entry = iommu_make_pasid_array_entry(new_domain, handle);
 	/*
 	 * iommu_attach_handle_get() runs without the group mutex, so unpublish
-- 
2.43.0

