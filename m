Received: from OS6P279CU014.outbound.protection.outlook.com (mail-norwayeastazon11020084.outbound.protection.outlook.com [52.101.178.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8738B15F
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.178.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115799; cv=fail; b=KIC/Fw/qBVPf2+qGICpRUZL3TkAlngSFcYqlMd2aSUCP0k+hjuvcBaVRW0FZwXwqFNl3G3K4FOGV+xZ4msOtqSf8lVQ/OlJQ9ms0kjiqyKJWG39ukr5TvL9AwWCfsBBHdtdfdGhKyAHUtwJPI+2/0J0Qe3VLB9QlWs5pTLparjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115799; c=relaxed/simple;
	bh=la9lpocy6K58yA3ed0Rv8hOCXmkIWgbLsGng93toxqE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c6+J3CaJiELAGw6XXrdu4qxPLZM7upwIpyQ+PIm/9dRMam7OaINRXs+iBd64lRC/7fkNIllc65U2NtRNTWFGZznoFvFQKuG6aBfNAY75q7x8xedFgmSrHt/d0eNEJzYzFGw5RG1eUK3WMa/urE4vQB0JnT8hSt/rWtSJh2Du2/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=wZHRq6bI; arc=fail smtp.client-ip=52.101.178.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="wZHRq6bI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M55rj+ueo/hJ26LqLpx3BEpEPiiVKzhwVv9o7/1dilt7Lj8FHFfkfdS7Cps6wN7Jcnvny20pe5kfUuKsW8Eze5+wiVmLxtM3etnmOLKkTHFE1dKSvOt6KUKN6b9ZBJzMDBkl7ffSwrhRvGEZt0hoS1lyxc5+csYXFZIZE9yhbX9efBeLXYMWm8Dm07PwwR3IPLQEWxOdfWsDCZbIF3ktjKlvEcfz7n8HUwoX0YxQKMjujPjfXZEZaIbHTPegLkkJ5kacCbNkDvGWx5PhPC9eGwnz51kehZ+cKO1RDrsMHfzCkaT1d1mJ/c30S+LdNOjtyI+hnq8AKI1NL+xeFtobmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQEAcXNe4L7vFT/m4XPszw6q3OZew6cOFbnw62wQ/0s=;
 b=vSJzNtVpG3s2Pwq4Gm/ytTeY63BvDydew2XrvUsomXbmpasveracsRPd9C84YAM+O4K78m5BU25UWeSF99XqMwxaPxrE9Kmu3DH4lOqDYuFBvrmQm4z4mzf+2wHu+o3a9gk7oOxTyEyWHfp1usrIICopFkX1cndNFLdtQI8/uS/5Zz+pFtA6uthuUt4coFItX+1Bu540e3bXtSYScRkAKrUCNVfZsLIH+OAw78+meBAkN+7RxZf2VWGCuk+3sGiSvBd7OYrFWGb3ERzKeC7PMme+JWRKeZXXT0P8RcIQL997QGEGDtHh1c8AYYNtzJd9LMcIYh0iBEbthB+Ft0xPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQEAcXNe4L7vFT/m4XPszw6q3OZew6cOFbnw62wQ/0s=;
 b=wZHRq6bIV5q+RDo+58OKtZeF9vImAa8DB16JY15/bbX8RBb9yZCq94A8ifSCT2zvWQrYvgUAjI9zXB0OBkpESdpBbb5gBOltaTv2vyLdrIdghGf6Lwa0Ry+KVXq2hssN+sWBusP0zfPqAAzaKUg9s7T9bj+bFA5zZRjbm2JA1C7jQn03eZMUAI/xcqs8JKzV6xBC30XQo5v3DWhUvPdD5YtWi9vas3tJtXoyB5Uwl8uXzPnX0+9VmevmZbLILVJXV8x9gnW1BQxXDUcOh6Al5NJvXlmyMZAKHVmawYauLnwH7qNSFD6xpmO3ZpWRb4eQwhHotS6Ol9EKJXGEQdXRWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS6P279MB0780.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:46::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.18; Thu, 2 Apr 2026 07:43:09 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 07:43:08 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	suravee.suthikulpanit@amd.com
Cc: dhsrivas@amd.com,
	jonas@dolphinics.com,
	larsk@dolphinics.com,
	magnus@dolphinics.com,
	torel@simula.no
Subject: [PATCH v5] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Thu,  2 Apr 2026 09:42:50 +0200
Message-ID: <20260402074255.18415-1-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0126.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3b::15) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OS6P279MB0780:EE_
X-MS-Office365-Filtering-Correlation-Id: 7934a6e1-15a0-4e2b-e421-08de908b7be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wg+mW+JKbvdzzP3JGFxh2lKTOQalkLEsHfCrmzbCAdUJA+n6vjxwNKqiIMk7RhctB/PBG5BSjy2hRAXP0mY/Un5ZdvM4CQuNhC6x46ntFPudvpkHf3iIce1vRZR/BoIwPiOjV9gBEmUaEAlIqrir0wbbdzA5GV3S5DAD85f1juBmGeJMNcMUncjG47qCqxIXonDnSN0bY00+eCzMx6GQtVAs3KmRD2gOMrZA0wv2HMVk//1HTR+bcWvAURXIvbqGwJ6yovrIBkVqDikd7LJtwhyzInGFUrX/7kukt32ql4XCgTCkcBC8jP2Gqm1SKJuxIYE6F/7XMtrdD5VJotPhlHNDic8hbkjrM2nLEsEKR7cNWmdb/8CdyBwCZ6h6c+k8+ptWkbt48hHm25JPWVF7uqU187ps5eeZ7hHV1EPqDk6xws4wvz7APh1j8WuYuB+m+T6SYiX/7KQzcsvfdzS+u2H3bn1TS8u2R+KvaxRhbavm6sPYl0Li/g6eJbSJcj8U21W+W0HmEJYFk4RnSSXukr++m1xdhBEl/PQM+eXVM5CnoLvCofCxtQZSY3uGwOw1BalN6Tvzszl0Wv3mDNnqyMyiOvp6Ji3Ks+2KBkWgQqGr8jG3h+SoPoW+FdZTTypqrlaX9yceDWK+/zwK/DzAyK0GP5rwEJCleN/r8cJnPSUvqHUAnMKajEiSs2eV1i/K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?if/ViZT3WUNj1DB8MUhHFuuJfpvDU+Zk/wltUpW0O4feZUMKVWWOm3aBl9e4?=
 =?us-ascii?Q?7/YHayPfUtgCqvWSR0g4SLss7lkxiiYZ8Kr9ZuFXAmy+aI+pWvr/cHtOV8es?=
 =?us-ascii?Q?lEDLuDtqzjjHvVNuysTLb9yBne6ZO3di1fYNTFn00CXSMf4sETTD8y3nVtO4?=
 =?us-ascii?Q?NLwUTEVAHN4KvPgSXhwiNgiKx8mT1f43IWRcYtgOaDmNKNtn0j3UK6jIZgCo?=
 =?us-ascii?Q?LYKTlFmf5DSlW5+8m3oDRuRvo0hsLdYl8bGCvARprEO1z7KVumHEVxkmoMJg?=
 =?us-ascii?Q?TpbvprHbybKBxA4AqQuRgIj0KoxiTatcw6w+XTBk0JA5Ww1V6WlIyYbhi+Mq?=
 =?us-ascii?Q?dctfmBvF8tqOjMHfDOSNsX/PIg55LAMF1jJ3sAgSZoW6FEsfyFwWgynylVoK?=
 =?us-ascii?Q?7P+QQmyuXJblVwF5XYz/6Jqpg0XRxkGqcYUUFURMuNpnYw0HT4xFFO95q+DE?=
 =?us-ascii?Q?mdwrvUMJlIqLLuchOqOf0Y6Tlp7Sd1O1p1+g1kin+2bc4mpuL6bPlWaAqsGa?=
 =?us-ascii?Q?5LCH2zEfcts91I3x/ZosMTcAUFJp4NBDEZbJ96zUcV+OibpulKrR1tpbN/yZ?=
 =?us-ascii?Q?yUi8jRCvpatHjWOptN2vU8FhiPH9IFSpzgGWy94FV6yFg4XR+dTdkYZs8p7t?=
 =?us-ascii?Q?3BSh+FP2PGH3v9HSRFXToUZL0RB3pQMqYB/wfNdaNbu49I0RJrXKZLfKQFeB?=
 =?us-ascii?Q?JjGHoJw/gzudOhO280n/W/80Aku8Emsca0v1D/6PeJjGYx4oPsRz/FsYQodD?=
 =?us-ascii?Q?lwhw+555PFZvcHVLt8fWmRcsZzsSFrE6Hk/u5YhiUsQMd4XCpaydXit6T1Jz?=
 =?us-ascii?Q?uGFDccomZNKE0jLYvuKhHVliQHgicN7ackSKd8ldaa7lolhGopWxmioKXApz?=
 =?us-ascii?Q?I3x1053g63hHI9I8rQoVzNynQyf06XKFhP1nSOyUYX9fVIKHaHuMBrUGWp0D?=
 =?us-ascii?Q?7lyYjvypm/sfWjV/xbh4eudBZQYvyd78kNyh74w1O2+2Gt9Z6n49OFPTrNFu?=
 =?us-ascii?Q?MSMlEC0xi5wONReG3sc009ZsNdl6mnCSY3UBHemcJkAS4E7cx+0rJSJAdX4z?=
 =?us-ascii?Q?x4aU8sXgAFCLy7NLFcMSpsx7uYMtf4Ug37o2x0Yr1EfwB+wiZ8AYmTovHLtN?=
 =?us-ascii?Q?kkUF9VpxDf2l7mr0kCNtnHPPDIaFD8i67kaxvkEr5FZN584/cyuIIcxmaUwp?=
 =?us-ascii?Q?NhPpDc9BL2J4UBWO0qk1nQQya1ICSh8lSWdIqU4ZEthNe9jtUuUvaEW8nBLl?=
 =?us-ascii?Q?gTN/2N7R/4cd7ul1Z/0xmkSDoFfiQ9bmIY6xZKFeTTEZO38uszPV1lQu4827?=
 =?us-ascii?Q?/Dxnzs8s6gsIBNi6FcE5/SJAMmjn4p34GL8g3A6IcVfcJhpW2Z2l9lMLf5Xc?=
 =?us-ascii?Q?Iunf4i0YmcPd8xwDLLNE78auMjLd8TYxNn5WUBhY0fQMNrNIoUfIitNARIgu?=
 =?us-ascii?Q?Ab7WB6hSycFjIC0EkAYuF2gkk7fcda+2wbjCmbB7jRdkVUHK606z8KJfFdyB?=
 =?us-ascii?Q?poCcEFYMQsGHf9FVVp8QQwROwCeyM6sUFSVoW9fCGSLF46oEI6IVHMJKF82g?=
 =?us-ascii?Q?K8YSKBd/QT1drfD3KaQm2/t9X/+Kg8BAkkJ0t6mTi8e180IT+ZVqZtwV5mu7?=
 =?us-ascii?Q?y+KLMcPrzvhi7VXBVWCSLenVHZBkyHidbEmGxzpZAwh/Pu+TLwPbqtlj5M8E?=
 =?us-ascii?Q?6RXxZVuaxpU5jRCH2mObpkeJMHzXfjDoaEublDKadp5auc14EKU+Y0+cT3zc?=
 =?us-ascii?Q?dRrkn/EQmQ5VLQKuZuEjxvL7LVG8vQk2YD46JtnxYdF0XoDSnpapLarrM0WG?=
X-MS-Exchange-AntiSpam-MessageData-1: 7ze7X9lZlGCDBQ==
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7934a6e1-15a0-4e2b-e421-08de908b7be7
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:43:08.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4Tm6WAgn0yF3DmZSy/Y9N3/XDOn7lvMDkh8pIPc1qeXbFhAuenfQ2FixS3TwOmbLMn2tuzl3c936IPq1RAugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS6P279MB0780

DMA aliasing causes interrupt remapping table entries (IRTEs) to be shared
between multiple device IDs. See commit 3c124435e8dd
("iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping") for more
information on this. However, the AMD IOMMU driver currently invalidates
IRTE cache entries on a per-device basis whenever an IRTE is updated, not
for each alias.

This approach leaves stale IRTE cache entries when an IRTE is cached under
one DMA alias but later updated and invalidated through a different alias.
In such cases, the original device ID is never invalidated, since it is
programmed via aliasing.

This incoherency bug has been observed when IRTEs are cached for one
Non-Transparent Bridge (NTB) DMA alias, later updated via another.

Fix this by invalidating the interrupt remapping table cache for all DMA
aliases when updating an IRTE.

Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
Co-developed-by: Tore H. Larsen <torel@simula.no>
Signed-off-by: Tore H. Larsen <torel@simula.no>
Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
Link: https://lore.kernel.org/linux-iommu/9204da81-f821-4034-b8ad-501e43383b56@amd.com/

---
Changes since v4:
 - Add missing error code check after invalidating

 drivers/iommu/amd/iommu.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f22a7e9ecfdb..445b1ca7c8b7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3186,26 +3186,44 @@ const struct iommu_ops amd_iommu_ops = {
 static struct irq_chip amd_ir_chip;
 static DEFINE_SPINLOCK(iommu_table_lock);
 
+static int iommu_flush_dev_irt(struct pci_dev *unused, u16 devid, void *data)
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
 	unsigned long flags;
-	struct iommu_cmd cmd, cmd2;
+	struct iommu_cmd cmd;
+	struct pci_dev *pdev = NULL;
+	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
 
 	if (iommu->irtcachedis_enabled)
 		return;
 
-	build_inv_irt(&cmd, devid);
+	if (dev_data && dev_data->dev && dev_is_pci(dev_data->dev))
+		pdev = to_pci_dev(dev_data->dev);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 	data = get_cmdsem_val(iommu);
-	build_completion_wait(&cmd2, iommu, data);
+	build_completion_wait(&cmd, iommu, data);
 
-	ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	if (pdev)
+		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
+	else
+		ret = iommu_flush_dev_irt(NULL, devid, iommu);
 	if (ret)
 		goto out_err;
-	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
+
+	ret = __iommu_queue_command_sync(iommu, &cmd, false);
 	if (ret)
 		goto out_err;
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-- 
2.43.0

