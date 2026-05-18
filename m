Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F68436215A
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071347; cv=fail; b=qUn7mEFuBk4jVWNlcd741p5b5MfAJs/sIV8M2Rt5P/Hd93N6JER9S9QBqSfD9b0yFutyqWMv110d4i7vNmtCrqRfM2FDMajbsw3LluuYn3hg4mOAViTqN1y+0tObeFvVnDxOCnTkDZRGV7JiQQJf205OLicOkveb+vH0Pi2jJ3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071347; c=relaxed/simple;
	bh=v03WgPVTWKX/kBp8V5GyaiVo4LfO5iQnu/EsHxC53Vc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfDHfms+FsI90rq1fGYW8nKrNoaf6gkVWn3dRyiH0y6Rs3PPr9garhtXB9EKByrXQr4mSHszgiycFmtsWdmrnmtRii7uDo3aKHcKSCqRmCj+1y7MwEVdpkZFFjblyCDFYorRDsJbLMGXvzPmABeDF5jx7x1kjVEiGP2iLC6yXnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fbxbfAkC; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fbxbfAkC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs3/MArqgUJVI1w2qFlIuyUg0X6Pczj9wvcxqjtMmyIGfd5kiNt5+tyPyuCLcKDxjULkxSKsaWhyAjEwmWAY4s2zKoI/BAJZs3NcDSEKpF6WV6i4cqZnGXXxrzbWmSD4waJgtmeZhXzqDbD0dqJRkYOH6H2rXTA9iSNuGL8zDiA7PmlGCvL/gOZ2N2y+QwWwt5t/e2ebEo60yXEPcXM6F0AcC+F/HClfPussy4lwMpbRdXVSp2TEsLEqPNNEirgdcVUAexTqieFxjtuAXRyJ+iw6x2PMiFBzpYxTVGhuezMbxCegP61aAQ9fbP4WGrallEs+SmtHfrqxlgWhD6LMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMpbmpsQR48DXmtc+hFTduzGrl+wBGpIMJM9PYDb/H0=;
 b=MOdf/0uhLXROeOU8rZASAuX+HUgorqBi664iPqVgMQIYgBt1KhnHgMsgXmIBunvuBSQNHMZqpUMvLE6EHBn5sj4b/MxYYqr0sVZE53FLnKAMbpALKyFkp19/7vsdjsHAsq06+ztPdtpCXYiKaMivfCRKEnhNnlWWI1AHhty/VdNDvKG8cGtBxYhOGixTDOXi1DWXFmyKOjsAIIvIO/sSk08Zw4oajHjFAFy9Twe7DWSUs7kMdQwS04RP0cdqhS0PCWxbec4g7EeKXp8T7+Tg3/I0g8gJDQYoB2mPVgLNdeVZ3Mmo6DJMjICOokgAC6++6Ium3MauFLUPcFJS/RJS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMpbmpsQR48DXmtc+hFTduzGrl+wBGpIMJM9PYDb/H0=;
 b=fbxbfAkC3x6W4c8A+eQTmL2Pc0xANK6s7GbqjOB9RJ6OYByJB5vAREN369PZzjVxC1f1Nl/cLJIeZyiNqJU7gIctfL6HsAG1O2eUM+gVZRjabIoLHz95xra/U4xvNDvlY2eI8bN6kaOFlTGCVWldn2DoNnNzLR9BcrPv6sPov+D+y7tnnwalmCiE2K48zDCfdQLkZkbfNN+yAC7i6/9ERR/MRakK66+v1foUEfIc8yOd+/DvoysntSYrV+3AkTqW7+v9wMNU890QiGadscLSufPuq1ISkJNFmdhah6tG8QFktCJvF7Xgj99d9tvhBRRfw1lbSczoPSnEej1EueVtug==
Received: from SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 02:28:59 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::f8) by SJ0PR03CA0378.outlook.office365.com
 (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 02:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 02:28:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 19:28:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 19:28:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 17 May 2026 19:28:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v1 1/4] iommufd: Move vevent memory allocation outside spinlock
Date: Sun, 17 May 2026 19:28:46 -0700
Message-ID: <446bc952846ad0c98e5226e73cd29b560d70ceb7.1779070992.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779070992.git.nicolinc@nvidia.com>
References: <cover.1779070992.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d69e00-af9f-4a44-0a7d-08deb48537f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kkTiLXO8c2Psyzwk2M3Yicot5bJWHkLtlLrIJIvPV5nXpMmRuKszHmpalCFiWcdJB/2fYLM01zPFWj390FgyPIuHMjsyNPGDhpM60EE8WCX3E+IYQMuQ7dAHz76r0gdPqt6xhPOwQKTcNzmD6nWpLYRwyweLzAT6vWdLXRqQytL6nADr8kiXe2GgYqA2ZUtmJMvz8DVsRcnKC5cXHE9tr4jvAMLBctUhIgFgp8FosKupcN4v3HBzycFChmLIQx2tPsHHXO2V9SRJzGyahTYgGi6p4tnP5Tbg2gW4coerVUI+YbDIIx2o/U0ynLmAgT6saorURFKv3B1pFox0kOzC+lz0JteTpz5K8FMT+OL3PEXGQ/fgpnc7kJ97TwvFuKiPIDM+y3TSY0SY76m5n+WHLyOUAeXGBO4glMltI/FUdDwCo8Rsh+1OVRD0Zbu06yrMTC1iumxFuqVcyJ9DTLhnkahKOlXrRBU4O05KFIbeOboGvhGhuAxoRxou+Qv80QdvgkLy2jPu4uJBFBasK0gg+JNhW3/A1HVs4nv0H9OL+NHY+KXdH6Qae+2mEAmYwZCPW/avYaxTp6DJHQNiZ73zWXynyQ/HG9Q+XK2waWcRRjrYZ7X6U01KlMRASlHXkl4719MPdel4Oeb0nfIYtks+UriESZwj3jBnlMVaRU7I53GNnUIHQYZ78ZDfAoSgrgD2MAuteOZ9Q8yOdspMz2rogi9QVRuexAQF3jfC5Emjdco=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yzH5c4Z/CK84/XsAIvw334ESJGoajkGYJJkgQ517N592Ck5BJujzFbl8sOJPmiAgXtMgbv8Sk9dNpZyQlfbha579lqTTUPMsHkDSTt9ocQJCJvReM2+qWxc6ax4aU0XdWLOI2OoKYtD8/9cRFaiydn2ut934tFdBgfExSUMhtsIN2E2YSrtyAoODYT7Jk0+mhhN9QgBWA3evE3AxZFqbbEc9cpYp+/F6vJbhEX3IYKm420T9/E0n8bGrQYTi6oXuAhpN49RwRVd0cnLkVjAHSnqL6e8V4cgat4o1zMrZi9THRz60c/oi+yo7p8DN7OBfmIdrjldYvVqrDjrTjwreWwXzjm5Fx/xHnw2fws0W+VztuTqPUt/tGw1ckPJ1HYc95GyQkZ2KPUnO2PPwPknaqdLtZrwbSXr6/K2QDsepknuIZwina3OwruiHPVNGAd7Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 02:28:59.5276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d69e00-af9f-4a44-0a7d-08deb48537f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

The veventq memory allocation happens inside the spinlock. Given its depth
is decided by the user space, this leaves a vulnerability, where userspace
can allocate large queues to exhaust atomic memory reserves.

Move the allocation outside the spinlock and use GFP_NOWAIT, which can fail
fast under memory pressure without dipping into the GFP_ATOMIC reserves or
direct-reclaiming from the threaded IRQ handler. Treat the failure the same
as a queue-overflow and return -ENOMEM to notify the caller.

A subsequent change will cap the upper bound of the veventq_depth.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/driver.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 61e6b02601d1a..b0dec089aeee1 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -149,15 +149,28 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		goto out_unlock_veventqs;
 	}
 
-	spin_lock(&veventq->common.lock);
-	if (veventq->num_events == veventq->depth) {
+	/*
+	 * Optimistic skip when clearly full. A concurrent reader may free a slot
+	 * before the spinlock; the cost is recording one extra event as lost.
+	 */
+	if (READ_ONCE(veventq->num_events) >= veventq->depth) {
+		spin_lock(&veventq->common.lock);
 		vevent = &veventq->lost_events_header;
 		goto out_set_header;
 	}
 
-	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_ATOMIC);
+	/* Pre-allocate to avoid GFP_ATOMIC; use GFP_NOWAIT to avoid sleeping */
+	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_NOWAIT);
 	if (!vevent) {
+		spin_lock(&veventq->common.lock);
+		vevent = &veventq->lost_events_header;
 		rc = -ENOMEM;
+		goto out_set_header;
+	}
+
+	spin_lock(&veventq->common.lock);
+	if (veventq->num_events == veventq->depth) {
+		kfree(vevent);
 		vevent = &veventq->lost_events_header;
 		goto out_set_header;
 	}
-- 
2.43.0

