Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD987377EA2
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126660; cv=none; b=Xck9yo2kMGkm89hBxCLqpw2zrpaGOCOT16WhQEPYO95KAP6w0qHiL4ZC7LK7jlCbaFbMntX2sDNoH+REVoF1KFRTn1eeg9TJksR3zynTf43wQs3fUVLUKMQrcYreF9CSs8yazAqzz3EyDAkD3L71+EXHyadPxMThvktKpUqOf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126660; c=relaxed/simple;
	bh=yRSrMfOIOY8yc+H0kITYB7yCLVZjoqzSM1JBHxbzG64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpnGVTDfpGRvIiAiZ0fzs3wY36DWMLF9npy33wfiqxe96295d6ga9rnBE9XiQ4IrtuxBXEVV7b2+hiv0IOCouYtG1TV4l9GM1tKdRPnusnTQWoxdRFzms5rV5yjY9eftXXzNZfJIWfvY1GnnlyzpfPJmfnhoaUpeF/YfwynYD58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EWbGobTa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CSt3ykmY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EWbGobTa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CSt3ykmY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GONHm1807638
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=95f+Fzhwpw4
	3Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=; b=EWbGobTaVHSvMe+UdI9MKJm5XKr
	Qv9IVzn11B1p+bYyThSwwHPjh54LB3Q4uben3cDYBZKh9s4kaTpms/ZMKKFGwW0D
	m7cdgfhos4qm6iBapSZkRFqOz3dzgeX2hdudydXFujQtEuL6WrbjZbAmLx8qmONI
	0wCcNNoZ/k50YHfTgfyjrnM2WRX2uqlnmVFSCIsa8ZbrWTgAPGvha3JErlVQKfBC
	dQnpRsTVfs9q0eraIgfGKNypp5e+OxnURBEtPdwfuSxONi8Z3rMK0j+k+Xtwo3kJ
	U7Gc/4NB9ywuRYwNuxkukIVgSqgYXgMTaH5UOg81wRN+hQ2VPbt567Duoiw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgewh72m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c083f1818so39350371cf.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126653; x=1786731453; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=95f+Fzhwpw43Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=;
        b=CSt3ykmYIIpih+r8cDE4Htg9x7TD+288u7l9yvvrnEw0ngqv2xL+U2zQ4UHhdAGCB/
         g50E25uCdgR70cc0KHctAezcVcmK6ZzaEqo8dGzhwpmC3tZVFgkhDmCVM0YehLgdYY3p
         kWHos4CLgNXgKrdrOeVgBtSmok4RIvNZ+iv47IH3kAtNdhRe0BXK2eCm21qGK3DeEKWU
         +dNrWekOJB8sYoIUiOgT3/2/h2X6coyQyuI0R2tr78D8GtOGm/4RkG7dqy5ezMbWSvpP
         X88jayFfXNEZn8YAmtxtBQNbSTX4t/jUJpXIcdoW05fN3MxxrsP7RR5/AjaXdRqnaC/E
         /K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126653; x=1786731453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=95f+Fzhwpw43Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=;
        b=HJujXjEI85F1T2efD9uaKchkl21jcWaicE9kAhm0IAf8ciV+c19v2SMBs2wS/mJY/9
         r0noIY2xUv2Zl3Xhfjl8cfIX+VU5o55yRgviUm7RtX4EzgqsP6EnA5x1lYqzcrxgv+8O
         d7RYWXHq3Pz54U9tpJFGPw8SYCFXgtXmhNLcg9BzOw6i/JEIY5wGYXNJAMkiAtkCeVa/
         fpjeCnFDpLFWoBkrUTWhRbQoysBXMJZg4iNnIHZ5Q1n6jx2uTRcY1Cn3QWHRereAUjCl
         lKXwrXgnLUzq3D54VfGZAfDfo7WM7s7Jb4Cc8gQd0m0kaTSBhnGdXA3AKwqpqSFwG2AS
         xYgg==
X-Forwarded-Encrypted: i=1; AHgh+RqBAw8e3JhpGBycGiFdYbUmA2Xm9OzfpJNoH9akigsbywfIT7nE6ZUKs8h60MKeK7GHmx5GQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOq788EbRuZ98HtS8HIm1vf/3Fo1WK/XpZHN44ppHJJnVH6sb+
	Dl5kpremsgHfcLmSaZz/fDFhSvMiq+ICIeNrwVnapSN0q2qRbAA3AbvJRzqWJlrFjnz+F3fKgHi
	GB0Enudaqhl6Ha/jiIPX7ny9c56o1gjrVkqwyfBs5527zEeGrUW/L7F5nyA==
X-Gm-Gg: AR+sD12hnlZzg7CcS8ab+Jwlgh2Fr1JUhhCNTrCWJhycU5h2AoZ83ZywtgiR4e30+ik
	si5wu/YyeWkfD2cnmDbkI/CPK7uURt14vRPrvE2vK45Z0JysTxAGkJPLgS8yZSzT9Pajq+llFMN
	VtZWtGtuGYVXa6C4bWbNMpRtt8DmtEYcT3Rn/JV+LjvwcQynr8Lc3WPF12rNL+fvaA3UldCwyEI
	4TPSv+gypMqCdCWQ/5hJzk6Q0P1bek5Ju0I40M9EfiGCkcD7+smBuqLU/vs2pGJmf995fEW1W4W
	tRN6bYRQDdebjI8PV0A2HZNzBAM6BDI8G6HMoJrqo77Cl39NkCSCxgoy5ZpkHR0HWy3L1gWfEeJ
	VZylQFlDGYCgB1buxkIRRXa2Y63g3moXBvhKHb+4=
X-Received: by 2002:a05:622a:58c4:b0:51c:963:cafc with SMTP id d75a77b69052e-52d20a814eemr36934231cf.41.1786126648159;
        Fri, 07 Aug 2026 11:17:28 -0700 (PDT)
X-Received: by 2002:a05:622a:58c4:b0:51c:963:cafc with SMTP id d75a77b69052e-52d20a814eemr36933301cf.41.1786126647693;
        Fri, 07 Aug 2026 11:17:27 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7cab285sm938856a12.9.2026.08.07.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:26 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v3 05/19] genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
Date: Fri,  7 Aug 2026 20:16:59 +0200
Message-ID: <20260807181713.228535-6-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX7Lvy3Um4q6ro
 tf2sXPThxlHoY94Ayz8z45oHMkvdTeLHL3KcpPKH8w42o0DELjUHw/Cy579oefwd3LXT36Swj9K
 y+n2yWQ9jc7N+1oaSnvIQWwgW3kaF70=
X-Authority-Analysis: v=2.4 cv=N5cZ0W9B c=1 sm=1 tr=0 ts=6a76213d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=69EAbJreAAAA:8 a=cHhBG6FuOey2j-0mYlgA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 0uBXO4dMifrkb4vFahCBlyjFhBoYstRO
X-Proofpoint-ORIG-GUID: 0uBXO4dMifrkb4vFahCBlyjFhBoYstRO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX2S2NluJUh56T
 zDr1cZ3K+fOt5WkRdxkTh2q41kwMHRhcXPNjHtesgXFQPKEvnuHz27Bk1dWDy0wWvKs8CvgYirC
 5BpYDXA6YS5FuLcnQQXudzrhTtg0sewoDwV1usS1R+21cHE0NJT+B29R/WeC5y8mIUR2QwMQvt1
 FUpEKtZ1N8nnrFGK+NQCaBwq5Mdqa/RyAUepvnkoY0drbHoGMQ0FanGphm7V0v/CXfaOTJjY3ko
 2Dkfp9K8VqgH0JR8enIlHe3LXVdQFKW2OlmGd56Oa6GkEDWFqG5suRCY5NqqqJBkonzyuXECQza
 D0e0loD5MbzsxU5BAWK0J06S4700VBaR3mvDjU56VHdOHRODch/2TLGvsgMqTCRBHlcY7t/38eA
 ODh27yhXfVsZC7E2chHpsakxHKV4TNujLV/rEABXVyYenufzKTDBz/htnAeqps2gHL3YXvRCTLu
 9rtyRKQL6ggNMVrs7gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070143

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

