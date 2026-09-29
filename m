Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EED547056
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718805; cv=fail; b=KrXM/QSP/Rf4KB9ds8E6ctUFHP2+bx2SpuAGwU0UxSQfqsWUZTl9ne3XDNIRUqkRSagDhgDFxvRxW7g711wWzkpB6T92QQZlWkf2Q+pWJuOVU/2Xtsk/DlpS50A5G0QM9UCTFkTt0Qp/knmY0nd89m3wSTaWASAJPADcjc2KpLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718805; c=relaxed/simple;
	bh=2PmkK21/0WpUbozhFjBozCPOmSOEkC7MteDrfE5Mz4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2T7H3nyjbpg+Br77J5LSyC4RRvdvunDMv44X/09YZ0AOLTBIXDRp4jjhKFM+bsmCUDRFyST6wkDTsyjk1tvqn66adb43n7y8cNfctb+s9IcsAA6NdqNV+yZhgplX0JdcueVzUEIMkydsTBzNv6ridZmjdHelh4e2HCYY7CP6BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gt0FzfY+; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gt0FzfY+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdQ3nGTW43Di5e8fETArJU3+FF+2X3aTc2PWrWxwjluCE2Tpa4UA421yEWs5w0/r10TlvC45Jlo34uKHSsJxZlpb+Ip0G7uahXbjoKYhD+NjwclXvSXcOoyk48Jl1N68tlh86DHgxyFzg1jX6QKr5nhwFlDHz36KtMmHCKVMWRUxhGGxHQCvUYnQj+0GCwT7JGeB/mGKMt2yLucwOTKOF+CcuUxVpWE+kDmr0otYnJ8jYdEYOeGB7uAYPP+R+cZ7xs3dsEvxTDZCCX9T/7YiCQJAzOSjvADLb5C/45zVzLBGGdYu+Gbd0doLM+Zqqd0lWeeE1sptnSt+BBTrsuqBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSx6jgZUNtzwHVNOql0k2ZKuc5P26wgFSzbYukbQoiA=;
 b=Db0n7aYG4eJbryMvsCuXmccAPIomyvF8puL/hk6fMe6tLj274mXxg82ZVwiREb1DeWXlRHwz6IN0Ah0DeQCfix5jQCZHx9e80lKKFwvMBOIetPZPnDBjG2u0A+L2hEUlQNpccRX9fHshP1v3zfJ8tnKHYhntGMK1e6dBye/+Y3hleNWRDPk+9E2A26L3P5wMSL6bdgWzbIa94neJwTHLmGE8qnDQhecsTDEeR7SjXgqkS0XaFORhYh+WYtXCxku+BMmwVDDVfQHhTnchp/psu+FSB9Ctru9eTr3lHE+QbBZpTH2+JvYKxNXgWchuWAC7Yja16e+Guqy6o63XX/JSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSx6jgZUNtzwHVNOql0k2ZKuc5P26wgFSzbYukbQoiA=;
 b=Gt0FzfY+R0CpKiWUI+KEQoV72e4pSpsTpjxsOiU3IgK8Rp5Xd2m6z+J0qtMFUmLT/IzdjUYyqY6oTac6W2OXJ1u3+dcTEz+X++LS/1YFtVxPdhAdVSf8AFoED6tFpVYkanrCVRhoDLZm5dWAE5nMFuXqop97Zc0U+kVrp0Jfrh+3VUAUK2NgkvwXZVePdl50hcdakivU6fBMNXo6FATVeewcVgRO9sRPUgZFlVOhJIv4K5uxi6RfvifUd1ActwNmxpD9eR5mJhHbSa0Uvlrg8S5If5xhet7eT9QsDDHgLyn2a7GDrrvwztxb3ZBHCwGXSR4xBNttOvI/wCRygf4fZw==
Received: from BN9PR03CA0268.namprd03.prod.outlook.com (2603:10b6:408:ff::33)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 21:52:37 +0000
Received: from BN3PEPF00022BC3.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::8c) by BN9PR03CA0268.outlook.office365.com
 (2603:10b6:408:ff::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Tue,
 29 Sep 2026 21:52:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF00022BC3.mail.protection.outlook.com (10.167.248.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 21:52:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 14:52:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 29 Sep 2026 14:52:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 14:52:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu
	<yi.l.liu@intel.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/4] iommu: Unpublish the old attach handle before the PASID replace callback
Date: Tue, 29 Sep 2026 14:51:54 -0700
Message-ID: <af5be72574fff8c81c2c199886fc67b688ccc3ba.1790718296.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790718296.git.nicolinc@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC3:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c0fd3b-cf2c-4470-f3a7-08df1e73f9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Vm9G8mFn9QPyo9GxfnNS1gNoqHqt/f5sZpYoq8eMfV8crkmyU20q2P0wtVpiNpbCZ2h1zjIE95N8U9e7UFCWLF1pZ5Xs7zqb3dy01g/ga2rbk/4ixhOpOb0OoMR5eKM5zZlHUpbZdlUYT21tHobIDHuomIT1KRKdLtNQ60HjIe8uJFYPUaf5KjBG4E3tV7LkNezz7E3InZH3Itcv4FAh7wed9QzduHN05RmyNd9BxLDoWKwmWoKUXMONCCdTqZPEQpZCh+ufNEZjWbklkgxWRy/xFXkHETdwM+QZlvsKaFp8VJdnk4P5Qtup8BlpJkC1tzu04fSONm53N8FeSGIZBDnB6RrS4kgvKfGiT90gBR0QB5owWGyjXN0vLVWyaENIoxtR50fFqgtmvrhyaDmLge1VfD5aQuQx7qtnqgQjKbcXv5JWGnpjWQdmmmIrcTpwcjOmX3MWScikXgeI5orK1zvtg2d5WnSchtbIc9FqEbnEbTmmiIpyKIIIrHLvOZlpmMmHLp6VtBGp88wxTXjsWTL6l9FnRGY6mDyJSY15ZAv5Rx+XUT07n2PmwUW7JtTjp3FILhVPwSl40cujZhzoYAtmUpE41lrFsUwWgJeq9tpWsfBsJQaNiFOTB7NjZCb9zDS7F5Q9hAHrk/VNtE9FOPazfdRa/XTmnTxzAorTZKG1bnlcT3kNnuTAXmO2wV8LSv00cjLIHm3ZCX9KuaVcRQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H1dbrrXm1gW7ss8f4gNjWWLzYOKCMYRXY651XTVndQgJeHUnQoXDtWrrNNq+k3rTRESUCvdmmKopqxhVLIshIFKrt12qCsb+Oz7V7Fd7jH6hIDCx43YJOeDX//yoy/FBVYt4AoCdEScK2kvVdiMk2XTkJ0SxSdz/TkA1G8Qlo2svFvUmgx8cEq/2XjxvxXbjrxQP8AmFLDSAx0p1PVvKDmhCfYs92v9I/kYgPUAQo6TO7C8+xauqnv7V5/b41fnS+fTgIwDFVSy0RA47rlKipi8Pv+3iOlQaNvrMZKs44nzZ6n3+I95lJHuEzShmNQUOouKpbqD/HjPvOUkOxmrMZb7kwIBeo59ut2RGdDvnz//i/Rrrr2Wr/kuwrAcezaKROlf64xJb3hqL8SxGsl32zttzZzdVoX9jjyKk1PPKv/0AfbOxHfTQ4CG1HIPLTzz6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 21:52:36.8211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c0fd3b-cf2c-4470-f3a7-08df1e73f9bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008

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
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 52e59f38cec18..2ff81e94a7b7b 100644
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

