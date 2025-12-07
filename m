Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AD2E88B6
	for <iommu@lists.linux.dev>; Sun,  7 Dec 2025 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765140608; cv=fail; b=nBT1drIK90UQs54pzO9kE6r5Slv1KD8qU+ysczKUBzp+gf1TYF1mrV39qA8zZYWY/VhLgy6rttRso8Z/rwKnOC7VOjYy0fLLrCo8Bs1YdP3GYu40IRXmFig3b/tfiGENYnLNb15TTqBgL90i+U7pBeQzRbO1nLkWTGiovMRkNZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765140608; c=relaxed/simple;
	bh=8dodyx9obWy4KsfYsSCB9aDs6g5GWy5eEbkPbgFpv/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbo+yW/BH8geS6DOcEAtWxBXaxOGhkjTaie+EOyoCuhawEwVKPWJDIAauHr+/njrM/xWasUHbuYpo2LAJZA0OcvcqqKlG3/ZEZi6CJ+PCzdpd7XMQ+24XeTY+KhgKdzz7kACe0Brf+Db5XtVaTK7vP7TBOCAuNF2b/E8CrKQGjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZKIqHm/; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZKIqHm/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rr2+HHKaQKz+R/GbZOK03IHnX48v4afWZlyeFqqJFV3lDtoq44LVst33zAo/MAtqh9SEGzZAicj0v/pXcdD8LMEmGzoUL/bgSOfIyOnmRUHfx9WsYh0IesIgOCL+ivZVm5eAn7YYHtZwIKAfNMpgYYri56N9MdTAglYVsRL47UoY5x3Pue6WWn4gGFe5Qv0iPdhWCKj3yFE7qFRv7kc6++50QfFw7HLj8P41gMzCZoykubEzm9IeNjXOQm2Po17cHEgd77JlOlOWcH594t6DdxL0H/j51BFO3/nRZgmAOenIKNGIlOat+3Skm+x9ERqHYLjoVDh/QmahhAPCUTtutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CbtspUDiU7Q8eO9YMWPlgGF5vNwEWOSpwEe9BsAZ8Q=;
 b=o43rtBK9TW/qjE8Bm6PN50No7EzomjsdViZltffyrnQkAmIwAeT69+3K2rK8BOyUjNmBo6pJbe8Zy+N2smmnt24SPI0ef5f8zmXPobT3ZSzuqHXfSB2i9d27/y1X2Bn9EJFz89My7iYrz3NhbaaErcT+HnAJsKlALDD7uTWd3bekJFhHabrDeVstNQ1udsWbJ3T6oVpgtbVNvS18wc4xKw66Q3+ONOTYg6TQ/40IUE8jeDVxaAsx1AZQPOpFxW7nLB/tMDIf0/6vWNUAFnsBGZNJRheKzC36p/kthprhwWLoXu3WQfqyTSnCTP5iMm4+m7IgAI1yt3JS6kljwDePzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CbtspUDiU7Q8eO9YMWPlgGF5vNwEWOSpwEe9BsAZ8Q=;
 b=CZKIqHm/1dqmmOoDDZTr+Q7Lj/jDcrfw6dK/qDoIBWGBPBcTK5KOS4fOPxP7YpWLP8QMwlAZXb3zEEGR0huas16hN/s72qxUmZ42rvmRRPh8l5mUMQ7lY41khi2cpHVnEd1zN4Rhb/UweouDJzZ2/SuRd2D+kURtz40kwXXKkuWnfBDvkCiXyZ3Wet30O7jMEpHmrOjnW9Q1bv6VxJwD9vY8KUAiWF8OZDPc9sWyp1nI5DJXBNegoXaM/NqhMC3+6NLAOeU0JyS8yJQQvZbAwkldXVQSEmlhqe8KZvYsTHi+BYy2n06dwLKe+h6hQvKuhA5RY7/0qn7P1Qe5+8JNeQ==
Received: from PH8PR02CA0032.namprd02.prod.outlook.com (2603:10b6:510:2da::11)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Sun, 7 Dec
 2025 20:49:59 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::a7) by PH8PR02CA0032.outlook.office365.com
 (2603:10b6:510:2da::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Sun,
 7 Dec 2025 20:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 7 Dec 2025 20:49:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 12:49:48 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 12:49:48 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 7 Dec 2025 12:49:47 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: [PATCH rc v2 3/4] iommu/arm-smmu-v3: Ignore STE EATS when computing the update sequence
Date: Sun, 7 Dec 2025 12:49:15 -0800
Message-ID: <b3586cb03317fb2362e936e4d303566851b506d4.1765140287.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765140287.git.nicolinc@nvidia.com>
References: <cover.1765140287.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: f5aed2d9-cb2f-4614-28b1-08de35d22f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m/9KFUEBbhkfWLt4kdlneEOzZaRnbftskIVErsjh0dDf1fCAf68rbU5fvsel?=
 =?us-ascii?Q?nYEtuIIU3lVnePaOVasKlZxcldE6uYRHEZzVDVp9rMVUhalDtq63EdgWFrPl?=
 =?us-ascii?Q?luIcKJTyr5nWzMP6Ga1eMo3EsNiq4Jl682v3kmZGQMv3ASwGCpm3uhx30ESC?=
 =?us-ascii?Q?SnYDStGFkAwWyEgn/jdVlVb/Aoz5pVgJV4wnmqHRhlcXWbYSl4tjd6NPluhv?=
 =?us-ascii?Q?Zma8gBlDv3nB5VytLExuPIgTvjZ+wPSyZzPUJvK/ar325OKhhKQqUH+J9Cn7?=
 =?us-ascii?Q?c7meEeuE8X3Sj5OGOGx0cD7qCMN5LpJsdeI4+COd1s9jGDxwP2//ORTBs2Z+?=
 =?us-ascii?Q?stcFbPmnTY6X+j2SRzSDYL/g/7mdRvsnCRN7ZxW5gwGMnVXakjC/96Qx8VsW?=
 =?us-ascii?Q?L55Myw3T04VecseiKC2rKHd/qPThEurgGYY34JCtmPddxSbwYxZCULU/2vlc?=
 =?us-ascii?Q?qZJ4LDd+XFu+2fsy8nLbDKZrQbOpki13Cp65Ja9VJVXc17IoZL5+ruAYDEFT?=
 =?us-ascii?Q?f08iLzL/llB0LGEAGtXk5KsDggalRqVMZVygUxlCZABYSuEg0cfmQMaui+Pm?=
 =?us-ascii?Q?ysy9DaLYc2RPcwGQ210Xj/m0Y1b8cER52+J17dlkJ/FUH5doT6+lPBiYsEun?=
 =?us-ascii?Q?M4Ebh6Y8wVw6SNtqkSluGNZS+YjIhGs5ZWa4FetdWxZaZbyNtvVFpzGJc3MO?=
 =?us-ascii?Q?DjYIcGzQb0w9paQQJZ3c64HeofqcaVQ5hskcotbJl4KDTS7kS0Fxa/7cdVCN?=
 =?us-ascii?Q?n9BsZy6T8/ToEHxYnET2pFG/coRNFoZIAWe5YrAdSbU558auj4dtO64JJnFu?=
 =?us-ascii?Q?uNcJY5QO63hlqi+29jAqfKV8fL3FzimbWyTkF9f+XFRRsmtyj1VgCNJfONVY?=
 =?us-ascii?Q?QpWGhOQyBxnBgGDFW75kNXZdJGwBDJlB9OpalPIEy/OpbYG3EHhN/DhbrN0R?=
 =?us-ascii?Q?+v/nc+jSjw9jjnWRWbcszhv+10n+HW1RNk2v937xVN7VQDx20keN9ablALVr?=
 =?us-ascii?Q?3CVWpW8VFjfYsW5ndlFsCT08NgA3Gi1wAXZerOFVL4I94YIgWKyqFdPJnAf4?=
 =?us-ascii?Q?Kphy+Nsu8yYX9pDApzBwe6AmaTZjvXq+t4kSBHXVBS6S+GcA/FJX0BLK05qf?=
 =?us-ascii?Q?FK8dLL3PGUcMdgvWIt5ZDMIIjKSBuTchGIwt63u81v4efbqbbwqa3jaeV9n9?=
 =?us-ascii?Q?YxjdLnFsPIix1/vdkXtw8Yw9bGI5Hb/Ku34+ROR3+D9dLyXujAZVMqinpvll?=
 =?us-ascii?Q?PMuAx55Ey2j0JST5vliHxHmKXpyIoQlUJ5LiuxraRt4lyk8IpxyCnHABYWrV?=
 =?us-ascii?Q?/SDcKulaFbTTneQ4cGwAOkQJk2G0A8JjbCCrMDQJ4QTeI3IjJwkOo6xcdFB1?=
 =?us-ascii?Q?zh1sHgmHbQ0eS5mdJyEi2cTcwoyn8GYmBq1jQwyK8AGFmhlWCXhz+DvKmFsL?=
 =?us-ascii?Q?Lnfv8dHNwuqCtKS76bjdGhIl0HUinyRs9VTutf68qZvG9c3vBXgxTM1Kd6LA?=
 =?us-ascii?Q?kqFcQ23ddleGbVsiVKY5qLmkXDYqCLI/h9tIZtdtgnd23p7MValPtavFT+ak?=
 =?us-ascii?Q?K6CNavxlJrlHrCGAtHE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 20:49:58.8472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5aed2d9-cb2f-4614-28b1-08de35d22f85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192

From: Jason Gunthorpe <jgg@nvidia.com>

If a VM wants to toggle EATS off at the same time as changing the CFG, the
hypervisor will see EATS change to 0 and insert a V=0 breaking update into
the STE even though the VM did not ask for that.

In bare metal, EATS is ignored by CFG=ABORT/BYPASS, which is why this does
not cause a problem until we have nested where CFG is always a variation of
S2 trans that does use EATS.

Relax the rules for EATS sequencing, we don't need it to be exact because
the enclosing code will always disable ATS at the PCI device if we are
changing EATS. This ensures there are no ATS transactions that can race
with an EATS change so we don't need to carefully sequence these bits.

Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3e161d8298d9..72ba41591fdb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1095,6 +1095,15 @@ void arm_smmu_get_ste_ignored(__le64 *ignored_bits)
 	 *  fault records even when MEV == 0.
 	 */
 	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
+
+	/*
+	 * EATS is used to reject and control the ATS behavior of the device. If
+	 * we are changing it away from 0 then we already trust the device to
+	 * use ATS properly and we have sequenced the device's ATS enable in PCI
+	 * config space to prevent it from issuing ATS while we are changing
+	 * EATS.
+	 */
+	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_ignored);
 
-- 
2.43.0

