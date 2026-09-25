Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EF3A5436
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349441; cv=none; b=ZqMqXXwwdPNM/DF/KpD9JHHU/RYMQF4JHP3bC8/737hbjLM/cOwql1qkgiv+iST3ICahmYNFYdfvm5zv7pSWLoie1seKEy7/R2CQTCgVDADwVowGz8h68ZfEjNoXHUGfSY3/H7celX+cuo41/DDMX01Ojfx+4kVbMJtivWDrgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349441; c=relaxed/simple;
	bh=SDUoeqvSzajvY32roYbZab9LFoIzSx5uPJqmyVedHHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMwt4jA15W05Sr+b54iWX3nO/31fuj/8qmsj0XEYU4T/kXjKRdzn5OqgWOvEsfj/ump3H+gN5QLonfE5yKVlUGJuXeBtukklV7f1VRmH7aKn8dJlln1zv5r3MFvA7WS2fCYIKI9kTTv6zYjiPJTWLNMAjlHxHcHoDRLOMmq61jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VQ1Wo9Oc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jrIIRXnt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VQ1Wo9Oc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jrIIRXnt"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA4DuC609117
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2Di7hXjezOC
	UALhcHgOGZSJbeZgIexdT/Z/W7mUl2YU=; b=VQ1Wo9OccKIVhqnOLCsJBz+TotK
	euZTwoFXCT+u8zdZvYN3t+mydoYsS5493vDLf4CROr/rCLtV/dmxw5bh40D4btyQ
	sEw8zVtraIU3nXKdeojYwkAWJ3oTQRbp3Zus3dk+/PqNsanf4DQi4zgtvHH/iRPc
	vrsGByVGc7cSt9SgbK0cQtCnxno09ziPqWYC/RuC1PSmN1LNC3ikLe/bP3ocbc4G
	DVx296DJvkoXyPPOAHe+JATV6S1m66adQ+j6m++vzq3qlOY2ZlwYa3d8RKKRrMs6
	D3zVYR/r7JGxgiokIHHoHNwxsk4VSpXoLTXt30qFEiuQ5WM4fv7BYvMgXMA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvns15u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:09 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7b2aa7ac788so119291137.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349429; x=1790954229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Di7hXjezOCUALhcHgOGZSJbeZgIexdT/Z/W7mUl2YU=;
        b=jrIIRXntE8XQ17fBjYfD723p7Jh26Vu6at/1gct4rphivZumUXWafQGPL2VDAuvQAU
         aPE1kSL0alchcr10TomzCQCNpyj46XkEcbHgaj0osbIowvJk+mP2G6cNNSq0KhXxlSQD
         dMOpFzE3SWz5Zi2nV043KtCxHDux/iGaDAHZc5PimSrMadw9DYq4/zulD2vCt9bbKZnc
         4uz0cC0EjBIb8NIuokKrjohTYtB0MPNMC8mBlgNsJgaxYrYGdz+sCgH1R1lNHDhlWRNp
         OwIF6uY5VXVa5CUTliE3j1tJzptVVWm0UKR/lPk2/yYEGR+NfQubF+voE2izF//xQ/uE
         MuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349429; x=1790954229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Di7hXjezOCUALhcHgOGZSJbeZgIexdT/Z/W7mUl2YU=;
        b=MlasWvTA3RwO862qmSMv35C882512Vzb9WNNiDCFaYM+IFsHQrEeDxGcrWrXNgJ843
         Z7EcxhZIOYE11+aYtbqr90YOEfBcUymSOtA1XCu4pMzTnDpIJc6fNJ8gAWCx0o+tExlK
         0wuPpI8qFbrEr23BBx2nmPQUVX61v89prcG6uOMWifMZtYp3abV36dtyyIFrdwSArFcH
         sbAQmP8QdbgLBSLwLBMCyo4CWgpcuQDoBZlEwIVeT36/MgxgVpMkSNWGcVUqeGt/bRNH
         tpGY/c5+Sx1DgWy97M3+GcHy00gdk3py8HZjMOT+qPes6G0IrTpRCZyhTGZa3bQvMCTv
         BG2A==
X-Forwarded-Encrypted: i=1; AKwUvBx7GvInOBb8WLMXwffOFi8htdK5lpt4xF4fkyECcERisk6csugcJ/XDRKoVLFpGv2dv0fUW9g==@lists.linux.dev
X-Gm-Message-State: AFuF++keIDsq0oBi0UK+qERzMQ+tLBoJ+1lIgQCdipV7KwqeInXqcl9z
	VvDwaeLx4RLQq7rbsZ1/7mjTfUNsaILq8gL3vfbto+cx5981Gcy39ZdSlTmCRNUM+Mk133ZwrfR
	goLQoR+6TlrOoxK7E8s51YzReAwvi3f8w13Xc01Ymjv2l6vo1lI+t3PLrLQ==
X-Gm-Gg: AYBFou0+McPF2bnKK45rBU6Dwl+RDtWVJ6qTFRWsfvL8vefRaHpURbzhYqbBE9mGevf
	u42QNb5H1E0pbFEON4wbvV58QQfX69T2EjQF34CrdtNqsybkqPx6X+EjwSEctig+QTiKCd2F4Cy
	U8T3tbvwEvenU8xCi+nuiGP9dwuLy212S5aclBqtfybXtP4XvihKWf5/IxoabM3pQxvxkCO6RRM
	IvYEIzcyIF3iK3YaLnqygnj2vktKiIlPkRnSb7myGmB6aSFTjfSnTumhJCyLHUG/cCtGBzK23IY
	XkNJv422xLzj/qliObcG8rjFwd8cBemJ0D5mGII6uo5zElbK80Q6ZSCZg/kFOicd/LjvUyhyLAu
	E8Vm3lg0/9LqWRpkl5dBNzgDg2BVs81vGHoytD7TDYIrDWcRb
X-Received: by 2002:a05:6102:f95:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7b1d76ab79bmr910412137.36.1790349428627;
        Fri, 25 Sep 2026 08:17:08 -0700 (PDT)
X-Received: by 2002:a05:6102:f95:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7b1d76ab79bmr910381137.36.1790349428007;
        Fri, 25 Sep 2026 08:17:08 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a74538asm7857424f8f.34.2026.09.25.08.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:07 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 03/16] iommufd: Split software MSI map lookup and allocation
Date: Fri, 25 Sep 2026 17:16:46 +0200
Message-ID: <20260925151659.419512-4-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: QRBL3YWb6QTfoW0-B470CGy3LmpeHazZ
X-Proofpoint-GUID: QRBL3YWb6QTfoW0-B470CGy3LmpeHazZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX6ooLzUHO/QLz
 cZF9cKYZ1eK9fFbLWU7dShQTkA8XAlCJi4xedtZBjASpA4Mmg4Z1klvnC6BM8w9R+UmEdVAEhTJ
 oqvi5MCrUXn/C6bJrhZUunYVITGufs4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX9WNHSw9tC/7+
 JdS9G1gKWkjCgxgGfnFu+Y4qs4MjgdHnCnRqPFewkJQ1Iwd+fWfKXVt3paAKgIbH7hnP2NLeKBh
 E4ZBUL7WRQqOEHyjzxxu5tErjZMhmkAO/UfqgpWTjldXF4hFWYXCNSZuGJ8ndO/Y9o1ZQq77p/y
 hujC/gOxA7awu8R32H9chdp6YnpNLur9118etZM7Kxp6cZdHwr93qOq0wX65Xz/y6WmC6kIaVai
 Vmj5fuYI764Pn42CLVEigfe3++NXxwATy4uxWwxYaT88t627JjSDsNT8EcM4DWzFd17Kl7eBW7f
 Nl3qOuaff6XY2sZePR0aGKaZjgAfWuzj24kEcmKB5aBvYV+6LWp+74Pac6vr8fyXgOJcgPnDZra
 qOlYBZUiQlXD8cRgEbdXJRZQv9jfxGtgE1/cHxFwEAZSuBLTQQahz3zF4dV8HCYwq1gptRvTUa7
 G/rZNtDJwvz7t2p8u8A==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab69075 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=_mR3RRazA89hjPCjrIEA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250060

Separate lookup of an existing software MSI mapping from allocation of a
new mapping. This prepares the code for allocating multiple mappings for
an MSI physical address list.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/iommufd/driver.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index ea705e416139..501f1e1f2797 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -189,6 +189,23 @@ iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
 		       phys_addr_t sw_msi_start)
 {
 	struct iommufd_sw_msi_map *cur;
+
+	lockdep_assert_held(&ictx->sw_msi_lock);
+
+	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
+		if (cur->sw_msi_start != sw_msi_start)
+			continue;
+		if (cur->msi_addr == msi_addr)
+			return cur;
+	}
+	return NULL;
+}
+
+static struct iommufd_sw_msi_map *
+iommufd_sw_msi_alloc_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
+			 phys_addr_t sw_msi_start)
+{
+	struct iommufd_sw_msi_map *cur;
 	unsigned int max_pgoff = 0;
 
 	lockdep_assert_held(&ictx->sw_msi_lock);
@@ -199,8 +216,6 @@ iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
 		if (cur->pgoff == UINT_MAX)
 			return ERR_PTR(-EOVERFLOW);
 		max_pgoff = max(max_pgoff, cur->pgoff + 1);
-		if (cur->msi_addr == msi_addr)
-			return cur;
 	}
 
 	if (ictx->sw_msi_id > IOMMUFD_SW_MSI_MAX_ID ||
@@ -293,6 +308,10 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
 					 msi_addr & PAGE_MASK,
 					 handle->idev->igroup->sw_msi_start);
+	if (!msi_map)
+		msi_map = iommufd_sw_msi_alloc_map(handle->idev->ictx,
+						   msi_addr & PAGE_MASK,
+						   handle->idev->igroup->sw_msi_start);
 	if (IS_ERR(msi_map))
 		return PTR_ERR(msi_map);
 
-- 
2.43.0

