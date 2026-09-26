Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668773955C7
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404487; cv=none; b=azxs68E3exWn1MTNGAGex+7AozTbP1CycYQ/cY18O05aBFHSLZ2cwjhgW40cv6YNokfulRKJzh32s9OmoGMWGZVEC093tin/cD6uJ0eVx6eYpMt9SDFPgCueKmc5+ecmrwC9Qn9dXq/0WmouP4r5+nvs0O4cGqOcKrcT0LXQ/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404487; c=relaxed/simple;
	bh=yHsO30A05MXmUjgWMqhSHRfHlmPgdfem/lqRi62WMjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaLt6RyyShRBitNJV+Zl7rIQK+tHvOeU1ptbpLd6n2tGG5gTioRAr77S9e/NzdQ+b9ABBd+QTSd9QuV/fjH1gjgTRv57mxyJKz+vsu7Z3vBW/lWbm3lvTXOjRJin+llZc5Ou8vzAWB1bg49B17CyQJh0AKuaNIQchuhGmIJOaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G1O8M2E2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j70CuBq/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G1O8M2E2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j70CuBq/"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68Q6OXd11949687
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KLaMYwCwOkkTw4yWr611vV0+1feJAqLJ5YJx1fFHMQA=; b=G1O8M2E23Fb8jh5M
	wQNjkVIn8lKwe7CouAF+P79ut0uy8tUQjckBz5on82zsQXRybyc9TqVJoyGtU1vU
	9AfCTXIVp8fnhro6yXiQ+T9w3NuRLr2hmKs/2jEwYiG0BleZrgYjK4gD7fnUh61K
	D2tOQXX9JqSey2tL5iKGPApTF/femUtuc8YIoGJTFccMh3+pBAp+l0uYE5cYXTFD
	Zpx08LKqEqwLCTHQpr6uju5s1gmvQMWXCBNQhtHGEtAGiYuOQzHpxz+kIiNL4Erb
	839oBAxMYbMqx6i+boA6MO9QiXNvwxfUcfb7zWcg+H9j0OAt6ci2ZsntQKXlWGKl
	wLwaHw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jr5xj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:34:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33f01b74124so2249966eec.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 23:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790404484; x=1791009284; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KLaMYwCwOkkTw4yWr611vV0+1feJAqLJ5YJx1fFHMQA=;
        b=j70CuBq/mEmJcHTsOIb5UrhNqmvolJIc4zP89VvwyQBE2ts4PLdmzzVutuToeoQmgk
         uIr7ikZQJU7jDPqTtIKLGuCc5Rz8qV0F2Bpn9Vnk9gjzCY4HvJkiD2Y88n0+WGqsQeln
         8wcd0Gr4AL1MNT8X1ShnhQ9aihp6uAmcnbMrPsoqeoOZtGXwef8jqOiQNrN93obgvRrr
         9iau4myqIa5lShokU6E66BcPSBYXkvuX4I91bz32e4pETLOQgnQ+FoB/SPp4/6/bL4FB
         dN88q5ecUCY4uaEJ76EObdk1QjATUuTbmG6Wj/YNqidi0ce0Rx/7MsN7dgiIysLurK6N
         0mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790404484; x=1791009284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLaMYwCwOkkTw4yWr611vV0+1feJAqLJ5YJx1fFHMQA=;
        b=TI62h2FImuC6545wbOn9seRKQjEiavvyH9FNRrby5agqrREVJby1sx06zj16dp/Pf0
         Crh/aYn+vkWgvDW90s0n40U9n6a4q6FH3XqC1TwEcS99EkSjVObD89uRKIIjEguQM04H
         WK501NKChsK/w7jVsdzazGAZDq3ueH12/XgdkUV9l8RkRkyGZ80aecVMKWI+lDGIS7AS
         iN7mVLdaaMPjaSjT9S1Tm8KBKFISbGkOdegMLyK24wbsi+8qgNIRVlD2670wy9bW4i50
         jHrN0y45JkTurSdJALIowPk273bDKVwhlkbmZ3LIJujjZuN7SIo9+7CDphQhY2jvPBrM
         HF0g==
X-Forwarded-Encrypted: i=1; AKwUvBzE3sNxzsiidlqlZlHQnWyUjFysXXSstuCSQV3Ket7vSAW862sgvFo/IntT3BYphjBPmMv+2g==@lists.linux.dev
X-Gm-Message-State: AFuF++k1bQfaXOBmukSJ4nwNFnsUEGsCX7jC1Y/3l7EHJwEjkgQWUQli
	R4OVY9iPOPC3KuvPnWn7r9cUFI05YosLxUoV0jh+NCHcSdoM5IoYEPMjI82JX4OQfdU9YwfVYOF
	ovP4OCsjklWofkmkg8Se81+fBz2n2BVuPJZJksVpc1fcDeKb1aXUadhZz1g==
X-Gm-Gg: AYBFou03ZnCeEqPtjB52T/oZEcztcC20IKcsTuLE6vkf+R+Jkb0pAyYLODowXRyVZMh
	fZH9cRuMGYkV3ozCo9gLiqzutxcrzUbwDgxUocftT6XhI6RlAQIt4/7WFZikeRS0OCLSIO7SPYb
	Iwo0Bc3dbXXkPwOBRrLZA3EuLZzG0J2in/aNaXq5MiP5BiJyuXielxMx9Bt9oIcyM6m7wly7ULJ
	hDUV7QFV7YS6bii77tLxTiyXHQEc9QeL8IclP4w1jO+f/fEE15qzyTa4X1Cw47oNflZHtrbNRNF
	A+0lflZShMeE7I55iSxYKwyTAG4G3wHU2KP8iHDhwB5KiTY2Bg8v8hJT7J5V8T7fI727BLskrwj
	0u4Imj/ZwPCSQ+iuz3NrSkzBECY8+9YEjSQ==
X-Received: by 2002:a05:701b:2313:b0:13c:d071:f97c with SMTP id a92af1059eb24-146cfdd1e92mr2105109c88.11.1790404483102;
        Fri, 25 Sep 2026 23:34:43 -0700 (PDT)
X-Received: by 2002:a05:701b:2313:b0:13c:d071:f97c with SMTP id a92af1059eb24-146cfdd1e92mr2105071c88.11.1790404482112;
        Fri, 25 Sep 2026 23:34:42 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc45f03sm9700691c88.7.2026.09.25.23.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:34:41 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 12:04:01 +0530
Subject: [PATCH v5 02/13] dt-bindings: media: qcom,sm8550-iris: Add context
 bank subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-vpu_iommu_iova_handling-v5-2-0322ca5dc10c@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790404457; l=3779;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=yHsO30A05MXmUjgWMqhSHRfHlmPgdfem/lqRi62WMjI=;
 b=Uw1Qs/lJhKz2n+Iqf/32r+jf3RsWE/D+ILHjzPTeNblWJtvhjnb0BixOmaLf6X9abqrXzVla8
 L20LeQ/KffjBLGuBF2ao34Oztr8oc/uF4diWgkFI/1CPdxXl0fPBcvg
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAyNiBTYWx0ZWRfX4TbovBrc0wor
 RJtric2vtjFkNcFAxKddA4hAuYzx4HqhUyI9veLKEqrLC6FEDPQH5LkWPuwCbHURyH6owmsNCnv
 /lJgjuTNDWwBBfTq1tOMSRVaEtqGcX8=
X-Proofpoint-GUID: EzCZszXB221PSyQAkM4Jq6rOvRNwJw8S
X-Proofpoint-ORIG-GUID: EzCZszXB221PSyQAkM4Jq6rOvRNwJw8S
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab76784 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w7pRem5UOBajBC5HA0sA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAyNiBTYWx0ZWRfX/COafEoopj0S
 DGKF4bOQz+eFjGcfjHbQD5gWhsTWGnPtCzLlWbrjeh7gV03EQOrKAf2TIU0b8pRp/kvVF3tcVVR
 r2/gE99LDlZT/V4t4uaFOn0FMg8VPKLh7gvOc4tkorZk0jjOFVzOV5fpNEUb2JC+3bWWt0d87vw
 78/hwN76734Hp8K+1ML5PdR2gVcAVfmW843dncySWGKazWtnGnFeTx20HSNfBMGBoIdTkcltBSO
 wKK+/YJKDiZdhwA93nrh4aK5Z7FXFtRM78vNwcIf/8FVjR0vpJi6izwldv4qOYLzKLtpJZ+8Mgq
 H1lmpVSxfry50NjAjrSQRVvHXpeVAk7kA637C2AE0SVHbb88xUcH4MSBz3m4iC5jJ7KG6ugiR4u
 /5O/QOAnIOXKwImjPujYUBn7LbMQ//3sJT6q1LuH5wlNOpyayFji2v9E00XT9UYr4LiakoKcSU1
 9JU1C8T4Z6kD/IZsiGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260026

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
associated with its respective addressable range. The design was
discussed and agreed by mainatiners here
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org

In the past, this limitation was addressed with an iommu-map approach,
with the iris driver dynamically creating the devices. That approach was
later concluded to be a hack to avoid having subnodes, and was NAKed by
the iommu maintainers. It was discussed in detail here:
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/

Update example to the subnode form. Doing so, it picks up the supporting
properties needed on the video-codec node, address-cells, size-cells and
dma-ranges to declare 1:1 DMA translation into the parent.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../devicetree/bindings/media/qcom,sm8550-iris.yaml     | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
index 0400ca1bff05dcef6b742c3fbf77e38adca9f280..6ee9d23554cffb30c92017ef99de15c2493455ac 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
@@ -98,10 +98,10 @@ required:
   - interconnect-names
   - resets
   - reset-names
-  - iommus
   - dma-coherent
 
 allOf:
+  - $ref: qcom,venus-common.yaml#
   - if:
       properties:
         compatible:
@@ -177,12 +177,23 @@ examples:
         resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
         reset-names = "bus";
 
-        iommus = <&apps_smmu 0x1940 0x0000>,
-                 <&apps_smmu 0x1947 0x0000>;
         dma-coherent;
 
         operating-points-v2 = <&iris_opp_table>;
 
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

