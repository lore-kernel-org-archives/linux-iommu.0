Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C453B5ED
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081994; cv=none; b=pDdzBfR4dNUrsEsiGWLiw7tG3ij0bo62qpZuoKvfNkGCmvitXTSfyOXcPiuygbmRFbX1Uv/jYAKYq2HVpomllnT685RJiXcxIzvmTgaAEZgv+BRr7vLCYhWDLbmNHdNuS/pyaoJQASOZLwdcxXx/jrS00QLU+vzpYhO5P6t4yRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081994; c=relaxed/simple;
	bh=8GgRFTvdkZTLwU8sEzbVj60ny4PaVMNkfY2LkfBn7gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuGdi0DmLwToClf3NhvOGiWFhPZAs4+/8M3xiWrhGHNPmH/BonotftT6NdkZehZBEznOdsR4osTzPaewuAqcMNUFDr2qok3rXcQhzp7KbpKgdHjIoO9cfz2TNLyTnVlhdKB964ETDsHAhymwTQojEhgPfHxjxmoUK5MznZ2VuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GcKRdATF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dpiN9ya+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GcKRdATF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dpiN9ya+"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBPa512869445
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 12:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=24nvX1TJGWoOIXKdPCihYhYy
	Gf+Fdgo4j/yi1DrWoEQ=; b=GcKRdATFNSz2dDkn3chhXt4IugWSiezzYmaNOZ+6
	6QzKlZZcCJ6tNk7aYB7++k08PTuxb7vb5biZXw68eCUckJ8XPjtv83lJ6OaTTO4L
	STOxhBzZHZxAPzz+EBQzFwr+m56mSQ7I8JkghZQhS6hGlL9TikjWlSvGoCxmbvs1
	0pwbFx0A6roUxuCtSByyGDrTiPrCd/avq9BpPc5DdVzhLSmfe8Ekzb95eZwl8pYZ
	MOkO+UhY/GB7W3od+BE5mV1u8SnPEGkY41iFPAnRtdHxzkvbjrykXHJurrnj4SKa
	Qzbb7cvbBpCL/VGhvaYMVEeLXcc+hU6DzRrUqT2s1VuLZw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guj1123e9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 12:59:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0312937eso518425085a.1
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790081991; x=1790686791; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=24nvX1TJGWoOIXKdPCihYhYyGf+Fdgo4j/yi1DrWoEQ=;
        b=dpiN9ya+R+rsHrvH/z6H1yOR8WYn1BzoWevroinzog2H8IMMq57Pg/PhmTMn9NRT5h
         2LpnjzwUI1+bmDOj7yVMy01qU5uVRnBUrUXgEWjsQSe/6be/ojWPSZnOtcxyf/vJyPld
         54p8qhOFvhvS3BQBuz66wsZrkTo0gqRmW77YDtHYNUwSLV19uSOoeiRBS1V07ua49jNt
         27MvAYZf1W4XzzoZB6V/O84ylpNpvfaNylnIr9u7i5kuOkJFKFBa3xD4my1vtyZuNG/T
         N2j8imhF3qhL6tZ/P3R6oTgCRZkGDWLV7AhKpYrwBWk4fiPXbzceWVL4TT3QE2fgiFAk
         FdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081991; x=1790686791;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=24nvX1TJGWoOIXKdPCihYhYyGf+Fdgo4j/yi1DrWoEQ=;
        b=Dt4AcRct212p4p8Qu6pGqCIL++sdjUCea7sENjfH9Za2+nG0fc0Z3d4rGQs2tutwbK
         foygW/9lYEbEWKCBguY4BSzlRFp3tzPP2xbd7mqXtMkjKMTaGBYlVjyQQ7T5N+hZpPeE
         6Mk6dQ/ed8jA9bJiw3ratMamILKYctoA0NWawsbkzwPddz45DLK5AAo3RpC93b9OEQ65
         Dzv72ean4Cy/1Yht5v/hIYhWi/1yOlhRf0oN6JnHaYGHjAZaVAyotfipuio7NblTAGaW
         lQ1Zcs6ErAi4WWpHTnm+4vQrmVntX6MdauA9yjRVVp6F0VN1cCFmQFCd8kAXhTsdrWg5
         +vmw==
X-Forwarded-Encrypted: i=1; AKwUvBxiyuDPzgf8HC+WXryxeaMTTFZi9xPlpB2K9TiFYP9qsNdaPEZtnm/g79lSKa6XDdSYlaqMYw==@lists.linux.dev
X-Gm-Message-State: AFuF++mettzQ7qD4QzghDJsnKB+UGGL5iLyxjbO7mj5EzSPmo2FwdsE/
	++0U9zZN5T5AXfQwWiZ+lF1h+VXpM/1FVUzODW+6US17MKPYj02LLvBGJ1Rftd4bKP+Zn5m2ugS
	8F8e7iN725t0ge0NmLnsK4OQz4PMqZ0yP9eQhUKafEHmlDyenibxrqJ8Dag==
X-Gm-Gg: AYBFou0GtENP/KiLIeUwR297f2n4DXZNdYybvYuV97AnS161FdU8WtZKbO+xLKXNlTt
	qq9JIlR8gi3qfXX5N36bppCQzhsfKCi4zVpwbZ4ZsKX53a8hIBM7AUMlI1T9OzEKjQhinghW+C4
	stkUi1iIq+SHYcqY4BpS9l6dosFnlDYu3QR+2AHEGms9vs1gnBwY+aIqTliY6tCAPEVe2LqEmUj
	YfuBx0mvfIy3tmx4xAvt/muHAelgcquT2QWwKyGLF1xcR2i5SuEB54uRva6ufq0sESlJT/Wb8/o
	kAHbAWN9hrXWXI0oa3RIgeVp92rX3bGAYikp6rpNuBoSZaP24FMVWrOBJ+zu1TFfPk0pUrCBoVh
	L0w9ghVq3kYbEimnQQC1sTF53/Qx0t/XnQHp137QWFLDJAmL+Wlx2wxVYGN08YmT6PVi9bKDLSr
	dgjrwr4NjoFHwj
X-Received: by 2002:a05:620a:29cb:b0:93b:fe5c:e6f with SMTP id af79cd13be357-93c15d91370mr579610585a.23.1790081991047;
        Tue, 22 Sep 2026 05:59:51 -0700 (PDT)
X-Received: by 2002:a05:620a:29cb:b0:93b:fe5c:e6f with SMTP id af79cd13be357-93c15d91370mr579605885a.23.1790081990524;
        Tue, 22 Sep 2026 05:59:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a627d779aasm5197741fa.28.2026.09.22.05.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:59:49 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:59:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/9] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Message-ID: <pk5j7gr5m23eocsliy2rtqcwbtzonzxidxdon7w3doysgehiiy@yxtjrrp337ex>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
 <20260917-glymur-v11-1-e0c8bc914742@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-glymur-v11-1-e0c8bc914742@oss.qualcomm.com>
X-Proofpoint-GUID: cUq5GkORCZNMdn8j8l9DNq464d6BR23q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4OSBTYWx0ZWRfX0buCJNJm3UmX
 wQNxsMXQBU0FTU5zHw0/CQ2PJHmzLUCprl3S3Zn2WTywyph5ZIoT7RK60z/XW/0WoLW1SVamZI0
 3NrZdDOnu8eq3DkoRBsxZvXGG3W07EI=
X-Proofpoint-ORIG-GUID: cUq5GkORCZNMdn8j8l9DNq464d6BR23q
X-Authority-Analysis: v=2.4 cv=atQnmiZV c=1 sm=1 tr=0 ts=6ab27bc8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=wWFq8rog9-yQDf1E76wA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4OSBTYWx0ZWRfX+Ehlm2g7ocK+
 1lO2DGx+imilXgYidEA6HIfWWo0fy7ARPNWPTR5DFzah8/ATfilGKw0xXj9hNrHF7FsLprTCktS
 wPeYDY856UU4PUR81LXnU2KSvIcJvT8IR+vkxu5aEh9dYqPYXqQfwV4TcHuh34sqjDn751MCnYW
 FaojmdCbTaeFrYJRhS3pDAOUT6dZhSKe+VZd1dgzZaPVcmfAXnrurwRvgeLwlP1GSOzqdpnzo0K
 FLC3+KPYmYvAC0hn/NhXXbHK2XMnf3E3fg9njyH0YdRp2JM3lTsWoqHoZYighQGN1RLx09slDyL
 YgBIVYVyuwfiI56kv0fR4y8snAoBRJ0KXVyZW7lF52z4G12MZ/OES2FzvYJG2z3b81dpVY7dP7X
 HiGB/BVIRuL8VLgTVpvij2AnAZxTr5COUkf2S5KarvPLKm4eVSZKwr6g2GjeIZSciJl0j/DRpij
 Mtxas7xmlgt0YxPvmQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220189

On Thu, Sep 17, 2026 at 10:30:20AM +0530, Vishnu Reddy wrote:
> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
> is a new generation of video IP that introduces a dual-core architecture.
> The second core brings its own power domain, clocks, and reset lines,
> requiring additional power domains and clocks in the power sequence. The
> current maxItems constraints for clocks, power-domains and non-pixel
> iommus in the common venus schema were sized for platforms available at
> the time of authoring. The glymur platform introduces a dual core
> architecture that requires more clocks and power domains, exceeding these
> limits. Raise maxItems for clocks, clock-names, power-domains,
> power-domain-names and non-pixel iommus to accommodate glymur platform.
> The glymur platform specific schema have fixed constraints for these
> properties, so the common schema only acts as an upper bound. Since the
> common schema now only acts as an upper bound, add explicit maxItems
> overrides for the non-pixel iommus in the qcom,sm8550-iris and
> qcom,sm8750-iris schemas to keep the fixed constraints as before.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,glymur-iris.yaml           | 218 +++++++++++++++++++++
>  .../bindings/media/qcom,sm8550-iris.yaml           |   6 +
>  .../bindings/media/qcom,sm8750-iris.yaml           |   6 +
>  .../bindings/media/qcom,venus-common.yaml          |  11 +-
>  4 files changed, 236 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
> new file mode 100644
> index 000000000000..de4792f3b658
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
> @@ -0,0 +1,218 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,glymur-iris.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Glymur SoC Iris video encoder and decoder
> +
> +maintainers:
> +  - Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> +
> +description:
> +  The Iris video processing unit on Qualcomm Glymur SoC is a video encode and
> +  decode accelerator.
> +
> +properties:
> +  compatible:
> +    const: qcom,glymur-iris
> +
> +  clocks:
> +    maxItems: 9
> +
> +  clock-names:
> +    items:
> +      - const: core_iface
> +      - const: core
> +      - const: vcodec0_core
> +      - const: vcodec0_iface
> +      - const: core_freerun
> +      - const: vcodec0_core_freerun
> +      - const: vcodec1_iface
> +      - const: vcodec1_core

Nit: is there any logic in the order of the clocks? Why vcodec0_core
comes before vcodec0_iface, but vcodec1_core comes after vcodec1_iface?

> +      - const: vcodec1_core_freerun
> +
> +  dma-coherent: true
> +
> +  interconnects:
> +    maxItems: 2


-- 
With best wishes
Dmitry
