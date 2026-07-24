Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D297443ABA
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905958; cv=none; b=ANBJp25oL2FIym+8BlavXvmY0XYaT7oNwouXeSkNuDfCjxBBTIquFZ1qfbJPSeMv87XpEAvzufHeW8EvJyrAzkM7zE2NOREvMstbdfePxFQSZ+4bkHIQYu2+bScwew+e5o/V+17lPhK3cJOp9MH3FmWdzvnaUyOgMVQsGWQ35qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905958; c=relaxed/simple;
	bh=yRSrMfOIOY8yc+H0kITYB7yCLVZjoqzSM1JBHxbzG64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/Re7Ie0NcvZWSV2O/bjS3wyJ/zFIbU1Z8GJi7H1IYX8kMe6St8OzEWHk09WCb6oGMZ1CzRG7cZsvh56KxB1dv+HzVNI5Qtb4afta1Q5Bb8BHpeXwsD5da7XgDajo3lMoU6Nx+9t+9HEtdJD235DX37wqVE69whLyXuF0zhThVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GFs837wB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LR8d5JRU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GFs837wB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LR8d5JRU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbH8J151640
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=95f+Fzhwpw4
	3Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=; b=GFs837wB4Y/KCyE6CmXhfOmtUwn
	EKo7EGn5liumh3BbAb06RTFqUsZhfBtrRmigfkaGqHaIS4SKxMIY873CLiS4jsV+
	VoCjzJnWuUS/acFswdwC3dh16Xf1zHWbjVcwydzc9sfXiV1gOsOsjRJAeyIkcpUa
	TzIVuDzdKfha1g+myFY/PP21hYyUjFD62g0GPMDhZhVp3f/PYtcEerwwxSIarxoZ
	o4ZYCd3cwbTWbgziCbLIb4Q3uEQ2Yj7VVz9iaao0ULQjKDW7jVsalNE7WcYs2Ycw
	edPQRySdTrYCg0KLHe8cqjPDrOz6qOLgxR0latKxi0Sn5yeZ4JtRe84ukOg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8ck8h6y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-526da7e3c9dso8479821cf.1
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905952; x=1785510752; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=95f+Fzhwpw43Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=;
        b=LR8d5JRU2ihfhkK8AvzB0QhD1M72ryFDl2HCF0m0KmTxJH/QAv6PEgUaGDkoLa0WO+
         kMX7eZTBryZbUBwUrL7rLT/BdbeOY0LOVMUDWJZkIPIQDb+Fa8/zCYhgSaoSVt80379x
         8op6kNxlSdN58QqzDSoA9vVwvOwuIGDHF6xWlicAYzRGossYlxiA/TzmPVkX8SWamDde
         tjeAu4XlVd/QZgewluFKm6PN6ayKuoRURCMQVERYN2NdjApwy3tDITbH1C5ou/iNmvoL
         l5bBINp8IhvjiwEsxnfBsJEk8E69iib8Uo2V9v3E2FhDF3H3pxThwETwwtfcmC1nQ6Z3
         v49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905952; x=1785510752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=95f+Fzhwpw43Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=;
        b=LZeKETiAasvEeym5k9UiqGr2ZMzjS63yXMJhJBAclDmof6/9vmZcanjJxPqquck4w5
         h1xfVGG0pPzfXH/dpMXVMdOVSTbft8c60Dh9R3RENxE063SUqYiwMStkudYWyZgUmrlc
         IYBgeeCJAdAVcIW9aZ6vMnau5iPBTAn5DB/sylBdJtd6fggn6zjvAoDrq/Gj4BKwZRop
         13+AateXwGaINzfP+6H+kD4Y6PUhU9ffHxQ0x9d/Ak6uPoQq8G165BNzc62AEZHHujGv
         W9t/ABHfogyRbUHjDGy4e4PkjElItFu+ntOiTkmt3BRTrHklJWUCgALV6B/IqvYENxbp
         /94g==
X-Forwarded-Encrypted: i=1; AHgh+RrQvm7ruIZBc68lRvPoqIKb9SJDFI81PYylnt6Sfqe0EabvrMTLalHED3m0NC8D3vyln56SdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpypDn5O9HLDXdHnm8Ter5lxGAnpTrvsXVzATHGNYmGvr4rAlu
	pF5uKhE/vtQQ4qiT/otMnmh6pHoWiv24B/rfIOuFsqd3Jm3X8fAdbn7YZUiMtGoc+vtaOvssAo5
	46dZrMp/JS14VAfxXSRdr55E0aTZ5ApWt7Q4QCKBj8wLwQ7t9q7cyNFsOEw==
X-Gm-Gg: AR+sD11kxb15lSVgJGdJF0MyfyYHGXH9G5lqpTngHydoXpGLexUXDL+0LUwNWaUlKeT
	15YwI7RUKWHKhWvI03IWgWnwcK8tfSAU3xpYxYc8VIfxxfjMsvqCmpg7fSqOivFfHdeo1fGYPgz
	xyTPmYdcDRNoEwDcrdryP8DSb3Qf+kZB2J9wHVbWycbqiK97QLsy6PjHM7pBDNaNlc6DH0zp5gN
	Jz1zafoSw6N6bpo8U5VQ2Y48YWaPFKox23OFsSaUAXLDXN1MePAjqab++iDCXyYIu3N63X1jJ1c
	v9b4nMOz6UpT8smimfSQIHrY4bz+IRId8u36Opo0dLJykNiQ0A3ZMw85xTFCCSg/mypoJYXGcD2
	UrZgs1ylxUq4ZmyxSPTdoWvYlGhmB3WGOjNEZ
X-Received: by 2002:a05:622a:164e:b0:51f:798:cf23 with SMTP id d75a77b69052e-5283df62e39mr72262841cf.62.1784905952001;
        Fri, 24 Jul 2026 08:12:32 -0700 (PDT)
X-Received: by 2002:a05:622a:164e:b0:51f:798:cf23 with SMTP id d75a77b69052e-5283df62e39mr72262181cf.62.1784905951407;
        Fri, 24 Jul 2026 08:12:31 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32f151fbsm365176566b.56.2026.07.24.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:30 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v2 05/14] genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
Date: Fri, 24 Jul 2026 17:12:09 +0200
Message-ID: <20260724151218.965929-6-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
References: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX7wuVA9XOY8Cw
 HkcuYLXGlD47J8BER9LkB0wUIccTXmAslIrHlywPuuog/RWpqcBPSs7+kxB6c08KQaL0s1ikIel
 c/hizsyBO3Di+I671aXrBfo5b3xDWAAR2jAAQdCLD8fRwnwsJl3auVIvLMRFj36BymFqtlBq/NE
 51D/nNO5eTN6EtDQOtP4ukyv8Iw3mbmQnVul7hueUlURlYzBb3gL/kVOyWTyq1cu2OWEYM634YN
 P4b/E9P9510R6NBLWs3yZTl+e12ZOHGMydzFXNT4ZkzNOhbJd0QJx7AedC/Cm+EKTXoy1mcc4WO
 zF4dFmW60OpZJANop10YbEb3hcezZd9bybf1+modGrba9qRx90y8ikMA1hdUG2wXQnpZJh4x2Wz
 nyc5DOBecp4CSw+gCePNSJNUCc+GqFxMV9jHOT+JNWkLpT/1GcFv2TVD2TtiW7Vhn0PY/5RA5/K
 Ny6e1LEK7rl7aPDJX4A==
X-Proofpoint-GUID: uvgjPR2eLPKuLEvdP6K09DVcwM75o3wH
X-Proofpoint-ORIG-GUID: uvgjPR2eLPKuLEvdP6K09DVcwM75o3wH
X-Authority-Analysis: v=2.4 cv=F79nsKhN c=1 sm=1 tr=0 ts=6a6380e1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=69EAbJreAAAA:8 a=cHhBG6FuOey2j-0mYlgA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX4Jk5eNoSj6hf
 LJkuFMG5PluVWu2Ambjk6OKRT61L7Q+aQVv6VGNRZhJOpOPZcWbNXEJTDDLxXUyI+fpip8JjKun
 b/Nj2Ha/0O7+vDuO2P2I/JOw1oRUuAc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

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

