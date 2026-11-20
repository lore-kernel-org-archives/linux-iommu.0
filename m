Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182218;
	b=x4T2X4eXpD/jZJ7/+kzFI7k1fBJcvAuKrSA+SncaEvxHgjIGVgxxIUsFJtCmV+MAtuD8
	 /gLOQBjt5rv2yhgIFBi+t299o5jpuD7o+jwP80CM5vJy2udEtr7MQosf5WfAsyROJECW0
	 Av55sRyEQ5SSvh7OhYiy1BHPA0Mbtg877XxolLimYCKFd4cJjtGGu3h+p4DvETg8SsjRf
	 y13VA4DglIDCweQrpbT7+srRzynkHR0xRp2cQ1Hj2MH5ymbZXK5v8/L+7YlQ/EpZLvH1L
	 lc8AmWr4VFeP8jXaHWOrNGHbtw4cqW+8E+Nj8nNLchCGz1e24RpPxWZCorkUPqAH9bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182218;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8tfQIoAmhbhI9PfFkSH+gD38a+UHNrkbahcyNoUO4os=;
	b=d66Ipud16Iig6OMzcOckUs/XtZbTjpzxvK4I4s9Nz/IegO70McNV4168Gi7Nir35OFaQ
	 aZ1TJSHllCbq7Qb5x+qj8iBKUNTwXKOxVi8uNl2eOVlEhpot7CtqP1F3SGliOSwfZzHaz
	 J08mfkCSzpM9qseGYh19k6LUgw6RTa5JD1Sv01oLV5eXu7eWLm9WF0qzK2/cOr5WkVRKR
	 qH6vp6LMcVywSC0me45+LKfFQZ0aKH7B/czSD7kN2tSWb3WU+76mxFwnV3rHXjgk9ZMkl
	 TAMcKV0QAiKKzu67seJe0pysLiNBO7iKx4PReCkZTFscpD1wIjuJEUR5wiYN7e/Qstg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EXt6C3VQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JxnsjvlU;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67822606A33E
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67822606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EXt6C3VQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JxnsjvlU
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk6kC3987225
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8tfQIoAmhbhI9PfFkSH+gD38a+UHNrkbahcyNoUO4os=; b=EXt6C3VQ2JcShR7T
	GVvfexU5Hiyo2njDSWXR6umb14gkkqVudyIg/z7liTj39vlPur6P673EpvYgfbLA
	LWTynnvFsGDvqiaRUUpCjyetduEDpW5XG9L/hqPOnUcJxpEMWSQCnq3yALzxGkPO
	8vTxI5nz2WdAMFybi03wUULzRClJLaUUeZpFSwVQ+lvWLfdfBxcucJi/giTunp6g
	Nb0iI++HuTV4+ZAMKJLE/xOFqiO3SEH0gLJUzNtsfDQDWX2MWzll4GDONQEt3sYf
	bfMJDqVehLWDoPkidDIDwg8LT5TXJ91fhQ0ZrzVT3Wgv2xqaquTYU1ff8aK0tafb
	SoLK6Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu81py8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3724667bc16so713415eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182216; x=1795787016; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8tfQIoAmhbhI9PfFkSH+gD38a+UHNrkbahcyNoUO4os=;
        b=JxnsjvlUK2O828DukrCu0xsJf+ZIvnj5LLJY5bjsTdu7WY/HezQ2/kkeyDUisAWuiQ
         w8+2GDDaSmKPUzQhK0MhktElrWrLK1qFCnXF2jpvUp/tfaGx4Ln8Gj0jaNiwtCgIottG
         Va22Ixm1xGJiSuUNlc8dRJvtLFPuGmkBeMctu0cC4L/BamdMkNmgl5CSf5XeamCbg3nk
         UrF7hjuhcow2AcijbjeajYYvx4yIXNulMspdnetV3ALNPH+hGvzpvYJSPsJ0s3GUMmam
         CH/iEuaY0li/mvFmrbVPEBpLFUitIpNMcVUW9wFsVhQtUdLxAEudfhzuQ57dl3rRnwod
         gM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182216; x=1795787016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8tfQIoAmhbhI9PfFkSH+gD38a+UHNrkbahcyNoUO4os=;
        b=Nh02nN6MMfmNoHVCNa3TEuU/AuPj1AVU9VyZEdhIpzb4Hxfh0Gv+NyqVe1b57c2I2y
         29lGGNaiHZmrWh2lrq6CK+Al4kE4uUvhE6db3tfcs/wGr2gPC7VbmL/Cj9XMYZXPs3/L
         VxAznO7oL0ddrHK0ErdXXpObr6cV2QjO/45F7XBwx/jg+ITRMt0gOMTnrBG381WHTfG8
         b7BsmEGhsC8H6pNZBLYfwDFTqepCE1sJOSsCHX6YiIkAeMCeXzfgw8e9YZpOGRp7t7jZ
         YoR5v0I/jvWPsFVVN09TvfXabmSVo1IEfyAYq4gK4aL+5THuOTT2OJLtO/8Gq9gR/zbn
         dL7A==
X-Forwarded-Encrypted: i=1; AL+hErG9lYnFofq/xOiInc18bMGSKPL+hZlt8z5IfPmuroWOgCEvBqZj2FRSsDKd+i3JJ4QuzNO1Xw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9HscNvT3ewPw6YA9m5u5yHq6N8yn3iRTAJL57VCs1uYyotAq5Q
	ZfNrS93KfogvVT573/cUnEj8lSp6Ef14XQmlfs3utbvAymCIieiWJGZSau4pokuq+m9jCMrOAIx
	f8KNF0jS9Qh4fH+/DF+bdyScEyA+GHrhhIIGbrN4uXAX6GSk1zehAC9kNIQ==
X-Gm-Gg: AZFdTZfftdN8nWGLrXmzMBylLgf4OS4COGyRae17PP5ztqWjLdI6iQ2Z1PnRTyReUwc
	TZ9qOpA82Lx68kgTE4zzTKKpsTwRczigw9S2DwCoCAGUCVdgLU4bIfzWSzVYkiyaPkY2Pm7iQH6
	I80d9nX4OJ/QcvRGfGRMN/mv72LCrQgUD7amdK3rA2XNc22eAlWo2+Ox2g2y5MeQ/wul61YudYu
	H+UOaKwXLSsds/Yt56tj7MAVvhBD9BFc+SRlt5OwrWsRSlTrKL2fn9zbQV8qhB9le8ffw1fZ8ZM
	Jfo6S6iFZhlsHnyp8RhnunVMz6puzqWop/zztG7En/t2v0OpSRARMeRzLZaSwS0fUGhgI0wp1+C
	RMlE6Xar80sdb+x7l095LDXuhU2koWzlOsSg42XmzebyIKwbhzNSfl+OppgZ9cjaU+aLTbBP3fi
	tI/2k=
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7abb with SMTP id 5a478bee46e88-3860bd889c6mr1578888eec.11.1795182215833;
        Fri, 20 Nov 2026 05:43:35 -0800 (PST)
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7abb with SMTP id 5a478bee46e88-3860bd889c6mr1578832eec.11.1795182214992;
        Fri, 20 Nov 2026 05:43:34 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:34 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:44 +0530
Subject: [PATCH RESEND v4 13/20] arm64: dts: qcom: sm8550: Add GEM_NOC
 interconnect for adreno SMMU
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-smmu_interconnect_addition-v4-13-be30526391d9@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1041;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=n4/9ykaP1GAiqJF0FkMOaaqLHTN1pKjv/oqRYjt++ng=;
 b=726DhEZpUXUvkLPxl67ZyaCjxVgALzXfrEUAVeS40RGbSp26vuIM9fAEcFJifZWD60gu4TCqB
 n9AYxnZOgJaA2zhyZOUOVTdcErENn2P3TCPi4ghxJuXbnRzIXYESNkX
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX/xp6jWCFLyju
 YChf1cUJ7f1UCJyAXITi2SWrIoTh5GzfKw5cNF0/dmnXzXvVFL69rHCkUXY8+ExsHK0biSxRRIE
 v4hWQSSmUhutsaaeBAI3KSMs+pVzgrn1yJazZygU2edKoka1iV7jZ4LX3HwQ+WsEWOY+IyaBRVH
 Pxaj9P+veLde0sItKT1KWXMY2gqm5p9KQBAoNRJ/xTHEUOwMFbw4JjMR3c32+1jCaH7Ac6GyssA
 UV3GfydCyHo9/csOFmwsLrR85qXpjoWMA5j4E5FV5yQFcxCxUtOJjSHJd9MBclMtzUYkUd2md1F
 EfZH8D5bBuoyivSUEjVnIlqzvoSqyq3+dzszFQ8vEZ6g9lPewngoD3SwdfbUk+hitESsd4P7YUA
 jbgq+lY0h/4+uea4xGFXjRDOrc+oIM5oWh7f6TGELKw0cku4urjkAJ3kdzfyluhgdsyGAs5tWCr
 PeiZQ/8CWTxEKdL/xZA==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b004e88 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JoDS-ckYLr40ggPBIxEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: xwo7quRpG152XzNqAc5QBsn_5W-_dM_s
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX27Pr/ziWQM3v
 Otk0Ldt+/BKOJQUbo4jdZjq5M+6I9WQdeXVtCfm4PEeEjUlhZiNaEQwjfgt4IOZt5EYHTeokNH7
 ykXgU0WCnvMYzv98ERA6K/zJ9I1QumI=
X-Proofpoint-GUID: xwo7quRpG152XzNqAc5QBsn_5W-_dM_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On SM8550 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index cf7d67faef92..1604d590d7f5 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3073,6 +3073,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		ipa: ipa@3f40000 {

-- 
2.34.1

