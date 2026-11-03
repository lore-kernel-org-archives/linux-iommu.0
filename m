Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729263;
	b=Q3Z8OKNJNWbyqVE565g4WH+rSG4KHmLAzcEXdLDGVO3TNiB/9EcQ4xH1V8TjlsTgBTZI
	 xQb7phlEDVFHfKmRGovHnmlS9FIsDRhOTBgPzBGyrUsu9d4g6u72B6uVt4wOPqSaDlLEd
	 0z8BBXOPMwXzJlVCEWB6URPK7EgjV6dqZtlmmI2g0BfQlDhC5fbPEOI1sdPLVqUMxDWzB
	 hl+ktnOxc//vmQBs1m8WJXn3rD6SjXgeFf8IqYC1EU+a4SDfvNZC7y4NRjpRq9uRmdhoX
	 1LWDP4nz9TJ9GfoyVUYYYnKJag7HheTyHs6dfwbUF5Q6jsDEtXcEnL6K3Oc3U6649Ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729263;
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
	bh=nE4mrJzxfhD0QrASwlDPAOHQrtN+wouzFaKvMLKGMe0=;
	b=xyzugc3uClcO/xyoITZ7N4RA1N+MjbA2R77ZCVwPoajuIoX+sLARbvmd/5dLqOunamH4
	 BP0ZNMbZT8/P5YXAzES8ZKrcgyqOu7ysya/UrGCP20rQQPjihqBrKrJYmvW5DeTzqsqE8
	 3w+KBCV2SoDsSlcm9jxsffGeNEk/+vGUJFj9+WbKKy/qVwB6vNyjsqXjd6x0TGJQRCfKa
	 /KbcKfXci4VPRSa2zIqoUbtGj5Pxfei+p5FzXbF3OPd8g6/AwDoepTgbNr8jm/NHuJNHL
	 r1cEVsgNfYnTvAg+uxUYSSAmrPu9zqCQMYFjWSxQpcufHs16Hci+iKgAb6/G/BwPb5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OdebfKEB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.40
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91786606A324
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 18:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91786606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OdebfKEB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIUvrfTT3Ra+GYQVcrruNPC12sZWnbUzB6S86A+6AuLszl2VscS0SIjnQtZoTFm/UCCzLvYjg6MtzG1MYsbUYBj+wSfp7vmk8ks/U97VbqSEIwZjcnz+WI2CT4UjpNyOSyw3P0o67PIY3AV3LrBXA5FufjLG6DE98l8XFasdPaUcdJ7xyYTKnR5kv3EzjEGcomIpsScqadsBu5sz1FCeh41IuCRZpoDhN1vjtZ0+Ylm47lYFjLwolx7rxyQzldrJUQVxMRVyYcGzpEc4ymRMTGwZCh/TCTEI7kTaUrTxRcPEjq8kq5b0PCFin1nMvkgJIhYOhGP+fMbDgXmX4yZYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nE4mrJzxfhD0QrASwlDPAOHQrtN+wouzFaKvMLKGMe0=;
 b=pMuT9woknYOQoMGqpCxYn8GG29ENe+1cAfBFMyKvh2C9knXi13NnqmeTpHD7WXv7oL//Rm7BrvEGZSGFFjzwoLfcJwHkQInBd2Em3sfBQtr7+O27PnwsHMlvSl0xlam2m1TGdRKwZO37xn1jd0ballkgXT8Lra2lJOJkuJvy0eXa/TfXg6PQUPQQ8FMH3wwAW92T8doaiKxsin/IFLz1WfRcT+GgKMuZoyCfd80OCgT7Re/WT6mL1vzBVqI8ViaBG52J2KLEgy3vdSHxrP1SlZj9bV7Ogv9GgMQeN9V3qjL4Cc/HD+5jR+cW92HVdSeSnKOb+cERlZn7uJ18iSwvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE4mrJzxfhD0QrASwlDPAOHQrtN+wouzFaKvMLKGMe0=;
 b=OdebfKEBGM2SKT0n2AaeCSH1JwsWfijwTSCnbcGKz1aN+6XDfYsUPuq+log8IMd0ytzkIC0kX+XSxhOfy3cdxp/czHtp1qRGA3IX7DAYYtoxt3a90vLRhOUJNRuJ1isyofbRPb+vqLK266M2gUabZIGHoezVOqNzt36YgBTa/hB6emnK7EsX9RwSn8PkM3O9hbVsmg0R5R/0xhqP/eLNfOJiySz4jlGeYXH4axYfoNuMEN1JsPQ+rT+h5SBmaAj9i56D/SiGSKg8N4pj2IPh5G05TjYUphf6uUuN58DPe1njzMA9SccnAoc7jP7ID7l+oBLl3wt2HnTC6lh2lrGvfQ==
Received: from CY8PR10CA0003.namprd10.prod.outlook.com (2603:10b6:930:4f::24)
 by DS3PR12MB964154.namprd12.prod.outlook.com (2603:10b6:8:438::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 18:07:37 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::72) by CY8PR10CA0003.outlook.office365.com
 (2603:10b6:930:4f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:07:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:07:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:07:11 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:07:11 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:07:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/5] iommu: Unpublish the attach handle before the group detach callback
Date: Tue, 3 Nov 2026 10:07:00 -0800
Message-ID: <80c57662f4e395a7ce8be9aaac4c92591703971c.1793729087.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|DS3PR12MB964154:EE_
X-MS-Office365-Filtering-Correlation-Id: 47720999-bb43-4e0a-2ac6-08df39d557e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|261021123027099003|56012099006|261021121427099003|11063799006|261022105027099003|261028144727099003|261102130727099003|261102123227099003|261026140227099003|261026121527099003|261009223027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	+IGfokLE20P1eJl7m44gwbJGsiX8gadbJ7kc/vkjNxtX4Dyx4qLRZEarf4UMADCcciGm59p4g+cvyC4gxvkzTw6SGnZf+y5KDLU/pkmIRzUi+oKZ6WabyqgmmOzqODkjreCHeHUL7jxSVjWQtvfBAw6jlyBvhyX2+jGRlhWX7UnWm4Zyy+Um4JMv+ATp3F2sxS5G8GQ4wu6waV8XtmzoVjvBWZSifOw+5xqLtfkh3QHWe2/oY5KALfvHx+0nUxFLpS4nyXZ/P30y5SVAR5Vb0GN4jti4pPdDAxOybsznT3NBvYTTgJMxdI/7HtKhpHkbv3OMwbvVn0Hupea33CbuaxYFgcLDoB0iMeh2yBX10zbn4IaECSq2oaPYxj41o2lARuohOW2MEFhkt+CnxmFr9eXxOCwTnbbvf69F//RpKmF084GeWVR0yXn3+vgLbSXMqWkw7WJAJlTKnnlS67eohSYeR2op1yRuHDxzMdE3j0yFm/cxab4wQOMCoXkes1vwrCeEIZICHXtDLgTEglBHpCYFhjLs9m6PP7FvVsCRe1P7pJfwvdcaXnN98qL/j3JoTJKKTFPgx2XITGoDQ8fEmfSl4Cc/x2LOfkxJOo58ITI4VxoHopt67f9NiawhBhzw0yx+57DVMIoGO3yp6k/48s/rXmBmiYC129X26NOvMZjnZ5/njyG4pPBGyIwmZ1JOCagEOcscgz6O3+/lIEC1kw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(261021123027099003)(56012099006)(261021121427099003)(11063799006)(261022105027099003)(261028144727099003)(261102130727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261009223027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IxwkrNzOmV8KVlmjH4DQojdaVvp/5H/kiwDOdrimBu29ylqlGrusMlLmPn1GvZ4/vfOwy4opEAo9kXel6qXPHULXFsegJgkvmMetO5fe5LZaqEA207tyCz3J/PwdG5b4lNqn4Rad8u0BebLzCgnQ9j8En9EUjPOUyz3qyTQvNRfWS+SiOClSVB3pf/kb5UKROS+0yE6Tlt8jPkfYDFOz94t0wWm31Z5siDESGfMGfax5pUvf7fR6txKKs9yDI1TI2ymLBRfIicxhrLYloN+HZVSeZuKH4ZO3e6Wn9kqXIRQonZ67D+5UNPCxAIZB0MNFgic/A/6212PWnquXm/a+yw2KenlyTuF5M+H94mMZvqH0/NlhA9DbZtTA3VvvVeyv25ruTAIJVFrL++rLQEVkkZwwEACPwhGv2a0NEOsvkojxCmF9eUtqt4mnXeX7XuHw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:07:37.4360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47720999-bb43-4e0a-2ac6-08df39d557e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB964154

The group->pasid_array entry is erased only after the detach callback has
returned, so the outgoing attach handle stays published for the whole of
that call. iommu_attach_handle_get() reads it under the xa_lock alone, not
under the group mutex, so a fault raised in the meantime still finds that
handle and the domain being detached, both of which the caller frees the
moment that detach returns.

Commit 5e9f822c9c68 ("iommu: Swap the order of setting group->pasid_array
and calling attach op of iommu drivers") has fixed the attach path, while
the detach path never got the symmetric change.

Erase the entry ahead of the callback instead. A missing entry reads back
as NULL from xa_load(), so that iommu_attach_handle_get() returns -ENOENT
and the fault gets rejected rather than delivered against a domain that is
on its way out.

Fixes: 8519e689834a ("iommu: Extend domain attach group with handle support")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcd..0f9d49a5c3fa2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3951,8 +3951,12 @@ void iommu_detach_group_handle(struct iommu_domain *domain,
 			       struct iommu_group *group)
 {
 	mutex_lock(&group->mutex);
-	__iommu_group_set_core_domain(group);
+	/*
+	 * Unpublish the handle first, so it would not resolve to the detaching
+	 * domain once the driver is detaching it.
+	 */
 	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+	__iommu_group_set_core_domain(group);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
-- 
2.43.0

