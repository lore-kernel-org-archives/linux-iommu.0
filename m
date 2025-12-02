Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CF8321F54
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685392; cv=none; b=QSaAYOgCXXIKIywIu6luX9ogFGKZ9xEcprejUZ8JpqjTJ5QAEZoqEBonCG38mIzYhANHQx/PlBMa80XngwIkLElOU5b8Cc8jjbMphInBx8MLI56etnvx/EGOT3SFHHDbL9Zu5wcw1zHksvhwhW4DKkUi9v0Nsi2vBkuYk08vgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685392; c=relaxed/simple;
	bh=DhqZPv/0aWBnunXhwhTfHEiUQFo6lSXbuazcurYzQjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAGs7JX+h/EGj2OX3dTJLFnjRXP/wUF6RJw19mR0rkHUsetouWKhjl7EuwMQf75A7ugRSEV71laKxsoA5zzzuCsGWikhgADF4eDBR34R1+VPPlqy9u/CHIIMFYK55H++VEgjP3z3y3Ty/MUjOxEWB1Z05oqZJTqGaoR0MtT6iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B/uLkYr3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mr7Cgp6K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B/uLkYr3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mr7Cgp6K"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B29TWfA1359232
	for <iommu@lists.linux.dev>; Tue, 2 Dec 2025 14:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/DcZ/qO2H5yuWrIIc81AedSaXbGKplExVCuz7hlc7lQ=; b=B/uLkYr32qvdAtOj
	cLnamVoRFfgpYSSOZQLfeqE7fGNRhJKIbr0Jm28gEGmOblFtJNN3Kfe4dhpi0PJ/
	c3fmYiz/NSDj+eyBMnWF/AS5irTXPoYslnTLE5yGZb9Fan8qkEZXkdhQD0Ljlaiq
	8+SN3be3kjRgUU66cY+Mk41xbXAv/c5B24tw/xyZVIu0RNEmxsflGiuNXvuKAJdT
	uLErWHPXm7QrZWiFQMRR/6zmb4WZ7Iwuyt5o4wRSgLhntAXdWQmfgtyJ3+qAus/t
	qi6oLan9JAtVJJpj0ewjXCSbxUvgeS1+jgDbq9x4NiIFU9mBmnA4p5eiiieufBIO
	2dv1NA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asp63j7b3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 14:23:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3437863d0easo8213918a91.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 06:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764685389; x=1765290189; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DcZ/qO2H5yuWrIIc81AedSaXbGKplExVCuz7hlc7lQ=;
        b=Mr7Cgp6KWTXK/MI6SAKqQkn5g7+KpSNeQrJG8aDSsuM6kgWmMOO4vqjlmiqAfPyJ6v
         wjUn+6necyLD7Y5I05m9gdHn/cTKE3vVKUY8LobrlI1DgYbIehuxW17BQid/mk7dqC78
         V6tpZeOR00qIxsLcHujnSVV0zXLOZZW3boOqn3Z8X8KMhwpTK5U6PHWdP1MRxirjew5V
         zTBzOGvghBImNAsCGTBXb+fel42wSZZOTuTg3teedaEEU5CUGOBKWppYA6aWNIbnaETH
         rhjrJ5DTffpLOlIxb+FoxWpopdb7SGQEjm5MKY9ViA1oQE9nEEiy+OAcUb/3Bta9Aeth
         bJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685389; x=1765290189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/DcZ/qO2H5yuWrIIc81AedSaXbGKplExVCuz7hlc7lQ=;
        b=ox7dqtqlwZoiwVZJKKDMaKZxYUy+x95Lm8dEmUeorAZmV2IEK6L4Mdo4vRKTJM2KxF
         lpM+xipTf25044LfkEYmP12WuIabFJeIOb44g0D/uZcbxr44xYwKIy6iM8FqFh4U6l+L
         lxlqyhmk5BRILJTGpcRdsaUG41wNe+7+FFKJTzKd1jVeIuAdVs0UxIlsIlCFV7g4GagQ
         4PkSp0dpOYteWXsWA4jdynKv2ImEZUjHWwxLj6Or94y8LRqMqIg34z5+K4Vq+LZXvGiG
         Ab8wiGIUz+elily3t7e78nwH+MyFc5FL1EyBnhUEuWoBLlU8QuM6yl13Xb0cLbEHNGrk
         ijkA==
X-Forwarded-Encrypted: i=1; AJvYcCXz9UwcwrweR0KGzRNurhDeIo9x4WEU2tz2UxmucMbwz7fcWevHoAp6r7kvze9ErvxExNo9QA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBHdMsC4FnV0g9RVz6XRR/eu+86cz8f/3oPWVhmt1JswjNVBqz
	A0BywySQW0uEnyU1BztvEUXTB6ALhkyS7K0dlCdiZYf/JgZg39PitxDn7JVHa2H/Al/JFmtX1N0
	aYeJQ0urW+ykCZhEq6sgEbqrARn1nxDtmRp3hkh8+I+NgxXXZbRQBC3eWiA==
X-Gm-Gg: ASbGncsk3w4YrwVpVQV0vwpodIgvWPDBk+RalUzH83WnQQGh4mg+e3A+wMr5GFQl98G
	KifP2X/Tm+bXkmzcQ6mCV9qFTByeXiyiMgzUBVhcPltXjLeRjEPD4syg3HOEL7XiVgt0MOtm91D
	tBixtVqOONvuwUe7s0RCNtyh388PdDsrC2qC1XEo95N999HxDxvD1qoKtt7jH/7OLFfOrRhzlRx
	KhRTi6pTBnLVmbny34tLaxax/M74s333DAwUWhpFd1aCUfZ/lq5xZ+kgi80mt1/cZuZVQSssD7Y
	VOM3DGtX8mgxPg22YGfpXHSaioB3AOutlbLbaQOuN2FRfXsh0VmXzYoIumFu4aQdtgpsJGhHtLU
	4AntDccB3cXqr6oibt+JXGizsQ6W9T8TTpt0Jyuo=
X-Received: by 2002:a17:90b:3502:b0:341:8bdd:5cf3 with SMTP id 98e67ed59e1d1-34733e55015mr47143839a91.7.1764685388500;
        Tue, 02 Dec 2025 06:23:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmJreXIxtC7QqwcAohA6pn3gbslnhbRvbp4ehG7lAwm1lgqaC+sUN5cC5F2+qBMdTsdTSDcA==
X-Received: by 2002:a17:90b:3502:b0:341:8bdd:5cf3 with SMTP id 98e67ed59e1d1-34733e55015mr47143796a91.7.1764685388019;
        Tue, 02 Dec 2025 06:23:08 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a4821sm15659084a12.29.2025.12.02.06.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 06:23:07 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 02 Dec 2025 19:52:49 +0530
Subject: [PATCH v2 2/4] PCI: Cache ACS capabilities
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-pci_acs-v2-2-5d2759a71489@oss.qualcomm.com>
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
In-Reply-To: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Xingang Wang <wangxingang5@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3778;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=DhqZPv/0aWBnunXhwhTfHEiUQFo6lSXbuazcurYzQjA=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsjU++bwaMOrxteL72S1ui6vDb/luSzu78qTHxz2GSUFF
 jelSR9/0MlozMLAyMUgK6bIkr7UWavR4/SNJRHq02EGsTKBTGHg4hSAiVR/Zv8fzv9IKenA0QAG
 JuHc585XHRbxvQq00wkWc2e7mjmBqWd7qFCF/WHtgsTvvxkiNLaY5noqqjW0XReduIjJ9eK3q2/
 XaPVbJKufUy0su+sTKMb871Z1yplNu0zMwwMC7jIdWakq31zwpuD0Ou+zMdUvpjMrsXT3P+i509
 vmrLlQz+fT7uvuq64vl3nemn+heFJ2UnO4q4ahyJK6vqls2uuu7hMSnJfJ1q3jyRxifqH77vT7Q
 imhpjIPf5WnJGdIL7z6QVIw5Tuj5Oa3+wJncG6926mr9PB3otW7rMwPrJFythkK1lWfOe7sYuiM
 kBRp+mO/OEJtV7zFrO91tU8brrwruFDGb7ddPHHTjZgOAA==
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: MFzA_DmTK-LBxWtpyqXxQ2-HX-zXZiEG
X-Proofpoint-ORIG-GUID: MFzA_DmTK-LBxWtpyqXxQ2-HX-zXZiEG
X-Authority-Analysis: v=2.4 cv=XM49iAhE c=1 sm=1 tr=0 ts=692ef64d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=8ziBJk15IZ5r+wOU3RLduA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=4sYZdrzHdZFwjucz0qEA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDExNSBTYWx0ZWRfX3hRcIV1xyttp
 hiAl0pfbQPw1MG/6ARyYZ1fbiXA6yVcaIWRiEtaEnvX5bRyiLwQQNQAxIdBEZ54OxPCxspFlbuI
 ngp/vqOd1QSQBAO63rty8U0wohHaCtIqeweWJcASs7cugvOwMnb8Pk3DE1ObXFY5QWy9+UJI5I6
 DzX+aP/Xnf8OPPciz0ztgyGWt2iQsIRyx+ggSwriUMTKuPQyZdiPvYjX7fsRByIfRS9SBKNhBNc
 68gUQc0LmMD+c1m132vWU83HQQ0CCqdIMRNwK5CgAIe9mDNM0yEjWhW+EFhcjEIAHUW7c6AiwHU
 cBWguRkThBGb04V86QBmZ46fyisASev4Vtl/CRTYIAS5H5VPWbKhzTHnuIbAN5dlvUu7Ri5pqpw
 bvbRWIep3muA8ZtzWJr+19YOGcnRaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020115

ACS capabilities are the RO values set by the hardware. Cache them to avoid
reading it all the time when required and also to override any capability
in quirks.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci.c   | 26 +++++++++++++++-----------
 include/linux/pci.h |  1 +
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9f594fc6dade..4eb5b487c982 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -892,7 +892,6 @@ static const char *disable_acs_redir_param;
 static const char *config_acs_param;
 
 struct pci_acs {
-	u16 cap;
 	u16 ctrl;
 	u16 fw_ctrl;
 };
@@ -995,27 +994,27 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 {
 	/* Source Validation */
-	caps->ctrl |= (caps->cap & PCI_ACS_SV);
+	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_SV);
 
 	/* P2P Request Redirect */
-	caps->ctrl |= (caps->cap & PCI_ACS_RR);
+	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_RR);
 
 	/* P2P Completion Redirect */
-	caps->ctrl |= (caps->cap & PCI_ACS_CR);
+	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_CR);
 
 	/* Upstream Forwarding */
-	caps->ctrl |= (caps->cap & PCI_ACS_UF);
+	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
-		caps->ctrl |= (caps->cap & PCI_ACS_TB);
+		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
 /**
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-static void pci_enable_acs(struct pci_dev *dev)
+void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
 	bool enable_acs = false;
@@ -1031,7 +1030,6 @@ static void pci_enable_acs(struct pci_dev *dev)
 	if (!pos)
 		return;
 
-	pci_read_config_word(dev, pos + PCI_ACS_CAP, &caps.cap);
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
 	caps.fw_ctrl = caps.ctrl;
 
@@ -3543,7 +3541,7 @@ void pci_configure_ari(struct pci_dev *dev)
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	int pos;
-	u16 cap, ctrl;
+	u16 ctrl;
 
 	pos = pdev->acs_cap;
 	if (!pos)
@@ -3554,8 +3552,7 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 * or only required if controllable.  Features missing from the
 	 * capability field can therefore be assumed as hard-wired enabled.
 	 */
-	pci_read_config_word(pdev, pos + PCI_ACS_CAP, &cap);
-	acs_flags &= (cap | PCI_ACS_EC);
+	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
 	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
 	return (ctrl & acs_flags) == acs_flags;
@@ -3676,7 +3673,14 @@ bool pci_acs_path_enabled(struct pci_dev *start,
  */
 void pci_acs_init(struct pci_dev *dev)
 {
+	int pos;
+
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
+	if (!pos)
+		return;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &dev->acs_capabilities);
 }
 
 void pci_rebar_init(struct pci_dev *pdev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bf97d49c23cf..c6ee1dfdb0fb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -543,6 +543,7 @@ struct pci_dev {
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
+	u16		acs_capabilities; /* ACS Capabilities */
 	u8		supported_speeds; /* Supported Link Speeds Vector */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */

-- 
2.48.1

