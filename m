Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63714A5EA4
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188394; cv=none; b=RKEPxtS8Nc+Nv1xuPSm0TCtqnq/MDOwVWzVis43M6WNvk/LMeVpef9IOxH1xvX8y6j1N5y4CAoUiF43e5KLlk9LQwTFl77X8MCu27R21Ptif/C/qo9sXq18JrrsjsccvGEFAbL8wD6yomzARxWbdeurTY7+LQuhONtovDCC5RW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188394; c=relaxed/simple;
	bh=VkDgGhf3pVTVVs4TjCIKO9ed3DJ83g7eqDMUmP7zsMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWtRftciIwPAGdHrVxfYm9rPY5mJ+FO3+XjRy4XcLazN59gff57lunWl4SFGgT6xhZjjKMvbyLZXjTZCv50hjl3zHr2zYws/RUEbjs30Yh2qTtRpQ8EqfRFUdvgjUZdHxsgS8iy+EDx0CATiq2U+RfG6TCNKqxin5I6cj9p0ApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tvpmr3b/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bFwtEJmB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tvpmr3b/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bFwtEJmB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETWjg3807963
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6jRs6t/MtD4
	/KvZkz6bTMmF94mAlAEjwCXwq5zwVULo=; b=Tvpmr3b/n+gH1qkQjzEane+onHE
	HJl3j7XKS+R696JDcCDt4SHnUsqGxikRmmw1nK/2Fgqgap48ngrFUssta3/Y2a73
	umAiJmxB09hNcDqIjNIGCMwZy+P08Za92pZL5bp8U5LmkzgUNvhOK6WiBj6z4S0Q
	RU1GbGj/r3sipkXmtGr2BYAAIR1F2mRdt8TmPVQp7VtHrGgWiLe0PsyimsimfeXr
	qogjxLOPt1JhcXBdY4MSx0/w0da8nM5v9d8vAEk+jKLGje3IH2DOKXbOXILWDCT3
	hcnd5G+fsa6SxtAJgvBGEviLlSZTOUMvygIe5/3zoj1vDXXJRQGYuTRe/JQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7wbahx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93922c75037so242311785a.1
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188391; x=1788793191; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6jRs6t/MtD4/KvZkz6bTMmF94mAlAEjwCXwq5zwVULo=;
        b=bFwtEJmBh3G9Wk7/kmaThr8/sMGO3SvbYZ3wybGxayMwj9Qvao8bNbezDoyNiKFv60
         E4mBzEM12BzzJf8f9ElYjH1Cghd9V5rL4Y/HN9E2S09bBLwBeURPWk+TPJCNSCVqs8Vm
         w42SXsod9lN6yK2sVaIE2NJmS7H+bJ0jbPjPpIH+r+Es7R/TUijqRNjzUcuXYwNubtkm
         aC0eVLZjjbPd9jv5fVeqOJ3Lqofm9D8TT4AHt3gCfr+HRpYNb61Rsucb6+PICWOp2nd7
         3pHN2Dm+sh7aS3Yqn9eEio/PFDHFrZxJIG1/jfU85KNsAvLL8gw5Baan5tnRHo+61ftX
         6eJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188391; x=1788793191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6jRs6t/MtD4/KvZkz6bTMmF94mAlAEjwCXwq5zwVULo=;
        b=s3n4joQupBvRf1cz2949P9rKt3GLnodRqunkv8RA4Afz4YjGT9B1zClfT6g8asl3MI
         GFTB38rRN7UEWDZmGML4qn0ggCln53OpVCAg9AbGeC4XKdfxn6HnlvzTveRFLhQDS82U
         rw6LbqRbdXjynXkbXcGisDB6ceBlbvddC34pKw258wGjrcUQgjyZo6fzLQuqWphCqzcU
         6rFdEm2wXDAphjDPNCic3wBoeT1XhBSNWQ/kJwU/i9ohbS9fG/xAckGE+hu9DhkvBQBB
         EkOvdyNzlFqZ8wiWAwyBBQRgLPYIFio2cvYQ57AHUU259ZYQNc6S7i5a4di/MSSM8lvn
         BoFg==
X-Forwarded-Encrypted: i=1; AHgh+RrNqcMOq89gQtiN7oNbHrQB7k+ADvLyQcsjTtmyhgLtEyFUAsye1456CMGLpMenGAYcehOJxQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lq8YLtNegyAAU1i6D0KrEqGhDB3pLHJOHMnOqYwH1fp31WGam0
	tjwsniQI1N4Guia7AQ/BnLpJ1LdRzNXyUnVBqf21OivNE9rRmc3le48tBv59kxNANNNy04IDusy
	c9GQgcvUL4VB5TbHr0n1JpNUxt89Sa5Y8f8HT4bRxGXHY8CQXaGsqyudByQ==
X-Gm-Gg: AR+sD12qUXUBQsfXliJe4OEAVtYjljX57D/vSRgEoUeLZP25Cqjag+k30ccUQXi7Fjz
	/GD49rQU0Brw1k4TjzeW9PC/AMjTPMOy2wJB3Sxr4SGj1c5Oia9LbAiJPrfQXk6DJ/pQM3q1IsT
	CkNSm9XwebUQKrMGItiRkGAm3rCorCmsr+becUx9QodGpaa6WmdN+JaJYft1Oy2x5ahYTspLxJZ
	OIwRLrJbz73emmG1PdXWrL6dhVFkHRRZreO54XQmo3CjBTdfWzwMZLlglqVJmj29IJt2DNQWyTi
	sYnSyZAJStQKrA65UZSkS6ljUk5TKGGemOEi6V569arVovYn9eX150krXm87F/+IDFrlXlRTgbq
	PlMjATAcuAcrCNFFhouFVAi6oR25qi6HOP2g=
X-Received: by 2002:a05:620a:470c:b0:936:e99c:4fc0 with SMTP id af79cd13be357-939137c8742mr2984778385a.12.1788188390753;
        Mon, 31 Aug 2026 07:59:50 -0700 (PDT)
X-Received: by 2002:a05:620a:470c:b0:936:e99c:4fc0 with SMTP id af79cd13be357-939137c8742mr2984772485a.12.1788188390253;
        Mon, 31 Aug 2026 07:59:50 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb33070sm23895053f8f.36.2026.08.31.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:49 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 03/17] iommufd: Split software MSI map lookup and allocation
Date: Mon, 31 Aug 2026 16:59:29 +0200
Message-ID: <20260831145943.313726-4-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a9596e7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=_mR3RRazA89hjPCjrIEA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX4uAbKJB9iChe
 PuT8jKj7TYC2WSkuKmYwQozTqRFTzINQvbMwu4CKahOS9DYX7y/HBlCjHjV6oDkXJUA10ccEFJ/
 yOHv3c1tH5aQuEEJ9BYj9XvgNN/WYQg=
X-Proofpoint-ORIG-GUID: sd6AHpEqx-a2fruUcp8ywO9Sug2W1JCm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX0CQS0u0kM/FE
 QyF9nGFksd6jRBbumr8Mgn3Tmm86f/+a6NKNwROxn7Rp+jCpLTZ/GoRlgsSrcxOzXmNNS8vhEnE
 7ZgRDc9441vUYEMPlG1C30zSfRIc8DMZacTb66dkXue6O8sYiQ0q2pEpX02OGNwXn3ajw6ReAFq
 M1UI8G1ubW81W2xdf+Ltmp3xHf8GLu08cKBMA6PYLxnDH/n9VNFIIZbEwnTusWIiEY7bXQL0soL
 XoRRzOM+s83aLqq3H8HfFAcQ059da65Y2lg//RCKv4DOwhra+GjQib5G8bFNu5k/QyCKt0hIFL1
 eI4CjUOOe5g7vT5QE9CRpJ+8Vpik7o7X7JlEF5IvKNCXWcVAqnU3DNoI3VjyL4nl3QacbxfDXXe
 exKGlhCZHmk/H1h6D8HSahOljvSyOFmlgA5ejXnJEZgRNN2oCbL0HR6g2JojkrxuMZMAyR5UQWv
 HUzNQDGYHGMU96oBsag==
X-Proofpoint-GUID: sd6AHpEqx-a2fruUcp8ywO9Sug2W1JCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310129

Separate lookup of an existing software MSI mapping from allocation of a
new mapping. This prepares the code for allocating multiple mappings for
an MSI physical address list.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/iommufd/driver.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index d0b05b1fda42..3856989f5c4b 100644
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

