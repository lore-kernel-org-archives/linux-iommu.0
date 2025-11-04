Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83E1A5BB4
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219433; cv=fail; b=Rr7hE5qRuqrEG3MumUh2jfM3wZlVBFYpHenK9WNHBS2Vj6Tz6YBgBAUyxIUZbI00r3tKjc/WpkEHKoy36OoLncIJhoZ4Uehyqv3FOgT9EIbrfByO4wqpG8NYYkijdDdvG7d9n64+9aepl+C5mjIPCMYgeC53qfaUtjj+O7AHoEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219433; c=relaxed/simple;
	bh=pgbR1d+S5Fb9izsS8IH9upftLEruZTO2g9HUENjeKqI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp05J88xNP/WoTHenLz/GLw+t5bkAEtdzzJ16nrYIbS1h53zpy9+Ek5rvNvyAJBCIYdTTrkBhNkq+qr9rVHMbsYSEZtm5pyur0N/2aJxt6QBLTDQUMXZU7wz8gx8ifktG4wH30Vg4dIbpNs2Xdjh7PlAGm+yvjsQtk0tf0pmV7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bctFbhJQ; arc=fail smtp.client-ip=40.93.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bctFbhJQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epToUOsmuDJif88V1vnhNC/HtBm5gCw+jzsYKDmVNTC68Vg9ak0jso0d4eH/gM0mYM7H5vneV6yh+ptNWygIg6OSdaYYGcVR/qlSmUlyChCpVm00PcXze4q+pZU+GiafVsZCCYiBuF5TgFfqa2oNAO5r1loSzDhX9F+3EZLRoDWgbM+FK3xrafrb/6RdWiTwqq7Ta2cQ2z2hlAqBsYSWxmA0Bb4KSLtLm+WBw9BqaouDFEE6xl+IgnGYawcmeRfqUTJEqGEcby3FtCwMoFEd3gbAzfUEXpGCEnZa2Jlhdx/gg3Mzfbdi7heYyxYBlTGHKm1iajquUUTP6inWegy//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/o1sfRuqjMj7FcYQ7Jd3/oEEBk7EWi1bNgIw20RBDA=;
 b=gy+jgSQ75i5huEwOL5Y0ATALpCJyYhStfBl2heXbsiGZU/vf4U+SOtWV9e6MgDjGTlRzHtVQCY0ktPmpEiYi1fm4odWl1mbPRIGcuNmWjFRahLptujPGfRGKBa4PBr5HHWMD+HCz1I8EoixgwdjvBzsGeksAbA6vP6PBOJ0NeJzu93PqxQ9gdnLAkJnsF5QWM5v4emXuC6LLRsifGKuPCSXHjoe0Qbp1wQLcrZsPci/WMBKZc7saqSMz3IE7PuU0YTnfRvp6AEy+EDpjXYFxtqdyUo+B5IUVy658dfe0bUN1II2rbvfb6DlpXR8tZ9Hxn7Zreu6da3js2MXTij8AOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/o1sfRuqjMj7FcYQ7Jd3/oEEBk7EWi1bNgIw20RBDA=;
 b=bctFbhJQtQXFqXUG3WdtT7+CBpZcfU32MZYx7UbkuQ07FHMtAVrDaIL2dZyGHx0LrmmWOSn+bLJluYs1PLFcwIKlPpKfzUqAQJhzIWBUHmLDvIbNN57NqIzNNe5dsxDgV7DpIQR0IP3PfJXu3BnIGOux+vaUX67IQqtRr8XxhSLAqVw+BzZqCwbl9/N70rmtndbK5jaP9ujqpAS0VsAAbO+Z1wSvbBpvgZsLaKH3CnkLryNVHA2AXr4yhIMhPlBx5K5VjPwbZZpUiz+g6jnzPE7o8dRyhpIVj3jTE9QNfN6VxQ77acLE6Bxpk7pH6U2bz4L01zyaBS0byX8cEcHOBA==
Received: from PH7PR17CA0009.namprd17.prod.outlook.com (2603:10b6:510:324::17)
 by CH1PPF8423FDA82.namprd12.prod.outlook.com (2603:10b6:61f:fc00::617) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 01:23:45 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::ee) by PH7PR17CA0009.outlook.office365.com
 (2603:10b6:510:324::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 01:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 01:23:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 17:23:28 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 17:23:28 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 17:23:27 -0800
Date: Mon, 3 Nov 2025 17:23:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
	<zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
	<jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <aQlVjtTiqd34I+NC@Asurada-Nvidia>
References: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
 <20251020224353.1408-2-jacob.pan@linux.microsoft.com>
 <aQPptXsqzt6kJS7f@Asurada-Nvidia>
 <20251103151631.0000703a@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103151631.0000703a@linux.microsoft.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CH1PPF8423FDA82:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e4d71c-3c3b-4a83-2341-08de1b40cbde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fAvYZo3TTfsiXNuDNVrFFoxl99ZxMegsdIbs9dfblCREUJwJvziF5lUrBUPe?=
 =?us-ascii?Q?P7Ad2F2Qdp7okmMvJMVCj9VUyFkcYwc/3q1LVEKeaH36e+3eGYIhmN9zsSSR?=
 =?us-ascii?Q?hFoq5JNIlonYfEoToAJvKPx2TnPCGlsR4aCP7P80rWYL427/IgbxhboO4BFe?=
 =?us-ascii?Q?2yfSfSoF+Yrjgq2/b53r5xWOJeX+r8YypR9HiyGzrzolHSNaMC4fhDSPBOWz?=
 =?us-ascii?Q?Sv70uoQKHEkUKDVRSNisGWgeGx//O1RLqr+hGS5htjB7M3RY7vW7MRHwrBwr?=
 =?us-ascii?Q?1cytIpBsWxbwDXTIOi2LFWjAb0pSXla5yE0DVOC2+tP7f6Krf6PQ1WBwWpoG?=
 =?us-ascii?Q?h74jOmHOwWf1qqCaw3Gs0JOyDAJruifGfh8bjN7VcngfHLwp/en/kq8SaweM?=
 =?us-ascii?Q?g1W2KtQmyAf6/Ggg97I3jvJt2yM6by+8OrXAhdJcH8ticbTfmcq2+mxg5OCu?=
 =?us-ascii?Q?JgJ5LCD8+FQNdCI4Bjq8MGqd1kPmkK41D6bfxEe2Yk++woFUNIKx4Jy8pCtW?=
 =?us-ascii?Q?a+cx0Ed0Jbgu5qRa1zVNtsp4MT2tannoygYrsGtvzu3/g0yj/PNG5P2ulzkl?=
 =?us-ascii?Q?cQLM6HePELbKhMVXisKpFZl5hebFxe/V8saqBVKGgbjj4Llw5yX5YJeifk21?=
 =?us-ascii?Q?uvfWTRsmyGRwxPm4LjLiEDs/UAkdkcXntYZ9tUXae6XddFczVYqClpeYLKDM?=
 =?us-ascii?Q?8ymAXD00plV2fUbTD/UnDnmPNqnNqlrBN92qR/IgpGnldyaJCRzCYEnNlprD?=
 =?us-ascii?Q?jTM79HEtqr+tuNjSZgoB9iF2t6pipHa3pUQLaJHQqD3SC25fCvx9kugm5gXq?=
 =?us-ascii?Q?vSXL/raoW8Xu4ciDYMI/aUZtCTogD47YteyF/tu+Rd9L0jg/GS/jIiih7/X2?=
 =?us-ascii?Q?EtsE7+XkzdwsBMy5DaWzR5zJu/UjBlFpE36NWX5mefoW/UQaU0YxcGLyDlgY?=
 =?us-ascii?Q?P45KwsXy2sqzjOcIpUfYkcTU2uhP8S3W8VWgCqjUO01Wu3pk6vbMKTD1WQQe?=
 =?us-ascii?Q?rXrjJCYHAksL6KoO8qZiS5E5eLI6w65+ruosx8CJDS/8YmMG3G9mi0+Bf5Vd?=
 =?us-ascii?Q?lQPHld7gwrlhOLRLdHhEwpX2WRBH+JzxSTs0GCk5ixP59L4LTt84UesV2zNE?=
 =?us-ascii?Q?dm72Y2lYK6f+ZRpnI7z+zNT1gs/WYySmHawPHZC09diEhfELpSNgIaqnjNth?=
 =?us-ascii?Q?p9H6WmAG68sjGRV80CugX3levdqmOWJLWOV/7bhF3WfQYyIgmkzLUfSi8TSe?=
 =?us-ascii?Q?RFUAs/QPrWpBS6yd3aScBMNub/YcRjW429EoIkYtm4ybaY8jscS6OeDkrTLQ?=
 =?us-ascii?Q?vXaDgc3Um5Bife8pA9A1xhrcPi9ARG4dHeaGDxIhMm9H/FDImQfgOK/SGoQZ?=
 =?us-ascii?Q?ffpg/z3gfuSZtj2g+VKKMFamIBLeYexHCGcuqDNRnm8emMoEik0Lh8pOW1OA?=
 =?us-ascii?Q?PxftzVg3RTZQ7z72+tAdi8Mo8npXO0q0n4IJjlmHtn4w6PU69ZMrRwKOdMAq?=
 =?us-ascii?Q?BN2M7yXxcxr+nYwsydQgelfO1KIw+3b2wCtIiyEaGFQK7CkxU0W+RhNvkj43?=
 =?us-ascii?Q?iYokCnzUhX7KuuSPM9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 01:23:44.4213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e4d71c-3c3b-4a83-2341-08de1b40cbde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF8423FDA82

On Mon, Nov 03, 2025 at 03:16:31PM -0800, Jacob Pan wrote:
> On Thu, 30 Oct 2025 15:41:57 -0700 Nicolin Chen <nicolinc@nvidia.com> wrote:
> > On Mon, Oct 20, 2025 at 03:43:52PM -0700, Jacob Pan wrote:
> > I still feel that we could just replace the _until_not_full()
> > with a _until_has_space()?

> Since the current code uses three nested while loops, replacing the
> inner _until_not_full() function means means retaining all three nested
> while loops and calling queue_has_space in two places - once in the
> middle while loop then again in this _until_has_space() function.
> 
> I tried to extract the inner loop into a function but it requires
> passing in irqflags to restore. Not pretty.

I think we could do:

-----------------------------------------------------------------
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b948f05..1211e087dedca 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -138,12 +138,6 @@ static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 	return space >= n;
 }
 
-static bool queue_full(struct arm_smmu_ll_queue *q)
-{
-	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
-	       Q_WRP(q, q->prod) != Q_WRP(q, q->cons);
-}
-
 static bool queue_empty(struct arm_smmu_ll_queue *q)
 {
 	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
@@ -633,14 +627,13 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 	__arm_smmu_cmdq_poll_set_valid_map(cmdq, sprod, eprod, false);
 }
 
-/* Wait for the command queue to become non-full */
-static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
-					     struct arm_smmu_cmdq *cmdq,
-					     struct arm_smmu_ll_queue *llq)
+/* Poll command queue PROD and CONS, using a continued timer */
+static inline void arm_smmu_cmdq_poll(struct arm_smmu_device *smmu,
+				      struct arm_smmu_cmdq *cmdq,
+				      struct arm_smmu_ll_queue *llq,
+				      struct arm_smmu_queue_poll *qp)
 {
 	unsigned long flags;
-	struct arm_smmu_queue_poll qp;
-	int ret = 0;
 
 	/*
 	 * Try to update our copy of cons by grabbing exclusive cmdq access. If
@@ -650,19 +643,18 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
 		WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
 		arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
 		llq->val = READ_ONCE(cmdq->q.llq.val);
-		return 0;
+		return;
 	}
 
-	queue_poll_init(smmu, &qp);
-	do {
-		llq->val = READ_ONCE(cmdq->q.llq.val);
-		if (!queue_full(llq))
-			break;
-
-		ret = queue_poll(&qp);
-	} while (!ret);
-
-	return ret;
+	/* queue_poll() returns 0 or -ETIMEDOUT only */
+	if (queue_poll(qp)) {
+		dev_err_ratelimited(smmu->dev,
+				    "CMDQ timeout at prod 0x%08x cons 0x%08x\n",
+				    llq->prod, llq->cons);
+		/* Restart the timer */
+		queue_poll_init(smmu, qp);
+	}
+	llq->val = READ_ONCE(cmdq->q.llq.val);
 }
 
 /*
@@ -804,12 +796,13 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	local_irq_save(flags);
 	llq.val = READ_ONCE(cmdq->q.llq.val);
 	do {
+		struct arm_smmu_queue_poll qp;
 		u64 old;
 
+		queue_poll_init(smmu, &qp);
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
-				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
+			arm_smmu_cmdq_poll(smmu, cmdq, &llq, &qp);
 			local_irq_save(flags);
 		}
 
-----------------------------------------------------------------

And the commit message should point out:

The existing arm_smmu_cmdq_poll_until_not_full() doesn't fit efficiently
nor ideally to the only caller arm_smmu_cmdq_issue_cmdlist():
 - It uses a new timer at every single call, which fails to limit to the
   preset ARM_SMMU_POLL_TIMEOUT_US per issue.
 - It has a redundant internal queue_full(), which doesn't detect whether
   there is a enough space for number of n commands.

So, rework it to be an inline helper to work with the queue_has_space().

Nicolin
