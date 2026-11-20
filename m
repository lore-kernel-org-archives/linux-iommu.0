Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172853;
	b=UFqPXQ46ZM+kUvp/5YzwOvO9HFZdSXHu39pAhIcBJdoK2UkFq/ZbeMWNtebQIe07s7gc
	 l03peSgNDxLP+w6tRRsJohM1JlKnTJ86pvfx3EG9HmU8kChxPnNd9nzb/4mIfwxcv/Nl7
	 00MCAdMkQW9i+Tt4MqUlMn5VmAIdxAc3IVCOXhFBgQtU75LZwHXm5szNZ9Fx6zoJ43m+/
	 qeiY8n7BDNO81l3HVcDz/seVypDqKVo+XRAK/KCgDAdMdch/UlaaGcF7IgfbMWAzMUaB4
	 tLN74IyU/KrPeE8BkILmGiAxdYy9grIjTJ6StsBDE0+UH9vYkANQ/XWglwki8Cwop2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172853;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hmZxYNnA0FlqXh17OoqgkAggLp3AAiOCxOAyC3Iq++0=;
	b=FcMfPyiEh1N8R5AebEbf0mXiwJd3S/P6xN8laa9WjJIroN/FZc+ecNV97gh7bG8HDkpB
	 HUFnwr34MI7gwAqxB4mX1qP9+SXopJkovsTLH9b5tTp+hCc4e51WQsyCrey/efXIPQhYh
	 NPyTJnpOCtVNmDQ2DsCtF8UJL6KvM+f7RZ4EKqsP+zD4ro425ce7hoGkiXZbcte+LeSCd
	 edHEgJm6kh1hngru0XJ9mYKOFxzpYuLAxKpbIj6WgcgC+pNCMWKNaaoWJOO75E69+isF0
	 4wjPOGwXcfs3kIZbLp9knOJsOLBd1be7U0UKcLLCpMMrV8dDOAjgBXQhec9g4oyrygQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="VnN7/0Pz";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UJlhc1OD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CED60A6F71
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19CED60A6F71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VnN7/0Pz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UJlhc1OD
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjxMt556462
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hmZxYNnA0FlqXh17OoqgkAggLp3AAiOCxOAyC3Iq++0=; b=VnN7/0PzTmZ2Un/0
	zIrk2N5Orv66HzLZe/Es24rOM2ssM4YtTEl8Mn+GL7AgPdhGZ6dgHOioe9vZZFNs
	DiAV59MKWHylvv96yU1SPzSML8oTJ/v+8yldAv4WAHsTGysNjIW3K47gfW1Rd+HR
	wcA+IuMyvxHIr0Jb1+5Kb4quagR6QA3l3kjB8TYAV96zHyaTrZwvq4qvDnPSkQ8X
	2QI2Sc9wsqfN8EiuCzCxTHpDgvkqpfYwjQPZNei5PvwtJpIGpmD25Ovkjob+hqRi
	Dc46oHG9t7DnTYRVhu8cix2ih/OWgskDTtlFeBnvVnaqVz1i3JsPBTDNTNV98adA
	Ue7gNA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fsbhe1b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3854627c1c8so1078607eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172852; x=1795777652; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hmZxYNnA0FlqXh17OoqgkAggLp3AAiOCxOAyC3Iq++0=;
        b=UJlhc1OD8t5rZVXl3F44crCulvCLHv5MunL669CUJNxA6BUfag6v+QiIPJCJegpPuT
         YhN+Fpi9WXxRKr2gdZlb9nXZWkEWUJ7W9iHJAF4gm8ukdj+XVG/225+aCwz3jrIn9dc0
         za8nBqeh2EGIosuZG620idyKmNnkL9wNh4EEaj4ChKcgFsLxZpLarMF2FsUytpHA+6+o
         TlFI9HtvEbUiRgvayaMZk3egAgnOqNmj8LaZge9siwfv1/DGnu0dsGeaRQFaU7tYNKf6
         M/zcOR1s+5Ug5SdQh7erCOKT5JaXwokUgobzWoxzZnsPkpTZnNgmEzTRXQ9YLhzLtaMu
         R32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172852; x=1795777652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hmZxYNnA0FlqXh17OoqgkAggLp3AAiOCxOAyC3Iq++0=;
        b=2Hjci/BXtz+ecpf78hLHCykPx/IXproQYq2bU0B2EfbkOsxkjUkJYjCaCNosYMS4Kj
         vz0xa0RtRUxmqCre5xCRTfwyOBQTLX5QZjxLIC3X+E/2KFS1jLzZPw/TG4VHBUjHmEiZ
         UGyqR1R/+k+kAQuczmJ6tovJour+zUFxGU098UiRnwAyc/icX5RkgLcmokw7QEbgAS/c
         m6Fmykki8mGTTxyb5xKlqLzCJOAPO0Tx8wTR4qvc10ZoWSH1Yd97hAxhh0oZt9wq1Eit
         5eNvcPixd6ksyaY+AxAcR+CrEUh4cd3BS6DdFI1tIvAAIpq0kDahcTPV4kAyIcll/BgA
         55NQ==
X-Forwarded-Encrypted: i=1; AL+hErHjmp6vh3Y+x/P5TalxPZPRQongGomXSC11zempvLqqeAFgKXBowFoRpueYrusISnaL52/2SQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9sW5xu6T/071bSb0d+ZitRveHvzFCeA+fz+KZkuOvCPFhiqsqm
	a4FFIw9DPRnn7fgjAqfi4kA3W+qST972pGpiW9KVAHSUgUE7In2697ehC6RQz/t6HF+yLsJHKgL
	T6HqvhZh8LkhgOZcvm2ih57zknq197gQTOk7O7sKnbq08NGguDCDRgAjmPA==
X-Gm-Gg: AZFdTZcOzLn1Y1Ue0A1r7tUcc26PuiuFqODij9NZrdgL9N4ABRAKSPzO8/a3Jt7iPzp
	k5UT2kgql2V6ZDrxSHINaBkdry1iCnpY4QMS14MtB5y/3k1NVFWDjJnyuM5BORi3ymYIrdPF+c8
	JtpYaLz9s+XG24Uv1RMfA6yWiIJIwVLyndVZUSlCmPQgxQ3OsfMjXMWN9/snrKVHZtjhBHAvpra
	cz9ppkDw5k2yJhSSQQD/9rQo7pURa58C2cxDAULn8ZNl13j5r8KSELfz62yAh9zPZQCulpDKYnV
	pJOOhjQZhfa5AkkzDVFFcdFNZXt324GBh82TMhRdHh50zM+akWoAddhCikEPS4+UwSeRt3Flipm
	KiSvFCXKwYY9zNTzWiaikUpmaOumpdiTh9N6gGAx9Mk5OFQ6h+X+ENhxWR4iBxqkERcM9P4AsDQ
	b8/wWR
X-Received: by 2002:a05:7300:6d03:b0:381:9b9c:6140 with SMTP id 5a478bee46e88-3856fd5bf5emr3103020eec.23.1795172851657;
        Fri, 20 Nov 2026 03:07:31 -0800 (PST)
X-Received: by 2002:a05:7300:6d03:b0:381:9b9c:6140 with SMTP id 5a478bee46e88-3856fd5bf5emr3102974eec.23.1795172850989;
        Fri, 20 Nov 2026 03:07:30 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:30 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:49 +0530
Subject: [PATCH v4 08/20] arm64: dts: qcom: sm8250: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-8-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1033;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=W3R0vadqLaDaPerwJqu9PSx+OZnsGkbm84YuXP3uSZ0=;
 b=2QSTYCJTswayLaRtH+B8G1NNWBpnaZuzUwYJDYa5ujCqH09DMFxaY3GcRjghHbNwCvQg3CFqR
 pHhnKyLIK8zC8y+M50UC9afzeFvT+6TpYpA4Z5kJbURrxQvEsqL1Ibu
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXzkTc85Yn87XB
 4KA8fB5IKnIOmNlUTqfwSKGPNTe9sInlShvuxHWai+FxGnNS9+3vcksx9rO8mUwwGhAZFM3zV2N
 EHbtYUB+955B/QVNkFLuxMwgbxelQ2Xnfe61CH1JLoZsznRkw+U9qw2sp1ZYSPbHbYywO/N38l6
 NrbgF9rqfyA3JHoFiX1trXSCJuRg9CFzE/QOd11vrFJfBqllXfP32Tir1NxI8VmkQKSjpc4w4DS
 98wrHZNNAAhvOgfkmFzDV/6nZlVPbGvvCAtRb6pgGYRubxnGCe4cdCXrDpc1KmFB0ib6dXnEDB7
 jQhNkWYLQeXPW4/+qHPhyFDqTSsf7Z0rDETZFcbD2mHNA8Hu9eCDOGFXM/t6FpJTcvu/MmxOngO
 MA4gSAvfNWWjFh5esJnzbd3GCRLi+jkgvNQSx5aH1daPVrFqA1J0zjYp3z6NQ6MzATtGffMzrs7
 UAJbFH457F+x0CP2BaQ==
X-Proofpoint-GUID: oztT2aHW0jBKfe4tjdfd_ecv8ymKvQs7
X-Authority-Analysis: v=2.4 cv=DeiCOftW c=1 sm=1 tr=0 ts=6b0029f4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=IeQ55TmpMpvzCWFLjAoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: oztT2aHW0jBKfe4tjdfd_ecv8ymKvQs7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX0/+JcsFC5r5t
 Wx3zXq2QU6Oh27YC3iPcv5qyj5Px+qXd3xRQegQCT67xqKZMHUZxKt28Wr23TfCqCYQNGJLYCq3
 AfSJa2cNpwvaOf4ca8gWL6/T7tvoOak=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On SM8250 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 992284e64d38..3a368ef7c22a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3089,6 +3089,8 @@ adreno_smmu: iommu@3da0000 {
 
 			power-domains = <&gpucc GPU_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		slpi: remoteproc@5c00000 {

-- 
2.34.1

