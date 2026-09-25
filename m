Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C54C4F40
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349459; cv=none; b=d2z4HU/pDntl93MZmeV6PYAEOQTjhO9ukWf1Ia4fWdvOS2Yd4q8lKc7ThonAAznZyHYqByJLn9c90nLO7E/oGE+TlOvCJ672rNmLqU4JV2bTwgVdSPRHYj3TQOo5bCIbXSqahG3evYQNuFIDdMyjCa0kZflTbbaIihr+Z0+MVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349459; c=relaxed/simple;
	bh=aslAr5e5fJvAwMnYBOmP8Z/jy/4ZkWdGr/bt7s4kLFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWOlXKIW0kCMGY0aBeROlRs22QW39SvUBUJx9FlX3pu4SDsm5tmkOxOBTKwpnW/Jjb1BcMzMI2PKDj63mJsUoCnngs0DlsxSgDZY0JqRsS6T1wW6m8a5kYvOk7aK7IewinUNCypv4Uo80f3MxcYITjYJCo+13b2tPRdf4hSqKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NmxhIv0/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AQg41tqn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NmxhIv0/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AQg41tqn"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PDi0la3532113
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hvxVWxCc7aw
	cPlTR9VMTluUHGn7pX4BoP4Q1ruBu0pU=; b=NmxhIv0/XGyNBriub2ztNnafrhZ
	nobcuyR6cFM1nWq8zcPqTsMgvqV8JFfspMhSE6JKvaq8c9/TXqRW12Cm3VPeSwDU
	O7zVX1CL6Sfy2LlmzYPA0xvBZvwvusMyoeHlT14CLanUI9F7cOfDhC72jJA/eBz1
	+ggp0ql/G0Sqr8zABPWcDvnl2ilL58I/xrOeLXzLTq4xYioAWVzr7+rbyiksQ4kS
	TvQGVlK6RQaA1NBTvJQ+nmYFQAkP7/snlSjQxuFJ16gcHz0B4KrDWT0j4raSmBIg
	jBuPj3vrgLBRGprvJS5QziU4JWlbUoYv6GjLrmcYkEsJk8aILI7cY1IRfqw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94kbs39-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:14 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-78faf713ab2so211355137.0
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349433; x=1790954233; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvxVWxCc7awcPlTR9VMTluUHGn7pX4BoP4Q1ruBu0pU=;
        b=AQg41tqnpT9Jzm9uZZvbcFzYF1ojBQAyfiy5VPX15W1u8emnR6FW/nZpkjswUlOAHx
         bp5VXU36w89mTo8293H5ONCIqbbCZg8X6K1fa0vFeipQ5U5H+9+ht5i9RABYXGnAUo1y
         PzJgRROHsYeen8FNVDiJloXaCj3AuJ16obUmidB06e800ukxTwAuwciEIsNwwua0tCAc
         wWDm3r69HmXyKLccFwQ8dedYz2z+uLRlqvqcyIhx/3dGR66wbQMWXtog98YRuAIfTQyE
         fGBY8zp+k2eoyDQKOdnVmeNXxjFo5EKIylPUY6ojoKa2VSBzVjEBpLePSMUDNM3ii0+y
         HSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349433; x=1790954233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hvxVWxCc7awcPlTR9VMTluUHGn7pX4BoP4Q1ruBu0pU=;
        b=zvmgB7t+DouQ0GsvzG/iH1ZeNDF8W3kQDRKpzyZHbwEIgNKUWfKlVTWycpOtr9df37
         lIEAARdGSs3XtLXoKkfLX+dNTNR3p+cTcY73QGOxY+GrxGBWathKQaf1zTs/UFr8wDsl
         xhfGxivbZbnx+C53jJp3VH7nklhxnS5CVXk9arSP4I5/S1a/OQJ5dW7bu2UgnaWBq/CV
         pOqQ8gu4NgsuPHzS+GIextl1eTmcHecXXjw0AtBQhkjLaozv/YxZIKk1EfYOhqUe8mdH
         lzGxkYOhVDF0QiFa5/N4nqdTcHz8eNIViuHu1yIK8h9KTRXmvnNbDqiHRIjhG5Ru2fP6
         jinw==
X-Forwarded-Encrypted: i=1; AKwUvBxyNfymTeA9NlHY6NrvxtdpMvVHloyXlwN3/uMXh9x2cq3qDHth5gh2Czt03m88ks65ar7F0g==@lists.linux.dev
X-Gm-Message-State: AFuF++nP6MFsveEp7xnCCB5u51p08Dw0OoLHcR8TpPgxaIRuwPqo75Gd
	OmBEJSJCn5PEQij1xaYngI4DlfPDVNcnpi9Pb9WjO4FXQUTL4Qy+A2hx0iL+BuMfkxGY6XEfxux
	KbU0lTHNQzSNHL8xM230Yd5scw49AJzxP6zEYboFn6/NCkl8eYWFIfqutlMndivUnVQ==
X-Gm-Gg: AYBFou3BkIJomWlERTuOLGIRJMXda0HDXeSiUymmM8e/KY/S3UnI2IZctBHuLBq44M8
	x0Iu6XxTqe4ZyQ6d7nTU9Lw8Jk0EmU9hm/BBoZcpNbLrtNG+2IlDzPLV+Tcx0v4EkajMV0itXlp
	Nzpht5S0ui3kTUScc0ecLAc0SiLhHROl1Nqx/+CO13AmtcHEcYK2FAN3ejIqSoaUXQO2jVSfth9
	bj5ZGtaJ2t5uWFwPhbfeoVlbOfvs/K4CcyhSkrlrglZvhhjhfguPoOEbNAS9KGpm6HgJ4i+wf54
	481Uu9e5c8I+sOrOzEFu3FNqmSVyYjLnpvVnACG2vFqjPWdpXoCRTmsO25QxYL6sUHpJSiwGeRc
	rqmhR8XfxDxOMyt4KhNU4s4zy0/1lbi8QtYHWSg==
X-Received: by 2002:a05:6102:6448:b0:7a1:fa0f:1106 with SMTP id ada2fe7eead31-7af1e1e6986mr2152255137.36.1790349431749;
        Fri, 25 Sep 2026 08:17:11 -0700 (PDT)
X-Received: by 2002:a05:6102:6448:b0:7a1:fa0f:1106 with SMTP id ada2fe7eead31-7af1e1e6986mr2152198137.36.1790349429718;
        Fri, 25 Sep 2026 08:17:09 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm8686711f8f.17.2026.09.25.08.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:09 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 04/16] iommufd: Bound software MSI mappings to the reserved range
Date: Fri, 25 Sep 2026 17:16:47 +0200
Message-ID: <20260925151659.419512-5-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab6907a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=f1RXMQGm8Qq6PoD2gk0A:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: 8d5saQQBRd-k7RrjZw0ThPdTHsdA3R7B
X-Proofpoint-ORIG-GUID: 8d5saQQBRd-k7RrjZw0ThPdTHsdA3R7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX4jhi5cO5gYC+
 0XqAFroPVPwyMc9AnR7QRVmu21WNZjxRStqOgOsTNUJ59A0HmwENqOJAfwRrHQVrUJmNlxN5TkS
 eJr8YKYVRqa2FIgvt1j6UxVrWf5L2zx9wX8R/wbv28PlAYi5cRzotlNOWrfqwodt33sAvNpeWD7
 d1M2GDbu2DsqXloCEeHr/u1sx0re5104oHk1QGyb0eh8wNvoKzUK2jIme86+FVwHdw0tFGFe21E
 2eSxnJZ40xsBBsrwMHJQcUVNCvI9VHzYPhH4yvbtM8UBMHjvvP4RlKlHpiQjXY5WyGlM5Jx9oBK
 l/kniSqjBXJycQ226k3114TrfP2i3Wk+3iTdWdqr9U3LZcg+tL0++qDAGUWZ26bJ+0VjTKclmaU
 3D7pULWI+8Nkqbgs4VQSB+PR8kmuYxUQ1PjJZUQb5iNRvC/xluCSGj3EOdFc1/yK4V7d44hPzq3
 lHSRb62OsgZ70a9i1cA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXyMtElKewfyYG
 oTC8liKp1DcrvI2iyzSA0loR3d+C996L7QQZrzpsNH6DknwtHzmubFdQxw7GpgSF6Rq2vSTaAZ0
 yIPeGbLYIHm/f01fAkemWxi2fcwAmkE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

Track the start and length of the software MSI reserved region as one
range and pass it to the mapping lookup and allocation helpers.

Reject cached mappings outside the region and new mappings when no
complete page remains. This enforces the reserved region bounds and
prepares the helpers to allocate contiguous MSI address lists.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/iommufd/device.c          | 17 +++++++++++------
 drivers/iommu/iommufd/driver.c          | 21 ++++++++++++---------
 drivers/iommu/iommufd/io_pagetable.c    |  9 +++++----
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++++--
 4 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 28e2c98ef953..2b12b25a74da 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -84,7 +84,7 @@ static struct iommufd_group *iommufd_alloc_group(struct iommufd_ctx *ictx,
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
 	xa_init(&new_igroup->pasid_attach);
-	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
+	new_igroup->sw_msi_range.start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -440,7 +440,7 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	struct iommufd_ctx *ictx = igroup->ictx;
 	struct iommufd_sw_msi_map *cur;
 
-	if (igroup->sw_msi_start == PHYS_ADDR_MAX)
+	if (igroup->sw_msi_range.start == PHYS_ADDR_MAX)
 		return 0;
 
 	/*
@@ -450,7 +450,7 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
 		int rc;
 
-		if (cur->sw_msi_start != igroup->sw_msi_start ||
+		if (cur->sw_msi_start != igroup->sw_msi_range.start ||
 		    !iommufd_sw_msi_maps_test_bit(&igroup->required_sw_msi, cur->id))
 			continue;
 
@@ -480,18 +480,23 @@ static int
 iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 				    struct iommufd_hwpt_paging *hwpt_paging)
 {
+	struct iommufd_sw_msi_range sw_msi_range = {
+		.start = PHYS_ADDR_MAX,
+	};
 	struct iommufd_group *igroup = idev->igroup;
+	bool first_attach;
 	int rc;
 
 	lockdep_assert_held(&igroup->lock);
 
+	first_attach = iommufd_group_first_attach(igroup, IOMMU_NO_PASID);
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
-						 idev->dev,
-						 &igroup->sw_msi_start);
+						 idev->dev, &sw_msi_range);
 	if (rc)
 		return rc;
 
-	if (iommufd_group_first_attach(igroup, IOMMU_NO_PASID)) {
+	if (first_attach) {
+		igroup->sw_msi_range = sw_msi_range;
 		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
 		if (rc) {
 			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 501f1e1f2797..c2ef15c2ca51 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -186,14 +186,15 @@ EXPORT_SYMBOL_NS_GPL(iommufd_viommu_report_event, "IOMMUFD");
  */
 static struct iommufd_sw_msi_map *
 iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
-		       phys_addr_t sw_msi_start)
+		       const struct iommufd_sw_msi_range *sw_msi_range)
 {
 	struct iommufd_sw_msi_map *cur;
 
 	lockdep_assert_held(&ictx->sw_msi_lock);
 
 	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
-		if (cur->sw_msi_start != sw_msi_start)
+		if (cur->sw_msi_start != sw_msi_range->start ||
+		    cur->pgoff >= sw_msi_range->length / PAGE_SIZE)
 			continue;
 		if (cur->msi_addr == msi_addr)
 			return cur;
@@ -203,7 +204,7 @@ iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
 
 static struct iommufd_sw_msi_map *
 iommufd_sw_msi_alloc_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
-			 phys_addr_t sw_msi_start)
+			 const struct iommufd_sw_msi_range *sw_msi_range)
 {
 	struct iommufd_sw_msi_map *cur;
 	unsigned int max_pgoff = 0;
@@ -211,7 +212,7 @@ iommufd_sw_msi_alloc_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
 	lockdep_assert_held(&ictx->sw_msi_lock);
 
 	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
-		if (cur->sw_msi_start != sw_msi_start)
+		if (cur->sw_msi_start != sw_msi_range->start)
 			continue;
 		if (cur->pgoff == UINT_MAX)
 			return ERR_PTR(-EOVERFLOW);
@@ -219,14 +220,16 @@ iommufd_sw_msi_alloc_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
 	}
 
 	if (ictx->sw_msi_id > IOMMUFD_SW_MSI_MAX_ID ||
-	    max_pgoff > (ULONG_MAX - sw_msi_start) / PAGE_SIZE)
+	    max_pgoff > (ULONG_MAX - sw_msi_range->start) / PAGE_SIZE)
 		return ERR_PTR(-EOVERFLOW);
+	if (max_pgoff >= sw_msi_range->length / PAGE_SIZE)
+		return ERR_PTR(-ENOSPC);
 
 	cur = kzalloc_obj(*cur);
 	if (!cur)
 		return ERR_PTR(-ENOMEM);
 
-	cur->sw_msi_start = sw_msi_start;
+	cur->sw_msi_start = sw_msi_range->start;
 	cur->msi_addr = msi_addr;
 	cur->pgoff = max_pgoff;
 	cur->id = ictx->sw_msi_id++;
@@ -295,7 +298,7 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 
 	handle = to_iommufd_handle(raw_handle);
 	/* No IOMMU_RESV_SW_MSI means no change to the msi_msg */
-	if (handle->idev->igroup->sw_msi_start == PHYS_ADDR_MAX)
+	if (handle->idev->igroup->sw_msi_range.start == PHYS_ADDR_MAX)
 		return 0;
 
 	ictx = handle->idev->ictx;
@@ -307,11 +310,11 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	 */
 	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
 					 msi_addr & PAGE_MASK,
-					 handle->idev->igroup->sw_msi_start);
+					 &handle->idev->igroup->sw_msi_range);
 	if (!msi_map)
 		msi_map = iommufd_sw_msi_alloc_map(handle->idev->ictx,
 						   msi_addr & PAGE_MASK,
-						   handle->idev->igroup->sw_msi_start);
+						   &handle->idev->igroup->sw_msi_range);
 	if (IS_ERR(msi_map))
 		return PTR_ERR(msi_map);
 
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4e447ce74cf6..0336d8f0908f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1579,7 +1579,7 @@ void iopt_remove_access(struct io_pagetable *iopt,
 /* Narrow the valid_iova_itree to include reserved ranges from a device. */
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 					struct device *dev,
-					phys_addr_t *sw_msi_start)
+					struct iommufd_sw_msi_range *sw_msi_range)
 {
 	struct iommu_resv_region *resv;
 	LIST_HEAD(resv_regions);
@@ -1598,10 +1598,11 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
 
-		if (sw_msi_start && resv->type == IOMMU_RESV_MSI)
+		if (sw_msi_range && resv->type == IOMMU_RESV_MSI)
 			num_hw_msi++;
-		if (sw_msi_start && resv->type == IOMMU_RESV_SW_MSI) {
-			*sw_msi_start = resv->start;
+		if (sw_msi_range && resv->type == IOMMU_RESV_SW_MSI) {
+			sw_msi_range->start = resv->start;
+			sw_msi_range->length = resv->length;
 			num_sw_msi++;
 		}
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 774cbe28cbaf..af7df868dd4f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -22,6 +22,11 @@ struct iommu_option;
 struct iommufd_device;
 struct dma_buf_attachment;
 
+struct iommufd_sw_msi_range {
+	phys_addr_t start;
+	size_t length;
+};
+
 struct iommufd_sw_msi_map {
 	struct list_head sw_msi_item;
 	phys_addr_t sw_msi_start;
@@ -181,7 +186,7 @@ void iopt_table_remove_domain(struct io_pagetable *iopt,
 			      struct iommu_domain *domain);
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 					struct device *dev,
-					phys_addr_t *sw_msi_start);
+					struct iommufd_sw_msi_range *sw_msi_range);
 int iopt_set_allow_iova(struct io_pagetable *iopt,
 			struct rb_root_cached *allowed_iova);
 int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
@@ -531,7 +536,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct xarray pasid_attach;
 	struct iommufd_sw_msi_maps required_sw_msi;
-	phys_addr_t sw_msi_start;
+	struct iommufd_sw_msi_range sw_msi_range;
 };
 
 /*
-- 
2.43.0

