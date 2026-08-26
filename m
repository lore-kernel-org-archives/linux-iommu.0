Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D23C449B2C
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755996; cv=none; b=bHlfRhN+t6KY9wq0NlMO3BBlcdfPTz7TQ85E5B92rexABb/TIjRrkPh0oqZScjtFdrS2Tyb9FOxiRhB7VKg2T1kg4IVel6sYN3s58lLSTxQcmEvt94GADmjlJvORQ7fK3MDlkBU8zkhh85LjFSlNtUTclJvCwxEBFdaKLAibwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755996; c=relaxed/simple;
	bh=VkDgGhf3pVTVVs4TjCIKO9ed3DJ83g7eqDMUmP7zsMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6VeAt8IQ9NEigtxtsQvb3rsMrO6ys5Lgt8dxOLfMCV0cAjvX8i6SixHtDCmi6EnE21q8TD+dDCSAAvS8SVFJ5b+06TFGiaijA87xHfpDGnYJRgCd4SGYNTILmZrRn/nrKCL1USG5whrufKJrLMRSksvtBEY4qP6x8E/efjtgjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jMeBJUN+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T/e387QJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jMeBJUN+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T/e387QJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDuhXI1703066
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6jRs6t/MtD4
	/KvZkz6bTMmF94mAlAEjwCXwq5zwVULo=; b=jMeBJUN+cYzWGKvzAGZR9hebWzE
	CCSRinnEwpP0jnNaKo+qJVGyJvfzWovXTFAaxjTJSemT6MmLGo69sT2Q3GnRKwCy
	OVhS1WgE/+QD5+hIYGHiKU71V2TJFMhR/ZAnb62ajzmV5+kZgobs7owLEf+5JuQb
	x+K75sdwj9JaG4Mp58kiiGpUEsTOLAwaS6lWQQjoPQ9kAIOKcj11vbP/OLx727hv
	3NkdbclYHF+Kh03a/5yHyNzvUpIKSfIU41JB810WlgpRrnpCS6X6wzRC5p/xijOB
	X0eY1qyW7RK8a27hKtmvbAzo2gcWgGzT6NsIyMdFS4+wGRx8P8BY3G9yBSw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbrcp0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso20550141cf.3
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 07:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787755991; x=1788360791; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6jRs6t/MtD4/KvZkz6bTMmF94mAlAEjwCXwq5zwVULo=;
        b=T/e387QJY05RiDb/y7yhVo7o/0zZeQXPDTb0ZoQT486DRvgoQHa/2tTDToadngQLG6
         hB7i9Ei5HbhA45D0AJeQwQW0BXNnum14arg32hM4PKCZr55GPkq2Xo9XqSlq8cRQ5INm
         Z9z2GzlO3F+iWlQgCodMwprPg0bFONHL/2RS+x/N+9epYnxBhg7vtTmL+WZK2/i1p9gj
         w1QkU/uTxrb6T1d8JkgGtOG3v+BMm7ep85sSY5Ilh18fstFCueP85H18KG0cus1VfcDl
         3g3Uoh8FYss7rEPQozcXRxTSoWcnQeYk1RPG3cxZsJ1PT39+tBOO5WCVB/b0uOeDd8b2
         0pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787755991; x=1788360791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6jRs6t/MtD4/KvZkz6bTMmF94mAlAEjwCXwq5zwVULo=;
        b=S8RRP9IDd22+S7JmZ7QMJelo2xIJqwluSqYT5W/gL5JZJgyBwSVPuebg1kXRdMe/4b
         WLtjNfcMYzURN/pgE5nQBpZNr97Ce/bmtlnx8MW7xRnP5rkkJCb7XWC4bk9YWv3FqRNX
         Ztc7qOCzKqZXhYKNkVzt80Ls5LY5uGx2W6JBXQD/ZqriU9h13ZDh0PJyVJQ6CA1UExyF
         S0Defco1cwxsb8C3PcQW4e3h6oOluQeg1Pbvy005KRFP3YipO4ib1O3GkHe2i//XA+73
         sxXRNGzPIrRGQ9hcOOAAaaY09iUI8/DPJCg7YSehVIidNNdY64xrVrR08hQz+iUNmGp+
         7BJw==
X-Gm-Message-State: AFuF++kGvm1Ea5hLWEqxzNTpt3e5agFyF9u/1XqgDZvGIQEFzkbVf0+g
	W3NAUaUCjofkvEveNf9YT2BXJ4O/qzKXwWxsgbS7n0sBYUSmFhCSTNK7t3OXVfxELVuY6IkULIs
	od8iz/ZBHdWwFNHZyxf0vuWAbTcVPjsA0zeJwhD9gwBGZcjh3Pg3xu4F41Ul7UwdECQ==
X-Gm-Gg: AR+sD13yGKfIhCZR/y8TfGPsJhelf24vOT87NzJP0EhTlG7JFG2wnZ9WlLp9U3emlUo
	UXWSnZVTCHus/GfR1D+STzQdREIg6+ds23EDjqK1bsj00NPTPAEkhcvBJsdbS/60oOnT31gqMpJ
	xmGSC566J0s+6FlhUu5C45bBip/qcZuwoeVJBRxNSXhe4hzjLKH2NG53KVUXCskgmaxROwgu+ow
	v6ZKgUOL+jsdgnVICWk/DfhwoQ9QAwtkrLLc1qdcR1JIyVG2IPCETpeVjaTTO8Jt813mrfX6V4f
	NAIxzZ1PS5c3pTbYQ+0oY0UkM9azu8d2vf5yYGkBIaQETRIKsrskd2WGZ/ObJzUUkBuJP3ulLS+
	EzaN89LYK
X-Received: by 2002:a05:622a:164c:b0:516:ed02:c85d with SMTP id d75a77b69052e-52e4228dbc1mr72187581cf.3.1787755991188;
        Wed, 26 Aug 2026 07:53:11 -0700 (PDT)
X-Received: by 2002:a05:622a:164c:b0:516:ed02:c85d with SMTP id d75a77b69052e-52e4228dbc1mr72186781cf.3.1787755990497;
        Wed, 26 Aug 2026 07:53:10 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc960e80sm30023145e9.1.2026.08.26.07.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:53:09 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
        will@kernel.org
Subject: [RFC PATCH v1 3/8] iommufd: Split software MSI map lookup and allocation
Date: Wed, 26 Aug 2026 16:52:57 +0200
Message-ID: <20260826145302.449904-4-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ZGmILN-l5IxismRrZSkxAiWZrYI4PWNv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX+0TcFevkXVFP
 RJ4AEtJkY6aIATzhUIfvaeYh2+XjVlxyvFYkt11vG5eh4vMcMa6aNoxjg/rh5rQeq7LdoM2f9zr
 rYBQzW/pWpHocNSZGKY9xtizC3YqBbw=
X-Proofpoint-GUID: ZGmILN-l5IxismRrZSkxAiWZrYI4PWNv
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8efdd8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=_mR3RRazA89hjPCjrIEA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX6h5fCybo11Tp
 m2w36j1P7WsWo9EUFrUdyZq4B0rJ3X3ALS4rwtrmhb9+xER5t448Lvq8Dj8qoCuWOw31USOBrvp
 C9jahxra7Z66FRdA0r0S6e6DceDocQsLpbVCgJlvuz8KMpx3jgDa01O7xOCrf0uCymGb953q/qW
 wjC7fLq2AGTCG9PNV3kQhLNtuxwG/LcCs0Wi22Lwy5oBsJoCT0ssgD71Dj7h8MoJoRtBCQRm/HT
 RTaTP/VIWf5Baaulj4iptKkMBPUIppU4JLjXOFZFxTRGrqA+91UysWjVM3xlnPk9n+mPOacKRZe
 xm+RvQQCcKi/bV97feZi7efrSm5kEJRFAfhmnSeRA4e+zVynNj8KzBqk1wSXLNuwFXNVSaFyYOp
 r1RFyKOqUpDTw05rwH9xWBnwI2xPeL+3Uk/DGWpexXYmfSAcNWsyKQqH7CGnA5ZLliZSYvnFx2y
 Ho9OMg9Zh9y5j620HBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260124

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

