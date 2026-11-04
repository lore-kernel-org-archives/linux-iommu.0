Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809391;
	b=BJ2legQ0SFYBVHAUe5RHVs0K0cwJcaD94JaedZjbLuW4ylkPyQsNcEeK8LEXVO9A8/dZ
	 xU8xcK+4HbIL9RQKs8fUuHpOSUYfTIjytdLDRoF4ee0/0z7VbNaDr7Xr0ZxiJb4E5RW+n
	 J1fV1ZS1Udonas8AAcfMlPNdunr4ibk32OBSqHRE39sBrDA24PZ1e/+wGCONiO6pqWiu9
	 AXuaHypdbi12ZJVMaNdAxIctidzge3KTf29fjPwB8iXiATalKefJAgvTA0hRIaTuhqR63
	 L3/KZTkMPXWXQRp5m+yJNb0oUz2Np3vg9lAi3ICJc7/mNRVbbGrU1r19JEPNd9Zsbdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809391;
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
	bh=pdlXHI2X6pdqRrHHvmjfrLyomme5qFfK4YpZ+ASEvLM=;
	b=zQO/0I3OteM/EXSMndTpIQ/daDwjd0iBeZpLwONlCKHJU74ncd05mpklxU08HLzdbm8j
	 maeJFxwJvA2tsJKBH/5QJggCtTsewT0j8T2m5tRm0OdK2LZJ4f8yZG9lmGL0Ke25whyXN
	 j+Vp7MySwNgy4U1zffSLgtuPvWTJ56oDwkdlvTrC5Tw3WVbw/MqVnvlS9WoalUo2H2ECS
	 2gQEy2yRPCZipBjxXBEpBpKaQ/UrEoNmSyaqZnKfBQhySqjmdnAPGjCQ6t99W95JK3kub
	 xtj3IiiP3qjehF15S89t9YZSfFRW/bzTAmOtkG/xjGK9+1B2YVtaSWBhhtPgnDO01mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=BMUqSMnD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.105
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021105.outbound.protection.outlook.com [40.107.74.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA2606A33F
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 16:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1EA2606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=BMUqSMnD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuQNYLkIFb0AFgw5PtN/LtHZrONN/LNoKI/2V/pj3iXoO2qLQkVGpvFBJWw+mY5Md2ThovClzspDkT4YzsyFDmvyp+CvTr9tqlkDo9Slw8gXyBdq59Ab4ljhFt7tn8vkMZtf9IASySbnHncAdGEqZWjjIew7T+L7oaETLqruBEOj0VnIu/35/mV99YnMJPHqsRng1il6B0OwlA+B7FLoaBzBo5fL5ZhyTXtxgI2QfL0Rt8HIDJwrwnUFQQiKpTtKImZ7h4hKNF4yjUxF2eUav0iIn/PBoxQFtqFM2jG43AjGOYrh+ZphTFlXZBuLwZXgqEpSPf9io51ZA3g7F0Im6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdlXHI2X6pdqRrHHvmjfrLyomme5qFfK4YpZ+ASEvLM=;
 b=S3RIBBoZOTVnI1SYlgqaoIPmU5V1Xj057E87La013/ooR97XEeuf3EN/tMNQiURHEbNfaWs2T90I7X91mTvOGEuC73mjFR9COhCsimKdD6tLW10sfy7n+IZ5nZBOIqeAY1SlWrnSv+AJoRr8j2hLxAkF2KW8r7TPRytd9WbZzszyAUF9Scs2l+a3N6JKeUzOsOV4TyENpQ3EX8gwYEKpsrSdYPUyoqmw/MxI5tfLMrvRdI9joX3zigmJkV4074D2GtS1Wi0zrjNkpMc8RD6uRpwvev+yuXg3BL01hdbnuIFkGpyWmaIIQAvkI5NrKif1O9i9TvQmVm8xk3vAZY2Yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdlXHI2X6pdqRrHHvmjfrLyomme5qFfK4YpZ+ASEvLM=;
 b=BMUqSMnD65W6WV6LKfK+/4/+8qmNYC/MeAybCfcwwLXyB2TdS1jMrHx8V3ogAqa524vTgGuFXyZk1VuK0dp2Fzb2INYs2v+AGqHV8Z4UNSainSzcoZEfwks6WvE8cB6gpe6YhesacY0XRY1g/q+Mrn2CUCT3uXaZH++QuiN7duI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSZP286MB1462.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 16:23:00 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:23:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Magnus Damm <damm+renesas@opensource.se>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Marek Vasut <marek.vasut@mailbox.org>,
	iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iommu/ipmmu-vmsa: Keep shared micro-TLBs enabled while in use
Date: Thu,  5 Nov 2026 01:22:51 +0900
Message-ID: <20261104162251.1749998-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104162251.1749998-1-den@valinux.co.jp>
References: <20261104162251.1749998-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0251.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSZP286MB1462:EE_
X-MS-Office365-Filtering-Correlation-Id: 5403297a-1b0e-4bc3-b133-08df3a8fe4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|366016|1800799024|261009223027099003|261021121427099003|56012099006|261021123027099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hYwBYZBOMFZ/GU2CIzVmAwKENm/gpOd0oC7oux6DQNEbyDrbXmgrnTfJq63L+BoxruSvTWGatHLBlBrHEtKXHUOBjsQ4rnlXJkUyQZ5jwq2Atee8Mvh/V8zFEocJxJ5+4RvQdxp38cKjWu9n8g1yXLxAc9CJ4NcsoSUJDDV244ufjju+gRkk7cEcPVyV7LbPlMzCCbHB2NVqIWXWMyny/GYavqbc4R6eyQT2g18G4sHdyg8s55J11pthbqNgG//zPv8LxxR94aOcTvgRGzN0Mkp07sBxCzJMZe0cExCmd+bhI1FP7hERfgd1FWnNKLYHA29Ue2HWPb2i7UF7l2V79bBmlZvMVZiXqbxKnBe6QmJCg5kHSxLckArjhQUDqhwxAnzlvhFTU2PHarPBX7QJyH8FIooXzA/dMgVFXFMfqjHVQcEU+8gF3OxD4UIgan0EgHgzUvL7X84ENnpTBmlAjjQbD36vMPlledeb41ccrifJFnfz3pkHnrNqMkSsYT8ZidAL4ohQqJvDkQKbAVDYA5xbih3AR+ulJLpk+qKLOrGiK6Zn8Xc4QjeBrbEnXrsVPfVxOirCaSVF74bPsEs8QJlGWbOugPl7P4LNyDpBiScYvu+vNbDJZd2lMJzMM5uos6jMMoDf26xLw59GWVkPllawh0UJrTHEsXcRhlbpmKg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(366016)(1800799024)(261009223027099003)(261021121427099003)(56012099006)(261021123027099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJZZboHc8Q3uwrD7S5kZN5bocsgw4UxSd/k/YqleLO760A2ivRW5/sUbftjA?=
 =?us-ascii?Q?gSFcuUYSAxT2M8+tj2qcMPHZr6nBXF3vtbpEBgCgtoFS4vyH7ZxQLy2wd0g7?=
 =?us-ascii?Q?AjWI1wORTOCMCeT77urqfjmbNm7gtTHdxicy/BSc6r2OGeWG9REvsIatzN2g?=
 =?us-ascii?Q?K0fez8TXhO4RE5NLe81WbEtPVX+dhN/Oa2bI9zzRIGdSDAW8Rv3pruYyrHlh?=
 =?us-ascii?Q?voPlMwp0g1bPuMVkN/zByKIjOkVs4wJ58V5TOZ/WJJk7a/Q5o3KQ406a4cYZ?=
 =?us-ascii?Q?LYmG+7nuEm0Rgwg78OQCXOt3xllrzPQ+TI/FzeMYnEwESUAWTMbbUYcaO2AA?=
 =?us-ascii?Q?n7dNqPehTS6wrMU3CyRpSYDD8A8mxOYxd/4me8xScm/h3JG6oIU4M2/aMn4A?=
 =?us-ascii?Q?zO4wugL8tj0eIigtlpEWFkc4H/+9cGT9vJqXcCVDV47By2UNO6lgDjSy6bJa?=
 =?us-ascii?Q?c6DW1Hi3cWFO44rlPwmPsaYMSBf2xS5ZDwIGcIoDGsIFhHwGVeS7UC2OkpPp?=
 =?us-ascii?Q?Ant+2JmdUxyNvbxLkHa+XR1PX99HXk3nwJCDk9v3L9cGGZow4M5Lv2TZ9y7b?=
 =?us-ascii?Q?2yIooiyZkdR7f3DYEES1vQ48hcSMJhChRBYIVPfH3L0/QTftlg81tB8mOEiu?=
 =?us-ascii?Q?WyMk2piSjHC02tmJHqXvR5vP7Z9Sp9xYbcTGjn6qEW1q+Gqm7JkD7cUJD65d?=
 =?us-ascii?Q?AqzBOlmigGpmXGgh9oHgk8ssXqSF1ZiaQ77m1kqSqNys0+fWGO4s3+SlBL2r?=
 =?us-ascii?Q?CmgRXQCggqkIyokQuyXAYf02zLk8wAOxmQnvh93zGCS4fdb/ULbakostjkyz?=
 =?us-ascii?Q?G6r4A4cJRU8/kr2KqRBEJm5p7wupP+cQQNlex3iiUGfTLoYpJ2mc/NiOqfna?=
 =?us-ascii?Q?Y7d4wv8Lq6SLTh8dSpVlP1t7QBa/sPVnPGaI5mbdOafU6Kyqy1nRFF7hazX7?=
 =?us-ascii?Q?isCmjBSMjBq91Z9TTz0FE3Ry2BCoKSD5NmJl0GIzTZi4bgkWx1Z6veUhMRgQ?=
 =?us-ascii?Q?Zl/FMYsGrv/F9Yxf00hQVUkhcLhyyyQpQioPm5B3wPlbmmVjtXBGr7O8u822?=
 =?us-ascii?Q?P3Owh9/O3VODpAIR+4BVeZT7BTzoJHwOVBgfX4dhsF2eUSzL/L38g/UxtLpy?=
 =?us-ascii?Q?2QvvvVtKePV/czNeP6aGV6racyV9k/N4RaZbjjFixZKoAGRcdbnnrnC9dAeY?=
 =?us-ascii?Q?3SknRtVYGpb3gsblAexxKXfKs0tMCV0BdkT6Ck+2LVFTsUFn+3jUtFUoAAKG?=
 =?us-ascii?Q?TNOe78JipAVqoLRnoZZv6/X2shuF7viGXu1UvGsKDeupTf6OLfmf8NDiJfBp?=
 =?us-ascii?Q?1lwd0DQF+chrfzLLFGXVAVinLwKUUCLRo0qorD18ZIaccPk0xB6OWxMidwgL?=
 =?us-ascii?Q?JcAB2QhQv56BBJYSCJS/qFkDKulSlsFYeGmNr9khQRwlJv0eK12EmbPsNpQc?=
 =?us-ascii?Q?PF8BkeG/PTxkyxny+7T12CM034nHzmJiriS4ubEgRt287NzWGzgMlmVQftpT?=
 =?us-ascii?Q?6fPHXBi74APAZcj89Yh+msoiD9UUeNRI2cXJa7Wfb970MYi5dL7mZdskylLc?=
 =?us-ascii?Q?ljKritA+uERMzdo/u0Wcb8dSFKlmhmXZbmqkzsFHxj+Lho4jsAmAgdT64Q6+?=
 =?us-ascii?Q?xqdZadi+PDgOzlDXxbGQSfvK4hyimVrGfR2NmDZnDlpRVIABGA0Yzs9+Ej4/?=
 =?us-ascii?Q?Z4B7MUvStex/hXWYQzTOqvnFHiVUEdBChYBSW8spbDxmHFCE9P5+O/0+H9+W?=
 =?us-ascii?Q?ZYSmWJRjHF9QE+HMRV/abwfMsyi7J7uZiJMdOWBlrqSCwUhGhizX?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5403297a-1b0e-4bc3-b133-08df3a8fe4d0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:23:00.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58ESAZUGF7ZYau/hsR0CbAQT8JPei0bLmLmcGnlFFeq6TD6YLXBmLEX2sp1I7YasmbbISTkud9PdmolNY1AB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1462

PCI functions can share a micro-TLB. ipmmu_release_device() disables it
unconditionally, so removing one function makes DMA from the others
bypass translation even though they remain attached to a paging domain.
Switching a device to the identity domain can disable a shared micro-TLB
in the same way.

Count the users of each micro-TLB and disable it only when its last user
leaves. Track whether each device holds a reference so paging-domain
switches do not add another one and release does not drop a reference
the device never acquired.

Cc: stable@vger.kernel.org
Fixes: 24dfb197c3b7 ("iommu/ipmmu-vmsa: Call arm_iommu_release_mapping() in release path")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/iommu/ipmmu-vmsa.c | 121 ++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index cea9348ac10d..bfbb6795ec13 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -59,14 +60,26 @@ struct ipmmu_vmsa_device {
 	struct ipmmu_vmsa_device *root;
 	const struct ipmmu_features *features;
 	unsigned int num_ctx;
-	spinlock_t lock;			/* Protects ctx and domains[] */
+	/* Protects ctx, domains[], utlb_ctx[] and utlb_users[] */
+	spinlock_t lock;
 	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
 	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
 	s8 utlb_ctx[IPMMU_UTLB_MAX];
+	unsigned int utlb_users[IPMMU_UTLB_MAX];
 
 	struct dma_iommu_mapping *mapping;
 };
 
+/*
+ * Per bus master (device) data. Several bus masters can be connected to the
+ * same microTLB, which stays enabled until the last translated master using it
+ * is gone (see ipmmu_vmsa_device.utlb_users[]).
+ */
+struct ipmmu_vmsa_master {
+	struct ipmmu_vmsa_device *mmu;
+	bool translated;		/* Counted in mmu->utlb_users[] */
+};
+
 struct ipmmu_vmsa_domain {
 	struct ipmmu_vmsa_device *mmu;
 	struct iommu_domain io_domain;
@@ -83,11 +96,18 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
 	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
 }
 
-static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
+static struct ipmmu_vmsa_master *to_master(struct device *dev)
 {
 	return dev_iommu_priv_get(dev);
 }
 
+static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
+{
+	struct ipmmu_vmsa_master *master = to_master(dev);
+
+	return master ? master->mmu : NULL;
+}
+
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
 
 /* -----------------------------------------------------------------------------
@@ -281,11 +301,6 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
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
@@ -297,15 +312,63 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
 /*
  * Disable MMU translation for the microTLB.
  */
-static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
+static void ipmmu_utlb_disable(struct ipmmu_vmsa_device *mmu,
 			       unsigned int utlb)
 {
-	struct ipmmu_vmsa_device *mmu = domain->mmu;
-
 	ipmmu_imuctr_write(mmu, utlb, 0);
 	mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
 }
 
+/*
+ * Enable this master's micro-TLBs using the domain's context.
+ *
+ * Several bus masters can be connected to the same microTLB, so count the
+ * masters translated through each of them. Moving a master from one paging
+ * domain to another keeps its reference and only updates the context selection.
+ */
+static void ipmmu_attach_utlbs(struct ipmmu_vmsa_domain *domain,
+			       struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct ipmmu_vmsa_master *master = to_master(dev);
+	struct ipmmu_vmsa_device *mmu = domain->mmu;
+	unsigned int i;
+
+	guard(spinlock_irqsave)(&mmu->lock);
+
+	for (i = 0; i < fwspec->num_ids; ++i) {
+		if (!master->translated)
+			mmu->utlb_users[fwspec->ids[i]]++;
+		ipmmu_utlb_enable(domain, fwspec->ids[i]);
+	}
+	master->translated = true;
+}
+
+/*
+ * Drop this master's references to its micro-TLBs. A micro-TLB stays enabled
+ * as long as other bus masters connected to it are still translated.
+ */
+static void ipmmu_detach_utlbs(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct ipmmu_vmsa_master *master = to_master(dev);
+	struct ipmmu_vmsa_device *mmu = master->mmu;
+	unsigned int i;
+
+	guard(spinlock_irqsave)(&mmu->lock);
+
+	if (!master->translated)
+		return;
+
+	for (i = 0; i < fwspec->num_ids; ++i) {
+		unsigned int utlb = fwspec->ids[i];
+
+		if (!--mmu->utlb_users[utlb])
+			ipmmu_utlb_disable(mmu, utlb);
+	}
+	master->translated = false;
+}
+
 static void ipmmu_tlb_flush_all(void *cookie)
 {
 	struct ipmmu_vmsa_domain *domain = cookie;
@@ -592,10 +655,8 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev, struct iommu_domain *old)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
-	unsigned int i;
 	int ret = 0;
 
 	if (!mmu) {
@@ -630,8 +691,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < fwspec->num_ids; ++i)
-		ipmmu_utlb_enable(domain, fwspec->ids[i]);
+	ipmmu_attach_utlbs(domain, dev);
 
 	return 0;
 }
@@ -640,16 +700,7 @@ static int ipmmu_iommu_identity_attach(struct iommu_domain *identity_domain,
 				       struct device *dev,
 				       struct iommu_domain *old)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct ipmmu_vmsa_domain *domain;
-	unsigned int i;
-
-	if (old == identity_domain || !old)
-		return 0;
-
-	domain = to_vmsa_domain(old);
-	for (i = 0; i < fwspec->num_ids; ++i)
-		ipmmu_utlb_disable(domain, fwspec->ids[i]);
+	ipmmu_detach_utlbs(dev);
 
 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
@@ -815,6 +866,7 @@ static struct iommu_device *ipmmu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct platform_device *ipmmu_pdev;
+	struct ipmmu_vmsa_master *master;
 	struct ipmmu_vmsa_device *mmu;
 
 	if (!fwspec)
@@ -830,7 +882,12 @@ static struct iommu_device *ipmmu_probe_device(struct device *dev)
 	if (!mmu)
 		return ERR_PTR(-ENODEV);
 
-	dev_iommu_priv_set(dev, mmu);
+	master = kzalloc_obj(*master);
+	if (!master)
+		return ERR_PTR(-ENOMEM);
+
+	master->mmu = mmu;
+	dev_iommu_priv_set(dev, master);
 
 	return &mmu->iommu;
 }
@@ -848,18 +905,12 @@ static void ipmmu_probe_finalize(struct device *dev)
 
 static void ipmmu_release_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
-	unsigned int i;
+	struct ipmmu_vmsa_master *master = to_master(dev);
 
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		unsigned int utlb = fwspec->ids[i];
+	ipmmu_detach_utlbs(dev);
 
-		ipmmu_imuctr_write(mmu, utlb, 0);
-		mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
-	}
-
-	arm_iommu_release_mapping(mmu->mapping);
+	arm_iommu_release_mapping(master->mmu->mapping);
+	kfree(master);
 }
 
 static const struct iommu_ops ipmmu_ops = {
-- 
2.54.0

