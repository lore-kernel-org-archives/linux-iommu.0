Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7589427F90
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062540; cv=fail; b=nQGmhaoupD9tzoB1CWTQ7JxChAvirCIVMJ6RFSyFAd6oUd9LaCjjsBkFq4MDquPrXBrrsjDlG4jJ3Loi/nrT+X0v91KNIB+MimRFNp9a9xP9e+Edf4TCurlGdHppsaHvmArs7R1Vp1mn5kkOm+z7yGt07IwKBM9jeox04mBmKZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062540; c=relaxed/simple;
	bh=zMvv9Jvb/4qfvJA1L57LuZRVrucTfggP6BRf/Lv9rZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G/q7Sq/PZbFGtPHLgINthkvLnUA+19jvWBeAxikGLTMIykyAK64a3OUchRjQYlXZ7o/PYreisSZhL0q7EwjshS8N6SH9sZyC3aBP3PcabrhkkMfiexCz7uhHfYgc2p0CK7P0EOEkPgiCAUAxVzFtH1fONDL4OgKuf6TyisQoVDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UxBat2Hc; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UxBat2Hc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6VlUilh5f29G3jJnth6HNJf7zY7mfXcC+oGyIyQW8GyKVHMh2G/eINt68XdwSUnBOV3ZeQ/AjfoYM2/COkOSbjWGii4piVX2TEv2UOzIEm2HLq++2LbvbwxK5LPBCiwsmgApREXdqPpRqzhkUt0ihWSsFEFHZfOiXp3MI0pIA+EPR7jLcg+788FjfVmTrydXT5nHx0agp00KX9h6BvMuzJTjzuMG4j7xs9Dz3gtljhIJYZIXfCOkUj6ur2GRg7kZQCTOo3m9dQ8g8lrspj591eFqZZ1Txr8qrB0jAOc3hdmnxYwHvBfBEM8dln+d17CsxHKYFApe6ZFLY444tDczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvROKIHjLzLVz4XM3r08Mr5TltD+zu8SC0Ti7eT5zoY=;
 b=IJh+8hEX0hEvMnNC6j0ncNzhV7js3CMuR9r6mVoGmZbWGMmyKyenMpBGbvoGmQ4bonipxCI2RwXIjNtLjjqiE/eam/iBsC8Ve8t8rKJ/g7GvE2f+ix6z/f1tQNlaEEzfYoxCDXMuZ7BTARekDbcOhyoRsT7tE64Jg9tOl7JphEizoZSnmjfFcfC8H+jxkAD0CAYLpIOyykqlkn0o9KHGKAWi4kbWg/Esfl0yNkyC+eF/wmaT3/hvJU+K2ivk+l96Q8jJl41HycjIuAGpS66iKjtnH3RqqdyNLixa7MA3T6HkNSvxQ/WBoXMdBR9BwBVcIQg8g3GzILwJVinx0amBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvROKIHjLzLVz4XM3r08Mr5TltD+zu8SC0Ti7eT5zoY=;
 b=UxBat2HcAmJK6fIFcwtTTyziW5dgsKBtHh/X+FQ5uI8hScdua+oxFyff9SBHkXzRz5HprHCIxHZZkNSR54GNSiwid3yMWelEc6/qL1+D8g7DpRliV15Drte0sSwn7MKrAS+j5HbzzQT07pbehWBbz+JeliN6HTEWnUxJymD4M99n+4QDmY3U4YrRNay/uywp8TAqMlMhlBHSBaHvdip7u8tmHJZHKJE+RJSFiComSF6jH9/P1Ujoa8VUSijUQX2qYt02ctakP1Om6CvFdupTJ3O6AvbPbayZTpHmLeA+E+ykfMsHZZt3HwuYf80N7SMSfdvFWikKI32kuPqnYV0ZIA==
Received: from BL1PR13CA0143.namprd13.prod.outlook.com (2603:10b6:208:2bb::28)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 20:55:32 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2bb:cafe::8) by BL1PR13CA0143.outlook.office365.com
 (2603:10b6:208:2bb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 20:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 20:55:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 13:55:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 13:55:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 13:55:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/11] iommu/tegra241-cmdqv: Fix error-interrupt races and VINTF lifecycle bugs
Date: Tue, 14 Jul 2026 13:54:57 -0700
Message-ID: <cover.1784059577.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: b4172345-6663-485f-df2d-08dee1ea3e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|11063799006|56012099006|5023799004|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	tbjvNBfTpWLwjvJnJpUW0cEDdyK2ktmnRtz3UFeY7zaUV9ODxNx9LleJ8Ukf4TGDYDvtguXspkiJulqnGOog8KSWTXz07mdcwHGQNKXCkW9ohK7zu1cVlhiwfQmWRGc17RDrG3GvSYAxVXi5A/WLHnttGsZWIZAoS/x5CsI/bACikYy56axZ8HbaRseL6pK1PyqeKmyPsln1FRbRy4G3FDZRw0kIex68EbEQv5zcFxYur3oLPHmRVPg5ZW0I+j6n1pWhL6DBIjTL2e7lSPIPYSsVUCK/zAJvPelp6tDKXRFPonKFiDLHBnh3GGh5oRVMJzHXYNLYNxD/K+q9bLDmKEwv20z7175xCo5bbIJ07rZAhXxdc3Fk5liKM0tcc1VJQKqUbLqnj+su07gTH8kq3A8W23M07lGuJeeEfd9yxGG68zxpnHuqabpAsH8D0PlZl7O8EZQ3LdfmtPAC6cs8LelR9WMBfDQuZXJzmIFIJ/dravmTBHVxyjDj/gX5RDL6kQf0NZYwbe1+7qhqdEtssCutfKPszjmghk3mdGxFSuEN/SrQyL4o1qq9Vg+fcmkrC1wC7AuGbzQxshHV3+YB/vCrrFr3rljs8g+MC35U6LH52iFrZpV0fhIwy8jPux+0d2O3dtLXE2yWTslyrnl1qdD9/VzvtL17KetTbqgx9u/m0YAjOjOpk/waKtmOURQPuhTcsf/3lMDb0qW6Rd3qJQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(5023799004)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6hyWBvHgEIrPZpAf7lMno1xr1wA8nuXXz3XmLmBrGRx2eA+8v/uqKTY+CtBNjDQbotKBa1zT6Hz5lQ/K2bU8wnNLM2ViJd2nJwksjr7cgbQ5GzFX6c6P1b90pFLgHXE39Kluk/iyHg6bqL6gD+rdOj1ROfjBtjAvPQgOfXtmmsoBWbIDx5zH9wZKoGA2IGCHj/5kP6sLptvYv6PFfXb6DMCW3mm7HS3b4m1IJgmZiyxPKPX4KVLWlfTA63zV+VOzMoy27HkPpUbL5PYlPO+WD9iT2YWUEKF6jWxenssEe/54eNigJaSEAA6xIkemZh9r5h/ym5fAj2Z1jllzJLsE7aGjUSf7Q+shkB5xa/ySVzxVqYpyxrA68dA2Q9LJluXrExupbQcFEwJ6wB7UhutWMgl6ZEZu0klQ+JlMYndbs/t+hfCiXxeYYpjcLTKx9vUO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:55:31.6967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4172345-6663-485f-df2d-08dee1ea3e67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204

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
https://github.com/nicolinc/iommufd/commits/fix_cmdqv_sashiko-v2

Changelog
v2
 * Return -EOPNOTSUPP in tegra241_vintf_init_vsid
v1
 https://lore.kernel.org/all/cover.1783054570.git.nicolinc@nvidia.com/

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

