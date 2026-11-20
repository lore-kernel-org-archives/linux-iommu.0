Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182233;
	b=souiKkxHwc9iFl6H5NG4qsnhsgOU8fesNZSRfTQRQch3Xc2Xb4WkLJspZ2dSll6EU4la
	 wYtvaLeqAv28xP0hUPjYkcTaWu/9D3Dbjj4VeG20e/sPnr0jySxDbqrDb1uPshCceWDsf
	 ssHIrI8YRB221NIOJE8rhIHAEMqM9BRx1TMv6ZFNCjTB2L5Df0kWGVOHCgqywc7AC957B
	 GVKvkoi2RM99/hjY/AsLykmaL3CzCxh36nVzWi0R5DxuqJ3uxle1Kw5BdDCedqAm5UTFz
	 lSNuAA1xPqYpn5079bRiIikyemB8upcdWVGj2Te7TBq670iGEK8PkhOLUXh0K0UhTtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182233;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1n8AvJWAPVamnEVhs0wyLEjCYaGptaUkE4x1OLf2QZA=;
	b=hQQQEg9S8SRSWXI/RlkOuNXPuJEV/HuNE+7rJ8kxEwH8K+VXaTVzG0NkbsCtIXombT6V
	 B6mjTQn/LdtkI8spkmPVnBqAGYHaHV00IDkQcYIDRtJub/2qcnzfN7Brvv0hhtPCkRIK2
	 ck27g0MM3RECbb+lDFJmF2Yo+gqMwWBcuIJa2l9daoLUUWz5zz9h++Q+sHkllE6mLHLZ4
	 MenYBTAU2U6IYiwaua8Rirq29G849fhJrVEawf/aqmNrwLdzPS1pCg2YHzu/6cJ7p/+MV
	 RxsSeiQmNnXrDSa79XHIpwDtHZxiQVM9BayQ8nVZZmjQ7stBJu2I/tgn83pcwg/T3rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=clk3TyRx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PGNba8qy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1660A3836
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD1660A3836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=clk3TyRx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PGNba8qy
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjqV91681886
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1n8AvJWAPVamnEVhs0wyLEjCYaGptaUkE4x1OLf2QZA=; b=clk3TyRxsqGpmwKH
	lXFfHJxGFKAo+2t1b7eu0FhmFz8UU5VLD0pn0BT5PwOd2Su68D3lc4U1WMgdM3pC
	TXHincv92LJJFagvBU3qxroJpby2qbjx3xHsqWhtYE1JLn4ReJGTWF+UIDUP04R/
	faja1vhBDAakHwDXpepD88lWuevZi3lTmylUyxCBpqFHm54oIHDKWTTOs2R1ffcl
	ydKhBgnJVZuNfYtM3VCStl7C5f/gI63pR0/hzVaw4gI5K7IrxkyykCE6QqaDUpDW
	yYSJzAM91z2nrVPn24bTgOOCGw5ZnYgV/fVPZtcrfOu3tVWzmeE7lIyw3OBKc4pf
	1akSlw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1tqdg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-370230d93efso2856536eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182232; x=1795787032; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1n8AvJWAPVamnEVhs0wyLEjCYaGptaUkE4x1OLf2QZA=;
        b=PGNba8qyWgze0UExRSvfH+QYTI09vwKN/cw84PgcpA6v6N93NI8acawkYl6VNpvDZ5
         rzseZKcjspflB6QBfiU2IKoMIuFsGtu2dtx++TXoHwvOeUQ4RsBOqH3PpmD/C9P+DD1Y
         2pt7c3a0MRWGLfyDvTAIaGf0tWaMM1yEMFsn2pSZSdkZlJmSbQVOL+oFaI6Zja5RC9nY
         kfBeqYc2wENsJcVEncrDwxCOPtSiCZ0h6OUMFQuTTJcpcevsWnuxLPURDN5H7v4H8+JH
         X1DuCNrhSWNonYHVY3i1O9XT97ecwFLyNjkzWtt+XEQkQHEkuEGLksvBkXkH5McwPMXA
         g3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182232; x=1795787032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1n8AvJWAPVamnEVhs0wyLEjCYaGptaUkE4x1OLf2QZA=;
        b=YMC10ftmas7efD5VUWBrR0eL+WxHoZQ0O05alnjrPPxILKUCjqmUqVdZDg1w2BgBwr
         bO/kXK9QnmCjDHOoLrYx7ZC1Z8VDoMdLuxN9laJe8Qq9V4kLjcl6G4uSZ16TuI0SRFaU
         bdV18HPhUQiz6ZzuRXQLJXV9CwYDRUeXrUsurasuxm67e7pKnR0/qzbiCLfRi3pIdc7q
         aWOxMUf6C85QIvxNKxrsz7/X35wy1NeskTLtUTyW+fhrfmjR78nxrWOQvyxBt8VLcbAz
         Ie17RQkCINXoy8kh4v/tcP79zTW+rpjJEOCW5ytewYe4bSvA40XeUVRlLB0arj2FwMpq
         nUUw==
X-Forwarded-Encrypted: i=1; AL+hErGvVTvk86x9OWxxLjECUkoa+u4K9HPAZ9e00/Xulh1CALNLT1s6tif/k5ISit9+n8dV8OvVMg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+KknMVTrltRWD8q6LnWzsGekZ/39CIahsNZOjgOUgYJtXFOlDF
	CKMQv1Vbn/l2E2/oCwv1FBMKtueUg5KZbarKwzasnB89oHBNPhDe8wREEX05l7XpLXhNzo9jYa1
	UprhWMWItr74HOhK2wOnxsuvmh/rkY+d3I8WQ597/JIdYTiHkEDev1jp/KA==
X-Gm-Gg: AZFdTZdvP18zyknBcptti/GCtPh0OdhxQq+llHz4+RchwkxBn4ocnmCGfwkPTMPmlXK
	mIbiQP+0cdALf0vo938kKhoqW+oX+yzc9dny+favyPHSF/M2UBlul2bBD8IeKVSzPQVAUAP2yr9
	XvR8sBcoA6JvWucqYRH3A9K+TjBKVquQinR93luNwKxsY2rh+Er3q9kQTgTeErZbvBPDMgU+mmR
	Vj7/fRywl1J+fwb53dbTQ79zeMXuz921hUl79bfTJu9EqrJGOtspILhA1mHJ846Ki0SduLn5lXY
	NHIzVhhwC8NYYMkWbfZ5/Z1EEOm/Cmnl1WGNTOdHvRNrUXnEUfyjyVQYFEF2y8CQm4zXLNQ7bxe
	RNyr3jcn2yEMVSvkaicQBEwrmJB55hrMeA7adSi8c3etAsd8QJfmoFjOrHIt2Bwn9bDKjalt79X
	9BuE4=
X-Received: by 2002:a05:7301:f23:b0:370:a11f:dcb7 with SMTP id 5a478bee46e88-385707434a6mr3031615eec.41.1795182231746;
        Fri, 20 Nov 2026 05:43:51 -0800 (PST)
X-Received: by 2002:a05:7301:f23:b0:370:a11f:dcb7 with SMTP id 5a478bee46e88-385707434a6mr3031568eec.41.1795182231051;
        Fri, 20 Nov 2026 05:43:51 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:50 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:47 +0530
Subject: [PATCH RESEND v4 16/20] arm64: dts: qcom: kaanapali: Add GEM_NOC
 interconnect for adreno SMMU
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-smmu_interconnect_addition-v4-16-be30526391d9@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1086;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=VBW+lAkn36GDWfLSpCvNbA+g18nHUbQQFlmvho8wcKk=;
 b=Fm5c9lgr4dbQtZ6J15zj9ArLcVgsoaJbg8eXgfGxClImKansogbJQoCBmf72JtCS7ZdNH5yZU
 9syPd6qmkycAwiyl/Un5MoDMHOeMfsWOs5/rFq2iL1qBF8PoemaXM3b
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6b004e98 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=iVAGZxyPhfMzDMBdamgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: cx9W8M4F0z1bPNVlUiBTMucvju5hoKaO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX0A2RIPejEtf8
 opUKPufw62pyNIYgaMe9WryXHPjzgoX0s34x23BKh9NA5TiJxAPETwvOV9mWfIAG9VXHH+cktSQ
 Cz0IRz8GEri+Rr3Hf2B3BPekkQcc38rVd2nP/USrKeddyC5bmV/KxyUcWi+aABgjO64tfTIBC1Z
 kbn+qFhUlA33MdhIVAgZCQZpxYRpnNyKak045saV0h/i1XkwCihYSExswk1kQmQ3f9OYuFkESso
 PNAEADXULlQDGzgtzQnN2eFQYS1ld3mbyBIsfm1CEa88QnOyshC7gSys5eTTLrXX2LqrH/36ED8
 g4U3x32d7IWNZ4lnll06vSqFLC4kRHwLJ91AgDfEn4Xk5CmTa5qiUtWSbqwF1ZAJitFNmcBXb2D
 XpiNj3pUTj8A9Sxz4Xw404Fqsgvbex7pSjd2yp19+QluJ/6N08g3lRyC8MFWMAgssh1aK/k6Mz4
 34e1YYQvp0j155Fu2hg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX13fnySaOUf3B
 zCas2Bau+iAk3OomhX+85p5X8a69k5v0j66pyWcLeqcFsp+F6LXblI7DZEWw81VEXbPUo46go6w
 HcmubJxmv71bl1r0tYBlhk4DAq2Ubg0=
X-Proofpoint-ORIG-GUID: cx9W8M4F0z1bPNVlUiBTMucvju5hoKaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On Kaanapali the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 9f04a5ad75f2..eccd5451e875 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2997,6 +2997,8 @@ adreno_smmu: iommu@3da0000 {
 			clock-names = "hlos";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		remoteproc_adsp: remoteproc@6800000 {

-- 
2.34.1

