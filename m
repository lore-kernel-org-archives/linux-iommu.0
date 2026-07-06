Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6834402B
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371941; cv=none; b=Risb6/EOUsFHVW5h1im9pepjEZwtX5PKPy6Gg7SeXASW4T+VOCCzHOO97LT5dA5CWpGohg12hvFvMXtCxR5nwmqpcga6hL2ReU32w6jdR359reOcGbgRrp1euvQm+MXmhP8JvxHu5fuKeKniCIbxjIeI+BDRuZBPwMQD1CBNYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371941; c=relaxed/simple;
	bh=yGsij9VKWI7rB/vT0J8nK7LauF77nPjz0MJTy7VKUkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULvifh6JquTMHNrByi8JJEo371TMRcqkLjJrjD/5ts4nhpH6hwPReF2f+JDYzIC2zrQ//Ok77tsEbBK3RxifqZwrwHmFEs4dfRTWAfWcxtC2UehFnquRwgAcxfKV4IKpeewpj4SC/LDYcmgkwC3G0bNbT1qKVY9Ct+tBqh1IkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P9Jj8TM6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ajqguCwU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P9Jj8TM6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ajqguCwU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEGXS1639679
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=; b=P9Jj8TM6cAcq3H7r
	wjqj6sSGBm4x3syZlkv6YdPpN+WR7zgnw8sn8rttUqC8w+Ux5lTJdlrWiOwLZX60
	soJUYBVsW1d5qsqErak8xliv9nP4I8vAD1rIpJIuNhCyPGc9Brsy8UORhWme5eFt
	cjV2JXrvgTo+VOMZUQkf6VWG0ZWG2W6ZLDWGCx5C8pUYiYY2qsTASxr0pqN53xxh
	EAsijqCklh8y9tobAaph0fesmhXZeKYNeRpUybL8eGSWyxeD9Yl/VTnFccc3ZmvD
	jm3ONgl0G53kRZR9UK5x7XfLhyHivpPsOyBPqM8pmanF7CZFYvyqTpQIVK3jpED7
	wGIoUA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r2u3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:05:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso2404753a12.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783371936; x=1783976736; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
        b=ajqguCwUVdH76v6DiIXIHgVKwzmRgz3d2c/Auv9WokCYyl7n75XhMFkWA6fbFbdlbX
         CVei0tiS7jYVnjQk/wNI/IjesgKJeswWrBJ9AAE1+5AIy/6Tk0F6rI+arGzmTXfx9OZA
         hi6dYZwh088QUBRtjQN8b5JqDUkw7PqGNkGedR56dk5Foe/n4XrTBlfpptnF6e5Zbvbu
         9Zm0GpPwkF5m3nBQhMCSEd8kRo1uxBH3Y+Nas05dYkJgxHKfy8pQxtQ0EoVtUoKDqKeA
         45gzz/JGXC+NukyWN4xIopiOoF0vT/utG8PE+jMQWRXDg9pZNhS40aM4Lo/Ihsi1hex+
         Z9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371936; x=1783976736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
        b=pA1JkYOnKbKHG7Arn1zP7Lq44+pD3Lsi0wiLvGSgmsXYgJ4GECyABe8FPtbMdr2E8B
         yNojv26+SknGfkQXff938Crd18iCIqBy3c7irylnMW3A0Ss9df9GUuXSPr26EcU3PtY8
         jCvaW7sfgITqEanCVP3KoJpu0D0i6HoauPpYzhpX8fODc4eYNgqzSaY/XDjbZEzFRRuf
         zqrB2+Z1Wfcc2ar6NWzzmUQy8IAwPw8HiENMrW4tFVAx3dOOUOrtPLDfq7+W/9MpRTJv
         y/xxbr1mX1n+eSD5vbf3jFe/Gb2/ON983CpArq24vd0dlI7dFlXsxwCxRlnEYAYH1AUD
         MliA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7CAVUbrlmh2NmkjXdq4gSAiD7WrwN+yTOt2PDBDglZLXbYd3vz9gJHhuHtUX0yQefcp7SoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyGDHs/k6F1pk7K87s3fzymDM6ZNpMuKDL6Zp/aUZtIVhF6gH+
	lko9Rt9lbg7TWngrjnimLLJankq6qJcR2RRRZBRTdpLd0t1iznRloQbQvNNkqbwfgmmu7pYrk+N
	3ZTx5k+Ja/JlekDD55Ba9OIaPCNMUNBGcR76YpbOhGfvFVUqSqNdCXi7IdA==
X-Gm-Gg: AfdE7clAHQw4t8pFEjazvA7X8/W/8Di7Ysb/MfIfxQe3UNLlPFSvrM/R7hyzZRFchWd
	8IR2/vKtRtawiIGLYe52yoYfhRvJuuQa1BfWgnxqynNwIxZaRbq5cXolbtc7CwdKO7QHcfmY/TK
	4c8NS2OHX7NjggQVPtVulxNpfd6b4r6DEA7IpmlRn998WyEP6c7StoKSrcLF8alGbDjBmsaJg1e
	IcJ3uSzZZj1yoYwijvuoPUj6BsrZYRJmJNycRoeDFoL6pkEKDG/KqtUUwITd2YbpVSm1v8/aJ6k
	/ZVaQgWjgFleAfXOqm5KcMifBZAHZM0x+Wx5xzyhxo8enxmCkC4MXrt3lYzricgRyZPb69Lf1J7
	evWZy0qEKpEqsvh9yXdbG3MMT4o6V2cmBci8=
X-Received: by 2002:a05:6a20:6a07:b0:3bf:9e25:1a13 with SMTP id adf61e73a8af0-3c08ed5762amr2779201637.15.1783371936174;
        Mon, 06 Jul 2026 14:05:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a07:b0:3bf:9e25:1a13 with SMTP id adf61e73a8af0-3c08ed5762amr2779159637.15.1783371935725;
        Mon, 06 Jul 2026 14:05:35 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:05:35 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:36 +0530
Subject: [PATCH v5 4/7] arm64: dts: qcom: shikra: Add Adreno SMMU node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-4-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=1898;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=EYNcq3OFs2Ql/wREKtEM5ji0GMxwTnKnJ9RpGAjMe6E=;
 b=DsMZ8weeC1FJ28PI4GwkWbJKDNIUqDgYuPQPbdoJatJcqoYjN0mvkvVRCXgkFLpEvRW9GGIIr
 imbpv+kai9SDEKXMg7NTAHIPZgWtHd9Y91kx+N0s6PgP2ncPgsQzm6p
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX21VBNPXzNFto
 yeXQ0f63IURGOFGfRgzWyfcF58sL4HPzmTjgPXZzHsXW7majrndh7J7lBmcjiIZk3WmvflXDz5F
 P3WKzKd+mpA9b4TkBNkNoJWkzx5EWhoN0NyxL+jbhQA58q+6VJ8W++39t/9CVvS/d63bDIjyEVK
 bvR8CagJRW4EUNIV3eyVXkVrMddCqPU77E9PGNXeac3dKSoQ/bkcDWQJiDxOEypNWwjqPHsIeKi
 TCn9vwtUuOtx2IoRTTmrNV+0iCll3NXxvcf0vRIweg4i5wMCjCD7mN7/LeQypG7ff5dWN8v+qkX
 CVKg9L30GJS9XEY33WqnArQHCAiUttg52BzfcrkmmkLYvjA2mieh51WEPnT+l9qhRodS1DYpiyx
 ut30LIg8xef71QqJSIwVdA8DIJPHGuNF1ZIy9Jji3/nPAUrk2LXmX3T2+Qe/HyAjmTp/8TwEexF
 NC+g9FhkXJvFHbXHvhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfXyCwkPmht19xr
 JbH+74EgXDCjWasZu3MDpPbN3uQrbzxYqlbKlmI2YI2eWpGLjhjTiqzxeOWFSzCxdYskReGjGaO
 kH81GBtNtHCoPn8aWZFoNAaZBbppjGI=
X-Proofpoint-GUID: 84eZ8DglS7orBL6w1jy2HpFJ7YA08SRf
X-Proofpoint-ORIG-GUID: 84eZ8DglS7orBL6w1jy2HpFJ7YA08SRf
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c18a1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=zTWU315qYGxAnKAOPQ0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index be443b362576..bb11e832d9a6 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2005,6 +2005,35 @@ gpucc: clock-controller@5990000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@59a0000 {
+			compatible = "qcom,shikra-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x059a0000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>;
+			clock-names = "hlos",
+				      "bus",
+				      "iface",
+				      "ahb";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+		};
+
 		dispcc: clock-controller@5f00000 {
 			compatible = "qcom,shikra-dispcc", "qcom,qcm2290-dispcc";
 			reg = <0x0 0x05f00000 0x0 0x20000>;

-- 
2.54.0

