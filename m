Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3549F325731
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685399; cv=none; b=IuaX3C1+cMhFfJcDs70yJ9HhIMOjmWi6bq5Gs8SPiLAy9BMYiVRIDJF76MFj2QQsiaZWoSC9wQo1fTjG+xVovaj3kPHhky9VT7zPAAA3vCziOMbceW22nbGfgX3a6xrb8ZmFWDA5J1SD2C0I5sWgfLdiSnUZHsXlcFjBmN7RGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685399; c=relaxed/simple;
	bh=pRTmIB6LMS2I/NMlLkQVrAoVSoFyYgoyBRTO1H+wJzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r6mGUoZKSQaFcbDAMytBOx61ibudVV+ZOqg4lACWc5nYuv0aDbeb7voOKpnkY93ii1mTHQw41pop6U14FPVHnva9A8/Hst6j7Ufbp3evQpBckWqpn/KnScqEyYv1DNv0Ih/RZVEBzLEpSo+ipNTQrIP2sIfDl6oYHO7QsFPf8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NIdvMNWc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TmLCpA9O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NIdvMNWc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TmLCpA9O"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B282XnJ1926812
	for <iommu@lists.linux.dev>; Tue, 2 Dec 2025 14:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QIIBjNvOJPz0nM8jdNic3VTJoyxgBAw5GlTLZa5uxBY=; b=NIdvMNWcCR/aQmkb
	MqL6WBVnr3oz06JX+toYuEG71wniyOjm/mZRuSEixxKK0NTD4lovOmLzdA2HNg4o
	obDxWEAPmNgGORQxULkxRwbIq/o2KKaCkfJv+pBVXCnXQ3aDnA0/oWMMSSv647Tb
	TMfIoLmMGfC0xtPkQHubK1Tt/CyvE5a8ogIPHUh1Bu9jy1OCSwT2upFhJwxVLm40
	er4qLIgumDnxyrOMXcpG4a6haiY9LkPPr6qSzNTi8m/fsx1R/ADboncP+74NyHlq
	Xq6k85ebm62SdkMzvr5prP7wuY1xtC6YEnkwGBSFWfZMJ0CmmL6kGiuYSSmryFGj
	Oeo8ew==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asm4xtj9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 14:23:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b8a12f0cb4so5171221b3a.3
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764685396; x=1765290196; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIIBjNvOJPz0nM8jdNic3VTJoyxgBAw5GlTLZa5uxBY=;
        b=TmLCpA9OANuNp8tPWNNORiZqsw5w37a/FwUQoxU2Kkt8xe9JR86fZtz07Vd21tKkvz
         b1BcuY81kPY197YXUgFBOEIwXsMQviCgO2U19mq53JhWLLisMXvpDh2UuQdJ6lXLL3/m
         N7IFA2NLfesgWczzHzmokxjeE0mzFvHYZ+/2AVF+b+RH1BFYiZ6qkP71RuAF7BYMdgIn
         dqDf9CDWhu9/tOPvJCeLijPd/k2u3vUlJL27RmIk5K4cSIEKcHhNsqmxYZljtzRbwRXL
         QTqcaN9CcoO0L/8e+P1HjjPSc1YoDBSRk1XiRfpP60iQeCX3kngtneP02Jwuf01L4lvT
         08/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685396; x=1765290196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QIIBjNvOJPz0nM8jdNic3VTJoyxgBAw5GlTLZa5uxBY=;
        b=CsVNKuuoNJrPe4ALj0CyKUOtJTSf8htlnJaOanYmzUBq2+edXJRE56B9vvQDWYRMpZ
         osI9Ww8gEy/BDWU5GnfCxgzAx/NQxTIZ1H6LFziPm7saWhoep6wzvR3fQ7c/fuPyCr3t
         fScskPKgGpcpYn2XWX4XUpcn6AtDQLpQvn/2u26LjiTN8Q3eStoaJ1cG2L3LTTvXCkCy
         U7pqKtBpsUp1dADJIpJTSUK2dDPIs6MPT8fEOJso1ifexJqyc/GIyVyqYsinOGQ7rPA5
         QX6ohBrM00dYw43SNQCZMT1fnY40gfS2aWz3qL45qS8W9F0TVRjIIsFAxzdpMuRuHw2+
         e/Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUJzTE6rWYB41WYSF8PWoNyb3lIyURt2L3ecrYbP+sP9X8efRmr8qRcQhei+HH4TlrezxLNtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxY2a51O33X4UDHddoOqB5ujgf4jyE/4TGTlVKnzZHsHNICi4Jd
	rBUixAS3F7Dl8HtAFbahmdRa0/KAhcbFv+zYmtFdhY7I2afiRxQqc280UWVIET3ILt+IE6YPzg9
	UMHmaltnRuBF8mCxQ0eACsWGiC5vnVPtawOH8s8LMANX3QGAJsJ7KnYFwxQ==
X-Gm-Gg: ASbGncsLFUmU8wy3DY1RKq5seWp27jsOTAAsptTx3kp6j0KhuUvowzijUcInGo/sAGX
	UWM0C1G/9gmms41UtnrxdGXMvB3OHGo3r46ygQPifCj2v+0fS5V2GIKnTbg/7+jh1Fyr6eMfWQf
	v62G8g+4pXSzeVT+C79qR+bsMrpfe6GWlt2LgXgZt4aukeA3cSkXzHqxQhrPsq3TqAdWU4M+irJ
	D+x8Hk9X2un9wHDtp2Cr3i9iy2pDLOSyFg7H+R5yZNavUPb6iQ1YzriezCAy1mV1utloq2bdzrU
	IzXgaw9nh5/rg8KHK8H/mVmL7VV7r/JUfCSe8I6aEAvjpqtSf2ibog6CJOHhQr0wYr6U7naIUx2
	5UCcVjNJ1mh3W6pqvhFnbhWFod8d0KImJKnEyh1c=
X-Received: by 2002:a05:6a20:a125:b0:341:e79b:9495 with SMTP id adf61e73a8af0-3637e0bd69fmr31557258637.54.1764685395938;
        Tue, 02 Dec 2025 06:23:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXg3DjQM/4ZIRpcDRT/tJi4qz/yVH4IAtQoIwviN0V/oe5Yh00yD0sJ44YqA3xpq26CgNZuw==
X-Received: by 2002:a05:6a20:a125:b0:341:e79b:9495 with SMTP id adf61e73a8af0-3637e0bd69fmr31557219637.54.1764685395435;
        Tue, 02 Dec 2025 06:23:15 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a4821sm15659084a12.29.2025.12.02.06.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 06:23:15 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 02 Dec 2025 19:52:51 +0530
Subject: [PATCH v2 4/4] PCI: Extend the pci_disable_acs_sv quirk for one
 more IDT switch
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-pci_acs-v2-4-5d2759a71489@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=pRTmIB6LMS2I/NMlLkQVrAoVSoFyYgoyBRTO1H+wJzk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpLvZAherrBpCOwOposcs2baS4ADrcU3EnqXe/b
 RPhSEm4to+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaS72QAAKCRBVnxHm/pHO
 9boTB/4mlbW8TW6gVy8o/sK2KC32UFLRsRusBG+Y5HF7v5PnfVZjhehuZQqeWahB6SG8PnCnNMw
 p1vnghlQYA6p+k9uZBX7i8lvjrTHSfECP81eQX6mOTdd/SS7Q/bG5VkaSdJs0G0BmKOMonBiwCo
 tkJc6Bw58gWszhaKmKiioql2hYnCu1EZ/DL3tkCLQmoDdOXfdCWJB2TLgRnuxDZQYyTXQGMbKmc
 RHLwb9U9uX0DK6GBP9dlHYIq3XgDLJQ9F3sljaBUPu68lnZhQ/TJblV9XocY82GhQVbw2y5faTh
 f9OgdJktdiR0udcHpUW6jMF8aNAtqmC9uRgAr4HYTy/yvtS0
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: OTxiBDi4nxB4iUnK9pKK0_v28foxKj88
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDExNSBTYWx0ZWRfX4BckvPUfMgZA
 +LLV9Zh0PM/5qmtx2GsGaJojlv8nZwu6oGj2pNBhuM2C+bSBiMrDnC2aU2lo803fE9uzFAaH0LB
 6l5KwWaO10RjZprek3s3KKJQMQHjk8BUYytRsqGwRPN8XNB+AWOj/Jcae8f7GEU8HJFUr8Q1XUq
 Kzgp/txdW0I3TPISG8dLiZaEmI/Gh1iNamUpI22AMn436jM47q/oUcJYQGJjEpfnpliaq2hyBM/
 1jIfvlRs+MGUonLNCQXO7LJ1/SIansMPRqsBu5QZOTzmDmMhsIrexjAM3t/gx4MN8qORTJ3TH7b
 8BLfwgDaHEaWTrzVhKY4f8qcJ+CNo7BU4f6cAlMuWVjTWR7neBPPBFu0TyUGlE3tyZLb/dvjN6a
 ut5AYGfb/Z5rMZ4Gv83MwWPct7M+mw==
X-Authority-Analysis: v=2.4 cv=cPTtc1eN c=1 sm=1 tr=0 ts=692ef655 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=8ziBJk15IZ5r+wOU3RLduA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2xi2RfK-dtapqwj757MA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: OTxiBDi4nxB4iUnK9pKK0_v28foxKj88
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020115

The IDT switch with Device ID 0x8090 used in the ARM Juno R2 development
board incorrectly raises an ACS Source Validation error on Completions for
Config Read Requests, even though PCIe r6.0, sec 6.12.1.1, says that
Completions are never affected by ACS Source Validation.

This is already handled by the pci_disable_acs_sv() quirk for one of the
IDT switch 0x80b5. Hence, extend the quirk for this device too.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a5956726a49f..314aacf5a309 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5798,6 +5798,7 @@ static void pci_disable_acs_sv(struct pci_dev *dev)
 	dev->acs_broken_cap |= PCI_ACS_SV;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IDT, 0x80b5, pci_disable_acs_sv);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IDT, 0x8090, pci_disable_acs_sv);
 
 /*
  * Microsemi Switchtec NTB uses devfn proxy IDs to move TLPs between

-- 
2.48.1

