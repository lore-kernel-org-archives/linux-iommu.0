Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443043D16EA
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964465; cv=none; b=Nd1eOEkVvm8Gp4yiPeIXEAptoQm0VjqcbiJzm47ch8Esa6aELOPjLdRUToL8zO4t5UdnRGE3JBRufH8VAQb14sRc26WFEEQxp+cFzsV+yjJ9/8vMQ79m2o+zO+lz/8E9CW0z6OQHoVVEiUmGQWR6hcC8c97r3blAFLNXIGPDSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964465; c=relaxed/simple;
	bh=lQ3z4JfxRQCYgSubX6j1hfl+h6PxkcR07VzhxVTyjGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAPr0JZLyMggeQEpjoCZqQfzWDHNoQR7Xhhd5F7cY8lTWig5OUnEuiyH1642emsMS8zDnf/mFE7L2lfWsScLI9GMObiZutD9c0IfZqZPymEmivGZG0Y9VaDU4CQabPDFmAZYmEKvlazE938CRWsf+jDrXbhVsCAzuI9y3C+0B1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UGaMBaT2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jTF/rJ+r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UGaMBaT2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jTF/rJ+r"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456lnfY3187628
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 07:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kIHJ7/jlM1Et6nXCMTws30svegX3oTdpHgtcyGwoCNo=; b=UGaMBaT2lL8loyJA
	pPx+8SZOnlTskN0iINLrj23dpF4ZJqr3QmYUuKI2v5bt6zH6jCUMHD3DViYiAFID
	5SZvQAa1rzvXRksYp+Z9tS1w/fq91soWCNUVjVZrC+uVsVGWBao6oRY7YPLF/IUM
	PDaHHz7UQtawsXDq1KS1nCNEqeWMM116OObzcK7aMtf6vpXEC4qMznfFQvjthjw2
	4PlaTf95kO/sr6xBqa0tT9FeSgwaZPaYxy1eruBMgY+SsISceYNnaJ/iFxW51RsD
	cdUAKjngmbe9Njen5tXKlnsF/eLPgL8DztwbHBqeIBNgJk/1G8oWhVblPPJ1K/Xd
	eYKg0Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkk81bp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 07:01:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fc22424d9so11949464a91.2
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777964462; x=1778569262; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIHJ7/jlM1Et6nXCMTws30svegX3oTdpHgtcyGwoCNo=;
        b=jTF/rJ+royPQRJpL+VeXPRHxnhRRPfX9YflLmZNZ2uLuBshXAVN+pOabuR2ez9ctjz
         gyL1RgtHhVqwKduRx/2j7oMudFPtFyrEPsx4QIK+WOwZhSiYDltBw/Jn4hLbSFKVCsfw
         qQK3YgaEPoF9qSKX8mMGMegNb7qze7Mb1sQ7GcIi0ZvsZUWCkcKz35iaazcPvmIZTB3B
         OephNfVNmwarRn9CMQCFDBatlO4qLgHknjapHEVSgKMScZ+90G+th68xvu8ZINDY76ej
         Wyy8wwerRlWZU66SOLnp2RRumvv3nPzNRxtvM/Szp7oo6y8OyLlctBKjRL19kFWYe2XN
         fW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964462; x=1778569262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIHJ7/jlM1Et6nXCMTws30svegX3oTdpHgtcyGwoCNo=;
        b=nqxDH03zpBe78S6R+iqGrv6Zzj5FaPno5WjQmtzxgG/E3uLDCuKNQUmQQQJqIotoNI
         XvvLLri8oG8bZQVlTteyGuGQ4Ibl6bxGAQNAKe3RFC0xLiXFBew5EBoABlgjx/E9dggl
         senYy0UJiGuZyYeEzEWOH1qnpOmuLOknX5l08RYwPv0cZCJ1NyTedJszs8paTIRvZfOK
         YUBJk8yaEtjOlB6sTYkCuD8EXbIwuRfmvwb1O4BBEvhKDYvZIZtWHT6rqhke7vlCuApE
         hO5Br7D0qNgD+EpzrjT8jWSvwhHmbb1XlHg0/L99pWHDBo6XRnujG3OFt3W07njpe0kQ
         aC2w==
X-Forwarded-Encrypted: i=1; AFNElJ+6yW7mTYk/BiGjQlLR74LhP3AECoA1f2QGstwMRMKKeRRqxlEfYw8HAtCHKK5m4ntuQaOdqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzinASfno4ABh0NauhIKL/d7jWwH5SJImUI3iE9k7WcimjWfUhZ
	HCePlVeW8Utiz9pNiizWZTsF6LGDV5JuXQyewmWcAZqGjbtZuyk4RBqaqsoPicmFNsRQNsk7M1M
	JVZwOkGdEv5JFUuoD0ml+iWHMPNen8tpCB7ET96a59QCOTcg8LPdk/E4d1w==
X-Gm-Gg: AeBDieuaEr38Oyk9kmsFEvr1Zf0y1luA/PB59vmSUl7OQ38RkhkNpBXgsF4w0OUc7wE
	AtLmvyDaM15N8vXHbkMQuyse4ri5ZRKtPNhqWVjWQ/c+bUWEnbDeMq/KvYxFArL+IrIxmv8sTFT
	GxmZDcUzwxOWAFuz6UFtS3pXyszrgPh64Bw4eVVPwwyvE5naqsGteNCZKxYgIZNAcf3qyIiBCVZ
	R0Ez3Dyp6WH+VEPI8MllWVIAAzDij7BeLbFWsob1NL7d2l9kUL5bQsDwT3zInUlZ0R1qc/gTaE3
	hR16jswP7jJXvhX5h9qbcdmRq/SLdSPmcnxHbypH499Vm3XfmhHqLFR6D7W4rzFKQ/ue3Pzrwrc
	OLMufxgCRIksgiR05AfgMbsQpzA2G8KalxVKoM8jFK8gft1Npu2lhlxn7hiYgXokW3A==
X-Received: by 2002:a17:90b:35cc:b0:35f:b6d3:da7d with SMTP id 98e67ed59e1d1-36577485fabmr2034543a91.17.1777964462161;
        Tue, 05 May 2026 00:01:02 -0700 (PDT)
X-Received: by 2002:a17:90b:35cc:b0:35f:b6d3:da7d with SMTP id 98e67ed59e1d1-36577485fabmr2034510a91.17.1777964461663;
        Tue, 05 May 2026 00:01:01 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm13840146a91.2.2026.05.05.00.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:01:01 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 05 May 2026 12:29:26 +0530
Subject: [PATCH v4 05/13] iommu: Add iris-vpu-bus to iommu_buses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-glymur-v4-5-17571dbd1caa@oss.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777964421; l=1065;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=MN1sEQpm2XgufXMnfyVogm/WAu43GbiaX89w8VaFbuU=;
 b=yU4wGk5gMcNMl/YgYaMOseMuBSUH5Ol/F51wnfm/FMqe+aaL+AG8wYAK8NCO34c4/5rM4xA8j
 frn4+vcXcSNBHatelFfO3ExHrA/OmP6y3dlyfsQmh+rCumYZTZflQuL
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MyBTYWx0ZWRfX7Z6sfqrCfDk4
 yiK4JutOgoo5wGjGs2gqyr1K916ix0MYF0LCtImcL5s5idQB16QEYeuxCJgg4pUeXIuewrHH650
 PUs25eadEGqF0H01StBjEHYKRlRP9kUapwrjpFLFmaO1TmAihYne0XkftjGL4bL+brfmHJdcjnJ
 gTw6XVaijttN4fXGBW7OabnNgs18uJ+0WD8rpcYGPmrQHFtMGYOZUk1SeTUNF4ElLGLEG0uq2ur
 NOA57mE6ry2loFKu3Olurt6y6Dux+dnu6zt1Hg01TwekYb0r+kbSai0bYgP1uijLe8cspJK0pwM
 p8f3pylfX3TLvxTB3AisQCXHZUtGIDuFkSfnctMwcq5d+97+QjTZ6m0ecAcdj14kpLsbDeRgCcN
 HHmeRGVs/AfYZfpccXdOB5Eembom0I4yzhzbcEMe0OSr1VgGke+zFzQVhu+VplPGIyhGgkUGvAB
 lHf79LvzGtpr0Y8rR5w==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69f995af cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ADq-ahcSnVbbDow3-dgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: H2yQxkpHWtI52tRRxIIFwa3BI6Ec4Ceq
X-Proofpoint-ORIG-GUID: H2yQxkpHWtI52tRRxIIFwa3BI6Ec4Ceq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050063

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Add iris-vpu-bus to iommu_buses[] to register the bus notifier callbacks
for device add and removal events. This ensures that when a device is
registered on iris-vpu-bus, the notifier triggers dma_configure(),
which sets up the IOMMU context for that device.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fccdbaf6dbd5..3b65df247e52 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/iris_vpu_bus.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -179,6 +180,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
 #endif
+#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
+	&iris_vpu_bus_type,
+#endif
 };
 
 /*

-- 
2.34.1

