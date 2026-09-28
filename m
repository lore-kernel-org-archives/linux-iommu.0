Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E36483BC6
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606415; cv=none; b=HdZ+jF+m+aPrVSe3cVMgoOmdTs/qrQ6LChZKe/fiHEDN8/HkLNeZ6lVqDrWKXjU1wV5inB5VTWGaItd3lX5V7QkgACtAKHK/vAbkFQo8DMcepxZvQCLEQS4kPAp4+Qayczb3W6D/nhpt//0TNHRu5BpzilccwAqFrT6cs3S6Zjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606415; c=relaxed/simple;
	bh=yRSrMfOIOY8yc+H0kITYB7yCLVZjoqzSM1JBHxbzG64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOHEDbtnmISYCnADizt901yDea4nXbg3XXooXKNVdcXCHl99/SiQYTL3Vm7Lrbj8+x9vJ5lBes1J/aiPoadoLy1AGzYZZO/C7DZyn3w8f8AVQ4uf2hmD68l1ck1RvKpQDDZqDpOI+T2pM+pW/TrRIqZ80uJXRv0QtpNuQiUq9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MMdr6s/s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YeWXmBLK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MMdr6s/s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YeWXmBLK"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAX661189846
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=95f+Fzhwpw4
	3Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=; b=MMdr6s/ssYyFfuRlTdQjkQCbpmb
	f/ssEosnetm8jJ4kwLwqF35IMwwxxbL4dnl7LoGzzMRtqh3+R+xinaj7DNfgQ2Ga
	8Fy160rzhWysrV3GR7XiQJDH+kWFFlADerqmc9BHUEef8rnpccfEYuLFzmMdATsB
	3d2OuWjIf3U7Prn4tYsYMPvq3Yh6ANS8f2CrHpLroXfPgZYFJZ4MPiD20cw34Pcr
	vCMizsLjBIUMxH2yqZe2hiOP18Jmug11NTuvzHNS/3eQDvoYcgZz/vzUVJIcrpMO
	r9JmFn7Ah9My+daLge+eNX8ZN37hIulxY9tCaDYmtwqRS7UJEo6600umIpQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc16rn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:39:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so3687038a12.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606389; x=1791211189; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=95f+Fzhwpw43Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=;
        b=YeWXmBLKXM2zZiZeF+TM6VTyCnZgVUtea6tadH+tHnMjrQX4saliombsQ/WuwCIPky
         XfuSgLNAZZ/9iLYbieo8X0CcTEsJIrJaLDt4nRcbiqHp480qRPSHw+kZBxchUSiMjtLv
         TNyi593r552osvzYdZG0Ia6hqIsSUqMsOVSQXD8+PdRjugsRe8nN0XZI3ylJ41TvT4gh
         9HZqth26D7Iy3zpZrO7630PdulXGNprKQIU/ykc/sAwjxQJ9OcdEs+jbSfinWLJSgJ+0
         qDytUr6b2nVuTkqkYS6kkiUdD1VTpVNHm6yXMvm9N1jRYJeweW/6NzVeo5JNSVdmshCR
         KVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606389; x=1791211189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=95f+Fzhwpw43Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=;
        b=aiPnY4Z/7AGCH2DwGGAO/BkXq05VlC9kCrp1Ipo6IA7cZtoDQtXu7YAHVwj9+m0lIv
         6aEyFhj7mXd06/SQahlof4g6ndn8Jer3WvB93QUXOQRAyhrOcttu1fIV+m1ZhpBRzfaj
         vS8v9IV3PuG/Hq/OMmttQ/paeg7d2+0QQtk0OSd+GWE2I0NviyrfrYp1v4MIYK1GlnQR
         6j1Q+FTxUYJYmD59ozeGn0uv9ZO8+FNQC2agGo03jP223d3iArf5UpCvvxLH8jz+xPJq
         Hdaj6hR4ZQyn1YCxYt4mWKblGCJfugVj7MYl7lVWKxWcDjVmOB87wDOG47Wyi3DkDdKw
         Ue9w==
X-Gm-Message-State: AFuF++larVH6f9gbiMRYKstXRdAb3YWJ3RuLyO93nSeUvfLbBmQF3uIQ
	Aq/CcAtX6gryZEgp+48kiniBWdHnti0M2nDwdky+bkWKO1DJKRnJCIgzjnT3/GA3Vp2vOWBJ23k
	74lDceG4y+eW0hS1C27QAd3MicyIYgxC/ebl4PhBBAFwd7tSzGjbhwW3M0nXu5VE7ag==
X-Gm-Gg: AYBFou20bIu0H5hQX22qJr7M+AkfYaeI8hhsO/aTFpCLu+zE3+jk1LddYHMConTVVw6
	bFkJk/0zrkTvuLtu3YoBalatOkN/tnMG8cTj9VJ30EFC1r7w1TeM9pNic2HXrlh+qLuOw3Y/EC2
	yE0Wt4sWMO/18nj7QAhSi8YL4eXaWP5Or6rM4wmzkdMuf5lcLgvSOYl1mNfh+KXzNNqdn68YOW4
	Z0IfD1WcI5CyN0t3GDEF5oWMsaYvFmmszChoPM4Y6CnhbdD0Igx8tRLH5xbn5RE4QdFdjKMHDZp
	ehlG78xiTtR+zAF59SI50ThEzwIFDlErIWHrkmvW8+ldla+AUkQw5s6ASw+maaBdLMS0S+CGXYb
	YAZyd5dakXvlfAJgqInkJyVhxOlYgOXacaEy93w==
X-Received: by 2002:a05:6a20:6f03:b0:3cd:3e77:1dcd with SMTP id adf61e73a8af0-3de0e6f42a6mr14232358637.1.1790606389287;
        Mon, 28 Sep 2026 07:39:49 -0700 (PDT)
X-Received: by 2002:a05:6102:3306:b0:79f:5d5e:11cf with SMTP id ada2fe7eead31-7af1d09c695mr3831186137.11.1790605933082;
        Mon, 28 Sep 2026 07:32:13 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5cba0ffsm4345440a12.5.2026.09.28.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:12 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [RFC PATCH v3 09/14] genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
Date: Mon, 28 Sep 2026 16:31:08 +0200
Message-ID: <20260928143113.49838-10-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba7c36 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=69EAbJreAAAA:8 a=cHhBG6FuOey2j-0mYlgA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: isgiuARcNKyl9p84VDMqkdX5fzkD_0BB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX0UQISYNIhlP8
 wy9/5d1C+1oJrYc3Zadp2CPP/j7CCcWBq1tlWn8A74KrMJlYk3p4l0jNJrjHcKkqMONJMVe9vtj
 ogbznSA8T9p4Epcijv04lSiAn1C9wHTbViX+JQ92X6kkG0Yt+cNJ41ytJd0U2RfNLVsZuBtNGss
 2Ts9ZAlA/saWt+BI1mRLPli9wdm968whTnY0qygZBbLkkY77Hzh8+cDFCblDe6ZDCaF7VxTgR22
 jLzFH4EKgSHvChYmJQhpxu0V8mtLxkDNXoe6BAEx1yFXFcO+cIcRAUgZhYjn2cAkF2z1HKbyHbw
 EKDNcbQpGRfX1HYS2rSHm4PJ3YqF3U0yy4Q88NbsR7h7wJtvV/cFVmW0SZx0IeP8x7mjy9b1xn7
 LRUDOcxoRS6LXB/JDCrfSZT3vkf1JkOxWSxq3djalm2igV9b6y7fZ+3BxZBLPWElsno/N7u+Hes
 7xHkja9r1drbmMgfsjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXx0KgbS5BC2z5
 m41BgournCJK/ZLy7hacCJHTVMd/TU5A0trHrr7Pzd6ceVA61Ss0Rqr9dJUcm19jvgyCX8oZk9b
 bWO6jRjiEUj3pPiwF5p0NQ3JaUtikBM=
X-Proofpoint-ORIG-GUID: isgiuARcNKyl9p84VDMqkdX5fzkD_0BB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280058

Add a bus token for MSI domains that remap interrupts, needed by the
upcoming RISC-V IOMMU interrupt-remapping domain to distinguish itself
from NEXUS domains. The token is generic because remapping itself is
the only property that needs to be conveyed -- there is nothing
RISC-V-specific about it.

Such a domain implements init_dev_msi_info() via
msi_parent_init_dev_msi_info(), which leaves 'domain' pointing at the
NEXUS domain while 'real_parent' points at the remap domain itself.
Accept that combination in msi_lib_init_dev_msi_info(); no other
msi-lib changes are needed.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/irqchip/irq-msi-lib.c  | 8 ++++----
 include/linux/irqdomain_defs.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 45e0ed3134ce..9027dfbab15e 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -36,14 +36,14 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		return false;
 
 	/*
-	 * MSI parent domain specific settings. For now there is only the
-	 * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
-	 * possible to stack MSI parents. See x86 vector -> irq remapping
+	 * MSI parent domain specific settings. There may be only the root
+	 * parent domain, e.g. NEXUS, acting as a MSI parent, or there may
+	 * be stacked MSI parents, typically used for remapping.
 	 */
 	if (domain->bus_token == pops->bus_select_token) {
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
-	} else {
+	} else if (real_parent->bus_token != DOMAIN_BUS_MSI_REMAP) {
 		WARN_ON_ONCE(1);
 		return false;
 	}
diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index 3a03bdfeeee9..954cf585b3c4 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -26,6 +26,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_AMDVI,
 	DOMAIN_BUS_DEVICE_MSI,
 	DOMAIN_BUS_WIRED_TO_MSI,
+	DOMAIN_BUS_MSI_REMAP,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
-- 
2.43.0

