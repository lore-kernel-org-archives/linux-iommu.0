Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9125F988
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262128; cv=none; b=DoIbSCiNNKRfuqGt0A4DRzNz85oll0fDL7GGLL/meBNAOyJ9EsOe56ox4ofL0vXVOnLYjWsSAZpDaTlAeaDgYCPdG1qTjkY77XICbCBrKiP1RgcZ8xVgPeXqaKzUTiWunsS6qa8VUAJW7jM33ps6RdgtSWjNg5QnsC7TBtOnqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262128; c=relaxed/simple;
	bh=yRSrMfOIOY8yc+H0kITYB7yCLVZjoqzSM1JBHxbzG64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cejVDDErmy0SwIz/zEfN+39b1qhHcx9odyzEcw5HRxu1hWvDdtI3GbOUoUWt9Czqs0Rr2wy9FBazLF4mSyDfhSY8FO8dfviPId7Zd5SF2plAEx/Cf7+CReQl0xxYh9fvyMua042y1ePZhwnVvgmvP2JRm4mO0fWIyQ3xVhboS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FLf9ktyS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJOj66h/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FLf9ktyS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJOj66h/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7b9I267933
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=95f+Fzhwpw4
	3Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=; b=FLf9ktySq3FvX1wSCCh3uhuAKql
	wHiTd35nqMOeX85pmsSALXS+CfoOZnXf1kSmRzqcX51c5J1ErUQlaNIg1BJySSfI
	VIKPpmvdmXBeiyq9vFqGBbGFMFMOFTytf6z5KATw3r4OGtyAI1vAXfxszG71YNma
	QcgRy2n874KHdFRn7LY91vQ/+gF0PwgL4qI+XF8EBMB11TFn9ubWWGLPXJkYcQFZ
	z1omRYU1etmBXidPfWairMSJhXdyiKIEDsKjRMam/b285IvIZDQyfk3wFUyXjzwg
	d4vgr51pecxSMFJDI2OWcuYHslujsZQBHVBdTQBWl9cMnL0JL+EXM2G9odw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg1b3ee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e695a3b28so164450985a.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262125; x=1787866925; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=95f+Fzhwpw43Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=;
        b=RJOj66h/WxUfHjJa7KZos3lip16o2re8vDbmfZgtrRbABK16Gko+1pauuHHnPu3x1y
         3uEgaQhrnAOJCEL2K8lwiFtlJnR1pvmcE2HasMqDxyuCOQ0LgpPXaWjherXRjUKMVIEF
         8PCyiO6Adh+bCb70MMI1ec+Rz0x2QG7r6Z7aH8L+lyDgu8zAGYwRb+w6tVlcYqMVX4Gw
         DhhTqAKyIOiqJYQu/pNsZuBCrtGjbWES2h9+P/AyGNdv4U/DxDqIl9bhV9CDMidM5uub
         4QkdO7rjscdCiyxRzRo67O/a5VuUyGLOUHIwlyMx+uszOZ1/SkMBYEwUYSmENGp92MA+
         LfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262125; x=1787866925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=95f+Fzhwpw43Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=;
        b=Ex2KvVEWIvgrev7j4pPhWYRWhAHwKsIqg2GX3hV3yk88SqeOijZuWDnOjCosw/BsKw
         A8LEJmO4qKO36JG1TX4sBxojFtZIrc0c9zGzVpqaETB+Z1BexIzboiFK90G8OaOOo6uW
         f33CtFxJHbe52x+TVpzQy3JsDPm8s1i8l0NoPzdb8KeFruXM7pJVlKVfzuqK0W0hjksF
         Ft/sECOjGhd7n29KKG92iE4pJJYdOjhoCiCQBg7Zrt/99y/C26yd9XgBdMYFWL1gCNTw
         xd5Aeh4gVTSUhlz7R2ZBxaUseQ3cZ8+FWd7QESZ+jZmi52y3YtjZ8gJJRMhYmQBLrQa0
         OMyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+J96yx8jhxjZq0/nCiZA+SFPC+EZQanvMiGpO0lv47dRe4T6oV5HDciGBrjTLY37+9pKrow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQ5g7ZIMmzLwvMn+13rwJYmg8JSKcAunVqNhUw2+ma4JB5LW4Z
	CzS0GWg70n6aPyM+aiTS3jnvJdolbbIr28wR9dSMH2hBQ9lFilPoJ6w0oFbnNZAiqb/G8H+DUwp
	FY2EFjAsae8di0QKnYGVF5DXsR5qQT3t1uk3/VjbuzALs/ltH7fu77In8rg==
X-Gm-Gg: AR+sD11FRMXn/2jy6iic+1oW2btg+fX/8BNzYywWKDnNFzOv5yZe4GuLcA0LbUdiejK
	kZdS/QFagSvU0fxXkkcqc/rLpqOLBe1GsEPkegRJlyz9FQoWpSNW4RdY2BmtwRqhbHHX2lrS+hA
	T41vFcE+jbx+yO5LW1Mzv4Fz8FqJVORWuUqdubBBoJ6OMmSE7vB681Mfo459llrTxAYrqxrF3MF
	+dLhOdNnOMmM2ruFMyQod3E9qyxu0oDQeJCanTHSbzPMaawLeIXSIN71WxZXGWBwj3O/YveHln2
	20mjR//MyNbUUw02Kw/9xoiEa1DhBHY+snAuwpbCLRuitmCWwpLmLGzLeOFJxBi/WVBsBMNqthA
	BDWcRktR2
X-Received: by 2002:a05:620a:a19a:20b0:936:af34:468e with SMTP id af79cd13be357-9372835a96bmr757319285a.4.1787262125155;
        Thu, 20 Aug 2026 14:42:05 -0700 (PDT)
X-Received: by 2002:a05:620a:a19a:20b0:936:af34:468e with SMTP id af79cd13be357-9372835a96bmr757314485a.4.1787262124719;
        Thu, 20 Aug 2026 14:42:04 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441b0fsm14831889f8f.4.2026.08.20.14.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:04 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v4 06/21] genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
Date: Thu, 20 Aug 2026 23:41:35 +0200
Message-ID: <20260820214150.545737-7-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: XTfTLS7OH3JT9enscPOnuaWGXwvb4KNU
X-Authority-Analysis: v=2.4 cv=G7Is1dk5 c=1 sm=1 tr=0 ts=6a8774ad cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=69EAbJreAAAA:8 a=cHhBG6FuOey2j-0mYlgA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: XTfTLS7OH3JT9enscPOnuaWGXwvb4KNU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX9eKYfCFJbCcW
 oUtwSH0hyXUIti2DfoDHIUsg6S41t+pYJnrHp0exzuJnLbf+4/wH28MEww/w2hqIk70Z1KbxPp5
 AEhx7QPhNHMnMaJcd2zDwQ6/5I7a24U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfXyQ0mD5B4GdBA
 n6K37xJjOjfwhnKh012DPkfJdF2WzDHnPuALlvLa8P6zFNpvrS6rwrx9AqTpg3BsTlVH7hBki+M
 fXBKQNrqGoLmpM/EARJxum5qysO8+PDmkctV7oQLytFKKaZPbiNOwW+TksiNgVCdLIKAqToxPIt
 Hq+CqZ84vmuRE2QkqVUjlsxubxf04pYULJbUbcuxOepXzy28yro4BKkH7ebLnVZviGy33WiqX5F
 0zEJutfOZ8ciJMXGfHSRUK9m30EXlEpeVmAjGmsmmH0I+ebXT/l5VtBiet33uIk1KzsRZh+lQF7
 pvB3p2moD7bwLBfNSXJH4KSFVd4wkLNrjdADuX26CjNg0pAHDq0uKKhjviNPJMF8ofgp9hrNs/o
 RQShVlO6Tv7nIVze5IfoumXwD02EaxDduWCw9tDPlqorHHmjGeGyBlkl6o7t/SDAX9w3WoHB1wr
 gZD4OduNcp21Z3PPeaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

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

