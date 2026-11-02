Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793603134;
	b=lXSIko/65wtVsybF711Tx2rKwORnaLzHU/Br5srV+FjEFI5C7dI9aWjaBBlPkd8IHp63
	 YwmydRcqy/oHbc5WkFIbPVur0iJN+4YkINnz84HOHT9m8gBmUfuHHWPoBjr8lNV/i6E9n
	 TqHurihCMbucazddMosMJrD8Izmp4gqwGWWW+AY++hzb3TfWGKMYPQVJk9PPKFzh4x6OQ
	 /CqANzdXn2LJ2ELinwiJSCeBKMa2fTcsKKUayeH6ozd0eoLWME1738axeuaznWt1ovqqo
	 5G5Cm0qVYbbMFx803ELVzS9LGJFpx9G6GuCIqeZnfa+z2+9iEAlJaqNwO9NH+vw2BTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603134;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=o+ZoyNOMx8oP7MmShum7zRu5VbjeMIABpxh6i6shGVk=;
	b=cP5Nd7H4O45PYmFYj3Ia1lmuGAPcr/j9AQi+5rWKzALHmjI6bUbabt6mqXyEGxNFfKZt
	 Whtzp2vEJV/K4bpIuKenCRbCPIssGjVoQ7uVzNfU0k2GgZX1fswrZKmE1m4l7yaJYrhSL
	 X6nPznVk3ehNKcA9utmo+vqZnbusHqbSBuYir6I177fcKEpLbpMucOVu8d/j/AtggyNns
	 pHi6PPDPszXd1UxGgGimXMew6RcimFS4Lh9EnYkhdbxcSsVzayKDEjoyHMAo2ywVPYhfV
	 IT6crnF3MRugvthPOvIyTi5TeVTC1VzoLm8EjXXj+aBlfZBDcFceOGTmtRhjIvK+mWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KYcusJzq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.71
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525D606A329
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 07:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2525D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KYcusJzq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkCsnsGhiNJ1hDy1ZPOUArCVHpw8sXYn5A40Mx91zO8IORQ1e4ujMWgvpErPooOJhJbD59I+UPjopqbYir+WVmzwXamfaBvHFNgqxwOEoieOBDfXJfujhB/dorrmqTFkcRECtysd7fegJmlOqGTs2J1ruX35LUGKTO5y+pP0Q9qQC1Y8LzrpBunHWlmSAhPAlcwfvDb1QM/W8zepup0GPsgGi4Sh21KmEdzM+s8Z+4Gf7WwY8vno6B80HOa7EA1hU+i/gJEeMA6uzfb5Jct7Wap9QPAA1WjiezMzSfjbOBuLwbrt/y9cqoxKJ0p3Q686pfc4QSmQ1G155+LEHT01Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+ZoyNOMx8oP7MmShum7zRu5VbjeMIABpxh6i6shGVk=;
 b=K3rWm985RRR0lcubfg2QFxevRRE2Jn6VQsIny2OGmorz4Ak+r0F+Kp0TK/R2usuLJ6bBcQ1r6ulmNY+ezhDyKGWFIKuyXiH4dccgynWBA0zBpZeBllAGRwILn9232HCzsuyJ6eNNlpAGuo4a/RY695JMn94Sn38vVIkAA25ppIG8ZQI39DDqa8MR7ggWiFZwJr5vONmPwETRbNenL4G6XePx6OOuKcwhXSiYlLLTwpGw0D2nHokqWZOjrXguXtoRBWFDPAO9pQNemPuKCOJYNckk5/saI+nvwVLPSvrs9Y+Rid42hEHj+EiIvVmMUphcmF52GJ1OVbsAAsRUf/oeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+ZoyNOMx8oP7MmShum7zRu5VbjeMIABpxh6i6shGVk=;
 b=KYcusJzqlRWMgpiP4EppxXfebR8Q/L8iYm0IAlSC/unRB4jmH+cIqn19QEWGUKiwG9kAcGhqpIh8y4LgVQy+0oF5SznTBzMimRzCWWbzg4FNOI2O19yEUV5LNmMmgLT+7PsmEAuK/SbkO+BwChnq2UbwOOB5b28exZDFhZP0wsSxAhcvGmSd4fLX4oWuxHkqO2JQP/cb83Qu+i63Og8SJNbh2xS7YCf3QKeZCPCTnyhCXIzllEGExOjJ54eEkuOlN1EFcuRDytO8QZKir/ul6VJfGR1fmDfXSvPlZlOeSpRXGvTQzoDd+vZltEib+YtsquDsHjMFmsfs/kQ464sVmA==
Received: from MW4PR04CA0350.namprd04.prod.outlook.com (2603:10b6:303:8a::25)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:05:27 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::72) by MW4PR04CA0350.outlook.office365.com
 (2603:10b6:303:8a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 07:05:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 07:05:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 23:05:12 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 23:05:11 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 23:05:11 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] iommu: Fix attach handle publication ordering
Date: Sun, 1 Nov 2026 23:04:34 -0800
Message-ID: <cover.1793602084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: fb37ce30-b99c-4eb9-d036-08df38afac37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|260925022911599003|260925021911599003|260925021311599003|5023799004|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261021130227099003|261021135927099003|261026121527099003|261026140227099003|261026130827099003|261022115727099003|261022105027099003|261022075727099003|261022113327099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	fCDqMsKdBEp1HfuJXYfq7A5X59jkzSmSjYRZJHtFQI2TDgEM5TdTmAMVB+3x2olIw3qL9QtWkZdVXF2F4HBlVOKi7PzQxiHauBsIytipG2eMga1ROGcC+7fLIzUatKlZ21xJJlQWEz0T2BXritFtO7gL4ExTalW7IUDKrj1bOWDEipTMD0HerhYLAMkk5cB+x+CStPeAmoUk/cHjVZG2uXpKV/+wJEasfVgo7beSF5ODjAHSIPP+9ArKt/X0Ej4XY9sLRaR9Xud2i1zfbtgRoQ18R9h26d6dV4co+qRahK8Vid0scVqO4bgFpvuMSX5pHI1gE4slNMo5alaRkzWcWHiylpx0aAZANEsAFVi7M45yg0S3KXFDzXsTYO9Bd/NV89XzDOp2mbagPEJGpxMeuzFnjmK331tSho+OVFyZ7MB4mvvjdjDHwqnNd6TOBDXPAmT1L+RZ0Nv2tFM9LcdK4iaUB4NZwixZwzVqG+EsoQuhdZXMYPH6E4QwbLIBVe0IWcj2WzEHvQwFL5v0uz3k5V+yM0Ih9HaKO163eWR+W32kx9QuMMfbPLOQ3mylnKRs2Pf3eQKMbgigzcyrR2+ghn8f5th1FIEDMzkB6DshterlPlXltt7K+6tZjOl5Is5v5LbyXr9Oa4y/spyDUNszzGGdPsjuIqWOdvlsOLkgWa/Jc7hxgqhiypX2PwH8eOQ0yMCP4/4ILENRs60UOvwl5g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(260925022911599003)(260925021911599003)(260925021311599003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021130227099003)(261021135927099003)(261026121527099003)(261026140227099003)(261026130827099003)(261022115727099003)(261022105027099003)(261022075727099003)(261022113327099003)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fusKBdNTS8pmRftr0aVECeqsRaj0JLsTyy4cWS85KYRwQhLqldhEHPTjMHE78Hpuy5BNoBw518f8aANSuETFAxoU6LNarhe0s+DATEDgSL5lvU4yvUVXSCIO3RUhZY9PKI4oLh23E8lLFuvoi+rSNinp11zT2nW8rHtbaUa34o8HDGVTPUdgrrF3VMxm5HD06J0iLjI6IxWft9sXon3p24pLh2ZHDnJiJfnT6rrjDMv6gSZDOA6Ise84Zk83YR0l20uPqZbSZhrW0L0EGBnXoJpPDsvjJOxb+wineXboxdLWEbOkB805d6x56n58nepEvO84938sblr6EehHPlZC8mdO6LOB6bue36YdSpp48PBzHHlrS+EJ3/8k0D6u24BQNG/NyHnSpOkWBo6Mz/lXedakEOT5mcZAbRF4bxagTg6vsdZ3JqBzW04t295vx0X+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:05:26.8736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb37ce30-b99c-4eb9-d036-08df38afac37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631

Jason pointed out an issue in the attach handle replacing path:
https://lore.kernel.org/linux-iommu/20260923233920.GJ2545495@nvidia.com/

When an attachment is detached or replaced, the IOMMU core can still leave
the outgoing attach handle published while calling into the driver. A fault
report looks up the handle without the group mutex, so it can find the old
handle after the driver's fault flush and just before the caller frees it.

Patches 1-4 unpublish the outgoing handle before calling into the driver,
for both group and PASID detach and replace operations. Both replace paths
store XA_ZERO_ENTRY to reserve the slot and restore the old entry on error.

This blocks new lookups, but does not retire a fault that already obtained
the old handle. The driver must still synchronize those readers before the
handle is freed.

Patch 5 rejects a same-domain replace in both of the replace APIs. Such a
replace skips the driver callback. So, nothing would ever flush the pending
faults before the caller frees the old handle.

This is on GitHub:
https://github.com/nicolinc/iommufd/commits/fix_iommu_attach_handle-v2

Changelog
v2
 * Rebase on v7.4-rc1
 * Drop "Assisted-by: LLM" tags
 * Add Reviewed-by from Kevin, Yi and Baolu
 * New patch: reject a same-domain replace in the attach handle APIs
v1
 https://lore.kernel.org/linux-iommu/cover.1790718296.git.nicolinc@nvidia.com/

Nicolin Chen (5):
  iommu: Unpublish the attach handle before the group detach callback
  iommu: Unpublish the attach handle before the PASID detach callback
  iommu: Unpublish the old attach handle before the group replace
    callback
  iommu: Unpublish the old attach handle before the PASID replace
    callback
  iommu: Reject a same-domain replace in the attach handle APIs

 drivers/iommu/iommu.c | 86 ++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 25 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

