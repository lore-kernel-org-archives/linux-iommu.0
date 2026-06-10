Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F48A3822AE
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073089; cv=none; b=iY0tEV4pyOYmEI42QXyf8EPmSdcpg2SqkpDG3MfyiKniRNK//A48fxiO5QfGNcsMMdcb7YAOgRR3Irq1JIFppDBDobCi0u3mMH5P6fTpjPlfQFqU0lXalcZPtdLShP6SbhA8lahrIEanjpuNSlVvj9KGgmz+GA2qgLFTxlvN62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073089; c=relaxed/simple;
	bh=ZedtRlFClaBXevVNFnYB8UGxbyP20S9HuW/op1IPHAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQfS2XZsgIHYlYw0ueIszglzlPhThffX5pB1OOIxjkD7Ie6Eqo5DVWG1wnb3s1VivChTEpeUn7jJ6k2PAlqPGM/hdbOK+EPZVXfgAoL8N2jHDMNMY3KdWSEFg1iPEAEuLXTQXbkYMJU50JBUSAz53xMpfN0kMipvHjvcyRTbP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N5qyEq1+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kxwAhPwY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N5qyEq1+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kxwAhPwY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A2f9Dc324080
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z4Gm/K+T3sc4qmyuI/6DYikh3FBs9pCLd7ruh8jMyfQ=; b=N5qyEq1+UnbsZLJE
	kbq5HXF7MhaXbGyIcPLvCrVSXMwTCHmw9UsPgXruBDDAx3BAL1BK52+sjVlbPpYR
	QfFjXpqQMTBSQ+hGssN2B5kQmq/cMrhaI3/WlGYiwXuQOTW4wCWG5wqumeTANdX8
	9ya3VyYvqQb8+kJ4JHEoTaVDStGLrVonp/vDHEqkup06oULeTiuCR31XGAX8lx7a
	mtPTDON2AAWm8sO5CN0OE9Nj7xVqLhQk3GL4AkZsG6pp+txK1wWpt0z6qVFmdtz0
	MBFS8YxkoPPGMvArYIjy4eJzhvxfjCnU51MjBGPezH8b3i8KxEe67gdO9GWJQ/ki
	O5asPw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeeawrbr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso11159760a91.2
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781073086; x=1781677886; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4Gm/K+T3sc4qmyuI/6DYikh3FBs9pCLd7ruh8jMyfQ=;
        b=kxwAhPwY+Qmka7zuzSe9cr+UwoxzW1tIS9K3OHHSqMG75VptEDGp/IN145WTxRaWEJ
         4ras+aIXoXfv0yHiY7jhUIBTuCTv7bMDyAiUAe7uB1INgIdp10YA1s0FDfivIYWD4IGb
         TCiCOmwByr4z+2M6UK6YJULVWtiBAf6itUVeZcywQHhZJd89QCuMXPpS9opfBqJB4jjj
         KPXU/Ppcyzgj5kk66qINp+IwSDAM1hXIsagnrTKzhgq2G0mhbpLH6ah91eG7P0XAx10D
         X8rjCavax0ll6saFcFbkKLPgOUSw1eQDUm1sWxiyCO3WHp/0weU7rMyMMM2QHuqMB+dL
         OMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073086; x=1781677886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4Gm/K+T3sc4qmyuI/6DYikh3FBs9pCLd7ruh8jMyfQ=;
        b=bTXOU/QDnOSOi505hyrhBVwoTfwQGbPW/d6T541aKr5n6/neysX+Z688q3l9a+aLeT
         VpBsnpD6WS/Fj0M0gadldxkB6zvRbRDcmb6lDlU8eMOzBPCS5EwxXV5IJppFIzKFfzf0
         PQbfbZi4G1szZEWxO2L3gDWc1opXqdaVPhNJdXSSzesEOQouisgm5eq2JNv0Q7WAnEHz
         wi28c2RW1I6pJ5ykDcYFMtx9LG4TPIqtuteA9DTOfmOYrEeu2QEESIpuCJwdNj20D3Lz
         HTEOFEuCp0PxCiEX+k9cx2lg4XBIz9PrbODetEUr3hE1emc00gyxApx7gPE5b6BinPZs
         D/Sg==
X-Forwarded-Encrypted: i=1; AFNElJ9CUXMSvL+yBb06FHnNYVPZzzB6vhz8BVyNYK46VTiA0SVwiAQbH0wB4NmkUsb8rlrOfBLU1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5NRcNo24jfCdiEdQyCgHJb/RS/4l2KluGq+avrQhI8h+EL3ug
	gia4CVxPmct8Bix8wJwklYrLsgSHRAzYn5qFza4NgC4mJZQ+JO+Sd4LOlWa+uQk3ozozrqhZ747
	F68vj5ivalIZss4c1GNlFZwC85xy+3NHKRMbTt72VxTX2SPK9eCXiPjLKSA==
X-Gm-Gg: Acq92OHgHDM1A4iyE4y2ZqvCgf+AOF9hHPs96cZjixxyz1Y7RuuOC1bveTdbn1rwYI4
	lxEIgb/CJc9SVP+6kJOPqG/1eyLscyb3hYzpQAH1785JlpHoENBhN8NXrnLk3tR+P9tEy2iRtky
	OMeiOmQd1t+DuIWTD+EiKzVfBcMJCNUrG224gRGkZNwVzkiMvLpmjThznWxOPE4XMZ12IUSIeNe
	X9KPzuK5l7z1UtWgYT5b1ZH/BVDItVnES53gHWncwdx/U0aHvXLYG6K2yLm4lS4CqCzdzMieQPc
	gV4PfVYttIvi1HG7dD1w5Ep3cXUNrya5J1+q1yeow3g9L7LTudKy5RpKx07wMJLgY/T1XAvW4Ql
	wUWqJtzPUlo2QeevbT63/BotEzEe/22Lx6YFtUPAOOP8s6U1U5/A6XwzBSMqL72Sytw==
X-Received: by 2002:a17:90b:5806:b0:36b:7f69:c152 with SMTP id 98e67ed59e1d1-370f0095ba0mr27626882a91.18.1781073085879;
        Tue, 09 Jun 2026 23:31:25 -0700 (PDT)
X-Received: by 2002:a17:90b:5806:b0:36b:7f69:c152 with SMTP id 98e67ed59e1d1-370f0095ba0mr27626850a91.18.1781073085422;
        Tue, 09 Jun 2026 23:31:25 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm21580420a91.10.2026.06.09.23.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:31:24 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:59:48 +0530
Subject: [PATCH v8 12/12] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-glymur-v8-12-1c79b9d51fc0@oss.qualcomm.com>
References: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
In-Reply-To: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781073002; l=880;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=ZedtRlFClaBXevVNFnYB8UGxbyP20S9HuW/op1IPHAM=;
 b=FfTt8eRCvP5b2HGq9cfYdfHZHEb2OOf31mknyWFHcXDKbGLqsavlBfR/mfKut5rpe1XC7wYES
 7GxoxcVrpV7AJ07VjbHxCjO1j86CkCt1pZUOXn/cwlImdS5tOiO5F8z
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: 7rrCwAHCtpL_zFHnLiGJBkPfje8NTlPh
X-Authority-Analysis: v=2.4 cv=Iey3n2qa c=1 sm=1 tr=0 ts=6a2904bf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Dn0IJEph4XI5J7oltBAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1OSBTYWx0ZWRfX/8go3SBYRIfa
 Zic/8ixLDAi+G2nL1ALY7CiynU4r8xWMhAb78ow9XX5kQcHx/kVZM2xqLDEwXjki0SgzfU3C/R2
 WCiCPnAromLOgiM5SfVr6cQiOBkugLEZY6iHVTIr8dSx2nI4T2QR08k0HjqzJzYG9vUGiEqr+8L
 WNd46RdSPdcMsmMKZDSV3lx6RqIncwYt6X26f/ZTPAmLuz1NcChu5fYk7zfeIpeJorkIAOhsJaN
 ITjoGLFs/jnQc0F8kiyR9DT+xMssxgpYmL8Lph0ec26UnjfKsq/aSXlR4GymFqPeSV+xj5aToOT
 pRGVdX0KP3wsIhBnzv9GlV1rMR+XN0HmJaU7tJm9kNPTWuuBEeGycidpRQXD/EdeaH8oVKP/n4L
 IX8uq2VU8248ggdFTFMd21Wk2Eo7IM0ibtRYcYQtsmGHYCo7pUmZSEFSxqvBofIGmXA0nSbRMcG
 mcY9QqO7Fk55Jzz0eDg==
X-Proofpoint-GUID: 7rrCwAHCtpL_zFHnLiGJBkPfje8NTlPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100059

The iris hardware block is described in the glymur SoC DTSI, and enabling
it here allows the media iris driver to probe and use the video codec
functionality.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index c98dfb3941fa..9445badeb18b 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -198,6 +198,12 @@ ptn3222_1: redriver@47 {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/vpu/vpu36_p4_s7.mbn";
+
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.34.1

