Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4A4E06D3
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605937; cv=none; b=FfVNFzcyhATUPXlqJBZL8r2Sh178Q5Z2gWB0f5ufSQNH2OIY9y/P5cDOOHN5snUUxQ+hgR8JbqiyaMvXDTi5Ja0aQkkirIkYCTMI4K+cAU+5vASG3GUCWGEI8Po7ln/0AGyi4Ry3eqIJfLRG9vx3bRTm7ljjD3QKmVe+g+rzQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605937; c=relaxed/simple;
	bh=CaC+DGtWJjwAqbEthgYpBOFABVsZnZQjzVWIplMfmvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHVU3R1bnfacobi0mC+0tCiIMvFfjUd3Xc778snbY3Y1SIgkzz6SX4NYgbreK8Gg62NPQc9J5k/E/i19FBZgkwv9w+r4DAL3ifEXrOKQXghtXz9PUijDpwo9I4jBXtirbZmQKwi/kzuR8/9v1W7UFgybSLLXiwjp/Cex59P+8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fqtV9yvy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gqwpylwe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fqtV9yvy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gqwpylwe"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAP9V558663
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JEj5sNGlPSI
	l2VeO8kXPsfyM5B41IeUh30FccYbnAeE=; b=fqtV9yvyZMRv+2BDcCzmGqd4bu7
	uoPeUO4RAl2KdRrPVf5fHKtGKl/m3VpR65PJ++GqrjrE0bs1luViQsWOpnWxqrUG
	BYzC+0tZ6yVNO7Llz35/BU+El3NAKDP1iZ56B8VGxg0ebZ6dll9Bx+GR4WF1zw79
	RzAHA4paBWEz2cqB4Ymfv/21P5NIjrNPxJEUAwNTCeXqsAbG8CNOMCuPEq5O0IIa
	YaqdNvj7czkZH9/htZy4uMrAY5aiQA2xOFFfZ9ypXuG55JiCCF1UIygba1Lk7xJn
	Kku50sKAzmWRa1bMVd2accQVToJbjnOjCZ0aoXXbP+xb4Lopm2b6105p2yA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq2k8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:32:09 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98537d1242aso2821756241.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605928; x=1791210728; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEj5sNGlPSIl2VeO8kXPsfyM5B41IeUh30FccYbnAeE=;
        b=gqwpylweB/FiGBpDM6IXTR0rZcFkPl1kvEItAqZCkbMTR+ViithdUPzrGKCnb72sG0
         brcZ3qqROtdGjFoO3CtWFOKNyfjthjV5RLPoyu1vzJF0VS/ZsfkQJ1Qkd8P6BPzJ5kZg
         RXt/fMkBGjC1BET+wgMXH+ovbc/5JT2/5citncZjyNGePlCknY4T8Wvd/+lVrvjVZGJT
         wQlelYsjoHxQJhDYkdk6W2MsBKe9ggfK7lNDgrpdQqpwNTXExOd7KJEFmpZqZjX6MwAz
         NxmKI3bQwsFRTGv8v54O22ceL5UnTVf1EfntKD8w4EGfS0c0mUDQC/zLpEShZ9gjnlfK
         qWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605928; x=1791210728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JEj5sNGlPSIl2VeO8kXPsfyM5B41IeUh30FccYbnAeE=;
        b=rNfqMxhuMDdfM05L6zxl3KGLAfKmxoFzkphSOVlemxO+8hk/2m0E+r1FvC/91vHJUX
         4zgOoLoqQTxRh7150Lr13E5oOVE13zBvhdH+Gq8H3dsUHUC6YYwUfqFus4s5ynLamWtB
         VVXa0+peG4OTSB0oBIEoE3FkNKwZj9tGg5hLcYkm14QOE60MgvVVLv/+MT3A+bRCZihV
         pwS13D4BtjIziwKaQDZQrreWzOQO2gKia1WE+8+VczmXzDUqoZwoE7EEEclc8ce+9bAf
         gaJ07UTlmESw54d0ocizTJEWIsz8Fc2dMvg4dOJfokgxGoZ4I4YHcONiAGyXN/wdIkHO
         10zg==
X-Gm-Message-State: AFq9FYLMDRWvFDZeNuS1h0RsY8hb88sDTwIfWkp4PfUn1wwmDBZEWokZ
	rHzqDTpj5a6NyE2vxc/QrW1rPNCLAgCVbNmH/iebPt1HtF9B2TkTdYDZT1Qph3jrYsuE85/7BYr
	6BEzOJ6HpJ5F29gTZalZQbiDyjL+KAadEFOlh0KxNUWbm/CqFGjME88TbtED7i3Smlw==
X-Gm-Gg: AYBFou1FVI4EwXW47HZ3IMHUdPBVd3eEFOCZyC6rC4yyc/gzLjpPMZGdfYf09Pzc2+y
	dmWDRahSLZeDkKw1M3tmi9NUnAnTest8bc7bO3OZTDI8JZmngWPRGOfINqhZEqNNA8xLbH3Ckg6
	anJ5CHaU4mp2Jb0AC4WD5IlngYieqOPbRgSu78NSc+a8thwyuXud1OUvNWa73VEuLwLemx8OB6Y
	zZkOC6SSLNXIC3z1paRzDpKd6OLmfmwql+g+XqkVLYGzLQjOCnFt1dSYIgc4N1fExL7yWQeoRoU
	jCWjPebLOZZ0YONXGfVqBsHtCPHJL0fGx2GPy3m/3D2Pnc8X6qnn+CDZWx/vDqipB/TIm6fOZ7G
	Kg5lrfoaGh9sR/wQ5n6PuSKUsk0Z5MvU9wK95uA==
X-Received: by 2002:a05:6102:a4f:b0:7b3:4af0:976 with SMTP id ada2fe7eead31-7b34af062e2mr2413928137.21.1790605928503;
        Mon, 28 Sep 2026 07:32:08 -0700 (PDT)
X-Received: by 2002:a05:6102:a4f:b0:7b3:4af0:976 with SMTP id ada2fe7eead31-7b34af062e2mr2413665137.21.1790605918611;
        Mon, 28 Sep 2026 07:31:58 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76a68aasm470794566b.35.2026.09.28.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:57 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 06/14] iommu/riscv: Cache the programmed device context
Date: Mon, 28 Sep 2026 16:31:05 +0200
Message-ID: <20260928143113.49838-7-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jBZA28kG_nakrwM_2icZfj1MMY4hNqL9
X-Proofpoint-GUID: jBZA28kG_nakrwM_2icZfj1MMY4hNqL9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfXzTcdZY1y+o07
 387xhQTIEEsF26bHHyPXSGhfynkafeFusb3HatURCt4qwtow5i2UF/BGNQ+Es3yKEDMTYN0Wmp0
 H2GBmTnQk+DSR41X8PINcsSYFefwtHw=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba7a69 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=YF9vHHK6WIIsxUIbJtgA:9 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX38gxE7c8ClyN
 faytAbDy80uO9klA1Xq6sSTmwN//RWnjnUP+leY/amM3MqtaqSABzp2v1hR3Ps0tlrgpXpUXiGL
 eeBzWuYJJR+iDianddg8o+18yCTYS+frHifoxdJdp9S3GUlXRv6OX/4bOeIjwO4HZdjGDRMUUFi
 nvpJJs0sy4ZO2Aby9Zx+29BQDtBOdsIwV7AmlkBkM1h9dwfTEqcdfdVnyMpYlOjVAZfH400KmRm
 5GHV+D4DNhGtP2u3lTPYKd4tEv7ofRteNdfgTHbJAkTHD9ReEjas+PKURDJOdmr1L2hbmFLwIJv
 LrnCh6KteTf9UV+ZEnF+4xHJafxpvyQCXG/gyWLUc0E7OFmE19EL7LZ85R+C3r/uajvQLFrxNYX
 8nmxCqZxQKl/gpRQMv96Gj7ua4B+iSndhVOHAFaTx+PK6pLesZ7WJH6p11iB8BiInBHyDbMN8D0
 DqSX6yOHqaAyn34cdDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280057

Interrupt-remapping state needs to update the MSI fields of an existing
device context without rebuilding its translation fields. Keep the
software copy in the per-device information.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2cee87ffc122..86d5795a12dd 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -872,6 +872,7 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
 	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_dc dc;
 	unsigned int nr_forwarded_irqs;
 };
 
@@ -1513,8 +1514,9 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 		kfree(bond);
 		return -EBUSY;
 	}
+	info->dc = dc;
 	riscv_iommu_bond_link(domain, bond);
-	riscv_iommu_iodir_update(dev, &dc);
+	riscv_iommu_iodir_update(dev, &info->dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 	riscv_iommu_msi_tables_unlock(old, iommu_domain, flags);
@@ -1668,7 +1670,8 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
-	riscv_iommu_iodir_update(dev, &dc);
+	info->dc = dc;
+	riscv_iommu_iodir_update(dev, &info->dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
@@ -1695,7 +1698,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	dc.ta = RISCV_IOMMU_PC_TA_V;
 
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
-	riscv_iommu_iodir_update(dev, &dc);
+	info->dc = dc;
+	riscv_iommu_iodir_update(dev, &info->dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
-- 
2.43.0

