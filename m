Received: from SVZP279CU002.outbound.protection.outlook.com (mail-norwaywestazon11020130.outbound.protection.outlook.com [52.101.180.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74230C61B
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.180.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051036; cv=fail; b=NKH5AODwGmp+y6+x4BUrSDUUPFFezbrsprp+Q8taP3jZPIb48Hh+7aW4XgSSx8ijrHAsh6hlKMl7R7ppyLJmWv9OiCeRkVyFEc53PoIHK5atVeAIqjzrqWDARUFwXQbM/J2BnKX3NKdPJ975QeGB11txOCkN8zqgL+Ssmw8swa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051036; c=relaxed/simple;
	bh=h3XTxdJHnEXxK43BW2PY8HlvNru6C5VpLLfX5ItlROU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVKcw1/b8A7sl4VkNMXE0XH7qBLnjrHlfgJMCzcX1voLsMp7yOcMxcoK7CWXqDl89tki+5HQSyv5aYRMiRkaKtD7vl0UvE+/QorZdYKqh0S/EBME3kSkSeCigePWIWyzpfv40+Avw0FK2e3NfWm7NOvzmMqoVbYBasaXsfh2MLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=PBtg/wXt; arc=fail smtp.client-ip=52.101.180.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="PBtg/wXt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIH2b1R9wSuIg4qmdDOynPbxMJjlQ/uwUCl3vU/HMQGIhc28glIvxGANQbUZ8Nsf8Ea7nzqH3bP04gEZ6r19KGkLx3CvjQYdxlsfB10sixZtR2S081efPT3JL+lIFp0jw8h5WAitscb6baIBCapMF1wO0t8V1wckss7f/EpvJcwLruyRp7TktxU0x4fEJyX6TrZHsaW98NMWZCGIXEuHEEQ6LVZzUT9Y3kMpBcd1qZo9K5IeXOX6f8yPWOi5HBPj/xff4pL8LSXnp6ij+OQEFaZj6VWb3Gn2CX/Z+8yCg2jEUWgKjf54+HY8hgV2SfEKs9RQC03iZy7+lqkIa99tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6etFIiMllfRhkM+Pu4GgcEgd71w+oLRDTAR19fWzU5Q=;
 b=Frk0kZr21xJt8ORAt1LY/IcTQ4VxeVuxTsbYBgq/KEqKQPc1PdPmKCMSTWyDY30eNsVc/QhrsgDLfJgoaz4YIJWEpbXz0Bh3PpapXEQI4RSaeMpag7E2EA5gjdeCOqCz4y4Ur6L4bSPDRVQ72fuqBumcPSrj4sgM2/8lxLpGkaawkJ88EQL1SWmNujbhcr8EICcvPB+YnRP+qa/eh5QR51iE5kPdKu5RtuJC7Am6VOmfYytkP7IVV9gIMWKHMMcVyHz94RO8C4znKWiuOqARST+heH4roPAHAtURiXzRc4YX/hl2AWyO91ipJtks/LLYGKlh+CvxDVvNKCkJJ5fbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6etFIiMllfRhkM+Pu4GgcEgd71w+oLRDTAR19fWzU5Q=;
 b=PBtg/wXt+0cZb5JmNiGXK4QhCsItl6JZwQ/l8PPSAZJzxMtJYRlX0+Y6JqUtpPlgJZzbLje+YRHeuPKoDFpmR57AHsOe6b3Drc7i5Ry1bFi+yDE+QCFteugTn7/A5XOQsjDKUOreK6FiYSF+Ov8sliVa1ATUzfSw93VJBjq5D4/gYYn7OblJQ1JUUS0dU2WAO0hz8OY97tibRG2E7EZsQR4w1FtMK8NojmwpA3DjuLteLP0RBei3CWe3v81bVhvlOZjt0Y0EkPikKPUvZN4D9yr1O5JAGCPU1109uqY3NOutZYcGN1Rc9be+mfquXi5PAPJYk03CGpk+hevFMOIApg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS5P279MB1039.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:56::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.23; Wed, 25 Feb 2026 20:23:47 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:23:47 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dhsrivas@amd.com,
	Magnus Kalland <magnus@dolphinics.com>
Subject: [PATCH v3 2/3] iommu/amd: Track PCIe DMA aliases in set_remap_table_entry_alias
Date: Wed, 25 Feb 2026 21:23:29 +0100
Message-ID: <20260225202330.23027-3-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225202330.23027-1-magnus@dolphinics.com>
References: <20260225202330.23027-1-magnus@dolphinics.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0111.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3c::13) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OS5P279MB1039:EE_
X-MS-Office365-Filtering-Correlation-Id: b32a8d39-5f10-4416-5531-08de74abc7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	8/9/x6aT+/NQ1GGz8Mxw48DUqSVs+Y/JFS5GIQQzweBwdAi/hpy9MyIJuRh911tQWbhneN3/UR06/te2k07a0UueNEukEof+8pfs7tQ/BIPIjxQFsKf9dq5kArVFgYmdKxyAiWgGWpR6LLIB5oJhRp3xr5a9nKWvtupimh+WgvHDWLSbj7E700dzwGIZ91myaH/5kaYiCqoqFfZ6G8tpErsl8SizukaJ90Jt9kBCNgtFBLGRgoHO2LGl4MlhUaBYcgepp19nV6UJnNkfIEl97m2Lkq/7/6nxrET+DxFP258YvxdSN+ph1XBuea292PfcIeOznoUZEmPN3hDIQAV1ogQGW5993H/QkTHNVYPv21cAKkEDu/8QsAbkmzRIVXyah894a5FAhGu1wGTcD7dPtKIb+4W7Iy5SGxUiqldxfLiRFJAbN4WteucOq2ViJoLfRr3A0b2qbfwDIhjBUeOBUdOkpndMuGYtvp0K+2TPB8u2m2Hx8wMuvKVl/1AuBEycpbpD49YfBUrq6I8lhYp1PTGLoh5YBz4YF0qLMOsxLwovSt2SuNTNvRXAV07bfkX5a5EJSZjABqcibswDQ6DRK2tftLD6sJ0Ll4oa7nG3XqLNQz86aCA4EwI9JgdCJIdPugbS6980xGR8Wq2ZWzEk54yIwc2miEW4TNmE2xRHWmP92NQ+X17whs7nBh5dXsU+IuMiGwF9Cq/tEXIf7v+nJrdh1dTTO8PAOALCErHkmOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3FcUfs+RKvOH5XATsKrBjE+9VbdAlI9gXhauUwLvHeAFfBNXU6EUQq1oVMHl?=
 =?us-ascii?Q?nLliA+UgxEpyq5q/+zEYlBJufc/pXUnYFRnl517hZjsSnm7V+eJIt8CxLamd?=
 =?us-ascii?Q?FwLLcLB4AYglEMREojr6YyGsuM3mhq3x7ACZZs02mekDApd82CbMALABFmh9?=
 =?us-ascii?Q?cIkUETpFVBfoeLCLM/d6/ZZGUc2iftKVuLTJEA8jLmHwkl9D+6ep+YAULLEE?=
 =?us-ascii?Q?KxHGWz8HMrgADE3uUtvmTtrPbL7tC7Y3m/c3Mjn80j6549T3EMYSZYlajOab?=
 =?us-ascii?Q?jf0FIgEi/04NS4LWYqvWZ/SNv0h1OWHPE3WFGqlE9qK6uBhT0TpF9HuSLhKi?=
 =?us-ascii?Q?rgPMBPv+5l7HahcEuR2Ux9v3TohqNN6UZ80AnmHlJgqKZuPc72+dO1ZIVkB1?=
 =?us-ascii?Q?IRbNGR0hTlg/H9MXyqEK0zTwbRf5zxPoriGRRUqYET5nHeoKOwOZTwOTUm/B?=
 =?us-ascii?Q?6XxuLEiZJ3a5tDd7ai40eUyxq3Jk7Dni3+jAhIovldA/NULLiiCMgTwLk3Xg?=
 =?us-ascii?Q?tFdwdOIheAEUuWsxb3zt8ViZr6tlDkd6dQsDaZrifvq97rD9A6ulFtaM3CtI?=
 =?us-ascii?Q?enW2v6oeJStMUbnZUp26zBLBSeCy0UoE5YfNubYcUTPnJ8jDymdR77LFdUja?=
 =?us-ascii?Q?XtPznSsnsQeJ3wwbfYH+Nk9RZzcKxHQH4nZ7PLhzFXmke1pKB7edeINYaaWC?=
 =?us-ascii?Q?EVMfmRRO0e5HbdLG/hL7PgZn7d2HTpy9m7e0TV3lInl6a8MhCDT6D9UXEdTs?=
 =?us-ascii?Q?q73kRCeWNOPq9FzPCKn5U09xF4bcojRb0JtJay6hjCwiHqiUi2kIEvlfxJjz?=
 =?us-ascii?Q?YpOOaDtxNMpomfy+lSw+7FCs45BJ3EFi+4gfNmwfTVR4WDkbASyXf2Uj2nhu?=
 =?us-ascii?Q?EIHWv29r4NhOpW6qSrphvgrdJwj1hJ/m8zqBEDZGly95h5MJHW904Mbpzw9O?=
 =?us-ascii?Q?yfLAcfBHe9L8g7La/fYSocTkVLGigsaxOfskb65v4qqKUn5JIb01sUjobUf8?=
 =?us-ascii?Q?gnpUOk3zqQynR0S1SLxSI8N3epStr20AhPzueyYJimPILMk7M8NNAZj8CLNG?=
 =?us-ascii?Q?iP9/NW0vzcdeMQfYhl/6H0v6sdNqvqRQfl4Z7n3UKIbj0KNN0xZLO193rZPs?=
 =?us-ascii?Q?PARZFRtsxAV5F/FWHqQ8pghwVXYSoyhzmwm/uKzwLgd7sedPYCUbAFNhOLU/?=
 =?us-ascii?Q?PvfSUCg8YOhzy7xS6CumwIUrLESqxCgUUsIoW93HNDAgJGHlt+0W90Q9Gzsy?=
 =?us-ascii?Q?u/Uof/QD1nAjY2AWg8vr345nxFcvDPjSFM1yUzC69aXc5arX3MW9y590sL1D?=
 =?us-ascii?Q?WXHdbUQZAOG1DvsIS2XpZzYlpITKyU4O+NvB5N1k0HnuLid2L+Cexoih45Oy?=
 =?us-ascii?Q?3sta6JDyAMwav4Ygxh2A6P6taYmA4PmGRiW8/StXHzb+0Bot/7y5jd6cz7LE?=
 =?us-ascii?Q?Jt7/swsoeAfwynDun8rr9IBhA3qL5j4QFDY7yA5RdJYqj55ca7WEmXxBdsVk?=
 =?us-ascii?Q?12GgNtstT57Y9Y2I2YCOdIumZH9rhPAvXYUUT0Nkzo8Gufh76fGuLl6cI+mY?=
 =?us-ascii?Q?hRRNoUi3C6L/odwvD7G7KE44sJ/oO2O9mK53ENILXgbX3/NHVaLdyF12jsfU?=
 =?us-ascii?Q?NaMo4EDC899F5uXN/UFlYG97NJXXwfs+lzCNqchdzEakfmq3hLZgZDi1571W?=
 =?us-ascii?Q?AlArgVCQzomkQ107YNjFn636Ic4Wca9onvO6FHJU6t6n5+vhqTnZ01ZfMBmF?=
 =?us-ascii?Q?fDXg0QnAH6KN69VIYAbr3nGd33wY0tLYhTPUKfhUfgJJwyxZMEW1Lbgij7C0?=
X-MS-Exchange-AntiSpam-MessageData-1: SCMeQ2ZUHSb7sA==
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32a8d39-5f10-4416-5531-08de74abc7ef
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:23:47.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89FG4V8DlsLMT3tHNvA3gHKATNDQTJNm1xImEv9h89+9r6SpOuRI9trIGNS8PYxgvLyFKk8l8FdCr30cvLW+RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS5P279MB1039

Track PCIe DMA aliases in set_remap_table_entry_alias so that we can
iterate over shared IRTs by alias in iommu_flush_irt_for_aliases.

Signed-off-by: Magnus Kalland <magnus@dolphinics.com>

---
 drivers/iommu/amd/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f3193c6428c9..5dec3502c8b3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3280,12 +3280,14 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 	struct irq_remap_table *table = data;
 	struct amd_iommu_pci_seg *pci_seg;
 	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
+	u16 devid = pci_dev_id(pdev);
 
 	if (!iommu)
 		return -EINVAL;
 
 	pci_seg = iommu->pci_seg;
 	pci_seg->irq_lookup_table[alias] = table;
+	pci_seg->alias_table[alias] = devid;
 	set_dte_irq_entry(iommu, alias, table);
 	iommu_flush_dte(pci_seg->rlookup_table[alias], alias);
 
-- 
2.43.0

