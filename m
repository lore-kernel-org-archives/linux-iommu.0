Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6F4BA1C8
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349448; cv=none; b=l1SS29qTXHFzBdTtZzVSLsOPcrS5+IgfIJWwvVThS21fsh2FCyyNqKBYOv+SCUcjKDZro9O0fELEWD4eOnNixTutr8ojKnTjXB7bfghBFLwpwB7haVv5mXOUQQKoti43dPFMfVY1VtzJN20JTwHqFu98IRoE/CVXJWL3F1Fo3R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349448; c=relaxed/simple;
	bh=qg8zIqF3Y/sc6lh+Hxvi2X9SYiYHMSQIve++3OfyJnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDdbSKj55BDQnTST7ZeH3AuuNH0YFuaCr2UO+d6W6pN6z1960RLKYwh1oy/Cl0O9qpPx0WVEZPSrM1vXB15M1diRJWgx8DZCfeQvqUObimnK9fFXuUO8P+s7S4YGxoAi5FWMKC+shyiY7nWLLSrLFflLx6K1Y2YV4fb4lgUYM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mZRITZ6H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZTu/DC3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mZRITZ6H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZTu/DC3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PD9Akv3532114
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1X0NVzHxbn4
	ywmQH+85Wj45+Tkg1X+lSCNdQaps1CnQ=; b=mZRITZ6HinHh8PGxb4S4TPBivG/
	Q9kg1OuqQsDA9Xx83GKYms8v2IOwsIrtH85NpvsShXZp2mVF4vHwkJu6fTJmgPTr
	8sBBh2kk6wOB7fpnaBIXhbpW7bYBGMXlNbgSEWR49vzsgWwzZHRci4SuHEhLizps
	quzhcq6ftjpgU73fxukulbvR8MkMu8RIF/NkMuP6XWZ/bLRQ54zXj09hJMArHx6v
	JgKTr9m4FonDT02VA+EYRgbJ0FCSNcz0yr0JuvpIy1iVczl1T/+OOVQz7VgNndh2
	M2Tff8tkv0aRjFm5yAD+VOZ59lwwtYQEabfNGGQnKzlj+HbXL00kH/gk0zQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94kbs3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:14 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7961a79fcd8so252751137.3
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349434; x=1790954234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1X0NVzHxbn4ywmQH+85Wj45+Tkg1X+lSCNdQaps1CnQ=;
        b=eZTu/DC3G06t/9ouLk8SGSym3nLeJFylAMAXdUVlUOcWaoiG+Z/5eqokkz5BEJwqWj
         vtNcKUSa8R2U3A751lQFgnn733Kczm9qWwZyD5H5KdpY8VSOAgqh43jwDMKjw2HYgpUV
         Jxmas6NdlbulddfYQLScuooscQCQ5X/XjRCZGycxk/36BJcJ1kJ6SG5yhNEabEwhrrx5
         BiuTM/HtdxllnMAGLIx2N0O0pCYCUEHgya68vSXzV8r3BlOgU3ytpKGzzDXnB1sjI8kh
         8OZcg3AKDUdaaIcyECxYRjbgQivKN3fBt/xgnBc6hpdvBf/rYFbUJDiOtg+fbU1Xwr0m
         inyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349434; x=1790954234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1X0NVzHxbn4ywmQH+85Wj45+Tkg1X+lSCNdQaps1CnQ=;
        b=wUZGwLQtFuaf+xiEVEi1ZovzYlwu8kJFTV+0AmUirR2oqfVxybf/BxbzlNvzIFZtV5
         mRjUc6FhD1sfzSszwUK9sDDwqElmgWwU5ucHkNt+JmD5NR4wn1/A94RARChhacYIrOvo
         yMiaLW27IRxcBrJmH4Oe3bQ7kaotJjdnx1k3otqevlmHSVrKxe5x6m1hPUEnJOkL/wyr
         bR/4htVuldg8VG1wIxoi8LOstBU5f7TU1rGGCT4uVrVgIOrIQls83SgHHk/JLV8fOSCc
         moDmQw6Xsl34bYT/VT9AJSyfE46yNS2DszGBCst4mAL6QK5X7/6+Gp9ImQvGO07+TqmN
         kzmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUA2sHDETKjFDCQC3Og0GqVylM941GCbnHiIhLYp7zfu6wszT6+de5uezVpgqeDg4ZpZM5Fg==@lists.linux.dev
X-Gm-Message-State: AFuF++kPxbD1iJjntu/EitlgKv4IFiATila/b9dMNIu3OWzaj7dfSkWU
	zbp1azcvmwfNS8i0g8zaJlLannjj9AJRfvTG8wquw3VPWi9eDnfR1lUXCpSgMbkGIZnN49xlRCP
	4MKM8wteFnLQpPCwV1+YGVi0goQh2i755OaUIGX3YsNUMxskeOCm7y4MW8Q==
X-Gm-Gg: AYBFou1WyWMDToIb6y4wLCNxj/OtKXltnm0cz/JTFUjcIcqUUIHtA83VLFbinDjCK52
	JmDBVpS9Lwxwd7sP2hjUF/US8X6jq8bbiHMf/+D14Kwed24NsDRTfJ9zXnVuAh7HcTG6IcnS8bk
	lFFrwpUBderFUWhzROL7WwKI4EAWxRnPCGakXpPgKo+Ey3IEcxniEcvRPWn5CeNWBzJeaer8EGW
	g1S+pzXaanI51Iqk9BMcbYSHribwLuVyGR5IZ7qDKuAkIusp2LR5ZCnpujpg6EuzRUWAiscvR2l
	EuAqCYHNQYR0esFXroaS+gcz7qv4DxbuGn8KISzTSKfyQkH/HG2tXB9LctJ8b/CXeqGTKaIRTil
	KZ1VdtpRVEbKnWwmFIed5QEqqwQcVRd5QsOvPFw==
X-Received: by 2002:a05:6102:160c:b0:7a2:4b76:55fe with SMTP id ada2fe7eead31-7af1eaeade3mr2347051137.21.1790349432036;
        Fri, 25 Sep 2026 08:17:12 -0700 (PDT)
X-Received: by 2002:a05:6102:160c:b0:7a2:4b76:55fe with SMTP id ada2fe7eead31-7af1eaeade3mr2347031137.21.1790349431452;
        Fri, 25 Sep 2026 08:17:11 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcc4sm8249719f8f.1.2026.09.25.08.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:10 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 05/16] iommufd: Prepare software MSI maps for address lists
Date: Fri, 25 Sep 2026 17:16:48 +0200
Message-ID: <20260925151659.419512-6-andrew.jones@oss.qualcomm.com>
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
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=noCGlsY9V4GqTmqY_BAA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: VtWmNAMvWAirDQc6tdcNHDDA41wQPxqv
X-Proofpoint-ORIG-GUID: VtWmNAMvWAirDQc6tdcNHDDA41wQPxqv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX+9FwySTpbrEL
 BMbNMxUC02w9yJ6Rd8LWrGn1Y7N8ZTXlvMK57N8hqTjNQrt7AM4waNca5JN1KSOgsw9b95FA07S
 utpozGzxG+cyIDGVPat2ua72kdorqbik0kOOBt7wi4lkkvVxAr0DP10h6lxgb6D2/VYpZ7YjtHk
 K6f85Aof3lXwdmIfYGtkeiuVVzsm0M8XgEc3xrLrUAFaz73r/MqjkWMLsgJO0c7YMY2bsUPd07g
 muVrKE8UUSv38OWS3DONbNGL9uUPdQ6+WGLm5jX106FkvRfnsNhV/03kNpl5VddUrLTlJarqs6b
 5LYl1D5QnxZ8F6LUuDWIRt2aPOZMaN+kgfppazEH1yzn71h4gUIb416xys6eh5uA3TR8xb7RhGB
 5oFPZixFTfxgqWLg+cX4jqvZI48JhfG7skVXzrzMD659/jCEd3HLLdkeq0L+aI6iTgaGu2sd+Op
 FUfBKJFbpZTSLhoEM/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXyF7qNVtoqqlh
 4hK2L+XaiiuUw5RTWB8G9nvvRnuf7cqd0qANdzr6suFP8S1eZkKW9VG1V/23j2K7mHTDaqkUG2K
 yCsukVnDgA5ZmhPUY5sDQmzSaZ/LPTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

Teach iommufd_sw_msi_get_map() to match an ordered physical address list
against an existing contiguous IOVA range. Mark the first map with the
range size so an identical list can reuse the allocation.

Teach iommufd_sw_msi_alloc_map() to reserve identifiers and offsets for
the complete list and build its maps on a temporary list. Keep the
existing scalar installation behavior and only publish newly allocated
maps after installation succeeds.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/iommufd/driver.c          | 161 ++++++++++++++++++------
 drivers/iommu/iommufd/iommufd_private.h |   1 +
 2 files changed, 123 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index c2ef15c2ca51..8b8f132ef3c5 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -179,35 +179,91 @@ EXPORT_SYMBOL_NS_GPL(iommufd_viommu_report_event, "IOMMUFD");
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
 /*
- * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
+ * Get an iommufd_sw_msi_map for the msi physical addresses requested by the irq
  * layer. The mapping to IOVA is global to the iommufd file descriptor, every
  * domain that is attached to a device using the same MSI parameters will use
- * the same IOVA.
+ * the same contiguous IOVA range.
  */
 static struct iommufd_sw_msi_map *
-iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
-		       const struct iommufd_sw_msi_range *sw_msi_range)
+iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, const phys_addr_t *phys_addrs,
+		       unsigned int nr_addrs, const struct iommufd_sw_msi_range *sw_msi_range)
 {
-	struct iommufd_sw_msi_map *cur;
+	struct iommufd_sw_msi_map *cur, *msi_map;
+	unsigned int nr_found;
 
 	lockdep_assert_held(&ictx->sw_msi_lock);
 
-	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
-		if (cur->sw_msi_start != sw_msi_range->start ||
-		    cur->pgoff >= sw_msi_range->length / PAGE_SIZE)
+	list_for_each_entry(msi_map, &ictx->sw_msi_list, sw_msi_item) {
+		if (msi_map->sw_msi_start != sw_msi_range->start ||
+		    msi_map->msi_addr != phys_addrs[0])
+			continue;
+		if (msi_map->range_size != nr_addrs * PAGE_SIZE)
 			continue;
-		if (cur->msi_addr == msi_addr)
-			return cur;
+		if (msi_map->pgoff > sw_msi_range->length / PAGE_SIZE ||
+		    nr_addrs > sw_msi_range->length / PAGE_SIZE - msi_map->pgoff)
+			continue;
+
+		nr_found = 0;
+		list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
+			unsigned int index;
+
+			if (cur->sw_msi_start != sw_msi_range->start ||
+			    cur->pgoff < msi_map->pgoff)
+				continue;
+			index = cur->pgoff - msi_map->pgoff;
+			if (index >= nr_addrs)
+				continue;
+			if (cur->msi_addr != phys_addrs[index])
+				break;
+			nr_found++;
+		}
+		if (nr_found == nr_addrs)
+			return msi_map;
 	}
 	return NULL;
 }
 
+static int iommufd_sw_msi_check_alloc(struct iommufd_ctx *ictx,
+				      const struct iommufd_sw_msi_range *sw_msi_range,
+				      unsigned int first_pgoff, unsigned int nr_addrs,
+				      size_t *range_size)
+{
+	unsigned long max_iova_pgoff;
+	unsigned int last_pgoff;
+	unsigned int last_id;
+	size_t range_pages;
+
+	if (!nr_addrs)
+		return -EINVAL;
+	if (sw_msi_range->start > ULONG_MAX)
+		return -EOVERFLOW;
+
+	range_pages = sw_msi_range->length / PAGE_SIZE;
+	max_iova_pgoff = (ULONG_MAX - sw_msi_range->start) / PAGE_SIZE;
+
+	if (check_add_overflow(ictx->sw_msi_id, nr_addrs - 1, &last_id) ||
+	    last_id > IOMMUFD_SW_MSI_MAX_ID ||
+	    check_add_overflow(first_pgoff, nr_addrs - 1, &last_pgoff) ||
+	    last_pgoff > max_iova_pgoff ||
+	    check_mul_overflow((size_t)nr_addrs, PAGE_SIZE, range_size))
+		return -EOVERFLOW;
+
+	if (last_pgoff >= range_pages)
+		return -ENOSPC;
+
+	return 0;
+}
+
 static struct iommufd_sw_msi_map *
-iommufd_sw_msi_alloc_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
-			 const struct iommufd_sw_msi_range *sw_msi_range)
+iommufd_sw_msi_alloc_map(struct iommufd_ctx *ictx, const phys_addr_t *phys_addrs,
+			 unsigned int nr_addrs, const struct iommufd_sw_msi_range *sw_msi_range,
+			 struct list_head *new_msi_maps)
 {
-	struct iommufd_sw_msi_map *cur;
-	unsigned int max_pgoff = 0;
+	struct iommufd_sw_msi_map *cur, *first_map = NULL;
+	unsigned int next_pgoff = 0;
+	unsigned int i;
+	size_t size;
+	int rc;
 
 	lockdep_assert_held(&ictx->sw_msi_lock);
 
@@ -216,25 +272,38 @@ iommufd_sw_msi_alloc_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
 			continue;
 		if (cur->pgoff == UINT_MAX)
 			return ERR_PTR(-EOVERFLOW);
-		max_pgoff = max(max_pgoff, cur->pgoff + 1);
+		next_pgoff = max(next_pgoff, cur->pgoff + 1);
 	}
 
-	if (ictx->sw_msi_id > IOMMUFD_SW_MSI_MAX_ID ||
-	    max_pgoff > (ULONG_MAX - sw_msi_range->start) / PAGE_SIZE)
-		return ERR_PTR(-EOVERFLOW);
-	if (max_pgoff >= sw_msi_range->length / PAGE_SIZE)
-		return ERR_PTR(-ENOSPC);
-
-	cur = kzalloc_obj(*cur);
-	if (!cur)
-		return ERR_PTR(-ENOMEM);
-
-	cur->sw_msi_start = sw_msi_range->start;
-	cur->msi_addr = msi_addr;
-	cur->pgoff = max_pgoff;
-	cur->id = ictx->sw_msi_id++;
-	list_add_tail(&cur->sw_msi_item, &ictx->sw_msi_list);
-	return cur;
+	rc = iommufd_sw_msi_check_alloc(ictx, sw_msi_range, next_pgoff, nr_addrs, &size);
+	if (rc)
+		return ERR_PTR(rc);
+
+	for (i = 0; i < nr_addrs; i++) {
+		cur = kzalloc_obj(*cur);
+		if (!cur)
+			goto err_free;
+
+		cur->sw_msi_start = sw_msi_range->start;
+		cur->msi_addr = phys_addrs[i];
+		cur->pgoff = next_pgoff + i;
+		cur->id = ictx->sw_msi_id + i;
+		if (!i) {
+			cur->range_size = size;
+			first_map = cur;
+		}
+		list_add_tail(&cur->sw_msi_item, new_msi_maps);
+	}
+
+	return first_map;
+
+err_free:
+	while (!list_empty(new_msi_maps)) {
+		cur = list_first_entry(new_msi_maps, typeof(*cur), sw_msi_item);
+		list_del(&cur->sw_msi_item);
+		kfree(cur);
+	}
+	return ERR_PTR(-ENOMEM);
 }
 
 int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
@@ -280,7 +349,9 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	struct iommufd_attach_handle *handle;
 	struct iommufd_sw_msi_map *msi_map;
 	struct iommufd_ctx *ictx;
+	LIST_HEAD(new_msi_maps);
 	unsigned long iova;
+	phys_addr_t phys_addr;
 	int rc;
 
 	/*
@@ -308,29 +379,41 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	 * assume the caller has checked that it is contained with a MMIO region
 	 * that is secure to map at PAGE_SIZE.
 	 */
-	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
-					 msi_addr & PAGE_MASK,
-					 &handle->idev->igroup->sw_msi_range);
+	phys_addr = msi_addr & PAGE_MASK;
+	msi_map = iommufd_sw_msi_get_map(ictx, &phys_addr, 1, &handle->idev->igroup->sw_msi_range);
 	if (!msi_map)
-		msi_map = iommufd_sw_msi_alloc_map(handle->idev->ictx,
-						   msi_addr & PAGE_MASK,
-						   &handle->idev->igroup->sw_msi_range);
+		msi_map = iommufd_sw_msi_alloc_map(ictx, &phys_addr, 1,
+						   &handle->idev->igroup->sw_msi_range,
+						   &new_msi_maps);
 	if (IS_ERR(msi_map))
 		return PTR_ERR(msi_map);
 
 	rc = iommufd_sw_msi_maps_ensure(&handle->idev->igroup->required_sw_msi,
 					msi_map->id);
 	if (rc)
-		return rc;
+		goto err_free;
 
 	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
 	if (rc)
-		return rc;
+		goto err_free;
 	__set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);
 
+	if (!list_empty(&new_msi_maps)) {
+		list_splice_tail_init(&new_msi_maps, &ictx->sw_msi_list);
+		ictx->sw_msi_id++;
+	}
+
 	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
 	msi_desc_set_iommu_msi_iova(desc, iova, PAGE_SHIFT);
 	return 0;
+
+err_free:
+	while (!list_empty(&new_msi_maps)) {
+		msi_map = list_first_entry(&new_msi_maps, typeof(*msi_map), sw_msi_item);
+		list_del(&msi_map->sw_msi_item);
+		kfree(msi_map);
+	}
+	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi, "IOMMUFD");
 #endif
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index af7df868dd4f..b54eba5c490b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -33,6 +33,7 @@ struct iommufd_sw_msi_map {
 	phys_addr_t msi_addr;
 	unsigned int pgoff;
 	unsigned int id;
+	size_t range_size; /* IOVA range size, or 0 if not the first map */
 };
 
 /* Bitmap of struct iommufd_sw_msi_map::id; starts empty, grows on demand. */
-- 
2.43.0

