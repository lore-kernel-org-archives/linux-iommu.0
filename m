Received: from SVZP279CU002.outbound.protection.outlook.com (mail-norwaywestazon11020130.outbound.protection.outlook.com [52.101.180.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6702FD1B6
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.180.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051033; cv=fail; b=sVtvNDJSWb18vX7id4ns+jHO7SBOPctlR1uFi0Z0E+xmwbZUmqYmDAU5lYDOLxaS7BtgqTewFJMOcMwa89A5RXI4ESUptTNt0bCXtfO5nGbVWIb8Py11WitqUlEy+zG2OTvf6WgZhjWtQNVTE7eW8nMK/GojN8TiDuiJC5k6kQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051033; c=relaxed/simple;
	bh=NjuMnR87/OpXQ2hN53OIRaAIdutwoH6d+iRgSwe4gAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ue3hRDNryAKrYS8fUpaL++QWufa2Kb7Dx8alf2N7bhbasMhM+5U+UUmjk4SaST1FjBoPkoBmvm/FnojQc43dbUYIO0+/bUPk12chJgvs7YJLvEHGSJmjZ7y4qAr88XH27k2Y5WLXTf3l2/G9Ftim9ke6EFPT6RJetZEqk3RDQOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=r5cJJEyI; arc=fail smtp.client-ip=52.101.180.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="r5cJJEyI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh/3gI4nbI7M7klrdXwxsXlTmTF9Ba0enZH+Ga5F079+kPOkJTv63+yR21SfvkQVj0mq7Xfgl9AcuDqCrtQ4rH4E4aaurIiEZJStnsq9hYI2VOz2NjnooS+1V+P/H+1zGEOSxNBcAbqreYsu8izsSXkDnQsUp4wax09ifigEFyUE44eM1XNxigqmyQINMlsCV/Jo0FBn+mTFCGSgFY+SspG9ZP8icHmGTXvDq3f0An7bVyFRW55lduyvvfDrUlHIksYPIDPH4YkgRzJi3yPRYxTqmJzRGVusV3HIA7QctK3lB3hOjHTF4UlT/+qCFpD1pI5B03dJtSPRbpaq+RyrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZeL/czZJS1tAsSdl0OlvVoI4Cu3FZDl7gZSwzbbxv0=;
 b=rTxNMy1hTA0fqBxZoQLx071K9MzeqxXYFHAi6XCtlZxUIP2/I3qeGrHpq4FANrYjBJCNsps8ZIy/vJBoB0bKj6Ym/mTNfu4NCFu4ZSlz/EaVIj2MFH9xIqGg8KBC7kFFjxQ4nKRJYDM8QdUqP0LKQMCLOGUyktSr+Dlzi+j5wTbSSw41+0JQ+VJ2819NZkdfbw4jFSAYg5UwhY1ADL8Ee++D6OruLg/7oIAVoD0uxbBzuRdgcA5B1hQdLaejYXhBTFrug6uB1KkQdh6l9Ao+eYTalnstYWLafCKC3GaHn5uIGNgX5pV8LLo0HCRQnDGsHZpBi1J1f24UW+ZYJhGgKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZeL/czZJS1tAsSdl0OlvVoI4Cu3FZDl7gZSwzbbxv0=;
 b=r5cJJEyIW6O5mupVG2OQxX17O9Kqm6OyqJI6qsyYY6zQrWxEkkTIFzKjKlHd/YvWKdSH81w5yYCMpDkv9wH6Z7QisClr5/10hXeDZzDWGTzeZo6Fbqnp9zVjFRDg81lOz3GQRwy6xgrhDFaAJnu8TFFpOfwViDseoKPDa1G4/Ax1Qa4sOsqfRzcR7RG+CM4OyzegWttTvAPffmrTlIQ8kSi95No7cefKDlwh8MqXnl9X2KC4Ub0P4/SbxYyb9p7IbRiDc6rvUHq6v2pL3NG2MeARDiI6De1mijoBE5ICGsbZsxIgqHVvQ2h315qRjAP5jyPvM7R47euNRqpNgc/P2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS5P279MB1039.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:56::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.23; Wed, 25 Feb 2026 20:23:45 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:23:45 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dhsrivas@amd.com,
	Magnus Kalland <magnus@dolphinics.com>
Subject: [PATCH v3 1/3] iommu/amd: Use raw spinlock for interrupt remapping tables
Date: Wed, 25 Feb 2026 21:23:28 +0100
Message-ID: <20260225202330.23027-2-magnus@dolphinics.com>
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
X-MS-Office365-Filtering-Correlation-Id: f3763076-b99a-44ae-925e-08de74abc671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	Vu5N+ARQstrQsh2NrcghOqDpYbFhQQYDiEQQD/DPFQVg8RmWo6wTcpVMw73CyskfJAMBzZKElxxXmhu3jZ087tWyTXWGvq46mhuoabpXCNKWD71zKyguJsrha8NYOhEWnTRB2v6K6i9PnelWxorhd5BHTbISnMRlExplzxMR97O1kaA6+GlosRW5ZzW2IELMAOAHqUGwzKiu/XokpAbfHtWVIADF7dyexebwKSskCPGJrgIJ2FVuy8bV31M8/Y36572yvUAC2BAxaC6GIsbUgf0ucMBHpKo15rMn2gCmQMUTPQQSC1rnwppKLnnp2wFGHE6z0oSUNebUA4qwVG0uQMC91rydIUC0CgYhLKlrGgwOy33JoCDNl8LtcXApS3rx9SUgNh4Ns6zvsz/Q5je+W68IPWVxXUO+UYFSlswoHRr/Ck8nV7fQyjopYvpSNgQDFRjC1CxI2U+aXbgqeJUb60hSx78bT0z5muUErg/KUC2tGi81pfwu1cl4XmydBP0i3JAlY75dVa0yILd2tPuLsP0GqOc3DjQuOAt9jiYHY6vKqbLYnkaGKhyWYaWEzxGOOwUnVDFGZ3BeqLsEB2FqNqbVQ5jrAQ6qNt+Yx4vljJrsde/MrtUaCrnwKtS5/x94UrCtcqwkhkhB4Q55dDWOpT4gcoXoGTPOGo3Dm99ThZH+Ef/EXS9nKpCljN9EYLzcPmvQUwjflCfSHzpGeQ4Z5BD2LQIR69g9M8hszlME+2M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yG61uAhNxPJi+XshXTMRxZtJku1MQKIY14KMGh7r2zorGrnOp7MqZcyliEnH?=
 =?us-ascii?Q?6PG3cl6vD+FEA3CpncFxUN7+lDyYjEfmSXV1VqR0yYPwUBqyg7I6V83NtKns?=
 =?us-ascii?Q?x0ZuTZF09gV8eI/xjl6iEQl+CRT07JlXDwtYvAjF0ficV49JEoRWsoHF8BGA?=
 =?us-ascii?Q?b11PikpL83Jn9vN+xvq+0lH9IcgzqlFsjaG8APx6FH8jY0+v577z/UqxOfTx?=
 =?us-ascii?Q?B105N45l4cs/0kJ/1UEWbw1GsctIybByfA9pYPxK3G/djWew14FqxQlq961n?=
 =?us-ascii?Q?NfMGhOsSSMDl51u4XyG7Kr1coAYUr4rDwHizfg8V4VbORrLVoDF1trOHCrNN?=
 =?us-ascii?Q?zMrOjWFAmWlKE25IDElux01VnEs435JBX9IrlPb9NBbXy0EWA70IhT0eQLhA?=
 =?us-ascii?Q?GkTAr9VvGkNqh2WRIVlRd1fgqf5zxgjuL9aZGnKizG/j3GJG8EkRkdT49Tj6?=
 =?us-ascii?Q?m8P2LNwShrFCnfpgBiDjbxFsjQLPogXT9xW/HUlghIh9F9iQJ+uyGyGH3iNm?=
 =?us-ascii?Q?0/Ax03PiIvm8hv5OFyvX0CzV+3nMZLxhUOJP5QV7jlVpc+cL397YvoZHaDA6?=
 =?us-ascii?Q?9aiSYv9amgwthGo0klr15w8EQdRAd9Gi6nWVYm/+gmXxPA/dblPJukOCURBf?=
 =?us-ascii?Q?OTouO9gt2Ts4kLSa75oQCGd/4RtAnGBu8vq0iM7kpKUfEGMgB2DuMwn5bPhH?=
 =?us-ascii?Q?oFRf0Zm6s9YJODj5AMkbFdOsI5IwHEQrBVsw7YOp3TNhFo8W40R+BGcN/0+H?=
 =?us-ascii?Q?JH6I78LBo7zp2Ztu22xgjR44zKS12IM3n7QFe9iRM+ZUlplBcjUth9wQynfb?=
 =?us-ascii?Q?MkYujGLbWYTE0xTcHKMH/kbJatm0F/ODh6v/NWa65rO1Ngo9C9AUCemxkjlb?=
 =?us-ascii?Q?oX9sMHyHW2nKvNvOAL39SOAK5iQreeEHmdBEEyoYkK+w7cOt8nPZoFYNVt91?=
 =?us-ascii?Q?HKFXXXO9PbW8txnotwoDz8DVEjie9I4heZRyEg2Lbfdo8//BttB8QRpbKzmV?=
 =?us-ascii?Q?o1gnkbJqJWeaSVrdWcjQUwvS7rtN+mvQskN5pfpyLjKrbMlfPRHYYiTFF4Cb?=
 =?us-ascii?Q?5ZG+AtPIDW1dG5Rd/BIM/H9UfMwWH3wcbQsooIjkPo6dhl8TaH0P5yp/Il2k?=
 =?us-ascii?Q?NXVsmEvSScCiUcWTf606LcQ8qOrLwGgMkafk4Z0905VCghjeGvcTW+KTLyhh?=
 =?us-ascii?Q?xByENRm1VaAw6AdBKdwXxUmdd3VNEXOpz0+TYkXMcQeOmkaD91qJS9kzXsMf?=
 =?us-ascii?Q?YwjF/7EZlOYKIYSDFl+D79X+bKEcEHhQjbKJZZ/khbHhaGxkYsj3Cd7K3bWJ?=
 =?us-ascii?Q?im39//J/TUK9inTzdwAX4UGwY1RCdvAJhJ5lXkzvXpRJMyyTsMU5U0v5Knu8?=
 =?us-ascii?Q?/ycTIMZyOi1Q4G9OM19cgTfUdNZDfZaiTCDkKMZarJYa7upXjXQ6qWTOL8vh?=
 =?us-ascii?Q?dSETOzN9aYlXaa1gNy0DF54JxEX7IfTFxTgaGQLewpOmuxmtATX1T6ejZaXt?=
 =?us-ascii?Q?53uyBHL5fdsrc3QiMu/ZYwm/rkLrTfse2BATU68VjJjl9pif2aoNqBy79gMw?=
 =?us-ascii?Q?MCnWkmIvaMeEybPMew3Bo1d7Bux+XOxf+LHZFpYWMzWnJxHPA5tZ8i22AxiU?=
 =?us-ascii?Q?RuS/0/wuzsClasw09VGcNpAmW/cH2kUGfdrIaoGEJ+bKGdpwjDVanVeM5ZOa?=
 =?us-ascii?Q?6od0IJ0dbQ0ZgvtPbIwHFDR0qgRXGIJC1vS362rUf8fgjfdk5d7j/LeP4S4v?=
 =?us-ascii?Q?VmBcQ2550qqyAGz+gYrPEzOb54eKAMFYiQauT82NsBn6T1Phzy80o+hjUYn+?=
X-MS-Exchange-AntiSpam-MessageData-1: FC+no3hnKjUtog==
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3763076-b99a-44ae-925e-08de74abc671
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:23:45.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhJXgPlvAzAFo7WK0oaTzG/UCyunEUPahE9hhL4TIlk237bR4C0Jy8X7CLyeTjJuYmQ46iZUDmyzZnvtqv0BDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS5P279MB1039

Use raw spinlock for interrupt remapping tables since
iommu_flush_irt_and_complete is called under a raw spinlock.

Signed-off-by: Magnus Kalland <magnus@dolphinics.com>

---
 drivers/iommu/amd/iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..f3193c6428c9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3164,7 +3164,8 @@ const struct iommu_ops amd_iommu_ops = {
  *****************************************************************************/
 
 static struct irq_chip amd_ir_chip;
-static DEFINE_SPINLOCK(iommu_table_lock);
+static DEFINE_RAW_SPINLOCK(iommu_table_lock);
+
 
 static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 {
@@ -3310,7 +3311,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u16 alias;
 
-	spin_lock_irqsave(&iommu_table_lock, flags);
+	raw_spin_lock_irqsave(&iommu_table_lock, flags);
 
 	pci_seg = iommu->pci_seg;
 	table = pci_seg->irq_lookup_table[devid];
@@ -3323,14 +3324,14 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 		set_remap_table_entry(iommu, devid, table);
 		goto out_wait;
 	}
-	spin_unlock_irqrestore(&iommu_table_lock, flags);
+	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	/* Nothing there yet, allocate new irq remapping table */
 	new_table = __alloc_irq_table(nid, get_irq_table_size(max_irqs));
 	if (!new_table)
 		return NULL;
 
-	spin_lock_irqsave(&iommu_table_lock, flags);
+	raw_spin_lock_irqsave(&iommu_table_lock, flags);
 
 	table = pci_seg->irq_lookup_table[devid];
 	if (table)
@@ -3358,7 +3359,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	iommu_completion_wait(iommu);
 
 out_unlock:
-	spin_unlock_irqrestore(&iommu_table_lock, flags);
+	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	if (new_table) {
 		iommu_free_pages(new_table->table);
-- 
2.43.0

