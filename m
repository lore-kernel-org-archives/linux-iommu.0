Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA658E2D8
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965959; cv=none; b=qN8KdLPDrepGZqA8BQGg83v06qSXb2gRqjBU8NzpbqvlEzTPASnRtAQd3V+QRhAyl3ocfwsVMpjXdcoZtx9EnDAOUr4U5DhmVbZimb6D5h1+1rTlFKQh+cdy3aY3UWja6N/EosnN/ffDSbdw8mMFzid2VBKf6tL+7SzVB8QUXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965959; c=relaxed/simple;
	bh=h2XojM5tefCf9ICzxKvMGK1x/tP3acL7PRQ2mqf0kt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHBsPbrQ6Tt8UjSbkyS4mFdQ5MkVe45XrUb8cvWdW4dds9ycTuv6QJR2RT0NdIiTGQUU8ZP1JX/XZR4kOWKfsTnebZcJa1mjpOKpxKAj5OhKrzr9iXJ7jc/Vnu1zCz8ZiFY4Gz/9JmUPK5V/x4QWRsGwsW3dwKrtAmS4aDL+nXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cG76sAtg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N8Y4gqQA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cG76sAtg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N8Y4gqQA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU7Xg2375920
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 14:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W9fTRtJ5G9UzjN4GJu0Gi6NH567IxpYmlV8JOuz/pKA=; b=cG76sAtg904gnYo7
	8h/mIbiYmC5fPv3UpMdgj89vPmE+bUwtIZiML2rkSVfGPjPmpTnJbc22GtI2QxiA
	82AKxv0f9EbwNeUE7YfoeEI0oNGO0VvD/nc5393QzREtHt+oPnG3MyGMVEqOtQIv
	HnteATK2u8jVJwIZCy3Co6jtXZjzNG7JHC+kIeA4Y5FvGzMK5bI12GPMErLqm/yU
	fAAlsCzOyjCy9TaozQlXxFlD/mv7gbjN8Wsnmw10co5VW4gHtUfaQWFMn9r385kZ
	hA9SQ1lxFii7Gx1J0dUyqLmZnN/ex8lPm8UptFEE/OhSYkVO6riNojURfHA/wH/4
	uJ622g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5ru13ct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:59:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39512608fb1so12540600a91.1
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965955; x=1789570755; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W9fTRtJ5G9UzjN4GJu0Gi6NH567IxpYmlV8JOuz/pKA=;
        b=N8Y4gqQAkupGxP4bjNJrxAXSgQdk0dx4oIJfS/IU2FAWsRLEvXZH3/cxPymXwvdSY0
         fZDOjszs34bfJnPRmtf+TLkrbmHNR+f99Dq36w1FMUCPhMoy6XdfsCh/ITF4shp+zu/F
         9pdXN5GpvqhcHk23pJVJ4AFcKElDulc0hOz/ATieJ6yeM/gcUpKZf2wXMTjD3c63mno0
         Rh2VRZrOQZp3adAJdw7dFz6iEjV/4tpKAp5rmKDUGsjscLXXr0bbQXxVF18Bm+z8bRSQ
         5X5ofOAd/kbKq9+qX+Epgxua51/WduikPB1eQtJL5pWg6lATCBeheokoIwjNbu4SoqwA
         JY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965955; x=1789570755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9fTRtJ5G9UzjN4GJu0Gi6NH567IxpYmlV8JOuz/pKA=;
        b=kb7MRo3PTFaimTeKqZsgKfXnQXcGrPftnOw1EHD9/UyqSY6Ouo/iR80U54xZm0gCgG
         QLh100beHhv5c3f/vwPFxCTK8JB/FLmb/1GZUbyFFwuN53LBwEP/z1wprFU83K83qdBt
         IhOFQ/fuSOqtaa8ot+6npl0mS+/UPofDwDQT25u83CetUJMgGv32UixQuxqZq1pZQvZN
         EPQcQCVjE6dhfQOL0nF7lmxUGLmD28mAEIU7rWhtzQPkWpRyoeVs4bdyQkkrYFcdv5Cf
         bTkXiGJ5qu9/rNzSL3i+fPP/zLhF+OW+S9COH4fdzmeyh9gRgW9aE4LfhD/y57xCCzqb
         ABBg==
X-Forwarded-Encrypted: i=1; AKwUvBy06/xsIbjdxZalOWFARpQZlGVIXn8Zmh+r3k9eh33Fc26wDr+W6jmHt8ObhdBZ39jzCTbUjw==@lists.linux.dev
X-Gm-Message-State: AFuF++lx56GUzne3Kzz2XvvPfFC2kmFIYvaV+Y0d66oYBVzH8FVdxM7R
	JAHeJ162ws5T+8gusrQ+VHsGW3JOIFkBzSfRGVN3yol3KLH+hLYEsptZ4zAB6CIT2CCOKOPjCRY
	YQv4F6RyP2Fkp3nGbBaldi3TZbNZC8fzqebmw2FeyaWV6WKNrPkl3HTPN/Q==
X-Gm-Gg: AYBFou0r/EuWI2CGIsEGgAEz+a4/biDceT+Bm32sW4ybDiwvkZlg2K48Ig7TAGyb5zk
	2kY/rautmqcnXOz39XJpekGWiMU3Qt+/gE5cK/jVOFkk7YUi+GxJekgC/kZCnd+/dlvK9wpkJ+t
	FJA/X4RWtTXFNqnMr4gme6t/tG8Uoxp0K6c98J1Hb45zGdR5eVKXCmAN2a1QB3WjLCqOZ4n39Ak
	32jHP5GWfS0fboX72YOGyFYOwL6zxGIs0HTDsUlet9e0NvHKKc1ELGIgbdAM8PrsImVMWdenFK6
	fyA6/5ojedMjd9g9/SsixXb0icL5j6iQpEyHDPJ543z4kizUSNTQMfRs+9Ld1bsHZRhVHusgNSQ
	RNW60JXpqxoBdXWis5767PyUBFU6b56D+bms=
X-Received: by 2002:a17:90a:d647:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-39b261074camr51452919a91.6.1788965955138;
        Wed, 09 Sep 2026 07:59:15 -0700 (PDT)
X-Received: by 2002:a17:90a:d647:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-39b261074camr51452855a91.6.1788965954599;
        Wed, 09 Sep 2026 07:59:14 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51270766eec.21.2026.09.09.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:59:14 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 20:27:20 +0530
Subject: [PATCH v3 13/13] arm64: dts: qcom: sm8750: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vpu_iommu_iova_handling-v3-13-2fe43ae45495@oss.qualcomm.com>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
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
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788965841; l=3606;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=h2XojM5tefCf9ICzxKvMGK1x/tP3acL7PRQ2mqf0kt0=;
 b=Kizq253lj7QjfHJcnZ7zy9OA4yO8Dh9a8KxZYx/V9gYA4sy2zQ1areBnDS5fsCu8+pwV2uVEA
 PJpTNoIXdMQAujK3uD8kMmy+UpOgKipk6Oe/Z7QuEv3nHDcQBS/VIZK
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=M+997Sws c=1 sm=1 tr=0 ts=6aa17444 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w7pRem5UOBajBC5HA0sA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: RH5zHayhGyZyOw28zD3BTYmpvmSH9xV_
X-Proofpoint-ORIG-GUID: RH5zHayhGyZyOw28zD3BTYmpvmSH9xV_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX4Vxu3uUPm6Kw
 qAoJAwrLq9GOeb3xBgariAB5mwkGoi2mWjkhCRmb6KJ2213qKEtOcsdyp2Sm2VX0W3xR7mkGzPQ
 XYzPg1wcHnDLiWxUUgYqQlHpsHKeUjQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfXx+z6uEIjt9Ks
 VJwGQVk2Z+JU4c7/ft7SCedK8U18hWrXxxmoic1Nib+uQCv0q6n4YYcSx/YmRa81txjitEPMaiu
 rS1jrWTMVMUj/EbimjtyrLrJJ8/dqvCFjzJG2JG54p9K5J25Ihk1flnyyfpEdyNgh9o4y245kch
 Inwz4PaNtv2/AUG/iILNnFt+XbwzfnZRAmvlbjNIaIrq6rr1kXnXZqXdS0qBxtd9QDBJhhmKbFi
 OBKVuW0GUynmWv3zOMXP0abJfSF3OoPjMWc/rQlAP3nEgXXdQq6Ql2ryV6zGRx/F6EzhIrCL7t/
 n/McWCO4upGM18Tf69YTTL54WMzIWLNA/p3X/QK9agcrmC727KML3fReHrCxtXvMfV06BVx/zl7
 mUvFUSU4w8C372/8Mk0PoBMwe8eerrOLBO94i4tyZNFAOCO9xJK05aPnHHjZVUWm3oK+6Cxh6YM
 iemlcqtuV+UvcXFY2Bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090167

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

The video-codec node includes address-cells, size-cells and dma-ranges
to declare 1:1 mapping for DMA translation to the parent.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index eb3a6990ec30ba3ca1c3fe468ffdb4e9df00174d..206ac22cab2c0dfabc1ca5f619f598e4823776de 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -3026,8 +3026,6 @@ iris: video-codec@aa00000 {
 				      "vcodec0_core_freerun";
 
 			dma-coherent;
-			iommus = <&apps_smmu 0x1940 0>,
-				 <&apps_smmu 0x1947 0>;
 
 			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
 					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
@@ -3060,6 +3058,10 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 				      "core",
 				      "vcodec0_core";
 
+			#address-cells = <1>;
+			#size-cells = <1>;
+			dma-ranges = <0x0 0x0 0x0 0xe0000000>;
+
 			/*
 			 * IRIS firmware is signed by vendors, only
 			 * enable in boards where the proper signed firmware
@@ -3067,6 +3069,15 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			 */
 			status = "disabled";
 
+			non-pixel {
+				iommus = <&apps_smmu 0x1940 0x0>;
+				iommu-ranges = <0x25800000 0xba800000>;
+			};
+
+			pixel {
+				iommus = <&apps_smmu 0x1947 0x0>;
+			};
+
 			iris_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.34.1

