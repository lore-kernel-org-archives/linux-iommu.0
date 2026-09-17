Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B74078E8
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621341; cv=none; b=t6+1sSG2yO1SQPV7uCK/rTwbjC/ncVgRQFdyEDBRiuahlYgDbdqwHP2YmscKRll3mNXHY63HnQpj4f7L1MydgKnNl3+oJyb84+jjg1u/+2QRVOT/j+3EBIcB+dgNSWQekZjjqrW75Y5YyX1sjz40QUujMO6wKEjmcpzoKsZuthk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621341; c=relaxed/simple;
	bh=Y9NxHc+xglkqVwfzuTXqVBNNH9QwhOHaAntxIH8RZsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFfnzUJst47syzPqkXtTwzos9dcqcExJ/sZF3KlRA/mJiBvVsDT0ARnBBf2Gx+KEBZS1QMWNJBauxSZdNAOFZy3CV5Qmc+m4uMeyYSfw7t2Wfx3QpKXIS+RDogIxccaM5ZvkaU3iNuj3Iajr1forbAb7Z/U56csFSUYqmTAKT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a0gNgBDe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MYyr+PVB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a0gNgBDe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MYyr+PVB"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GNdE9i2601741
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M3JIU2Ao7wEoQjtG7vqxKzMv1IDq7N5iVzUKdH14XEg=; b=a0gNgBDet3oawHgx
	i/i9v8FvhTE3LvDlxg6ieqWgsQE3ec+shngtIuwdHjo4hh20QrD3Gr8fjjOSzB5r
	DOlxzGqXu/Mf87CHx1P1rH/H2nQylf45U1Fv5VIK1E9Ndd/WMQGlDDTO5UdW31na
	CfTVQsZAYNW7PKkKjqn4QdoG5E15OWnRnTcy99OKmUdGdCJ09QvOaF4CTISZgE1P
	eZGcYvfto1ttQyRyo4DZnA0x3cRzostYxQv1/3PiW6Um6A+R0UoF6aDUiOAbHEmp
	fLTV+XrvT0qhlxBs/yINF1qArfuCFFmZD7DSlqlkvj1V1+BAPMWVdFHdHkIF2epd
	wdPK6A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquwb3knj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:02:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d959904658so9481175ad.2
        for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 22:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789621338; x=1790226138; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3JIU2Ao7wEoQjtG7vqxKzMv1IDq7N5iVzUKdH14XEg=;
        b=MYyr+PVB3TGK8QhD37A0Bshn+hZUus4Pm9MHOAl+dLfd+V/sA9nvLBFaR5Iu1waPub
         vA7me1BEWyefLBpidk7r6QXYSCzl8D3BsvEK+nPKHMYrAMzmEoSmyFYKHhOkkhVV5JtB
         Yfsi0qAvLk0xN1vZPyLVPqCxPiA6s9YcheOrj/lI4khvhWscJSCdkhtGfpeqwGWsGwO5
         gmd9Z1DlWbqfIVrn8QD5tnLEIT0wOW1xZIVG9Jbwj4flGb8CuRI/nb3CyXc/VZesZwrQ
         Ge2iM7k+RDgEGP3rXaGx6rwA5ippB0ITOreWn8AdepeTkgPCJVKyOXzsuTHhJd42+mvC
         9M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621338; x=1790226138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3JIU2Ao7wEoQjtG7vqxKzMv1IDq7N5iVzUKdH14XEg=;
        b=ADndExtvJz2bo2uiYPm1vXHudlDSkkB1u730cVbYnvHzucFYzg4YYPj1eSSgS/R71Q
         fAGmVW9ZQ33yhzGZ/xwPjD4owwV3TtsfL3L1//fUQ9Dj5tk7Irf5rbMr0OGEaNfigQ4y
         dDZYWZSG/P6yU+sg2tUjUcTjil/LYjw8aT7om0ytnbAUl8eYwnppgICKFBd7eMh2t//G
         8fmIOJUp9Giqzzo83r1sxk8czirCDSDBXm3hDf4uPjJ+0kW3QcavRKga0JmAy5OORoCS
         ugLJIooPN9I8CpqwprGdUhV/+nNUhrDnGYBciVMW4Ppre4etP0WsfYaKhrTgSoMmf2eE
         j7QQ==
X-Forwarded-Encrypted: i=1; AKwUvBww2H3VM3CLeSh9mxE36EuXY+Qmb+6d/REG3PGn93DzExldctVnDGWduBGthuTSd8avxKsneA==@lists.linux.dev
X-Gm-Message-State: AFuF++mc0oQ18+B3a9eF4IOTB+0yS1M1BYwZ1PWHSOuCg8VH1TdkBP+Z
	ch/26lmcp0VUiO4+umURh/rGwzdv8zlVeBe1sesZINjImPJJzGLv6KHlQ+mq2JtdDpep3s64/NQ
	sTG4r6KmFQ4nWOE2+Zba5VpM/ywUGZP0uey7rUUlN4I42aGZnCYkCzLR/Ow==
X-Gm-Gg: AYBFou1TaPWQRRe2kkC+duI1HRtnlrzLPhHDgAK+pVRPoEj36hugXkao2sESKnalW5l
	c0lLV1pP/ZV9GFM7a6BsjYuV62Kt4GB9+wFa7NTQHsPCj2STg5C4Xkq3NTdJIrdAy1wC2QxriJN
	hjEIKgZxexvGt4JGgHwqAXACgRx/WXFucGFmToej3yVNsFSvqx2p0DXjlPbeChKsa4ykMAFbkVM
	HfIdU9CF6aCXGu7lSL6nt8HL/QXCJ3+b/iKio9YykWCuEwTRLPPYfXOeOKgnKrnmOwe/GYl62Yt
	JPLz6eIA5/MVQnS1UW216U4lCj9xqkf7FUxw5RtTPrBNpX+Jhi5CgWtHqJnq5aU3nSZwdEKaXkK
	qTXBQ+JodNqM/glNNl7CV7haYqEqFcpEfnA==
X-Received: by 2002:a17:90b:5785:b0:39d:ee20:1e2c with SMTP id 98e67ed59e1d1-39e1e5042famr17381499a91.18.1789621337769;
        Wed, 16 Sep 2026 22:02:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5785:b0:39d:ee20:1e2c with SMTP id 98e67ed59e1d1-39e1e5042famr17381376a91.18.1789621337310;
        Wed, 16 Sep 2026 22:02:17 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b2753csm23544223eec.31.2026.09.16.22.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:02:16 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:30:28 +0530
Subject: [PATCH v11 9/9] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-glymur-v11-9-e0c8bc914742@oss.qualcomm.com>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
In-Reply-To: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789621265; l=1017;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=Y9NxHc+xglkqVwfzuTXqVBNNH9QwhOHaAntxIH8RZsI=;
 b=3U56MsFfuNyaH5fXTSF+gKX7NCUWQjZAG/aLF6qAe2JljJI4XoZVUwImGi0n+tjqEChuaW1XA
 KhWEvhcURLYDHfPTsVvgXfSCm5/9I1hcbsPjq5bFT0MSjCAL/G62b24
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=H4JOUOYi c=1 sm=1 tr=0 ts=6aab745a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jls_Txh2LmBa37OkJYYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: bwD60xELjJNUMaS2xrcC1No9fD8BiulR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2MyBTYWx0ZWRfX2X5pf+lI+2dE
 WZQC/w4sfTN1PiHs1nmygCBdZmWKWFqxTReBcnnURkED05TlC6X4ifIqaAG3/rFHW9SuEbMc2WW
 QB5pUOpABYoRBd6jBpjdKsvDVFWUHo90I2ae4PhFXhGB1PqInoj1r3QKnAomyVQRZn34LUDKup6
 sY/cV12J8W+OSQq00X+wrn/ybrdYk8lUZsBKQL7yLC+2+c6DYQPfQh0phiMq7gRwfRi/KY1wckF
 brJICgBL88RlVcOnoM1r6ZmiCH9utiLTOJKovdSuYlRF1tdVJHRNseY2oyT/v+LJMrOspMaTLXY
 EqB57hbhJ/5I7vN6YiS1FH5KoJZbxdr5xSXT3AhDf1BoLfhHFKVqy5zhQ+w1wyQ6yav1bX605wG
 tbyI5sRfENgMezTmEe33yOnPjfBi4Wn6mYhbBy7Q12NNW17D45/VSGPaDGo6nG5Z6SeJeQVQ9Z2
 ZehpgrjTTYVZujdh1TQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2MyBTYWx0ZWRfXw8rEUI4Pc+dX
 eNpRaSsgVPOfexHwjObRb+cAOr9Wof2g4nJ3wzKmwNmRSNQZ4XHMX6RyMQvNpcdDOcTC9B8d3he
 wrK7kBWfGcbrVNB+O+BTc1iSAnGy8+c=
X-Proofpoint-ORIG-GUID: bwD60xELjJNUMaS2xrcC1No9fD8BiulR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170063

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
index 4df3ccfee106..df36e3ba9816 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
@@ -694,6 +694,16 @@ touchscreen@38 {
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

