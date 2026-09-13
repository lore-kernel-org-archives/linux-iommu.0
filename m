Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5A3B7747
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325418; cv=none; b=VhjiKs/uHAqc0jYq67UXt0+BPAcpS8ULNv8jvyIqcj1gijNgXPnR0bUpcFVXT9IcPDlGey0RuN2iUdj7lohldCu7O/Hdfp7ilRSV0DoLyj324JZGjDuuqnwgej66H3n09fprPQUnyLmGnd78+tN9es1dImRpViDW1KsuDUMIKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325418; c=relaxed/simple;
	bh=Qa2Zp3mtOCmlv43McNFjBc1+0AJv4pRvdWQWwZsWNKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lozA4iwu/W8kFUpcd8J1leyrFAT5Pmwvo1JdQ/52EswSswGH7ZJqrv+SwTW3gXk70Eh6C8T7OEaAbG7FlfMoIeiH64qCtFmZpdi9UxZ7F3BBlO0/o0GLjWxQpefciuX8ZC3qRta3ZBGPYdwxzA9hQu6qUka72z3YNKYvFZOnHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f6fqQAGT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z2Ai9svB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f6fqQAGT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z2Ai9svB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DI2heA2979814
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aDXJrtGXbNQEY/5xdA10m94DDaprg9EVDMwPUbR8BWA=; b=f6fqQAGTN7OMA4qJ
	xIxk8mrcknnfqkJ6jQgWFkuDq5UyxcQT6rlGPxYm68EnESAArus4TYKzM/D/Ac6C
	NEEviq37sA0YNltC/INEqZSPOzvhTF28gMS5iNqyG0h8iYFF89XJdjIOGlli4N5I
	+uLm+X4UbPkGHHy251nozwXOX1hC7asPstwkuDe6Tq6M1bDykFANehMx54gRGD5k
	D5bzZw7Yprt/ODeOmgntKpF/OIrFcczaunlJB4scW8F+YBGLLD7WhAmKptTB9O30
	dfrkMh3bfv/5f1kIEqTizxZWwXLNM+vDcwlAioxZm8yIsETB5iXhLUjZ8k2+y+KW
	gbgu3w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dkxeu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee1ec30f2so29344055ad.3
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789325409; x=1789930209; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aDXJrtGXbNQEY/5xdA10m94DDaprg9EVDMwPUbR8BWA=;
        b=Z2Ai9svB/XdDNNQsp5pxg7acLtaKBo5xSAAvsbEULzOAMIjD8dKPaVfdaOMoAPo3+l
         zkBl1pTpPWnRQkTv+bN1tsb1XVrpQutrTTMDElq0O3zPG4bQ7JRKZeU1Cvmf5SSDkJ/7
         6l9gey4T5PRADIYIxR6wsRTjbJ0H47CbIE5eQDu3jLnquEJ/BddMSZNv/rhr1KUZ57kk
         r+lGqgjt+MyvoFTZRTzkabrBxmKsgFtpEnaRTEEnP2rt9loqVkAcHUhg9NjTu8IlsMGh
         2iaKy0IUXc22RNCu/P1/40qLxkUWUknFASX+o8VWRpZfxbIM9MlOlVHbBP4oT9ub1PWf
         1Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325410; x=1789930210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aDXJrtGXbNQEY/5xdA10m94DDaprg9EVDMwPUbR8BWA=;
        b=dNaRO2QGKCOtz8NxoQG6UzNCFUWTZKnvaEErsimss7WEGcSZSf66A1P0rDUmX8DHjO
         dnMEthcCV1vsBeZYQXWjkZb7FLYm4slGpZaNsVaYxegUD/5Vsq/qhMU2E9NttW8QktpN
         ufBvq6unBmlAsyHIC0P2WpfA3lZNfbb6WTqAJQaQ3c/DoCGAgoSKwK6o8V0b5faWTgj5
         ZxnHnokc1zYUheh2uQ1/oHcK/xoo50aGpkenkGZBmFQp0h+MO6hXFDGX631sCGiYXb7P
         SxO5OnFjgc3uQOX8DFsRtx/y/lRZTU2lEl+U1eBY6Cj/PJ7RDFPizOMTRx53sl/nZjE4
         3yNg==
X-Forwarded-Encrypted: i=1; AKwUvBzJs8LjS6sSaEh2BTNdHj7jOF7Zpklv3Sac3nnHfO3pO4CXQ0MBEO/McVMIVuwhgzhWFTvobw==@lists.linux.dev
X-Gm-Message-State: AFuF++niGTVGuHUen8+f4e5Y3JWAfzN7XISNZpQl2sJv26Flg3uDFF1f
	Z7iroZwSMxSKa2F2uZUBQ8N4o3JmdlM2qeM9I3ZK+lSF9Z9avl+NUxz5HnM8SZ/CHiYzFz8Wl8J
	itii9SZrhWmiP4FgxZdFVH74ZsWGNuiygsMFJl2g26/7ahfyQUkFhR+lHSw==
X-Gm-Gg: AYBFou0laggw0CoEyAcy/DLIvRTi9Za8IoPF9TlyerxOd/F12UtGOyqbgFeHkLsehe5
	7h0fr86KCFvqSmkcdv4x4KPUeFefiY+TF7BH38rXLkE9dQRyYxoVDiWCKA5dKLb+SS5RA1xdSqn
	TzZU73U5T7G6DhT9/UPt+Zgv6ZlRiiMu3s6YuTdzhzUk+3uBnFyVfy7od95kY/PZSnHt6p+wtlL
	KhNC7n9sWuR7pYN96Tu0lIAGp9k/hgAAbIGHMSuYAEW66L6qhxBE3nMFT9ALWQaqPm+f+UyzYZ2
	tRkyeEMaps/QmzJsYEsSthSrQjOTBAClwGoiWArVSfHdP3GNJDJCGxIAMoxMB4c98sVWYWTvFWA
	MUwIENNU4JOtj5AvHAw+9kiWEFK/6QseqaH0=
X-Received: by 2002:a17:903:2985:b0:2da:e67a:87d4 with SMTP id d9443c01a7336-2dd2a35dabamr255818675ad.19.1789325409436;
        Sun, 13 Sep 2026 11:50:09 -0700 (PDT)
X-Received: by 2002:a17:903:2985:b0:2da:e67a:87d4 with SMTP id d9443c01a7336-2dd2a35dabamr255818375ad.19.1789325409013;
        Sun, 13 Sep 2026 11:50:09 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm22473130eec.24.2026.09.13.11.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:50:08 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 00:19:20 +0530
Subject: [PATCH v4 03/13] dt-bindings: media: qcom,sm8750-iris: Add context
 bank subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-vpu_iommu_iova_handling-v4-3-9b9074a73c41@oss.qualcomm.com>
References: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
In-Reply-To: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789325376; l=3817;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=Qa2Zp3mtOCmlv43McNFjBc1+0AJv4pRvdWQWwZsWNKA=;
 b=xKgMcGQDCsIW7jwgLM4Vnl4Qip4e1w3iS81Ohhu+3VzMXymIU74xzNdhZBAkJA7C6TXdaknjW
 J5oxiSK7hAiDI3mR8Qncd3xzM1hf1Q/GSpQx6fmrXThtgLeHH1qS4eD
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: KV_Gmj9Dv9Ib0SGjQJaBvUgdx5v92Dm5
X-Proofpoint-ORIG-GUID: KV_Gmj9Dv9Ib0SGjQJaBvUgdx5v92Dm5
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa6f067 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w7pRem5UOBajBC5HA0sA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX7B0F8fu4FwMC
 zgn2c3SDgIPIiE2hD2oSCUY+m8ioG5oZ5dhJ5z1zfKshdDsvt0gEA53mQkwwF24mRQ4wsphf5tw
 lfJtw/tJT0c39hNQnqFgQcHY2B47eRQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX+DoTRsE07nGt
 MH0O+HwLub8JsHRDaiyBTxGRo/zfYZqIQeo8mLVkMYYxm051EZOfUhKhLH1/VZ/q6MewwezHVgS
 f9es0Cedb5eCA3+9E03tZp7yqZJAXKQNfS8lvq/INU6wd6rX5cYkUcgv3Tz4mmFb2SXk9MPG8Pt
 t67WIayVyqA/PH19ioCIUErUjg7L+YmNRBMunGCv2je8ADHcAJP7L3VJ2gCmWx4dMlGmTijNteg
 WzsampbZYpYv5B9UVdkZwzEAbGcfSBdtKDAt37TSuY7DXMM2YQePzhbsL3CvHkCD49Ly6MyBNw8
 zdHVw4fQjmKHjmYZ7eqtIzjt/vHBubXIXJ1K/FTSk/ahkyJHLKnUmfD8Z+pOfQjXX8FV7M/UOcp
 g/5K1+eXTCK41O5q1hlCZ6+FEUvz83nxS4kcrV8YIihsxeX0bs1Lda+8Yhy7gcDLOKvlc5HxKCe
 N0FkTwKQ29en5ere1IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130267

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
cannot address the low 600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
A single "iommus" property on the video-codec node puts every stream in
one IOMMU domain sharing one IOVA allocator, so nothing restricts a
non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
that boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots:
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Given that the address range restriction is for specific VPU stream, it
should be ideally be moved to that stream. To achieve the same, a subset
of streams is now represented as subnodes, so that each can be
associated with its respective addressable range. The design was discussed
and agreed by mainatiners here
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org

In the past, this limitation was addressed with an iommu-map approach,
with the iris driver dynamically creating the devices. That approach
was later concluded to be a hack to avoid having subnodes, and was NAKed
by the iommu maintainers. It was discussed in detail here:
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/

Update example to the subnode form. Doing so, it picks up the supporting
properties needed on the video-codec node, address-cells, size-cells and
dma-ranges to declare 1:1 DMA translation into the parent.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../devicetree/bindings/media/qcom,sm8750-iris.yaml      | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml
index c42d3470bdac796cc878090e65becf6b62bd80ca..b6d5ded1aae6a1a6836c2c24b1dae548cdc6f9d2 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml
@@ -72,7 +72,6 @@ required:
   - dma-coherent
   - interconnects
   - interconnect-names
-  - iommus
   - power-domain-names
   - resets
   - reset-names
@@ -110,8 +109,6 @@ examples:
                       "vcodec0_core_freerun";
 
         dma-coherent;
-        iommus = <&apps_smmu 0x1940 0>,
-                 <&apps_smmu 0x1947 0>;
 
         interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
                          &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
@@ -144,6 +141,19 @@ examples:
                       "core",
                       "vcodec0_core";
 
+        #address-cells = <1>;
+        #size-cells = <1>;
+        dma-ranges = <0x0 0x0 0xe0000000>;
+
+        non-pixel {
+            iommus = <&apps_smmu 0x1940 0x0>;
+            iommu-ranges = <0x25800000 0xba800000>;
+        };
+
+        pixel {
+            iommus = <&apps_smmu 0x1947 0x0>;
+        };
+
         iris_opp_table: opp-table {
             compatible = "operating-points-v2";
 

-- 
2.34.1

