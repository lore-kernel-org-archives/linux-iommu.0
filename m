Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DDA3793DB
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541858; cv=none; b=UCI0gjU3NvGJQFnjPKWBoanHPziHcQniGps8hS2C4t3eDUPaalICj8Vf5q3Ep4I4LNML5HNzzI4WjMuy8Jo9ubt9miZltnl44r1hpYdf1tGFLzBnL6XtECgs2g9oNQRDwickpu/uJHtJ9i403lcsu/lfWyRp1OGyZBGfTMGXXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541858; c=relaxed/simple;
	bh=kLuNmu+B9ZTNwGmG4E6FmnXOTaQyPLrqtIE2IdzJVbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OnZrIGMJ2kXyTOrt6hxZZR+328pfAR1zOGwrqylWCEOT1Vc0S4ys4o2UsnvUOPzEHuWQ9qodrSldx7S+vwIpf5wIQxuCa+3haA6/ZxlnhF560rGyUc3Jk1/p5y49urP4RsU93YV6kG4AW8zSQiYvByZPhA/mGd4RBuE9RI1XNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=siGW2K8x; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="siGW2K8x"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFu1VW1902480;
	Thu, 26 Mar 2026 16:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=kt6PPcel44d01XI+
	T/eEx+sPHHnjvffcKTBQfAS/1LE=; b=siGW2K8xG/GDOLg1qFsbvwM16/xGOvOW
	tCEva+iZ+TpOGwysEMcCWoKPcY7YIRsd6nBSez+RG8vxf60OsOLrSEkK3RkUkt/h
	AwuoMVHqcR5zPcAVuT9IqRor4pvY5Skg/5ddfkBBq/q1h8CK6mEk2hmtbPcoiDVM
	POq94qom22nLowlndcGMUc2ePlfLneog2y4NRW/Kxdo6wcKA/Xnh+16SvdZ7iju1
	yVh+5Rr2B1TgEEpPOrY6oOyObCyTenNOhHvMAM+Qan0bbEaFYuOoFTs8u5yb0lSl
	iPIquxgTZ80GZCVVgJsO7BSrmy5Wgvi2EFeQuT4gEXNGCLLWSu/Pug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kejrjfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 16:17:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QF7LxX028963;
	Thu, 26 Mar 2026 16:17:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsd6e20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 16:17:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62QGDlmZ003713;
	Thu, 26 Mar 2026 16:17:21 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsd6e1e-1;
	Thu, 26 Mar 2026 16:17:21 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: jgg@nvidia.com, joerg.roedel@amd.com, kevin.tian@intel.com,
        vasant.hegde@amd.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev
Cc: sherry.yang@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] iommupt/amdv1: mark amdv1pt_install_leaf_entry as __always_inline
Date: Thu, 26 Mar 2026 09:17:19 -0700
Message-ID: <20260326161719.1329502-1-sherry.yang@oracle.com>
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
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603260115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExNSBTYWx0ZWRfX1RVs+tn5QEiv
 Gq+7EiT6tI/TrZL2VqqTW4nGJgWubXUTWH0sCpj24iGFGfc6S18HOckC5mZ4jm6fun9oJcYD67l
 CwEU6DEk1t3bwqQ6nnVceSFvu6byk9BrQ6Ivy7bYsZ3gaTb9Z+vQb+KQyl2kQsOsHDzMUUNzhTV
 RBfwXB8zIo7QTk9exE4T/qD2Q6W4/Sd/cskSsVJ7pEVzRUmUiQvZ6y2wgfqU897GsoClyAgQqLx
 DytxZMUDNFgnL76u8SCeCryy3KaaMk/3VPsUmCeDdk9AWynImzOIXcufqVLPUen2TxgnOum0o3t
 R9n0prq3g1Q0/ezCpXZ5QjXe1EGe9KF0rfP84mWqVbqeoe0VFoczASKPSPN2h0Yct016egTJWAX
 kaGHBuk0mu8B0yo6hrA8Mn1XybXyvyWiKnSVwBv4N9pgLuFdfaQ++so0ZsUnAEE2/WVef+UTXV2
 8TJSA8MWLbE1qy0TOJA==
X-Authority-Analysis: v=2.4 cv=GZAaXAXL c=1 sm=1 tr=0 ts=69c55c12 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=ze1IRH6pvBvPo5vKM3EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SS50ZXEV-NMQ5qc1JLIp_fW84PwA_a5W
X-Proofpoint-GUID: SS50ZXEV-NMQ5qc1JLIp_fW84PwA_a5W

After enabling CONFIG_GCOV_KERNEL and CONFIG_GCOV_PROFILE_ALL, following
build failure is observed under GCC 14.2.1:

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

Fix this by marking amdv1pt_install_leaf_entry as __always_inline.

Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 drivers/iommu/generic_pt/fmt/amdv1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index 3b2c41d9654d..8d11b08291d7 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -191,7 +191,7 @@ static inline enum pt_entry_type amdv1pt_load_entry_raw(struct pt_state *pts)
 }
 #define pt_load_entry_raw amdv1pt_load_entry_raw
 
-static inline void
+static __always_inline void
 amdv1pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
 			   unsigned int oasz_lg2,
 			   const struct pt_write_attrs *attrs)
-- 
2.50.1

