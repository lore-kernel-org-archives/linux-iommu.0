Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3839CCF3
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306577; cv=none; b=fek+il+NiXNYZ6Nh+jOepes+WL8xuS2G2HsXOHZJpsFaqMx+yb+wK6A303A5oVUcArPh9PftcPmmaK2BBU/Baa19xVk5wzwwmDpKJf35v/T03UGr2LEMXGDehn62SKe676U8q6DPYR/yMcjZ17U/8xy8PHAUJP/Q9KD1BA/8d1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306577; c=relaxed/simple;
	bh=7mTJcw8HBthTXbxYIDu/Mf6KA/iBjN8RO8P1CCTFwMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mO2JV4SLbpvsKQUfSkiYN5ygB63BmHZU1F4aLO/tl7uaF49NAjQpmooUCekOb9iHLV3N0vu+wtHYJuy0KliszEMwHKbIgHcu3m4z8NF7JWH6+wL3BLHLyDzorf70WW9bBlvw1m38HGMI3fd+/gYlAh6hAS58wW3LaUkRRIeKQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZHXdN1Vp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d8WSA/ti; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZHXdN1Vp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d8WSA/ti"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679IA3jm2692956
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yk+KYV00feoHEnqEQdIlOr21cfjXAHPNBDwYtv89cDM=; b=ZHXdN1VpDKl+ZNUo
	ODEaQ2l8XHyiBPxTgyi5JmJf7quskfA6a+2oEsWpaXjcf/TwORC9I4Yjfr6rsM5C
	g5qiSKcTK78i34yeMKC/0/AMFu0lvDQy4llT3+dGXjnEfEK7yOHVo2OdMDzKdQUO
	ST3rwaLxP41exMd8U3iOwA1zQVPvrdqXS/cEpbBzljptJTMBO2NSH+GS3lczTrzS
	KzIoKi9luQ0npfbNSnr6zDlNjQB2VoDofL3XN2FMVXZRT5Bw+ba6Mu7uO770gNAz
	RZcIxt5zBo4HX+or/9qFQoYHP5r6nWVwRuRCdVOC9kJvGx2xcUEtg77AodrNv+u0
	ubo4Pw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwmgucws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:16:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1a97644aso13452081cf.2
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306574; x=1786911374; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yk+KYV00feoHEnqEQdIlOr21cfjXAHPNBDwYtv89cDM=;
        b=d8WSA/tiEX2C09CG+YeqNWoCLDWxmPIe4yfIZ0yVjrkbEweb7lW3ky8rKGdbNpgupo
         /IEeFDf9cgFpQtZl22DeVaVEfqzvYR8pPd4RmBx2IGysUFtkhwNWVJDyARUdLdeoXZJT
         4T7SS0u6go+0yaDwdRgNVGldyhlucryIWTqhsWTsIodK0aukvHoufwuUb7NOPNRrg4f7
         8Lm71c3XDoDmJ5RMstwlnqENXuqUYx2ptlLdS5kR0GH/e9P9zPtreZxC66UusAM4Td+T
         5WeN3fB0lhUp/OBCDioCsCs+menbzoejeAD2bAXeauM5LR1ek5L9C3szqDXfvENHky7p
         7J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306574; x=1786911374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yk+KYV00feoHEnqEQdIlOr21cfjXAHPNBDwYtv89cDM=;
        b=By0d1vswKQYG+saajm+bMHvGyEm6Al8l1DuT8uAW2RwamFTeI9Cp3EttLO8bWVJfIX
         d3LTgdOuNZEWzi3tkaCsxbnQ6sdebrqY/2riP6ys+0kQC55XWfgNETADfMJeo7pWrUVK
         a0lNTepSM0DUkdyYVj1fF7KZ3/wOY1e97wyoZ74vdkRRBPP/GoobS6u0L4B/A2hCjgv4
         r5jzu2S5uJ/GaqnYsySdNw7X+fcC0/e069dUJVd0ecMdZwPgBNa4QiVri/hZq7WWZ6Et
         A4YassNyBledTUkZPpo2zNJKzHCdP/ABbzkqMuO80oaxvQo/C+eMCrsQNGoKZ6z+Jw2V
         zOeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rra08TnezEdRjlg1275340GT+2cfKNmiLsYzqYgLGSU9mxeFRGmh1pmZUCCRtyqKWpA+0YKCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnT4fwxeaPbUgjegvfkrF4uMlUoyMtC2L0hMxunWZzMil3OAA1
	XnFVWjDZarlTCeSkQNawDtLSD7I/0C4LpAlBgKGv66P0rwEFPLoCKyvsZfrdNO2Dy91oy5njCyV
	PjQuNEzHPUPwGc6qFwjDfqYySAwjGiEQnAczcjgHRV+a3dZPaQBFb4AQ0Ow==
X-Gm-Gg: AR+sD13C5H4MXsOtN4qNhK5lCWP/pPhtxzFBO744aHRRipLym8IKyN3teEkESSyuCr2
	pR3btCjMF4kRj9YWfkoIhkoV5iIm5coSBQAAWgmu6m/xNQkGyIBhXP7V+je49VHjHRV0mquJ4KZ
	lqMk5JUEK0fyFYULctoPjLQHW94oKYhCCzQu+EOlOMZ8o2LqVSFgzW8bK7ol4VAy3MTcdhali2Q
	xpOrJaM3kMRRiQ5B4joXDRDXg+5tJ8/1teXMcALghhv5kduDbSnbATzlms+B5+71wxuuD4Pcfgz
	qqu7cGXvN4dgUzYH8LDv22Xm7mi6GC5zVcXDUdxLNHZUI+YEWbCzb5XSVZBySCH0vwL0Uv2OFKP
	r8jW6a1lqMgcMp+RLbLmGVXE+NXOCsuDwXyA4C2pOLOXPnQKv7VZstHi4gJLsGTDgU0nDRgITrI
	UxN7N9ACiOEM2L7g==
X-Received: by 2002:a05:622a:13c9:b0:51b:ecca:f2e0 with SMTP id d75a77b69052e-52ce5f44c7dmr383805851cf.5.1786306573853;
        Sun, 09 Aug 2026 13:16:13 -0700 (PDT)
X-Received: by 2002:a05:622a:13c9:b0:51b:ecca:f2e0 with SMTP id d75a77b69052e-52ce5f44c7dmr383805601cf.5.1786306573440;
        Sun, 09 Aug 2026 13:16:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:16:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:50 +0300
Subject: [PATCH 11/12] iommu: qcom_iommu: add the MSM8974 instances
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-11-87f5cd492560@oss.qualcomm.com>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4519;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7mTJcw8HBthTXbxYIDu/Mf6KA/iBjN8RO8P1CCTFwMk=;
 b=kA0DAAoBizyKPgIpKNUByyZiAGp43++hNuem12DDwajis+OwqIh9iTWMPy7MPfgSALuCYaIMO
 YkBMwQAAQoAHRYhBExwhJVcsmNW8LiVf4s8ij4CKSjVBQJqeN/vAAoJEIs8ij4CKSjV8aMH/2Gs
 /ZeyCHt2uKgXo7yBo2k08/ksLkKzv4XX6EkQgXcFWdr4a2M43ghcQUcOi4hi97mOoDYxcJ2rtpZ
 3r5cM3FMU2JXbxaKfthVjEkIEaNoq1vaf5emEukCvTuRkIJJRin6FKlZX8uqQu4+2GfQOQ7TZOg
 pe6yokGZD6WNROQOQGw5r1XwNfWvjsf2TAhch8wgZX9GbMAoNKwOXaGYA09g+WaPQTLjR61p7dC
 iX451qTFBgZSuJ6s9N9oh4q5EBnI13SV65r+eZ65Zop/51irdjikPiFhFmsa8UGghQJPohmiX9a
 rTUZgI5FAFu/IgagduF7gsw8+ipPpSIgO2zAyjs=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4NCBTYWx0ZWRfX5ffREhI+esic
 K9vwMlB/dpwTTUVjepJG7Adj3NkMduT9aLjBqygLiCUtDeDI4dY5egr1gUZvjX4KPNnITvcttT2
 +ZhHb2pZcYfO0yhUgG6cX4ukcnH+7L8=
X-Authority-Analysis: v=2.4 cv=HodG3UTS c=1 sm=1 tr=0 ts=6a78e00f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=T1X4G6qr_Viczm72je4A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: wX-6WZvoalUkYU_j6OaWxPtIaiX1y0wl
X-Proofpoint-GUID: wX-6WZvoalUkYU_j6OaWxPtIaiX1y0wl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4NCBTYWx0ZWRfX8iWT/s1DPZL4
 ajGMc2TNQ5WaLYIfpgYbqTWnDqWOf9mQJuE0J85PkpMbu/6xw62b4oF7OL9w1WtX3r0mCehiV3O
 UDwl8cCmV+TU75ADPF3bj2bJcPfHzRheShJSceUYeW77TweWcu5O+BKqRiz2/po9H8yoOoPJAnd
 1vVpKigzimos3Wo+9xt3yxnwZ6ANNmHGo8ubltwxSnYFazNgGrF3kTS59Uk9rg6+pdfBHUiQp0G
 IwyvTqVEeFO+GTe3VRPHaR98vqf1yUk3pE463Jsk7btLKnciQAkAtCB+RX2NdZ2RW0x4JSaevfx
 gfiFutHJbSLy/crUi8gyPjHhXPmTPDqgCrohOktjntYmZo3E9fGGS0y/wEKXSMG164tjQPN2MJK
 fbu7E3KrbJQ9t+9VgNmJyqKvxqnfB1VOAtxuYj4I48SAZk67XMo5N2h0CcLx9K8QLslBAZUf17G
 5GAtkXQ562ITLTilV4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090184

All the infrastructure for driving the MSM8974 IOMMUs is in place, but
no instance uses it yet, so the GPU, display, video codec and camera
blocks still cannot be put behind their IOMMUs.

Add the per-instance configurations for the five MSM8974 IOMMUs. MDP and
Venus are TZ-secured (SCM secure IDs 1 and 0), so only their context
banks are programmed, like on MSM8916. GPU is fully OS-managed. The
stream ID maps come from the downstream MSM8974-v2 DT. All instances use
the short-descriptor pagetable format with the AFE quirk.

All instances terminate faulting transactions rather than stalling them,
as downstream does. The display IOMMU also halts the micro-MMU while its
context banks are programmed: a hung GPU cannot drain, so halting it
during GPU recovery resets the SoC.

Verified on the APQ8074 dragonboard: kmscube on the Adreno 330
renders through the GPU IOMMU (119 frames offscreen, freedreno FD330)
and MDP5 scanout works through the MDP IOMMU.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 102 ++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 9523ae95fa12..bc7d692a2043 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -1187,9 +1187,111 @@ static const struct dev_pm_ops qcom_iommu_pm_ops = {
 				pm_runtime_force_resume)
 };
 
+static const struct qcom_iommu_bfb_reg msm8974_gpu_bfb[] = {
+	{ 0x04c, 0x00000003 },
+	{ 0x050, 0x00000000 },
+	{ 0x514, 0x00000004 },
+	{ 0x540, 0x00000010 },
+	{ 0x56c, 0x00000000 },
+	{ 0x0ac, 0x00000000 },
+	{ 0x15c, 0x00000000 },
+	{ 0x20c, 0x00000020 },
+	{ 0x314, 0x00000000 },
+	{ 0x394, 0x00000001 },
+	{ 0x414, 0x00000081 },
+	{ 0x008, 0x00000000 },
+};
+
+static const struct qcom_iommu_sid msm8974_gpu_sids[] = {
+	{ .cbndx = 0, .sid = 0 },	/* GFX3D_USER */
+	{ .cbndx = 1, .sid = 1 },	/* GFX3D_PRIV */
+};
+
+static const struct qcom_iommu_cfg msm8974_gpu_cfg = {
+	.no_stall = true,
+	.fmt = ARM_V7S,
+	.no_afe = true,
+	.ctx_restore = true,
+	.bfb = msm8974_gpu_bfb,
+	.num_bfb = ARRAY_SIZE(msm8974_gpu_bfb),
+	.sids = msm8974_gpu_sids,
+	.num_sids = ARRAY_SIZE(msm8974_gpu_sids),
+};
+
+static const struct qcom_iommu_bfb_reg msm8974_mdp_bfb[] = {
+	{ 0x04c, 0xffffffff },
+	{ 0x050, 0x00000000 },
+	{ 0x514, 0x00000004 },
+	{ 0x540, 0x00000010 },
+	{ 0x56c, 0x00000000 },
+	{ 0x0ac, 0x00006800 },
+	{ 0x15c, 0x00006221 },
+	{ 0x20c, 0x00016231 },
+	{ 0x314, 0x00000000 },
+	{ 0x394, 0x00000034 },
+	{ 0x414, 0x00000074 },
+	{ 0x008, 0x00000000 },
+	{ 0x00c, 0x00000000 },
+	{ 0x010, 0x00000000 },
+	{ 0x014, 0x00000000 },
+	{ 0x018, 0x00000000 },
+	{ 0x01c, 0x00000000 },
+	{ 0x020, 0x00000000 },
+};
+
+static const struct qcom_iommu_cfg msm8974_mdp_cfg = {
+	.halt = true,
+	.no_stall = true,
+	.fmt = ARM_V7S,
+	.no_afe = true,
+	.ctx_restore = true,
+	.bfb = msm8974_mdp_bfb,
+	.num_bfb = ARRAY_SIZE(msm8974_mdp_bfb),
+};
+
+static const struct qcom_iommu_bfb_reg msm8974_venus_bfb[] = {
+	{ 0x04c, 0xffffffff },
+	{ 0x050, 0xffffffff },
+	{ 0x514, 0x00000004 },
+	{ 0x540, 0x00000008 },
+	{ 0x56c, 0x00000000 },
+	{ 0x0ac, 0x00013205 },
+	{ 0x15c, 0x00004000 },
+	{ 0x20c, 0x00014020 },
+	{ 0x314, 0x00000000 },
+	{ 0x394, 0x00000094 },
+	{ 0x414, 0x00000114 },
+	{ 0x008, 0x00000000 },
+	{ 0x00c, 0x00000000 },
+	{ 0x010, 0x00000000 },
+	{ 0x014, 0x00000000 },
+	{ 0x018, 0x00000000 },
+	{ 0x01c, 0x00000000 },
+	{ 0x020, 0x00000000 },
+	{ 0x024, 0x00000000 },
+	{ 0x028, 0x00000000 },
+	{ 0x02c, 0x00000000 },
+	{ 0x030, 0x00000000 },
+	{ 0x034, 0x00000000 },
+	{ 0x038, 0x00000000 },
+};
+
+static const struct qcom_iommu_cfg msm8974_venus_cfg = {
+	.halt = true,
+	.no_stall = true,
+	.fmt = ARM_V7S,
+	.no_afe = true,
+	.ctx_restore = true,
+	.bfb = msm8974_venus_bfb,
+	.num_bfb = ARRAY_SIZE(msm8974_venus_bfb),
+};
+
 static const struct of_device_id qcom_iommu_of_match[] = {
 	{ .compatible = "qcom,msm-iommu-v1" },
 	{ .compatible = "qcom,msm-iommu-v2" },
+	{ .compatible = "qcom,msm8974-gpu-iommu", .data = &msm8974_gpu_cfg },
+	{ .compatible = "qcom,msm8974-mdp-iommu", .data = &msm8974_mdp_cfg },
+	{ .compatible = "qcom,msm8974-venus-iommu", .data = &msm8974_venus_cfg },
 	{ /* sentinel */ }
 };
 

-- 
2.47.3

