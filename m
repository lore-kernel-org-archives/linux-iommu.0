Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172905;
	b=JIHtmbN+Wtb9DdBw/8WAuY7HU5UHjNb8FDHDQ9DEwOAkNACSIzm27eYUOqvW5arnrcky
	 QdaA5vuAd4PBtapoZLKTGGm/3imoe2UZvcLCeqbRB8SyLI6z0ue/AIvP5ChLjW3mMvmdR
	 4qeOJb057fPnWjAKH4iNIwXlZ7YKBQJ4a/xBr2QXbLTTKH6XpysqWTsUtAUFfPQz+0OVC
	 5hA4xZu2mgo9S54rf4Wuu/UnD7iUBogsPYZ3sHcGJtFaZsIB513gVvEVES1vtZBzuuIlT
	 OE8YOz1dEqScOKA+FnCmjHZqDHl1Wr6qot9xsPBJNAdpOduFeBKi0yx4hSv09ZKDimw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172905;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aWLejDBY6cxKAWalyM4UrAn1z5uDI+O1UHK3W8xEzBI=;
	b=Z0Q9aihTvip1bByZwzaqEiNKWcPvDGnCE1nkGgeFa7ESsrW0r7AsmZr/e0j7WCeZcFbi
	 6iKu+RIqCcmHu9/UG2lLYht8FGPcvKLL7k+AMUCRxuTVuwzR8yxXZQU2nZ57sFDGRVp8E
	 cdDSTTdfpgZCcuyw3niZSi8BvzLmOsrJVJGHbItrKZm0a/h8h1rxCm9NfYu81Wfpc85lb
	 0m73UUZ/0e+Cyyxw2oLSUOyIMzlibFejYzXvBRGL2kz3H/sI3q0RfzZhQB+eZrqDPzowq
	 Hqs4ugUaKxFDbWs4LDySjWtgkoLlKY45DhF4Vv8DuXRy7J67duG/5+DhnN1a1FlAtVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kFgqblB1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UIx5CrX0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D160A261F
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 452D160A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kFgqblB1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UIx5CrX0
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkQdC1017536
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aWLejDBY6cxKAWalyM4UrAn1z5uDI+O1UHK3W8xEzBI=; b=kFgqblB1KyOqBzjl
	SI8BRPIVJCHt/dZOvNY/RF9Var1F1JFJYPJwoH5d/m3NEMAs7RoNmUPSAKp0G9Ct
	nwveGZltxWkQSbrPADXZgyrtI26A5FofYrfhOWmexCgsziC7nmQlvlzOQiVn/aly
	BGaa+hQeQ1Ir9dYdKfXJMJ67wRO/lfYjaddOKVUW39B2Mm48ybfT4ZJLT4bJ7/ad
	xbgENLiwFp59D0b2uIPRf5qotAdPhwzfGEGtQshjtO6iof7pfVR4TyGWnglOImsT
	qwITw4fRx1y6399xeihkKRCDamzcClB1DBo4LaOPrKuBga2gfWkZVvNAuAjfVp+Z
	mRmZ4w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqs7p5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-370230d93efso2463136eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172904; x=1795777704; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWLejDBY6cxKAWalyM4UrAn1z5uDI+O1UHK3W8xEzBI=;
        b=UIx5CrX0idz6agtilf/FG7ATThLlBDQEf8AK6lR7JB94As1LHXf9NI8FHnonWioIwL
         xSk4IcWnJeU/SpqeLnnEkan1UDiUuoFdGGTu4fbVjxdMFSQ+4lO1ELz4VqT3Xq2m5oKX
         +zZ2nnKKNyV73eCiwgL4RqUywyNPV7kIy0QxnMsXOgtbq8rhgyuB03Le6ybXzdH6j0En
         ZryK0oBKC6f4E1fdSYcRDG6oOFywciJP7VUc0AsXiQvagB6+E/gvkKM8IUBxsB5o9mqj
         VhEiCfecrwAtHPgf2X0v3KKOfR2lpPbmBzh1dC+kSvB+DbgBi6dlGQtEXPFBZHr+EB+d
         Kf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172904; x=1795777704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWLejDBY6cxKAWalyM4UrAn1z5uDI+O1UHK3W8xEzBI=;
        b=uq2Aun+I14rF/zrC08afvdwHycqflUOEpcHgqT2dvf5nclBbBJq+ved0Epna+Bs3h9
         iCuDh3QM8GgtXbCD92OxUnkIp1+hAhD/5o4TARZQcchhKJDsYjrXx6w+jBmKUc5OUAG6
         u5k1LA+IuoQT90TgNX+YAaBRchp3IGl7ivfMIQjaOg1X+JRFc5hUq4D+NIgjlQsTqJjZ
         AOps+MG4I9/bgoxIJ1rXyrVzB/NxZcYeXMLeV4+YdWZfVF+01IUN5cFQfCJfWDFMlFqi
         Pe0adGM56CbIovPP3kZRk7bJcZobZ15jRw5w9qlWtpRlhatxVr9q1qre8WoA2JYj5sHE
         w94g==
X-Forwarded-Encrypted: i=1; AL+hErHNFtVLx5O3+WlGjjQDgwRHEBE17T7b64DWg56nAruzyYF4zAKJpP54QPAztuRd/b7PCvaXSg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/FDIKgOcpqkY/LVgVpf3a6cw77aDHVet2KrLY+KwfRXzTJFerJ
	gi7SfeZjxbDwdPQX9AfxN3LnN/de9o110jF2Xfqzgz2js4P07Sw08zRwGiiOlGK8QpWSO5Z1vU1
	9r4KnTeQfyQlKZEvddkjgdqLRhwKU5Fs9qSbMfhTm3Lcr9a4bhjmnC37f0g==
X-Gm-Gg: AZFdTZf8qk4g3SHfoUZKyiReOo04KHbfyKCjllEboanX8eTntQqkST2onCZ58bAouqj
	IqIDeTe1PIqIwdr+u1EVfYE7UmCa9xtYH93a/bSiD4qM8IF32nI8bHPy4bB/nQQtTnw5y99UqlD
	HR7RYbqjxM8qO7mik69oDSXF0XgXuUXEXqHv4SPe5RAYYaEhms0re0iouNS3N3y750HkTTMlzKR
	agDlWx2q87nYd+YvYWZNvVcpJ7NXTAjC/EqchQjDhnaDf7VnOBPQ3a0iuLBn7VLlrqhl43IEg2o
	UaK89tIb3yKYcdE/W/+LKkoYx9NRAltN4jLRF35QwfKC3yrYi3i2v7x0xyBXAXwrqR9wVduqgEc
	LBATGviDaSP03oMjGIUyjKkaeZaS4VyBU9oqUsUahHOU3PM+OZZ+exdDDvmDfLk+LgcyhvxJz5S
	I9u08f
X-Received: by 2002:a05:7301:619b:20b0:36a:1d6f:917c with SMTP id 5a478bee46e88-3856f45057dmr2756078eec.22.1795172903754;
        Fri, 20 Nov 2026 03:08:23 -0800 (PST)
X-Received: by 2002:a05:7301:619b:20b0:36a:1d6f:917c with SMTP id 5a478bee46e88-3856f45057dmr2756040eec.22.1795172903140;
        Fri, 20 Nov 2026 03:08:23 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:08:22 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:59 +0530
Subject: [PATCH v4 18/20] arm64: dts: qcom: milos: Add GEM_NOC interconnect
 for adreno SMMU
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
Message-Id: <20261120-smmu_interconnect_addition-v4-18-cab8ee8be0b3@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1035;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=uW8nrRF4SJLtr5/e82lnBVVXICez3ZPhzw4syEcDxKA=;
 b=UVzRHXN0oJO9hdlh7U4rxJrqxQy1l3cZ5Rlb2hk0YTnyggdfF/MY0VgoShryhbLhtW6NCInlJ
 H0MBMdEyI19B4ktai3TXrSA7fgr24uRXz7FNw2lNnZDAoaeKB6/8rsU
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX7cAmZx7o6vlw
 nGi5aj33r3pGb21Ny1RGpPbheocWW4PyEc0MzPbWFXrXY5KKTFlwAAr5eJ4cqamKDayUgiPXcl5
 MmK+ZMYlHehiEawTMXwk2fSb6sph9jhScjAuC23QWZGKcIlnR7vWmiC/6WHYqvuipbY1vexMLhp
 zdi44L6s0/Vk9cbEcSEH23k4aeHDiiU1DZuJ/8/fyXya4aUj0BJI47QTHlcRNqV7eAte+B9CYJb
 yt52gTAo1Dz9FvxDM0l/PpfsBCKZKgrxsJRKztlvZvOVfOcSxACVhz761dE0RFgFbIHrN7dvkQM
 +3O24/SZcGJ+azdE5fBquupnHXXw6TWquZMV16sUxDiRK1FCdQ5fKTIpzf8uw+ABYFosAogMlYv
 bTLxy2EXEeT+GRjwZ5yhdTSluB5Tl4dokoRqOhyfp2Lut1AipvHtwwMgsT1VXpTmklRLyh67BIL
 UxoLVAFlUnsnbk0IZMg==
X-Proofpoint-GUID: Oelq7XFAa3gzU6FB8VCJo0RuWuRSzprG
X-Proofpoint-ORIG-GUID: Oelq7XFAa3gzU6FB8VCJo0RuWuRSzprG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX8M37XT4quQvI
 1IGWjFtus4qDkezaLZRabodKfqDC+ZVxP7sckJYHKbMX/aeNmn4yGnRK5TEN4dxIQsHzVmsu+gr
 OXSJD1gONBOZvbkfIzzojhIgehZQ1cg=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b002a28 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iSr-qRAn3DWi8jR0IaQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200044

On Milos the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
index 9cae93b6a610..49ea0a8759f3 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -1988,6 +1988,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		ipa: ipa@3f40000 {

-- 
2.34.1

