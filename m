Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265730100E
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784320993; cv=none; b=eIt0GM9ojJv0TvO3pySD4HWCSzhhHfdKjpf2oO4T0pDohbkZev2ck1vCEfh9lLZ4OeMRtuK+Ej44kDZFkXlGlYgqzK0i7buoFOeODajeHlGaC8sWiM+ajUybpCa5/jNJmUODqNRnVLAxv9de5HkSLA0gGNfCFWXjpBKITE/X0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784320993; c=relaxed/simple;
	bh=5F/4LhMRQgSwHx4+A7bz1FbfbCxCgdAfchrXjYiRToU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwE4iYmQGxeaaMK0A9ro41HQv4u59dMq1y99ISRVaESnjj9M+xVpf/ZqDBkPxpRhrOg0+ZOsgq2V3WmLNdRsWwVNeRhfalZ+K8taYR0OVe9kt0Hn6IE1z3Xm9ir+WL8RqIQn6WA/7DlZJxjov00IUqjYp97qwg7ibTZJdFNBBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pjPVSzfU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ezxQo04x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pjPVSzfU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ezxQo04x"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJthrF2824112
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6+db1P5RhSgKDmUAmXoiZyavEFVSigUv3Np7w9qQeMU=; b=pjPVSzfULLlVIqYC
	KHI/PHlLgb+u7+xOpdqVecyBd6IinheCrfAlxjs8juOuAZhmn8PhDTF8i9ugZw+X
	BRPfy6/PSJhwhGZ+zfTBRWW8WlMQum9U0u5lYfcZ49UkRf+JvTSKs8Cna6kG6ZZC
	EMIW5Yd7nYCnutt2+odxbkgiJaWEsPGjv0IpbjGCIh0gtSFLPfpYRw8ieNAoGKhu
	+cCnT8Bv6cf0JiZ9k3GM6nFxD+WkMyJm+6ZTbZk/8Hb4q3Yovv/a8zeFbwM1M8go
	Os4bxaLk3C2xqaLBfHgjGtfTIlFSs/m4aarMT6+FyEpnNMrjJ3GFqmAHIfp03Voy
	s5xNRw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff81390u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:43:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38869800848so12364656a91.0
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784320989; x=1784925789; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6+db1P5RhSgKDmUAmXoiZyavEFVSigUv3Np7w9qQeMU=;
        b=ezxQo04xZP9BFLGpbM2RE2u/x1l4wYQoB58tAIEsNQEPXD+5gWMPQCglmFHsgIl6Dg
         0okJ59XA9zsrWrm4QZxf4XGj2aPQIzSru8ksIjO19tjRNgUVLA/2+sEeN66BYcL3TG/Z
         IbXZ1kMpBW35fxXP6VwRV1zpgaoSBrNSMZFBQyGi4iyW6IfQNAtKR6uGJ+dsGcz2hysY
         9DEDstKyLs79cvHiVlS8PtDYy9k9DFwBsS7D7tbyZHKqVhU4l/Mqn/uZE3GXKHv2Nong
         ELYAMiQgZyrVd7TLoYGDC/y+wfoRkmkBf9E/o6rsa1Da5s1+//zZhkV+fF0HNTDNYuM+
         r7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784320989; x=1784925789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+db1P5RhSgKDmUAmXoiZyavEFVSigUv3Np7w9qQeMU=;
        b=lH7lLqymt4C37ZUkM86oJSQH9PhmuAFQJ1OO+yULwi6+22/LmJea5fbErbUU/ZCXDr
         RYbRPW/JeYzr8047aaqJajpXHRl9zLV1cBOEOBP5LyY1QinQ49kbVwhvxhPY8QL3coUX
         dNb8DbwPFQ7g+v/DL7TI8+jpj/um7GpSNDKrBjM6DO27XIVlxXfcdMn7GQSrnz4p4s4f
         5cnYmWtCa6gSvhxCYKDxvZ6Auk4mqQM1Xh4bInR71HWgy3LfPgp9+rHhNiae1LHniTjK
         wkU6yYEWdYtv/+7/MB6V82PwzV3Ws5l2X6Vef/UdU6wXmBh/sh7JVK2kK5XFpBHHrYAi
         djbA==
X-Forwarded-Encrypted: i=1; AHgh+Rr87fq/5rkSqjTavDiv3QclPZQSPhyAlEiE5NSJeSFmRuTISG8PY1AYCtsaWvZtTNUU+yNkgw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx54ZgyYkJ6WBYF7uzHTyUzVWGtoeSc6mFnNiTW21xHMriSYaRr
	gr2uVlN/vLRuT62v3pO4+frBCBDUcsBmPXpTO244sAAQZBhBGzaQAqFmhm+B7KUExIRPuGe/ghz
	1hKg9jI8eoiynQOigJXGpu9Q2wkCEyhI92NwWukTvIZm+2HYxuQ/AtR7guA==
X-Gm-Gg: AfdE7ck23HYubPIgXdFDKTRIbmi/gmJzXmw16Txl9hjXeelzc/n6oUvkFtBvo6GNrEI
	wIMrMOZ9A95VLheIFBmugvcFXF5ZtiwhpfDqTlzi7NwxXBNVRpjMsP4GVHAxN83bYJ4w0k+pdbf
	7YAjxenirDvSrmW2hzd1apcTpPWDFwYkdJoGXqGUG+PmGSZWSsxjgmbQKrLoglEXahcOztWgVwo
	MpoTzIbce0vVyZkWZ2HXpLPiawzqDQaAJsXdGOCGD7pvqfyS1/23OAM1tCJC0riPuKeXUJek307
	Rty4t3MF2NwMD0L+RPHDFuF8EpklYt7vYEV/IaTUHv+kAneX1N5ANOnzOIDOYEG22ydVE8XxpLT
	X3uZSKROa+tus3f8HAX5vj2vJ
X-Received: by 2002:a17:90b:4ccb:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38e4b57c2edmr4367645a91.38.1784320989056;
        Fri, 17 Jul 2026 13:43:09 -0700 (PDT)
X-Received: by 2002:a17:90b:4ccb:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38e4b57c2edmr4367589a91.38.1784320988324;
        Fri, 17 Jul 2026 13:43:08 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:43:07 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:34 +0530
Subject: [PATCH v2 9/9] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-9-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=826;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=X8RDXfBHklja5EB34gmFlxaH7HzFaYeX4Z1IBHMoit8=;
 b=9Q8iDnAw0MhJOK5ZVzp6qxDBJ1QRxddOheLScWmDbidXJrIMQnonMmlM6v+PtlCEEzK/dtESK
 DatlP1RAZO2COPGL6D6h9BFfbWY7fTmJpoXiY4tftEFy1+oli76Z++j
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=RbqgzVtv c=1 sm=1 tr=0 ts=6a5a93de cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: ZSXVZfqRb9_UbGJz8jPSEhRGpiYyFp35
X-Proofpoint-ORIG-GUID: ZSXVZfqRb9_UbGJz8jPSEhRGpiYyFp35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX5B9CpE8jBjfa
 YG4BX+eTcx9qdwlKBKOCN+J/Kjk1ksGu5CC7AhlHC4opi/Q9P3FGGBz6UZto9mRp62wZO6cOlhi
 4BWS6D8PKYvUqeXDnb1Bh+zjy6ZoF5u7rua53glLAxhJxEx+mQCCfVEZDD6EqHk4mFY6jHkzxsv
 PgIhOA5G/pHYAs5b1u873NOyTfuiv3G5uQ+0lu0Zg3kk+ioine4keNtbqpb8HtugaiNJAQz8yq5
 Yk1l2xY1L/PkRvpppOui+/SdHWJjtRyfs2Thnx1IQVibcf60XJSD7W/SpGh9t4PbbW1kWkoHhon
 G8up1nSMWiJ4dDZboRGELptUU/zk9RSCf5inLg8w9Opll+O5XEnYAAWGD2Ui8IW1rfhdc0ssisV
 9rZchJiEIzYswtxS8wWdhLCpOJ79xxEKMZhgaMkBe5+N9wS9c5slzHSNhwenEe5gj3JO/tfUOWj
 RQdplq3u5bGkbUJCKcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX4fjLrjJu/mI+
 MKURhe1e+FAJV51S2neTPoD5VfU/DtMx+TqJQm5EFVyerMlPiBX2Reg1KJevTY32qGzQzPhm300
 Hp2O4iOZaH6rNPuMccXxnDAWHQRLyNE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170213

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
shader firmware path.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
index 1374afd9d14e..a6e24d2e3b42 100644
--- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
@@ -417,6 +417,14 @@ vreg_l7k: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/eliza/gen71700_zap.mbn";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.54.0

