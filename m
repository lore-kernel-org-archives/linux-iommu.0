Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172823;
	b=HRyuhe+Vy+Sm9Qwk8RaaIv8b/mdZCLT5D1cWoXoXLtL1inp6D/tLyOX1GwB86ANT23Mo
	 kHYct4f7eE1LUfwotlxrLVTs1aKuuXJUla1cV2Dr8KtDKWPhPo6yKyP6A2TxA+A2Mr/6H
	 +d1JUaz0U3M9VrQVJAAACZ44Sikb6jIvZLAgrfQksHehF1aOIUi7rBH6SOCAPDE5TlAL4
	 QGNhhhxAPfBIQP/6qp+2BvbEd5Ra76IWJkQyIO5AZwIR1IKQlSwoX46MFbV1NKRwZpM+c
	 mFthzRB+Bo7t628GPup7VUhISKRtOpIPJvkb91ebXQL9WHMPSKZZS+/4sLFWRK40jIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172823;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9wp0Zy1+0zpa3C+2W/5fX2hdJ67qF+07MlJVkRCmQuQ=;
	b=huKPM8TFiz15oa4iut/ykozYOcYIFhqRBP/Bfqizt9MdcyQ+3772RHfR8KndyM2F+/CN
	 ekvodoaCH2K56L5ckSVkRJBsKPmT68iO8LOVHdhHQLi5UnKC+JtxahA+xTYss9EPzXrbd
	 8PqGTTFH4O/Y6VgI1jwnjM4DAdTIRv6MKS8fON2JkvKxJofIB9d+XjNkctFgFS+ZU20qa
	 Bu9t0ewE6Fv7YGmgRCez2kr5+1v5uKtiRMHCNuOKiO8Z2LEztyOl94zurDryoEJ3UJELT
	 vUCGc08XzCFWvuYnFGxIpkGHbftv7zaD3QCaD1So800xF2dCnVtOBsYhXewyUeD7kEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k6Ft9jzM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uci6apOu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D060A2605
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 445D060A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k6Ft9jzM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uci6apOu
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk6N23987232
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9wp0Zy1+0zpa3C+2W/5fX2hdJ67qF+07MlJVkRCmQuQ=; b=k6Ft9jzM+Hll4YRR
	eaVThWjOWxFJvu7IoA/Do60Gtn+KTjaPAo7Cpr0s9KI6+itc9jYLIJ1zUUJYne5T
	3c5HfDXZ8rKS7pde62QLuaCSn+SmHMylXGZiHYu9p4GgnycrT8rkLi8lZIZuI53k
	Pm0yQ88iv25n/1nalIpxjikLGYV21KpyXE42GdDPzXl4rV1mxPlkyea93/ZOgzQM
	eQr6kCo/JLVdsONz2XGgCQu5wIx2X8PNU2frIHavrrudyrpi3D0pzecmdROzAXcp
	rpcEaGKCXlSc0UTOeFftUD6yNQ7MgnHEenrWFl8cLcsh3ZVQCmH6EIh/+jMZ4bkB
	qc/Dlg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu813ya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-384c78aa0dbso973948eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172821; x=1795777621; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9wp0Zy1+0zpa3C+2W/5fX2hdJ67qF+07MlJVkRCmQuQ=;
        b=Uci6apOuMabM6FOV68CH7lJfcgWIS51gBWk5dU9DrWE2wn9M40rvR07p0SGLyW4ad4
         /O1i9uOkAIXPN0/Je1+R43DHvEnpef7jcK4Zu8LE8ToYcvjNM5O0Zw5UC02hhF/fWbFy
         9bAqpv4CkbENdmU1jl12hyVMEMynKIdpXvXK/w6AlaVxA4r+ho/uQlec2VG7OiKp3AM6
         EzPrD5vT0wEXqratyXkY8vM7Zhu9ILmxyXvWsFcy/7OYQ9ale2JNdZ0/rwkcopjYE2T5
         K7nB4fnP14Pcsa/XdnYIqnwfWb41oVFLno7q0eg1B8L38tBPGcymoAJUoHeI6/d9QAVt
         s4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172821; x=1795777621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9wp0Zy1+0zpa3C+2W/5fX2hdJ67qF+07MlJVkRCmQuQ=;
        b=KLoLHyejyQiPhvCwtnTLt8EF0sHa53jwF/uNzahZtw5sO5mDsR+UoCZUedxwIAy92O
         oBramDsyAkZGB9V1g3bf/EQfxO33GqWvQww1WMukP39+y/7Pbctebq2tPz5x2Y9JuFHL
         ohYdeeMp5dc+/8B3enPLxP9PiUCuxI4Tpa5X3vZV2QeYncso14SXeT1EZRxOFB1zrEqZ
         2vyszD6DwIGrYwiekbA8YJ4YRED7bqjkJB/qwzq/bQlNoosCngaSj1pVYcebqcVpdYEN
         uAEKI8/AsB98b1q0Iik+5y88DwO8ZKpdsPwHh/KD2nA0mc/orzkXeB0SLmFmnP5ru6Km
         Rc/g==
X-Forwarded-Encrypted: i=1; AL+hErEw4nisW1OvD+OiKilNusBcLybcq0aYYJi+gY+zsKKkc4xdfVeTf9USH6jbme0JOjz/8TjrNA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/cQQ1GDFdVXEcpzNNwFu/RqsZdDxa+he6QSdOMh3G+WtzTk9pn
	L8dWzhScSauy5ZOX7I9NgbxPAMXvi9ImZeTAtCZ+SR5CmOYdgcGBBKbkRFy3hNv3nrcAfFIjUUN
	mFpXctylASm010q0VPoXglRpZa45mB7We4Rt9Clbrvur6K+q4Jrl08slABQ==
X-Gm-Gg: AZFdTZf9z/lYHkU1of7Oz4BDQlw8ZnOWMMfy/SPdQAjTg5NqBDRtVAlQaxtvWGKcxFB
	908TLRsScNFNz3a7iOmaKUXnb+smXt+LVJgyotBlfrT5JM844y+FojKZd43oWPTetbUHVjNBrWG
	ED9CHt+CNiKd0ztS5LacwcBhNnyiyHC7kGwCjdqjAGFmW+qDbu3T1ZN8lip0NW+6CP9X4FoyAEq
	uqQO1MY0e4HHorp9gqPAZSTpV0zKCmPYcxKdeNyvlx+c34vyD9eHEp8eAdlid7kMzI4v9Meti59
	QirkRLcC5IqHNsQSLHL8kbDvwN/zJb5Q6r7SvUR7K9j3K+I89PW0nH3Xl7/CTNDNY/w6hj9p084
	EtpiAxC5UpWpD7ycEI51RcxQemuoefxgYUY0JEieg1+43SitxrrE1r8XWyvcii8uCCOlKKwLPiQ
	yfZivq
X-Received: by 2002:a05:7300:430a:b0:379:7bb6:9c4b with SMTP id 5a478bee46e88-385717083eamr3104336eec.39.1795172820332;
        Fri, 20 Nov 2026 03:07:00 -0800 (PST)
X-Received: by 2002:a05:7300:430a:b0:379:7bb6:9c4b with SMTP id 5a478bee46e88-385717083eamr3104290eec.39.1795172819595;
        Fri, 20 Nov 2026 03:06:59 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:06:59 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:43 +0530
Subject: [PATCH v4 02/20] iommu/arm-smmu: Add interconnect bandwidth voting
 support
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-smmu_interconnect_addition-v4-2-cab8ee8be0b3@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=10382;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=2Tn1fmNrImTIJuMoWPhujoBy9ypAmrcFqaUEL7ITQm0=;
 b=82e3NtB7zovJkGgRY6qn9VlGw4xD8oguiXH/aMhyAV0D66HhFdOi+uicnbcEQtVbudd6sGBTp
 XXV7mvXP61gCFF/Jd4OPrIq8UDWMEodObIuOHU1c4R9IDWgVvirvrFp
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXw0IoZPIjXy8y
 Ms8q0cReztjF1/GzbvI0/2y3c9E5YaE8SSV3o7TQ6MOqommLA8kUJAPvUmh4bcp8Kd3xPt/RvUz
 x5dUtJLfp/VgM6Xol7jHueqI69hs4W9cLCLBpSLmKLaT1EY0uhK0yy1pcky1yQjqu9iG/czi/tF
 aXrwNSbZ4nTbtkw/W2hoJ9dczbyCeQxkNI0vXcByQ2xepZCerAFiGJtxC9nz03HufEIIuwMmF8j
 8jKw6N0nb6PeOGPBcpB4oWhoRzD80J9PQgxjVO6Ks9FFKmQFK8GrAX0kRZyVs+Gv/pQkli/hp5N
 KRvLEX+vrzTivo0v57s2JhSMW2hAW+sglxyowJVm7kMfBWtb+j1kBpyoKck/F+CfvOxf/ZSfq3G
 aLSVG/wd+ZbBtlra2WQIk7/UGksJyr3aFpi7benD1NL9CaCM/h7ilha23rKQMTcCOSzvHqtPgZz
 DKLxqPN6B62Jk0Q4qkw==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b0029d5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=m-PSj7kzn0EKmAiG594A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: FP0eKcRlHImd6rQQZvLYPDnbakL5IfLf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX6/85X2Brxk2D
 t0C3QcZnwSisSyI8WGqEOnb778tUsHSmWQ0a5fazwI1KnzkNclvQ2qR1kzjb6Zo2VxGNpBZ6siE
 JLybIVobftSIYIuHl3SXZBTi1hNyM0c=
X-Proofpoint-GUID: FP0eKcRlHImd6rQQZvLYPDnbakL5IfLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On Qualcomm SoCs using the ARM MMU-500 as the adreno SMMU, the GPU TCU
sits on GEM_NOC as an independent AXI master and requires an active
interconnect bandwidth vote for its registers to be accessible. While
other clients typically satisfy this requirement implicitly, certain
corner cases (e.g. during sleep/wakeup transitions) can leave the SMMU
without a vote, causing intermittent register access failures.

Add support for an optional interconnect path to the arm-smmu
driver and vote for bandwidth while the SMMU is active. The path
is acquired from DT if present and ignored otherwise.

The bandwidth vote is enabled before accessing SMMU registers
during probe and runtime resume, and released during runtime
suspend and on error paths.

Generally, from an architectural perspective, GEM_NOC and DDR are
expected to have an active vote whenever the adreno_smmu block is
powered on. In most common use cases, this requirement is implicitly
satisfied because other GPU-related clients (for example, the GMU
device) already hold a GEM_NOC vote when adreno_smmu is enabled.

However, there are certain corner cases, such as during sleep/wakeup
transitions, where the GEM_NOC vote can be removed before adreno_smmu
is powered down. If adreno_smmu is then accessed while the interconnect
vote is missing, it can lead to the observed failures. Because of the
precise ordering involved, this scenario is difficult to reproduce
consistently. Additionally, GDSC power state transitions in adreno use
cases can independently drop the interconnect vote, further contributing
to this race.

The design difference between QSMMU (SMMU-v2) and SMMU-500 explains
why an explicit ICC vote is needed only for the latter:

QSMMU (SMMU-v2) — SM6250 / SDM845 era: The TCU is NOT a separate
hardware master. It is integrated INSIDE the SMMU-v2 block itself.

  GPU SS
  +----------------------------------+
  |  QSMMU (SMMU-v2 @ 0x5040000)     |
  |  +----------------------------+  |
  |  |  TCU (integrated, no       |  |
  |  |  separate AXI master port) |  |
  |  +------------+---------------+  |
  |               | page table walk  |
  |               | issued on same   |
  |               | AXI port as GPU  |
  +---------------+------------------+
                  |
                  |  qxm_gpu0 / qxm_gpu1
                  |  (GPU data + TCU walks share same NOC master)
                  v
             GEM_NOC -> LLCC -> MC -> DDR

On SMMU-v2 platforms the TCU never needs an independent vote because
it physically cannot be active without the GPU data path also being
active.

SMMU-500 — SM8150+ / SA8775P / SC7280 etc.: The TCU is a SEPARATE
hardware block with its OWN AXI master.

  GPU SS
  +----------------------------------+
  |  +-------------+  +-----------+  |
  |  |  GPU Core   |  | GPU TCU   |  |  <- distinct HW block
  |  |  (rendering)|  |  + DVM    |  |
  |  +------+------+  +-----+-----+  |
  +---------+---------------+--------+
            |               |
     qnm_gpu0/1        alm_gpu_tcu    <- separate NOC master port
            |               |
            +-------+-------+
                    v
               GEM_NOC -> LLCC -> MC -> DDR

On SMMU-500 the TCU has its own master port — it can be active (e.g.
page table walks during wakeup) while the GPU data path is idle,
leaving GEM_NOC without any other voter. Hence the explicit
MASTER_GPU_TCU -> SLAVE_EBI1 vote is required.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # sm7325-motorola-dubai
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 50 ++++++++++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  4 +++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 29 +++++++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
 4 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 795e8ec7e8fa..eee20811eede 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -6,6 +6,7 @@
 #include <linux/acpi.h>
 #include <linux/adreno-smmu-priv.h>
 #include <linux/delay.h>
+#include <linux/interconnect.h>
 #include <linux/of_device.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/platform_device.h>
@@ -608,6 +609,45 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 	return ret;
 }
 
+static int qcom_adreno_smmu_icc_init(struct arm_smmu_device *smmu)
+{
+	struct qcom_smmu *qsmmu = container_of(smmu, struct qcom_smmu, smmu);
+	int err;
+
+	qsmmu->icc_path = devm_of_icc_get(smmu->dev, NULL);
+	if (!IS_ERR(qsmmu->icc_path))
+		return 0;
+
+	err = PTR_ERR(qsmmu->icc_path);
+
+	if (err == -ENODEV) {
+		qsmmu->icc_path = NULL;
+		return 0;
+	}
+	return dev_err_probe(smmu->dev, err,
+			     "failed to get interconnect path\n");
+}
+
+static int qcom_adreno_smmu_runtime_resume(struct arm_smmu_device *smmu)
+{
+	struct qcom_smmu *qsmmu = container_of(smmu, struct qcom_smmu, smmu);
+	int ret;
+
+	ret = icc_set_bw(qsmmu->icc_path, 0, 1);
+	WARN_ON_ONCE(ret);
+	return ret;
+}
+
+static int qcom_adreno_smmu_runtime_suspend(struct arm_smmu_device *smmu)
+{
+	struct qcom_smmu *qsmmu = container_of(smmu, struct qcom_smmu, smmu);
+	int ret;
+
+	ret = icc_set_bw(qsmmu->icc_path, 0, 0);
+	WARN_ON_ONCE(ret);
+	return ret;
+}
+
 static const struct arm_smmu_impl qcom_smmu_v2_impl = {
 	.init_context = qcom_smmu_init_context,
 	.cfg_probe = qcom_smmu_cfg_probe,
@@ -659,6 +699,8 @@ static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+	.runtime_resume = qcom_adreno_smmu_runtime_resume,
+	.runtime_suspend = qcom_adreno_smmu_runtime_suspend,
 	.context_fault_needs_threaded_irq = true,
 };
 
@@ -668,6 +710,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	const struct device_node *np = smmu->dev->of_node;
 	const struct arm_smmu_impl *impl;
 	struct qcom_smmu *qsmmu;
+	int ret;
 
 	if (!data)
 		return ERR_PTR(-EINVAL);
@@ -692,6 +735,12 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	qsmmu->smmu.impl = impl;
 	qsmmu->data = data;
 
+	if (data->icc_init) {
+		ret = data->icc_init(&qsmmu->smmu);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	return &qsmmu->smmu;
 }
 
@@ -734,6 +783,7 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
 	.adreno_impl = &qcom_adreno_smmu_500_impl,
 	.cfg = &qcom_smmu_impl0_cfg,
 	.client_match = qcom_smmu_actlr_client_of_match,
+	.icc_init = qcom_adreno_smmu_icc_init,
 };
 
 /*
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index 8addd453f5f1..12c3eda780dc 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -6,12 +6,15 @@
 #ifndef _ARM_SMMU_QCOM_H
 #define _ARM_SMMU_QCOM_H
 
+struct icc_path;
+
 struct qcom_smmu {
 	struct arm_smmu_device smmu;
 	const struct qcom_smmu_match_data *data;
 	bool bypass_quirk;
 	u8 bypass_cbndx;
 	u32 stall_enabled;
+	struct icc_path *icc_path;
 };
 
 enum qcom_smmu_impl_reg_offset {
@@ -29,6 +32,7 @@ struct qcom_smmu_match_data {
 	const struct arm_smmu_impl *impl;
 	const struct arm_smmu_impl *adreno_impl;
 	const struct of_device_id * const client_match;
+	int (*icc_init)(struct arm_smmu_device *smmu);
 };
 
 irqreturn_t qcom_smmu_context_fault(int irq, void *dev);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 8d50a4ad221d..f015985cbb8e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2183,6 +2183,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	if (smmu->impl && smmu->impl->runtime_resume) {
+		err = smmu->impl->runtime_resume(smmu);
+		if (err) {
+			clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
+			return err;
+		}
+	}
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2263,10 +2271,13 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, ARM_SMMU_sCR0_CLIENTPD);
 	arm_smmu_rpm_put(smmu);
 
-	if (pm_runtime_enabled(smmu->dev))
+	if (pm_runtime_enabled(smmu->dev)) {
 		pm_runtime_force_suspend(smmu->dev);
-	else
+	} else {
 		clk_bulk_disable(smmu->num_clks, smmu->clks);
+		if (smmu->impl && smmu->impl->runtime_suspend)
+			smmu->impl->runtime_suspend(smmu);
+	}
 
 	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
 }
@@ -2286,9 +2297,18 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	int ret;
 
+	if (smmu->impl && smmu->impl->runtime_resume) {
+		ret = smmu->impl->runtime_resume(smmu);
+		if (ret)
+			return ret;
+	}
+
 	ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
-	if (ret)
+	if (ret) {
+		if (smmu->impl && smmu->impl->runtime_suspend)
+			smmu->impl->runtime_suspend(smmu);
 		return ret;
+	}
 
 	arm_smmu_device_reset(smmu);
 
@@ -2301,6 +2321,9 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
 
 	clk_bulk_disable(smmu->num_clks, smmu->clks);
 
+	if (smmu->impl && smmu->impl->runtime_suspend)
+		return smmu->impl->runtime_suspend(smmu);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 26d2e33cd328..ed08f86cf99d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -455,6 +455,8 @@ struct arm_smmu_impl {
 	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
 	void (*write_sctlr)(struct arm_smmu_device *smmu, int idx, u32 reg);
 	void (*probe_finalize)(struct arm_smmu_device *smmu, struct device *dev);
+	int (*runtime_resume)(struct arm_smmu_device *smmu);
+	int (*runtime_suspend)(struct arm_smmu_device *smmu);
 };
 
 #define INVALID_SMENDX			-1

-- 
2.34.1

