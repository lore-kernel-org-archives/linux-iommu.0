Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793596787;
	b=ZhvyVRD7lesZAbQb1mB7V703oMDrbmonmFauQLnx3Sv0AjVumpKK0r3LKRUxVekr4v00
	 7RQO+PkryitglSGa3jJ0V2hnqACzRFpbgAs3avSt4O3pWGCvpD3Ge3fl+qxB28vaIu/61
	 MoqE7CeaEIMvL/JvU8VCpVHr2snaZMUd2VR1OAvkWgZT2/5D8rwi5c8KKXq15d186UGj+
	 OoKeJtJRyZLUT0EA45HlTT1cZZ2q8kPFTDSVnY/a6NwSkBuHaNTfjZl8cYkdrKGmyPbjO
	 f2JXpHaPvSvj4T/KOp3GF7gHF8rCpokllC6ki7pUQIvNDbHQVR92xbzWUdnHnjQdbtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596787;
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
	bh=P0nl3az0FrnI86MzNYtGIeDDnt/B5ura6HZHXXE3EeU=;
	b=F67irxIe6cyFQVQ3p3BT6xgpWOD/Cu3WF9uG6631oa5vtOHGsUGUOLroaEtBocUDoRfj
	 t5UrPsUtbuAr2m3RMPfi/pX+M8QoM2MwTg/9CY5brrUSAWrU9dUe0+R6RLvZZCl0vX8X/
	 tvp3B6F/bYYrirpmQ5+SR80AV1XyaNcPRzfHbet6QMJru75dkKARYqkZWJm+uv39wNR75
	 TR13vTbsEKuJcvbebHOIcvNb3cpopXzMMlGxG6MpGtFG9XwWKk0W3zssV6uR5JfIHsFEC
	 hFcuLHuqT8lEayq9e14X1ufXzuMxGmPjWpwJawP46W3Hx5KD16RIghahkSTwy7XwPvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R7DPdT+4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.13
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751D606A326
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 05:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9751D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R7DPdT+4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnaxW/g51S8kOkczZHOHznXZnL55RVgzUyheFUSEU5WUs6SsEnE7Ikb9NqrLZ7c/tULFd8aOd29y4f34+GsGxH18QMigrQ8DiqxZyo5bjHrqnYYAFRk164np3Jcn1fXyCtNRaI3QAm94qH2irAVUc265G2EO5ukRe0Zbr+jf9nkVj/eydWUyR8XlPZV5sx7jUKswXi2nS9akCJbNptv3/AOXzNVZ5WAbCUJ0npKc2C7SbsoHAq+9h+4Cr1YWNiXVdlxWRaEPIz+AuoWvWirmS7slet/lYU1WkJZltxsMs6ybIC+ZBgr8ZooOXfVgbfNVMCe/GDY8lk4TC5+tOg14AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0nl3az0FrnI86MzNYtGIeDDnt/B5ura6HZHXXE3EeU=;
 b=Ddm1Lw+Sihf9dtjdW/6RWnZUvUKWnZq6IJo8BxAVAlm4loHApnLDtxD64Bhp8um2ubtBN0dpoFgcDyU+aE4fRpmcWu37NJ2+zpOCJxeYrIXKE+D8dO2ITG6WIV481f3nxrERsVnFxyJhst42RfRbeqKi3PVNvfByW7W1JM1VD2n6AQDfSjSIjqrJjKIYXKvEZ6U4nCMkBwsIsZpXPb8fvle980fWY0A/8t/ol97NTtP2QCYtFrYp99BzQ+/V0eLirqQCa0VdkRwt6lO8UAAP9F2awvYRRRUHzY5vnbKudMVysYmQkNTZ/6fP96qzARXWYQQLwbqbw5ti/FSAVWW24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0nl3az0FrnI86MzNYtGIeDDnt/B5ura6HZHXXE3EeU=;
 b=R7DPdT+4VNrRP/iX93nglMTRa+c5HFqPRuEVtijSmVFnnvUN0KwOKKhYmjXB0ln6+RL0U31qVXBb93WjQm3LQQt5hUPeK9ljXxZ8lt+nkO8FGsKZHGg7XHhNL8Fdh4igEFksEMkiIfZz+ahNu74nne5i0OzPXjjRuazDhfsPqY5o/AE8jPFHMWkMQmBulunqehdzEjhn4HgTXyFj4kKbwK7sbzQlbcQ2d3Rn0ljqZWOarUIuxIY0tRWtK0Ld7M96sX6/UoOJKntd3jSLLgpiQNJBDhwhGbcyPBLk9G8hL/cdrPGI4wf2WyyCUIiqJYLLJYAlvzltjfJcISeHVVaclQ==
Received: from SJ0PR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:332::14)
 by LY0PR12MB114387.namprd12.prod.outlook.com (2603:10b6:404:231::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:19:42 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::55) by SJ0PR05CA0069.outlook.office365.com
 (2603:10b6:a03:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 05:19:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 05:19:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:29 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:29 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 21:19:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v12 01/12] iommu: Pass in NULL old_domain when attaching a deferred device
Date: Sun, 1 Nov 2026 21:19:09 -0800
Message-ID: <963f674b92f28548e03d6fa83a950e93d81ca3de.1793593923.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793593923.git.nicolinc@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|LY0PR12MB114387:EE_
X-MS-Office365-Filtering-Correlation-Id: f23da197-31e3-4958-21d8-08df38a0e639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|261021121427099003|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021135927099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	v/XdgUEyyfUpxnZ182H7CJfcbpEV1gYC5Ikahfij/KwgINgRRytQh5fFNItIn37JB6qkZZ+cQqCzPvRreabqoUz+hkat11O7kAW9m37K+7tDeSdVYQOXRmvdWh/jWaWEINvKJtCtfootSCeeOyAJ5M2fZbRnRTTiXZYVmV6WIDx7ygxl456sAqZ0UP8HOw8oIKTc3E5gz+BFHRc8UH1vknC+FNKEdgxGSG7NJXmiQDMgS0nNRG44ORu/+zfHiKSisQ83ZOAPpamOS2lEcso+PXYd25HuLPT3XLZO0Fwi7c4n35JvSzY2EuuVKokzwzRESzZBGQVb9CmzeKq3Grm81izmZxlGsA406R6+1mwiM9icfAEACCld0zHoVFLPFpt0A/0zvvdLmcf07hPzqOIVyvZB97P48HTwsxwtaJw99hiqrJ9qNlLPbgrWXMyU/ewShkEZqnxpdPrPbM00AJAAH1pEMRmC3NRus+GXp/OsIu2clTybf6a5WSBHByxFe2tNOwwPtXkMnaVON2mO6DT0qKDEBIIa1xWLHPGl2jgotvPQ+yUXiKk6d1LLGHwQpeR2Tnh2kkcfU+RzK9zNdyN4CItXjRRNbOqs4quoTwA4v9IcN9C/Ajnxu3bIC46lfMLkBTXXDr8cNz1Uayp4HppPVUUY19ahwJcM21Q27fiWWOXgSSfVNneZSDILZvixBhi62OxEnXudRGUghGEYLXUwXg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021135927099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zau1M5/gMIgn3PU2qKN0HcLlV7b3ru7iEYdzY1H6i36Dsf7wx0t8w15x8gEsJLHPgMpmB4JR6LiQLDDztv3etLcPRobCTyLjUmqPKBG7u5Lr13rapivuLpzmenGJSKN+TdBTacpu/+IfWK5zWAQzP9EUpjAJ+k1CzYgzOJeQWwEXFn+pbvvocpmq3krBqE//GAYKPI7RWWe4k9SZ39eZwnYJ+MIBH2ZLWFDcPrgwaAXvq4Vb4owVdOB3VVS0eMHfXffvaxc2J+kgWTyHRF8Li3E4pvsmYKdLOkzLnGPti+tAVqKCgYfl9QQfk0egGNs6RDmLuOWZwMK15Qw7GmulFkq52ICupXnFTL1R1TOmu6G31Dq8cWf/FeSPlelSmzl7551kspMrYqw1dmZIj2doAyMXz4btl4m6V9TVQc/lD6A7bGzYISvpPl285wqkdeEP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:19:41.8047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f23da197-31e3-4958-21d8-08df38a0e639
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB114387

When a driver defers the default domain attachment of a device, the IOMMU
core skips the attachment in __iommu_device_set_domain() but still sets the
group->domain to the group->default_domain. Since the driver has not seen
this attachment, iommu_deferred_attach() later finalizes it by passing in a
NULL old_domain.

However, two other paths pass in the group->domain as the old_domain for a
deferred device:
 - __iommu_device_set_domain(), when attaching a non-default domain
 - pci_dev_reset_iommu_prepare(), when attaching the group->blocking_domain

A driver uses the given old_domain to clean up the device's state in that
domain. However, a deferred device has no state in the group->domain, since
the driver has never attached the device to it. So, the driver would end up
cleaning up a state that does not exist.

In practice, the first path is unlikely, since it requires the device to be
attached to a non-default domain before its first DMA mapping. The second
path is reachable when an ATS supported device gets reset before its first
DMA mapping.

Pass in a NULL old_domain on both paths for a deferred device.

Note that pci_dev_reset_iommu_done() can keep using the group->domain for
recovering the device, because pci_dev_reset_iommu_prepare() has unset the
attach_deferred flag.

This will be needed for the SMMUv3 driver to support the kdump mode, where
it relies on the given old_domain to unreference the invalidation entries
of a master.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcd..4585ffa9a73c9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2420,6 +2420,8 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 		if (new_domain == group->default_domain)
 			return 0;
 		dev->iommu->attach_deferred = 0;
+		/* The driver has never attached the device to old_domain */
+		old_domain = NULL;
 	}
 
 	ret = __iommu_attach_device(new_domain, dev, old_domain);
@@ -4059,8 +4061,13 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
 	/* Stage RID domain at blocking_domain while retaining group->domain */
 	if (group->domain != group->blocking_domain) {
+		struct iommu_domain *old_domain = group->domain;
+
+		/* The driver has never attached a deferred device */
+		if (pdev->dev.iommu->attach_deferred)
+			old_domain = NULL;
 		ret = __iommu_attach_device(group->blocking_domain, &pdev->dev,
-					    group->domain);
+					    old_domain);
 		if (ret) {
 			gdev->reset_depth--;
 			return ret;
-- 
2.43.0

