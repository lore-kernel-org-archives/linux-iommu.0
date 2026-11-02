Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793598898;
	b=itPRoBgjTOys5ZRD5YBZArVsxVo3skGtjtrk61jvwtwUa6JhEEFd8DVb6ihcUrwrjuAt
	 35dIRo5CI4cRLQuPu4s9DziTDLWnWdtvJ2NrYZDAfz0WjQjm3gHFu7TaT/pOvgCOtaxn9
	 5FrdGbNC62p0fMovaJeTkLFbOmo8WHT922sMm7dcCh4UOTLiTJksUgu2oG0VL8DHS1zwX
	 cjPnD2iMszeAuDBCq4X0I+GXnhxc+IznQIdK9aOTwYNNm1TtGcPjl2/ZHI6gcbTOL7fwU
	 X80SL/YNsqbKoJJWoBM/uI9QViQfOrcXxPEq55uRfFsD3dsB+x94AavrZqOVZ1fJBNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598898;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=+xwQEzEZ5RS/Yd5PgGkuEikWFaIJUhhl9bLklZznxQ0=;
	b=lWNTqNz5THko0x0VIQph+GQ+Ngq+nKzjkI+GQEWX88WNbiXG/aSjOHKXOdSP08kMber6
	 vAYprvhRutC8YV/+0kyjLSYtTF2CSE7aHwvFgP9DEVdJy9+dxCLwScYH3d3Qevgzm5JE2
	 Y01dqGB65HozxHGh9+yLAhkAIKnyIrh71es/fOu0PRoXPmBcfHcLtsx9E9CLlU20/Vmrh
	 DyGvSiRYeKI+XQ4LfMLDP7kxp9SV+twSlEYQlo5RU2VeeUCHEfFtDi/ULWvw5pfN9tbVc
	 3N2GRyz/4xB97GHm9TgXRY2cxKV8NjhppdhmpuKxEHO35zU4ehziXdSc3l0Mhim1mfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DkFp6A1u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.12
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D6606A32C
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 05:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 456D6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DkFp6A1u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv/ITnPhG+qV+hUz0KCacigCdi3NMeJfky6o4eB9KWVdPA+uSlLdd/1NVkpAnSdK8ZDulOFPfxYF+lyvsM3tWfhJlqcYRNKKlzvkcC4fVFX/aLzxNbCBwpZdSdB3W9ioo9itRv7Fl2ax4lrNHwCSZCe4YKSDT39215KYSuRc3txwMZgvyGrklJziVhsriGNMwKEdf3uMxHJGwLKdmIxQSisNJfz9bUhv5Q4cajDccECyELsonLe9VxX2TGN9+jXxdUHI2MhSqzJ2qhNmq0MOPkFrQ8t4zaHqQwQhcireDxLoHWsrZ+NjK1BME1cHqjyZPDw569XUMwPZ7hTwWXTZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xwQEzEZ5RS/Yd5PgGkuEikWFaIJUhhl9bLklZznxQ0=;
 b=FxADOQnn+1TbNVriWgRfpQkRyhXXOaWz6ZkAbdVJNDij6y5vPWA5zftD/rZRaVsGGBfWDealsYgh/X8yK5jxxtyC7Vq8zAKfGSC1awkzVxat7alk4nBL60fa8W8I15557zzMNO8KNcuK2dmAiRsmy2qBQFXVas/ZNeXWQw5mLb//3vpb4SvGyQC2hhBAbNv+lI4up1F2+mCT57NPSEdDNTBBhDRyOaqoKzE93EY66mEBSbc3vxXFRvnxsbRug8rRby//N//wuaBzJu3yr0hGzWBVlsE/B1EH9IyR2lJRCqVpX6FsbNaFT1jyRKze1vAesdwfnfjlX/x2kmwWIVtPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xwQEzEZ5RS/Yd5PgGkuEikWFaIJUhhl9bLklZznxQ0=;
 b=DkFp6A1u5JPMKqS6fKSfVe8eNt9JYbNy8SPbYrJ0Rl+qs9dw8jbPgoaNE3OGNyfM5fT9m80v3g0brU3XF/I033VGN5FwoiLVhAMXawRGHZX+AR+d91SZ8HKWYdjG/EVQpxA/O9cxWw4Al5NWWT1emK0bZIo4nwNwDyiVOo1rpujCEkFph0MBb0w+7uNKiNAJCWNC5fAYbZ4vCLomCkgvsLV0X5LVxg0iuFfwhXg3Y1SN/npRj0RrYreapHw3OjjRT53+GQEy5UmuuJm9hME3BD5jJmfwEKvkyvbumzmPH9rSKxJu2bKnByxJyVixcDjfe4B+PWwWgYeNCuuUtQAEWw==
Received: from BN0PR04CA0041.namprd04.prod.outlook.com (2603:10b6:408:e8::16)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:54:53 +0000
Received: from BN2PEPF0000A88E.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::11) by BN0PR04CA0041.outlook.office365.com
 (2603:10b6:408:e8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 05:54:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A88E.mail.protection.outlook.com (10.167.248.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 05:54:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:54:35 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:54:35 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 21:54:34 -0800
Date: Sun, 1 Nov 2026 21:54:32 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, "Jean-Philippe
 Brucker" <jpb@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
Message-ID: <auglmP/oFZNhnja/@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
 <5751040a-e180-4d29-851d-3ccab96878a3@linux.intel.com>
 <5512edd1-3c52-4e8a-a38f-3a5f1457cdaf@intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5512edd1-3c52-4e8a-a38f-3a5f1457cdaf@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88E:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 60da8636-6273-45a2-e340-08df38a5d085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|4143699003|11063799006|5023799004|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261021130227099003|261021135927099003|261026121527099003|261026140227099003|261026130827099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	j5r+sj+5zgIYYZhktG6zE63NgklDFwKVenh05M/CmC7/sDEL1yBL5yxN3ZyA7h7HDrt452mQA+pITke0mILC0WY1PIPcE5dz0mi406SvDjhA87pektrU3qlZ5PsFpAP6EYXzxJRBm7XbfyQqVWAtsYf9XyRKxOyKwDlzaFtlCUbk2TedmZ7rLju0mP0taVXl+ZKdR4b5aK13lHikFag4sUQv0y4giuzOWZ2bN/NyQpDz9Y5s6+TyEpxo0EhyhaJUvIj2aMHz9LbY5RKRKkGA3qHt2UAjvgkXpnDyKCsi2IDe/lu+wBSF3ar9WJtZ17yy9uF6+5DDwpIFUxmYyGIR+BSJoEyZIeYm1Ag/bbejqXQ5LAVaQp5+LpZrJBEkwCw43Jhe0k3xpBktx7YlFTI72H/4FukmMDLyVqune1qY+Qsx7/kvgS69g5iNwvBSWZ2PMuTeURxlUYURK1OCXOdaLD4tHa3AvU0IthAHz1fCrTIg2xLqYgNufZ43zImcLeyYL+tsceJoWmYiSYUFTNWJ0/AvrxkVbRQwqbOkZKFCj49u1NetmH2CWXVqnvTz7GBpQUa/E4ZIvSpOgKCfpCwtxKOFeJBARWqPbU02/8gIm9ktGKuX+oUwx7BZ7XuPt+3MnUQwZfW01a3wxyhRcVFXgfyS86QYFUomfpRMnHc+EpDpohN82DZfLDPCWDcDWxZFwrdo8yKd4ugH3IIVPqI5SA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(4143699003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021130227099003)(261021135927099003)(261026121527099003)(261026140227099003)(261026130827099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ohth/46KQAy3FpwxUp8/ZG0G9UEHHut1FXY65k91fVv2XNXUfmmU2+tDY2E6mD8BUHYJKk6HZD6HT4sHMcbpVwH6PjAhB0kLtzNZPeNyYksVAzWt/SS5swIgzWAuXSMGq4rk9pPmyHcAzXSwCcF8CkONcDatkF4Sr6mUxTaoPxZVvD4z6I0sud87BuZkBaVflsohCmGY4xkpHaFc+HXGDpsprHkUNe30Gm//E81E92QFe9/QdvP1MyZbev4v4SCiMeMRCMWu/7wrbO9RCdni05B25i/f0NOURCc26nGX141F+cb76r7Woo/PlDTZqmcTSBqPhL3ZIBbPTVT8GH6C+yDF3laut18/qncE9voRWHBVJ/E1r28rAgK51m03Ttwignr6vgCC5DOOS9dEMzusgaDx65YZ2hhCBHimzxQAorqvEy97O7K+78INWUCZyucL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:54:52.7455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60da8636-6273-45a2-e340-08df38a5d085
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A88E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

On Mon, Nov 02, 2026 at 11:30:02AM +0800, Yi Liu wrote:
> On 11/1/26 13:53, Baolu Lu wrote:
> > This doesn't fix the same-domain replace issue, which can still result
> > in a use-after-free bug. I agree that this needs a separate lifetime
> > mechanism as stated in the cover letter. But is it possible to prevent
> > the same-domain replace case from going through this interface?
> 
> fwiw, iommufd already guards this at the device-replace layer
> (iommufd_device_do_replace() short-circuits when hwpt == old_hwpt) [1],
> so IOMMUFD callers can't currently trigger this. But that's a caller-side
> convention, not something
> iommu_replace_group_handle()/iommu_replace_device_pasid() enforce themselves
> - so it's still
> reachable if a future/other caller doesn't do the same check. Worth
> deciding whether to push the guard down into the core API, or document
> it as a caller contract.

I can add a fifth patch. Please see if it looks good to you.

Subject: [PATCH] iommu: Reject a same-domain replace in the attach handle APIs

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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3fea48d3538ad..a9bc4ca5dbb4e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3716,6 +3716,10 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
  * Caller should always provide a new handle to avoid race with the paths
  * that have lockless reference to handle if it intends to pass a valid handle.
  *
+ * The @domain must not be the domain currently attached to the @pasid. Such a
+ * same-domain replace would skip the driver callback flushing pending faults.
+ * Then, those faults could use the old handle after the caller frees it.
+ *
  * Return 0 on success, or an error.
  */
 int iommu_replace_device_pasid(struct iommu_domain *domain,
@@ -3785,15 +3789,17 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
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
@@ -3985,6 +3991,10 @@ EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
  *
  * Caller should always provide a new handle to avoid race with the paths
  * that have lockless reference to handle.
+ *
+ * The @new_domain must not be the domain currently attached to the group. Such
+ * a same-domain replace would skip the driver callback flushing pending faults.
+ * Then, those faults could use the old handle after the caller frees it.
  */
 int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
@@ -3997,6 +4007,16 @@ int iommu_replace_group_handle(struct iommu_group *group,
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
+	/*
+	 * A same-domain replace would skip the driver callback flushing pending
+	 * faults. Then, those faults could use the old handle after the caller
+	 * frees it.
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

Thanks
Nicolin
