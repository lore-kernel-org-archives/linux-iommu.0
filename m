Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172864;
	b=gbSG4YfEKwNhJsN8ODfW2JmXAjX9jZyxUr3yGZM4bYP/zWrPHNUoCBOaPN18pw4zAzzw
	 vQuT0VnaTXJ1AtEpMlXoY7ZvpjiCCyrcHsEYWmJNZKeNqByJMMAAxITdBFS3nt+SIWEnr
	 2Fo4IM79MKCdUwxDZETFtiAe+R3UfYz3zbO0XVL4zfPkY4PXHifvhOFBvnHA+ZX6X+FYi
	 LgTmCFuAIdQ3cr4UGgGRsgsG4a+R+okE4raovvCQE4udkNnNbjA03rkOqNR+eMyHgtGpB
	 Zt51upToUwi5Gb07ay+i7xJi4H/80uAs/DbStBaYeakjHzL4+aFOL5aEGDL4X4FXLMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172864;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=a/39YU5MZYqo3QJs/gpCcGuqyuQd4Jmu1xV4WICEifQ=;
	b=Lf7geg8UKCMWeyzmrdiNJ3254ofW5rZEo7GYBIz5FpwgHrscpcm22VkgYTLeBkX94Hah
	 vdz1gWA8xi2NaXE2+xMd7+j8X36hj7+uVGRjFKm/gA+4lIEZv2HUEtidJRFkUDIFZQI7H
	 s+o4ozunuEpgO2ojn5tYwQOdF1leIfhEofZwLW56RbMJwtlNYnz+ghiiby0UzBQhoshn3
	 AauJVoH6FgcH/tN+wh0gXUFHAX0uzRtt5iWptre2qxh5hKAtU/RzGZ3NIVPVlu1GMNPoB
	 qbKnwg99Uh7im+FWikDCqLQgWDrH0hIu8WS24M5MDd7QxMUfq5mTqMhibgWAzaONO3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eD9RHG7z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DtVWvvZc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102B606D84B
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7102B606D84B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eD9RHG7z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DtVWvvZc
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkgLn3107631
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a/39YU5MZYqo3QJs/gpCcGuqyuQd4Jmu1xV4WICEifQ=; b=eD9RHG7zNlekuLQO
	Umc9O8xT3sNIDqKFOpEJw2iDgZ3UfIvS+T35wGpJlX84qZGQC+eeIoUvJx/gnzIK
	Td8+A1/IePDCjvYYhmGwZ/a91lgNKSzXfm4B0oEksUvnsEjqmq9q/O81ui6T+2du
	ZfjLYl38qtj7dwtdRaXN2w48AVpxdhG1ig1/BwoN9eXvxdRXMuOCyS08baF3/LnM
	2wxO8Cm4QZr1cIpLNKHcW3cJzRP0mg/mSEzriD8CKv4oXCVw/GR27B1MxNDZZtZB
	2h+PMVP+NyI9oHIACyZJhGWKA/JPDCDXVuRTH1n2z3QZjJJEfhinBUVZKY25aNEM
	Ims5yg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au3bx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375bac6bd21so823043eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172862; x=1795777662; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/39YU5MZYqo3QJs/gpCcGuqyuQd4Jmu1xV4WICEifQ=;
        b=DtVWvvZcxrvMK1Ilomw7GTACj7lT2LzRCgSL3OGew7iTmLkp6SgELM4PR1kB9Vj/uf
         Q7mFoyVAm/qlksPmUEj/7RuyVzuIxdaA44gAaLtQTDclIk0OqQEmBAOltlph7WkxBjnC
         Crutsa54mnsechru/F7B5YZcHDtxejik5FOY7wUN5FPLzMJwAsc8hWhg23oUEgIRuWB3
         dfwDFbZ6+7AZbS61mwDZ+/0CbA9oROP9UkGC2RdjxDzUI6LRBdPB8w9hIDS+rESg5ynj
         aPngerAUxMt4N3A5wsFyOCYkPfjl6vaSs3Onj2AGAI4HCEEO20MpiwYZAzFtWcgkgjii
         QDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172862; x=1795777662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/39YU5MZYqo3QJs/gpCcGuqyuQd4Jmu1xV4WICEifQ=;
        b=kZDpNprkyCu1K6gsGg+t2prnwg1QQ9eMQScdnaCRncFvYfWR4CA5bbTJ62BOFW4Mz6
         x7uezRiJAaRdKMlAy1htvRd2uTCNDoz+dFrQbPQbqi2oYm7VqOzr3p5T/64i264JaG5a
         bFh/GwB9P3ghsPgvHFRii7STy6R/B2Xh4o+aucZVSkD58/dlgQ5bSm77eV9MukwYYIkb
         yphm7zTGpQy1kJonaN+ml6hpjQS1lbLtz1LHNMKbw3daJ+1PyyqHsD6PbOOwc9mupTid
         Wvo0ewWHRCGqaUJ5zcNnZHSxvtaqvBgSapfNt6nyfwSksybVRIxsu9A04JbgxpO8vlCY
         m5Vg==
X-Forwarded-Encrypted: i=1; AL+hErFh1UE6GxfvSB42Y5cEa++hcXxWo0dYufZOSxqvXqzVuanJsvtNmzEGJEb4V3Wy0RWGR/Co4A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ltG8ifPBRItOdYaLG2TPj8OUv3S1V2b2Fn+BLC5qmmjUEQYTB
	T0Vx3lCAWLlQLL87vABZ1YqJ0rCCgHwYWvuIh+jJNDDfCF/apcbwfJVKnLJaKbPlizOZ9D/IjaW
	h/exGoTdW2y1gCK/65ALI+iqBq3xZ6qeUD9S4zzkrdX4fhNNSJYjMOBh1nQ==
X-Gm-Gg: AZFdTZdE6Uzbc2f8rzobpUHnyARaFofoqEVM1wQJLqVRxUsjGNbfRzlJCbFKL4gM/D6
	4TRkamvGSQmIpVjCbWOXCZAHXjsvWxgkirqso10kYT9JHVezgCvIp5IQ59HYHg/kXvWvrrrpoVk
	wnaO5JfeOcjrnbGqrdV3tbY6QPSekxvYW9VC+CNP4oO/99NtJAY42RlcS0mnTOT8hW7eoSPSWFC
	KQB5OFZH6j6fYDl6UrFQV5sAJHZKHVStS01KG8m9iqRgL7X68Cx0MJZPFLtMnOi+DZ5Xz06CiBN
	yagdpi+Mifx54b3AYtWBmC9dQSKHHC486DskEaZnYjWulsYSYMCbPxTBMRV8E9Adq70qGOeGhJI
	mU9rhDANyRM7onu8Fss/W5cKeQcvHAx3KOYgH06fQrKORXn0PstFoj9w0nmSjm0sd/T49rSw8Ec
	sT0spk
X-Received: by 2002:a05:7300:f794:b0:381:c31c:bfbf with SMTP id 5a478bee46e88-384b496a36amr4160540eec.21.1795172862103;
        Fri, 20 Nov 2026 03:07:42 -0800 (PST)
X-Received: by 2002:a05:7300:f794:b0:381:c31c:bfbf with SMTP id 5a478bee46e88-384b496a36amr4160488eec.21.1795172861446;
        Fri, 20 Nov 2026 03:07:41 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:41 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:51 +0530
Subject: [PATCH v4 10/20] arm64: dts: qcom: sc8180x: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-10-cab8ee8be0b3@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1335;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=BJI9Qa+ALwqIsUj0DfJo7B+SV6DPkM10cbLytxJMbcM=;
 b=iDWhFdAcUQz86qchqaGgo72B4dP/xA4xeHvIsaSCpx5fY419WT9WrzE1fBkWEtNJC2d3KiBmo
 LIRDLJ0PBAlAUyr9Gm5xL/jT1k3Sol2uGi8bvu3WZCc4c3ZmPDmZ741
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX+7YL8LMs4glE
 Ec12o2/Q6071VhXxb5nOj2bJ+E7VSQHO3LmN1vAYl8AZ4H/LD+06P6cLg6n9olzYFcmbqo92Syk
 V/CDBfsZvPERHsfgQyYTyPj0DP8ysSbYq9E/omsNaV8sKz/In9cGKcvEbGegPWSePS1WrsGk7c5
 1EQRQnyETWawVm033FKrRUZmtv58WP+Q0eh4gGZm7GOPiJNKuPu4TkA18kFSMU1kdQ7XoWpASaG
 K+zpJPYRW9ofjLZWkaTXXS+b2BDmp5NeYlL4UYEsJUwPeoXFqEo974ol3T9gfjwCzHk1QMtiE0t
 6iiGTrq5TFwqYZ/IjazetbgJqC7ZkEczMCzR+uQfl6O67i1n5oPrXADr0+6/hm4bL2Nox5J+9Oo
 h41I+r/rTWenVG6RlJDLBFGq3R6zmhk++nghIeBp7JsLZ4fhvQmj20IznwFPzQRMY+yk1B65EUi
 +C7NSI6I8eMLJvINI1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX6V/vBF76A9K2
 bZNJ5O92wvEUB5sjLba/IIC9X4uzbvc54xivFygo9Ox+TkTfw3NP8SCWo7U6LILZLr46prCzbrW
 nkFJOr7Zf5pycVWwD+wiQcLaY8BVl+0=
X-Proofpoint-ORIG-GUID: a4qoKofwTepBe6RqY8yAzywmUQhoCRZ8
X-Proofpoint-GUID: a4qoKofwTepBe6RqY8yAzywmUQhoCRZ8
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6b0029ff cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=UZQlob4mJqq41ALSq9YA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200044

On SC8180x the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index be79608b7161..88a39e5e8f07 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2280,7 +2280,6 @@ gpu: gpu@2c00000 {
 			operating-points-v2 = <&gpu_opp_table>;
 
 			interconnects = <&gem_noc MASTER_GRAPHICS_3D 0 &mc_virt SLAVE_EBI_CH0 0>;
-			interconnect-names = "gfx-mem";
 
 			qcom,gmu = <&gmu>;
 			#cooling-cells = <2>;
@@ -2410,6 +2409,8 @@ adreno_smmu: iommu@2ca0000 {
 			clock-names = "ahb", "bus", "iface";
 
 			power-domains = <&gpucc GPU_CX_GDSC>;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		tlmm: pinctrl@3100000 {

-- 
2.34.1

