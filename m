Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E43C4167
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767829; cv=fail; b=Efn3vvAqx1eQtmEPj05ZMyf3YscZzpBKZG9v4OWsM7i/QIeNq0f8515LMG+grqahjYon2rSxVcbeTyGUwIek6rhB8jb5NvHBPuNgJRzAkZiTK9edzVNM7VbPwbrkbNLPwjAL9NlToZJo4/fQbwak7xqZB9pOvLyJx6CvHAMnK7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767829; c=relaxed/simple;
	bh=orxIfU4Yc0Jbd3D/IjBqtOh/6FisMU42xDPH8b5BY5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGBjBa1St/22fXJUD6Q7uceufbqEcSQqxdKbsAO/bjl9DV0jO/DD0LimR5rBs9sQpTpb+Yupg2MMP12aqKIh/4htJ/ii3XJc08aRIyC9qcqiQRD6IMgyh1ZxMn+tafd4NcHF3vpCRQ4dY0XdeurkmRHfWbujcJoEsUovhpjD7C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NcOTgPtf; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NcOTgPtf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUmAv3LSbkzqx1nw3aJmKD2gwZgqajNuLXZW5MuGH/1ulKE5YY3WkeHCj1Nwf4V56rJV7Uz9OEpUSdbD1agMEooCcV6Njyxm8YpZTFnaTrgelR3mJ7Sgv2T0AlDlZm7pI455la4O6bbutwXsohKdtzZdyiuMpR/bdhrQHfgMq/lIctteB+iT4gReTkAna2NU3Ura+gtTLQ+u2MrHAzidsw00v1Vj9tzu2xDt1bVAPzTkNZ+cFiQBarU6UQYw0Vm9geKk6LckxmYm9mSjJkfRqMI/ftTuRHgS7pdxqhslv0mbnNHQxF44vB3+Np+LSbPnLXgs63DlQF232sdFKZ1NJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndKD+RLGOH3qiKAMmkU9ht6jYAH333lyvIMnWiO9Dh0=;
 b=vsUz7IDm/TTmZ+3S7mDHrKtDYSh+Kqv4BG16hDLWkzfDJD+P1ZkjBDwjS/nSbvGZmT4+E6eLNDOOgqU4Z4se5RvTvg4ee5eYBsEC2CjAQS8UloTmjJGYz3WT2CXETo0Tgr/ut6NQptprRt2fZI3xeHpUFJCOErfOOCf0VTOuowU2v7kUq7XmlhSreWwRfertXnjXeu642GbqPBxO+8/uAyghNaEXqCas7/YlWL29GIUvMpOTm4JA3wuYnZbaop6d2G3IJqLXA6JUDak/ONvCDa78kQoaTBrbkXjYIKqnKlNpo8CmlHorj9O/NmzQSL7xVYpx2vkgwYmuUVobbpW7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndKD+RLGOH3qiKAMmkU9ht6jYAH333lyvIMnWiO9Dh0=;
 b=NcOTgPtfnU3Q0L7pYR0bE2KzU5iEpiKhPvRSO88ktU4H5+CAumzSeBRqZJSLtBjOVF3LJz/wLKZ5Yj0tQQF4Z27XpK/yXXSbAb9eZyq5YSJfzH1adu4xQ//+LNb3OAlcie3jMPCt3MncOada8XvcDDTdPHQwkX9blg2I/6vn5KjQPWx/4erH8get4sHGn0u3CpofL7RPTsERuXCRhislJLP3JdKnroeaj5lBBQVMd+R0PEtQ2wizM6NtaYC4vZX2muKcZ7jVSLKgVc+9vgQr6BzUhpJUly1WIx46+qw6M81vx1baeDRCRfN+5Zj1QkX58cRqjmGmY7OTJdiiji5PMw==
Received: from MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::15)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 21:17:00 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::2f) by MW4P220CA0010.outlook.office365.com
 (2603:10b6:303:115::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 21:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 21:17:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 14:16:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] iommufd/viommu: Release the igroup lock on the vdevice_size error path
Date: Mon, 29 Jun 2026 14:16:24 -0700
Message-ID: <b0f848c60ce3337639d95362691c8e98522b7fda.1782767110.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782767110.git.nicolinc@nvidia.com>
References: <cover.1782767110.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9d5902-2fac-4cb9-8baa-08ded623c26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	wntQUjdpeYLF55z7AVB0ln9uY+1EwMTIkeZgrJrtEvrOcLNba1RMXwACmZTmeFRfEZY6OY7ZT9zIB6I06hjSn7pc2WByRH6dfWXkplVrqeY3Lxlvx2iKobwjURWVOjQnJlIUqxYx4HxB1MzGU7NSkAsWkQ4H/rp3l8DZtMpu/a53wO9JoHAnRawqdusmWn6w/CMUbWYC/NdlL6nHRjIXJiH4pVgmIyemk8SXPyWjOpdI6ZZPuePrMBf5mLARr2wNopm+MIbPbTRMbsz31ByH+e+vj/Jm8VUNwqowihcMfsz1ZIUGVbN/fFoDYkvYuVYrwyOBmgEEhw4B+SLe73kap2b2ZezoIeakkmoxDjeoYhD2VsWOcmFAN7yTC6PmrjpJbH/wWnuMezzix1W5DJBkX2l7Nx7WodgtDDOqEvVoHQI473MLu6BSgvol4tCfLODC3O55uZ8yujZnlHN66JfYQ3FZjkoOib7cHRWCrMgAaS7WCMXQBaVS8DA2218V8MHDyShxlwo77H8rcyBMqZCBLrGSA8NrjDV+IN7OzZuBr3Qh0/858vRHUi67AL+654Bue9Oh7yHIJ1Ad7TGD0VBRYthTNg46FjHVWbe0Oc23Hw8MrDRjuYsX3ARfuIt2dJAFTG2ASvd0PieCOCNHBS2TQJai1DY1R6e6cL9eU2aE00iq2cc0EDK0LtKhGq6lorTxicjTeDCiIMPmBLwPYTn/Kw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ga3sHEMt58hj3YH6eWS+UChxpOpEfdB+qD9qB28tiEc+jBT6qKoTUgVDsu+jonyoi3Xn4OSLgHuRfq+AAKvZF8HFsSzKtPEZUsXSRVtYdWwSrJILOz4N+R5oLOE3yrB17GRWhivVBtZKXYGK2Ey6heNuqJdoVth5g5mgKYIe3wgg/Ic87GMMV+kGhVrv9sb/1PKnmbwAB548J2256apTC54t+oC7hiBvoiY4HTqZ7qQrdfgqJGhdrR2WSg06jYD/V+IK/oldWt7FMhTT648JVR18Zs9ZM5qagH9aL28ITz6PvA+nZS/3HDp3zn0gZcUgI/mZJHNzsIj4mF5qNlrTElXA56ypd3zBVL9etBgp+fs20Ju6wfnKIuyNURkpklcRUXI0TZpnILr6pmded2Oe9SNBfYniCckxlfTb78IpQc8hVt07AXx1fpcerkCXBUgo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 21:17:00.6379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9d5902-2fac-4cb9-8baa-08ded623c26d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

iommufd_vdevice_alloc_ioctl() takes idev->igroup->lock, then validates the
driver's vdevice_size against the core structure size with a WARN_ON_ONCE.
On failure that guard jumps to out_put_idev, below out_unlock_igroup, so it
skips the mutex_unlock(), leaving the igroup lock held and deadlocking the
next vDEVICE operation on that group.

Jump to out_unlock_igroup instead.

Fixes: ed42eee797ff3 ("iommufd/viommu: Add driver-defined vDEVICE support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 4081deda9b33d..0c12c7e352a14 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -189,7 +189,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		if (WARN_ON_ONCE(viommu->ops->vdevice_size < vdev_size ||
 				 !viommu->ops->vdevice_init)) {
 			rc = -EOPNOTSUPP;
-			goto out_put_idev;
+			goto out_unlock_igroup;
 		}
 		vdev_size = viommu->ops->vdevice_size;
 	}
-- 
2.43.0

