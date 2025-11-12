Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AE3538B9
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971962; cv=fail; b=WPC5bfFdRtt1t6BJdonBimWbmVzoATO6saX7XdDbUzTNB3rw/MWPGPMAHxMtz7BOjKDIvM6/hwOWEF1Y26TVDTqTcEWK28oxHLV0qykxf0hIfhZ+vyJE9jXYXOPPrrS2JQ+fU05iQyz0u6iCuScyhxTAgjJymyjZfUKX4cWaIas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971962; c=relaxed/simple;
	bh=sPUTVAFgKr9ruNjiwu6OUS8/ThL0URLZt4P2KJ/G8Bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBShskF9sstx7pYrPhzjwnKJ9tbQhC8euCSagrMgn+rvpxEhwoRuv+4k92NDEJU5nvdzk1RMPjfXNVQ1gphcpxdamUgbcO3fz+DpKEd4xy7YZ6L4zZJSxm2tZJr3IwjTNHyO/aSdtPnQe26s61y1yRoZ51ImoebjG9/mZ97kDsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mTQfNr/A; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mTQfNr/A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4I5G83BSCXpYVP8q2/w6DNbXal2rGMsZDGOkcdLNPtsNl+nxycUk7JFFTKhvqt4qnfAwBXV2WaEK0NCbqRkrh/Lk9XNAlbrlHnaI2UB+QSexbs68DV6v8FL61kqo+Ly8KQcrTXGL2mZeU25CJA8cLUPBedFSYvaCMgj9+Iay9tiKiIA9h/CjA8HE/TmX9p4/3DkxTCnwRBzIzUbhtRsTzaeEuXSnChjtgrmPs6/RRqzA+pwYvzxJPhONT2E5X3jyqGk4/dwTjKOsmjAFagDnJl/0XFIGQzHy8s3frdvyIbVxp0BAHOfCk5JYAEjtstAnQmG38/YJMwf9eYFRpsWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOeWeR2hR7qVKAnOem52gQIB5GHJOrbbE5fs+eurI+I=;
 b=FrciCsjXE5xIis5sybABU0/PTBmXPSiMTrGPB0i+MSNiLe1NxXCigcMFbDo1avDl6IYwK2zWoYCANI4CNT1GANkMW6eTX7/CBl79yfn5nM45X2ClSwAW+8As7WmQfSqlVRi0kbKzz/bqLaT9j4K2rENv3ZChJLWAHT2q1aOeJ0m6S4Jmxx5KFy/FcbBSF0YcJOk1Kuggl+Dbm/LJi1umysl6QcRQv4S/5tSUYMZBYqY55kkQDeH03EY3f5MxUgoLkiqDP+ReScET0sD6BFIgzywpWxZ0d1Wwu9Jdb46RtYJ5PYGpVPzJnSzGjrkhPIbnIcCazwE2w3tNTIiEyQrN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOeWeR2hR7qVKAnOem52gQIB5GHJOrbbE5fs+eurI+I=;
 b=mTQfNr/A9LKOB7u2SPAJKrKpl4xNlkX3kbgUwrD92Vh/K4CyUzK4NcaQwHVG2eiwMfOga97m1cNhIXSJYIXWexnHNn8PWrkvp+hvOesOWOQjONs/XW141DMVOCwaTZnnmtotdvrr9Pzt2a5GtF09gcTZv+mYpDo+H9WON/BRr8U=
Received: from MN2PR05CA0063.namprd05.prod.outlook.com (2603:10b6:208:236::32)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.15; Wed, 12 Nov 2025 18:25:50 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::31) by MN2PR05CA0063.outlook.office365.com
 (2603:10b6:208:236::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.5 via Frontend Transport; Wed,
 12 Nov 2025 18:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:25:50 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:25:44 -0800
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 04/14] iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
Date: Wed, 12 Nov 2025 18:24:56 +0000
Message-ID: <20251112182506.7165-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cb5816-b9d5-48d7-ee1e-08de2218e80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2V2ab7HP4vSLK5gsEgvtQUE4o1M5GjchlWcU25gsFDMyDyPy5EthQ1Qa9eHB?=
 =?us-ascii?Q?MfUyKnUVGUy5IDHivX8VaPUGXPo9k3SF6dNdk10TdCaH/mNik6dzkS7wbnz/?=
 =?us-ascii?Q?mBmi/0L54NIs+ojNDH7A2MjPohNgvO/kAbISLglkiaf0j+9L6w9YFNRpwIQw?=
 =?us-ascii?Q?C58r8uQKPbt9kzze0miCyiexx4jXpGThy/JWJOyUr0VgRkHLo9HIkpZ4FpsQ?=
 =?us-ascii?Q?66bt8dQKgO2hMDUfr3ukWzT7r2epbM7PI3CpyEtRlnjh9fpH1A5sTWL3iSrx?=
 =?us-ascii?Q?1Nvj2LB49ctIPWYbt6qSv6+uWYrL4cXKmUP1AVvIThNBn907U08zTBJf6f7D?=
 =?us-ascii?Q?YZGToB71in0TKFqUEazAhQT/iJ8QAqsZWJk0/FQiHOa4wn6Wk9FhzH6EHwUr?=
 =?us-ascii?Q?k4nie8kUK4w9p8vrvFl6E1T69jG6lZPsRFixcLjH8H1wrkQKrnneWlkwu299?=
 =?us-ascii?Q?TkY9mOgNI5H8f8kQyBaAD2BdcbR6gQl41S6h0cgDLPCBdbNvpM/H88XarwVJ?=
 =?us-ascii?Q?wWupKUk9q0i9LiNiohBKDA6JghuoAhIrcEcahNhqzYvWu3vgOsrVOiWpCNmJ?=
 =?us-ascii?Q?iaqoLbM/tG9BclxmvYHQTJt/WZsfFSrij6dVg4uqYozfxEZ3IWMWM4XS+xAE?=
 =?us-ascii?Q?Y5VbiE5/eoHo7hly55fLKL6XMhjHbzPVobQvhyfGoj3K6x1AWfSpjaQAIiQe?=
 =?us-ascii?Q?QapYPzhEFHFFsPw1WLrpvHiPG85qiJxSzR9VFowpo6GoNubRZsuKOgJhPrAS?=
 =?us-ascii?Q?7aKILBa6UoBghd0EVVSgoF2H2BHDAUVFjxcF1n2jWFL8GNOrgoKicJbbLYMl?=
 =?us-ascii?Q?l+PjHSZzEHGf/onlCXejPwDnzPvviF9yB1igK4moBHCeDCJY3OZ9tzxCy8oZ?=
 =?us-ascii?Q?sKXGZUKMm0VpbrF72Xqv6aPkUTMlt/J8XS+L32/CHzi2y2SoBQ9ocxyrr+vS?=
 =?us-ascii?Q?tFPUfy8KCJYprzXd/zJKRu9mYGDvyA+jjCgd91EobbBwH/GqUvCM3m/QsRYD?=
 =?us-ascii?Q?zh946ifxOCsmiZdixKUrtvo/apEv1l/Oz6fIeSJ2QgcC7qq9eO/MwjOxyrF1?=
 =?us-ascii?Q?qG33MHizLugWHDbTxfSC0ONsjIQg1Cw9JLH6iixoSDMY6taQZ0E/wudC4L9Y?=
 =?us-ascii?Q?r3Cx5hFgZxA5nwrbzJbdNgh+uSzT9UkRVLrktyMCa9LdtGmrmtJdZqQsXqQy?=
 =?us-ascii?Q?hOaHBEUUqrOE20Jj2CtuN5ji67u3MEo8IeuwCq00Yjlx2On0eRLwG26KE8Kh?=
 =?us-ascii?Q?Sza+aTkiF5636276t1tdTdLPXcx5KMetwq1SIH9Kp11KKlkJtFR7p6GcV8tP?=
 =?us-ascii?Q?rjhVNUT7Tb9/T8OzQfcg4vGGVffoUFAyLDwyskmdEppladXRd0zX3c8/Bnth?=
 =?us-ascii?Q?m3Wg5rONPoqe8cvQ5Il92aNn3xX4Yw+v73OTuL69SQyoYFF90zWXXWTJTfCI?=
 =?us-ascii?Q?cLAyJk/A2lfP6F5QvbKaeJtGo+vKXuGD5iFGdQt/BlaNYePEiVrTWnE0mB3X?=
 =?us-ascii?Q?eNDoY1Aa9T/J79OV6EXH9SyFTTUor6FpZmweO3t5cq6BPcTnh6qjOZaL+en6?=
 =?us-ascii?Q?zFruqnI0DnVu2QNY7ME=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:25:50.0666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cb5816-b9d5-48d7-ee1e-08de2218e80f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344

This will be reused in a new nested.c file for nested translation.

Also, remove unused function parameter ptr.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  8 ++++++++
 drivers/iommu/amd/iommu.c     | 13 ++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2730fd0b55de..a6ffb1ece2f9 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -187,4 +187,12 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 
+static inline void
+amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+{
+	/* All existing DTE must have V bit set */
+	new->data128[0] = DTE_FLAG_V;
+	new->data128[1] = 0;
+}
+
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81eb27aa30e1..0be2c818504c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1976,14 +1976,6 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
-static void make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *ptr,
-			   struct dev_table_entry *new)
-{
-	/* All existing DTE must have V bit set */
-	new->data128[0] = DTE_FLAG_V;
-	new->data128[1] = 0;
-}
-
 /*
  * Note:
  * The old value for GCR3 table and GPT have been cleared from caller.
@@ -2033,7 +2025,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 	struct pt_iommu_amdv1_hw_info pt_info;
 
-	make_clear_dte(dev_data, dte, &new);
+	amd_iommu_make_clear_dte(dev_data, &new);
 
 	if (gcr3_info && gcr3_info->gcr3_tbl)
 		domid = dev_data->gcr3_info.domid;
@@ -2114,9 +2106,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
 	struct dev_table_entry new = {};
-	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	make_clear_dte(dev_data, dte, &new);
+	amd_iommu_make_clear_dte(dev_data, &new);
 	update_dte256(iommu, dev_data, &new);
 }
 
-- 
2.34.1

