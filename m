Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A3612F
	for <iommu@lists.linux.dev>; Fri,  9 Sep 2022 19:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6porbBXNf7SjtzDuN3vIoWmSKJgQQwiME/8s5+SGSCd1+o/Lcf+M1Sh9JiHn1hTaJQ9w0pvCcKsO+fgVtdwoS62hlwknwfRkT+T7+NQszexfnpCU6Ms5hCvJki0zVrL3yWXJ7m/ge8Dz9ikvntwZsL+ErG7PaBNae1aAt9pew9hv0UJJxQimkFWvz/twVf2qPSg2SgnufVVKEhCVW0pW6iDBBL+UAcec7S+WVzmbj8ggQAeGy9Ux26dhQ/1WLrHyBJ07bEv1PhvxROTRcDtWjwMzKDB4ceMHphoOH0foplz8H+ABJRO/PNyUXWL3GBRLuhhQIh1q9ltUrGiLvJ9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPU41hhEedxFvY47jGOsoU/+L3pjQBcXpdHhKmImvTs=;
 b=FPUvwFGrnsDORLcDX/DmPZy0xpwCCy72d8xDXTylyUQyn/VP1HoqYuGfA668id8jqTrV7TkceOxE8ciMNBbTRonxMALFKGVFYTK6CXfYlkzS8nKBIradMV7G1yiPoTf7+Gif3F7npihfGMu2DVm6JoAhdrx6gU63XjOsSYdquFPGtNxubEKicB2ZgYduvIZHLvO+TwxvvKHBUFx1i53CKBI676DK87oC5NNZeMf61fhNtqBRuKIMzrbSWZUcUbg9U0gjthE+3b771LwRYAexLL33t4oP5jLVqAk/fm9Fqd3mIKCjryFtwx3vJ0XJrgNqc6O/I2yo5/kjRdTKGTrPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPU41hhEedxFvY47jGOsoU/+L3pjQBcXpdHhKmImvTs=;
 b=PcLMlGpfoNCfCqGbWCQn2WKF40s7usofYh5301euzOYMURRgFpcbNtxs11z9ygenR9UIR9cc5CR3FNy++D2pl3CbiaW+vPuO8NWIEm2yMKD5JBcz/JJlPiv39WvyQCCYKVZ7B6irC0rDI2ulFiEPSgqDg3ttpQehUngKkETGtrt63WyUZY19dbxPr9zfctqnhJ/E+BfrTQDjwD/gYr9eg7d99fIszwRNdB6wkttBxvnSAGDPtn1CcDx6Pf/81zcJKKo/ITyHCVKY0oM29QAsa+gMYJ/QHB8Yqt9w1TXr3Had+yWh5825+Hx7r6fdCn3RPYn+tF7envaZFcGC43o6og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 19:46:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 19:46:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH rc] iommu: Fix false ownership failure on AMD systems with PASID activated
Date: Fri,  9 Sep 2022 16:46:31 -0300
Message-Id: <0-v1-ea566e16b06b+811-amd_owner_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f5bb0b-78dd-4991-7f48-08da929c00fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	otJ0pzh9WNAA3hB7GZOcgp5iYeneAfQhv6CdxwgdDldWHpIzQqGbLkxWVnNcUlvwfw6PP/h6xJfT5xLw4p1bSg9HGOBwZmxOsuPDkqZqSLAV0My/tqKGjhrNBvmaL99oG1P5CcdPCvhyY5REl1benBEbllEbkjUFBhIyzfpLJlwJHzpLR383Y0FVRRdvwBIhQl3YgBP1HMxj4TBmUeWQcDXCSCJ0r0EQ6bBrbluLJkOkp0U+UPVImIiB3E13DtPHqhuyBjMcdea8ngUKFzmwxwFE+ktfeNSB6HsjxRYM63AO7si7lmXIbUdD5zSOK12cm8wJHSU2SqO2HGxaQjdKUYTjD0Dbt386RnAQuen1gxjA9kiXKa3HTCTDeygV+tdnxDEQD7TbNpYppUR4vo/GcTzjJSta/DjwQT/FIoCIWhQEjIRiMziLIST/2LW95XrL2kBke02S4ciLMsd4u/PZjixW3DUHD8kXPnH55iiSZxmORh5tzttruiISbo2m5Ce41rYqe8U/4njHjiov+TFL8oh2Y0i9lCVSZD1gwhDw68QcE8+hZ+SGmY9MaMxaRtKK8iFQkiWNU1OOs9AVeotvY3TrB/yEAa/cKsfkHbcPHu08h56vEOz9Zk5XBf7U64wVitqdtJlZ3pUKYKXHv8lm2gAGkJUkO/GcWhUGdkjhY4t6uT46LtpW7UGOUPRKLyYoxsN5xH3LkUscNOuZ2F1vpl9ZPs0WPMnGqWklC2kLz301d5NeopU5nHguWRxyGBLP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(316002)(38100700002)(41300700001)(36756003)(110136005)(2906002)(66556008)(478600001)(66946007)(83380400001)(26005)(8676002)(6486002)(66476007)(6506007)(86362001)(2616005)(8936002)(186003)(6666004)(5660300002)(6512007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+0mLvGiclebQrASmWeTsJ7HQzLTZ7YVW/GakHh94IzBzp1//eG4DarHQpYCm?=
 =?us-ascii?Q?CgYfpx6Wxi2MG2eIkaudEf69RmmZBpAUzmjOmM+0az/CKeL/VYJBSRSIFSaT?=
 =?us-ascii?Q?eVNtB8yik1jFG5ZtTRHqJWzebVJ8pGpVTedME9sSI6sB7P6+6njv/wP/20jz?=
 =?us-ascii?Q?ORnEPBEqKsB2KZ8WFM9g+n2U+Cu4v/MzcxG/e2ZglatLIm9cFWFv/Xdh6ua9?=
 =?us-ascii?Q?t/uNoPlxU43V3TGQv4s1b1RyNLZDgor8nseBj5xeBNLYKokPAB2TVJvRPeQe?=
 =?us-ascii?Q?d794gb2vseRuKdW4D3/vTmuB3IAUDE3tjSlMtZu+hTyhr283NoTwL9Pk0wLW?=
 =?us-ascii?Q?F6jEphH6aVSMennO459W7QtbXMsMypgb+KpMdExtmTvLaOpatZBYArnxo0PN?=
 =?us-ascii?Q?aCj9lKrWtw1e2knb6DtTHkAcOKY2mg3OhEbJaPiSrSBNgBsL+UhTa5TYUjyp?=
 =?us-ascii?Q?TYWatNU4t71F2wwuiCu58qnGQtOfrnpVsbfgmSMZjGc0Xz+ElZh6p52Z5nf7?=
 =?us-ascii?Q?gSB3LxyJ+HOkwuLatjM6RuWI0q1xkrhKhByVjHfpWX5UihUV+pNS6LP1uGMf?=
 =?us-ascii?Q?m/SnCEddrOd77OoBzdwKQOLwuEzx63podIQqvZbaT8FY2LEwLrB1RZK8nEgP?=
 =?us-ascii?Q?aT2Tmlo8Hiqfl2Pv7SBDUkerZfzdfweNaxON/Gxk4dZnm6PMvCxyOweeKaLM?=
 =?us-ascii?Q?TrnY8W9V1CAG/tiuaw12WmMz60EbYe6WHTzJTQYjvtG4AbMzhI/r6zj58rWU?=
 =?us-ascii?Q?D30EIHGhBGS+OHV2ziXDKLbFJELmh5dAvtH52PdFicYREFr2wAbeWiTCMJIx?=
 =?us-ascii?Q?Ammrhml8h1NqlAZDGtwWrdxRFxoz3vrtWvvtNpP2nI2cfa2appnkVjreihbk?=
 =?us-ascii?Q?K/RENqjLNP5PUTCOjhsWQYdnv4MBDbvzBc8nIgxNCAIcJrp//BF8OdpkjBYC?=
 =?us-ascii?Q?mbkHl3d9GJ/uh/E650IjdG7H2sFH5qvQobRG7QvjFVWcY97Ni7fcwgxwpXXm?=
 =?us-ascii?Q?LG3bq+I8J05fkEu0r/M0E/2rLPW8S3CfxBl92qzy/y4Jv1X/3cKb3dEM1sTY?=
 =?us-ascii?Q?uOD2Ur/X+tsCK5wM2+FLWYxHs4//AwgsN2rm38u/SyC0OrV2ThPZ5UOR5X7v?=
 =?us-ascii?Q?0zAbVRUm2aC74JyvmniO501ckUXZWbJlxzN17LwasGYUu8N4pCvnlIsHKtq1?=
 =?us-ascii?Q?B+9KbXUGxAL9kpIc0BJ12ZKX3LXcAEKFblZLLAUdVlU0GAbP8k7M05CgJFSr?=
 =?us-ascii?Q?XBwubJabGZuz1hnhxGD1HSuz1zZn6YThnSJssURgpSBsfg7gso9oR4mYk5LU?=
 =?us-ascii?Q?CYAeAPXx2ehPl/Cg5HImc1VIQ+X7RCVcAXpv0bcbIJPJMAe2s2GnW3dSm32o?=
 =?us-ascii?Q?cFTtf7Fd2Tv7vtMm677He5qesJaFJYDcZsxYNJKwy81wGVoi1lcKCjgORQCO?=
 =?us-ascii?Q?ucLJ6ydQOLMT5jidoDZvFX+XnkCyDfrIQb70LzOxFlewXsueF4lNQ1XL4pKU?=
 =?us-ascii?Q?P2LGFKGffnPkUgLkhrc32AR76gXlKRHs9pLarXKhhing1nM8bo6oY8iOn4Py?=
 =?us-ascii?Q?KK8Qgj6WEzLiqoaD1kH+EqWZzsLtbcvMcun+M+Ks?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f5bb0b-78dd-4991-7f48-08da929c00fc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 19:46:35.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVc88irpwTJFhkG2hbEAsrech7J60gJfhD2e20Cskd+mvEzkq+zKp56KjCg5qzLO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676

The AMD IOMMU driver cannot activate PASID mode on a RID without the RID's
translation being set to IDENTITY. Further it requires changing the RID's
page table layout from the normal v1 IOMMU_DOMAIN_IDENTITY layout to a
different v2 layout.

It does this by creating a new iommu_domain, configuring that domain for
v2 identity operation and then attaching it to the group, from within the
driver. This logic assumes the group is already set to the IDENTITY domain
and is being used by the DMA API.

However, since the ownership logic is based on the group's domain pointer
equaling the default domain to detect DMA API ownership, this causes it to
look like the group is not attached to the DMA API any more. This blocks
attaching drivers to any other devices in the group.

In a real system this manifests itself as the HD-audio devices on some AMD
platforms loosing their device drivers.

Work around this unique behavior of the AMD driver by checking for
equality of IDENTITY domains based on their type, not their pointer
value. This allows the AMD driver to have two IDENTITY domains for
internal purposes without breaking the check.

Have the AMD driver properly declare that the special domain it created is
actually an IDENTITY domain.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org
Fixes: 512881eacfa7 ("bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management")
Reported-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
--

Robin points out, and I agree, that this logic in the AMD driver is poorly
organized.

With the coming support for AMD's RID as PASID 0 it makes more sense to
eventually follow what the SMMU driver does and decouple the RID's
configuration from the iommu_domains. This flow would have the underlying
config to be upgraded from v1 to v2 and keep the same IDENTITY or
DMA/UNMANAGED domain attached unchanged.

---
 drivers/iommu/amd/iommu_v2.c |  2 ++
 drivers/iommu/iommu.c        | 21 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 696d5555be5794..6a1f02c62dffcc 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -777,6 +777,8 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	if (dev_state->domain == NULL)
 		goto out_free_states;
 
+	/* See iommu_is_default_domain() */
+	dev_state->domain->type = IOMMU_DOMAIN_IDENTITY;
 	amd_iommu_domain_direct_map(dev_state->domain);
 
 	ret = amd_iommu_domain_enable_v2(dev_state->domain, pasids);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cb83576b1877d5..21373cf6be748f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3137,6 +3137,24 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	return ret;
 }
 
+static bool iommu_is_default_domain(struct iommu_group *group)
+{
+	if (group->domain == group->default_domain)
+		return true;
+
+	/*
+	 * If the default domain was set to identity and it is still an identity
+	 * domain then we consider this a pass. This happens because of
+	 * amd_iommu_init_device() replacing the default idenity domain with an
+	 * identity domain that has a different configuration for AMDGPU.
+	 */
+	if (group->default_domain &&
+	    group->default_domain->type == IOMMU_DOMAIN_IDENTITY &&
+	    group->domain && group->domain->type == IOMMU_DOMAIN_IDENTITY)
+		return true;
+	return false;
+}
+
 /**
  * iommu_device_use_default_domain() - Device driver wants to handle device
  *                                     DMA through the kernel DMA API.
@@ -3155,8 +3173,7 @@ int iommu_device_use_default_domain(struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
-		if (group->domain != group->default_domain ||
-		    group->owner) {
+		if (group->owner || !iommu_is_default_domain(group)) {
 			ret = -EBUSY;
 			goto unlock_out;
 		}

base-commit: 848c62cb24a820066994d6cccc218dba58725ce9
-- 
2.37.3

