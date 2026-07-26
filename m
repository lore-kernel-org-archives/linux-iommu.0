Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB0353A8A
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045132; cv=none; b=LQ3/Lp4KS878LfxwEFTCGzmnK6D0nY9SCe/bGmJMgkbVxwcNiahS/DVCD85E0YGaRDfdBsdFRTCcsPvpUzxbfjU5EXXGOLcBz3do8O3WIdjbCMIrlZTm8bn9fx1fLZJ8dSGJWLdM6Ma+SWx3Er9hzhhjr6CAE7BvGGEMatgTVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045132; c=relaxed/simple;
	bh=QMtO0aaK+jEwfLoS/FX/xRFAe8jOcUGQ12dvcUB8g1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOmencpFaN0MDTneaIoNZTrNUayQbDIUWuPxpDQ9m1++Xp49p+/I1q1H2zN9eqLJ4TveAZvCH5EDB+e/qe3X9Mz+p7+ranzdJHp8OqyuXG3Chjc+o7GlSJxHKFvCn+Jx9FSa1gTQgSU7XC8GCgAmUNJp1DgENLelu/BczPnoCaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K1GwRksO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hdrmY+Ir; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K1GwRksO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hdrmY+Ir"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5RDYG3722615
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bMCoOHF+KRjaR6jwkz18K6wWxQZjA74R5y1B2yqirho=; b=K1GwRksOkSEVHQXf
	5n7T0MfRhQat+SBW+pZX39b1mXmF50QS8Ch6syDFa8piOfRkH7Eq1H12dMAnUETF
	zOtQ7FGdTfBK/49ilvEdf8uZfImByCBnkxcucc9ntmpzU25T0ewwNpnhq0o0u5C4
	IGJyYAEdouiOhukhIkmPzk3nfdGRgDoEbMtBa6q7T5gNEKWCSU0NgGKEMlM/EX4j
	xCOon6TmSt3+VWIv3+HCuz34QAgVXTahfV4Nupq7aGVkDQDelH08b7pSpaOHN1J7
	ppQIex0+eNhnBQt3hWn/cJ6qDMI1G3YS3mqB/niMUJjVtHYNP8QCDCA+F7yGlCIN
	aausBA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpeea5v1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:52:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbbb9c9bfc3so431503a12.1
        for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785045129; x=1785649929; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMCoOHF+KRjaR6jwkz18K6wWxQZjA74R5y1B2yqirho=;
        b=hdrmY+IrZI9UMlnyT1QSSR2NRfD54Pg+cWK8XKHcQsYHqLegEEnGWkQ+TL8sVcQSMM
         sy5FRF/mnp01VWtUwc1atXNeHRl9fT6dhgzli6VHwsPT1uUWkLAgpevgOtFYwyLJH8wA
         a+oaFmwpchBU+6b9FubZizJVL+fjiLI24xfqJMolI7KTcuW7q3W4ayaSSEp5UawbKrD8
         Q2E0M087ZZo7U79jlP/ReBqYqc1Ts4syQdz5fVilOlEk7vAXN+QedW4OU1UNjw/416xz
         yHeRO36lz2nyZfL05q0zxBc3p3e+ekHSakp7y7Nk/DEjM/c41U0Am0ST87P3xHfyhtLS
         B69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045129; x=1785649929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMCoOHF+KRjaR6jwkz18K6wWxQZjA74R5y1B2yqirho=;
        b=ngvHaUISNciKYQx8ccESayAMpn0e2r14rJEHdviXdlgK3dj2VhRE2Wwwtkx5f+pmhA
         GzpxBiBn9p2TLO2Tu1C6JFHvUvwcxjyDfbll5EkmOnH/ZUvNE4a4wlTTiJYT8rh7Wc53
         uZDrZPzl37Kn1+tivmGz6Y4/sjlHxAtmVrWI1YgemmeXLWQpyAI9khZ1sznx7ZEkXqOF
         ej8ynAtzgqUudmSuDqqG8ylUMHnewCRCSnPObQm03HunObHo+XAn/O2ODvTe85p7N0sv
         pajJKhlJ0SVbhCC3t+2mS10MEYG3JmsMx5cew8+ThLrZxlHHTXMtlP5JuJ+OcnaTWeaX
         7YEA==
X-Forwarded-Encrypted: i=1; AHgh+RoF1qck7RTeL5Mh0wqqiKq97QLAdqyu/HHGgNWmqKueBjt/lWSkA3TnIZmFUUJT6rr+GqSBWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyovZ3ZGp7Lk3Bw5anH1qmUCJxSUMwrbjzK4QKwAGdGRU8Lu8NW
	cV5fMZsZJcaKxnTXv7EQ1oZ+Uo5/TlSgoFiQwyar9Fo57/ExT3rdis+YdMAJ2BvuSUb/f1x9XjS
	9AMEuZ1xN/HBDqmDq8OBmhCJa39nimUzXz8X4xCpwosdvWuwjUmAqgVxbuA==
X-Gm-Gg: AR+sD11jFtgFApYkz7DWND+fx4FzEg0voznfz8Yz0SZ+OGOzweO0ZyZX2J106BgaFz6
	0LI+cNwDdxrBkdI4xutDmPcB8AGF7KOIlzrSKS8GssygoBmBXTww3VuXcUmUzJu5HvIFh3/lj40
	K2Ha0MtlVmZlif8o6Nt+uNMvn14zNCqhowuM63awWaaFDsRQZ+6gOibR/WMquluk5r458h+f/Ax
	0/Ye+WeW7B2AuF/6Xrb33RQcVGLspVsryye1bnpa68AAAQ72nwmXTXuKPQSU7RzOJiUrZnOhmgA
	M0cXJOKeIueBy1FEf/mjawqtRPOEO2EiS38k0MzLhDYTvp2mhJSRuFsFlnK+mJ27abCkuke50tV
	nBlEVg24tPIMzrhg2gIqNAUH5OdUk4djEbw==
X-Received: by 2002:a05:6a21:3393:b0:3c3:b57b:628f with SMTP id adf61e73a8af0-3c67df285fcmr4613012637.48.1785045129484;
        Sat, 25 Jul 2026 22:52:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:3393:b0:3c3:b57b:628f with SMTP id adf61e73a8af0-3c67df285fcmr4612994637.48.1785045129054;
        Sat, 25 Jul 2026 22:52:09 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm67106334c88.15.2026.07.25.22.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:52:08 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 11:19:44 +0530
Subject: [PATCH v10 14/14] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-glymur-v10-14-de451559e88b@oss.qualcomm.com>
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
In-Reply-To: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045024; l=1017;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=QMtO0aaK+jEwfLoS/FX/xRFAe8jOcUGQ12dvcUB8g1Y=;
 b=k2vmy+1Hvs+i3tndHQiZE3m0r+Wru7GaVIqoEaaJnGXwex8ucR+WVe9BqSpoha508idHXhkC7
 0jlWG27zHZBAwhrqnLiZ+0Du0lmPXC8wakvmfuDl73IGSbaA4CEy0LP
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=Jr3Bas4C c=1 sm=1 tr=0 ts=6a65a08a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=jls_Txh2LmBa37OkJYYA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1NSBTYWx0ZWRfX6bJcY/1by1Vt
 AEiSD7AwRcPc7UxPMnM6gBXwl4o+Ef1bXph2+UlWK/LmNwrJHBDmeOKnNX5398W9H7B3fo0NfYh
 vzg1rlon1XPqt0KeO1BmBngYir25uxE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1NSBTYWx0ZWRfX0EAV+26vZP0L
 aaKG1bDaJUTQ+DoGRqwAqqdXQYEo/glTJFwWe5pXQBF1jsFAOi1Zj0HI12l1ov8tJ8q+WS3LXjo
 3MTj/21rsxcaubgqkaUbAK0Rmx5EaiUhfVrLmcJ/Z09O7AB2KEJPLOGAKym8nOUJvQD5/Ts6Tt6
 qF3OHvIDsq5kq3RhmwhNJpkSTnAP+v1JoTefM671ia0LntBFrm9aM2da7L7nSwTmAqvl51BNT33
 GXp2YH32HkoAWMbIRKmp5MDhvrCOzOl70mSncjt27jgH7J7Vsn4919az3LknZPE3rtEsgKceZLb
 pa0hlLRpTYTCozpdTDDXlaa3KFYVQYplIArqAiNLXOKtmD4BgoWNNzrBSXRNqhlk/5xU4KR4RHd
 ALcBIxeNJYHXxMkmN8IZ1EJd6ICDienafQ7GBXT0p9A3fxJrTllHceGVCro4P7vBSqGHei71hA0
 KZoTb5bi1cCzcMKqrMg==
X-Proofpoint-ORIG-GUID: skc2W2USpExmxe3n7AqJKJE94xCuCppj
X-Proofpoint-GUID: skc2W2USpExmxe3n7AqJKJE94xCuCppj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260055

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
index c12808abbfe1..b8eed6e99588 100644
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
+	video-firmware {
+		iommus = <&apps_smmu 0x19e2 0x0>;
+	};
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";

-- 
2.34.1

