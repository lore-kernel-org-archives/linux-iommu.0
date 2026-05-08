Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A041B370
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266961; cv=none; b=KtdbJSZ2TYJVNDkxYARyQSmc9R2koYYVT8+FYn3T0p86j+fvlALlXV9n9/i4y+UBtj59cZEhsJdB50K9yHIuudDdlVkqb0nG/BSlh8KPWSWmrJcpf5N8tFHgYmMrPMZkzx36Poxq3dYzCBvQ14VJIyUKks3cfCyNbSeXSGYGqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266961; c=relaxed/simple;
	bh=DDN57pej0y3Ltf0ub6QCqNvBebv6aWZer0W3ArGFCCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qj5O/FFpqdEYm1dXXg+JvAjilcAJy8deFXINLKLOF1xbPdZtVTqBcCcHF4nI/AQwb9YKgy+OAL1ZfpACrpLpGTgjfsJOaQmz1Ktdo41He1usNiZixjteYLE0bYwBnebyRuhOE1r+pw6uERQURnoJs7YwfZ3mdKqeE/1Lwa3fPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZoiccdI/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CibD9YeF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZoiccdI/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CibD9YeF"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648G4F2G1093702
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VUfpAIf6lAkbIZyifhFThrqlqNv+nw276Cn0YLBJZDc=; b=ZoiccdI/+SBIEzg9
	A2Az9oCQElFc7yNejZdEsCIJ00/VCbC7tpKnJV0Iph/neJL79RUcIET/iB/z1FFC
	ryIiON5IuNMqTQZe3IOdbdtZeuZ1pxS1I7edrAyL/ltzeUrtXcrfvX8iBJGOIvsI
	XbHA9tbvoCTcZbjPjYEEsc5YtkbhaALxMmqeefIiRNNEttS0lFHY6UlsMX/Aoo27
	rwBMj/u9a0RhVm0wFO98NckbhQfOYEShTpKQCh8wJH5UQTHfRCODU9rwhCc7O7o0
	J1JbuBNuEKNxXepUA0CPJgqQf+c3TheZw8YTSDpOig/F7/Q3swqji/aYYwv4W/D3
	NZRmUw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1d0mqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:02:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f85179263so2376707b3a.3
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778266959; x=1778871759; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUfpAIf6lAkbIZyifhFThrqlqNv+nw276Cn0YLBJZDc=;
        b=CibD9YeF2YBqTKTw3wLvT6pS4V3TUKVAB7WSPj5j5izw9t5vA2uK3jmPosCI+b051k
         Fh2CEb3HNrCe9FZZNdxQdiaBQU62CXbLLnotrMlY2hDZshREzLZ6MV96JR0GUqjk4xAG
         vXo+J1uj1kcq08v1mZMNUmb+lE3TPSF6HCDG/UOsOrWQ9pgTFoxrw6Wyk0nOge3yKOqh
         /yXEEi6foTbNw57CzJz427LFd9tXhqWLXdrdniVfupzUg/TA4QrtIU+15MiCdk2GJ9VK
         pGeRRaHclXnC1wYwkh2KEccHUdN7WMYNV0Yf32SrcZRtzRuypETevug/GaCKUO4Wnngu
         p2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266959; x=1778871759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VUfpAIf6lAkbIZyifhFThrqlqNv+nw276Cn0YLBJZDc=;
        b=ElAtEas11rPTRGkD2ii0jM2pyd+7DK4BIBPfz+vhuLH48OuQkhf2ah7jAwB7x0Cq8c
         slQOhxL1cRX/RihEe40o2IYMt9CrWy5byjEp26wZwZunx8/pSqQFxWio6vfC6zbWqFeN
         TWfiy+ELv1i6mp8t5ga155/DtAm6PNLDn9zqjhvpUrJ+SC6TkKscAIkB445eJ1LQsIC1
         K94l1vAyLoanD9BJLEgoZUUVSCRoPr9wx5P7Yc/Xb4446kxYEQwOY5mwiPq9VuH5biRh
         xmbe4sbqoAk4685QFRozaUQ2xVvBghS0w9lrOzvk7yPiZsYouso4svIyYMgZZWEnSsb3
         u0gA==
X-Forwarded-Encrypted: i=1; AFNElJ+dkyQM9XVDH2vL20Q4Bc35rP5CYp+JW6TmOhDWtsne+bfW5EqQ0mYohB/JwYIbvQtto6K3GA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8BTurYEsIM0HnZUXC46grvzj4KZMiYzK8THNkA5H7TWI9mVLo
	jbQIlfvNnN4QiYmvVrKghboIFVKP0hzQlvMzg3O9118W1kWiANQb5/LZyDYSIZtF/05TnqbkLGZ
	1uqkZ/vZam70coE7UqLkEsExGnZTRy6CHnFjw4Sv28v+o6yRmMtZaOAHHiA==
X-Gm-Gg: AeBDiesz6j9cI0dWdlRymCCwNn/dYcqBo1Hx1JPgmjlbsGaVao8hYvXJeU5gw8OHyqp
	Awdi8rGcJ5xHc3r2EhS/M/jKQVosvZ/ZplUIe6ETW6c3bHsAk/yaqIGVcDEoHjTxWmPn/xHEKhV
	K6k9Wp3WeKXz8IRilqOmb0kC8vgRmAIXTieLzWoyfxVBkHeI564AKu2cxrYH9uNUrUGS7zrDFot
	Ddfo7FgEim2J+pNxnWK6UMYCC+0GyWel6nVAlBQRKCArwbGlX4ctE4xt1m2LAY2nwXF+27KUCfh
	JOc95vJPluQDZ2JGqFghLoa2Xkf/oGqSeskePObU2LdYoRVl7SIW8Mf/ybkJkD5MuwXD7Rxxsh3
	bIYC36Y6TqAItlcNR4+dXMYH0oYZcgzghZ3PGpfLdsbrg3oyLPhbodsg=
X-Received: by 2002:a05:6a00:4b05:b0:838:af72:fb2f with SMTP id d2e1a72fcca58-83a5badbd3emr13466878b3a.6.1778266958778;
        Fri, 08 May 2026 12:02:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b05:b0:838:af72:fb2f with SMTP id d2e1a72fcca58-83a5badbd3emr13466823b3a.6.1778266958288;
        Fri, 08 May 2026 12:02:38 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm13395550b3a.19.2026.05.08.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:02:37 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 09 May 2026 00:30:03 +0530
Subject: [PATCH v5 14/14] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-glymur-v5-14-7fbb340c5dbd@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778266845; l=761;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=DDN57pej0y3Ltf0ub6QCqNvBebv6aWZer0W3ArGFCCk=;
 b=43GoEfeonHscvF5G4ZYHZZNfYPeq/aygoPj0v3/hqMHX2/+nPmJQ3WoIzvOBrug9x+yhhPKtc
 JFr/KTQrnkQACNGBhNoUj3l1N0rXNSwZa/klt7wlr+TtOon2nDNgQDS
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfX3HwMEebjAPJS
 incmuWI8z8b3YXzOZGC0+nVc2BqStzDG3CEGzLQ1fYGrYi/Q1Kc1DXXasWdnqOwQZZnw4rH/Bu2
 xN4NW1P1geaozSCX3orS3G63NroGfYOHjAHxV7a1SqKsW9fJ9hSZTE4v6g7Xqi/csXoIEjeeesw
 u1W2OGLZJK3oEDkknVkWthwemsmhY4i4pAxV89g2+t2g3FmyA+6WacmN/gW6qb4EG+CO0hFPL7j
 Keya5q0sTd9VkerNvcNUiWItnZtEpketoqH05lOFkWcWROAPmI+TOS9K5bs0SRhQcK0RiF/SNF8
 MI0zgXkBk0ApSM6A7rrtFgwsTiQXoovaIXnTfUmNK63p1MPxFJ2wDd7oN461ZKuTkWFPN6lVSdf
 YSf7CKDgaL+B9zQyb1r88BLlSOBwoT3TNt7b1K0pWK2/uC3pxSgeKc660vnTTu746oKOTNdCX7J
 34nFzYR40hy8BoY7wlw==
X-Authority-Analysis: v=2.4 cv=GLU41ONK c=1 sm=1 tr=0 ts=69fe334f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Dn0IJEph4XI5J7oltBAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: F5iqXdMpGEiN6r5cFPWEIGq2vzXLiSQN
X-Proofpoint-GUID: F5iqXdMpGEiN6r5cFPWEIGq2vzXLiSQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

The iris hardware block is described in the glymur SoC DTSI, and enabling
it here allows the media iris driver to probe and use the video codec
functionality.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index 35aaf09e4e2b..8d6ea857634b 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -198,6 +198,10 @@ ptn3222_1: redriver@47 {
 	};
 };
 
+&iris {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.34.1

