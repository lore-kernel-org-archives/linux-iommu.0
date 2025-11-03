Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012051.outbound.protection.outlook.com [52.103.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E3D27A465
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178467; cv=fail; b=mMt4X1DGLUJJD4ENvVAQbVQErVYKJLyupXrSV8orkYuRDAdXCeUZ+YCqWzjYpSgs775UO7R1zZcf3IQKstIXCI7PQMCgR25R0od13xWr4GGL4Qbc2qQC24JlZhMXu9bgHG81egemVe7vdZEG0Vm0+s6U9Zn3XUFUot1tRSWrXY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178467; c=relaxed/simple;
	bh=0pGCkqrQxc84StwzF5N9lTgmVc04NO/7TOYYGyrhWPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgcUKXTx6K2BGc1/Ve6YX9B53HqEvITtzZDY3I4ZMbCsISaD4omqyH+phIGt92lE6WftTOjjsnLggNHpbfmaqadkP0ZcfJfXTbQDqhHRvn94FgIKebDVbwnYdp/fZuGqnHMB/HLJcXI7vtN71y6XCMFmrjDO9HBVFo8rV1qGa3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=i9p62Qhr; arc=fail smtp.client-ip=52.103.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="i9p62Qhr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ4xaUI434zK3NYq9bFGU63gc5N6a08UtEGcPA/oZGS6vjHO6+vn9CeSREjladfzaQWMGtTFDakg1V0NkrSfO/y6/vRcaqR37yTYJX99ATj5sHtSVSFv1by6uEEitpfmBvFoB7fKkDiUfmF/25dal3Zz1dUYzBOXCt02D3WiiTQkmcTar0ZoL/953hZ2VuYHqtnFjfbkLALObQfXKkmwFgZ+r0LdxfpsizcYTx9j3DqtSXJTb9T57IDzyn0AT24ENaimM2xEUj8XWUn4Q4LoACnuQ6IN+FZdAd5kao+sd6gtutB1/C2lKkxFHY0IzxFSw56MT6F9Q60MGVzi9hhn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUGgc7Lc+g0wJfb7fZfwpfltDjIBt8pgpyAw11VS0Ew=;
 b=Mg07QyP79bIW3Rm8kzCFBu4q+F49njwemXkTFWOBj0p3mjBuWbiNEN5OORz/wddrsBzExrRSHqH1nNufZ/sXxAqKR6OnP5Ufe5j2V3ocUNTxB7KnzghVHcZCduq+4ob5pljubodmODDGksO5R4qYvu8LOpRTHBh2bQvs4dE+BEgIWd6APwAkrJzn2ingMJHRXUq09fW0PmgRIWyFRY7OP/YAvFD++4Ep/aJBhFq7fIG+NRNBNb8nakLnXIuHSfPT/dU3sGH0Erwzot5GpQu6vxssxCVabzVr3pNQSiyJQSlR/FCKYp+YOSwJrVkWeH+4C6tItVa/x8sW6gQ3kmLXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUGgc7Lc+g0wJfb7fZfwpfltDjIBt8pgpyAw11VS0Ew=;
 b=i9p62QhrQSpxSKQdSuCTge6xyNimRPlcI16c9AW/kIUMqfURAziYjwYuAJrY3eDT2i24bjmZAr6oB8d6O9JxOMf+ykjvGfvW/aENbDkjiPJcvdBrpeJZqHKnTvvC91XLiMeS+Urzje10NGOGRUdGvFYKslhFFE/QLLWECo2ISZ5yiaVmqx9z7dvE3sIAmGWI3l5I4yyPTFglBogQ+Zk63JMGJ03P7xwretbmakbxA4n9yFDlvV8CvrjgUxsbhECyiAMTWNSDQlB9uoTjMoFfggcBnIMKckRbKp9mt760R/ZRdDMyTeuNoLGBwaehv20NRjTcWZGYxVgFnv20KqaEvA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4597.apcprd01.prod.exchangelabs.com
 (2603:1096:101:90::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 14:00:58 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 14:00:58 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: alex@shazbot.org,
	jgg@nvidia.com,
	suravee.suthikulpanit@amd.com,
	thomas.lendacky@amd.com,
	joro@8bytes.org
Cc: kevin.tian@intel.com,
	wei.w.wang@hotmail.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for MMIO-backed addresses
Date: Mon,  3 Nov 2025 22:00:34 +0800
Message-ID:
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0345.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::6) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20251103140035.762861-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c904c2-3b8b-4a5c-c415-08de1ae16a01
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|23021999003|461199028|5072599009|8060799015|15080799012|19110799012|10112599003|13041999003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0m0Ln7V0OqGeN9OcvqrGRYrLOJ50Li/aJGZ3SBzFOuJv9+ianb/y9nTs62pW?=
 =?us-ascii?Q?hbZf1PQp8AmZirCKh/iVWxVl7tDW1bjQHVUGIiZxfghHN2bcJPcGtfMgGl9D?=
 =?us-ascii?Q?wQpx04T1grUk8eQfgXqTr11eSIgDl5BhvINj+WG5/2unsM/AxRjSOr9ILURZ?=
 =?us-ascii?Q?QRsTgMv/4wqsBh39UwBXmsZ8rZocBgVAnO6yOwfVoXXSRa8rFNgLCOk1ZXal?=
 =?us-ascii?Q?pKE9hv/5pBjKWdDlNGuFbHk3d+u6YJpbbbZbcw9/KAScfH119auyX3OXmbsr?=
 =?us-ascii?Q?HvbzUcjsxB+ImTdShsyDMFbGONoGQWe9yvYTPR60ePJpB3FUZcmF761rGi8U?=
 =?us-ascii?Q?iHEjFrsgcK6fozfk2azhToEVbBCru6St8tGp/RO0H7tw4HHWhZ+WB+xT2T/Z?=
 =?us-ascii?Q?MJzdNn++CH5D/LXbjNUfe3VEQhvE0y2vj5rZXqPe18nQ4wTVW7N1IiAN1rNW?=
 =?us-ascii?Q?7gkR1cWOeYqx2UsoLzzl5hw4ZZJkY85TgY7Y4xCN/PtqvB1DgOjb3TO+ep7t?=
 =?us-ascii?Q?8Eg65Z1qhtM1zULGBi/yY9I95nm3XMuJdy675NkTVJZvVMgO2gBB8xSrp6Z/?=
 =?us-ascii?Q?2GyJmxyrM4+slXrkw8RGXv+kgqTegi1zUapp9xVZIlUu6bAXO8NBC0HBQJPv?=
 =?us-ascii?Q?OZG10q6r3PyfnDH/u23HBhz1ct3ULqJbhiaSeRr8VnAgjZR7Z3mH6s6LVjOu?=
 =?us-ascii?Q?/JjnyN5hR30Qs7cKDcQUrL41AmExfn6Ej1r4My+jB7gAPo1wS9Dt6ma3IptL?=
 =?us-ascii?Q?mQe60HNHhOEwc4qQNInfAmCdne8WayDYsfEcBLR5Llzmyc0ksdjLewCfU1vI?=
 =?us-ascii?Q?aY/ejgNvdz5rBv5+CGJhypBQ5yJhm8eEjydIgfunm7StqneRdKpfGZE/68v0?=
 =?us-ascii?Q?UqfleApRfxwZSdic9sBv4LrSJXpO9P8FMn8WhxqDztlrtfPCaRsrvW4rc4Hn?=
 =?us-ascii?Q?wB31YjMLCaKf1q83RXEc1NpG6+Gprl6fX1p/baLm/8g3sbrNP+CRTOPrrZ40?=
 =?us-ascii?Q?G4z56hz6vs0gCrkgLUILb5/Q7VN56sbyoyd7q54uGwgHvQThR6Mh9krOBmZX?=
 =?us-ascii?Q?0k/xZFiCLOrTWl0J9TrdcsoyB6rTcLHmFerQ4nwoNYkwaw2wfgOVniU9oQ6E?=
 =?us-ascii?Q?XwcUFBqIs/FO5o+vr1oqUxiAddtez9jrf35tjxkc2TXmBuUi6FbFcoEFG62c?=
 =?us-ascii?Q?+5P7EdsVZ+i69TEG1AxESsoty5AuCXoper9zzes4Qt7iMc7VvE8vy0z7F1j8?=
 =?us-ascii?Q?fWXPsOgcQl7fOPhqWRao5HOEYHULxPhNY1RxkEc2Lg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p25V0hakLVDZM6HzevDk1uEHUTIEm9v0qNcRjjY3IuBzq+OyihdcdcfkjJBX?=
 =?us-ascii?Q?7FdvIL0YqO/CCQrNTf6d46ZTL5XOSZuFsu4w2usFPtnEsIv4l0pIu6r90dRI?=
 =?us-ascii?Q?oHWOel/oxWoZXQlsza5vtqYTetEhgo+Fvcn4r4Jwn82ss7yqoVOc8rvkejA9?=
 =?us-ascii?Q?R08S6eGrYBR/f3VEC3sMp7d97b68h0Zuds+SkRB2GL8K1ePdNBW/GesvoZWh?=
 =?us-ascii?Q?iL0DM8Fq6XjLIPWdI+uiSn5MVbLvmot6BuiZfr5CYc1ejtdrDAa7gxZZ4jAB?=
 =?us-ascii?Q?kMfxd362goSF+n/bH9Faeg4Fk+kWpMefmQLXUS14o9AroevrCl2cVdYEjtrR?=
 =?us-ascii?Q?PGjKuSGTSly1R0VApKGFDEuVTgBtPbKRayrnu+EpJLJTcFso6xuV936fqnWk?=
 =?us-ascii?Q?Yk/RjCs+UrjqSIrD+arqm+Rixovs89YCsCBvx0yYeH3oXWQrFCPn6ngjPYUo?=
 =?us-ascii?Q?GhqGMLa6SPJdAnUiuOcc1RvcEb4RVPfNsPmuM+8fZfKJff7h6m0g2QP1/Q31?=
 =?us-ascii?Q?nq9Rqjcda+DCCpJAVxoV0FHOG5WwtXJAgKpX+iOs+gtkFUi1WiSo/WhkUgOb?=
 =?us-ascii?Q?bGE17X4jWzI8YjB/XSLQ/e/Wr7z0wuHklbJs5K8vBKIzQQmhfiYB4PfWrY61?=
 =?us-ascii?Q?s/05HvPim/RjHVhLiZ6wfFR1kfOD5pB8WMSH/VaAt+xcyy3oiA8h8SpS/8KN?=
 =?us-ascii?Q?1+NI03uXec4OmJHjUY/QAKRI/qJNS9acGdm0Bgfs4BAF7nk2p71qwBcoF98x?=
 =?us-ascii?Q?FLfgU8SOHiYR3f+CiBPnyfhqJDiYJlngTs9KFEfIS4GZuK8P5Xhrn7WeteJa?=
 =?us-ascii?Q?1/5TqgcMUpRvLmcZ6Wz6oUdtvofdBdC2vkaKrICnKsSILb57l/yIinboAGbf?=
 =?us-ascii?Q?PBzO9IlVyvPmgkabzRjIgtK4kdPMfTf8T2Y3dLK0+ZOA9ohSR9f0DXUIpl47?=
 =?us-ascii?Q?+qSbJcmWb8ijfK7zDzf1aH0nL8m0ealBWTCAUhS7XdSyyzWExoHUt87brErG?=
 =?us-ascii?Q?PpmGbSNqhK+Aez+PxnpTxUSBBSffFulRZmWwVAAknhumfl1SfvxOVzDzs/Bd?=
 =?us-ascii?Q?KXmeGf5TLdEps4/KRWlorFa6QiASoTRmVTMaZuAa58tEGsxsGMOKBcI5lkeJ?=
 =?us-ascii?Q?0Zt9Yxtdk9A3RUJX2H4hanJOK8j14C2hVdBxzrjYbops7459+vi0X7d672hj?=
 =?us-ascii?Q?MVJufDpDfBs8nffFBu8CWAs+Cl6ZyLr8tYn7lEjHBw+fk2zJAr4YGvwQ9Kg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c904c2-3b8b-4a5c-c415-08de1ae16a01
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:00:58.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4597

Before requesting the IOMMU driver to map an IOVA to a physical address,
set the IOMMU_MMIO flag in dma->prot when the physical address corresponds
to MMIO. This allows the IOMMU driver to handle MMIO mappings specially.
For example, on AMD CPUs with SME enabled, the AMD IOMMU driver avoids
setting the C-bit if iommu_map() is called with IOMMU_MMIO set in prot.
This prevents issues with PCIe P2P communication, since current PCIe
switches and devices do not interpret the C-bit correctly.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/vfio/vfio_iommu_type1.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5167bec14e36..f5c56e227f9a 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -583,7 +583,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
  * returned initial pfn are provided; subsequent pfns are contiguous.
  */
 static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
-			   unsigned long npages, int prot, unsigned long *pfn,
+			   unsigned long npages, int *prot, unsigned long *pfn,
 			   struct vfio_batch *batch)
 {
 	unsigned long pin_pages = min_t(unsigned long, npages, batch->capacity);
@@ -591,7 +591,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 	unsigned int flags = 0;
 	long ret;
 
-	if (prot & IOMMU_WRITE)
+	if (*prot & IOMMU_WRITE)
 		flags |= FOLL_WRITE;
 
 	mmap_read_lock(mm);
@@ -601,6 +601,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 		*pfn = page_to_pfn(batch->pages[0]);
 		batch->size = ret;
 		batch->offset = 0;
+		*prot &= ~IOMMU_MMIO;
 		goto done;
 	} else if (!ret) {
 		ret = -EFAULT;
@@ -615,7 +616,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 		unsigned long addr_mask;
 
 		ret = follow_fault_pfn(vma, mm, vaddr, pfn, &addr_mask,
-				       prot & IOMMU_WRITE);
+				       *prot & IOMMU_WRITE);
 		if (ret == -EAGAIN)
 			goto retry;
 
@@ -629,6 +630,9 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 				ret = -EFAULT;
 			}
 		}
+
+		if (vma->vm_flags & VM_IO)
+			*prot |= IOMMU_MMIO;
 	}
 done:
 	mmap_read_unlock(mm);
@@ -709,7 +713,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 			cond_resched();
 
 			/* Empty batch, so refill it. */
-			ret = vaddr_get_pfns(mm, vaddr, npage, dma->prot,
+			ret = vaddr_get_pfns(mm, vaddr, npage, &dma->prot,
 					     &pfn, batch);
 			if (ret < 0)
 				goto unpin_out;
@@ -850,7 +854,7 @@ static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
 
 	vfio_batch_init_single(&batch);
 
-	ret = vaddr_get_pfns(mm, vaddr, 1, dma->prot, pfn_base, &batch);
+	ret = vaddr_get_pfns(mm, vaddr, 1, &dma->prot, pfn_base, &batch);
 	if (ret != 1)
 		goto out;
 
-- 
2.51.1

