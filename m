Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013086.outbound.protection.outlook.com [52.103.43.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479F2FC895
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049279; cv=fail; b=nnihpUhTCtpu7STFrDLRIVXUeNaqIyNZHimlzZjkwNKae58HR0u0H9V70mECWWe/dFvUlViS6lrHKygf4E6tSKV87DBd1LfdzA+HHqj2rbulXiqWp232fqR4OwA2p8kkmQJVfY5Iza2Wa58vbf45GZEwmIhy2gwK7SbTQGgXFxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049279; c=relaxed/simple;
	bh=3e5gkbyuedpTO/yNFkzFPTa5V04Nmb+J7X31ZRFK3To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=suSnYCbuVbQF+laZxI0IE+vOFeQPLf35/QwVuuL0vquXpQth36++PBv6PKdLWniafSovZl4thBn6LHBqdt6npB6JlSBK1fl094LhgXBj7ynN/CH5YqelrXtXR27NE4nTuFCZxfcA4rVNxiZjyTQ61WuDR1K+0wTX4PKvRR4Sl/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=uW+Ljf6j; arc=fail smtp.client-ip=52.103.43.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="uW+Ljf6j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8HibYT8L7Zyd5T1/NY7yiJUPBF0VqXrriQzNxNneceYneO4pvD39vujm8+ksGR/+k8z6uTgMS9SkIo4BLljnD+crJNBIFYDWz3RrIbArGu6ZD6e7pHjQcrkwvp6VNkD4VtBYECHxsrsQx7BB4KvNodzvqJuFJJpIbJGKx0fNXThWUHzAoE5M4bsjsO9D0KTJWnzmP9YongUbMtNkKTvtjowEci4lmb2vSyC5kGi+lRSsKRARWvvHxUefbY+gK0ccIGYRwXAfiQb6ikouTuGVuHBgP7GVeduuL3RkfX6wBv4lkdaJzqgLpMtUlORupxo6Rhuq5dor9tzA7kYwb72lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xtQk2s6OehG0qYwDMreCMlenM3Jl3eaaajcvgYIbt4=;
 b=gUpPyBxvx2F/cRXQo9S2nPgLZLwWuCDHoP7UcwaL4TQEs2rbMAmZiKIrYZG0sCMAE8IlL+J0Chz/F4xYuYEoghOfKIHf7b+6od5a2joo1OyNbswPt4n14W7hAVPj5PMVx+lJTzM01kCxefoXA3+t5vm6vHzJdDP1HbgpKxVEtZY35a6uMJZy6y7ByqlEjflwHu8GqV5WK9KncRKX0uVX78E+gifA3GtvinFN3j8xBZro8aneyhZYMRHrP0WOVripAz/NMsC5ZojKLYW8lbKngQuBr5Yyqr9hQ5Ifz+ryP+KIJIxhqucyQtOD8dH/u2H84ZiH4ktyPuRnlTA1z2insw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xtQk2s6OehG0qYwDMreCMlenM3Jl3eaaajcvgYIbt4=;
 b=uW+Ljf6jdlkVjtoWCZpbRvAbX3mRXsdsCsEkyBEOYuRjJJzHHYPyrFias9EGeiPmCVuv0aQZ21TTFDYDwGf9EF0hBK3I/RvIWeIIQ1eyV9oTXO1nATxBgPSwwlJ2NlVfbI3B+OvR70AcYYsp8yaumNJ/72gHMOTGFTGhGINULrPFuYSed+dDMYFw79yI+ixRBU04OT/FPav81xu+eac4kyozqHdHbjm05HOVjJ2XqN0oMVmpACNQpLHtZvdcGlttSuZPOHLUnUhT4GuUUkSlaEKCU69ABkVabTIEvJT0i6kcCdsicDASAwjRRA9+IxFm7K8OT7P+KakRXJEF2MGHKQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SG2PR01MB4170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1c9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 15:54:33 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 15:54:33 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: alex@shazbot.org,
	jgg@nvidia.com,
	thomas.lendacky@amd.com,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org
Cc: aik@amd.com,
	kevin.tian@intel.com,
	wei.w.wang@hotmail.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH v3 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for MMIO-backed addresses
Date: Thu, 13 Nov 2025 23:54:07 +0800
Message-ID:
 <SI2PR01MB4393BFD04F698501F19013B4DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:405::16)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20251113155407.1183804-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SG2PR01MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: c905f470-847e-4947-4444-08de22ccefff
X-MS-Exchange-SLBlob-MailProps:
	qdrM8TqeFBtg1x3yx1r6QKZAk6LGeuzaKyVfLBFadWQsdG4QSKsGXBXN50aluAqpGx6eYqevoF4Ud6ASkRmCdrxalhav0X4f7zJR/W7seRxZLgcLzXF+X5Y2jSYvjL3QpJsJw6Lnrc+pqcagS5fscyb/eb0aQrbGRhGqk9cWJKfOvADs+Q1zO50G6ZQZ73L9ZXSRpFWA0zQUjBcxj6ZKosb8GGDUyPD397X5W5k9qwF/R2Ppf3/NCFjv37159psCCslHNf20VGXcAa+UP9xpyUsI/7UoflnrLAxhuSgIOoQmABpCxhPg26iAK+dDDmD4J1aEm/1FYeMB9Da5V7fJh7WOqGj2On9A2J1TgNJmB+mva7tbsw2c8a7zXcilniHwpwR3mxrIWtdzci1ZFWGtK+KJoe87ZnF5R394sjnJhPY21dhe5IMmPK0b+w7JAUpG5uIRdWOzMdBgzPWDCjlf23HlCJpAc0TfEazLI5mzB4VD58XtjsVITcWR4gehrP1hI+LK4pZFzMWeU+q7JrxKW/QP1k52izafRPdkHbnWwLk+Jxs3cfzGeiQhljHXrcEB9HxqTEZLfzXyvGydHJaQFcoxQkRU7S0Imvav80Nfl8XhABGv4XfunUZGTD1Tz2rhTdHfWiB0vONB1Pt4KYGbOm1NTB1VXR4YLRbPmjevelu09deIdxosE7IRbbaJWzgO3yofQnHn1q081oazfAU+YeJwhosGO7xy2kIzUeZyFSwIhW0Krtz3dZ5/tWyEYUqpinqtEjPV6neMZSaZcp+AxNXovfk7zdYS
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|8060799015|41001999006|10112599003|15080799012|51005399006|19110799012|461199028|13041999003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3vKRotDIbxAiuU3HOBsO1JMl3IFHjknyu4G1JA14ocP1efem8WP3nXNrm/ql?=
 =?us-ascii?Q?ZQTqvQH/VoEnJI63FmKSnPGt/ffh0ac5MpLHNBe0bMbO9urwI+zwWfezsQvE?=
 =?us-ascii?Q?0WZNhU5vsf9hSvAfP1q4iivpCOl0V9byalxSy+XDZ9WaS9JA0hFgSDapwWNI?=
 =?us-ascii?Q?j7IaW5MvPikKhS6qHhjTg3v+let8l31oXx3o1UWlyykavpzYC0zmWTfEmyrw?=
 =?us-ascii?Q?WWV1TVON+nXiaTX83QGRSRSKYdr1c3VNRLr2MSQBtFmngaYnuWUerw3lnvH8?=
 =?us-ascii?Q?zPw4Bf2wjDZYLUm0UafNtDa2rTsFzVJXimiRbtu6VFw2oEyrN0IDObVhSfrK?=
 =?us-ascii?Q?JPS2fqkEUuwN0KSU/bw+oF3BXDeJ9guna3qOyu3fqwFuozuX0U2DyP0mLV4s?=
 =?us-ascii?Q?GKSheCPAgfqO2j+R9P2OVmealbAGyngzi6i5dpo/+pfmpqjq6KQfH6y4H2B1?=
 =?us-ascii?Q?8J5tirSFFwL9uAkm/1R7dUdsTi3XOXTwI5nQD+JB9yiXu4799dETZ5HNgbwU?=
 =?us-ascii?Q?HXGyBt1co8Qg85knd48TI4nc1Df9gClY/Mm/rVKW1JPDYRhe/kUdJXsgPgFg?=
 =?us-ascii?Q?KS2PxNeooMLu7HdP9RMhprfkcKDY3QLoClusX0rZC0lP2GTA1HHmMxSZ+fHg?=
 =?us-ascii?Q?445cRocl8v/2qg6heuGCsgbjJTz09IhROGLYNo0BUOq3gGK8KDeIf5Zp9G7d?=
 =?us-ascii?Q?8yN2qg7XGIYxRDRzJ7cJckLQS+AxEiWrZGMyutL0zNsLI40w28Bl0owvNd9M?=
 =?us-ascii?Q?WI2Q/SXqxGwhXDtAzoN4khvE6gYF1UL6PBbTmOrgIhnwLr5EuLBQjvq8zBNm?=
 =?us-ascii?Q?2rzP08N51t+nT2Q3c2RiX4yK6ZFH3KlfRjQFaj5WRj41byj33+LGbIqrPdvd?=
 =?us-ascii?Q?jEfxHImxFFp8LnZam09JnXvTiP6Qg5VerhHTJS98Yk9M/TtaOHJx2kT4CEZm?=
 =?us-ascii?Q?OqaP3DfGKrJRPNuxcKEByy5WgKvwi0R7DB75e72Otk+OU/4oizeWFRKR5W70?=
 =?us-ascii?Q?zBxFw04leiNW50AMhywzHham76eZ0waPM1FlBI7VMSjN7qsAl+SCQrmxOBFa?=
 =?us-ascii?Q?4o6X5dxglPvs9rNXZ9jpPW5i7yt+IkpIUf1vp2aUpf1k7JFNSXSNn5VneAh4?=
 =?us-ascii?Q?7SZqbdEux4aoTpySA5w9ppqk2QI2JpzeBE9G46m0xbu7Hss9Nexsag6J4W6j?=
 =?us-ascii?Q?4zNpUY2PnvTMhg3geU4JpUz5jwdu8SDT3GCbwxWgbNBLr/QDJIhUN2m6uSQj?=
 =?us-ascii?Q?IE64DmAXd0Cfaj/v9qOi1Vs+6sGQTAgaJ6TMQf+Z2gqm8CVCyp+ZFxGlmcRM?=
 =?us-ascii?Q?J6M=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?719ibmsv0D32Nbr0m1tiXCN2ojQjokTHcPXndcJ/oYS07C/hPTuKVLNz0dwT?=
 =?us-ascii?Q?Muj3x7tk4GQAUnugLVoBxhHUTbHMSHIFWYHZGeUVvPX7vXxkdcf4/B6l3+x3?=
 =?us-ascii?Q?9KQmZOjUFDjRqv5DsyY+BwH99HQxrIC4NfHj9AJdCGMXHkNHaM2C2+Q48Lwf?=
 =?us-ascii?Q?HpH7tXhB0uOPwaAcdQ+lxgEl82JiFdva1HmmxlRWFKIsehuxS7jrsIMpjcY8?=
 =?us-ascii?Q?DH5UpC44v0zRqxmHXTWDLwGsxA57DsuA8j8dQDy6k0ueTRPi9ckpI+/+SZ+1?=
 =?us-ascii?Q?k6WvobidPUrEsD+VHrLam8kI+PyMSwXCTdQUpATELzINi1GlSf7fPsbIWLp1?=
 =?us-ascii?Q?fBN64FjyAV+5PVRoUiu4uCy4J4V4W0Cd+bQqenet+A7xtsPg7+kRETYSIOMf?=
 =?us-ascii?Q?f50qPEkO6qZXWQQ6WvN+vP2lBTfc7t16Tv2kHqVvCbLcR17Kpsf/8wjuCoJb?=
 =?us-ascii?Q?L3WnmaManzUTRUPfaHZZDISfh/aSLrBozGelmLkUAgjrQ2+FsjMgYEzJcY4I?=
 =?us-ascii?Q?o+okRPWEKnhU1On7nBzwY9waVV87o7DGVPhDg08+PSyqAf7WtDg2Xpe2brX1?=
 =?us-ascii?Q?/DiNa3w359rZOyltOWwHgA9ddoBIVgjLafosRiClChUYCMP0FZiRnXlYB2Or?=
 =?us-ascii?Q?7+zcdCIJ6L8Ub2nutA1z1bFgNjrn/8nOW3Idsavj+XiIHaUbhZOWWmGqyLXn?=
 =?us-ascii?Q?f38IAM2vj9MbqgHnJlrQpL0hmOKosb4y0vhAdzJpQqbj9YE7DhZZz2tTFrz2?=
 =?us-ascii?Q?n459/cax7si0W5theo4WrXe344dsr6OXGuxvzKT/yPEsn2Un6MQ2LIafmsv4?=
 =?us-ascii?Q?73MqISF9V1ViKtYvB46H/IDiNYrD+Qw6+XxqHq9+HoLfOg6kFw9E/F2PAK7F?=
 =?us-ascii?Q?Ha8S39vEI1wTQJ1h+G3mNozE65wvHiDLgoKUW1nEGwuDw4dSRovdMDZFc3XC?=
 =?us-ascii?Q?9Z3H8ClDn97zKvtkk5MvFTQ5CcNf0Lw8ZYZZS8M8YocdrCyor2xTWxKGmd7a?=
 =?us-ascii?Q?tuFXxo0+tKDpdAkGBp7NK8mc5kwBvZruUAu+WrW9MffGPfErAoy46n2+9lV/?=
 =?us-ascii?Q?h2HPKrnFLh7WhTeDNeGS2noup4At93ERuaNOMoFBEdTqrIeQXXJ+UQHH0MaM?=
 =?us-ascii?Q?yCHkiPYXuJYDn5fj4HiKcBWw9qukkrSxmuMx8aTrj0SIS4TaP4oyiXipuz3O?=
 =?us-ascii?Q?dwhFOMZOMHGUwnrTQtzUHr6VuMOKxRnGm9LG40MdVVRSJ93CzI6yQLuQJSI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c905f470-847e-4947-4444-08de22ccefff
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:54:33.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4170

Before requesting the IOMMU driver to map an IOVA to a physical address,
set the IOMMU_MMIO flag in dma->prot when the physical address corresponds
to MMIO. This allows the IOMMU driver to handle MMIO mappings specially.
For example, on AMD CPUs with SME enabled, the IOMMU driver avoids setting
the C-bit if iommu_map() is called with IOMMU_MMIO set in prot. This
prevents issues with PCIe P2P communication when IOVA is used.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/vfio/vfio_iommu_type1.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5167bec14e36..cde7cfcfd61e 100644
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
 
@@ -629,6 +630,8 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 				ret = -EFAULT;
 			}
 		}
+		if (vma->vm_flags & VM_IO)
+			*prot |= IOMMU_MMIO;
 	}
 done:
 	mmap_read_unlock(mm);
@@ -709,7 +712,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 			cond_resched();
 
 			/* Empty batch, so refill it. */
-			ret = vaddr_get_pfns(mm, vaddr, npage, dma->prot,
+			ret = vaddr_get_pfns(mm, vaddr, npage, &dma->prot,
 					     &pfn, batch);
 			if (ret < 0)
 				goto unpin_out;
@@ -850,7 +853,7 @@ static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
 
 	vfio_batch_init_single(&batch);
 
-	ret = vaddr_get_pfns(mm, vaddr, 1, dma->prot, pfn_base, &batch);
+	ret = vaddr_get_pfns(mm, vaddr, 1, &dma->prot, pfn_base, &batch);
 	if (ret != 1)
 		goto out;
 
-- 
2.51.1

