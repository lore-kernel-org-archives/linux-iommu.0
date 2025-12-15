Received: from OLAP279CU001.outbound.protection.outlook.com (mail-norwayeastazon11021097.outbound.protection.outlook.com [40.107.157.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081733033C
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.157.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799580; cv=fail; b=L5gR3OTPV6tpx5v2FkokfTKth1Ggc32O1NbNnfPPBmV1UuIDk/gwOrZWysJz1+lMANJdtUwfz6njxnVKozwWLBVUO3+7bxC1685dmn4ur+bDJroPMdL1z6q7D9/gWmmy8ipxQk46O4lfA994nRh+AVCjWW1N1FGJCGGZ6suIlL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799580; c=relaxed/simple;
	bh=fkK/0yrEHBGKxnQGsDD/rvPCipXFL5rOx8hhpA4iaGM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tUx7oWvFJVbCFdqZo/X50Kp98F97qovmCsHyrqfMrqiYPyshsHAYaen9FI0zITbv3Z28mFnM1hDpluOnv7kh3ksAE8BVMQGJ+WOsBF6opoegM7iLNr3tvJCTLnIRSyYqxJO0bWOakEwlaNZV8elQcFgNiiC909LQS8JXHUUUChE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=JloTN7uh; arc=fail smtp.client-ip=40.107.157.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="JloTN7uh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozkxFBVDwiTJZv/hT/8vn5fv1inVtWwm/S7D8fAjR3j4Hj5JFgEl2w1EKgdbmti8S22mjzHyVnKtQrzDcAG70vqTaTuWETsy5rhzEuKqxtIdCZ0/GVPZuZV0K/bR1V394gN7zb8EI3uRLOZC1U19PiEyydW3xYgK5BgVWpmjT1tzCkfMWNvjfQeI1RAUg6ORr21Xw9u+ipW0uywg9Kin8udIWqaA7604rL4kOxubv/YZA/K/eCN/s81z8/YzUxKgwmdd8KfzlZs9aGXgs2b+DVv/4lOpczhGlT4OynP+H27fxLpGML6k2RYnv3mAST2MaTRps2V52FPU4GQCgG/scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+m4GeBVyPVYCB42OM/6MsBiKOGOJl51NxeFTinptLQ=;
 b=LpIexaS8jG5yV9veaIsr08woittqE2553mH4tWoZBgXZ75mTIBRXxGKvynEPSCT7MpGZ+lBnt1QR3meNaAPRZFyI6zxYFy/cNIfbMc15CRjD1qT81AzZomLmZZ9dPoa1rMv0Hr/AHliz1bgBUlMwoYHaisNuuerkLRpyKYmjZRsNcx5KxUCsPgtaZ/oLtpP4kDmZzkhV4kh0TUr41JEAEmtatZIeLjOeqYK70OR+q2eAB4NQrzaeRWOr+uzcs2lIRiYftltqJB19dpF4TVFmFlS0HSj360wG7A8P1YJ36AaVYJig0QX4aV0bUJML4S1xJsLOv713easPTErs6a62AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+m4GeBVyPVYCB42OM/6MsBiKOGOJl51NxeFTinptLQ=;
 b=JloTN7uh6kUOZSu7jotNIoYSm8Pd31GWEtB9/RQe15jhA5DWbZ570joXHfAi0jTJdKSER0s96A6EB2/VdwZel+GD3RDnTZb9hS0S/hGRql+8AUo2uUri/T++1IAPXH8Jezi8rhm6oSBSsE+jDhquSYudkUpreIQOMmE62KYtkdGrNF6Zw4w8oEY6SsMK/JDWarLDyiHI94fMWYEFqRSLRba3BRvr2eNBuHffHzdjYbhyTx2Ba0Zaw3/9EFgf1j7aQpqjbW67/9SvJYAcJcPtePZSqYGjo6M4jOHRwP4ifxAo9dF0z1ArN/uD4tgFkMUdeaEtcquNpOAEj+fB9d/ypg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 SV0P279MB1129.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:35::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Mon, 15 Dec 2025 11:52:51 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::5add:4383:5906:2115]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::5add:4383:5906:2115%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:52:51 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Magnus Kalland <magnus@dolphinics.com>,
	"Tore H . Larsen" <torel@simula.no>,
	"Lars B . Kristiansen" <larsk@dolphinics.com>,
	Jonas Markussen <jonas@dolphinics.com>
Subject: [RFC PATCH v1] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Mon, 15 Dec 2025 12:49:53 +0100
Message-ID: <20251215114952.190550-2-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0081.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3e::17) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|SV0P279MB1129:EE_
X-MS-Office365-Filtering-Correlation-Id: 735efd97-8917-4301-d670-08de3bd07981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ef4QF3gEt+qOlZ7bK6co4Q51X7IKkSXSxyKCeNr5E6iuuclhni9yCXJOzBUc?=
 =?us-ascii?Q?nRHH4HkKWSn9jGG2K1irN1+/SU045w3vjEeDQXMeY3IE44igZSUkj5qSusdO?=
 =?us-ascii?Q?eAgK9XesTsxoAS0z6oG/FJK/j5nQSrd0GAB5hF3mNspXgZQS3bL9eoXmhmQW?=
 =?us-ascii?Q?lCImIli/FPrikPgEuoohImkQG5Du6kQBneVdidihT2EX/dx8fTpT7IwJFLhk?=
 =?us-ascii?Q?aRv2BnFp9hxAIBhestpnmDWHH/MpFCMda7IX0ww6WYiMOwkXC2tN3cmpyzYx?=
 =?us-ascii?Q?5tyt+Kp6x7cWrYFq6o2tZr7WWB/HSx07RVfSR0NFLGzil/A0ZF8lOuI73XdM?=
 =?us-ascii?Q?6VuDEjdbHrPH0W3gf3XeuPNkOF6quRF2hcgFeNTwCsB9Zxg0PeUaavuT+kY6?=
 =?us-ascii?Q?RpP76VMCho/tqrihU83V4vf6boYVxRF67rf+HMt6Xyt9O3CGTSEZ+KrCuKVD?=
 =?us-ascii?Q?muPfGTi2qVylAFXk/KSBr2+4zWJ849c/18Jqo79NXtIB6H96pExwbQn8SBKt?=
 =?us-ascii?Q?tFRNWXuo+axLPyVJuF/QEyP0l8DXemOKgi5I0ipjgwbbQ4AhOzdrBpN5vohO?=
 =?us-ascii?Q?p2yC6v/wtJLE9tFqWLtG+Dm45XtohqFuSp472Mx1Qu3SSoxxQnSihXZ6avxj?=
 =?us-ascii?Q?eCReRrkDK2Y6bdJcV1STkFhgkJSaiOv83ymo5cmC+Rx1rBbwqZ9nAprn9dMw?=
 =?us-ascii?Q?zn6xgujBGAkFsIIzR5cUDzA6TCfc6Fw5utumrxKTl7hlqlOz+PqDviEwgcQ4?=
 =?us-ascii?Q?yuqhARKiZjPPQTR5f9xBetG8XuG/2PxiBkpAUj0aqhcUpPAuBqCI/+eYcCZ4?=
 =?us-ascii?Q?w+rJJiknWBLdB2j5/5fvOItSDhnHzLppyM5x4qh0vONdkeR+nIdYGj6QY2Gg?=
 =?us-ascii?Q?NicZgP9kv8TCiCyi/cbUeTlJso7oBkcemNevzWEOAVf5ucEam9Pucj6+cSob?=
 =?us-ascii?Q?OhOiya9W++XeMmuP2XPvvzj3AvBQEoSDo+h3Pfz2AcqShC24/o6xT80gCicZ?=
 =?us-ascii?Q?/tm61U8cs8MVpm4fYw4UXJm1Y/J8sUaFUJOBSjfvJ9oEdo/H6aBOC5tO5X4l?=
 =?us-ascii?Q?VUiktXbrnjmx78bEQuo6MmhgiwAOOzElt2bx1c9Oa6fUIDqwws07KSgpGTv2?=
 =?us-ascii?Q?iwVKRga51Xkps0afTpEwzCGPuKmRiviubxeJJgPQRIeor6CTgXu+pkiIArxl?=
 =?us-ascii?Q?duFu3llwXKoGRpkKZY2gVv1m2US7xZ4ZwQ57JIn+uCyLWqBkgHRQ1SgTeF9m?=
 =?us-ascii?Q?lRECzQ6GEZUAfrwMOvG9YyDHnQprcvM8V312wCBXXWXduq9tDkSbrkfMVk6z?=
 =?us-ascii?Q?VP9Jc+F6Zl/UJj7tlyE8xrhUhbJUgaiXSphCkEHgffb4dC7F+0/1vapb+ioq?=
 =?us-ascii?Q?GUl2/YN3iHg4d87HgQPfvtq7EfjEqEA8vXAvhm5jkhxg/3rr/xTWIFQaFUJH?=
 =?us-ascii?Q?U1+Zs/GzkQeb72jSuQ451afwbuCmYx/W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4IHF9vjupPQTTrc0rmK5AFnqeJ5yOe8fbq7EhnFa6WZqQPq+VGqpolUnzMJR?=
 =?us-ascii?Q?govAWPtVa1bGi6nRx8VfZQPULHk1XHYR0GYXDVMwLmMyst/SehdTdQQK23xQ?=
 =?us-ascii?Q?uMvzGSvDzHa5FZXaol7aULVTMs+lkLM0bPsrQbPhyvjtd4fntXQIi0bpAPVN?=
 =?us-ascii?Q?4540soZIuLEB1FMvGce6GkHrph0ynQcfVxP2ST+15A9FeUKfhZoQbsN4CfLG?=
 =?us-ascii?Q?vVGHZ0cBq28B8g5bJ/Z7nQ7oiERFfJWP6xxkAp6SJZoGmoX40O8CjryUswA+?=
 =?us-ascii?Q?nUkJg1hw/k1HyIFwcbKGsma2r7e9SVFtQPfyYzu6wyt+uhUPYZRUiTH0Qv/L?=
 =?us-ascii?Q?khsRVhvIb3nr4inyxCNf1oTMkn3qn5dMe8yIwH5Mnmlj4LdyGlJGA+h7BJbl?=
 =?us-ascii?Q?iVtC5XColqUPZiQQ8ot4Kt1Xc83yELnijZKTEmCOFEfHdSKio5rICFOSe5GK?=
 =?us-ascii?Q?So6dcppRVXRdx7Yb2/LtkRHGHDQp64TMrbZWWXOVglCJ2QyO9QcIRtI/+3es?=
 =?us-ascii?Q?DPJbWr4ZiUNAN9qSTynyF/qZELGiY4qxenSQBwsn/AuFZlICpk5/caq9RGgM?=
 =?us-ascii?Q?nHgh+2G1ZQP9GK4Zg51c7k7bKJPsMZX+dzTk/eDfzd4R8Mo8+6VRxUQEnGVK?=
 =?us-ascii?Q?KqiNXXJAvoF5+W/G7ayj9ITvHxP1IUxAcoS31dk8YXpyY3ICQHvTsK+SPpYJ?=
 =?us-ascii?Q?FuZaarockO2OxOk1mX3I7TT5M1uD89bWErDED/SMpU5jPpeSjD7tncojX3PJ?=
 =?us-ascii?Q?+wihB+rboDoxQqoWwZGD+I7mV2+3uPMZQaytdO/fLMY7brUflFh9a6ogLfZK?=
 =?us-ascii?Q?9P6n0K11xX4md4nE4ry7AOBBK5V5VwgCPzCGeInK3oEQ2Nq6dknBq5HPiIG6?=
 =?us-ascii?Q?FmbSqKhDM1/Y+qLGKWvh+2PvaP9kz+7wIBDcYM/r1wPtr72vCmPAJgFOcgoq?=
 =?us-ascii?Q?YcNvz9vuD3IwWvsDB2ReweVAODGHnI8K+Z9dtiM1NFpggNc1B1dd73yQ0Bis?=
 =?us-ascii?Q?k95j4J0Z1VWxqaIcPJWKhR1JnafLN0jWLpmz2eiJPhWM0caopBwDoffZvDDL?=
 =?us-ascii?Q?FxLdbU/XJ/nufcYZxZIX2YauQKtfU2qcdnbJ/n/VOP5nxjpktRJ59Uo7p/2h?=
 =?us-ascii?Q?i5qQw7pNS1/0D4rQ2U2G9VyWtEGy0uN6n/fvWg85h76J/GzCg5tOaz8X6UTT?=
 =?us-ascii?Q?Fb/l9BCtULhkZ1IHssXAaoC4eVGyFIE+SiMFALR52AIAxQkQ99vKJcEyODmD?=
 =?us-ascii?Q?rI6q39hkebnLkQF8X+Xig+g0aEsBpq/CK/X7GbXcit+oXWemQpm5doT52wkK?=
 =?us-ascii?Q?buU7mAgwSaVwS87PtyoBrivwkXpGpsv+6FRdmznlAYDewu8gEtCkFKCGwKMA?=
 =?us-ascii?Q?4cRS5tWo+MLbu/hmWm6UuX4sjrUHodtOWg6oQLamFE0S4MATA/QZcS+bOTzM?=
 =?us-ascii?Q?EOEAOf5wyd7lgpf4oAoStGCAmF1Bo0WvxEfvOy0nbyYcpip24hPlc9dxaGrt?=
 =?us-ascii?Q?Vwz/jaewJRsjI9lVGrhn9x/bPU3ntaU+GmUSNHoMGfDQXYWQv0590kSv/BLp?=
 =?us-ascii?Q?nTIyDHfyb2Yw7LLkG1SzAzk3im02ReztekfwexOP?=
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735efd97-8917-4301-d670-08de3bd07981
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 11:52:51.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoFFDkvXaXCVTGPxCj9AOU6530YmhG/iJkz9XJJWgBb+KHJJUoAj5dgisJIhZznWM2om8lQDfXIZwkK3MdelOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SV0P279MB1129

DMA aliasing can cause interrupt remapping table entries (IRTEs) to be shared
between multiple device IDs. The AMD IOMMU currently invalidates IRTE cache
entries on a per-device basis whenever an IRTE is updated.

This approach can leave stale IRTE cache entries when an IRTE is cached under
one DMA alias but later updated and invalidated only through a different alias.
In such cases, the original device ID is never explicitly invalidated, since it
is programmed implicitly via aliasing.

This incoherency has been observed when IRTEs are cached for one Non-Transparent
Bridge (NTB) DMA alias and later updated through another.

This RFC proposes invalidating the interrupt remapping table cache for all DMA
aliases when updating an IRTE.

Cc: Tore H. Larsen <torel@simula.no>
Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
---
 drivers/iommu/amd/iommu.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9f1d56a5e145..5ac19398024f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -31,6 +31,7 @@
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/cc_platform.h>
+#include <linux/iommu.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -3095,22 +3096,44 @@ const struct iommu_ops amd_iommu_ops = {
 static struct irq_chip amd_ir_chip;
 static DEFINE_SPINLOCK(iommu_table_lock);
 
+static int iommu_flush_dev_irt(struct pci_dev *pdev, u16 devid, void *data)
+{
+	int ret;
+	struct iommu_cmd cmd;
+	struct amd_iommu *iommu = data;
+
+	build_inv_irt(&cmd, devid);
+	ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	return ret;
+}
+
 static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 {
 	int ret;
 	u64 data;
+	int domain = iommu->pci_seg->id;
+	unsigned int bus = PCI_BUS_NUM(devid);
+	unsigned int devfn = devid & 0xff;
 	unsigned long flags;
 	struct iommu_cmd cmd, cmd2;
+	struct pci_dev *pdev = NULL;
 
 	if (iommu->irtcachedis_enabled)
 		return;
 
-	build_inv_irt(&cmd, devid);
 	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd2, iommu, data);
 
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
+	if (pdev) {
+		raw_spin_lock_irqsave(&iommu->lock, flags);
+		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
+	} else {
+		build_inv_irt(&cmd, devid);
+		raw_spin_lock_irqsave(&iommu->lock, flags);
+		ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	}
+
 	if (ret)
 		goto out;
 	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
@@ -3119,6 +3142,8 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 	wait_on_sem(iommu, data);
 out:
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	if (pdev)
+		pci_dev_put(pdev);
 }
 
 static inline u8 iommu_get_int_tablen(struct iommu_dev_data *dev_data)
-- 
2.43.0

