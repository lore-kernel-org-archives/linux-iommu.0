Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F9228CF6F
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685389; cv=none; b=Um1MngVWb7rSWMUPvwTcMWu0bDUhI0CYXmsrZkqg8nCS9lhdBSqHsR/jcFYqlSFR4QsoLdju037f8o3UPKXZHcmEh4ufEYOj/a9Th/Bmdzoh1LZ8v9CkPcNeaYtomW9kDSAlQ7MItqPP7BbLEFes0ytmKTNCt1oC4WZXXMdk2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685389; c=relaxed/simple;
	bh=5z1ouJ38EhP2+fHSIKbzZu23IGvzKgpnENHaWvqW/bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Meaf38p7HK08WsFj9oFou2jWPbracwLabDsquWmTWD4wqfCvJjtjG6as9fG7b6OSZ+cvEKQ95W0xeLZvQPBrbwFtn6ukWM/59Mk2ExTWWDetCop+hhIvf6+DEdhp6nPEtWgQQLE5nC9KT384bb4Kq+F59+j7F9TENSErhCwijFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dfYzBASd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBMqTyHT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dfYzBASd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBMqTyHT"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B282WMa1492403
	for <iommu@lists.linux.dev>; Tue, 2 Dec 2025 14:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvDGlE0S/6XgEh4WV9txDwLAXqVJ3Idv7+GFUaC/Ruo=; b=dfYzBASdItj2/N5g
	0VnEqjooYOUbN8kLHVQkeLPtWK67g4wWObSjH8kw8MlGDqBwxECuOXMp146ATx5S
	9dmgdEazvUCvGPzV4O8ImZXhy2KKgiNz8b37DCE5ZUiCd442ejhSGI+WtgrHtVdi
	ekiUpF5fb7gdwFR4gMvZDXai2bEdkPnIzPk/kaohiCLbXzt3lszqz3R2vg+HnIT9
	bDve1x0RxRYJbjUyEJ6OD7VTQ49LU0ozA4LxSGMGcITqc6W4w+CKLi44JhFIzQxA
	SFEsWuETF8bv8x1OPidO9G+1lGOEE2+XkJqA4Jb/m3tkyLTQnpjVTm8OU+IyscY7
	uiYLdQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4askbd2p3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 14:23:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-342701608e2so5601368a91.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764685385; x=1765290185; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvDGlE0S/6XgEh4WV9txDwLAXqVJ3Idv7+GFUaC/Ruo=;
        b=QBMqTyHT3Fl3OJkGMl93Ydwa2Ufwpu25U8XOMWhf3YWct6lmAC+OVxXtLnqaEL/bTe
         1bdar4W9klrUyL0vXfn8fDMaMIa3xddTRCNtxMaOclG7qFY5hWRCgcf+XurdWBdObgO5
         rGltAmx9pARIRn+SRcdFByibdml/RkpiEB3QdAaOtDH0j2gx+142rYZFaqszCPWr1bUB
         6OH59mitsPcJVBQLMGjOsnSPb2ogMaApD2Ibazf6C6rqqRROqzMRF14AGnGun5oKwYYA
         U18L0Wgz8Ub/JbVsmdndhqGCVWoQ6r3GDnIN5jpYwaXpJ9atlvmLHNGb7wWXe0efm0Cz
         3BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685385; x=1765290185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pvDGlE0S/6XgEh4WV9txDwLAXqVJ3Idv7+GFUaC/Ruo=;
        b=GwJyTqY03bUeMm5f4DX+ovZRk0chlsdeST4z+n8H/eE2fWM0O21Vg2k17LdyHbR/Rt
         Cgh33EHdppbddUDmfJQWxKgMahuILFaexovkVL0q1YYWqifOUEJNiKLGBc5UWMP3hRwd
         H6qh85KkUaaPlf+aovzjR3pcj4v56cI0hrr4Gd3Ugvpwxh/6Y8xZcm1phAifp1jfuiE9
         ay3ART+exjqYthe+KCOP/cvGnCEdLBhKaCdeZvp2uJNmwexgFNfPoi3n0fIEcUjiDJ7x
         xlHFu/riNoaTLgvg+7p1wkNHvk2aR519KosuwrzLYkB9hGMpWxyxWd8pH024Gcc/Knjv
         1jUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPK5vR08YCiWc6xmNQjGL/u28J4DlKdLByqxFsrHSZdoDq1VN53D5SwtIJyEB9iQMJmsFoRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj9fNv72ddP7ajdU2YnLT+ad1xPliEBioKWNOSsEayEIezyNeE
	YJK31WUFSOns/9i2BYV4iiehb6Dk8zebsm4TP3dsWAzDHE9cMValBE9xLO5O+jcyhfc4XHm2WUW
	jIiAbsTCx3jJcuFpSaI0uvMFMhjlWfZUa7KUEZztYAwm7cpbGrJbrgVEzyw==
X-Gm-Gg: ASbGncvmrvYK5gHC63d7OE1/nTtyNk8RUSZTPTXj7cMToW6Adthj1RFGjypmHvw2iE6
	sCBMNfpoW8rFQqEw1S82FRyhBJcxsz/h11RiDtPjtD5HjrcRL7BA28hJ3S1TJ+QJEA4jFYxRqgW
	Gy97Z1gXn031Vo328/sJElff2b2d2LEmA05fhiamIOo1Gh0Fzx5RW6haagd5YfkzT7+6LggjUD5
	VHqBNw5gVFKeJvEffr70g/569xjUXZJ8vYgZIBKIU5JB97e/xJJcgI+QE0AcedfVTIsbSgPsKYh
	iqwfZu0e/hZmpyvLje4/ml4ba+RCKSob0Kpfg7PyDJGzkPPME3Q8K9lCUY1akSCCYvyfVS0CXi6
	1R6qN1ROpwbm7FonDmVDlYpCOpKmU6tajU3PeEQk=
X-Received: by 2002:a17:90b:4c45:b0:341:3ea2:b625 with SMTP id 98e67ed59e1d1-3475ebfa712mr32702725a91.12.1764685384950;
        Tue, 02 Dec 2025 06:23:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcAutCfpDdRSSnk5MniXuwtr5pZ1zGjMgaerjI8XmJ3h8BcgaKPJR/IPoENuE65rkpJv7/dQ==
X-Received: by 2002:a17:90b:4c45:b0:341:3ea2:b625 with SMTP id 98e67ed59e1d1-3475ebfa712mr32702678a91.12.1764685384366;
        Tue, 02 Dec 2025 06:23:04 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a4821sm15659084a12.29.2025.12.02.06.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 06:23:03 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 02 Dec 2025 19:52:48 +0530
Subject: [PATCH v2 1/4] PCI: Enable ACS only after configuring IOMMU for OF
 platforms
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-pci_acs-v2-1-5d2759a71489@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3924;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=5z1ouJ38EhP2+fHSIKbzZu23IGvzKgpnENHaWvqW/bk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpLvZAK0KxrEsmvfHKka+ak4tP+Htq2wuvd6IOD
 Gb94sH+n1eJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaS72QAAKCRBVnxHm/pHO
 9TfPCACbwfeix1zhTrWBa2NPzMJrnW85zmPWFT/Qmgjv3jGIXa9W0UdmVZwtwyn5nzAQ94sdyrH
 zA7N3Wps46qw3ZGtdl1fwzu+dZNkBZnD+3Kdx2l9texP7AIR+FWTZMg9mtxABxxAf9JGLpwJSz5
 hezCe0rymO+HB8nl9ehmsnUT6WSnkFoJ2JFixPOCg1X42VOyv5XibQE+X+j1rZ7OQLL0lXcghQl
 b9M7RvD2fs+Qil4L0S0QkZS+5VLJQq4+2dMy6gMWXiTZQ+IgifVXwv6sPk1sVXzpFDf4vDQGN34
 TA7JCsA5LTM0oCeKOSGAKgwvOIhdnVAZ+I1cMv8WWSgV3N8I
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-ORIG-GUID: zFB-XggOovc6XzZD-Gnf7orFWnZTItG6
X-Proofpoint-GUID: zFB-XggOovc6XzZD-Gnf7orFWnZTItG6
X-Authority-Analysis: v=2.4 cv=fLg0HJae c=1 sm=1 tr=0 ts=692ef649 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=8ziBJk15IZ5r+wOU3RLduA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8jBi6dqPNo5Cx3X94iEA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDExNSBTYWx0ZWRfXyXYZgRaf3dCm
 SriOQeVVZzN6ePnhEmuFm/Ud6YCZo2dEIbsprfOG5r7S9D8xXO8CY8pi7rlgPgrYL7URBO+3WTG
 leDzc8i89nzJrPjpTo3470fh/F91VnTN6lSD0USxP+8/N6glS6wNspxOY7OKdTKJbhuc05eYN0X
 6u2+p73eQOFLgRwFFONzELzmpiUQ+wKE8V7eGYb8Hf+n5xJNBeZtfzGaRI2OPeyQc3NQhIzmR9T
 zqNRVwYSI7n5tEMIynsFHb0TNIB+pt25ZiySMmzyuF4EKrPabPdVnORQtF4p8aLyodK0li2vrQx
 NGD44/RBu7aYDAN7tmxO+yF2gtJ8Mp0rAODgzyUkAgFYX0nEwcfmKS84WPcpMAOrQPb0L1iC1iM
 Kl+eJ2H9WR58DcJj965Vi+c65cSzxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512020115

For enabling ACS without the cmdline params, the platform drivers are
expected to call pci_request_acs() API which sets a static flag,
'pci_acs_enable' in drivers/pci/pci.c. And this flag is used to enable ACS
in pci_enable_acs() helper, which gets called during pci_acs_init(), as per
this call stack:

-> pci_device_add()
	-> pci_init_capabilities()
		-> pci_acs_init()
			/* check for pci_acs_enable */
			-> pci_enable_acs()

For the OF platforms, pci_request_acs() is called during
of_iommu_configure() during device_add(), as per this call stack:

-> device_add()
	-> iommu_bus_notifier()
		-> iommu_probe_device()
			-> pci_dma_configure()
				-> of_dma_configure()
					-> of_iommu_configure()
						/* set pci_acs_enable */
						-> pci_request_acs()

As seen from both call stacks, pci_enable_acs() is called way before the
invocation of pci_request_acs() for the OF platforms. This means,
pci_enable_acs() will not enable ACS for the first device that gets
enumerated, which is usally the Root Port device. But since the static
flag, 'pci_acs_enable' is set *afterwards*, ACS will be enabled for the
ACS capable devices enumerated later.

To fix this issue, do not call pci_enable_acs() from pci_acs_init(), but
only from pci_dma_configure() after calling of_dma_configure(). This makes
sure that pci_enable_acs() only gets called after the IOMMU framework has
called pci_request_acs(). The ACS enablement flow now looks like:

-> pci_device_add()
	-> pci_init_capabilities()
		/* Just store the ACS cap */
		-> pci_acs_init()
	-> device_add()
		...
		-> pci_dma_configure()
			-> of_dma_configure()
				-> pci_request_acs()
			-> pci_enable_acs()

For the ACPI platforms, pci_request_acs() is called during ACPI
initialization time itself, independent of the IOMMU framework.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci-driver.c | 8 ++++++++
 drivers/pci/pci.c        | 8 --------
 drivers/pci/pci.h        | 1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..a4ee93497a06 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1648,6 +1648,14 @@ static int pci_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
 	}
 
+	/*
+	 * Attempt to enable ACS regardless of capability because some Root
+	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
+	 * the standard ACS capability but still support ACS via those
+	 * quirks.
+	 */
+	pci_enable_acs(to_pci_dev(dev));
+
 	pci_put_host_bridge_device(bridge);
 
 	/* @drv may not be valid when we're called from the IOMMU layer */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..9f594fc6dade 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3677,14 +3677,6 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 void pci_acs_init(struct pci_dev *dev)
 {
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
-
-	/*
-	 * Attempt to enable ACS regardless of capability because some Root
-	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
-	 * the standard ACS capability but still support ACS via those
-	 * quirks.
-	 */
-	pci_enable_acs(dev);
 }
 
 void pci_rebar_init(struct pci_dev *pdev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 36f8c0985430..972b28fc5455 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -917,6 +917,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
+void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);

-- 
2.48.1

