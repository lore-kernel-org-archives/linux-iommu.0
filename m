Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4239EF2C
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404557; cv=none; b=CIQJwowcSPvDPilhPmiqs0oPC5dvizQ1cyaKndyJ/KSWgwAbZswwJfgZDlc6wPSY/PbE0EjtJuCrHAyyMdU3YLbKuNcQnRBpmkK7BADycAoSvnfV+eOxh8v2itOCwBZMZ3DxlomM1w+7RXp+r7GzC2PdDWZ2btPXeYYnC9B07OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404557; c=relaxed/simple;
	bh=3kFVW5Nz6U6ecZ7e3CWStkI5fGjySwII8rzzk5lKC5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9xXqHtkg889zXaCE3Od4vyK5nzd53TIglQvAjfN+gDlp/MijfhtC90o+5+PXcDbX0Er19kClraMwpVbbzTfnNVO5+2Jfq2THagR3oAYEHwxZhSuqmrXzSA8Lo84x/ip0/RRfotS2ddAsVxcCexFauPsr6Cjmj28aGuCwF5r8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwszTZnS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FFoAr2FY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwszTZnS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FFoAr2FY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68Q6PwlR112103
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cZYBA7KJEqE8Qvpi2+pbZkng941B30M0z1x+yOLpprU=; b=gwszTZnSkPrZtVu+
	1R9buWs4FR1uDn/tspjEsR9HFHFCwAg4uLKu1wgOLzW/EmMmvAW0xLZAJ/Zrl0k4
	TtWvbEfVoIltSNf/PqQdTWneuR8Yjh/l96fYjukNV4ko0WvtbkFWbQDiLG+ZgwEI
	iPLeucr2z5ReDUg3mWZdkJJEdjaFUATcn71B5APFzDYpsjJG3WmEPUa8FlA5H6uI
	TTGQgsqHRUeyqYOz0dfpoqZe5g4RBBXeB2sRlCOEWcukoOr3hZYycXT1XH3Hx5ue
	way1Lqp5d91wOkscWmLpqKUt4ZOIkcv+w+xfvvpgrMcK6A/Ju6+qrMq80+/ptPj0
	z2lBRA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx50s8epr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:35:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33f01b74124so2250437eec.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 23:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790404555; x=1791009355; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZYBA7KJEqE8Qvpi2+pbZkng941B30M0z1x+yOLpprU=;
        b=FFoAr2FYjBZqdVjZXrXGmjHGXrNWLjDERybJ5UEel5n0lredOu56oLxLrogrBrc54c
         UIWsL0j2QopX5vdMqaUNcchRvP1dcIw4GcTyDbysyIIqy9zy6A1eGdY+Ua0SeirB6pWH
         E/5F68UsF8i1dXfjW9dSzcURhnhmg2EBCdNrQEtDFhw+2JPFe+1BIWkYWY35PIZWvwvU
         89RGSpG9SkCMN+Wf3ISbcHPp96zU2SwvPL+gvwiDAtQh/LdPP907IFDs5cyjFUwPSF4n
         PKA18HQl8e0hlLecSDQCZ3JDZ0CDarmeKFMPbd3011YaemRg0y2ZZfr/76uYezJKTh++
         BFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790404555; x=1791009355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZYBA7KJEqE8Qvpi2+pbZkng941B30M0z1x+yOLpprU=;
        b=MnNtCk7KFw9l6sV3/5bdfKWuEWrQPjIiSN/qzH9r0BoYQld5BmFOz8v6Pyid/+olbM
         BsQEw08P1Scuq186YeB1cI16hjyMQptEsozkBR/mx+Szh835+e6hVZgPdkAyr4D0++fg
         gLDgX/oaKPpWK0EeNwdU3Vn1S55KZSozN4bfgahmTe1N2afetet2IV/pgfdljx2CMyb6
         GHZBgExkDseoXnaK3kcHCHXzF40nwzlaS9dxhz5dpPVL9hpWpTuCrGtTeMKby11z/5FF
         8YnM3UpKHQ00OJOk2YsVIaGBKPSV7fqcuai4rtr9K7861VH+hzkP2CAR4mRlz1DhCCGP
         NFBw==
X-Forwarded-Encrypted: i=1; AKwUvBzBSyX07rahYbbDzSdyIJPTHUsOYeYqgqr4OdJDq1VeHwpcqqPlXqZzOs2MfOE3xp+QcW3N5Q==@lists.linux.dev
X-Gm-Message-State: AFuF++lsR/Or1Zlv3XvBP53ypW3T6Gd2gGyHuPJxaBy1Bc70hkJE02IE
	e1ANl4jPpuO1QX7zWqho1qsFLhSNg6YWm4hxQgn5CJbYHg413e+45dTE82f5UmsUFdM3h5EmTpD
	BifRhdhtebtml8HX806NxLUuRbZXa3RBQZbX1g2tGZ8yLyvVLFLKpYWLFxw==
X-Gm-Gg: AYBFou1V2NlR+BYqVzlZGQDzb5fGJgZO3TanUnq0VpcNrkg90J3TKYN0amqjszltVRH
	FcqUVz7B6yTLcE/kVo827ahaa6xc95LnK5rdVN5J+lGoJ/3QipXpLshlDAv4FSs2hk1OKzR3XQg
	JMnutKgfELGmGt8mKi8JFNHF1R55+VrfpDPChzQUX3EdxFjpIec/BY3/eAPVyhImF/rIfSRVdBr
	KcFzQ/le6Y/J8n6I6G5iNTQYW2GqeQYMYDv/VYIULGTAz2k4p/NSUHtRBFjmawdVkvlQ3JgbS4K
	iYE3O7YgZ7mkUYk2IWBqdE0v4y30F1FhB9/lbd3OHkWuCBDc6aB4IJ4Mt5zLVtk8j5Ps4zbRg8m
	O9vtFIIERJbnKyeYMN1BjK5zGSZs37jtTiw==
X-Received: by 2002:a05:701b:4512:10b0:146:5f73:d45b with SMTP id a92af1059eb24-146cdfbdaa8mr1829327c88.3.1790404554641;
        Fri, 25 Sep 2026 23:35:54 -0700 (PDT)
X-Received: by 2002:a05:701b:4512:10b0:146:5f73:d45b with SMTP id a92af1059eb24-146cdfbdaa8mr1829306c88.3.1790404554094;
        Fri, 25 Sep 2026 23:35:54 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc45f03sm9700691c88.7.2026.09.25.23.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:35:53 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 12:04:10 +0530
Subject: [PATCH v5 11/13] arm64: dts: qcom: monaco: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-vpu_iommu_iova_handling-v5-11-0322ca5dc10c@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790404457; l=3217;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=3kFVW5Nz6U6ecZ7e3CWStkI5fGjySwII8rzzk5lKC5I=;
 b=ciztsoOrnfTO6RwL5MaYR8Q+Dgl4oobZr7xvUYm+npPBX8zbl0ItNA3BprjPlyQ9XEe6vZG+B
 KsJZ2iURAqiAJ3epcFU/MHTkH6eg30SNZsb9e15qd8uPrWWFXY0yzBX
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAyNiBTYWx0ZWRfX7/pxMIBMVov/
 8+Szt/A3Q3tcseJDvjWVM7k//IZlfh1ST99SgkEJLgWCaajnTE+tLmb2i8hR/dcE0fKxIijuyUD
 8nU5ePtjF8na8XxETuhJtRsWZgnqqgE=
X-Proofpoint-ORIG-GUID: hVgFp9U3sOu4QD783pzGMHXxvrs0FPQ3
X-Authority-Analysis: v=2.4 cv=WuK+otfv c=1 sm=1 tr=0 ts=6ab767cb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w7pRem5UOBajBC5HA0sA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAyNiBTYWx0ZWRfX+d9dcrZ4TZCo
 TBVP1DRIjAv0jEeKJu5red1Ej09tzEmtg5Q/oT+Je3Ng0YrINyhqNLfOyv9iYhNhAum68qDYhNj
 CMhwtAKof9EJ6esikpuWg+KcJTZFCGMyKfEvsHBvzTjTasxl6PoNWhD0UM0pz/PmnhMpxFIFPLS
 D7OtFftfuD4e/4q81Pzf6ABxk1LHudtMM5RAGOCFxx/bBzf8X0tAy8z5BYgEieznjRPpVFl6ju8
 2Y3ejg6RKIWqFeLz2qLi5gf78SUIK06vrd+D2JKnex62wNFn0MBMMABmk6o2uWCh2Q06sg6iVha
 L3WJzeAtbrlRptQxWMZFcythjyOBWr6qlsUuJhE65Zk53RPAu9Nron9Wg0B/2hv8TTQF7lLhSFA
 dWZmXE2v/t48r8QmSbARSYtRms0QBHtSePWfx5yJC5RojKXWVyKcHxTDnEfZGZG4BdU/0H3UVQg
 44SzcPlKMEs70JCrPZg==
X-Proofpoint-GUID: hVgFp9U3sOu4QD783pzGMHXxvrs0FPQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
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
 arch/arm64/boot/dts/qcom/monaco.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 395d32d368443e6c73b934b183c3de007ca2e6b5..89ea87a274a159da872facb688cd742d8d28f3c5 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -5403,12 +5403,23 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";
 
-			iommus = <&apps_smmu 0x0880 0x0400>,
-				 <&apps_smmu 0x0887 0x0400>;
 			dma-coherent;
 
+			#address-cells = <1>;
+			#size-cells = <1>;
+			dma-ranges = <0x0 0x0 0x0 0xe0000000>;
+
 			status = "disabled";
 
+			non-pixel {
+				iommus = <&apps_smmu 0x0880 0x0400>;
+				iommu-ranges = <0x25800000 0xba800000>;
+			};
+
+			pixel {
+				iommus = <&apps_smmu 0x0887 0x0400>;
+			};
+
 			iris_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.34.1

