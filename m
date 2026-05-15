Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DD47D927
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844227; cv=none; b=SOVKHV7hzzgtGg+SlJtvbOjorqmNB4k9BXg05OLN3dk/QLs8XjvBAVht8tpvtnG94zYzBpdY2DKQATcoLaRoWOtfMAxOVkzcLOqZIaV1HO8WOqPcCn+m6U8N4svIz+UlHFQJjtd22tcQuWdzQmRN0X8mm/8IshfmKCnuU1CnazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844227; c=relaxed/simple;
	bh=I+FhCbobG6kZdRoyaisDIn3UKwT9sap0kLYTO9LJWVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fC5UPU/HwocBVgbm8jqd3SkrwnmYO0ZJH9PtlpLK3JegHS6TwvSbxihz5xHBteyT4spzSLo/wzzrC8Nw02B9lWXvvRO7LlEO+d8NMhCFW541a6HY5AvU+XcNC7iVotKnO1Lpg0cAG5um8Tu0S8wDc0jxBJFrHiZR3pyYkKxS9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lmf/tbEz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ahIpBowd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lmf/tbEz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ahIpBowd"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5USUY3200389
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uSFq1izJ77a0VhXBlRZJfgQFGF3dtNG+x2g54MrIho4=; b=lmf/tbEzdF6ICGA0
	SPWcXYO8JX6BNlrJwrCrW2lc8dT89Qmygk2pTLtq+pnuITqDOLQ1BR1y9kCYCqgb
	Z1Z8s2JRCfGMw+8qVQxfexqCTiUNLDACJoAEzlrE2qpsmYQSOyv2ml495Bw8ZI1S
	onVTTym3WrjdoaHcHOE4x6P3YE3zgKv5TEu25WjmjIYtt9QtFfHZaPqljJ7DiLpU
	qoJJD3zw0HH+aCErebn8sEedhlHk4nEt/vwVW7JYlC7To/jWEnxTMJQhILmdsGhF
	vKLnZcpW06rWkqF0KbNsBtSXRCSBpzp2W6lmcJ8iSiQqCCFb8he8wOhumAb7Rb0Q
	hWAhhw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qtymh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-366ded3bed0so565613a91.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844225; x=1779449025; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSFq1izJ77a0VhXBlRZJfgQFGF3dtNG+x2g54MrIho4=;
        b=ahIpBowdE6ICnk0UqP4Iy2VIyDNFKNmgYvCbPGFD7BmLljglAkUAPL+s0RqEM05snf
         oakF6Gwg0evx6CRpQ53ExplaknUj3uI5CEHYLH0EkM2sWhm8IqVqn4CL9l6cRsFtFhp6
         zbmocJ1dWAQQ5UdPQptk3ekcogMQRhaTGBvJbrnbdE0rq31ijVPBkTKrsQ9cj6EP8uHI
         BHoe7kSUgp6sRVbNATwA8rUgnPiiLhlreR9/T2FyV1zfWEBU3i8Z+h/D8sf9neE84y0Y
         kSw0WghSTokzvCuy5f0on8vodXf2Q5vhlBCrYonmGqPbejcQT0OIhNWQTB2t07JOg69l
         MmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844225; x=1779449025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uSFq1izJ77a0VhXBlRZJfgQFGF3dtNG+x2g54MrIho4=;
        b=a9sHG8yXyxNhqqNINgJagB/0pHa5E55XXNQktpEqirEEwixAQ+1owvHaErrg7sn7A7
         QtEbAowwPNbzq/IxUQ6WjMh/EGrVJuoftey0XOANcV/moZvklEz42CMGG8Uowa0rAOg1
         i8+5EXQPfKrNN2mG/qIpiSy2KslUcKsnkWSGyspim8NAu+GOXUazHaCRwtsG0Q0iRqte
         Ad2p9zvCjOhkn4tcsRWVRhgQXZO/I5SAnQQg3x0Sj4T4UVeP57k4REKkbxYJKnGTMuTk
         OVd/s8hjkUQjXgZCStk+6o7nuJmmlv7lU9A/a+UnOXDYMdJepd/AINk8Ts/EiVb9hlYT
         5e6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Y4Bli7RhJFwBJjQ0CRW+ZxyH9jUOB2RRpAgXyi35JVPwrmVwQqJXyF2HmKtyJNWiy6XBhKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhR4q1I6vF6ZtibZPzIYBsMtGUauYs6uFdRcZAAVSCuiV8MPJN
	eqjH8g5YWY7DZDVCzkgP0RgWF9Bit1juPVwI8SOzog0osSD82ZaaQGgL48Pd422o9EHBbtelG4f
	uZ4ra22XgqkeYNdRY9FXKJ21yqfbHGCpmPb1hmDOEEapGbhN0yDgskzv9Uw==
X-Gm-Gg: Acq92OGqYpMN+P1kqdHB0ci6LnvCokcAzu2uQJhFT+n/IWOjOOTlgwjnQBbH697FkkW
	1DFMW1gxbMLI6ma0ir9ZkFdodQegPwcg/UETvGGGcLib+/HXH6apPdki/yYEGK0pLiigU9viCjc
	xqpPEVETRPS/7HZp/YhqP1wvDMyEDwFbY9Bm9pVa8PPivUKhv0ALmqQ42Ss78k/tQawSHy3BOvl
	Nku8jWymWxtb0LwnC+l7boFRw86vI0QP1IaT6qZ0i8zgWtn579YC7MMbHiuZ2Y+REteVlpgSm/Q
	ClKL5xWOwTVbaPLWOiyEMrHlLyY41LkcCts0W6BxJHGwaSXATkyuIMZ0M5aAkpbgi1QJtcQidXs
	392DYcXy/zgzYGsrdoP0sVjWLUMZVBMddq2tsWkhvExNkzmHOM5SCxc7dM1ERg+x4Yw==
X-Received: by 2002:a17:90b:55d0:b0:368:2832:34fb with SMTP id 98e67ed59e1d1-36951494a98mr2924751a91.10.1778844225026;
        Fri, 15 May 2026 04:23:45 -0700 (PDT)
X-Received: by 2002:a17:90b:55d0:b0:368:2832:34fb with SMTP id 98e67ed59e1d1-36951494a98mr2924726a91.10.1778844224541;
        Fri, 15 May 2026 04:23:44 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:23:44 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:18 +0530
Subject: [PATCH v6 03/14] media: iris: Fix VM count passed to firmware
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-glymur-v6-3-f6a99cb43a24@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=1678;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=I+FhCbobG6kZdRoyaisDIn3UKwT9sap0kLYTO9LJWVA=;
 b=yJSdrJ9U327Cl28LdY+SOP62A7gkCxLZelqSbuJRMwwdlMsr9bwa/rishfpbzasDkgnPXhnQB
 xWl01CKrnjUCS5apq/6NmAuVWSZB2FxH8R6nmdrWj3Cj7pW7WHPh1Ly
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=HbkkiCE8 c=1 sm=1 tr=0 ts=6a070241 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=G9EXm27dpV9j85VmElcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: efwEnFgDIY6n05PuDUJ96b28tnYiJdNE
X-Proofpoint-ORIG-GUID: efwEnFgDIY6n05PuDUJ96b28tnYiJdNE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfX3hLL/M9kHFIT
 QvuLuYGRYqp9ozKFScUilct7gcYuvk70Fd0fQ5HNWDNNzjBuupgaKcDlxp16a4bJx36zCajALXl
 8AnMgmtwjaZHxXQC4ug0Gr9v/uhQ4uNFUQWT3mg9HlIf0NlWqjwmbj3W0ji5x3E/O7Z6S0dFVWs
 suun6Ly8F4Qx8GxC9rA2vEAHmiWxqkOyR+uKGybaCXBIUonvO1oV+UD5hhjPiyupjAc44NYx0iu
 oUoHT98JbsXh36MZVDQyG1rQTZX/zZgTZ6SYn62uXBvfAZWiXW66UU8Z+36lC5ws53WJgWyDUbe
 11dFPnLSVHUeHwImpI0CyFYabqN1opjL23Y2TDegiVJKuypO0LRkNjGH4FZM1uMVm7HKEUWc1oW
 P0UHd855mg3OnWs2dlOcR7KVowNX6DjkaWOsUedcbrAAgXxkZzWXceNdcK6U3sFIS/n3KfieyKF
 syh4u62GwyLBcifLJoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115

On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
the number of virtual machines (VMs) and internally adds 1 to it. Writing
1 causes firmware to treat it as 2 VMs. Since only one VM is required,
remove this write to leave the register at its reset value of 0. This does
not affect other platforms as only Glymur firmware uses this register,
earlier platform firmwares ignore it.

Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 7bba3b6209c2..df76530be809 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -26,7 +26,6 @@
 #define QTBL_ENABLE				BIT(0)
 
 #define QTBL_ADDR				(CPU_CS_BASE_OFFS + 0x54)
-#define CPU_CS_SCIACMDARG3			(CPU_CS_BASE_OFFS + 0x58)
 #define SFR_ADDR				(CPU_CS_BASE_OFFS + 0x5C)
 #define UC_REGION_ADDR				(CPU_CS_BASE_OFFS + 0x64)
 #define UC_REGION_SIZE				(CPU_CS_BASE_OFFS + 0x68)
@@ -78,7 +77,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
 	iris_vpu_setup_ucregion_memory_map(core);
 
 	writel(ctrl_init, core->reg_base + CTRL_INIT);
-	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
 
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(core->reg_base + CTRL_STATUS);

-- 
2.34.1

