Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0E3D6CAA
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964438; cv=none; b=Vh1jFJIhF1EA/S7BIXlo5whcXioy988PWX3m0A22HZpzDkWZUJJvZyCeupy0Pc5FJHqjPCT9zeTbFY0rfZs2Lrm+xkz/lrMBdzpWpDpEtIXE8VBjGyi1L/OcMlUv1G3kFteLQ2O8rV6Pd+l82OsMkuIMN0+AiNSzpf4KBB3TCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964438; c=relaxed/simple;
	bh=XCLAciwoGLa2sJvy/DDGRqny4ifzNwzjaeJeVzt0PYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0gA1hAhI0RsACQ0b+Q+hqLhFiwNPknDlo3FDwuMyBd/rpsvU6zjryN755I2IlSN27PNXMHzBRcmeKtP9qxFDZducWr5OV73S16KbLyEkYR8W4vsJeqDAj6Po3B4RB1Bw4W54KraOH51fMyRzbSt2d2Y1kFx98047vqBqwsKqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XIYAc0wF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RvxNOCAN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XIYAc0wF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RvxNOCAN"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64501pm51346212
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 07:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mCM0+/uGCzj/hM4vy1/xEsxuxsqzm+PtmpUe54/lVkk=; b=XIYAc0wFJxzEGvc/
	aUOolG4rOkBmutVXUNU8SM1/TVb6OL9iXDBL+kom2dgZnmX9RYWvTs4JOoOd2wvC
	D34o3YbCKlu+k/Oxen181/BNCJSusv0IsA/XC05XKLQb+6CBJQjARnClpb+GLt3Y
	im6Q8ddCxXFEF1vA3rO8rNa55ygB8vNsYQt34QxjrwVxjvAKSh9YNOvRAwc5vjk4
	B7wuy8MOacnb9VRXE1vIyXYDDQomFu8BmtVjoMcLoXnFrSpsqCHFf95bSFgEY73A
	8hfeTRsHWcGWCij8E2bBZc0+KKcHV4aVy3hA9aiWoSdUkO1bdACZK9YNPzeKiBj0
	/XrNyQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx2xaukn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 07:00:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36555cee295so1534653a91.1
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 00:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777964435; x=1778569235; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCM0+/uGCzj/hM4vy1/xEsxuxsqzm+PtmpUe54/lVkk=;
        b=RvxNOCANw9m2QCOzL3RhcmPl3HQ/t7MPmyF+0vkeS7UUNdN+Y9YXoMJcdImORj+jyB
         ZbKz6kWooBqWvrkFjTTtSVGJKRfkjqcqpejnNy1mFP4XcR5EqjVt65jIQ9iQG+AUFCkh
         f3/uDtbwaMQ1J/4smG0kxOEgA4liFxC15uIRZPzqCf8Vku2RCUfc6BoM2fSrOF3NWmQo
         Ai5IWXZgq1ox63q0yj4leivLjgQYbi212ehJCpKHdsBO9KH/XBjWM4MJpU6uhsb9V7+d
         sb89rtYvr5PAqvVGD9zs//o7JWh1Bp956iPX8/+WyWCnwyxG+1+kt8ARpwGtPe+AMqv3
         WWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964435; x=1778569235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mCM0+/uGCzj/hM4vy1/xEsxuxsqzm+PtmpUe54/lVkk=;
        b=lceMaAADlQomUZPtEX7rQvVvzGVsB5EUlFkldoJx7j3MNejFHRYDsBY6J3HXdPobq0
         zavYnxh6YODgo1yAK21s5PxNuI1a+WGik2kZSlqQFgeP2h+P/Pk+/PE2XHrYX1pVqgf4
         cUQWv1Sux7nMO6pRWG+PQJVn/72AGPLOlxQ7oBgLjqI0PAbGQ7oDoXRmscZ6TL/W5eEW
         avApgBsAPOXzgyKFIbcLCaVMisaSphhPLi3phlZsRVQmzz1i0j0ZG6JWo6yBEDS+xooA
         QDUvoaxi20Q43Jy9/HCUfC6FjxP7Jk5h1kPXg63hYjY69F2v/lMbr3phai8pu3G97FIp
         pwYw==
X-Forwarded-Encrypted: i=1; AFNElJ9hAlweKyU0cQQCTekoqqIVWXachRpe4tiC0AA1a/xFQxwRn2A/tE+Id4Mgj49dVrSLM0DYRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOhXxb+n2cVHUzQt/U/PsljfndAWiBfQUBCD6YVZEeJbo/q1EJ
	taiuI+iRb0b9QDZ6ScN50X5xKxh2VfBvFM1uEuO/Cjb8C6hL5gy0UZPKBLDt9eaYYQqdu7OyIOA
	vxgVyoOBOYoQZh9/8LcMXaehFtIcz3kp2yndk7+Y9st4+0NQ0ZvKVebdvUm3oqqUhww==
X-Gm-Gg: AeBDietjPUSx82gzBWmw9FLmoqrCVeW3DOrj7A5mYL6e3K9X+zWJKBb/DIRbQgHQEUz
	WgO/P4p5dT4vrqhX6D4MlpMi+fz9IK3NUlATqx8UkLLgHX44mW5PtKqiSDepLwDF592jNVYVR7j
	1XV+szQyzAX5O1SpIYZYi+1PR/nDcX/yC8DTqC17nFFa416i/a/UYMEqi4yksyH/SH7PWt6dqvV
	Cf6jQzdhQFHxP1jGi71/Svguqe2WqkXrLKw6FA1t8y9/bfwfAjJEGHT0/KUyYEm14hkY61GA8Ro
	Y8cP6JY4WdH+vt8uaIyxNFdc0ILsgHi0qAiwJT2o2CIRv+y7gpyRKROlLxVOWJ5Dn/Kax7m7DWK
	Fj/IB+zGl31acK8bHeis4jZQmNDLDHLmp/67glv1jOvVe6AJFcZodW3RABeBy4H3baQ==
X-Received: by 2002:a17:90b:3c85:b0:361:45df:103 with SMTP id 98e67ed59e1d1-365773ba9b6mr1998788a91.12.1777964435347;
        Tue, 05 May 2026 00:00:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3c85:b0:361:45df:103 with SMTP id 98e67ed59e1d1-365773ba9b6mr1998752a91.12.1777964434865;
        Tue, 05 May 2026 00:00:34 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm13840146a91.2.2026.05.05.00.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:00:34 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 05 May 2026 12:29:22 +0530
Subject: [PATCH v4 01/13] media: iris: Fix VM count passed to firmware
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-glymur-v4-1-17571dbd1caa@oss.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777964421; l=1361;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=XCLAciwoGLa2sJvy/DDGRqny4ifzNwzjaeJeVzt0PYg=;
 b=ktXf49S5sgx6u8kMejEzA6UiVMOHVQS4joL+4BEKP49XKZ4vQFp65+/vb+24gDkEP4GS3Qp+Z
 Jr0woULZO/2CoeWozlpPFfxeMfe4S8Akw5yLupWJ66leYOiL915/QLW
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=U9eiy+ru c=1 sm=1 tr=0 ts=69f99594 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrYi3PkkErC94SPB-twA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: vRcwMUY8LOAsYk_gYLb4oLQE-bijCIcD
X-Proofpoint-GUID: vRcwMUY8LOAsYk_gYLb4oLQE-bijCIcD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MiBTYWx0ZWRfX1YeDzp85/OPi
 e61DY+Zqec1jWeZaNpiW7p2Ss1WiTkZsV9pTNY3aUtsRMPsPsRG6Pz1dBeSEBMDU1fznuNQm115
 gs+p1bDg4ZornHBNnKVnnmR7cDNMjIMP2l8o4Sunqbx45q9aPRDPH27EcgXoiczerkDK5cRGcBk
 YAiU5VYRtdmvbfopAkdgmIs6KpN1RKgj/Pq/EfVxwi2adQzzDhMdr0+EuxpfKhObgRedOAJWRp9
 7o/XS6KYblBfZdADTyMuiIzZn4Z3zEkIAiAHLbRftGL4cSWgOaUE7uPrWw+6YXFFlNNtIfD82o1
 3V4izc8WP/NlUBqTn9TIP6T9vcQsgSnN0b2NzgzsYGsbIzZA5pSNZjoba1fAo1yBihVR5mGxIuH
 WEZZHyzA1DfSItdQ+m/H490A3KbJrFY4FhYEYc3/qKaFhFuVSi12dXtEe9iy8OTguXYoBylMJa5
 jBKJ6hJ+/s8y97BXvCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050062

On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
the number of virtual machines (VMs) and internally adds 1 to it. Writing
1 causes firmware to treat it as 2 VMs. Since only one VM is required,
remove this write to leave the register at its reset value of 0. This does
not affect other platforms as only Glymur firmware uses this register,
earlier platform firmwares ignore it.

Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 69e6126dc4d9..f1f9e04b7c31 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
 	iris_vpu_setup_ucregion_memory_map(core);
 
 	writel(ctrl_init, core->reg_base + CTRL_INIT);
-	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
 
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(core->reg_base + CTRL_STATUS);

-- 
2.34.1

