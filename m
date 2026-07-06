Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E666436BDD
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357034; cv=none; b=OLMCHWh0UU+YtcZv4alYMKnc5LvBk1B8B4T2MRBBm/4aU5RzjK9PFeVq0jFarQ0/c1Lgq4Hw9CT41497YhyAP+yaGx7MMUSYNXYV8Y7soD4RuXlj+e3LOxHC5KwcuDaYAMTH0VETtFDEJVLi6vkOXjcmj4Hr3H96nX55NGT0ins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357034; c=relaxed/simple;
	bh=jqUN234mlgaPq8CBPF9A9IY6049dMha0UkLsYYR2Tvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUh+pDIECxe6Cjv0pRBqTNXJKjf6BUigJ3YCkqRg084ub7jsmpmJSbap5asMLrh/VQJjb6I0YHLz8mwphXy9w7HSdTep+awLc+xhyga7ZOcVbtrmdAp6G3NR7l7Z1JxxaBh9a1tPjRsIJU/NZiJNCyifLZI5PhgCtCbccJut4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RhQbgbp/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NtunQWeL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhQbgbp/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NtunQWeL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFDkX762353
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 16:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZWIz119etuH+575UYAm8u+FQxHrd3RggNnFu04wufqE=; b=RhQbgbp/Gc3Cw2k1
	FM+795kU1npAxorRu8Ca/uqJcSQZP0gcrzXFhQ2dOBIbEEbC+2+EYyhd0lOSrPp0
	jSUc47Ilph5EI9I4oOXTdJtKRcitfTiDnMJucWUVt+kr5xGDI6DKpdZtOxbk3Oh2
	psaBQ6AaHmmCjO5afJnSgvPzloFBJISWQyCKfS4+aeh7fhrHkTzmuhZpKXdsyNsV
	Ti3jhJVyIwitGgAs29xe2a3gTBzY4XmdLGBfS0r9Ok+uENmwbl8EBIcjCltytoVm
	JuYDTVMgoVfhnV8dCq6mdTPPqD0y5Qa120MKngGEbma8XcFJ0daQ0G2GRaI0Aweu
	il+ltQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxtm83-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 16:57:09 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c89704da8c7so4999158a12.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783357029; x=1783961829; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWIz119etuH+575UYAm8u+FQxHrd3RggNnFu04wufqE=;
        b=NtunQWeL1BU1c+7GrmzqzxBr840r6xK24LMsgr5KIqXlLXu8tcdOG6BkYj9OoupMZP
         W3Fo6SB2lRfiaD1rLksOCeuLcp5fAMZhGhTM8QdovOnA7RD1/DsR+0zs8kjIfkrfPnkO
         EhtE5tbp6udY1gxjXBrSPfnxhrU7hLZ7uOeDm0XeYUxJgnehED+czxzC4E5Nzhlu6BsL
         rfrXFGj0wNB81yo98/V0UcN08sNNsyWm7upSEtuO4Mes8uEUV1iPw8jp/BFOLxFUJ9jK
         LJFegVz+ISZyA+qBWaYQTAgE4WU4pVmAM127GCTv+/WkBzdLolQsePm72+r7iR5F/XFq
         6a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357029; x=1783961829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZWIz119etuH+575UYAm8u+FQxHrd3RggNnFu04wufqE=;
        b=TGeBtJhAhCCdv/VE9vRQHRjz44D1wf+mNg4OeSDJ5Eth44z43uyDFUXnzUW3spRy64
         fnQQgZXfhMYFt+kynIpPJUJtC6XRLOGSyFPf2Cvp77Ut5PGx8X//JScNVkiwZq8eY+l9
         vlY0qOuyE1dkMOWjtpeL1c7MlltcsGJCVW2GJSM6Kjl9vtPoEtawHyM0XKfVN+tAqfU6
         ah7rXJUCWfFnPm89PtasaaUJrej6lKIfuCqU8/BGKdXBJZHA44XHN3UwvDmQh/C9X8MT
         yofDc4v4UxnVpoJ3gqrVZg7LsUEeI/scuzPt71Vg9AolvQGjrLKi1FuDn8r2Bj80h+5p
         9bNQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHaK1WLHGmIoJDpx9dqnVE/RJSLnIiVhElj9qBu9AB28tINBDJKnLrMkAaFwhCoIn6Dj3Wow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxobibvvu/B18C6T/d/A6eamsN1WrHUDDOfUX5U8zSGAc9YTXya
	s3mU4hWI0x/24qcB36ZgE65d2cu2GYSbY6Zct1N+QT2MLvjTDlNWRSuYIh7BT+zkCo+ghyp6wkt
	/CMwfXL7u4hnnEjhQVf5fAfcQ4AvnBoJPOwymBxqIkowhXHqLHhxjPdAsng==
X-Gm-Gg: AfdE7ckgsSHThgPi4GG1+id3WgChU491yKsodIYGDshjYjruEhK8Jj8PlzDmAZ2H+oF
	V0WwlS/7vyntpyVg8njwOgra5utLUvyClPmXh34qYE/VljuzSD9+0/yhDo8JjhhEl7DrWSLp9CF
	KNLdJwqfjsCWVHjFSOS4PYfSqL+Et4rJN3TI6cwypfAaIGzaIEiWjz6c5PoZzJYFu2BuL8VLEmv
	iY/AnrlND9BQR6Jum0O6v/FpJ99bs3yJS2CcjsVgEZ6Z73DukScVm+UmiP+BnYyXy3sA0b34rd8
	6zzc/1qeMk/R5Jr1iB9UczfaltiLnMheKPCzisrtYru7n4lyiokGUfpcdc5wUEVqpUejQwWXGn3
	FCpg2Y+RkGEvJWBhjxOyeqRB7jiQEXR2Xr3oGKkVzfQ==
X-Received: by 2002:a05:6a20:914a:b0:3b4:68e3:f16b with SMTP id adf61e73a8af0-3c08ee0dd12mr1703390637.25.1783357028893;
        Mon, 06 Jul 2026 09:57:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:914a:b0:3b4:68e3:f16b with SMTP id adf61e73a8af0-3c08ee0dd12mr1703368637.25.1783357028421;
        Mon, 06 Jul 2026 09:57:08 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0efc8sm6960604a12.5.2026.07.06.09.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:57:08 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 22:26:37 +0530
Subject: [PATCH v3 4/6] arm64: dts: qcom: lemans: Add GEM_NOC interconnect
 for adreno SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-smmu_interconnect_addition-v3-4-afdca0125a65@oss.qualcomm.com>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
In-Reply-To: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783357002; l=1066;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=jqUN234mlgaPq8CBPF9A9IY6049dMha0UkLsYYR2Tvs=;
 b=1ji8Ma7hdzOxQlIfqJxCYd4J3ISJcrVHCJl+oAGjgiQX8DpK+re8r+OuerLb9O0po65oAjDV3
 yxt38Erb7ESAe8axkhSI4hc2FzLqGqjsLkh6UNnFGO8TVZ8yM5p+i7S
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-ORIG-GUID: 3Z5xXAYmhf8LDBlPkQP72OJC1DlGgZSc
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4bde65 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JCeWlrImN8qIMoXkfH0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfXxs28r186DVws
 iq9+8TRKMrCl0N5yji5mBIw1ePGWFoobKXA2tx4omp9UipyU27/LSKUwf2W4GoeR+sfjFU9cFms
 qRv4QQRkWUsEVQ50pKHwHRILVBrHPY0=
X-Proofpoint-GUID: 3Z5xXAYmhf8LDBlPkQP72OJC1DlGgZSc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX4nyGDNfbEQA9
 LjH6KUW7Nd6XkW57aD7uI820d5fX/OIYAmLOrgvBlCO0WAkUfK7yKLxh0XtZE6aFMLJWIWk+cKY
 MBRiqsqsQEOeZCZcWzLMEJjaXY222qxVtZzgrb0GF/n9H+vF0BN64ik+HXC0qD24c/XCForAjc3
 5l09hy+/vkoWzzlYNhKqlDSIkC2cCjhREWfDVOquzswkvPd1AlPlkF7YUWDQianHUFauLDsTqZH
 XBTqHd8xnqLU1SXzHeIeP42tBFPOE+Ma5+Xo/AGLhdtSXmyeVeyNqNQ/jQ01CZgebjj6Ej0p1YR
 dxSvcXiglJ8Vq+6G/l9DyeAsaEpvE+pFEhAli9uDBBSaYlHW8HvprxkllSLObnfBVK453cyuSFc
 RLM3M4rDJy+N5YNLh7FufDLl1iZ2Ofkyob4SkIeH7Z4GZi0DpDrVj/9q3S0/eTUeVABrnXbyQ+K
 ZhS5wXekh7tMVn1W+vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060170

On Lemans platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index a10322c5bc35..167c33d14375 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -4809,6 +4809,8 @@ adreno_smmu: iommu@3da0000 {
 				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		serdes0: phy@8901000 {

-- 
2.34.1

