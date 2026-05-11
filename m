Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E738330F
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538281; cv=none; b=POjrDJYUOo4/QzORvu/exli7WjGbWDM70jXEl4DAnaWQHq2xb2VC79McXyyiFGQ1C6sn0Xeqfc3M3kjSQXglnls/yaA5vQgB364A9fiwxjJUqizUu+m7DBtKqnPvPolO/L1V1tcV28CczAhFPeaD4ilLB6NiGb2alGZrowsmwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538281; c=relaxed/simple;
	bh=4TwFG6GQ2rWfxHvno6AGnLKMEMKg94Z6yrhbxek//KE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dupiqi/a8w3J7ib+q03J6ggabrbPv2DH1gSGCH/vZaXgPo04ArAx5xY39XC2MpgxBye+Ym9BeOQBZZ1J4wfSHOMyWaTMYQY7Cl7XfqnTez4EVmwO1GTPeh0iRSMFaX6mgkD7d2Ee/OOV4o1+pUEGKXGUqV1Gxca25DqXVCqsHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qp3AwBmV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QSK+nwrn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qp3AwBmV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QSK+nwrn"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6TMl3443739
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VT84PwNDUBR/tJKsjUUmdrL7bPcbqpDnJjYc8wbzdjM=; b=Qp3AwBmVkx0EsjJ2
	vKcMSKGExBHgHr1iDbkp2A1IpUs6nUz3FfiGTOBgmHtNM1Tg1F8DP7XEM8p0a/gU
	YRhzibqnFtWGsjOJqAtnanVpzrnyxkGZvCmg8M1vkklyPRA9IQSEKD/MdzUxi9ml
	VWHRLWOaoWSn5wcNZ0ppHQKTBGxBsahdmIB86v/Da/wcCb/1KvaR5upWM7fdx0Pf
	ztgsWUm66qf/OhiCol8ldCwGILEHa5T4gMP9UsZc3j/KSb42PO5UU0GHTrA9IjTG
	7/wupGretjc/9D2mJbyzGEXn+ai/+nDFamh1+NXbt9CJZ4uc36XP7EPzQRiU388r
	Nq6cEA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0gfeg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f85179263so5227287b3a.3
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778538279; x=1779143079; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VT84PwNDUBR/tJKsjUUmdrL7bPcbqpDnJjYc8wbzdjM=;
        b=QSK+nwrno9pQFbXQMNrMSH3Rxh/Icj6qYxlbk/o6/OFdpJumNAI/407ggZJ53D5wCI
         pQROUZ+Qx9A4kolps1lEQ5k91/Uhf8reExUweSbo8rotLFIbuSAdZqQ0JayhhE9HiuLM
         xuMDvibnM4zEyPa43N3ECXljUyscLlr2FUmP3AD0twX0Fqr+nKwkhCpfQNs8gEQ20n1d
         J/dfV5kcQ7NwnOP31C6laaVW0XZYbusXz1Tf5mzw3LVIV3wa1+cLhQT0UoYxAoik9q4U
         PPSeDBmBDxv78UCB/dZPnrXG4DUrA2dsjqp4YL9LITAx3wC9kipWzI5HXHeiHgWGNEKy
         W/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538279; x=1779143079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VT84PwNDUBR/tJKsjUUmdrL7bPcbqpDnJjYc8wbzdjM=;
        b=Zuh/9EblQsDPjEsf1WYCIqyWxRCGALEq3wPdbuZkHPKYzuOcWBa6OgnkQHCWbqJgQr
         t85khau6aftvB54DG3gK5ToHbPbHW5NKWf2mKWwof7g8uxqGjm29i7yHf+9emIa2nt83
         Mn0ovMTGYXWhrucDK+Z/Lr/+F9oukZA08+SYyX7I7DL/ceDvj+0gCsQV169g98H9V64E
         QYTU8hA9jpRiMAASEMIZ+39Vjixx03A56ufmxTSzRoBVqtvZqt99PgHJO9EKogVp/jUr
         MxZE68ttWnbpSc1A2U7DwTcVKUph1JXBC62C8VNcKC9r9SkSOf4pyBXZ18kxTjDijnT4
         nsPA==
X-Forwarded-Encrypted: i=1; AFNElJ+jBPCXfFG+TUeY3hS5j4gedAmzSyTrLPTtlkhXh1sTNZTbhIO+n/kfL7tOqwCHktlH6rj9CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq3t8ubD4NJCMwU+Qa1GD3rni0UM6PR3CqJD/w0MqmAOn2HpoB
	g0qK48FIgAyMj0555ikcKieK1v2LpuA2kkW0CHUmzmiYtglqxGt6GEZ4Mg1Wv4DgLPzhTQtHfId
	THyPnW//zG2EJaSYvNa/zOhQ8iwHhlyYU4EVIRlY6t+r3VSMG1bO3CkPGiA==
X-Gm-Gg: Acq92OHnEfILmr9anklFD50Hbifu27LYBEA3BnYjXqxAAeLv9SqVU/a5z7Wba9DCTK6
	zhJePMlRSzUleUWtEFFLt+01v6+AFvSnSoNmSPSYJBBNyZnqb9bHtkjYIlK2CtG/7K3OJW0RbKa
	5oWZUOllwWjSyrnhg6LLhW7R7YhVoCRd1rDvTa32qPl59MUm5AR0yKE2ZCkucD2MKQjzPkyXAma
	HABNiLt9r9icUqOrAB41j8BmevzDese79ybBcolQFOZBUDKj4X8eLKM9RGq7P0Jxke8/qrI0Agc
	eKghwNBi7EyXrjYLaRJ+XUtrnhOxeHXGJ9FZUoXxFuAHjX+mppJ5+GzpGUvpheY/90N1ndS/t2q
	ZBgKqggWqP/42dmiSHRSGwH6DUcccdpBHLLpDDrnXo7KyhA==
X-Received: by 2002:a05:6a00:2c86:b0:83e:c8fb:54df with SMTP id d2e1a72fcca58-83eeba03dafmr336288b3a.2.1778538278588;
        Mon, 11 May 2026 15:24:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:2c86:b0:83e:c8fb:54df with SMTP id d2e1a72fcca58-83eeba03dafmr336251b3a.2.1778538278121;
        Mon, 11 May 2026 15:24:38 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:24:37 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:22 +0530
Subject: [PATCH 8/8] arm64: dts: qcom: kaanapali-qrd: Enable GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-8-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=723;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=4TwFG6GQ2rWfxHvno6AGnLKMEMKg94Z6yrhbxek//KE=;
 b=waPfCkFYB6eDvZNGEFJsUZ4feqP4qBVshCQMu58SBRIUoShOVQKU1ivqUXVi57+d8FACeeVYb
 q0ZLr2DHU5jAOh82UtRnGExYjXfoo+hpAyQ8b0CbMm6Im6ysoGaandY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a025727 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=tTGeZ2WnJxbZjfYJna4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 9XN9KlmrktjJgT-OfjYhnzhl31owMq35
X-Proofpoint-ORIG-GUID: 9XN9KlmrktjJgT-OfjYhnzhl31owMq35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX6LGwGH0HWJeh
 s3oywNhSO+Oo8HGujTf/JqjPDClL3DP2xZSACQU90r0xM/cDHQVa3blGwMbs5681k8HxrTN2abz
 zM/on1an+iEFCzTneUqYJ86QURxFG60RNLmVdahhPYH8FkPblrB4kaoI5cL/uGNU1ZojXtgQkOh
 x2udn8xsi+lVo1JR+QI+b+Pk0zMNfYRD3zc33Z+slhkK+QceomMLJ3MZHgt5DH4nybU6h8UR1r2
 nJ0v8qdU8sTvePzelxDR6yf1XxU9Rq9s/YrO2G4tHhC3dPv3/j3Z+xRvIHWv5fK1Fn3qAyl6sBG
 gfEPeRPvAb6A3fxK4OzbqFwQThK/D7BEStxNBhLw2E9tf8WkRjq6OBMFYohBz1qBnfu309p8Lsc
 JzZ0j0/doAEWBrjCiJ0vvoXpzvqRgEv8q8Wrx0cfcer4lN9EYddfpeR8qgUdiYn5lnoTo1hTWSB
 kqLx1FtIatUj10nJaBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605110236

Add the secure firmware name property and enable GPU support on
Kaanapali QRD device.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
index 55d02219ef4e..6bef8ec151f8 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
@@ -693,6 +693,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
+};
+
 &pmh0101_flash {
 	status = "okay";
 

-- 
2.51.0

