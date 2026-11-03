Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729264;
	b=UEvVvoZxKeajJ0xTraseEfLDGRimE+pzJNe6WcMnRff5H8uLWataJAxOGEqW4p8c/O0x
	 f5FoSjFAcHAbeFkj4vTnfOe+ef6NWL1/aBpyCaGtDLyadcCfenFG05Uq26JWBWGfv4Gzj
	 0sxkRaqt1DYcPb3/I5iewv6BBj2oNaiat29uT26IV+oO+4P60tzZeYD8PXXcxNOoWMZok
	 TgpUkGxyFjFzb29nise0ISweNGZ1yDiL21yE0a6o9pIeoeHEWCEsXGTjPDXbL9SaDPl56
	 gHYCpaGskVULGXUfoLPxKBO3ABkiQA0QoWcpWo9H39ProrIgIYhfr/dmdLSCSKF+Ysw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729264;
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
	b=KGNOVd9TMaadMiWbH7k8f+0AymwaJzCXA/z7fe4u+4RmDZoxvspDf6054Q2AaTM2Vj97
	 iC6hP2107puYMs9HVG3//Fm2GNYfhv+JDVrGsb9WDa6y8fUleiCjz0GLlwFDWhS85ZgC2
	 k6TwitfQX4JXfJGzrpyCh/hd7MV/gtjruqNO8LDC0syZydyyg2nzQEumDFxmJNBosfy0m
	 0sAhRWJt13ZKesMvyFo482HdCtrCeotIC7FsZV2l1COB3mK3pOvVApiwQUSeI8iJApbgS
	 IZwV3ZZF8mz/2N7xdbusYrdzj7h5NaWax6PW1wwR55FuvDwcpMch88dzhH4psHhAEqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MOJ+hM3p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.71
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E59606A32F
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 18:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E59606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MOJ+hM3p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MC9xB8yQ5xtFCIiHciRpzkMliF33U1aLstH/42J+pyfnnj9ahtzM9IgW5zU6nTu7TheAqRrTQEgPhC3DWn/bPWCo+pWM5v/n6wliCR5tV1P6i54OxxNhatRPQy2T0qI6FgmKElB4l58crUQZMGjGpV1h4C1syXBVR0SXtxRaoHsjHkUTuwBxd3v0iGtEvaMO6AxtwWSwbni0rtv+e4gj/dQo4SkTW7OCgYrwBMRgDAQhR+Bw1yz/jM62xEZhY17lIU494Tcl1YKNacmsXAD48ePCkeLr9lD7StlTCsrjS/ga3kO5W1BAhNTtZcdKdzpJotJdLIMDv3AWaeDWbLgcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIH6uqdcxc56npraT4vZKiBi4Fr15Cmw4x0ME3mTqLA=;
 b=L0ss0DcPxDpOazQ06Bs310/8zge9kHbeNUpRIVBWfWJGwp650DDPbhjvlR00c410JG8IggDQq4M2Xbu5J661+O/KzTf7RgDLPgYGkjYyqgP7lK/yhXM9ConN0BXVfNyyRtoBk5oVbYojJBOmti/R0fbQGncFKWQpwquZAWbuJbnotpm2iqpcaRc0wj18VouqNJqHThpr9xyHuXdLyJhFrbwB1tfDvajt5EHlN5syOY16MhrMkC37UrGLAhH7U5ynTFsr+qOZC+ax2k/6CD/Ls1mpKeLINhwH4kLO52MvXIPmT5HpL2gChlbPgr3xssi/0m3g7/1dnz+/qZNcsy20eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIH6uqdcxc56npraT4vZKiBi4Fr15Cmw4x0ME3mTqLA=;
 b=MOJ+hM3pW7zEppOnO7ZAkOV/991GPmJk2R5eACLcZqO2RhxiLgOAdJzBnUU+ResMY88yds0S5Eh+RmsDguT50Xo9nwXc6D6np44buAWZAMSU3a9eC8Z6IKDRlN4KBll5I/ZbH2ALZaBUCINs5YGK/LSbXSws62j8exVb7aOajRHY3HnVSKIfJt0QUCuDuT5Rarsi1PQzZSmkUglzz0oAaPNdfz7OMc5dCfHn8mdMLq6dO8oWEcbcjYy8xlH+I7DXY8EEmFTZDYWzp88ekSufyY4Od+CaS9j7JAsjL1nIjrPz/ebe3ewN+qEbJl/TlWIsZhVjjhTqMbXzeyIVfqIg3A==
Received: from CYXPR03CA0048.namprd03.prod.outlook.com (2603:10b6:930:d2::6)
 by DSVPR12MB073533.namprd12.prod.outlook.com (2603:10b6:8:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 18:07:39 +0000
Received: from PH3PEPF0005961A.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::a) by CYXPR03CA0048.outlook.office365.com
 (2603:10b6:930:d2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:07:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF0005961A.mail.protection.outlook.com (10.167.243.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:07:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:07:13 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:07:13 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:07:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/5] iommu: Unpublish the old attach handle before the group replace callback
Date: Tue, 3 Nov 2026 10:07:02 -0800
Message-ID: <824fede620da3d8661d4e1b85e6e9911a13ee13a.1793729087.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961A:EE_|DSVPR12MB073533:EE_
X-MS-Office365-Filtering-Correlation-Id: 790de6cb-05ce-455b-26fa-08df39d55892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|261022075727099003|261021123027099003|11063799006|261009223027099003|261028144727099003|261022105027099003|261021135927099003|261102123227099003|261021121427099003|261026121527099003|56012099006|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gQfHig0wL3Al+jJyXfs2QmrNb6QOQwxw8D/hdidsdVowl5FgXzTFmUaFXYq7D1oiinej9auxt1d1341n5nlhPq97MYd4R1tLJIz6aJlNgvvRLgVOV0jwZJ8Bdf1UcqH3YcD8WnmCs5zhvGk7xzXyS4Fq3FQYiCEva75qetMxDcq4qrdPbJqeNSLJmuoMMbkxZSAZSrdrjvcJC2zYg+0zl+cZOsiWZDdNZu5YVmMCtQdpVteKh+Ui6sjZiSsyBbXXnqmTfiXMRMi989Z1E/CR63wXDuw8w0IXsmK9K6lvzezF5rj3tzned0C1lKZbeRhrqf6VTECxMT3RDfeZ/uBsu50OcD3gikqYdAy9wSR0IMqbGPTesqG4EDqS327WwCU8t9vG/NMZ7cKan4v1E0gIG11q3SWRQVwG3ERskeXgctph8oY//YUWrUC8Hj5GMRt4j/J6kPZz9O5FYrHD2RpwXgn/3jvh19Jfk17whFqOgMu1183pvSUZe/l3RrIs3Vvfaf4ywV0TOPt8Iv6mjkoUysz+xTK56ndxMEpTin50spOoAmov4hfjBHGbAZW3GLedLdADtnVtVU3HMXZWFeXD5tvljyr67yVPssTJ4CUOnJsFkZTQMVyh1NFAS3Vt/4lHG7aCOU7fAGdI43yw5TdeSLlqWc6Rc2s3IhSacnhzklrQZUSAP62BxwiO994hWSTehsPvTQMImHXhHMZM1chdYg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(261022075727099003)(261021123027099003)(11063799006)(261009223027099003)(261028144727099003)(261022105027099003)(261021135927099003)(261102123227099003)(261021121427099003)(261026121527099003)(56012099006)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	icBksBopyv15MSosjxCG+GcTyZityuYmdoy3AsmPMTQ68XPMFXZJbOZBZ6oE/RTv6dT+WvhJMZQ0hausZnvGDsAdZ/MvSDUO5ZlFHiirLKCYqtNop223tmlPoCAWUYjNbsr7QknCLRKHeODjU1l7OzckNBncAXqLvqucIXgEVX5SCBeix/2t6RFJmTBKT/mUU9doaNzowFGOxVn8jLHG35LkRZ6FjeT+nh6LK/wBHf9OLrpk44BeLIiRb5A05QBTMNYIXJdo1Q7D+/qIloZgdMWaj8j4lBan/H35JVdQ5Voh/th8/qZ8c9dAtrv1+Palwsy1v+CFLa6DDBjGwNlEdZ+M9t4aYrqR4yLqVtY7Why4X8AJ7rR5uLuiSM62fBjmo48ceTyTGkHTcO/Z2yXX90yCz2MUdUg0/qAwRc36H8VfspAXn4Xaip2jC86uev55
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:07:38.5811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790de6cb-05ce-455b-26fa-08df39d55892
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF0005961A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB073533

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

