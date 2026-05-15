Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FC47F2D7
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844300; cv=none; b=CHpsZc/eesaVklo+AU1yXRCfqHClH4OGPM1eJ1sEJiOf7cj7xFuM+sCRIXBILwN29kQLu6Xs8Z1ZLxXDuQ5ZroZ0bQTNWF9JnslroHTO6fGy8W/BxEkvWFRJFcPHcv96O+ZG3STv6DVmhCrqiPD1DgbpWhhRBCNjCbECKpu/OQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844300; c=relaxed/simple;
	bh=mB3ax+sGyD+thy/S+owtTT++uI8XjdDtWOIrFE8Yvn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DoS62EW5dNK3KvtHNCiudO0vINPXZHDOM38wi3EyFeRMJK3+mMniA5wrZ47Tt9TCVLr3IDarLniClpElr/+VVMLSfU1k4+yNs4JpRV2tCJavtCq7EiQ0EEnmLCgC8/2KIQpjX35N9LqYRihthZF3Hz9/tjSwH6qhlmqSQrHqN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ugvn8ITM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QmO9CVIX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ugvn8ITM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QmO9CVIX"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBAJ2r3795527
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hICxZj15kBmkUDSg2CSx6+F75VQu4k37C8p6b0IsqL4=; b=Ugvn8ITM5bq/Ebp+
	XyzKfxVb7RJj5ZGNRQMPY+/xmjZhho/aQvgBf9fa+Ce8LN/47s0yUOIRGBR5FFBZ
	K5qNAnzd2lvSfSyGvbhBCcm/Hr4N4llpW3E/EtO0WbcpoeCRutAwfzNdEgJDmdmi
	oH31Sc0f1izXsL1INrtgQuYV95larZq9itsg6aAGWfF8ovCZScBGw6bYdtpw2qae
	LI23anlW7IzyHP9c6+lR6VWFbx5WF3z85KWj4un6bzCbTb8RpGUNQJ7rYCcpfaiG
	ERNd+zb8haXs71W7yo+K2MoV+YgdzUdyvOHl+O5eqeO0+wj9YBZg2sUBKkwwdXm4
	D0rD5w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1styhw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-368edd5fec4so4563918a91.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844297; x=1779449097; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hICxZj15kBmkUDSg2CSx6+F75VQu4k37C8p6b0IsqL4=;
        b=QmO9CVIXrdwcif1PCoyOw6P0ZESmO4/YkWkznGndoWDcf+Brqk1K5Wd0eg22/VB/Lk
         7d4vPWoyJgHM7hu0kYcN0veyjSXoW1Nf8eGD1N3bjO+M7P193opV9hJZ+gWCrjITJOVT
         RSwucfljYUWzv90U5PwfsEaI7YgfHvxpyv3oKlvf9kWWNjIumAJyek8HBAW83h2iGPOv
         r9H/WAtrV6IqQQ2S9puyiObvPjVoAgiyJxN0DGdE9tIAD9dBx03msVm0WRY/sAQ1KYGW
         UwZSwZg86Sa4uH2royhh/Tk3IHieFLg0q/xo/wpRKE8HIgfzicnAm1SAKY5Qej6Xngf1
         /+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844297; x=1779449097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hICxZj15kBmkUDSg2CSx6+F75VQu4k37C8p6b0IsqL4=;
        b=dY1cNQYZnVsRhodWDij2TrpsyX9NLc9uGABPF66KskoSJfGb8S2f1JktgZEje7Ofh+
         kDEpnyUpXz6p9UyhOkwHJkoZ20quzzbErqPbqqyPO4O1JDLuf4+HCrL4B7+vPVdBQ4up
         JTjeS+ZFAEGnLl6GFpSkgwikylyJ0yl2ViuUnPGwtwObIWS4n7Vev/71VNPwKxcOSc0D
         T91jbpxb70vtiziJPanrwzp9H3L23E15YdNsAkC1IAKy4zXEVjt8uLi71UeHAEPeM0El
         MsnO5ySkdhZJ/LnbLn3C/SBZiyg2Ut25p4wl2qU+KzK8h77fw+Cv4Ui6sk1jtzHaA3j6
         SrJg==
X-Forwarded-Encrypted: i=1; AFNElJ8oEFXv2bwHAJMY+7Yj7RLt2vD5QV4XUJeAZcwWaCB4nv7VnE8n3QvMAr/UASLNlL0RzLX9uQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzrpw/OPFmkq95A+jxQHM9ewCSnPW8+mgAOPtLxfytM1l3MKb3g
	M3BTk4Okv7L38LhXABtjzFfcfhin5nF5hcbqEc/mAHU4/kreqQDEyvP+41KQLkjkivuZb8m+PbV
	Piu3dUiLlUL8FR/f8N7r5+zDpTe1YgsFr/f5iR7QaswtZhX+2SmVz4w5DuQ==
X-Gm-Gg: Acq92OGfM7iVxuWrSRG+FKSpBptmdpKVPOcG8oBXSTuirFOTMXXWuVcBTxOAa5XCDrk
	tZtTk6RQYfTzl9k9HznBh3phM1+/n2Ffq75tnHzY2QMwcp+tRdjR7QCoLjZqOyYINxz0ETeprxm
	S3K9vl1B/9CA/2zlP0wvx21+0Y8+D0Prmx9MBlOjHUby+jvedponJ/eFuZxi/9FrhcIzwnQgXV9
	ZneHmtt27TkQqIWNLrbUILEM50RK5qHY5Rtgluts9ZjAi1MHyX6UtzGxwRvlFPSR66lwlLrxJGX
	pTSiY7jSVQ1Rng1lopYQoKtLU1OB+KxDEdYFJ80pEqXv3O51S7CCGE8+jgoNcFgpZjBAjnL1wUn
	DzGEa9kjZXTi1fdKa8v9PGCCcKgf4QBDjWwfORFp/z8GIprnFKL7hDzY=
X-Received: by 2002:a17:90b:58c4:b0:368:b4a5:c4dd with SMTP id 98e67ed59e1d1-36951895b63mr3507724a91.2.1778844297051;
        Fri, 15 May 2026 04:24:57 -0700 (PDT)
X-Received: by 2002:a17:90b:58c4:b0:368:b4a5:c4dd with SMTP id 98e67ed59e1d1-36951895b63mr3507692a91.2.1778844296564;
        Fri, 15 May 2026 04:24:56 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:24:56 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:29 +0530
Subject: [PATCH v6 14/14] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-glymur-v6-14-f6a99cb43a24@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
In-Reply-To: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
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
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=828;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=mB3ax+sGyD+thy/S+owtTT++uI8XjdDtWOIrFE8Yvn8=;
 b=PkZtwhvTexrUnZWWAE21Y2y7ROg0444tAsb/bRuCRc76y02WUWY7ps7jFUEMVmPTgL1iUL9my
 GGaPgGvD3bDApcsPuObmhs21d4H9/RAnJwDeZHTK1P7mtZ4A2GqU0Mm
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfXxLxYvZaU1zzB
 Yw8PqIIkuOqJ8QUHMOOvIUF5VcXUhbmr10uoahZDzwOa+FXoCycJJWlQThRb7Q16/qnkjwK5XdW
 yznvrukhd4sWSXwaneg8NyvEsfn2BAGq2OPeRu+1FWzC+mjVERlaFcdh6CmIlCr65qKTXpistgM
 Ma4x5jvc8DNjs5cvcuuEj7M7Ioh2NHBrbp3+wlvmur+gbKQZpQASCzID2UBxkSE4FPThoo6KYnc
 dyGT1Qou8twRb4AziYAwTBvFXCWl04Hmz2t1iCepvNKjYsDGBXCdkhFZEAQSZxvpUSMaI5EULkt
 lbKZZDDtDhnVFJXHtoiwFhXd9i8XsRiigVA843pcjuE7BN0JS9uDK4GAK/U0qODIJjxLjY4cRpn
 pn68xwQ5xJE+baatAESZIUQRUSkB42htRZUwcFjMtvxO8jThCQgdknXVB4kL11YIHnYlwlWoRKK
 iorbz2QkS4CxKKvwrwA==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a070289 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Dn0IJEph4XI5J7oltBAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: SYnpfWkWuP8PxepOUG4mJkks0jB9hsPE
X-Proofpoint-ORIG-GUID: SYnpfWkWuP8PxepOUG4mJkks0jB9hsPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115

The iris hardware block is described in the glymur SoC DTSI, and enabling
it here allows the media iris driver to probe and use the video codec
functionality.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

