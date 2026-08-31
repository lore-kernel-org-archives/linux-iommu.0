Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4574A5EA4
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188396; cv=none; b=ELhUyBh16RiBSHQ91LjAetHMcDsg4sibljwqRClyVJJKJCrudUo88RCpk7LwG42tWan0nHaWjkeNPBU0Ql42sdZpKuFw8PQDKiPS6A/tXpH+h0C1peFpRaP7WWuVBAR3kq67tChiWYD9k1itZuwaPw6Cr9+wLJulqYctTtj/NuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188396; c=relaxed/simple;
	bh=TGK0lhZfCfz2pIw4hd9TDxJ6q0dSM1jq7vGUA/EXfM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTo6gHQsNj0i/N0SMKXWjVhPJ9XHD4XWJnUZiMBEsZUzMX7rk1dC+8cZVVwqEGOfPQvZz60DoFS+QVd5+WJJ1UbqCxhkwbjKdTx14JGPlra/V3dxuIvHKUjyS4xZB39pxbGWqWCPJKvO3tg+0N1cNQ/h9Xl9QmjQCnKY49tSWbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvXpdNAE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WPRey/aP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RvXpdNAE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WPRey/aP"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETQnH3703685
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fxkNrhhqMRA
	B4rFIf0pTSCklWbzV8gUXV1JpOe0FY+8=; b=RvXpdNAE2cruLbkqkfxY2uJJ7qe
	8YgKY+ej+HnChSaYZRAlqoMtNyrKigQ2JuoIEybQz72C+3L1+riY3eFIF4JJe9lZ
	z8ToTP/Ke0KDD1zQVySqvTtk41KeWwR02kEHQ9NB4LYvVaDyqdT0XFe2Efg0bNuu
	GBoJQVor8XzJWT+wKfvdFTjzlXCWLXi/hZRAgG3lweitmRd6JYeym0wMbP6iKuP7
	NZSPP6VbwIqhqrUQIC8BZmo7TFQ02iCjuvkI7p0nIkkZpqHTGvU226R649R2ErIx
	bIJRIcu85oJ9JWPGFqCD2mSdB+vuMY/0ry+GTb4+0cW/4Hwu3MwU2IgM0qQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6yasc77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936e393061dso398112885a.2
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188392; x=1788793192; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fxkNrhhqMRAB4rFIf0pTSCklWbzV8gUXV1JpOe0FY+8=;
        b=WPRey/aPrrvw5ef50sD0iBY79Ru3O6bxOKlwTlz8mhlzWJnF1zGJzF5JEIFhGAq/XF
         g4zGoxH859/10JjSYn9MLu4ED/oDEs3qsrhDn6FtZCOsFPY8JO3UxsJnbU2gaGcpw0sP
         whTSHfr4TMlKtqOlSJul+rKipS2FJucky97VvTPZdZ9M8kSqzykJswdOgWTN63aTQ4MX
         x/iVNON/E9kmVs0Exs8uta6WWNzJGBX8O4asVeXa/G9TyIrzXyAiUtZP+01FcvskMPH5
         0xd0PoROq3SKmRig92AFwE168/WclqyD9ZfVpeKkK8dbiiKsN4vh2z2nvaUq1Rx/hO6Y
         NG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188392; x=1788793192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fxkNrhhqMRAB4rFIf0pTSCklWbzV8gUXV1JpOe0FY+8=;
        b=RinIWudKTPSr9e65bTPj3a4Wp8T/Hq/dpuDpAnnruLJmu8zcMlpiBBjUisLgK4daEe
         MPKaKCAZkRCJhK0xEYaYjZ0bY3QgfVrj8zCxemjnFmJufcBLAQ0LXQwtQVA2vzZG8jFu
         YtokAR3dt923K0YkKUWFCU6cMYXgYRd6nQHVFv2ohpzFzh5teOWaPbzxtaz7hPqFR4Z+
         zl9xrhPtDxjb5O9K6uNPF31+m6lsJwHwjRq0vt1P+rf26WFeRVOxcto+nb8PHDUURDsB
         DA7ntxGbYU3/Q35H6Vsz/EcGwITlB5gkVBHcy0pK9LKlnq49DyDftKl08swPwdTZ7V2S
         m9pg==
X-Forwarded-Encrypted: i=1; AHgh+Rod1WjdYvyIV7RgL57FpZqg6D6jyDVDCkavDMxIOihi4G06y1R9qTN+wzXem9gh26JJWpNL6A==@lists.linux.dev
X-Gm-Message-State: AFuF++krl0mU4nFSZxKpbPwb20x/3zffjKWNRk2OAQxYG573YKnRrHTG
	GTRp62EgLZ76MRC9dMDCUhyaVYCVgq4WqOQ3uB4LFrFkODLNFfAW5YrwnBpaXhYdGzI9BM+qYP0
	Irb3crYoaSunIAYXqA7CJC4mkhNzn8ErQcytwiWE3CZrfwFxKPEYP05X0pA==
X-Gm-Gg: AR+sD13PiN9//MM3BeMpy7r8azxpy8RxTjxfFdP75AIgenkpNdFJ5HTQ4vfjYSLJnAy
	G6zbSj6ipJN7r1fmZIPUnJAVRkyG3CZWfWHXq7rDC2h2qZJYjRi83tLC44H6+RCR971xMEefAJ9
	iykmfjus3aefkhvj2GUEkpWIZh1wq1/nuTlSvXpySvVMlbezp+cIlfQZY+tujd3H2TYP1LpLRzg
	Bh7eUtumQIEzO/elB0EcV5V8P2LG/7NfXhsUHB9XdOcRq2XtY2qJV4kHl29A7CTPsGxrWIRWx0n
	3oIWmCsAXga+dVpndu7J1y7rPase0ZwocWjUCSh8+v4lm0A8GqymgOeA82o5CK1rN6g5zDT5bM+
	GZ4pmfG1lbh/FBWUBsHyfCRB1gE9DKxLwqFM=
X-Received: by 2002:a05:620a:55ab:b0:936:afa0:3661 with SMTP id af79cd13be357-939138df41dmr2317226685a.36.1788188392455;
        Mon, 31 Aug 2026 07:59:52 -0700 (PDT)
X-Received: by 2002:a05:620a:55ab:b0:936:afa0:3661 with SMTP id af79cd13be357-939138df41dmr2317220285a.36.1788188391905;
        Mon, 31 Aug 2026 07:59:51 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b963c3c0asm526216835e9.10.2026.08.31.07.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:51 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 04/17] iommufd: Bound software MSI mappings to the reserved range
Date: Mon, 31 Aug 2026 16:59:30 +0200
Message-ID: <20260831145943.313726-5-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX7mdiTVXloHVQ
 gP4VHm5b0H+DgMQ66JCCuEijfEnu2REyCKV7WJI/4XAEpIRzqKk/9GsQfJCJcu2PowfNT9eUzkr
 CEpWAmly1TifqvFV7zG7+y9G+4VeRHQ=
X-Authority-Analysis: v=2.4 cv=CpaPtH4D c=1 sm=1 tr=0 ts=6a9596e9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=f1RXMQGm8Qq6PoD2gk0A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX+mhVLQM7iWDf
 bSj2S6VvFnLBVm/8z5UJMkcva38OX3Z8oO3yTtIFty8nXBSxpp9u4tlREzpeBAW0QJ3EtsSOP53
 7Da6YvftusDvMhzsHKKHxMR5Kb/s2qRvLQcL9Hm1SthFMsZgXBJb2F3s6nUucKhnPYg0SRr9N0B
 msV/R/AV7VzB2B5rWG3ux7nXTNVqSeYs9TEKlFjEHatDl0tFzQzcDdkf0G+v6LCZx9qGyJLwiyF
 E0+xHeSPts+Nw4KaHCiHwjppzNVNCALOz5JskC8zc6cXpE17vu/T5fRtmjYPgatzta3RF0jrwdm
 lJVmPCqgFMzTls7ryXE3UvpfmSRxXqdTCBmFKl/OFxwt0Xue2lbZ1WV9vFTgEnnu3VoILU55a9V
 R3HBAXrNphEzrzkp4Lk2GP9A+zd2ycg7sjxZiZTXuNajv1+qDe4OogfEN9+BY0LfB/2LNJDNEgr
 QeJsruOcWe3xPdY9GmA==
X-Proofpoint-ORIG-GUID: 1D7vNuArTlqDXRO2jmdCawP7lUkSuTO6
X-Proofpoint-GUID: 1D7vNuArTlqDXRO2jmdCawP7lUkSuTO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

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

