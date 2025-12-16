Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013084.outbound.protection.outlook.com [52.103.74.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4422727FA
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901671; cv=fail; b=CPC+bxEez5Uo38OKo+XkPMB2dYVinsIQCin5TxSliG0Ke+w2q7to1jNI+l9GaIdNO/LsNWP8bJeJAJVszY1rLfxOTur6FbL1unJ+US1YGcNmUSzxSxqGGtfpl3WBlCAyIks3Dok83MdZ3llraQEeO0xfl5S0w3zS49ubuj/tYSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901671; c=relaxed/simple;
	bh=fXA4waEpDzYQo1dUf9dq5tgUoQ1CXZ3+nN8XULYlrTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jcLfS2vXZIQVHj8MTwrY8UPb2sfjVYczYDVlTK7U93R2qmmEmWFEYntrsG9jKZ8UE3ThLWZZhbgZBeQWL1bjjcmCIKk9/yb/oMttrbqPvgYC8Al2i/rY4fNYX3exWY9j1zsT45hXyGRcaW39+1XXjHWNdC8c6PBLiF6uFECeuAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=qapJohT5; arc=fail smtp.client-ip=52.103.74.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="qapJohT5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8HksqeniiCjtvv4YAvyONYMNfKvNdkViQpTYSR+4fgN7Ui+StHjoNra0+ufax02QOpIa6lxQWU6bDhFRbFzgrWlTqJmJM/x7DLNYkBT2T2NWNsWR8sGNipVkR4grAM+4008QPYE7YIQGNbkic1NMPQWSMaAsUlqrczLTuI6Jw37KcdQRYoNaV4K1BSx/NwF/+UMDy8q7gnt7Ndnx6zsueSENlf2zYQJVe/hrTjktnYBLz5GXwHvx+XVGTVZlOTX5S+Dmap8Y7fF6B5dEW0tl9Q8/PvdrFa+XRUki7EwyoMn2t2vn2/5Bnjv9a4Q37xlpua3EPgVifvviERye4LcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3JJgOnl7H9pVy2gp+huMUL0GPl2xay/Wm6Bg10olSo=;
 b=o38xA4zrW94vliKhehWZzR1Us00RlixTeKrC3FvBWkddkfRy4ArN0Q7DkP0MJYSboMcLiP96nvnZMk6uX7fhDl9PHjZex7kMUHB1jiU9V7vB8IAlsvFzG6i1aM9Co3I3qNOXLFTyyCQJkQoONbvfH57OxNSeo8Ybzhq/BeGRIYuHNhVKuURzZyuRmR/6tMJSfOP/oZME/Z0nIUfVzPYxKwVamKvnZ0scaS8UXwFUR5Q9/zjzwSSlXuRSTa4zVX5KUVUpe/igpbf9kDtnjiRjaGjfCigR7h9LMRg4ScIWlEIi/IfUXHdvv4/pst6p1WxRJGh4Ibn4s0XrEvrnY9AUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3JJgOnl7H9pVy2gp+huMUL0GPl2xay/Wm6Bg10olSo=;
 b=qapJohT5rq4g6Snewsc1l2wH0GNkfRPpzDk8k/pTWY5BPNIEFM4k7175QHqlFvgoFY+TWVCSWsfk8G5drN49NPw28vMHu3pxOjWI7CNaKxXPSQT7BGulYkXOeioeO1cLn8ERtegfw1C5TMtKBnlTy5eSTa2V54RZosWtkmmswJNTSivU2e9QHsaPelScuc+NUxmub/IlPKuqSwYMOR4D9URDSpdup+Woz86ZLuu6hln9X1f+8lL4w34vOy8LrIgRrvt0/rv4U+yADd9QySCeo5Y7s5bQkZg85ravOxxR6WlH6ZevhbdQXhNsBGkhZ42tqTIUugJ/b8W2AV0ht8kIuw==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by SEYPR01MB4770.apcprd01.prod.exchangelabs.com
 (2603:1096:101:b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 16:14:22 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::5145:bf70:5ca0:ee19]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::5145:bf70:5ca0:ee19%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 16:14:22 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: jgg@nvidia.com,
	kevin.tian@intel.com,
	alex@shazbot.org,
	joro@8bytes.org,
	thomas.lendacky@amd.com,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	aik@amd.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v4 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for MMIO-backed addresses
Date: Wed, 17 Dec 2025 00:13:47 +0800
Message-ID:
 <SEZPR01MB4399DA27E304E8BFB3C667DEDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <SEZPR01MB4399D06A044791DEA8BE43CBDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
References: <SEZPR01MB4399D06A044791DEA8BE43CBDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::19) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <20251216161347.1380195-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|SEYPR01MB4770:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5ed77b-16cf-46e0-0849-08de3cbe2c46
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|461199028|5072599009|51005399006|8060799015|41001999006|19110799012|23021999003|36102599003|3412199025|440099028|40105399003|13041999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vCvFfHv+ABprKa5mf6UYG9fKa7DlfmuDGUb1Nmr/n9ciZp2ncIvvvzw8zJE/?=
 =?us-ascii?Q?OFQaD8gAoNdaYktWgdnq6mUeckEG+E6jm7OfZKfUHixtTCbm7jGsUBVfimhE?=
 =?us-ascii?Q?oablmND+1RgXeC7ECLHgQzoZ1BpYGHJCJfl2DKUjCmhrN05mh6TW1oYrKtzD?=
 =?us-ascii?Q?Hkhcfj3reHHyhp6kdFhmQc40zKVYg0BMUcxoDwUiv8vNGbcDs7Kqw6y+kUX5?=
 =?us-ascii?Q?ZEBrYVhMldMK+Qo6gQ3AF5Cs1y2ugWDplQicyajNGEfEyTlo+GckRdnnmlmQ?=
 =?us-ascii?Q?Jvn01griU+l6g0ZKYgT3JYpb1ZMbSAfqMlG8Vgm3hWiuKm4LlK41mWkDuKN+?=
 =?us-ascii?Q?PR15PddZQHGBnsj/fvVKcTh3Ad+DfWRXp+mpnVO2u93V7v/zyk2zGccnsVTi?=
 =?us-ascii?Q?I5JDlbYU3FtvzbO5pc7tALu2pWst1xPl5E8nMg3hPAKMO8BCo0pxLrdWQXDi?=
 =?us-ascii?Q?xHc1p2orRTTZ68bZJXEg0bHe+8xknPqSouiqGI5/dYvNo0YMjQxXGKwvHsO9?=
 =?us-ascii?Q?PUTE4FB6hGwkhEEBdAzQJTFGCzJSZMOVP2k7CdBoAnMh1eqWu+Gec03LWqqU?=
 =?us-ascii?Q?u4d6UXAVNvFPkPdcueriFlq71uFbwRuUGibEO2gaVs/E9xFHds8RxHPWd4cE?=
 =?us-ascii?Q?qBaRLgzEKFn2nRP37hykVvEfnlBedeGBV7BxibnRuuHL9TW45tlHny2V5Hab?=
 =?us-ascii?Q?j8RJp6Rxro+E4ixXkqXNBT4o2Rf4e+a9N2X0/tcS+Fhgi5/vKEmejIqkJ5hu?=
 =?us-ascii?Q?oDwHLVfhIrMbUtqL/q3uy+0cC80r+2xa/1C3YqfH13UlbaFiBOH2pf7XWlGk?=
 =?us-ascii?Q?KfQx14qgdaqZMhT/ugLTMQt0yzy9PYZ8yxKZ41pIKPTVAppgEld7r3CaA+eM?=
 =?us-ascii?Q?ICHo86bKz8ot8CvD9irRQomRgKTjOysfpPUliYw9OsJ7C2SB8EIcl+MTPZSl?=
 =?us-ascii?Q?9IGndoxKRv3N90b78DNDa6gsH02Nf0PgppqlXoR0zUqHnYqx4b8W7DY57N3/?=
 =?us-ascii?Q?ifIJFKA6BX6QHCdS0YCU/pWSl7X2ZqUMVjsfS9GWYOf0640XQFX+zJ336q0n?=
 =?us-ascii?Q?LQx6XKqK1MfiVPjDwAUDm5TaP0IU2/h+7VlymnIJHSJvtIPkqNuAdhUnYVlP?=
 =?us-ascii?Q?MYyNuPEva0AJGO4et7uZaAJu6qSX3GrApBwpY8Yzvj/kGzNGFFUtsaRbMoIq?=
 =?us-ascii?Q?nKmzMaTaAyVrF+SBuA7iWpKy3JyKN21KUGXuwzQok3pXe4NJYycBwrMnwDge?=
 =?us-ascii?Q?mfLkla/laLqvdnIBQarNtZ7Y3vu0Rc8zPmZUmkFbqDk2CSlbHiA+15LiNeLh?=
 =?us-ascii?Q?YXs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uXrvsYS3uj4/4Lh5zxMNvB9C2y2YyCv55fy1biJJGx0U1HrYdORb21UjhTvE?=
 =?us-ascii?Q?dcePHxZbpKZ6YwAG0kK6g/j1Jmm6vyuY2WWZSrIZ/quABYtgH83icip1l+US?=
 =?us-ascii?Q?etM2J0ovtF/QzmGkLLpwiKWQjkybkZ1q9bK7WBoxIuS7NpeOCUuLxJ6fqFL4?=
 =?us-ascii?Q?nk/oSQ9ecE5JlFcdfD3umNqoxRj4NJWFJJw/HRTjWQ4gN3C7KlpVtc+kVvfj?=
 =?us-ascii?Q?fy2w9IgxjJxpN4PZhkbPtO33AS7ftK9b7nF6FUXGslcGlJA97zekafwDd9Bo?=
 =?us-ascii?Q?q8yIiGL2YnI2KHaPwnPhlVzboaZP4lvuPOGSAa1ZH77kkbQVsT7MCh1j3Q2P?=
 =?us-ascii?Q?2/G7lfzIDSL48S7gVXV19pgsj8xcgQq6BVIlyKRhaaugZAd6vLJDu3K7d31J?=
 =?us-ascii?Q?kyaIzKi2/HkTMohp1+yUVi2/VX/tAAV95lViEydXDHnyIAz5CFZnRgjTAylR?=
 =?us-ascii?Q?MApbrjXEoaeq36KduveJh1IPt/UTo4juNOu2z8toTCNQJ0vAnEsY75eiKQ1X?=
 =?us-ascii?Q?JIpG7wCZSn5kgMfQKoxb93SYh6IGekWT1scF+LlSh6hbBARkfxRExDRtVJyt?=
 =?us-ascii?Q?iXfE90E3fzLJOw/Ys0VzjxLxCqfZKC6cgz+yNr22bAmYTQZ4p58cptfo/5iV?=
 =?us-ascii?Q?4h6VEn/lxZqhar+caaVbL5m9QhOGmOHGSxF/39tFWHCw+ZMY6DDzd76upflL?=
 =?us-ascii?Q?+anOoyfxjBeIv0QAyRFJrSsyroutP5jdGvXRwwguefpzk8k6okqq6v07rxc1?=
 =?us-ascii?Q?eNKaIJK/rJRtDoTm/IgHr8/Cq99jPSS0r+4g/5B8kmIxNUt3vG6bNxa+WvQg?=
 =?us-ascii?Q?ppwQTyWT4xIVNjrr0DOcHp5Uzefw4vjRIm23EgKuaNcn1PuUvl0mfSytIWcP?=
 =?us-ascii?Q?l34lhzp9wMd6TNJiyN/lDL7mrxEMRk+FsPTKsnsJzalJNGo8teEezRB74oDF?=
 =?us-ascii?Q?5cPUZZA0jp8L/NJYJEAcC/tVVrhOKtgoTrt6vLdMgPxvz565wSCz3eFhZVN0?=
 =?us-ascii?Q?FGCql94i32I2sWao4PqsvhDvo5ldx59W2cL09Iq+t6LBrnc1X2w6LkVBORkx?=
 =?us-ascii?Q?AT4SWNVrQzcuwT89mDAXw9amX8InztTmACjOdRkKExHVOC7Yvac8WJAH9AsY?=
 =?us-ascii?Q?zZVpXi66hef3W1U9COJjZhfpLtenHitas4X0EVR1UzFWSw5yRq+dHR9LCHDH?=
 =?us-ascii?Q?9dADWyO19DWVqabm9hdhD4PmDyrAC+AT4NL7CEMoKuaN7zHIt+BGX5JSOew?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5ed77b-16cf-46e0-0849-08de3cbe2c46
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 16:14:22.2974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4770

Before requesting the IOMMU driver to map an IOVA to a physical address,
set the IOMMU_MMIO flag in dma->prot when the physical address corresponds
to MMIO. This allows the IOMMU driver to handle MMIO mappings specially.
For example, on AMD CPUs with SME enabled, the IOMMU driver avoids setting
the C-bit if iommu_map() is called with IOMMU_MMIO set in prot. This
prevents issues with PCIe P2P communication when IOVA is used.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5167bec14e36..dfe53da53b80 100644
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
 
@@ -623,6 +624,9 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 			if (is_invalid_reserved_pfn(*pfn)) {
 				unsigned long epfn;
 
+				if (vma->vm_flags & VM_IO)
+					*prot |= IOMMU_MMIO;
+
 				epfn = (*pfn | (~addr_mask >> PAGE_SHIFT)) + 1;
 				ret = min_t(long, npages, epfn - *pfn);
 			} else {
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
2.51.0

