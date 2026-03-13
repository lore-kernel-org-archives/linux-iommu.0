Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621F344D92
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384577; cv=none; b=OwKhZfxBP79piQIBPezwnyLOHVmIabj6ud6DDddFuTmY/3aMi2hQNdyyQTtf71W3ScH0pb4sgzXMb+jkZ926HaL0NgDEpO+j332bGW09IRNb+dbzLGsx3+5Rt9yDXzik1LdOI06Rz1YWALk3Aht1T55CFgZ5JaJz2mzTM6SKpbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384577; c=relaxed/simple;
	bh=pvlk2gOPkIN+ITxicWXFZ618jc3EqUbu9jfuBJT+Pj8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MaadHMBAHVGcB6Pde24qD9r/xgBv3WxRwpnlR3rlHPoS4r4gfs9Pjjo3s/WYCjkhCoQapqgeFc0W/IEz4LK7wImuUN6oaLXezROKSidJE2rYMqEOQI4uyz2c29osXOehL+ANd6Zi+AEXbcMe4wZ/b6VFNnaOklffaftemyCwWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hJLgPv0Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H95uHv+P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hJLgPv0Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H95uHv+P"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5trae1574861
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 06:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5AVmFAe9Ik/fE0LX/BsA8E
	1wHztxhMYSWxglI3gqndc=; b=hJLgPv0Z4qDUBFVMEQHi0DDoGS8X4keR73BE3t
	RKLGdEhNe7yWwXWndunp/MZkJR+6CSGY4Ke9tdGCng2D68Bpd+vEhsUfqxG2HwO7
	ZiJlG8zfhLXxIcXG0KTwyNnjL8tF/0S0zdDsl7UKHOB5ZQjJyHvKXLZ2tpbfLglV
	K8jiGYC0yrdyO0Eu383hfcRUAqPFoDCAHgqcbs8VwrRaFAfN+CoTk/CBnYDnapUC
	ZXjC6iQnXBdzEhzfYSWasyBpiY2RgaAREBvHW3z9nLk5u70QOCUtywwUci/rU6cr
	yaveQe29DY55nFQW5Ei5O3g2ASPT61JY3EmJVnHtM6lWJ9bQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh53mudn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 06:49:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358e425c261so2061382a91.3
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 23:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773384573; x=1773989373; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5AVmFAe9Ik/fE0LX/BsA8E1wHztxhMYSWxglI3gqndc=;
        b=H95uHv+PFW4+58Sgv3OBbWx4j8AgR+OLNWrpw2wWumpWuBBgD0ZUzEBi8XkgQNJw/H
         98u+HUOMwEep8iU9IsQYT6glsM/L5PuE0+I3cRnHfRfN6yF7DYkZrSeoMOyKNyWy4d84
         oAkbZ68JT+Gml41V6/Dl1EyqRAq9zVjqjJQP2I+TzXWY4kng7n3O+Ju+Bup64ecsR+5i
         isRIAXHDr/ATaM56wq8uVV/Y1wJngCbYjr89vz2rZNBvKEyY/WHfJ06LJrdoNfHCZ6uv
         fEt8T7ptQpFfuwJqICU8u1tE29QNREWdbsmo8D2XLLS68MjPokknxC5HGc7thY1UNR7y
         EM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773384573; x=1773989373;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AVmFAe9Ik/fE0LX/BsA8E1wHztxhMYSWxglI3gqndc=;
        b=Z7H6u5K91GVNcvjwCPaykaKWhZmL9OYD0+lTz0N/xMXqM1eQiI4k0z+ePbSRmEnHKM
         CfPWIcf0xNGkiTacuBJx15dWCkGCm07MYir8qi/3gfxJQZMO3EJf8b6X8ZM30OT2BaZ+
         IowxsmyviVnx7Jq/ATYub4S3mIWmuPN5h6DUagCCcxvo/qiretBEDsgZutOSLAF413KU
         QhWr383eq2JZRSaWyM9fRSrX5zMl46bk/pqCgZwp12VYwOoU4/WU/sAwXtYrdVDCBEcX
         s0ehcXnO5N+gkIx6Z6huBYri5ynpluuwUXNfXkcOxbbcmPHuUEkT4HVHoigNHBpd0yYw
         lB8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYjk1YW3L1JkoygR86BG/yDx/QmEk2/mILhBsh3ui7WOc0tx6YD+7OeNn0Hk1YkvOpUgCeJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDUuJo188YfatN6JjiHTxptYeGxdyiPiDBaiPG2ly3aBDEFYC7
	hTW+FWer488u2NGfVzMjfqEt/LsbkNgyN9a0++BAaeKyRt19/v1alOwoZEOwShB78uYxtjwm58c
	rfG1+mIeA8ytD9Q71vh7N7DcLnjqXu4KGB0LX9nB/G75Xbr8xO7ovO7YnLyGS81Naqw==
X-Gm-Gg: ATEYQzxIIT8CjEPr52FQHxGJlqb1Tq17CrQeerbANScRCVfRIylypbkA8vVF00iYBDX
	KZlJJjeYNcj0olH72qRSIMFJIFE12JModLtp4hzUZj0itaxVjr/JO8OMOwP8j8Kipi6jAiQ/Q7h
	Wqgwv8XC1tSr/jE2uA6V/qooNWDoeXPU+nB6xqIQlrMR8gIn/1fblL9QR16A95ei6AwzEKsNYGe
	dkaPlX9KS+Nv6PpXhCYh9bxBfsrVNnNS/B95QL/sD9QhccuNTeNS4yhcRmS8XNDEFAxp9UtMatN
	A01lj2GBWMQe4PtAykNzEy6xotf3vCRjEHg+/gWtGM5/GVvdaUkKzxQ21rW7vbvdttbmiS5/+n+
	4XwbE9QJbCHsDcuRd9Mcz8BcN5vFzaIxSp5VdToH2tmhZCdo=
X-Received: by 2002:a05:6a21:6197:b0:398:afdf:3463 with SMTP id adf61e73a8af0-398ece212b3mr1705937637.70.1773384573482;
        Thu, 12 Mar 2026 23:49:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:6197:b0:398:afdf:3463 with SMTP id adf61e73a8af0-398ece212b3mr1705918637.70.1773384572883;
        Thu, 12 Mar 2026 23:49:32 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb97b41dsm936160a12.5.2026.03.12.23.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:49:32 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Subject: [PATCH 0/3] dmaengine: Add batched scatter-gather DMA support
Date: Fri, 13 Mar 2026 12:19:24 +0530
Message-Id: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHSzs2kC/1WNwQ6CMBBEf4Xs2ZJuUTCe/A9DCJYFNqFUu0A0h
 H+34snLJG+SebOCUGASuCQrBFpY2I8R8JCA7euxI8VNZDDa5Br1WTWurtw8TFxJp6zBIj/prMi
 sgTh5BGr5tetuZeSeZfLhvdsX/LY/kdHZv2hBpRUezT2eEBXYXr1I+pzrwXrn0hhQbtv2AQN8W
 02vAAAA
X-Change-ID: 20260108-dma_multi_sg-c217650373c2
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Veerabhadrarao Badiganti <veerabhadrarao.badiganti@oss.qualcomm.com>,
        Subramanian Ananthanarayanan <subramanian.ananthanarayanan@oss.qualcomm.com>,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-pci@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773384567; l=2678;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=pvlk2gOPkIN+ITxicWXFZ618jc3EqUbu9jfuBJT+Pj8=;
 b=CJsyKHGdctf6eMe9FYY1OpAZhEpTLB18Re4kWKHiZ0+TKe0AV4X/h4B2qhl75oyvumt11XvKa
 T/JaOl/TpY9ArzGxVUQ0/u9VR0ZLcx4FAaInJyDJiUPuxoHqhv3XDfC
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Authority-Analysis: v=2.4 cv=ZN/aWH7b c=1 sm=1 tr=0 ts=69b3b37e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=f6ynY6_RdjVN_4bGfK8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MiBTYWx0ZWRfX92Nw+PrQe2O+
 lgOzWUh72IBk9+2zKzpXcIxkBLTE2AH/cDG0t+U1mt4G+16BkrN7jW8pmrAxL5u9f1beP2Kve7a
 nBolnXooAx4V/t4LQDhSvMWDBTzw4dlMl0YQL/FoHbOoWKl8C7ZSYqaR3H5bc1odtmAG37xrhVE
 WYShNlBg3QqlG7clCqYrIahG+ntLfeLtRv8Veo1l4O7Ej74wA5wnTm47Ft1j+2Y8GZ7Kcab7j4A
 JLadmaV2mlfVQP7Cwa3oMAP0Hidbfcr0Z4I09bCXoP+0c9QcKJeGMaZhL69AzWaOatJhJiuB25o
 H2WCP6i4NstdeVELrFGibpCwXSh+c1KTedb+30kL1fmgd6Tfj4/yflbRbVm2ZBbqkfgIVx64mYg
 iC+Azd2l4qBV1b9SqZIVi8hXwOfv5ueqDSVUjTLeb30PUMb0sDJxnx4AQp9TAbk1F7mffOLVPB6
 xa/Xu+g45m+2r8+M/ag==
X-Proofpoint-GUID: xRihRrH_F5p8QgwFkkyG8T9WkL9CHI8h
X-Proofpoint-ORIG-GUID: xRihRrH_F5p8QgwFkkyG8T9WkL9CHI8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130052

Synopsys DesignWare eDMA IP supports a linked-list (LL) mode where
each LL item carries independent source and destination addresses. This
allows multiple independent memory transfers to be described in a single
linked list and submitted to the hardware as one DMA transaction, without
any CPU intervention between items. The IP processes LL items strictly
in order, guaranteeing that scatter-gather entries are never reordered.

This series leverages that hardware capability to introduce a new
dmaengine API — dmaengine_prep_batch_sg_dma() — for batching multiple
independent buffers into a single DMA transaction. Each scatter-gather
entry specifies both its own source (dma_address) and destination
(dma_dst_address), enabling the eDMA hardware to process them as a
single linked-list transaction.

The primary use case is MHI endpoint ring caching. When an MHI ring
wraps around, data spans two non-contiguous memory regions (tail and
head portions). Previously this required two separate DMA transactions
with two interrupts. With this series, both regions are submitted as a
single batched transaction, reducing submission overhead and interrupt
count.

The series includes:
1. Core DMA engine API and DW eDMA driver implementation
2. PCI EPF MHI driver support for batched transfers
3. MHI endpoint ring caching optimization using batched reads

Performance Benefits:
--------------------
- Reduced DMA submission overhead for multiple transfers
- Better hardware utilization through batched operations
- Lower latency for ring wraparound scenarios

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
Sumit Kumar (3):
      dmaengine: Add multi-buffer support in single DMA transfer
      PCI: epf-mhi: Add batched DMA read support
      bus: mhi: ep: Use batched read for ring caching

 drivers/bus/mhi/ep/ring.c                    |  43 +++++-----
 drivers/dma/dw-edma/Kconfig                  |   1 +
 drivers/dma/dw-edma/dw-edma-core.c           |  40 ++++++++-
 drivers/dma/dw-edma/dw-edma-core.h           |   3 +-
 drivers/pci/endpoint/functions/Kconfig       |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 120 +++++++++++++++++++++++++++
 include/linux/dmaengine.h                    |  29 ++++++-
 include/linux/mhi_ep.h                       |   3 +
 include/linux/scatterlist.h                  |   7 ++
 kernel/dma/Kconfig                           |   3 +
 10 files changed, 224 insertions(+), 26 deletions(-)
---
base-commit: f0b9d8eb98dfee8d00419aa07543bdc2c1a44fb1
change-id: 20260108-dma_multi_sg-c217650373c2

Best regards,
-- 
Sumit Kumar <sumit.kumar@oss.qualcomm.com>

