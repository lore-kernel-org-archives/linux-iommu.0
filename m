Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F893822A3
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673923; cv=fail; b=rJkvs96NJDuBZByaJZGEvDPJ9EJE35Rnsvr1WVUT6o3ou7q1gan3MxrLg0+QP06DmFkhwBoB2djHrnNKK89aImRO70z+uDh+h5M+tCU5eGcz5wRqaQ9WJwzq22hr1MyIQvGd3jms9lg+NNIti9XSTOYGeEvs8PQwe1m7fNLKMQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673923; c=relaxed/simple;
	bh=XkKUo7vTgAhtAEGOFOAwdG2PZoAjSkQgl1w2iRp2kZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ams5GwKFzT4VdJst84wPiZRLDlktnb1fNR0vYAPTUKw96rq5ldRbEEOfiyMsdmbQXlH9jRUkiDED7/hLlbAchh8SMZQstmof6Ulr67kZM0s8ke1GfvM6tgR0z/56tOPhMWxRqlbQgq4xFMyfxft3aEhIJ4GO85JHpcv836CBEMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cb1BwWVj; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cb1BwWVj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8kodwNH6JCQoDroCnbfATxdr+G5wGR7fQt41PnPe/bOLg7cpMtTYi2R6U/gAPDASvLyYVaXP4R6xvRxql9BSlIF1XWmZj4b/3ABJ+bYtcGG5rpgYKD0rf83m0xfHHosT8eJ4Abww1eQGAgM4dmVtXXCUn/VauT/O0cuV3XXy9npeRUQotSonZYY8rNF9GMrFJrptOUNnMxGUyUkiRSy1lWaq7HACuQBa+TDsfxYcJNIvOs8HaQHR8kN0hoj3h2Qn+7zIS6fKQ/DK9lNGpxfSU3qOVcdln4c0j7NPKisC9gVvX+smvnuez9FGnc27UqlDfOAGoFTF0CqFivzODuQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDIEcjtEw1GLmqCNV4AaQhnzsVMdkw7rEPRDfojK2S4=;
 b=n5+e+et5svOZbFGLrb9AFyKYWOz99TRSpk026kGG6d8EtU0aJ4e+pw5anS6TwjUdoG4nRcb9hrX3z0pqCjVnrSK/+mE9UCaVFE8zHBLmMKrrvrVOW3ZIK00SeTfH/n+zit4QpRth1eevcuhL+rp1KTZASl49nzg9GfAo5zXNHXvHVkgvS3gMrYyaBNvB41AZp8GUXfDnTK8R68agl2I00g/s2r4vWmXzOmg2o8C9NLYyJwSyVCHM4sp2jWP29o9CrqARaC6Bgcy+WppX7M/uRFVe5+YS1k7ZNfOohhJ1iXfunMOA9Tqub5X19sg139pxkwrExDVROUrD8MUoCrCMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDIEcjtEw1GLmqCNV4AaQhnzsVMdkw7rEPRDfojK2S4=;
 b=Cb1BwWVjYHQtFufh7jzjO2+moAootJKz3G/VpGxtc8l90CFgvPYVQ8WYwu2X/ompBepe5wt3+kRAZqdcl40Wv5cmCype3bXDfiz7xqiavUUCGW7otJUvgWiuY+COIQy/GFioRcTdlE5VCYpLNkkrTvuXdltt+HDF5t0UnhkMz9cZ3jCzTDPikfPg3MhczHk0MDTNh+8zxM8W8JRQnqCQjBpT3dgvpjFRFqchtY8gruXwMh2F8xw6K3RGcqoFQxMf+6ISPoWvzOOjwv+myIgZdeK2a1e+kpDcnM1pr///lNKqJ6kdj7GUbUVPPxRvUQvvVxUIHL3FrONzSq3Yo5rvcQ==
Received: from SA1P222CA0165.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::11)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 18:45:17 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::c9) by SA1P222CA0165.outlook.office365.com
 (2603:10b6:806:3c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 18:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 18:45:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 11:44:57 -0700
Received: from meforce.lab.shazbot.org (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Apr 2026 11:44:55 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <jgg@nvidia.com>, <joro@8bytes.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <robin.murphy@arm.com>, <will@kernel.org>,
	<iommu@lists.linux.dev>
Subject: [PATCH] iommu/vt-d: Restore IOMMU_CAP_CACHE_COHERENCY
Date: Wed, 8 Apr 2026 12:44:42 -0600
Message-ID: <20260408184443.3077333-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 666e7487-772f-4591-56f3-08de959ef924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	gYenGZt/Mdm1JlTEZGMLRYux51FacK00TrFr1gUdlff+J5K76HQaAYR38kjM4bUMH6iylpBUq2L5FMM7J0X7258+r9iAuwAD231Ckrsop0Vs9u7Bo6+bumIJZeSy8KcMlaP2J31GkJJxSztEUypUWZEY/URBTtZMPs9jjwjziuSYJPoicEZNOQPAwJw6pccFbZFh1ufvR/v5dWEXdYHI6Kv6yqNZpG3yteAOQ8CxAuEKnV47Mh0OpW1DVK6fPiW5Ewe+A9qQWQTUFiWzYKUuZuanYOlVfn8hRHyQK48JO0TPLAjyNt4shwBVVt0+xjKeUVkCYznVSbjC7z9iT/8LpAJlZTG5FQQ/+Y0z8hwhIFSDPrqoejIQbtFvx+LXWvivWiz9z93epch/ihG0GsLi8hZiwYS2IrGq6pB59ve9Y7zPvVmpOIEgx3h+sn7gH31grYnOtbT9cU7bF0m410V3r+3P19cDPnkD4Ln4Pbu3t642MQHQatvOZE4R1wTZ/f3DrpMdmOqEeifxBMoR1W/jgWBQDJx8xb5RcQcjvdutEDqg7+M9oh5971MBiRj3KPrznr/l3QfOViIVhy9khcSqYxpiHH4axP87joJFClMQfJU4KcWgatut1FAXCNManIMA3hkxP8zN0/NVZnVg4OC96WoM5Y8/AHm5NTZLeO4kBP42gEdE+/wwmpRWsCOHP9lg3vSMmD2YG9TkBmq0bN9Qjpm+uWAL3luJLvaHy0P15Reh6LXFk0jcIqLlaCqkqnd4NqoEF4Gy3b3pljTBr/YRHQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wlWnN1lzERWN3S0IOv2V2QgOZ3yQXD/TV+kZtjWf+MwrdfQN9h7ip/AsmsyOahUybrze+WiOt/U/++tjnOM8weNQqyd5vx1+kEuhBwBsavSRd6ICYpVWix9+PZq6LHnQhDk2B9stdMAdLXF6lCOj34N537RY4vJ+VKZxHHMbvet2SOUg0QIOHcw6FNbuTwSrHKU/SccnFMn7RE61+/E3cJdQhZp3Df7AXf4Ofq5m4RxK7p6eDmieJqzwVP1R3bobnWrs9zhsonJkdZkSHcex0ySzNJWXi8huZcxlP6BB7c1zLCKcsI55b3Zkh5KQ5hsIC4FZfPQQNCFuUABpN//OAlBNzxh7/XLMJzC4u4vr+h45x0+K+irNFNN8Mo2YqRCIYWR/b6ayq3Nku1TuBXssh9zB2zwklfceCCdHTVjLLZx//w5Q6tvBzCp8z3G3gDdm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 18:45:14.9033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666e7487-772f-4591-56f3-08de959ef924
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

In removing IOMMU_CAP_DEFERRED_FLUSH, the below referenced commit
was over-eager in removing the return, resulting in the test for
IOMMU_CAP_CACHE_COHERENCY falling through to an irrelevant option.

Restore dropped return.

Fixes: 1c18a1212c77 ("iommu/dma: Always allow DMA-FQ when iommupt provides the iommu_domain")
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 63cee27d6a5c..c3d18cd77d2f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3212,6 +3212,7 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
+		return true;
 	case IOMMU_CAP_PRE_BOOT_PROTECTION:
 		return dmar_platform_optin();
 	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
-- 
2.51.0

