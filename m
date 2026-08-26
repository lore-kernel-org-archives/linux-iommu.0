Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0EF44A401
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755999; cv=none; b=Pl3VT9an2BcuR9CrqtuMDvmyEkkfroGNIOcK1BVT72cE8TR9VhH6AoK/EsPtqLcYEC9YmqAKCUSSwUEcovKhfNIPxCVifJyzx6n6yb8Nj1Gg7pRk6ZhV1KB23gxDXvLmDIF4ZGdAfZcvxvHt3HxDJzH3Mtzit6VKKd3M3S8TkfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755999; c=relaxed/simple;
	bh=TGK0lhZfCfz2pIw4hd9TDxJ6q0dSM1jq7vGUA/EXfM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtKcwqjgtR59BPao7AXAt01o9k4dld2WkLJ0iyYoPw2uFmfwASBh4akC7py8gks3t3RoACphSkCps/Ij5FK5sTez7MxofthPvd5hh8ZZPp0YgWG4KWUjUL6P7IZ34Isj+SEnWBEQl1dbZowHK4T9TXY6cYfvHWSR3s5XOac/hBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MRJNsXVr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h4//C59u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MRJNsXVr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h4//C59u"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDuxf7026302
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fxkNrhhqMRA
	B4rFIf0pTSCklWbzV8gUXV1JpOe0FY+8=; b=MRJNsXVry9Uqeoj7kyoYixfyQfe
	Rv76lxHtnzbmtO5JjlvFbwyp6h4qGG1+38zYTSq5jcq6vuboHc3xsESAcsrSTSM4
	DM7e5dPSzMCIRl1Nw6Tdc4p39EKdPpAyRsWr50DEO4M+tCcwPUd97RO5jd6keLnl
	9ds/1OG8l+bPXQgl3h+cl7XQc+Ay6PD4+8ErDC7f244KCDUkyFmOcJb8PJ9VkJze
	TtgffAWnbjkQW+7peaLvbFmB8KAebj7PEZ8oPA74STZMwFh3XEYzY5rI/1l08O/L
	vWhfr//YMFARtgNugFbwg+8JLNsmlwPrT3bTLEjeG9VUxlhM9MGZR/z+bUw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9wmqs871-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d7b3adda4so11948951cf.3
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787755993; x=1788360793; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fxkNrhhqMRAB4rFIf0pTSCklWbzV8gUXV1JpOe0FY+8=;
        b=h4//C59uroGCj2ISFrtAdYw5tY29VUW7g2rvhl0bOX5ozppQfRpd1lyoxBBcAa9ddu
         47682OsseQ9I/2gOYNFl6bwZzfrWkJd/nOqHBqXWhiLvYdsk4XU1NYnnFmvOeiOCtgey
         lMxGWeepwZHgqDXWxBu9vI6/ZZYDafLuBXBgNYhYQIUZ2mk9kbOuMtZJY6HaKjKBJo2m
         csmcBZ07IgSmLZiCiaCeQjNpf57/InzYrY0zMV/LzECc2WI81a+ISSBhETpk+im8Ix31
         eVUMQj/lyBIttnuNVQZUGwBCspu50WKZgr5o8Wsz+SrKSCEgad4PehSOqwlWku75b6F6
         +udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787755993; x=1788360793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fxkNrhhqMRAB4rFIf0pTSCklWbzV8gUXV1JpOe0FY+8=;
        b=sN9RUuLWdxT56rkt3eo7dC1x+FqGvJKUZvRA82S+YayowqGfMAJ7qwBbcmo04C8Q34
         NFv5Ge6H87JncjGZRIvPscwgst3cc+I8surhqs7d0E8T/p4Ok3Nh2sFHaPUk6r9VI2hd
         yOLmp+DxohWdmSwPxa2v+3CYQySVk+8JKjI2ksg7Pz9KmbBJQgXLqtUR/HEhReCw0iBS
         uvgv8wDjiOLovoR5rvwN79Oz7bLXPduEnp7q3udgovA7GkRm451XxZa+drSUelotPGE5
         l4F2bQKWZ+ROUEICt07BlT/nK8SuNg466QD654PBGKUDpxBjvoxowGcHlWoys1VD/gdL
         VpVg==
X-Gm-Message-State: AFuF++ncwjfu2nkF3xEjbue4zu/UyW4JQUis8CUyTfiDblMB4DpxBU9w
	yLxEJb2ZdGYu5XDRBzfOFNcIv+LqJ0C9h/Z/pLgqq6x7QVSq4LEaphBtPn5vk9p+eT2LB/m835b
	uxGLt7Ur2mfxtHcHXKE+JntNpyCk2eQwXj9i0tcKFPgZ96JdUaBEpAd7BWy/JCB8iuA==
X-Gm-Gg: AR+sD11ABTiOb7SaiB1NeUpfJk1rAss1ZMjpugh5oYjLCFSuxmY+Gb1KMX5dtTRuYOV
	H9JSRW/0r4B8J7GXC+nY/bmx2QE/sxm4fLioR84fPVKbsHda7y5i7vqq3aM2tfc5JD2AtxjHk9f
	Wp1UENRsED9dpkjGlzwzPUG4Y5n8+0Mm6+mTOYdBSkd1ZfPXxaSf/TDUtoEDA+fl9lSLMsCTOJZ
	wVqAhH0NchNetXfgJBvYSczQk/kEwFIZpQt7MF7Xy/RwazVY/EtXDiGcllWQkEHMO2dPE8fdVdJ
	jgkAwVQLMxUCfWqkgAQxLWnE+ocs6dy92/qu8//+sP+t1l4p/V1hjnpRNlgwcHmAx7m0Eomi46b
	aWbJUxyxX
X-Received: by 2002:a05:622a:3ce:b0:51a:bec0:1040 with SMTP id d75a77b69052e-52e4228dc92mr75709671cf.12.1787755993073;
        Wed, 26 Aug 2026 07:53:13 -0700 (PDT)
X-Received: by 2002:a05:622a:3ce:b0:51a:bec0:1040 with SMTP id d75a77b69052e-52e4228dc92mr75708841cf.12.1787755992545;
        Wed, 26 Aug 2026 07:53:12 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc9ae4cfsm29466565e9.9.2026.08.26.07.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:53:11 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
        will@kernel.org
Subject: [RFC PATCH v1 4/8] iommufd: Bound software MSI mappings to the reserved range
Date: Wed, 26 Aug 2026 16:52:58 +0200
Message-ID: <20260826145302.449904-5-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826145302.449904-1-andrew.jones@oss.qualcomm.com>
References: <20260826145302.449904-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfXxWGsqvW9zWcG
 n8XAl5AdZwDhf+mms60RFkVPDIBGJfdP6+ijnhx2g2HpbFZy5lbhY+P0Y76rmK1zCHvAklfWFyk
 5arxrmf+5OS/IV/+My8tNaJU9GUcXqM=
X-Proofpoint-ORIG-GUID: mCQa8126ye2ONMyqSb6kIEx4a0bX-cQ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX1kFUhU0fzwVX
 tchu7sfvQql+B+FxNl0ht4ffh7AigFK2MeU7Pmbw5CcFxfRVoL3ZdOn/obIaJSqjBO5OBLHxMA1
 ovLxFLMAb72pKtMgS6c9YCjWMPDlzx32kZkChpBUiu4ltXENYFvdhouxfWwGmDg65VZa5Ml3N4T
 HRmVo1aSWEsulGPGwGbFDLu0RN5HLNS2K7oARqbPtcyhACvEYVNX7eLCYcoXzDkh51ss7RrpeIJ
 i4+2Dhrz4a2n8rKRKjmPfESdYZD4xxXWXNtmhl3WRjW6/Drjgkhf1i6fCOM9hRhAZdW400rMPA+
 ET94jcnl1jtPIr0u4hbzjsk8QLlk0DLS1e7YQPV4PlBKClucQExyie2VpRIWnCJysNErzJHmpyr
 ZMbuWkMFuc2a8wwvzyqj5uSJSNmxXVFIeQbZH4djLzs41OHabFjFQyMsBpxbfj4JiYTFLR7lAiO
 NVS87G90KrSOrUxBDxQ==
X-Authority-Analysis: v=2.4 cv=T9S8ifKQ c=1 sm=1 tr=0 ts=6a8efdda cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=f1RXMQGm8Qq6PoD2gk0A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: mCQa8126ye2ONMyqSb6kIEx4a0bX-cQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260124

Track the start and length of the software MSI reserved region as one
range and pass it to the mapping lookup and allocation helpers.

Reject cached mappings outside the region and new mappings when no
complete page remains. This enforces the reserved region bounds and
prepares the helpers to allocate contiguous MSI address lists.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/iommufd/device.c          | 17 +++++++++++------
 drivers/iommu/iommufd/driver.c          | 21 ++++++++++++---------
 drivers/iommu/iommufd/io_pagetable.c    |  9 +++++----
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++++--
 4 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 868f1e591208..7b83810a1c90 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -97,7 +97,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
 	xa_init(&new_igroup->pasid_attach);
-	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
+	new_igroup->sw_msi_range.start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -374,7 +374,7 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	struct iommufd_ctx *ictx = igroup->ictx;
 	struct iommufd_sw_msi_map *cur;
 
-	if (igroup->sw_msi_start == PHYS_ADDR_MAX)
+	if (igroup->sw_msi_range.start == PHYS_ADDR_MAX)
 		return 0;
 
 	/*
@@ -384,7 +384,7 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
 		int rc;
 
-		if (cur->sw_msi_start != igroup->sw_msi_start ||
+		if (cur->sw_msi_start != igroup->sw_msi_range.start ||
 		    !iommufd_sw_msi_maps_test_bit(&igroup->required_sw_msi, cur->id))
 			continue;
 
@@ -414,18 +414,23 @@ static int
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
index 3856989f5c4b..8bb47a81fed1 100644
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
index 24d4917105d9..8bf2554af334 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1501,7 +1501,7 @@ void iopt_remove_access(struct io_pagetable *iopt,
 /* Narrow the valid_iova_itree to include reserved ranges from a device. */
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 					struct device *dev,
-					phys_addr_t *sw_msi_start)
+					struct iommufd_sw_msi_range *sw_msi_range)
 {
 	struct iommu_resv_region *resv;
 	LIST_HEAD(resv_regions);
@@ -1520,10 +1520,11 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
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
index 9ca5f9f92cdf..4e2d32809695 100644
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
@@ -171,7 +176,7 @@ void iopt_table_remove_domain(struct io_pagetable *iopt,
 			      struct iommu_domain *domain);
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 					struct device *dev,
-					phys_addr_t *sw_msi_start);
+					struct iommufd_sw_msi_range *sw_msi_range);
 int iopt_set_allow_iova(struct io_pagetable *iopt,
 			struct rb_root_cached *allowed_iova);
 int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
@@ -510,7 +515,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct xarray pasid_attach;
 	struct iommufd_sw_msi_maps required_sw_msi;
-	phys_addr_t sw_msi_start;
+	struct iommufd_sw_msi_range sw_msi_range;
 };
 
 /*
-- 
2.43.0

