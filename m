Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793603132;
	b=MBcMgcGltFJ5bbwWdmgJnPapfzmcHKfP1/Uw57RYXVWp+dOEG4wSydIeEb1mqAxu1eNi
	 5IT6lOQHilF7hKr94uZ8H66L00widNtExhrjcARv4xYL5we2nBuGrS40Ju2JveN2wXhXd
	 ioHvJDxlhWmENZjWxm0SofaEjpgiMcUgOLoSjJVhvKryvsta3E9WeU2n1hz6ym1nWhT/M
	 OwbKCfpEvGxlDAumh4CehMINMuqqlC+FBLL+qBxSNJeS4Kvd1o43sxd3FJpm1xTdP3H6/
	 YgySSWWubELTBwofmrQmPdV/qabNe5h/RQ1wqqLycVbFdEpx67mgEDuWWIIhIwrvlIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603132;
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
	bh=sIH6uqdcxc56npraT4vZKiBi4Fr15Cmw4x0ME3mTqLA=;
	b=iXy5fd0mxXfehtDHiyoJpv0i1TnGQLEYun07c9ETjvY3EOLwWBIt31xZoUaEWgcHSqJk
	 dcVMTTNFEe9OEUbL3NWoFM+hLitChSwOE+6cdcrW7oT+8wdsXr7oRhdaHGKv+K72zwGra
	 uwsTVfWhELdAO5hl4z88fGXRgz9PNSewcbnDBJJBkuwKdlIVQ88F9I9FGtDUyHVM/ZFU9
	 c8Zq6ukp40xw80bb2+pirgIXrkdDjoGPWlt2ZB8lMrsLoFbtj5ScMTnY4jppnV0IZcEWZ
	 669uhLXo//DehFuOlPZsit0jd771tC17Dgne+gswbgpveGo4iYTqFzIOujV3g6If1KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rR3bB130;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.55
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F0606A32E
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 07:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C25F0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rR3bB130
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn05dkPH1xvjujpXa6LN2+bxjPD8Qx/N66H9/+luRif2EWBMMCw6ii0YMucJ/G/iJ0ndyXgLxN9684mAPV5DtQE63Y27ZOOBbaYkpf9FtBzzauhd2ZO07LNSasavCl5XMtYb7hO2hS0vs4Bok8zRQ0UixHdiRJw1i+0h5HcovyOHDW0B9Akh/SEL5MIOp9YPYa0wWOH3he3df5C0IQFCznNdzPR5VIGnsnjCXHpE61hayYxMCaRe1g+4cZKr6eGvPSH06F3mhgB+nILtFR+uUCKvWRJr0BzomoS1yf9f+IhuwDUqq/Q4L7dGiYIqWpdqCAw4EixcQvQtq1WT/dCKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIH6uqdcxc56npraT4vZKiBi4Fr15Cmw4x0ME3mTqLA=;
 b=g8KnZs2sxH0Q92xVnG9kOjb5OP5BGQC0jX15BIpjF3Vezhqi3w2xiqRndoy5FSgaut+GryKEh2Z7eN+SomKlsOqYOEVsX9iFcRjp6plwzCMZ+EGq3kcDg8pMswp7/xrZWuBfFrsJm4q2ZSOaw5mXUCx0hjea0KBoYHCgAwd5JA6syvjR6O0DMPp8c/gWXbYYmbq3oDp1JFyMNqpHp6r+WIefrnd5ryIgSYvlCfT4Nl3VBRFwA5lu91ToGFOuCyj5NnRg9aY6kHcRzfDNmp9PHrMIaR+/5Y57p8/DToFeaNEnaXroVHaqRMdWc4SA5PAjMNyumjkKxgqVAxAQ+obFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIH6uqdcxc56npraT4vZKiBi4Fr15Cmw4x0ME3mTqLA=;
 b=rR3bB130NRKK87ohJk/wpfSOt3ehUqUnVBJM2X5j8mprpUTb1FQkDPI4Xb5r+j3fu2Ug9PV0MIct1viXwBR6u1MOqdRVBaAL+zsFeHmcVPqUFJhHkKdHf4IHg+BQA1Hm5gFeP6CyYLLhgHVs6gYzAFUqSpXgczOCLIz0vmp8zFny+XQixNPN/kIZNoOwzD6D8HxIOJUromZg6y6sh276hw6ag3dvo9NHR5gNng7pqEBKtj+hcNJWabp0tcoyogzi7K/tD/rTKWj4t/0j7Bibz/F45DB/dg1Pt13Lfot0n1HDMA7GmBYsLB20nkt7770UfK/hfg5pZq7WdqsfpfNvVg==
Received: from DS1P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:44e::17) by
 SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:05:27 +0000
Received: from DS1PEPF00053450.namprd04.prod.outlook.com
 (2603:10b6:8:44e:cafe::87) by DS1P223CA0028.outlook.office365.com
 (2603:10b6:8:44e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 07:05:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00053450.mail.protection.outlook.com (10.167.23.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 07:05:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 23:05:14 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 23:05:14 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 23:05:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] iommu: Unpublish the old attach handle before the group replace callback
Date: Sun, 1 Nov 2026 23:04:37 -0800
Message-ID: <824fede620da3d8661d4e1b85e6e9911a13ee13a.1793602084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793602084.git.nicolinc@nvidia.com>
References: <cover.1793602084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00053450:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb11595-6087-4db8-d9fe-08df38afac32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|10067099003|56012099006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|11063799006|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Glsz5c4id1ZGL7kDOzJZgcYRS9Q7dvMH7qbxjXWgIhdxzYMwGxpKeLhYMWLXew3THg5n67WvZGV+Po63pqG1O8jUOmkRmvc95s5ToTJXjGbU4jmhw4KMZoxFAk7Qo5yng77x8s6nn5mbbtOBASSlbwfEYai7h/HmWNQrmlZe5O2KgqeB9cniHzJ9uI8IjRzGwmZo7X2v1MZbDASPd4hSckvs5CTjCKL+0PIgN3/yX1xXApUGPlXQeUvYHmXUf9219fsq9+0aGboGNMu01ct87kbZHNFRwVnyz859wLy9B8ZSNxJQWUqVBeBV+q2w1IRcOgREuJFVo19wMVp8TsLZgaq/Tg3cz9QW7CtQs8vwcL+BOmzjDVZ3P087ZGWy2VsdJD+J+XVCZYtVmGvRv4O9ks9U2yi16mNAJp5kTGNeuhBZlRq2BmqXSD2I9q+2ksyr7p7bN7I/Ncs5Te3YPRC5pQLmrUDVIZavFA6X+m5IfACZYFsEDFIiGaTsiSkOO3D7eZiMNfaX6O9Bg4GX/0QnX8F/Yp7G4ajeRVbTX93K8sdbmOwAMjqmXiytyFHFdPm8wF2z4Mkw4UrjFTHCdS3nBx35MIH2zm1bxc6kMRSYlXYrEHajPiIhlhWWoNJV5UwKk3IQvjJD5X1AQPrkdhoYq78p9znW53dpXzP2PTu145kqAcTFO9/s6G5mmdqUqvnDKV1E0NVwhblOBlNnedlQhw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t3hilyIp9HedCe5cNhH41ms4n+WUTPgq5UMuCZ+tuRUtDeI7nqqdqEiEyU8jKF3aWKigt2tVnkxs7pO55hbpPYzeGJ4i8FiDdF0/GBVe489eMo8sVVCKAGXabF8oRKiwu6eRDAJrBSc8M30/vTfU22SdClmrtXIQ1+Scm5a0lMubtwT06LjYQ2fgBu4hxp9Deo2KGm/mKAl83OkSWtMKvaXtRSTjzKueQ6PX/om9cFZ9ewbdn3FtIy5hcnT9y5d5jsN5lAjO1KlglMToGGBM6jC+fxbU3u0NTkzYftS+wDSbFx5RCJJm5txQ8VobEYzgrS04rgXzb54Bz22Y9csDV+WwZy+VURGsCwrBlChxg9BO6QE8rrE0BITwFB9S1uaPZ/QCSkWdSEgo8X7H+Dzn8fWmFMN2SSjoy+DqzPWKFC7fJomhQahIcnOXH3odAfYH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:05:26.7822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb11595-6087-4db8-d9fe-08df38afac32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00053450.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687

iommu_replace_group_handle() looks like it hides the detaching handle ahead
of the driver callback. But in fact, xa_reserve() calls xa_cmpxchg(), which
stores only when the current entry matches @old=NULL. For a replace, there
must be an entry sitting there by definition (i.e. @old cannot be NULL), so
the compare fails, XA_ZERO_ENTRY is never written, and the call decays into
a plain read.

Therefore, the old handle stays published during __iommu_group_set_domain()
and only gets replaced after the call. This creates a window, during which
an asynchronous fault path might hit UAF:

  core, holding group->mutex          fault path, no group->mutex
  ==========================          ===========================

  xa_reserve()                    ,-- old handle stays published
    no-op, the slot is occupied   |
  __iommu_group_set_domain()      |
    driver attach/detach ops      |
        iopf_queue_flush_dev()    |
                                  |   iommu_attach_handle_get()
                                  |     reads old_handle
  xa_store(new entry)             `-- window closes
  mutex_unlock()
  kfree(old_handle)  [caller]
                                  UAF: old_handle->domain->iopf_handler()

Replace the xa_reserve() with xa_store(XA_ZERO_ENTRY) to unpublish the old
handle.

Fixes: 8519e689834a ("iommu: Extend domain attach group with handle support")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index aa50a8f6ef6f2..0a199c1c3141e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3985,7 +3985,7 @@ int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
 			       struct iommu_attach_handle *handle)
 {
-	void *curr, *entry;
+	void *curr, *entry, *old;
 	int ret;
 
 	if (!new_domain || !handle)
@@ -3993,22 +3993,25 @@ int iommu_replace_group_handle(struct iommu_group *group,
 
 	mutex_lock(&group->mutex);
 	entry = iommu_make_pasid_array_entry(new_domain, handle);
-	ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
-	if (ret)
+	/*
+	 * iommu_attach_handle_get() runs without the group mutex, so unpublish
+	 * the old handle before the driver callback: a fault must not resolve
+	 * to either domain while the switch is in progress. This reserves the
+	 * slot too, so the store below cannot fail.
+	 */
+	old = xa_store(&group->pasid_array, IOMMU_NO_PASID, XA_ZERO_ENTRY,
+		       GFP_KERNEL);
+	if (xa_is_err(old)) {
+		ret = xa_err(old);
 		goto err_unlock;
+	}
 
 	ret = __iommu_group_set_domain(group, new_domain);
 	if (ret)
-		goto err_release;
+		entry = old; /* Restore the old handle */
 
 	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, entry, GFP_KERNEL);
 	WARN_ON(xa_is_err(curr));
-
-	mutex_unlock(&group->mutex);
-
-	return 0;
-err_release:
-	xa_release(&group->pasid_array, IOMMU_NO_PASID);
 err_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
-- 
2.43.0

