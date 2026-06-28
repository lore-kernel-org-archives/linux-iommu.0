Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBB30569D
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671134; cv=none; b=isjM6ZqzdsPqMrlkeLc8Y6aVQ+SddAS2j0TWUYT1g9LoTq0ibDDWfI+q0X+TJoOMwesu5VMKsNGG2BJbwCHG4yPEa+AalDl9YXp7WiMxNYikE5l+SW+x1Ob4J/zvtaAzdOPRigsJ1UGDb/ymGhomTbKYO7074IoORtu51U/aBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671134; c=relaxed/simple;
	bh=Kmpg2cRtDUynAO7yy0o/iSHvpnRUu362Fx7oOFfm7RI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1yAgTj6c+RhXQYXs7RCRgqqI5I14//PWg9WN2WdLrNS1YB6NbhPEKrrFWmSLIsGbRrIOzXgEn6xvTH2viuKJFTk1SXSpSmHqBu8KwGnrkRIJ4BGSyCwOJtqnjwiKDgblPS+D7robANuEn4Kf5sH3VtE/DiXKjgfnBTZiHuuNRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hWe7bG0B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nye3bOpV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hWe7bG0B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nye3bOpV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SHigih448255
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1yFPVvQy+nbJ2ioSTODUoUgdioi73DC3iCTsISkzqNU=; b=hWe7bG0Blx3TxZKG
	/3NGF7L60JZiZv7jEdJ4S58RdujNMuqzXO1DdXy/pWSeSzUweKBPn4ZUio5YnVS4
	c+gukrkN97b1o29twJ/aoJtuGuNqJpaItu3bW8H/ne72D2Fn8AGFFbTRwwVQOBEI
	flY2RxtqnY0iBxGkENK9F2qPN/9E+NZ48uVSV0FYR2Kt/TfriENoviYYZsmZUMaC
	R0LgTzqy4vuFf5DjQl6zodJXTj4+CcBMMZQRgQvYEDEZaYIMihVAhcT0rboBvBv/
	M/qIf3FxptGh4XX6A6otiuFuXjxclgugTP/FZtrxKJyHkazbtJ+5F6UBWVQ0jK/5
	tS0olg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tukchh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c011c7cb9so6033712eec.1
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782671131; x=1783275931; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yFPVvQy+nbJ2ioSTODUoUgdioi73DC3iCTsISkzqNU=;
        b=Nye3bOpV0rgbGVUT9SkIV7fzPZaL+3mysURvcx9JXtoAfYBezhvvRSVXLYzkyykmk5
         Ieazpyu1DlkHWqeohS2uB2JEZvWFCfj5zYVQV+2y7XTL7OW+Tvs+fvUjYD1DFBCJwS6W
         wbFCTRJKduJXBdPaogs8kApNx50TMMTLoQEqOQlo9O5j2/g/TRZ2BgePs/3Z5buUpGEh
         u7lX8YX+kwFD2P0KRHQB8VHh/1Zif1NWPir+CslAtclSDK6ULsdxcgiVnwhIDZ0ffSKV
         +Y47Pp3jld5oMO4AAKUXxbktONXyfhiIeKgbbyzRev1QiNA+Qqe7ZVrr1pUs/VGjUUd/
         o8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671131; x=1783275931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1yFPVvQy+nbJ2ioSTODUoUgdioi73DC3iCTsISkzqNU=;
        b=WSogdGfnfHjp22QOc4SoGGySn6n/uyyC9945YyHuSDIZnQNOwgO+E7LVZn5R8e53Nv
         pyhs3QpLkr3tVi3qXlJCFpmN7PAWs3idMweS2g7sjNKfKSQC9/BBUFsO0savzep5PuX3
         HnjBnlHv4LMyAF6TbHka884g6Izcwzt8aSNL+B4n9MFagn7i7N5WXqNFR1yYPEqzb4vL
         Ukx6vj+dE/tyW7OG7UkJ/ZeBGMDP2G5MsLWAtEArvc/zaWtf5+H4M9lBhwDQ2UwJMiiv
         vmSscR8zLf237qvlpUmRKxUrHSSHdBJlL0CC6Key6JTQaNif3KdQ7AXIHtTNyWk9Bb9x
         yJaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMoHTdSAUQKUkZ9mGos4rhn77XPPUGIMeZkeE+uJC9+mzepalMa60ejDtfxbBvn98pecZRqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt6l65USQOFJeJuTwA9ztx0ddWuLHktEPEG6blctrST42fRvIN
	PgAZdo/3PPqyAXBUM1Iq678iYdQo0XAQxqmzt/H6Wh7iiiT07CUpIaG6jOdfd9T1ybiq0BeQMiJ
	q+F8QRJAR2F2TF0XGheQD3ChA9WDdzLXd6cIW78s3V37eJCDapSAydNRX8A==
X-Gm-Gg: AfdE7cmmWr4DGGLuobpSlP0STlo2HeTIp9FCM7c+qd/fhGiMn66IrqzGPIto5mgtvIX
	mEAJljxm9Q5tp+9n2jOtA+Q2IAPJJpznz/j1QRMCM7Kr4GtMS8s7A+sHfhb22LHSn4nGRvoVrNU
	mJ+qFUXRzoPn5NAHBW/LsYujsNXA5SNwLBFR3eb/X90n4c16gVnBv5OryaDITvWV+lfpqB+vzge
	dc54mFMfi443w8udj0Sr+bHwIsZBqioyllhfaSrbaLghBlelKnJf4hSBSl5RahRi9nPwZ1vgYi1
	HsVWTcqmGy6xwTaeRIdqWYDdzrNzJ/BprYrYc1KGvovGWFs/HG/V1+Xfe4h7npl2RdQGrIopYZx
	V7aeEsu0SnAyqSn3k159sYt2/drWnXDv6Bp8=
X-Received: by 2002:a05:7300:7308:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-30c84e2074cmr14238213eec.11.1782671131345;
        Sun, 28 Jun 2026 11:25:31 -0700 (PDT)
X-Received: by 2002:a05:7300:7308:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-30c84e2074cmr14238195eec.11.1782671130794;
        Sun, 28 Jun 2026 11:25:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:25:30 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:54:01 +0530
Subject: [PATCH v3 8/8] arm64: dts: qcom: shikra-iqs-evk: Enable A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-8-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=802;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=tzXgoMGOkByneCJ+ZG1Kzo6D2yqiTmTiTrurOKuJQ0A=;
 b=vOMsC+RkFWKODgCcMX87UqVP576wC8O1KhQFPbBpZ2NKXQ8EKjv/Q1fMsAlmqzi1jvMj/Q46a
 9dFJbo/MADYBvWrmlNIu1gp4R7A4AWiByduT+jS6FwKt2dNf5omb2ZF
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: mHayPT9ipBML_21RKa8nx9WS3X2wK9FQ
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a41671c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=e7-BAW4puXiLW4xK5oIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: mHayPT9ipBML_21RKa8nx9WS3X2wK9FQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfXzKFqx3WJpIrB
 tWL6iP0dJm2QBzCEifuQ6k151h0NBykEt9IShSa8B6mEltssY/7gt2CjDj1ea1pCScAlYdkyYMU
 Ygiu9WrBGlSCSP0h3ZwjzDq3ZwBcl2n4+f8XgvhmfHGykrkd5JNyOw35ZqmaVse9b17XS9CAQPC
 urV4D4To6ebghFBSthELru5CJLtlGBmq3VOEDEhkEvWy/lcYoKKDO8IHZ06llgNi6yVZnHrGvlt
 FU9Ri+SKVPi8W/uUrCNA+P1ZQdwByyRC6Ywf8HrBQMw4pwu2sRT4wrlGu22MAZdg+Vbp4twIdAP
 EeqMHKI9j6HSUBdzjI2B8qmFRlvO2J58h8++kUaX4rixsnWf9toDTcTK5YYqNKqIXSVr9KZ9g1C
 IAc3zxBYTgybKDP+dUVjjHLXeDunpBujgW+h/aL5MxbtlsNZte72riq7b0qzDrGcDD4KQtkk6HO
 UmSbHbGsudCLY/2OE9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX2608t2glKSkH
 jYSqefJgv7wGtITd46nujti2X/SY2cXr4VTWhQzY/RRn6Do7cnpyCBKlq41Hmmbvsb84F0RZ7g1
 BBZXN2mw7jcyllFLxUPnGp4gm/htuQk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra IQS EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 3003a47bd759..0918bcb4b1ea 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -23,6 +23,14 @@ chosen {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/shikra/a704_zap.mbn";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm8150_l17>;
 	vqmmc-supply = <&pm8150_s4>;

-- 
2.51.0

