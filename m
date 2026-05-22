Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC724E4C3
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410229; cv=fail; b=eg6/xMx3zQwm80X+vRaMlRNuceKgs4shx4jHst4V7rOgxVn8eejC51/1ef11qlYmXP72YimNN+tS7E7Mu8PggWb7y4oNX4G483ff+f2zNz52Bp6eYBIji+v4gX8Fc2JQsFP9XI8lrDD1RyQVWBEDf76F22VwuNFnobSE0ee9z/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410229; c=relaxed/simple;
	bh=f9zT6lHn4sZmk5SEPdO1em/IsDyjT0oVI+RnRAjN+qM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrXN2dfUY5N2kkcfA6KIskp9s2MqzwQ1okjhoMqagnefgq+NN473QytPbfl8ogOu9ViwAUtY5nJWNSabiOXKcKAWjmKnfC870QERt+D3SA/046xWAGTw0VyohFoLpeu+2+T51XRnWPJWdMYZBz4w1+OJ0LPNy6s4h5rOXCGRqv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zf/sBX5i; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zf/sBX5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuZfqqvSs+p7ORn0MNem+9oKbpHrZyccEP/iAoXurvJ86wpAIW3Jvp4nFyklS7VXVubucGqN1KRVncdaDqBcWxVfwuArjIGE7PJAnvKbfvIZ+5ubn+MK4EyOP19L+phasbnYJOCpwnkqQEjDQ739YPrr/TJNjbWSzbS45RDgHjrtdXQ66W889aXvkYdBLl2KdLo+dWaYG72ZTos46gIT440yiItdpUr7eq5WCNNIfmxKFoHsE49zzJle5mpuM4mzoypzD9dxhxImFQUqNeIM2iqDFL9UKfSlBuqdBkET+65knrVXKYh/3a5vZci6QBzObGqzxwdm08NOzetW0Ya3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pXNcD8dqr177LjUHTJOoYQnuhsg+LCXEUqPcTXr6c0=;
 b=d5JzRv26wfP+bWAfZ0rA20w3BxH5joXaDTZFrqtDbm810tMtRTDYrqVGG/1bMUn0wPuKe7elesCRxFFX9YJ6zGU5bHjXtdM7D3Ao2IGVqMCh2UNj8I6jzDBsHThuewQ4uT8aGro2e0aygDMTjrt3/qYGT0n4JYX8OY+pnBNlNfUTRAdkGVVeAWWNgclVklxrHCaUgfiiCRzU93O/GR7SBTliRXC6KaFvE9VXmsywcCgb02lfS0OIMovK6KuUd1yNWOiAkCKlbJ7uEIIIhdRn2rT347DQs03xBpYv5lWCit+2Qr8uZKsPkKiRXGGUxA75Q4895Qs7W56u++e733zfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pXNcD8dqr177LjUHTJOoYQnuhsg+LCXEUqPcTXr6c0=;
 b=Zf/sBX5ir+qqjdDFOOarWL7BpzBPPQXmx8f9MfPZhuRepbYNAopcEeF6WAXyMHMjJ/T5qkOvMXWuxa+N330wAeyNSvBYYcHEGW/3BSxf2j3C2D+bg8SW418JzS7BTbu6kgAYpp2iMOVpQoV1+HQJ8qDoPGGrkHKEYavfuzhRur4QBtxCfcE6Rf+4zUFJVW9Q6ODBaCS/U9aoQr5BB8+gxwoZEzhmojgHIiiIpfIcsViKA1hiipKIF6JowEA0FOZz+vSXSQUgpcKL8xF+NHAuwnnbjTDKZHJwgpyIEYUrYFoOpszmSMk5nCkvE+HkEQFFQMumeWQ2xcPNyc9EtLA/Ug==
Received: from PH8PR22CA0017.namprd22.prod.outlook.com (2603:10b6:510:2d1::13)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 00:37:00 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::95) by PH8PR22CA0017.outlook.office365.com
 (2603:10b6:510:2d1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:36:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 17:36:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 17:36:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 17:36:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v2 3/4] iommufd: Set veventq_depth upper bound
Date: Thu, 21 May 2026 17:36:34 -0700
Message-ID: <8426cbaa5e8294472ec7f076ef427cc473be5985.1779408671.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779408671.git.nicolinc@nvidia.com>
References: <cover.1779408671.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 62db34c7-d97d-4864-7708-08deb79a3c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LOmBjSDdrbJO5Z3DKBHKwoTuITOsidpWwvNv1nx18ctpQrNxPsSc1E2Vr9vrj0xfv1KsqcvYPfPJBQKemjw7Jf3nS8Qcb3v812THVRCH31beyRNdHpAlnU2rEhGJKfUCByX4H/7sujKhvIF9kPmcQGvCMH3CRxMOj8WXQxpxEzJRNDU8UcvuJrCXp8Tuv2wYebPqwT7gHhkNzFFYucf2/VZaTeRvBaf79oaezYqwcs7c8M0lSxNZK3xiWd86KJ/8RQTkZbBmX4LcX/qw0bzMkxJJxcQKmxan0LgJgB0623tZ0YM3MWLKwY8+kDB726xOqkRpPWuKiq3wHmJHmgKvYm1JiZG3eC6Ti5/hGaY8BNG3fZj5FCspo0/rStEwsbcSRYprQdT1r+cCd6bYfGQI8/cjPNZZqy8qI3QybSBfuIWp2/wXKVQyEyG57vssiyMFcpxg+HZp0KzWxROrjE7RsASffM/vD4zjrd7nw9T/mhcKaO2pgJNEWcfb1Jys/6eUh+Q6v/YLmETJwPMP+KYZqnjkrFKZCOQGixu8XvzhCBv6NGurzUeeLb4/J4vpNdN9Y86PVBMPmSfj7k0a4liP8wF6qyRYs3KCIW8NrpE+KRvjmBZsXf4VGUmgte+CPb5+KbpIgrh3L6EbOLJo0CvalZ9xAv61OvqJfkJR44yjIExRhSHhZ+MWeLb+fM+z9s/DsP9Zp7JoSynCaTnFxxXK30FWvQ5IHNuiM9qbZ5QfHsw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jqge+poNb4h8X8UO50DwyYVyl5zt9WTojKt+Z8AzrrkMVblVWP17NcScTzZhqDnVQyx8wsZIA+nrll/TEs9jRVadRduBv7DnRQQ+xdr8kwsM7tgU37eG4xkBggXk913xAXGZROCobB+iFBHgTqss9DER/fj46OEXwxtXM0EwQrktb6Spz+YopnVDz7A1FIdYsNTyaLYubFYo0CKDLauwtx1Eip3O9MjKFDbJMrqtTxQvpm29+Ge/L7pw1Xo2VAGXXc1YoYv5VCuFlG/XjD8WXZyeyQM7WhrGmQw+d3eRiGPvF+h8gA5qhrTHUYISXM6KOTPkecD4a6ZSi+B8PLzrR3YoATdM7++XINGsxknfTtwInJhA5lwEAiIsd6XEXhjsWnDFyUdqafiPwZSFqpkYaskeZV6ja8dYnBwK4hfy5M/Vq5elQswCcg1XaSNyUEJq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:36:59.3441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62db34c7-d97d-4864-7708-08deb79a3c1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224

iommufd_veventq_alloc() accepts any !0 veventq_depth from userspace, with
an upper bound at U32_MAX.

This leaves a vulnerability where userspace can allocate excessively large
queues to exhaust kernel memory reserves.

Cap the veventq_depth (maximum number of entries) to 1 << 19, matching the
maximum number of entries in the SMMUv3 EVTQ (the largest use case today).

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/eventq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 78689fb52d24c..1f1e415285b1a 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -473,6 +473,9 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 static const struct file_operations iommufd_veventq_fops =
 	INIT_EVENTQ_FOPS(iommufd_veventq_fops_read, NULL);
 
+/* An arbitrary upper bound for veventq_depth that fits all existing HWs */
+#define VEVENTQ_MAX_DEPTH (1U << 19)
+
 int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_veventq_alloc *cmd = ucmd->cmd;
@@ -484,7 +487,7 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 	if (cmd->flags || cmd->__reserved ||
 	    cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
 		return -EOPNOTSUPP;
-	if (!cmd->veventq_depth)
+	if (!cmd->veventq_depth || cmd->veventq_depth > VEVENTQ_MAX_DEPTH)
 		return -EINVAL;
 
 	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
-- 
2.43.0

