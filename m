Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657FB3FDC18
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325497; cv=none; b=rLEWztpVvv9C5wRLchFFd1uhlvagBllLPvX9TgYFvBgjF5xmIsC+FwPAuCGfmfN9wuAREaWVbyW/7q+vE+PfD5+nvpTYJWhlj6K0c239PnXRHi+2UHHzZkmOq/OlLwMfUyBS2aY7hv5DVE8v8RD4mQoyLowONNYpy1xRegKTDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325497; c=relaxed/simple;
	bh=gYrrWAAu3UM4XmJOH+Y9uqQA/KhAPozl/f9r3EEBGVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6ZHikABfd/U2Q+cqFLQw/DKagUpMiDyJnLUlpM1GkQkWGVvt0xJDqOdCZ7xV52o++qU7FIBmYdyfLURVvEBMw2XPZ2K2bn+j/FJ/c8PNNlJ1RNo0gEjdts73NHHdTbOdVKiHnsKe5jA7RvrrvwGKJnvzi4tQ6kvp0Wp0eHUYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TAsOj25G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UaqO95Xy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAsOj25G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UaqO95Xy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DI2dwX1693372
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lCZiOT9vk+oD3cSiqrNWNn+aGN0ogRGv3H9bL1TqTw0=; b=TAsOj25GPSVtV4cZ
	/HOAuRYeNMie3g7dc3xikFe5ZDW2CAiyHAw4p0icaxSyabynTTk33tA6b663XjV1
	e03lpPhk0qEHYGfRKcVYOZ2NyfqK/6OMbqQh48vZ9USwls4ASZl8rZ6l55ug3GDv
	O9KOGR8iUibadvxRxA5pmHjsap/iNDLppaGaXQgVj43OnVmrv21R4b9NzDsCzkCn
	VT9n2siWRZI6CmeSbOn97Aic+LrVpdD7XeWv/PFZlBOXDHXsYQf7uH3gVIY4E0QS
	qxaAKN/dfh1syEopLDv1eEt/sEIMOfRvfdoGVzA4fghCkeKLfqK8SCWqKTUaFx6o
	Td0P0g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gn018kt57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:51:29 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so1958946a12.3
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789325489; x=1789930289; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCZiOT9vk+oD3cSiqrNWNn+aGN0ogRGv3H9bL1TqTw0=;
        b=UaqO95XyXR4/DLK6kjueHRlaX7DUvCpujaLd5vO3bJ1AnmApjKRPhnE/I3/12ca+J0
         BLmpDzUwL1kEvNztOWF9nTTeWu3DxHuKC1cnXzgAD32/+C4MS7+dbR3byB7JAdfW7/hN
         WEGOtxLzzC66PPw5/Go5/+CZSmSu5UlOQVVf+TPY+4leHSOGSBlBrh01SKQlmtrZZKaD
         E+ZDhBbpP4ZmjIw4e8hwvTiVxO1D/fLVJKYvRNXMYRGhMXlVpCRBH1twmO5YGCnivdNh
         MSK9Zu4hsPH+rod3zGm/7sJCsvG2dRPdMDDT0VqUHjtem0MEUwaEMHCR7aGxNczRPgUJ
         oY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325489; x=1789930289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lCZiOT9vk+oD3cSiqrNWNn+aGN0ogRGv3H9bL1TqTw0=;
        b=CEbkPty0toxHnMBtaY/3dIVSjFxpih1d1wMAC0ZlXYFxVLllLOczo0fOC7zIzRzUUd
         vOx+p4obExWvAwMf13RuL1/7wpNtfK9MQO5UYO9aEper/zK15m9jW5wAwmV7P2PNyeVC
         7w8UopPkzJqBJR9m9zZRnjnmHdtAw5LT9Ee1+EObWZ/sMgxC7x7HsbS6rt/49x4PvoVa
         lEtXJOaSIxBwHRmDDwi/GIDpSaYaYhszcT4f5vLCrTIlR3dA/4B9oRnozpPNEXKYOOd9
         P26RIZoD+lKse8fZZwSXCbn2A+PPevuyFEh6oO1QNRuHc/cnIhp3qHyAWBpJXNym3PHn
         QQ5A==
X-Forwarded-Encrypted: i=1; AKwUvBxwF7B/rPi311QYFuD7X9jrgknKowSTameFY7gvqlZ6E/lZoHINGVys6drftp3nvmZh3zDC3Q==@lists.linux.dev
X-Gm-Message-State: AFuF++lzEfNLRYFhsJnSYiwh/tZBL7mnKxRUlGK8hJaAemXOzmjFmap7
	Eb4ZkLxXk1Zd6gtN1dylGmblrfIszVP7b/QSjcFV1qKFJrE3QOWkH3uPPPV8R/CIH/JiTEF13QB
	dKwT6Launw4GPmVakT7lmttB2bhJDN6YUhcdAARi2pIf0LehC9kc4PAZHpw==
X-Gm-Gg: AYBFou2v7dyMKAtK2dqPFun/nuMFos7fWLP4SXbUs9w9DUW3BLrUK5MBFy6DY4uYSBP
	+0dMVPNPWAnhXNfAII/WkPpZKtou9+rRjtoPgYaFgFgoPs9YYWdE+9MlXMvMrt8S7fCY1LglXDc
	pH8Vp1XBMNLqJjvqG0kMKqAwKeGTwtVgSEZzuvqVYIJqNX97HINUYH4YWLJ+wNt8ebj0wlF3xWA
	l6vmOm/hKif5a+QpbqNRbdmGxZtCBim8wAyHUo/EA7BFsIGQgtUBt45qeRYyiBrG67xuSrWtLcL
	TGlabV2PzjqipbvjPe3qr+QSxwwDXYJQcgRWflRPymNHmm7baXJDS+tRBSUUNA+ZdadX580/H99
	Q1DqmubXtTNSVisqEueNvQok99Eh+uji+Y4Y=
X-Received: by 2002:a05:6a21:7e0b:b0:3da:f32e:b3bf with SMTP id adf61e73a8af0-3daf32eb452mr21465259637.17.1789325489137;
        Sun, 13 Sep 2026 11:51:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:7e0b:b0:3da:f32e:b3bf with SMTP id adf61e73a8af0-3daf32eb452mr21465215637.17.1789325488682;
        Sun, 13 Sep 2026 11:51:28 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm22473130eec.24.2026.09.13.11.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:51:28 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 00:19:30 +0530
Subject: [PATCH v4 13/13] arm64: dts: qcom: sm8750: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-vpu_iommu_iova_handling-v4-13-9b9074a73c41@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789325376; l=3606;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=gYrrWAAu3UM4XmJOH+Y9uqQA/KhAPozl/f9r3EEBGVc=;
 b=Y4eeAu0k6A/PwtRusPc6pQKOgvqS3Nq4tR3EDHA8bebt+tl9fO5k0LCZEe/M4OlMMlya8km8d
 rDFwu/fzA7bA9mLcVEPilGt8+xCC5/GeMbmbLGH7nxkzQP7G9Vb/84k
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=c4g+0h9l c=1 sm=1 tr=0 ts=6aa6f0b1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w7pRem5UOBajBC5HA0sA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX9Uft1LaR0cJp
 /PVpXo0tfSq9yjrF+1vMuK2uPvh2ZjxLGVcEnp/KvR1BWxvbQasjQGOTN4+QBezHJQ9DlKhcxns
 wBqzUA8wx8S429GAaeXCcbK1QXMs+G4=
X-Proofpoint-GUID: VPIaSAbWIjMlt0AO9vAqPB5V_7QSz1Rr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX5+ZzVUIbI0cV
 UKtH3nzzM8xyRzWKbQJdbHKpAL6IdvpZzLARYSQsq8DmsEcaTBSwT+kQvLHnzelExViNMj64ae/
 UfL7EZSQHHYJ6Liq+vKby/I6HEyaYgaqPghenAWkqPkZI6lj0XjvtBiVgV8wb08zb1506b2n8vk
 xiJyaJw/E+M5ThnXGgvcLeFvYrnSrf3c9AwNpR5dYMSlt9Dr8swFiyL4O13k8CSoZTcasL4WY0i
 VPVsEoZ/7VVr83l3/aQNUV+vk/A5AP6/d5Y+8XJiWsW53exaa/uQJPIMIkvUqN5HmHZjz8P1RtE
 0XJQoDg1+pUHHJPuOY3RVNKp1AVterbBDh1FOAtCr/4shamDlqH+9rFbDNKeOMVjAP0mtj5bWFr
 NMntpem5zeC9VY227eLiadZT+6hJ5UXqM/PrkKGtDwR2sChhxx1du8ukNksN8EmkSfgPc3wFLdQ
 DULUfz1ItQoxlULdsfg==
X-Proofpoint-ORIG-GUID: VPIaSAbWIjMlt0AO9vAqPB5V_7QSz1Rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130267

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
index 28cf22da854d01413b8e86be3f6330354aad05f2..2e1e07eb5b6aa49850a7a5572ef9e755e298b799 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -3025,8 +3025,6 @@ iris: video-codec@aa00000 {
 				      "vcodec0_core_freerun";
 
 			dma-coherent;
-			iommus = <&apps_smmu 0x1940 0>,
-				 <&apps_smmu 0x1947 0>;
 
 			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
 					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
@@ -3059,6 +3057,10 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 				      "core",
 				      "vcodec0_core";
 
+			#address-cells = <1>;
+			#size-cells = <1>;
+			dma-ranges = <0x0 0x0 0x0 0xe0000000>;
+
 			/*
 			 * IRIS firmware is signed by vendors, only
 			 * enable in boards where the proper signed firmware
@@ -3066,6 +3068,15 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
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

