Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D94779A8
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124706; cv=none; b=Xpn83Zg+VhRlD+Gb8ranmj6hO/jKNGsl1VNXJsKO79W6d/jhExsuUiykLVZ4NoQBkRQ5xVz46BzLr6QEEWsuxKDFPvXeJ1ctjb+783Vh52r8UbFTTrkvQiY5+1pkyTqJfmHFLzdn9izIw69lmk4E59wOlWbFYEbJHYKi4fC+4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124706; c=relaxed/simple;
	bh=HKovxLVfXVSwQAXngyNlJki7rLoRBolhkZVsnfCS6gI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+AvhPqDFSp65pw7IMGd2arGrI1kUzfv9h8ci1K5DIFmq7bXK7pz4a/TEXOP0vGb5TZ/a4Ur5g5Q2bnceR1h2XQKvBr3H3NGi+Ap+y+9K0KKHJ5KStFHxjMd+gj/VT/GKguiUYA1nVXi4VdHcKhFafurWjHVlgXXZup5BB9DlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dCXW4hbx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aoDlfjzw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dCXW4hbx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aoDlfjzw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FE3Z74850956
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DQ47DDAfNPWgexHv1Ma19CgalnyaHgiZ1WcVnWQbsZw=; b=dCXW4hbxx4hC4ym3
	o2dppgNycVguLGhSpLiu8d4Th1o8MDTqko7B46IsiaQ2v3VxJj6p0Otj2oRbOZdt
	rYTKS0ZlbU9hOebV5QF49IlVgQBqKFIwio4vEgd7bg+QdkyvUBw51RlL83jAHfVC
	l6lOUhrivXTA2aqv2Nh2gj1B8/Jthmfk1w5lw/++zRwQtuZZsYioITf1piBBhKhN
	Op8sMZOrT2UfJwDD/82VMT/kYTSfFu5TnNihEGK6fQZmB6ATqPcZDjzdXRzJTv86
	InRyoyKnrkDE/cxtXd4SShaUqk2Ykae9LCwZmc8RYfoYXW0XX6KQ72XLgCq+1f3i
	sm6Dvg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe68wsekd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccafc5e82cso26988545ad.3
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784124704; x=1784729504; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQ47DDAfNPWgexHv1Ma19CgalnyaHgiZ1WcVnWQbsZw=;
        b=aoDlfjzwmR92n2Fpua8qcpTBms6U4KTmKVBWoj+gsICCJK9ZxtGQI08uro94gIsCl6
         ukme2iZM/fLQ2r0wCvLJ0+yPPen0VSFhYYxfhSjVblbT0bqwrIr2BZ2TehBw0RlAqiYi
         1x9bX3BbA7RVtoXV4xR7tquS8EIFWR8G7Z/yEx4YZIbhttXHCScjithhuI9VhOgC+Q5g
         bpP1Bzn9ZUHiNAdiXlhUrwuNQeKVBkdA+H3ThjjvgtT/j1w7mV3cco4YPwzWXSaVh0Pi
         ka1r4v+wMePdNiEaDOOqQNWzojtl3Kvg10ADeYJHoSaf45AZm4Adoe1xBlCI+YsaXqg8
         xArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124704; x=1784729504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DQ47DDAfNPWgexHv1Ma19CgalnyaHgiZ1WcVnWQbsZw=;
        b=Tk0UNee9Ra4tjiW98ZEd5YI08xy3W+nfQPzyHza8RKE7La1Q9rz9Kn3nsNDhNJwCBl
         GdEEfCmGAGdQpEvpG3TBNfWyATjJpKsGHKcqeG7TLfBcsT0sbuSM3+41tTOkJU+vptku
         qX+FU3xzJHncOOHrnmu1p4eSNAnEs8zWEbVD0KvR7WODAufQqpuAcQgZSMm1WqRqoNMX
         zr+1BDx0LBroyHv3Q5NcjGpiUsC3nq9YZkw1Fs8T+N3ykmCSdmOw5EINYiaCk38S0Z02
         omfp2ud+34sy34PliPk8tRB5qr6Wy+poepoREW4v4AjJ/kp7dzzNZGQi10cpVG9xH/6/
         PY/A==
X-Forwarded-Encrypted: i=1; AHgh+RqdB8/vtwvyJhB2473voHfNJ9XV1St/V4V76Z0PdoU7WWosdxjUYjQwNgtmQZ7wkoCdwJnKcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+pQL+DPZM4ZtYM4cr9E5uvGRzie2MK3nILz72eeQOGZ+dsdxC
	LiCUdSfXGpCm3Qp22goEkoK9h7gpsA9hxYEgOrvEgoSrLdoo7LaOitqqyJNnr/Cu5mkKGosxrXj
	RnbZoPqspnA1YQD12Iy3W1oxiaPGr+wXYgr1ArJhi05LbNZxvQzCqLENSNQ==
X-Gm-Gg: AfdE7cmpTf4gZXsastVOkbZFfiLbMqkkfF0g/taMYgzQCVYCpU6zCpQNRt5jqdNT9Nv
	gnY+Ds0eZ7+OMiGaUkToGWYzLBloxcACSZ/knC9xCfdrsUZaiac06VCWn+4Dr3MkPzMY/dx3m45
	/peWKpWJtlB5ZEgAbFvETqRxwy5SZq4gZMuXyFe8Gj+vYRiwEZ9bKmCzBPO2/Uehgz9HmS3CnTv
	KRMhMtWNy3V18Wd+vujGRMjFhNggq6bSpdrwX4s3rXOHPqgMY1Goq44H3ymMeq22CYGwtvVZ3VD
	Rqijx/t9cQcxnc6o9mAsIhlLVRrvOyGZ6s/WO1iGCBvQSWzjpORjO8O2qsCQajpXhoOy6qEh3iK
	yZvQrdc3OjlnuszvLnLPOTjWiMmAQ7ALlWrUQ5E1ezbuX
X-Received: by 2002:a17:902:db0b:b0:2cc:6b7a:dfcb with SMTP id d9443c01a7336-2ce9f028b80mr162598915ad.33.1784124703951;
        Wed, 15 Jul 2026 07:11:43 -0700 (PDT)
X-Received: by 2002:a17:902:db0b:b0:2cc:6b7a:dfcb with SMTP id d9443c01a7336-2ce9f028b80mr162598645ad.33.1784124703496;
        Wed, 15 Jul 2026 07:11:43 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1070b68dsm2913215ad.79.2026.07.15.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:11:43 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 19:40:08 +0530
Subject: [PATCH v9 14/14] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-glymur-v9-14-8cf2cbe12a07@oss.qualcomm.com>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
In-Reply-To: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784124602; l=1011;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=HKovxLVfXVSwQAXngyNlJki7rLoRBolhkZVsnfCS6gI=;
 b=Yj06tNo9W4Sz5F9Y8NffrAmj+GAbIKN79t2NNC+0Y4uOLP55xyUcSy6bwfJTvc7P1yLclr8us
 u1O80vjjnzBAU1bFxQc8ueCpHZwWR0/+xWybbd3MF9B/1V6E7Pb58UY
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: 53mVVma31VdNhqsZOsyY1W8y1NiVqvHN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfXyyx+MnSRD+AE
 dgmuxy1IN6WQM2OWCXgbYfuXy/c1gPMtEIXzrh4wdxV2wZ5QZqg2WMjqLoc2F+hYpQzIYIDTfTg
 y0mED7wQshe7AvK7iI+7NsSwpnT8KLn5ZPKH8/rKixA4fC6mBeGOhJUzjIxpGDEGZdQ7PxQutyi
 EubM4uMkS/S63hf9kda7R6DpLyyEtNihZKYvSpe+RgKL6cUr3ZbfryMs80jLByVjX5vR4inlEyG
 mhBfUIh2KwUl93XT3tl7Y156Lskd0k1kXt8I8m98DmOfYpkYLyF0QHT+Ws0K3TgDeLkeTJ816ZL
 ftOZTzLcD0+WJC4Etu1ukcTzPj5jtt3SONH+fxWDRcMOFZrv8OWfGOmDYSElTf7QnoHGJgnyGi6
 2B//1DxDeluv+IcaUNK9PDrf0imU+HoGEwFdCadbd3uxBvDUkZ6B6VO1q3oPYWA1g74GRjSaUeW
 gd/9tHw5sqHKC3h9HQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX5oNWlcHCDF1b
 v5psbLmEuwXeaGfhUlnY1SfhgRiwpkWqM929zHd8t9GQ/fkQUM2DvHwSqAG+Kel2Ff5DP3jknBD
 wrfmkV2w/kzB61iuAqy7waDaq+7Iruo=
X-Authority-Analysis: v=2.4 cv=LbgMLDfi c=1 sm=1 tr=0 ts=6a579520 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Dn0IJEph4XI5J7oltBAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 53mVVma31VdNhqsZOsyY1W8y1NiVqvHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150141

The iris hardware block is described in the glymur SoC DTSI, and enabling
it here allows the media iris driver to probe and use the video codec
functionality.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
index b314c6dd423c..3ade94220667 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
@@ -695,6 +695,16 @@ touchscreen@38 {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/vpu/vpu36_p4_s7.mbn";
+
+	status = "okay";
+
+	firmware {
+		iommus = <&apps_smmu 0x19e2 0x0>;
+	};
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";

-- 
2.34.1

