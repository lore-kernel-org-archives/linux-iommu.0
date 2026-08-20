Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871A48CD46
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262151; cv=none; b=cszzwfVyS+6b6gW3ihRhlDJJ1TSglhP0hiUie425kTwyJGj0IZVqjJQu90hV/Jw0aRbE0NkZlqUc9GYPt1j2ktCZ/NaY+/fyGCsoxBBXB3e1mkCZdyfa1ieF/FKG/rQPnHDniFErnFqDKVG5ikioYuk2mHDpy27Zn5ukfnC/nl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262151; c=relaxed/simple;
	bh=L2g4ZtCObm162dRVzoLQ91uKwt+jD6Ypwdsa1iLryV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLzmEn6fNlmrLVebqtPAgBzopfUPizG82jFxcE2gDfUH6WF3uXPAL0fWI6HyCqSxJZqTTaW5kflnjJXFYD+PFPmrXzBIXJldtWLGp7HgncubRAsjl3tmEjILISThhA1uLD6DM28muGzZZTaOic2MUuQ1sQ1s3gSnAOqyzOqTza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=guCYsuq3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OVKC4Ob/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="guCYsuq3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OVKC4Ob/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7Yqw807251
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=79+EUc5zjJ0
	5uChddI9OeEyTI1SRgR19Uh5B705ZPJc=; b=guCYsuq3akatpiGz28vkfo8wojh
	oogzY9QFfOvzIO+XE5UNVoW6M8Kx0fjB1a/Hi3eXp0v7Mnqzf60ahKQpdGI6JkaV
	qxAMpwiH2t8MCKNn1flp0hWsr8liF2CB3jELUoSz2wrEQ5pTLzbNeFuMZZgYu+42
	I6w7/1tDTzvBZtjAlhOXyx+O1wlfD9FHpRu2YdYwMjNI5uNlQwhFB+nSlDWoP1Eu
	BMi+xZ5Sv/h+k93y2W3iUQ8LSIogsf1QczoETPZMmiNOTlgPfWyloI8EikngIvy1
	O3R8KMKGh/MetekRacaSR9J8H4n4Jxtb1Ul654Coyn3CU+xvYMQkAyvQTzw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xgcbbv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930edb4362dso31047485a.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262148; x=1787866948; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=79+EUc5zjJ05uChddI9OeEyTI1SRgR19Uh5B705ZPJc=;
        b=OVKC4Ob/Jh5zHDOE4+e8eoeQcaCNf66QHafv9t0Gm0zwdf3vt+iGhbA3WFLUo/wdAA
         dA/kXSUTOMBqkcZEe1FPry1ujxO8lPKK5jAIq+RL0VnCYH+guzaNd0OSFObcqMQ1ypMi
         zpnzId08SgoBP8UP2wTYnV1giyf7yxWwtSWxEnkO3P9tnRaIayVsghJtVi/NmuiCb3oB
         BpzZdOGyQIMUNQxB7ZITYwN2q+2dEZ/G5++LHfCYtOc0BMTLgCpZtSVM76g0Hu5OJQSc
         dFK95OSZNctAxh9FZdigTe7joC6kbHpYcvEOLNtEZ0v4wODu+ltew42pamdUDz4PNMmf
         wniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262148; x=1787866948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=79+EUc5zjJ05uChddI9OeEyTI1SRgR19Uh5B705ZPJc=;
        b=nJ6BU/O8sipd3gmlxOMe4jaqXHwZ4BDSFI9QvGS2qqkwzRQ1FMsABvaSyyPP4S9K8R
         6P3u1ottYs9ZU+fIYfBcQPItIbc+2nAxsp1GkPo0/wlRO5hyrztaOD4SzooeSlPdR/IS
         w4thn28Vu8ZMavzsz+iofiumLDxrAViGqhvbK2Y0nTeo//KfihtFgQKMHzOSqmRiiSLd
         lmqM+4bgrXOwApMAyGDrmapNx5dC9UGWEhC3DEIJuCx/8VMf3KoRchJyixesFqqzLmk4
         YBK7Wu7Q3DHArxzi4g0MITh7GHob0MNEbd0QdAQt/9iv23dScXqUJVmZo3kiVIMLWdZ/
         rGZA==
X-Forwarded-Encrypted: i=1; AHgh+RqGQ80q79Gu3fzk17b8ROBHI5n43UXgvzdikbRgskHc+82Dr105jmGIhNJkBNudAAAMW285Zw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWJ75WQlKQV4AGnJPdKObedASwak5wZ3b9tuBEEsHxRE+MparI
	iZoGIEClRZ5aiON+sCus85d54JdOg3L0fXu9NNXYuRYlls//qjkanvGErw4AsE6VRxOVib+5Sj0
	CfTM3NNLx1N7uR4IwHlDi8Y3aaYhFfqNDdIv50w2810dGWhPLDzQidc37Ug==
X-Gm-Gg: AR+sD10CyKemoYUw/wFek36kxML+JYLxlV6ccm3+vMXhF8cFBSikrgdIWmKZHRvmav7
	5E5HCvqCJ2gk58SvAXJvjujDeXT0a1XrCi7F2nMqLkBkfeXMMkEqL5ihYp4NehGn0WnpQ/yBimy
	v3+wKIRsq2d5VeXPbNSGYU30k+xKI95z0nCZWJFopgycz4IxulNr6RsrOOkSA29oK6jgBPzMq1G
	jOobe+pD0lCB4kTDNU692OwohGWGaouIMe2JBfsw9qx9o2pWnb6Fh4fjDBl2R9iiGEkOhYap6mX
	+2t3031f3AJDV9DCZgFdNE0Yby08U+tErYIkZECtN8OEmHlmbf17RK4s+m6ksaJL0j84Md/OvpP
	V4xktFVv9
X-Received: by 2002:a05:620a:6018:b0:925:56bc:b8bb with SMTP id af79cd13be357-9373942e505mr132609785a.9.1787262148633;
        Thu, 20 Aug 2026 14:42:28 -0700 (PDT)
X-Received: by 2002:a05:620a:6018:b0:925:56bc:b8bb with SMTP id af79cd13be357-9373942e505mr132605685a.9.1787262148227;
        Thu, 20 Aug 2026 14:42:28 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90f7e24sm5954095e9.8.2026.08.20.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:27 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 17/21] iommu/riscv: Report cache coherency capability
Date: Thu, 20 Aug 2026 23:41:46 +0200
Message-ID: <20260820214150.545737-18-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GPM41ONK c=1 sm=1 tr=0 ts=6a8774c5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ITBYzW_wA1tX7bdzKc4A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: WskyHPNTNUdzKO33nMQUnZiX0WSBuJMD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX5xPTFhi9J7W0
 f6C7+kRSsaeQM1KoAkHJx9Tam0ZVl89A9lEWHDb7VMmDOmKfhgM8/xl9B/g93r7jHnpwYsa5OnQ
 idcmDBylBnrU7b3+ZEpkM+My9Cobc6z7uVGX6l4PbNH1q/BXujMJpGwpNjeo41b7jNDuvkFuPCZ
 BbTsi9K9blY4jljIlIZhTmN3/qmDcWO47UQftQYGHBPSvy7y+BgFUxIifu7oHm7CzJxW7rIIDqw
 be0piW5BtLX3qqcNCR7g+qdHeHCz223vie8JvV9Gz5oOsot9CfImUMDOvpPBSUEKOZLAkhdHj37
 5U4wZURA+hMydxaoK+WUvzFGPRYhALZyz+hyPKWe0neku9janB8dCGCUxhkR68vy7aJQdHbvT3X
 tIVZk22ajJutnQaWX9WHyFuR9mw4SPBaRCQnuWWAMNGwrXQCFOvHvc+nle2ymik4vVqI0Ofwdu5
 vyL/ptDZ4ABSi1Ji0qg==
X-Proofpoint-GUID: WskyHPNTNUdzKO33nMQUnZiX0WSBuJMD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX/+vNfU5jAGa7
 yjueopU+CPmxTfztdmSI5I/kT/kUAHH3QF9zXBb+5WsQl6IfzdqO8qmdRKR0v+dOoWTYgIiTVrw
 XeTFFapTdM8aQHCj6NHAGLlKZnqxzjk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

VFIO and iommufd require IOMMU_CAP_CACHE_COHERENCY because they use
IOMMU_CACHE mappings and have no userspace cache-maintenance path.

RISC-V page tables preserve physical memory attributes for IOMMU_CACHE
mappings. Svpbmt marks mappings without IOMMU_CACHE as non-cacheable,
but preserving physical attributes cannot make a noncoherent device
path coherent.

Report the capability only for devices marked DMA coherent. This limits
userspace assignment to paths that can honor cacheable mappings.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 22cccc69bd2c..161093b1d9c5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -16,6 +16,7 @@
 #include <linux/acpi_rimt.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
+#include <linux/dma-map-ops.h>
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
@@ -1429,6 +1430,16 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
+static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return dev_is_dma_coherent(dev);
+	default:
+		return false;
+	}
+}
+
 static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -1520,6 +1531,7 @@ static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *h
 
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
+	.capable = riscv_iommu_capable,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-- 
2.43.0

