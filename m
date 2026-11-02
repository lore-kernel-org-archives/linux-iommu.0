Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793603139;
	b=4rEhfkr8t0YkHe+vk0ePRwnWSc50FPNfil5wvCm3DU1oCyT1MWuhUsGwJyXGAyVZTVkq
	 H6nI2Q3kLL0BgbYkf8mfaPBhSBRZWijC4u4d9CESl0i3HpWGXsfwEPX0TocMp3dNzRlW7
	 eQFjntXteiCJabGditS6dnLtmE2Hj/Gp2+gFZNP9FIlQfyC90rTiZZoXQddCgdlldJmE+
	 3y6I2vOG1MWosoVXbDo/UX3u+S3sDqy+Jc01nXBVzLzhLV7JiZhoxS8eqvDtJJ0Y4ACzm
	 zd+RSyZPBDJzJaz/r3zHnJlIhlLu0WLfZb3eR7PwNO2d9TeMzyufD1Rpw3wcbMjnsQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603139;
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
	bh=hVx0/7/aRV2wWgxne9iyKihDqTCLobnDw5FCxIHHqbI=;
	b=HSYE/UlCG5eNk9FjBArHMCVNKgk0SHxdjFe2t3I1+SC+WYy05tD6Gwz+vu3jIEDK1Rzs
	 zUu/TgWucY2pdsEiUpLbPpY5296j5d+cc9tlR2b+7FkmEkOSg+F78loBZ4CjqQn8NhIAv
	 fd65PvrVT7L0WltY5YlnwiorxzQCnZNkCAP618yuhUSFwQnrUWMjmY1c1jDgUFQiEA2BA
	 RK+vsrwbIkKqOpGToUin4lzRA7+aCqEtf+sOpRgY8PZtZdPXZRE5HiFxGpfcaMJy2HXl5
	 3md9Ted+DVtgb5HVT86N3nnc+OpdjFYC6kh5EbWhvRUzCyX0WE+b+KuD4QY/yT1Bnzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gyoBuqsK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.30
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D160A2604
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 07:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB8D160A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gyoBuqsK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tj0hPLeCJv2ZXEosgqgDy5/Jq3NxiSBJA4nyjNakiU5zzGhNGcCzjqCG9Riwiwaj+BwrPBZeEZvBFIo4IqCmTXK/PNkQyJIFyWC4sFgnOMCcs7vwavAX+3X8H3nNq2qwGSs95q6Um2Ogb2CwUwLW31lTBZ7g7zoCxa6o3ifbFv8vyRVcqfQ3zt2Idz0sHHviFq/K3KSUZtm4F4GeHNaGRRexPVtRUSvBtxaOKwZtWKykFJ8kHeSYusG0hZpzu0QAoNZ4rIq4hzjf/mVs62RHDYGL0wUKwOYsKRDW6FMNjg/esmDo0xY++diBDriRzJB14Xnii1vyTCGDPbiMCdsKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVx0/7/aRV2wWgxne9iyKihDqTCLobnDw5FCxIHHqbI=;
 b=kT+0HSw2vGdqiEX3kgNhy1vuMvnbLc8X7ag6O9Ycq2DvkW5KFtp36WK+jvSEmShSRzyvyYqjhnDDdlJQHFK1AuGmTMdKw0XQkgyviuYK+AKX9WYZc+L0YOonIy/JCSAHvITRcHbzJfoQJavTNbXRwAHWIj4XQiqmUqaEVm6O+N2u05LE/kzvvuOKxAt5ks/2YBUutNG6Dlany/daEwqPL020/GpDtdfQDP2QcJdaKetwYLyhyh59MT0U7dfHvvAZrv/YjXViq6eOOPXEilezI9628A9aaUshzn5sLBwqRffWYl66h2sA/9VmdlWo1PWISS4kf5VWdM6/46zK0UvnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVx0/7/aRV2wWgxne9iyKihDqTCLobnDw5FCxIHHqbI=;
 b=gyoBuqsK1hJ9cRBlb8x/Tl4LtUSsMU462i/X5XeAiZRgNQ38M3GplNZBorx4h95oznm1EEJ2NB8j/Bf+4lCQFTU/sZVajlIZya+x7R0bmwyKVUT5TvOo9jCHuFWTcqjNafKy+AsbTZQEY4cWjiwnpptsnZbDwBW22NbV/mNRWx6CziEV9gLQgJB8D3G/J8A7k8l4GjVvnV/xDyuJK/VLhCJVGtbu+j7TjlXmo8Q6qpRM1Tg1lPojPEmi9WXe+ftcqAIFBOCckHRSjAhvqGzLT4roNmpb8wgtf5wgdiTRfIoeQuFpty4thPf4Tzf6eFNg8xS22rN2kM9HOyjlWNu5hQ==
Received: from BY3PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:39a::23)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:05:34 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8e) by BY3PR03CA0018.outlook.office365.com
 (2603:10b6:a03:39a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 07:05:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 07:05:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 23:05:15 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 23:05:15 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 23:05:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] iommu: Unpublish the old attach handle before the PASID replace callback
Date: Sun, 1 Nov 2026 23:04:38 -0800
Message-ID: <33748eda55ccd91c32729d5d212b389742a6b1ec.1793602084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0bfdc7-fed2-4f1e-fc25-08df38afb033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6z4fDTgCAF3kAyheQKzniqmGzPffKaJYzPjtTN4dybEtVss6IJWk8EyN3DhPK1AtxUA3UH3SGPau4JqP7CsVBUNrf9XOgdN++moNHGZG0VzPwi9cHZrKumeG6A4nk/qlDew2b1ckZzfQk5drXztlI4nfWlvFPmFeAo4Oo6HBeNg0/e7weZljeVUlv8D1ugCs5CAqEALcwcMJxO+vIExdnl4VCCEASAGKF7Q06MBp8tskpeBqKO2ak+UanoTWxcXuWox7UcgAsIg444sSc/KYVeowXPhQfI1qpF0hxWXckiDpUHS90hhP6cP9RYktOOmZMEkqH0lOC9i/A0Jqo66JPCuFT9CLaluaYOo3UoVLcfr2oNW14PoRWtxYRsRb008hD/HMgWziWWoMisOpwNw0OCu36amC6lZibfVSJK5GQaJoHddTlCCoQ3+Vm/8cbGnECFdjlP3OQ1A1oS0ze032znUJqchNMGZz5/xT6tNr69JtsaJzb0RvswaQUMofBYYINJd94tYJk5YxKqWYGGLfsp/lKhMJAwreS9o3U16QCKeLTCf12EzUoYwk7SUNnJwXEmoVuC5DJCajwxiqtg5jFcuIkiLuGemkJI0hSgUd7jpp6K79JFe/X/8oUjukLjbfgFc3c/OkP+1NirnBci9BWutVBpRv6Jc6/rX+DhWJXXQgP7QRpVtteAC3+FE7xKO/nQQXkkAY3j2VZnbpph+r3Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZOXUpXzi0wkBqUpaaM+sMdOeB/3TOTKAhylWPcZczH95Iok4E7k9juTULYmp1o/jJFVJ641SwGzBQ1rPK/IpNULt3DRQrXU6MyNvmw5NmQyaHVQ4aX9cGrJs8rok9sybt3i2+OYwDhEBWZNGI5lbQzind5yLShHv6/VS3ZsO9qm2+eYqU6zidpnIkwk8jgOtQmPf6K0fdCPOPiR9QC/vbcspMPOn5P2kjHo4c1ufR2NwLCb4LRl+AQy99CDlvPSsZ/LXLFXm7B4EPS8VFIgbG7ScjuCkxSfc8pOs9j209eJyc1VAPuFMXyjugHAU+mTntscguRVU0rdp5OsI8kNTQ1PWrE3bmISfm2DqpYuq6EF9RCFIEFB6Xwi22utfRU7aXByVTCZI+dEbbDwzIFkAfvvM00Z47wt/9tkNHbbf7w5podp45JtK2tolVZJDrp2J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:05:33.5458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0bfdc7-fed2-4f1e-fc25-08df38afb033
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479

Similar to iommu_replace_group_handle(), iommu_replace_device_pasid() has
the same inert reserve as the group path and the UAF window:

  core, holding group->mutex          fault path, no group->mutex
  ==========================          ===========================

  xa_cmpxchg()                    ,-- old handle stays published
    no-op, the slot is occupied   |
  __iommu_set_group_pasid()       |
    driver attach/detach ops      |
        iopf_queue_flush_dev()    |
                                  |   iommu_attach_handle_get()
                                  |     reads old_handle
  xa_store(new entry)             `-- window closes
  mutex_unlock()
  kfree(old_handle)  [caller]
                                  UAF: old_handle->domain->iopf_handler()

Store XA_ZERO_ENTRY outright, just as the group path now does.

Fixes: 8a9e1e773f60 ("iommu: Introduce a replace API for device pasid")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0a199c1c3141e..3fea48d3538ad 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3751,8 +3751,13 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 	}
 
 	entry = iommu_make_pasid_array_entry(domain, handle);
-	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
-			  XA_ZERO_ENTRY, GFP_KERNEL);
+	/*
+	 * iommu_attach_handle_get() runs without the group mutex, so unpublish
+	 * the old handle before the driver callback: a fault must not resolve
+	 * to either domain while the switch is in progress. This reserves the
+	 * slot too, so the store below cannot fail.
+	 */
+	curr = xa_store(&group->pasid_array, pasid, XA_ZERO_ENTRY, GFP_KERNEL);
 	if (xa_is_err(curr)) {
 		ret = xa_err(curr);
 		goto out_unlock;
@@ -3776,7 +3781,7 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 	if (curr == entry) {
 		WARN_ON(1);
 		ret = -EINVAL;
-		goto out_unlock;
+		goto out_store;
 	}
 
 	curr_domain = pasid_array_entry_to_domain(curr);
@@ -3786,16 +3791,16 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 		ret = __iommu_set_group_pasid(domain, group,
 					      pasid, curr_domain);
 		if (ret)
-			goto out_unlock;
+			entry = curr; /* restore the old handle */
 	}
 
+out_store:
 	/*
-	 * The above xa_cmpxchg() reserved the memory, and the
-	 * group->mutex is held, this cannot fail.
+	 * The xa_store() above reserved the memory, and the group->mutex
+	 * is held, this cannot fail.
 	 */
 	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
 				   pasid, entry, GFP_KERNEL)));
-
 out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
-- 
2.43.0

