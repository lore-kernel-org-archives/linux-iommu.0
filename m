Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDB4CE677
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718766; cv=fail; b=ZQesaBw3IUrnDvZNzAeqP9nPgT3csAc+iL6M13HK+zoD87+5PKSl/QHlaRfEhCSxESM+HHTQvsLSyHRSAJIddrZDtUhBI5ZsZk+OqienEJWpiNaIvC4nw2zH6t7OCBlo384aJKl26Qxl3HvF4G0sq6alUceycPPW2qGxLRRZOe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718766; c=relaxed/simple;
	bh=rsS70DdznsnVico/b+nZaS5sTRPIgePjTveA7BQo30A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmHlsL56e3dNIOALqDs/3PlGlM6FY0tq9iAXlodidpnkStMDtdDCKgNa4sB/1kMQS1/Hy65mzHCvefDkGKa6Ye3r1uK3eaSiKp/3Oxv2UZ9KERpN5SKi34XRtRJG0Ze/EMqtM5WJ6JApGHzEDN3/8JyrLvOB+eQl8h9YYtCmjCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gt+JL5w9; arc=fail smtp.client-ip=40.93.194.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gt+JL5w9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjMYHoSL67Nfr5EJdtR2xOB/amV0P15DdbsubwvHHr5YfXjmD0nTQ6PVHulvFjoNqGDHeWhNWE0dgkzMS1Auld8PHDFDqW2iD/9iKcYVXJFtPjik5TN0jQtQ74g+HLteuSTJ7RY5elHAqdOOsOymkbAS0EcligHlD1IJWKE09Noer1KtTaA94qZyI85oU4s/7AUI61repuov4QJCP00NZJ6RduuYeOeskz8gLBpmxGnJB7Rw1v3LI2NpWPzIQhQNrz1p5anZjXHVQly3hsk1mS9c5bJjX3YK59NJ+x3UsIR8V7jochIR7hRThx/G41sThJxCSDO2MBS0OkU5G2vs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGIU2iDXevSS2acSjel9H87lTLyDOppIDNja22CsQns=;
 b=OCt0qyhZE3uv9t44F5uz89eL3dDfxsZMOv4bkrmL4Y80yr+mHkG5GeEe9od3aER/5h/RcfgnQIzifsqPv6Tc80hAIBStvzTRAZxQT0aZRYETaetOjMfIx9uVTEQR02lliS8uHOi5bIquyKlM+K8VWlJAZ7iUU0lqnxcMh5dcuFXEcRLdRBt50K3L+Ooc8iZhH7TVnpWD36RVso0C53Gc5T1lhLadtShX0ZTPt5kZ3ydG4fyQcXDTR7ZQjXuMI5LCXQ6gUvg+CDufwvpe6i0+YLmiNT4otnTW3KZB0ozlWnmPj6ocgxUDQ/yk+sp53+eRERumVYCed1IdAdAfNlwfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGIU2iDXevSS2acSjel9H87lTLyDOppIDNja22CsQns=;
 b=gt+JL5w9HNXiP9BdMRt07lxduohxASMXz4ELYYgINHcRK5GrXkNhiLRh9pBmdymQsgH2argBAv+o3qdfGZRs5s8r57tKivJUUTjq5ybhQ8IjzanQZvZRYaoRTVDthJHN7NOq5dP06OWaYjIi6vOW7QFtrU0iGZYDjxch06PCZyGBejZnpu4NDPOEv/CiloC9acCchJwi2lESJVXOp4u8tYjgI9/jul6zPh6H27W0q6PPlsPSm0BUET711aHUez4iN3a8MCoyHUxGR6Uoa94Ca77UjRnp5aDs9k5kf763oaUy8SeARxesmHrDsYAlm8kgEGtBtMJ+EENNtVVvHGiA3w==
Received: from SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::30)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.22; Tue, 29 Sep 2026 21:52:35 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::4c) by SA1P222CA0028.outlook.office365.com
 (2603:10b6:806:22c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 21:52:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 21:52:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 14:52:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 29 Sep 2026 14:52:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 14:52:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu
	<yi.l.liu@intel.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the group replace callback
Date: Tue, 29 Sep 2026 14:51:53 -0700
Message-ID: <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7d5c7a-9b75-4597-4eb5-08df1e73f88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	N041BGtQzIMLWmdhkCVNxePWeZjhAeEpEZ8QEhcn1qRGM2DPF4tEbvXw9GK1TkGP9P55V2/YEJnmmnifbDZkFADt7yG+4JagoPxf9wCwmrnbwr2rYv7s9EAw4tHLqMp6OM3T13d4TRNoCTsHJoWPOzmkFuyMN4WqpkJfol2cltG1nCE7sNudUWs+udpueIdZhXmLOzFzfE6a7/NDNmaUakQAfJCGFzUb67pVY+vFgkXD/T+PHLrQJjqHrkenCIUQ6n1uCiUfE+s57ddO8fiJVX6+cFPOS+RUNkA/gH75OLTWgNtpv0fGmrxrFdZuLwcoDj0amv0niMxxupBFphCfJY76cMmSOXdweSP2PrToaBD8NvOHmLzr/FnAP3k+gcm1sRGK91lZ7wyNfYVET0R7HjQw2AbNzs+rNZ5+PFDelSx/0Fk1Ks7/fIUFvvdtOF3hzb/2outvDK0aLAnCnlxbFV/zEVqN9kM8M1Rfx5ZP//g1YLL3kJY1w1QtGbVoxxd5Kg8JEXs1vvURuNg+85nvHjvmUgPjx093cYsGbJkcFe8a4HQ+WDD5DIGPQSv5xOirHX2YbUC7L/VJuOvyuEM/clElO92muuAX+0683968rZhetZYptDIvo0pGqK3f0MZMPHA7/Wp4oBbVrgyt8wbvzsuSdG3ESCzlKtVvLpAzHnovuJCyl4DNKA3yWQQh5JRNtChTPwCZACq6di8AYPu9vw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w7aWwsBot9HVhkaBtEzkEQn4xvU5Mm4wXoYFIStJJzq2YJVk0UTz8uCbcR2bkjmrBCS+ut+nbxy2flGNyDIQqnZfwYTdhQ4FVe6nV36yDINHQB2YkREiNb4McHIxQhQ/yWYgIMmayea2scP3ajfvCaSFSWtwKxSt+0HK06H6f/rwQDR3p/te39eKI6gmuqLyqmFLKnFTmA5XQW42TwfXrYeWqURO8zNKWDTU2CWVb+Iq2kjJe0FNCxPwa6AjE+dlhlS/LOmbeSqoDVn7NL1NGSjxMRgn1aSHIOgAJIZcNonjmXqR0EIo79QapcGRhrFBBXOf5ZDGq3RVuRMawQUo8OMgCCZca4XaMd2fFgeLSx6AQS4GVGvUd1E7dhSYzDB5G0UbhAX3oq7Fy3nvNHkvq70eD1AUqKsJQLqTxiruvoZsNES+Xgujv61Vxti+PPKu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 21:52:34.8833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7d5c7a-9b75-4597-4eb5-08df1e73f88e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192

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
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 19b880d23314b..52e59f38cec18 100644
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

