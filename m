Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DE143C63
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507135; cv=fail; b=lq3KsMjyxfcQbNPMGUcS0kXPcggT5OT9f3cxEalaRmIQEa8cjlFOP9YXQDaD385vygUMPGml88F4x3aR8dbVPwrf+G3L5kmC6XBndi+6wV9hrTKJg6ZMUShAO4JU9fdOU6KDC58Y98sfFdj3mNC+Lqsi3qFNWvzYp+ZE5PZirkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507135; c=relaxed/simple;
	bh=rz7SwFwq7jjensCmduRsfPqJ7WSerRxdZTOASySlwmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kp/016qTtOc30ql6Jdq27rQ/mm4Cu7EGlf6cQjv/UjkPzH9rfWb+VVnn27o6gQ7Psdg7X3VIV8lmcwgttTlLO3KexbRYqTlSFO7eIlRLEenMR2HrNZ8gWqcF/V3SC1q3Dr1NigNUPvbz6hnBDOrOLFBCznAXzAbov6/yym/SkNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hGt2KyAY; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hGt2KyAY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbB3xQG+91imme3bmSsNWxdAyIg/DZdUYdZsJ7yeuIRiqvBecyOWce6q93a271Ea6spoyrypM2bn56mbMtd2kENB3T1E5UnFQ2RQslpkGOEwYg/jD46dK+edWqMcP67e0KwcrTaEjG4f9xu4cy1RtyW8BurVnkFfkEL3u3ZAni0bGNgg5FuzcjvfJhnqDTTC4yvyvcFuubR+SjfCEe+4vZaouq8+zf8K9ewvlnb9ighwB54Yp1CWvpkh4IOOdJLC7plgCtkY0o8tkz7WsqGaEFc9Au1MuqdnlX8U96yQnUG6aw5dpAqepwU2DmOnUbjKCdrpWb+lhpXBjLIAHVHsHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXb5vzhKyLudYQpsLsRnz4NHfmQ4HexomRt2R1L1KLI=;
 b=p4mwNh+NJ1Gw+knc9/WUCYGy2D3Wh6ydEWRSefvllBA778XrKP2hGscV2eZdkguSBWiaDKZ1XHVF+MQY+vfUfYsmjqVXXtmxJfcwAPkgZ2/QkGINi+yBNc7E+yhSxtDTBuz5vuic7rxv8CUuZ0PTIncqWXH1Go2p8fejKMe1vL3RuXbvJVQuQT7nowCfMkvkXE3pyXfuVfuXlFZDeYG17VPfNBEXjBFfF2KwKAFqgyd4nY5oNpFKHBlwfWB+EKMAId2ste3QtpLuTMNjS269Mg4aMM0cD2iQLgChGQuInTOcguYpl5DuNOV4tobEeJPQt1JXCbKwcb7sM+HV0PnI6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXb5vzhKyLudYQpsLsRnz4NHfmQ4HexomRt2R1L1KLI=;
 b=hGt2KyAYY+gOjeehYfupBAB2RtxlPVSsxg0We/+37P5sBR1XyW7WsYhGrCTzaLwTuCDhGvEtubm9vZU5UY3CEltiSm/jZ9W6d3dfKxra/QtsmVJILvH+e3IUtszXgJDZhvIqlt2dtSgywpLr1BVxuAHgPQxDeV67BuhYc3XforQ=
Received: from CH5PR05CA0002.namprd05.prod.outlook.com (2603:10b6:610:1f0::8)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 17:18:49 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::82) by CH5PR05CA0002.outlook.office365.com
 (2603:10b6:610:1f0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15 via Frontend
 Transport; Mon, 16 Sep 2024 17:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 17:18:49 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 12:18:32 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 1/6] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Mon, 16 Sep 2024 17:18:00 +0000
Message-ID: <20240916171805.324292-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: a250491f-c684-4a22-e4b2-08dcd673a175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URDTV6kLhhoDzq7T+EPreU9RW6sCngIphtlwJmCrPbSjlpPnzykq1uMB6qpL?=
 =?us-ascii?Q?1Kxi/msY2BXUvQudy4KASlROAtiE4uIOdBL7XJB9+YzVlJidHZtphvALnqF0?=
 =?us-ascii?Q?N+UZ7jnc7BwC/RsH/8whvS99EBaah1FSqi7DmbT2e4oFDCdwfgyF4XkNREH4?=
 =?us-ascii?Q?PhLeHIUo/y0FOXys6l3OvfGxLxNHZgt3c00qP9fPWalQbs0JY4WCm8yPmznZ?=
 =?us-ascii?Q?B52elnS24EgBxW+ye9mn+5Ai0Zm2MMyenDBZOHzkMe0F4Ut0dBce1EXpPK3h?=
 =?us-ascii?Q?4AuFd5X3YNez3kSYd/lByyjUqOhSBwdU8e5GJ/ub7tvphKoZHxhf0UNSwO6E?=
 =?us-ascii?Q?pK1vUaFiBkomixsytxAPKcgJ4YZt7ktWpUSJAEvBiR5UF34aOEwKu9DRhFRR?=
 =?us-ascii?Q?JW4kHIGZpZDzbA0ECl7onw4HgmI1HcYYO1JcLKRuDRAOuggP7mcbbyP0AN2p?=
 =?us-ascii?Q?ITSC2ElZb1X6XtbZdJOPqcn/fDg1VnTxWLWyKRLb6P6vfkIiOLSeKzTIoK8d?=
 =?us-ascii?Q?JQigYchzes0nf4KyaOVT63nMUU4xqkA2PUSk1TMU23ZCnYKp1F23oSnLMhhC?=
 =?us-ascii?Q?dCAs2v6e7cpwWc8Kk5dHHsUX1HiW8Y0sEbTXfiwy0jyXP8FpHpL1GXdMz6q6?=
 =?us-ascii?Q?FzoaUi+mj+8qz3jF9O7g7/nikXq022byl4mReaq7F8pTlR8knWGF/qDui4Yg?=
 =?us-ascii?Q?SptwX+4MKe+mWbXXAxLrAVbIVnzB4x7K5S3aXnqqM2B/X8C/LRfP8Qb8qXdB?=
 =?us-ascii?Q?doJiYg5mN4WnGgKMuoY2UuFRIDfwBx6ux4Wgmnwq4rZ27NHL3V+DkYlIo4Wc?=
 =?us-ascii?Q?TCpadkwwADBLx285nfrmkvTmud+RAQ4eI7nOBE4pXd7atIMTcUXS5j0bB+J9?=
 =?us-ascii?Q?comM8RshNvt8wztGqolLOOV0WWj3cqF+rPYoDqLfDZ8iM/wWB80i5U60kusD?=
 =?us-ascii?Q?/Co5e36KqA7x1TBe9lawOunynB5pb8HYqeQCOcIHOYV8EnNE99XODYiGJ+0R?=
 =?us-ascii?Q?3aaPyKjMRwFKBOL+DnRHZUrA0+n1mR+WnZ1C9gjIWEVbJ2nj5hdV6BqeBnCS?=
 =?us-ascii?Q?IRYQRKGwGHXw/UeLuNYdsrWTKpUER0+qPrsFDfvdGusg3TCjHevzxA0JgNwM?=
 =?us-ascii?Q?dfW3YtXQkWxAPPe8y+nnq9ixQ+gzvGeDHzx92aCbdX9nB7DdoCM04WAYR72Z?=
 =?us-ascii?Q?kggAPVWAX3BhIbN1KdXRmVcOB/l55JkDXVGD0Pv7Hxcl26JDYBLd3ypDFymS?=
 =?us-ascii?Q?jfTnilnXqZGljS0+vThh6hN3KS1xbwRBiM/F5X1fQgZPIdfUIW/BEUGKtW6n?=
 =?us-ascii?Q?9wxelOCnc87x+1+Qz0QLew9alhwcgwziXjhKAMcjChxVUymMki1DQFmPaBl9?=
 =?us-ascii?Q?EdofVfrnReVddmv3ZaYx5szgG6ZGqa+HC4d/kLVRUgHeMuiJAmsAYwJQ6B2e?=
 =?us-ascii?Q?XPEU0IJxDg8Q8mviHCjCE+TYFeHP8Zsq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 17:18:49.7427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a250491f-c684-4a22-e4b2-08dcd673a175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273

According to the AMD IOMMU spec, IOMMU hardware reads the entire DTE
in a single 256-bit transaction. It is recommended to update DTE using
128-bit operation followed by an INVALIDATE_DEVTAB_ENTYRY command when
the IV=1b or V=1b before the change.

According to the AMD BIOS and Kernel Developer's Guide (BDKG) dated back
to family 10h Processor [1], which is the first introduction of AMD IOMMU,
AMD processor always has CPUID Fn0000_0001_ECX[CMPXCHG16B]=1.
Therefore, it is safe to assume cmpxchg128 is available with all AMD
processor w/ IOMMU.

In addition, the CMPXCHG16B feature has already been checked separately
before enabling the GA, XT, and GAM modes. Consolidate the detection logic,
and fail the IOMMU initialization if the feature is not supported.

[1] https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/31116.pdf

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6b15ce09e78d..983c09898a10 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1762,13 +1762,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
-		/*
-		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
-		 * GAM also requires GA mode. Therefore, we need to
-		 * check cmpxchg16b support before enabling it.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_CX16) ||
-		    ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
+		/* GAM requires GA mode. */
+		if ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0)
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 		break;
 	case 0x11:
@@ -1778,13 +1773,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
-		/*
-		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
-		 * XT, GAM also requires GA mode. Therefore, we need to
-		 * check cmpxchg16b support before enabling them.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_CX16) ||
-		    ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0)) {
+		/* XT and GAM require GA mode. */
+		if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 			break;
 		}
@@ -3049,6 +3039,11 @@ static int __init early_amd_iommu_init(void)
 		return -EINVAL;
 	}
 
+	if (!boot_cpu_has(X86_FEATURE_CX16)) {
+		pr_err("Failed to initialize. The CMPXCHG16B feature is required.\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Validate checksum here so we don't need to do it when
 	 * we actually parse the table
-- 
2.34.1

