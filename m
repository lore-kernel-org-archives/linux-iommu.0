Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793846980;
	b=TctqvhLaFIBt3v+lBfkly4oxffS0vtlv3TrpX9JKq3HFWxLciGz+e7qpcEB6th8HnKg2
	 8JUFaov8qq/k2oHQdpziiwArQafYWVmxABpvW8ejxQ3CBEoN+wTKGidO+lsarjh2LH1vn
	 CJng/oR2GulaJo+T28HFiZMqa9BxDK/ruy2jGLDv+I/AeRa6a8e+V6FvvYya3sKef5po1
	 5Nz/hM/G+0P300nbrm5Tz0j40oE85FM5vMKN23vXKUG2RlYoXggpwirS9VbW71oG9KN7A
	 ycUooJGZK5Tyht8AQ4hV8xc4YfkB73+ke5aX/2JUODcImxlVjd+XmquSJGMp4vD39XA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846980;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Z+GO5+s2hkBJM9nfUVaNL+KpepUrs4oPTbXjyB5VyEM=;
	b=LIPqXoo4Y+uibPmPJ7Qqr/VixoCZWYFkW6vnO8Hx2wM2S5s5BT7L8fP65ENdSkOn8xWd
	 xfWeVreet8Huun+AtlXvvdaMw7UOkzaqMBm4C6UfyLe5KjoOcJ/4DPFVAK2mU0grcOM2R
	 AULy7KjSR0R0r/gA7z2v9blJcmguAA6bQ8FCdGLiQmJE9YhS9k3U63vqcAxEF9EB1hWIZ
	 LrG016STXL5ZzjJxiYjhIClhWgcKGZw7MwouCyt2VDpi5QSnh0YRSE2+PjvQTaNmxEaTv
	 +MSX4Puo/BA1XsYXhCXYaLmjcJdZs174EVQbnaETYWEb71z56sFo6zAhF/Izw+hTQ+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=GPbY03t9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.131
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020131.outbound.protection.outlook.com [52.101.229.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65779606D80B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 02:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65779606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=GPbY03t9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzXTVyVlCfZDB5LZZ1Jv9xi1uoOV9a6j8EnN6JMSmnUqPFsqlM5K6yYyjLMsfrsBmaP63m6aBGhqwHKfk0MSxR11TNQ0vIfFd4oV1tMWdk7OqJgJ1rTULqjyMd1TD7sTH/jg+3DtWt56icKqCtEFj4WyNgVdryPfliYDCB0fv1MInvS5V5Mu9+NPjID3Y8DmiY62a2/W7xc0j9EFOU+yLAPYq3paaQmup7FInnISCuir3gkM0ukFSIS+6Q21+FpcyKlS1vPSxRHgDqt3fjJbI/S2VVFFjuvkJYkTsVLORxX1tzfmI9iNTt5IurbMyK/wVG+bg5NmH6/AbEBW6AfHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+GO5+s2hkBJM9nfUVaNL+KpepUrs4oPTbXjyB5VyEM=;
 b=rha8PnWrBV/8DNiwowtFqi6G5Ld0RNfM1GS+hPovR0eah0JPXPdf9hpIhVr4e9HdIF7dUjygoKzUoRylAloks3eVQWF3B1FaZkfVHJsg8047Yp6YR0oHAzWm8PCcMOx1W8qTgu0M5Jdc1kIcsWhELWp8GZXRvlqPQwnh01tRFQEgVgGOTXsP17ninudPyn/jzRsvdVIhwIqEIS6MkFK0eLa3rIeZorWI6OeDx76HNGoccEzBn5Cc1HohI5nJI0DkoaidSC9DAHouRrHHOTmXRkWx9FIhyaf4fMyoMVzdjhD64iULBGfwaTh9HHI7wSLK87Zt09+UVVfvhakH/lGN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+GO5+s2hkBJM9nfUVaNL+KpepUrs4oPTbXjyB5VyEM=;
 b=GPbY03t9EJ8V1PC/ABg3SNGBaP7wMdqhjzklp/DKobUvM1vkddOJZullG08yAMTRXnAQq59SqrwunGf/rD4akXj6ZPfMgoiuHrM6DhjXbUoXDPbY4GKSX1IgDp91KypjslSeIgE+ANBo02aEy+Hrazhg5v2PldgDlASqFr18AfM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4001.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 02:49:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:49:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Magnus Damm <damm+renesas@opensource.se>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Marek Vasut <marek.vasut@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iommu/ipmmu-vmsa: Keep shared micro-TLBs enabled while in use
Date: Thu,  5 Nov 2026 11:49:10 +0900
Message-ID: <20261105024910.1879230-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105024910.1879230-1-den@valinux.co.jp>
References: <20261105024910.1879230-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0209.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4001:EE_
X-MS-Office365-Filtering-Correlation-Id: 95323af8-4c71-4db0-067a-08df3ae76cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	4RXs9XWZF7B+t6rszztGXvJi6msO7w8GH9AA0s89St1YVRsjJYuMKDXs8crokODnp3M44p9i+rFLYL0galY593mIwz5AbT84+JxLkjNTZ8j//q91biMrz+oOzS3eoXdA37scF+/3OSbbZUl15CFOi6n8gOiG5iAebC69jX9Ym1V/mSpSIo1/PPThW/4fet1Wf38ow0SNiyKh4vs0IwSvq+Cwrc2EzjFUEWjCWjqkvPC1LBVO+X+Fmug1LOQ1kIhrnfXdNAY9k1p1zGvi2jWc97W4cXjlAMl8++CR0PVjNcfKclJgZmuu1aeHr/s0mWB87NSlhNDEFRZzCwII0Uc3CNTS2uQ0tCtrBCXvKw3NhI7Ooj6cUniEjcrbab/TpsyaA1oJXj2L34Gdr67lBtoFvC9YXMrLrpWTVlGKDvdDdC0hlqdHHtelOBen8osTc6tHwu3AaJN/gFHouEr7T5spJJiHf31VF0nuvPqAfWllNg8gr2iMnPafducemqqfQePc369NZHmL29iHUO66jOttHutLgw836DNAngfiYSWKUVRjPeV0xSUkN5QtDxY2FmsPoZvooCWX3RnnIHZoiB+wGgjt5c19j1CxCtKZBhH2JFCD/JUZleHgtLIiLc4+b2jifYIPeic3o+U+dnFRti+N2ICXbmq5Z+gHEuPkwVcgv7g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/K0pvBpjiOcSR8q9wBhmq8y6GQNZ9loqoo1ITLHNQMECEwkekXp/GLIFVuIU?=
 =?us-ascii?Q?mhURdk/RJWTamda+NPd68rYtGLhVIF4u4PljlBbW8JOfkRjOdzH9xBu3nyFf?=
 =?us-ascii?Q?jvt+XXegvmS9aQB1VfR3RKBJvVEo5l4UhoWNpTW6f3QPyA/GsVeCeKY3T2nq?=
 =?us-ascii?Q?DPRj7RT4EsEPwd+c1aO/tqOUzYXV647lsFogkNdNR0Yk928Mceu2qDh86zRy?=
 =?us-ascii?Q?ChDR2WYfc5lhVF3I4rSRMf1IoyBqqyUKPqBKIvFtN46N2Ql9nvsW8n1fVQiM?=
 =?us-ascii?Q?yrC1GCy9fMHgGWcUrEnjqw1am+Vkz4mVacsoIaM/6ytnffxcnQNQ/f0p4Yu+?=
 =?us-ascii?Q?Q5e/QqwWkXQcOJHtl8aB2pjbzldqDJYxqOjzXeR2tqHAytqG8VWybuktwRAK?=
 =?us-ascii?Q?8xY5uSAy4tJQQyxdqunjD3Hy8TSTNpk7BunPRu68kvqKrJ1KvKP4DtfEXjCb?=
 =?us-ascii?Q?oLn+x9hYxTEZ3w7FuMqPtCGGXYKbEIu80JIKZ48LLldYOubDo9KoMY5ILv/M?=
 =?us-ascii?Q?P6pFXaYF4F0+68AYXszapiDjIkXSHQf512HnPlHJcT54l6xaz+pm4/L4IygJ?=
 =?us-ascii?Q?faOA/n/2SJGst42ri/XSbr2CnN/xUhxMEO3HX+cF5PpPEHA1d6ja0V7YaFC3?=
 =?us-ascii?Q?AdTocty3uFiWFVr0DKjVKJhzE8sfujKqmyyYT4qRvEMNaWEiQ9+tM1xjczAp?=
 =?us-ascii?Q?vdY/r7UdTlMUx//fvl7lJyE2nGh6z5t/6ml32C+ikOXlliErYTb1E/Pq4egY?=
 =?us-ascii?Q?iZU1JcRiDceVfztmlO2QJ3FDjSYHFTH4OsB9+L6B8FbrL9TSaQv72Ap+JErJ?=
 =?us-ascii?Q?99rZeBRUToiDiqUUioFqXS9dJZVnX5pm5U8ryo34ai5z+P1Cdxa6u/nFsSu/?=
 =?us-ascii?Q?OFLHhAxjz7tnhLo33NvZXWXvnEiI9ukUKXFDhTb3fqWsnC81ogzl2HEhv31j?=
 =?us-ascii?Q?8Zq/1Oge580wdnf5syhaRY8anTPiBf6gblWl2UthRYp9KmdACiMNuU/KZON/?=
 =?us-ascii?Q?1CpgrkpD6REjPZ5vTFnmcq5wG7I4uK4DuRLxiH/q3HsaN/XML7wsUIVZmS/x?=
 =?us-ascii?Q?U0H7eIcLQ+ffoLGfcXMdOsA1n4JNemVrkTulSjNWKGMkbtrbY9ZFoDqE99fd?=
 =?us-ascii?Q?on91xihKbh6hNBpP18PkiybafqeilaeqV9+gNRoIRvkzKyJwVaKJFP4pVw8W?=
 =?us-ascii?Q?uciXB0scXNss+WkZvFv+lFoBO03Z2MyYfmK24AVzODkEYNmuTzH51wh1GuAW?=
 =?us-ascii?Q?9wgYCPjJFNNZXURWdD9CcdoF/mlNkDBJ0ut+i2kJ2fjbjD6tapNQp2cc5E3i?=
 =?us-ascii?Q?Qy1PEbOjIzSCeGK94WD03ES0fOsaZoR4j9eT/IfvEvzgF3ZcLrDB7zkU4pQT?=
 =?us-ascii?Q?SQjgepJ+P6psHvb8qg2hLowdA7J1rWlx8mRq/rHiKM+/w3G/jNfM+IjdMOZm?=
 =?us-ascii?Q?S3IRIxnSXQPFeiWXIOMvMpr6V2RwZMP62zU7k3/jHEytw9YY4nukpLej4pPf?=
 =?us-ascii?Q?G17fOXH3JOWWRDH0qVWvwR0ld74ZVZqb27ApFMONWhvTMLjkxssWfTqFFzv4?=
 =?us-ascii?Q?JqlQwfdQ39DfK3p3V6ZhieSIEyaZQU6GiFqs8ahA7SHCv5BICbeHjaFTJlgr?=
 =?us-ascii?Q?oAjbE5Qy2hPPbsZIwhxyN1/fiEhOzebNa+m9R8namB2G/etkiijDq+mRyD78?=
 =?us-ascii?Q?PqJx9kEET+vrRIFN2WqmVRw3KgyKGdARWmfJ9fSPSF9BKe2H02AwCEipK2Vr?=
 =?us-ascii?Q?XSsc6HwQl5m9LCg6dhVAOIHBnKpqTDtO51zNp48Cv2qSHVhsoRm4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 95323af8-4c71-4db0-067a-08df3ae76cdf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:49:34.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWoD3gpMXPThqYBfbzCt9KBxgimx9qxoIrTxHHtgZQG8LULDWOp3b22tIw6BiK/JdnvG+NQr2jilWUufbr+f1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4001

PCI functions can share a micro-TLB. ipmmu_release_device() disables it
unconditionally, so removing one function makes DMA from the others
bypass translation even though they remain attached to a paging domain.

Leave micro-TLBs unchanged on device release, as other devices may still
use the domain. Instead, disable the micro-TLBs that still select its
context when that context is destroyed. Check the recorded context ID so
freeing an old domain does not disable a micro-TLB already switched to
another one.

Cc: stable@vger.kernel.org
Fixes: 24dfb197c3b7 ("iommu/ipmmu-vmsa: Call arm_iommu_release_mapping() in release path")
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Disable micro-TLBs still selecting a context when that context is
    destroyed, rather than reference-counting their users. (Robin)
  - Remove the per-device state and restore the original identity-attach
    behavior accordingly.

 drivers/iommu/ipmmu-vmsa.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 99586c68ef35..f13131916b7c 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -281,11 +281,6 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
 {
 	struct ipmmu_vmsa_device *mmu = domain->mmu;
 
-	/*
-	 * TODO: Reference-count the microTLB as several bus masters can be
-	 * connected to the same microTLB.
-	 */
-
 	/* TODO: What should we set the ASID to ? */
 	ipmmu_imuasid_write(mmu, utlb, 0);
 	/* TODO: Do we need to flush the microTLB ? */
@@ -466,9 +461,18 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 
 static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
 {
-	if (!domain->mmu)
+	struct ipmmu_vmsa_device *mmu = domain->mmu;
+	unsigned int i;
+
+	if (!mmu)
 		return;
 
+	/* Released devices may have left micro-TLBs selecting this context. */
+	for (i = 0; i < mmu->features->num_utlbs; i++) {
+		if (mmu->utlb_ctx[i] == domain->context_id)
+			ipmmu_utlb_disable(domain, i);
+	}
+
 	/*
 	 * Disable the context. Flush the TLB as required when modifying the
 	 * context registers.
@@ -477,7 +481,7 @@ static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
 	 */
 	ipmmu_ctx_write_all(domain, IMCTR, IMCTR_FLUSH);
 	ipmmu_tlb_sync(domain);
-	ipmmu_domain_free_context(domain->mmu->root, domain->context_id);
+	ipmmu_domain_free_context(mmu->root, domain->context_id);
 }
 
 /* -----------------------------------------------------------------------------
@@ -580,10 +584,6 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
-	/*
-	 * Free the domain resources. We assume that all devices have already
-	 * been detached.
-	 */
 	ipmmu_domain_destroy_context(domain);
 	free_io_pgtable_ops(domain->iop);
 	kfree(domain);
@@ -863,18 +863,8 @@ static void ipmmu_probe_finalize(struct device *dev)
 
 static void ipmmu_release_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
-	unsigned int i;
-
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		unsigned int utlb = fwspec->ids[i];
-
-		ipmmu_imuctr_write(mmu, utlb, 0);
-		mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
-	}
-
-	arm_iommu_release_mapping(mmu->mapping);
+	/* Micro-TLBs may be shared. Domain teardown handles their cleanup. */
+	arm_iommu_release_mapping(to_ipmmu(dev)->mapping);
 }
 
 static const struct iommu_ops ipmmu_ops = {
-- 
2.54.0

