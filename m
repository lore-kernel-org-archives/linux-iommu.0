Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93C35AC03
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056735; cv=fail; b=lSH8RTaQ8v3bAaWn0cXKFbJfB2Nq/DRQafG+5cdbbYdY47imImDzzZJltBoXqo5xlmmOMiE/YqZkVwizIpKEKVo93BEkzKZ/5fdhBij/AXNDAXRjMb1P8Qz8Sj8akrFjGjmZn6p9LuTVBDIxpCANSmnol6WzEUL13+M/ZN2CnnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056735; c=relaxed/simple;
	bh=DQsM5w8bAG+/RTJL03uy7P/geMjxmRsy6HJknuAdwI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sae1llTgdJxp+uzZnhKWfD7qn44RXq7koUeyQfX+u93+hdg5e7SzBbkaI19FV9d6QbIaW2M5cgMQGXZ0/ZUA6eRvKF0KF7FOmhIvr0pfu6JbBLvFCSarf9zq28f2Fd1eJvBSPzpP+YH94CI5uxTFAdnWLANAt+ahd6ashhUuO7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LRJWOXCz; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LRJWOXCz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUX/v5TFhp4IHuexgbZVavibx3Y0sW/M5cJRjev2HmTqRaCOpSNkokgU6Px94jDQGqYWo7j1zl9KXaSnCYk7zcOvN5uSYsYLsFv5KXkd/4snUHJw7fxzxBOURs85oI3NxtF2Wr7ZMlUnIGIDCxTqSQoyYumqLAGRESRFxkTC43bCYrdR4bWQUX3rjxBdvKSZ5mC7IVF70+PHyGLUcnpfhqzWQBCi0LsMMUgnUHFwdOfYpIuxqHiuHD7gXNkvXaHIZJJxUdIg9NYzLrv6dNsULD3vz8bq10KjaILe4Np7Um7kjXmga1EyHgTg8DYXNYNVCaDo7GcZTwUAiEsIqgruoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G61UsFcLKqv6S1hmLaqI+a/n9pwHM9LqSnXz6RdUnh8=;
 b=T/ELqN4b+N37NcvdiA37Ccq+DqxNqpu9K+k6hPN1K+pcYc0/PfG9ev4wYEyVxVliKvXoKWT8/l2A4en3x0/rdmPcvNDLCNVv95cdJ7RG8ogW8ICWg1Kl0va2qftqw+MMNwyoNegkQ5d5qvct2F+DqE5Msd4rxmUKW6h9NcsnZlBNC6aHDBzlPdxiqTENipcsjWFUOH0x9pAD9SHFR4uWvZoV5bzDEU6GdmmxfMA7M1k8W/EkSEZGovyupsjCxhxVy6muaR8iYFZGrwhhpPU45MYHz0v7AyOdRlTtOga7R2+onamNqgUJDIGFilMFoHjorBBNrT+kLMYkzhtm4hytxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G61UsFcLKqv6S1hmLaqI+a/n9pwHM9LqSnXz6RdUnh8=;
 b=LRJWOXCzIm7f/5TGVJda0Y4qkUvvVAuHzSNMrsbAU/Gr/QG+zuJ6dBHpOctHWH7JE/ATumYy0UsFmVDNTaEbwCEIVkzyeoH5t+mjj4PRB3rz9okk6rwOn3WTywzAHkIrECv19oiYxvj323oeljQfDjOwBoAlPGrRVJP+aUZ7wGlLyrlSjpKh4YH3jImqm4k1CNU51M045r8VAp7XtMHm59MyX0un2JpXhgxsW9to3TjvUkSNFqp5xCkCuLnchce41MgbKBsEhXCnQSHAChcS6ml411xAaS7C7ULOi+ZKVFvNNeyWRWhdxTiL8KkCtaPi46FkaCWdfJls5pzSFRTU7w==
Received: from BN9PR03CA0666.namprd03.prod.outlook.com (2603:10b6:408:10e::11)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 05:32:02 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::1d) by BN9PR03CA0666.outlook.office365.com
 (2603:10b6:408:10e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Fri, 3
 Jul 2026 05:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 05:32:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 22:31:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 00/11] iommu/tegra241-cmdqv: Fix error-interrupt races and VINTF lifecycle bugs
Date: Thu, 2 Jul 2026 22:31:26 -0700
Message-ID: <cover.1783054570.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b67092-0857-4bc7-0dcf-08ded8c46973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|5023799004|11063799006|56012099006|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	IIUuZhrD/pMjFqGzG14CN5wdO4oQhrOGNxxog4+hoCP98/9N4dnU5CAMvS8rvA2ykpbCB/qb9Dt/cnSAHyqOC2O+qD4SLIFugFKpsa3Xt8KBZnbnjgRtxLMwQH7aqU9YuTpUgzXNneAAYX+Ff84q3TU6terweVPW6Bz1d0fowVYl8PMWhf+FeZr/9ScxWTzgL0HFA3az2+R7GvSSWYwqioMKE/H1LiKsjI+Ykh8wF2EKGaY7GUw7GPz9QSNVK9Has4lZdf9/9EaLMiyAq8ZBW/KZa9WBdDWRHF9S3N0voQhtgTnubtAwQYjqQKAp65WxUY2cuyxB8ZYwuLF7pzgkcu16zbYZAvWwHZMijw/HcTcz4EiQODAPrz3MVCEoyS3m1cy6WNgspeExlwFI5EdPE4atHuEraUVtET3pg2NdpuWmhN+1q2EhHfj15WtP0E4NlmJ2SDAA1nGZz+DT3OztKGMEwtZV+h3ioXP8EU1u9wLx1y1YQ96nkt7umVZ6usFmdbhlFH1hSghB5c6iU7wk7FlUxyMFBqa6cKLwwmFFEiggYeZS1aiOBOWXKQve4rFijdkZaHzfU1OVtgQ33z/jji78OzQG3GP4NHLEVrsd644EjXl04XYqetQNmnXT3aO0+WgI7EH/jrSYCNhZBhLNZ+zN3O3NZJQ4lAy0YbpKFgnNeyQBGQ7eKf1d1nnesTB6peQnOUTGGdbLL/qk7bB7Gw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CzVJvrUB/uT0uFdf/IueAtIb7z6ktnXyFFfTm9JFZ7ZxblNSNNAa1pkJY0YLB+XwUDy9fpGVTnBHEt7c0y/RZsl1CWANYEQrg/IZ4KEzfQF/s0N8fAPlcVyXX1tRcpGEiaS3CUAwbt0MqX2IQqRFtQFiCvMu+sQgNYtcVu3+n4MpOH1of08bBy8+7eyUjWraYgDTb7qCvnuqjxhhikGR+DdgdJskgQKEntdcM0JDMb542rrOxZNH6HjibQZYVRQBTqlSJ50lObQgdqmp8tVJ3LAFuCv2PCSm9Qe4i9kLbLAh6e7u9V7dDlTP9PcxN0BABHQxUewbxGg/AZF5+cUqsQcsznZ4/UlsQIMsM9fL0dCVNFWbhs7ZXTh6tmJj0QdnJwklzE854cvvuR5KZ8/G/FyqHmzFo2cp3Am177sX9fr14BHSaC9Wa0TwrCC8wGJ7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:32:02.5619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b67092-0857-4bc7-0dcf-08ded8c46973
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361

These fix a cluster of bugs reported by Sashiko during patch reviews. The
patches are ordered roughly most-critical-first, so some later ones fix
smaller pre-existing issues in the same functions that earlier patches
touch.

Issues fixed:
  - the error ISR racing VINTF (de)init and reading a NULL, freed, or not
    yet fully initialized slot
  - the probe fallback dereferencing an smmu freed by devm_krealloc()
  - a guest vSID programmed without validating its width or the device's
    Stream ID count
  - VINTF0 leaked on an init-failure path
  - error-map index/bounds handling and a VCMDQ base above the 48-bit limit
  - the error ISR flooding the kernel log under repeated guest errors

False positives raised by Sashiko:
  - a viommu outliving an SMMU unbind and touching freed memory on close: a
    physical IOMMU is not a pluggable device, so iommufd holds no reference
    on the one behind a viommu, and this teardown cannot arise.
  - the ISR running after cmdqv is freed on probe failure: free_irq() runs
    first from tegra241_cmdqv_remove(), the devm device_remove action,
    which devres invokes before the cmdqv allocation is released.
  - a guest never acking its VCMDQ error wedging the shared interrupt: the
    interrupt is edge-signaled per event, and the host ISR only snapshots
    the error map into the guest's bounded vEVENTQ, never depending on a
    guest-side GERRORN ack.
  - the ISR accessing a de-assigned LVCMDQ page after a VINTF hw_init()
    failure: the page remains a mapped MMIO region backed by empty
    registers, so reads are benign and writes are dropped.

In parallel to Shameer's Tegra241 CMDQV CMD_SYNC use-after-free fix:
https://lore.kernel.org/all/20260629094106.251694-1-skolothumtho@nvidia.com/

This is on github:
https://github.com/nicolinc/iommufd/commits/fix_cmdqv_sashiko-v1

Nicolin Chen (11):
  iommu/tegra241-cmdqv: Publish an LVCMDQ only after it is fully
    initialized
  iommu/tegra241-cmdqv: Synchronize the error ISR against VINTF (de)init
  iommu/tegra241-cmdqv: Harden error-map index handling in the error ISR
  iommu/tegra241-cmdqv: Don't run the error ISR before probe sets up
    vintfs
  iommu/tegra241-cmdqv: Don't fall back to a freed smmu after
    devm_krealloc()
  iommu/tegra241-cmdqv: Free the error IRQ before tearing down VINTFs
  iommu/tegra241-cmdqv: Reject a vSID wider than the SID_MATCH field
  iommu/tegra241-cmdqv: Require exactly one Stream ID for a vSID
  iommu/tegra241-cmdqv: Fix VINTF0 leak on the init-failure path
  iommu/tegra241-cmdqv: Warn on a VCMDQ base above the 48-bit hardware
    limit
  iommu/tegra241-cmdqv: Rate-limit the error ISR's log message

 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 224 ++++++++++++------
 1 file changed, 156 insertions(+), 68 deletions(-)

-- 
2.43.0

