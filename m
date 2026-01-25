Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012053.outbound.protection.outlook.com [52.103.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD96330640
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768798812; cv=fail; b=aC+aeRW4PpxeXFTl+CG6OxryvG9Z0efh1lzVJiInNQqK5eIAJIng4RnJrJ8Lx6rEeUdrBKTBtmT2uC6Xdk5cM05AhraszwcmdSyzVzA5rQ9qwdOnbXBMUJsDziECNod94EsLalCfojQgSMNPRGuK9T6FwCBQ6Uky7/yIhYG2Nh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768798812; c=relaxed/simple;
	bh=Er+11eU/JTH/LyyRaqAJQfmKPLWPpRK6/pu6VJNwFBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYoa+oca0sqMYcsJIVlAOFA1OpHf8xsLquLI3R+8KAYY1Crm+q7z6BU1sOGuJ5O2T0nOKrDLDeznY86kkXqMv1kSc472WtQGgGZs5it/nGBpzASwA3cK5h4Y6HPS/0tMCPiQKiAz6dW9VEhAwQFs21wYjW4zaWTgf2o+tHXb3qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=YjTsfaQK; arc=fail smtp.client-ip=52.103.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YjTsfaQK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hff15Ot72ZvLd56C5TGx47oaN7x3fEghmPNs15OVcZqmGTuGGClQ4TDBZDNxTc1eHs440bERz7tE+yU54EP2WW61+J//d20oBzWQqtwRZPhFbjgakJedgMxpg51rZsgMgPkqUTnB70Pq1IS11LeSl2nEvfMrjlKMAik9HYRzmOpVW6fWwkOQC7O6lqH7O44rE6L01nLIe+j+lYDXj3pWAKMbccDdtDhBCDIi4Hh2UwpYTE5Pbg79HRWBSuT16on+1+cSZgWIIj6CyDyJYvN5ooiE0rcDNm5etUWTy/kSh9RNMfASxdQFkZrYEM082TUjd6H9ED7kb3wd+uHFImPkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkhnqalxoP0Ieh7rBg4KSIOVUqSxZfJg/mCa6sIFBMc=;
 b=J/99QFUmfQqKBMy3Hne5Ap4978gDXYCzADS+YhBS/d6kBug/uz80O3HR7rFpMIJMzJxc2nfaONqCiM0d1AWkpbVVe4ZsLrpqZlOrzti690zTFP6CUU8QpnX99mygrtJn2ebQwZCSTC5e0iDJ+tk41KZ2MI1EOQVXHS5Iite1xTgh2oHDu8tPDxv3CAflfPZ7q010jIEcZLpeVDRqiQs9gfqV1mQk+KeqWXzBntZcGgTNN3nWyx0y++JO0y4Dwjck/DYVt6cM/yu9uRVLVMWARKJqAMy441JHN1jYDs2yU4cmtvksGcUYIsEdHMuuJif6i21U7huTNgt/qxO/nY17CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkhnqalxoP0Ieh7rBg4KSIOVUqSxZfJg/mCa6sIFBMc=;
 b=YjTsfaQK6a0kK0LjUCSrOYGweRjF5y0X+jiEK1frDE3T3NFV5mklHmb/iFVCurNaXCtG0msdtbJCHEMBRoozvAAoofW+wtgU8urdWn7t7zYR1ihx7tqb0GeJqZUOvB/s2SMyCuJKdpMeDJUVNN0vLVgSXkuwP7Zrfm9OJG6orse0S/R7Ojyau3Lr0MJAhLRGBYEeRvfjTgsM/zgKmOnhkMq6rZqmHBMYgiQG2M9Tpi4mpfkbcSxRxGDQwoFM5sxnD92tqnuYVKVGbCZxAdt1j9TH+15rV4VhMQgjMy4zXRWmkkbfOx/EVvTGleOL5kb5cl+Sj1NyeuemKOEHd/SGCw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY1PPFBE0E41249.apcprd01.prod.exchangelabs.com
 (2603:1096:408::34a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 04:59:59 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 04:59:58 +0000
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
Subject: [PATCH v5 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for MMIO-backed addresses
Date: Mon, 26 Jan 2026 03:19:21 +0800
Message-ID:
 <SI2PR01MB4393E7518DD5EB5839AD136DDC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393C9B731ABDA050A336166DC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393C9B731ABDA050A336166DC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260125191921.831033-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY1PPFBE0E41249:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d23748-40e5-4432-3ae7-08de5717983b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|8060799015|51005399006|23021999003|19110799012|41001999006|37102599003|5072599009|461199028|13041999003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?meJZrILwSFjaqvjRaxnVmp5WdTPkOfTDAN8ctoJjmG2g2Hqm3aNHDCm2qRgE?=
 =?us-ascii?Q?5lBkIMqqDbcfibKblXZ7gQia3ysyg4z2r6sA1Zks1mnjSm/mfCJZ7DeFQVZx?=
 =?us-ascii?Q?3fMQbIvAEm1HNfPxEZ2xaiHBfzmvFuuBRlY1Us65OKWosm3Y5gx9yeoIsnBy?=
 =?us-ascii?Q?8+0fQEHbFZsE4vcUFAHjPJ1BMu5vDgmNZYkijNwzBQJ622d5YuaUfGkc3N2+?=
 =?us-ascii?Q?ZQY1ZT3WbtiHF9cmlu2kaonZoXC2fkZ6qH6coigvVjr7GOzX9RRbhNVmsn39?=
 =?us-ascii?Q?mDr3zFLYJr39hoqFcMUhpqL8k2ZBXtp1tK/TRtauqBg9MmAETtucyX7bMKQt?=
 =?us-ascii?Q?1igKBzGw8/SsVub942bIuUnE7GOakb6ox5S4W6uzKdKUBBCJCDi8wq/W0AXW?=
 =?us-ascii?Q?6SgJ3oLegW6zENN/F8w/h7J8zGTp1/GIyKLa/k2MpbKWOGZqZg4Mms5F0HTY?=
 =?us-ascii?Q?Y3XHgT7e7kBMWeDgRhUlZVdbiYO9JjZhTdfZkkJfRdm6fiGBIZIFsvmZWjTL?=
 =?us-ascii?Q?w5uywpIp/4cFHYNbMii4oIyMR0I06KO7Tk76jDwTj6ETB0I1/g4DR5CSXXx4?=
 =?us-ascii?Q?Okth/ziexWr2PaVEKSYAmGe3+UUEranyquEFEM7CQUCIcb0WlmwHtVgQvlM1?=
 =?us-ascii?Q?AtTJ8VV3nmqnm5VHK5RYWnPGJNd8AGBBJoChxUTFkpHdXdcgSIhgv8oCHkOm?=
 =?us-ascii?Q?vkHHngDlN+WysnrKuimIyvHTpC3gnPIRUflJ7UfO7Y+yBmm41lSn1xdkIs7c?=
 =?us-ascii?Q?f6r5D1pHuyfIz+1EDQTMkE5mTog0gLb0PpK5vVbaDUYuxHOJKGUHcFy0NXvD?=
 =?us-ascii?Q?y9/kMBhzH7Pw5RmcdnYJxG3h/dYPrrCHMxe2xlRUbcVD7IV2dB07jJQ1j9X2?=
 =?us-ascii?Q?5O3idhlO44GSx6cjdeoRx3qBfN+wkG+ktW9kma4LDMKq7L8Y08388KSgVOY/?=
 =?us-ascii?Q?CSO1iCMie0VWwPHtO8VnF6n/vH+PTdgw1hnAODxVqPJSlfqXH/T6Zux/1GLR?=
 =?us-ascii?Q?3qypaDTDBx5mQQ9kW7dCZufASGYg1uEVyo+kmJI1VtdCs+a7HlhV9rlBGlvD?=
 =?us-ascii?Q?gamnR1NZb0tkRVR/6LRvm2uSCzcy+YJbowIkFuo58wFCdvNAVGPIvL65wiyY?=
 =?us-ascii?Q?LFR+le/Ty/84mcjr+1ZVHFrxTDVai9SwmN4ahnKyj12ao/MkWxFz/kPYcgip?=
 =?us-ascii?Q?OQCO9PsKglBhP32GJk0gRLsEVMzBREtH8fTmp3wfTW2r0sJCGtd8CE8cFQFj?=
 =?us-ascii?Q?T9XucOVcxrgGCko3doiG+aiBqhaduKfR/jybzDZaRbVsNUDQyY6nqRx3q6Fx?=
 =?us-ascii?Q?/ac=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YFJ622dBly2tNXtXjHVfiwLSrNQfZxo7LZAPS7P6AFu2rYYWFr0WAqweD/I?=
 =?us-ascii?Q?kzzMlZ00OcyKEduEd5BioIJmbyIRBYHDnZ1qQD2EhpjidrjtXIxole5Tdjxq?=
 =?us-ascii?Q?P+PHpFWdhUgMlwtHewcinwbDJBfLZZQrROo+q/2olsH9QqlCQfknY9j8AHp+?=
 =?us-ascii?Q?DCyZNyXSeIpeiKhAwXvJJOO21H9HN/2kXCXmChqQaIf51Ie5obYPDtGE0cIu?=
 =?us-ascii?Q?RSOzU0OTdZpYJrc+iO4DuS1zrJ8xvJORFpAAPK+F2wfIldhipT7eF13LyvQn?=
 =?us-ascii?Q?a77tAqzfX4mTDBtZA00sWUiJVk5MVmw51fwyHekbGr7JfyO1UMCO8MRD02RS?=
 =?us-ascii?Q?944QLfzEq0AF6hocW+e/8RGdZQ0Jp3ioKZDUDSHuu/gIcOuYSbhXeCP96mkY?=
 =?us-ascii?Q?VP5OHphHYabGKwbp8+YKzrFCbRKFHnQrxkOK6jv4XoKXpv7OfH+QvGoy9zzV?=
 =?us-ascii?Q?mXat7hxB3LQkiINrcn6aZ1Y2XX9OaiBliHhwNygZIU4lW8KvZvlD0s6/6UVs?=
 =?us-ascii?Q?7b+NeuWRg3wn6AmwECm1Tpfg5W6UVBG3di4E4390AwOLuoBXBn8zjE2tEEOG?=
 =?us-ascii?Q?pZ6UKN127cwVs54yLDt+YW3YCff38lfpvwKEqYqZ1biPF983J9rZNHab3wVL?=
 =?us-ascii?Q?dEsmrf9QbouMCLsyYp+wuHmh95GNY335RUkKWis4PT43YglsKpNKVf0nm872?=
 =?us-ascii?Q?93Y2olP3CX163JQQgykpnc0rHG9DGSBcNdS0kokVeLo/tZZzTaLa26UCYol9?=
 =?us-ascii?Q?u71DpZb6p4FUh5JbldvpTQMg2mLThrI+zck/z6Cn8FgA+WzPQW9qYa3l/K+Z?=
 =?us-ascii?Q?DaABr98WXBfwDljJA2FkE9Q4pyQp6BkwS6+90jE3TslABegURTdKxw4pW9q+?=
 =?us-ascii?Q?p+pb/EP1HjQMOFeJ1BChO+Ke7rynpu+BYy7fghAxpGFEg8Z1devW5n7ywIKi?=
 =?us-ascii?Q?hLXrefMHE+7VgU7dxmza5Ic/LtW4WL1AUSKOxadTnCWdgQXZbDvoMPsuLABQ?=
 =?us-ascii?Q?u2YM8d+hk0fqkuD6DPJaS8DJBp0ciVvrRNWvqwsbfbYays48rdq7haOKCyK4?=
 =?us-ascii?Q?wPMUbWBjxfHV6XzKAyhPtXbSzGp0n2snwqWl6ZB5G0dwE6rGu8N67drmBhFF?=
 =?us-ascii?Q?xp13vZyB3lRaM8WRIisDi4Jsd3qoLG1BAfB+Zdmmj/X3q0b3X2B6anx2EK+g?=
 =?us-ascii?Q?a+3M7++5a9y/175ZkXJPxvQb5xYYsVGqTwI5ANq73EUKNB8jzApED5cwsBxi?=
 =?us-ascii?Q?B/+1ppsdTILJ3BqIyi2klXk1jbyxWz4ReTP5HuWON3IRGTqyUroIhrGj/Tt1?=
 =?us-ascii?Q?OHgDqtlDMw6YcKBQdMdM7LHIIttrJaGDSUQsoYJJs177JmKlDr2867JxlFay?=
 =?us-ascii?Q?rcmNyTiUwtGv2/Ps6iRKY5Awu0bQ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d23748-40e5-4432-3ae7-08de5717983b
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 04:59:58.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFBE0E41249

Before requesting the IOMMU driver to map an IOVA to a physical address,
set the IOMMU_MMIO flag in dma->prot when the physical address corresponds
to MMIO. This allows the IOMMU driver to handle MMIO mappings specially.
For example, on AMD CPUs with SME enabled, the IOMMU driver avoids setting
the C-bit if iommu_map() is called with IOMMU_MMIO set in prot. This
prevents issues with PCIe P2P communication when IOVA is used.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5167bec14e36..9fbd2ba519ca 100644
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
@@ -615,7 +615,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 		unsigned long addr_mask;
 
 		ret = follow_fault_pfn(vma, mm, vaddr, pfn, &addr_mask,
-				       prot & IOMMU_WRITE);
+				       *prot & IOMMU_WRITE);
 		if (ret == -EAGAIN)
 			goto retry;
 
@@ -623,6 +623,9 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 			if (is_invalid_reserved_pfn(*pfn)) {
 				unsigned long epfn;
 
+				if (vma->vm_flags & VM_IO)
+					*prot |= IOMMU_MMIO;
+
 				epfn = (*pfn | (~addr_mask >> PAGE_SHIFT)) + 1;
 				ret = min_t(long, npages, epfn - *pfn);
 			} else {
@@ -709,7 +712,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 			cond_resched();
 
 			/* Empty batch, so refill it. */
-			ret = vaddr_get_pfns(mm, vaddr, npage, dma->prot,
+			ret = vaddr_get_pfns(mm, vaddr, npage, &dma->prot,
 					     &pfn, batch);
 			if (ret < 0)
 				goto unpin_out;
@@ -792,6 +795,8 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 
 out:
 	dma->has_rsvd |= rsvd;
+	if (!rsvd)
+		dma->prot &= ~IOMMU_MMIO;
 	ret = vfio_lock_acct(dma, lock_acct, false);
 
 unpin_out:
@@ -850,7 +855,7 @@ static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
 
 	vfio_batch_init_single(&batch);
 
-	ret = vaddr_get_pfns(mm, vaddr, 1, dma->prot, pfn_base, &batch);
+	ret = vaddr_get_pfns(mm, vaddr, 1, &dma->prot, pfn_base, &batch);
 	if (ret != 1)
 		goto out;
 
-- 
2.51.0

