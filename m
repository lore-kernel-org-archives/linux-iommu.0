Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FB33A6B77
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160313; cv=none; b=jwYdJl1iDTSTNBUFiTMy+2k8pcf2LqOms53lgmd7+/8qciA7R3R1bdexJe1cmRYDxWKoWpHpZhYha7qzfZKRpUiYWBHN2bPFNrovZUWOieAsZfkFCZodl7tpav+/WQD/2BlT7sjLft2HS0Ai1wmpVDN8hO4830L5tK4hQuTxCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160313; c=relaxed/simple;
	bh=+xtDZT7nkCEFSCdY4NJ3dt4/hEG+rUMVBQYgfDNoC0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J4cdQhKGCLEgKZiTfqyJxsmjqzaGqcr8Hy0DoKCzsatjOda3G0RWTcs0tYKTMIzNpaQEXFzvWf167j0lmgpq96EfwgwD3qZpBhL0sZltp5oEOyn6ZtcefEMHKTOaXPzlzKs4oo4Zm3mVuSr7eeB8iQdpgHnso70cDy27KDasP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RHTeeLno; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RHTeeLno"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9AZ1P2581445;
	Tue, 10 Mar 2026 16:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=rSgz4ASEuRBOzKsz
	KJhpdZKXEhkKs1U23ldbMvNQzHk=; b=RHTeeLnoxyIhMsrn240Y1VqMqV6Z0jyb
	h50GxvIDiQsd6G4PrmQgGPa8Fch22KwEPZd9R4ep0g4iZBGWnSZVn5ivp3Dvq9+9
	WQWOntE4iqguIys+t0A2SmQ30Kvnn2nXeD8wcoGhWMAt3xN2uCIP3fCCGWJrrTtB
	SZSLF2D9lxR+GSJMRAgWF8Y6jGkeRqFhHkl/tCRgnaJK/opiKeq1hFO9PBTy8asl
	0iFSNdmSHnf5N9bHeQ5jvXc9j6TDmN7wlT9ZRiQ9kOAS77762RZfJAWkF4aK5ztV
	oS2oGwFKapWlXtCcmFgO2UtchHmU7xFakjOe0shWhHA6UD4g9cSqOA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csm9cu7pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 16:31:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62AFQE3Z038383;
	Tue, 10 Mar 2026 16:31:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafevmry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 16:31:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62AGVc8a008788;
	Tue, 10 Mar 2026 16:31:38 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4crafevmps-1;
	Tue, 10 Mar 2026 16:31:38 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: jgg@nvidia.com, joerg.roedel@amd.com, kevin.tian@intel.com,
        vasant.hegde@amd.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev
Cc: sherry.yang@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] iommupt/amdv1: avoid GCOV builds triggering FIELD_PREP build failure
Date: Tue, 10 Mar 2026 09:31:36 -0700
Message-ID: <20260310163136.1179322-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100143
X-Proofpoint-ORIG-GUID: SdiDRQwfvHOWLU1v5mqh24j0twY4lTuS
X-Proofpoint-GUID: SdiDRQwfvHOWLU1v5mqh24j0twY4lTuS
X-Authority-Analysis: v=2.4 cv=LeYxKzfi c=1 sm=1 tr=0 ts=69b0476c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=ThXoxqst169cUD3MQKIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13819
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE0MyBTYWx0ZWRfX83U6W0Xt6Xfm
 4c/sHYC+UpC8XTtjYf8SJvssDTo8g/JzbLC9MceZpuwd79jwhCRI9upo5BufuXsfv7EC6oGznV2
 0qUfwp54kmhG4UeTC9m2GIoUJj4zd3SXUQsoS9XOoxfU52QrU9E9qUG+UAMHFPxSXFh8oY6FZbx
 Tde8nGVY3Ku5fmlfaZ7sLB49XLAKaE1le7N0SEq6pbukbM9hjZ6v4wzsr4L5Zo4IAspSeIN0HwA
 64W1Ui7RbKDMZ+XSsjJnJFif5oqkKij5X2s00c84qs+B0S7tn2bU8DDAqPlri8Q+/jCxJDkGW6p
 uPyDlLowJabvLzKpRiO8nChKqDIYJIOr74zIVIXLMORp0A/F452Gtecs0R73S4HXK668NXDPj7L
 DeiNuimcbxw44Q2ooeHhBQ5yXlXW7CHLYCSHW897nupTGczGTGqxUkmaumfaiUmH94XjJhmWE2l
 cpAmwpvi4nSGgnWsLaG6tjwMI1PahBOtrAJ1A2Og=

After enabling CONFIG_GCOV_KERNEL and CONFIG_GCOV_PROFILE_ALL, following
build failure is observed:

In function 'amdv1pt_install_leaf_entry',
    inlined from '__do_map_single_page' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:650:3,
    inlined from '__map_single_page0' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:661:1,
    inlined from 'pt_descend' at drivers/iommu/generic_pt/fmt/../pt_iter.h:391:9,
    inlined from '__do_map_single_page' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:657:10,
    inlined from '__map_single_page1.constprop' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:661:1:
././include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_71' declared with attribute error: FIELD_PREP: value too large for the field
  706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |

......

drivers/iommu/generic_pt/fmt/amdv1.h:220:26: note: in expansion of macro 'FIELD_PREP'
  220 |                          FIELD_PREP(AMDV1PT_FMT_OA,
      |                          ^~~~~~~~~~

In the path '__do_map_single_page()', level 0 always invokes
'pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT, …)'. At runtime that
lands in the 'if (oasz_lg2 == isz_lg2)' arm of 'amdv1pt_install_leaf_entry()';
the contiguous-only 'else' block is unreachable for 4 KiB pages.

With CONFIG_GCOV_KERNEL + CONFIG_GCOV_PROFILE_ALL, the extra
instrumentation changes GCC's inlining so that the "dead" 'else' branch
still gets instantiated. The compiler constant-folds the contiguous OA
expression, runs the 'FIELD_PREP()' compile-time check, and produces:

    FIELD_PREP: value too large for the field

gcov-enabled builds therefore fail even though the code path never executes.

Fix this by keeping the compile-time guard on the NEXT_LEVEL field but
encoding the OA field manually after a runtime 'FIELD_FIT()' check. We
shift-and-mask the value ourselves, so the compiler no longer evaluates
'FIELD_PREP(AMDV1PT_FMT_OA, …)' with constant inputs, while we preserve
the range validation and resulting bit pattern.

Fixes: 879ced2bab1b ("iommupt: Add the AMD IOMMU v1 page table format")
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 drivers/iommu/generic_pt/fmt/amdv1.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index aa8e1a8ec95f..c0a200afbe79 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -214,13 +214,14 @@ amdv1pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
 	} else {
 		unsigned int num_contig_lg2 = oasz_lg2 - isz_lg2;
 		u64 *end = tablep + log2_to_int(num_contig_lg2);
+		pt_oaddr_t contig_oa = oalog2_to_int(oasz_lg2 - PT_GRANULE_LG2SZ - 1) - 1;
+
+		if (PT_WARN_ON(!FIELD_FIT(AMDV1PT_FMT_OA, contig_oa)))
+			return;
 
 		entry |= FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL,
 				    AMDV1PT_FMT_NL_SIZE) |
-			 FIELD_PREP(AMDV1PT_FMT_OA,
-				    oalog2_to_int(oasz_lg2 - PT_GRANULE_LG2SZ -
-						  1) -
-					    1);
+			 (((u64)contig_oa << __bf_shf(AMDV1PT_FMT_OA)) & AMDV1PT_FMT_OA);
 
 		/* See amdv1pt_clear_entries() */
 		if (num_contig_lg2 <= ilog2(32)) {
-- 
2.50.1

