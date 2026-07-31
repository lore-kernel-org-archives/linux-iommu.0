Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2718A408612
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499996; cv=none; b=m0xSFBcmgScW7W/xfbS20jALG8iaLExSU4KmD+C/ZGwF1CZJsuf8CIZeMYbq45pdJq8/YqWRVe/jdTOFyPWCGprSJq+g1k2UEcsXz5pnYr/E4GBajAEicbJD2bOdeoxWGY1+3+Z0R0yT5RNoAYzt16uQGD+rlOfrHZY2BU7LQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499996; c=relaxed/simple;
	bh=2lgMSr3Kd8iqkNgBFBm9uhKQPq3np+GySL8xY0y5YxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/TwpK3Dr3EWa5eqdX5exUS+1hsoIQC7EwbykuV/TkgofmnBYjIthnK6w4/9kwi5Jbs8LSpjED+SaHtdgVXu4NpISxgC8Dw7MdFP35sfrs6bBPYWY7Ygn+/RP5Bufn//wCMq309cdJ/bj4yFBg5xYwXMNWK4jkDp4TXYjkStLtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWXzfA3f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hPntzqUg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWXzfA3f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hPntzqUg"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBgfVl3797916
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 12:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rh54GB6Vgywir2EVvnKxHpid
	qpzqdcjyybbV2fe6ZtM=; b=AWXzfA3f6MTCW27Jbf4vgHXWvLXSboN7ZhvbyuAP
	UytlNAj9R5vHL+mm6H0WBww2LOz0Yxa157XjHASfAon/pWH1swU7n/ig7wkierXd
	ewGx+7X6TQjiGG4/TQPMxzYqIcgVrqSs4IXlZgHGdko0Hm3aUPZ8UA4LDjKFZvhC
	qm+96stgSWy4oTD9h//nR3aT4W984y8HXMk4ZbqqHfRXDPynHgPD35o8So6Gmg9J
	Jsw6GCwRumOMMXDvnjri3co7lYKS27RQ49NUwFVc56S7g6uM61SERLFOVzRR0D19
	8wxBR+L77DZoFsLW8woE2svsQ8Le/YAdmxi9g30tuL/Agg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru2u0394-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 12:13:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-526da7e3c9dso8070701cf.1
        for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785499989; x=1786104789; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rh54GB6Vgywir2EVvnKxHpidqpzqdcjyybbV2fe6ZtM=;
        b=hPntzqUgBJRfAEugg+jrNSD1CbaxpVSawiXrplQqooXvn9gMXBfRtJn7dYAMNZHwjk
         7BdJDLV5qPRxnHDxLC32G9DxVzNbnshBTua10k13HnLvdiBMPBcfYDD+HkHTym4ad3vK
         Bf8stis0wC3puydQoUYqalU1bJhBvvgTFL/MqvXfVF1NzpUAX8TTYUesEUMPhwoTIdPq
         /MgBFx0bhnSzf3/mJsZ7uASmn2GtVllplrZ3Gdn/hMlU5hGSUY0LrKyzftPR7yJgz21o
         PT6lJAU+CT1+to1orGWdhcrntHPvIR6T0djBc/9MZtBuuKphE+c1zTkbzUmeqTGSmkYX
         ZTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785499989; x=1786104789;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rh54GB6Vgywir2EVvnKxHpidqpzqdcjyybbV2fe6ZtM=;
        b=LC0Pg9wTpnkW8DFZM7Nc68eNeiXPB1ImQoBPVp5+tDWUtnCWcXjflVBmY5tCzw1jto
         +FbBtLgfCss/HvkS0hs9/TgRHFTH/zLSy7c5xG0Dict482XxLiHlWJvQhm8tqOwWXX2L
         yA2vlxmRJ1V3WNS04sBUn+D/E13TeWmCFANeqxCyHKPHjJHZooZSZoiYFlQ0dFogEvVb
         NOGiTIDv/NNFF1b8Ei5lox2oagXhn/DPf9kwwmLU4TaLVM2asUu9KHxhDAWsmFhA3B7n
         +k9XJcKDae2LyJkzw0Cjjcj3R/SO/jX6fm4+9de3ZelsLYqIRv9P40udGvhTPHnROnJX
         Vcsg==
X-Forwarded-Encrypted: i=1; AHgh+RoitprqTb6gSGsSWS25F3FHbiV+UsfYzbJb+420MNvNhDEcob+No/ZpIoJHMxrUvYeCY5wmZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsZMrYfXKEN40/9hJ1+ItfwSlPBGEHpeJq8SAlgJk5GL5Tninz
	MSFQqbPHVV5atlzcW+R39dRWkQmWbgA0dZjsfq/HsGVmWNRL3Z7AgL0uOAQcwQy3xjR5h5020SU
	bbM+lzhMjgHXsHcCytLeywtdISdFXndCU7xBIoW+f4OYciCR6V6nwonZ3Gg==
X-Gm-Gg: AR+sD13Gdb1umE2EM9TeQh7lADksY4rlUHkStIFn/xDxQV+cCYIEVOFFhi3IlsMl9f5
	0CycccAlXeFPq4PcjYuO+f4ObhFt4H93gd3XEenxI3IykPIsuAg5E+Opj69oMUYkJ9rIDg3zqhe
	IwhIQXhGUgFwpHimwy3N+alAGcDoT7oM3JhELdFvYo78bOChR9n4DjTEwpoY0BxcsJ2n6Zwuo88
	s5k/H8gqH/las9uhe3xsTznk34ZUGRufJK+VTaTYlmVQChWMj+ZompiCRtikIQPrg7/fFUks+8P
	J07Bj4Ip54sh70nSySh12TuOqSjP29fH+y+pF0lTHPMuqEB/phqLzvOoxObWVs1QJqkNSqrJB6C
	/UIRRFDgZ+FXBL1uLEKDEvO5SQEf2n8KWS59z5ce3m5dXgdVRVZrel+xqj205VUL4nBd8rJmfI6
	vspjJYO9OhB+A5IQ==
X-Received: by 2002:a05:622a:292:b0:51c:1241:3b09 with SMTP id d75a77b69052e-52b4af4ee67mr24260591cf.39.1785499989307;
        Fri, 31 Jul 2026 05:13:09 -0700 (PDT)
X-Received: by 2002:a05:622a:292:b0:51c:1241:3b09 with SMTP id d75a77b69052e-52b4af4ee67mr24259511cf.39.1785499988626;
        Fri, 31 Jul 2026 05:13:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e2441deasm268672e87.38.2026.07.31.05.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:13:07 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:13:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 01/14] dt-bindings: media: qcom,glymur-iris: Add
 glymur video codec
Message-ID: <5r4rqy6vb6taad2eglxx7ihta6sk6axfheoxl7vhlzycgmpmw5@zasxwrq3hy2y>
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
 <20260726-glymur-v10-1-de451559e88b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726-glymur-v10-1-de451559e88b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: c1MEtOVu86qjO9u-B6mOq1rKUIftrKHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5MyBTYWx0ZWRfX5sY5ZVwYBvfM
 +hxAmQ0VdG3bW7Bg+A1su5zdatq3WC9FeWdWaWl/w9ByLfyi+opQBozGjAmI10uiC714eLFPzzs
 cZnOehi9nLP4/ZYH8JGK4HoRkBABQNr4qcFVbkLWAHd44WfZ4Y4gxZpryKfHcWJQYkEjV2wTMaQ
 uejfBHDGdosWUObd0b/WEgDD3U2N+bB+3ZTY/yPU3Jw1m3XSsD6rawIO8A6DGyzYYpWsRAW0pQm
 8Fteo2wo4dY6CM1LjDYhevMP0m+oHtfvluhvSTa8yTG0LBu6O2okTfgpsg3vroJ6NCVkCAsIEWF
 UffVUSOuE/e3aCqSdKega/z6/CH8Xya+zmyTC3VKb7icqLkVtn5XyneClf3dERTFE3Da6Ig/uLX
 i7ZBjnAN0l9E+FJYt1VTjrGXxtDvnJHtllOG5VnrF6dmo7BktZp+ea2sR+IYvY10YVzIRBfYLNl
 plHjASExIKsNSq6JK7Q==
X-Proofpoint-GUID: c1MEtOVu86qjO9u-B6mOq1rKUIftrKHo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5MyBTYWx0ZWRfX4Z9fJnVf++0N
 66zYvu29hCDTShcuQfXd0eombQ9uJ8E9GVJ5O954Nplk7CEEbAUrfElKEBThS1XaTOWfQbthD1L
 wBoMPI2q2tMDEfTzsMSGTVrdBXSs3Tw=
X-Authority-Analysis: v=2.4 cv=b+uCJNGx c=1 sm=1 tr=0 ts=6a6c9156 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=vQe_Sn1lod5mhkmiIsQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310093

On Sun, Jul 26, 2026 at 11:19:31AM +0530, Vishnu Reddy wrote:
> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
> is a new generation of video IP that introduces a dual-core architecture.
> The second core brings its own power domain, clocks, and reset lines,
> requiring additional power domains and clocks in the power sequence.
> The current maxItems constraints for clocks and power-domains in the
> common venus schema were sized for platforms available at the time of
> authoring. The glymur platform introduces a dual core architecture
> that requires more clocks and power domains, exceeding these limits.
> Raise maxItems for clocks, clock-names, power-domains and
> power-domain-names to accommodate the glymur platform.
> The glymur platform-specific schema have fixed constraints for these
> properties, so the common schema only acts as an upper bound.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,glymur-iris.yaml           | 257 +++++++++++++++++++++
>  .../bindings/media/qcom,venus-common.yaml          |   8 +-
>  2 files changed, 261 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
> new file mode 100644
> index 000000000000..1bb16206d859
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
> @@ -0,0 +1,257 @@
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
> +      - const: vcodec1_core_freerun
> +
> +  dma-coherent: true
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: cpu-cfg
> +      - const: video-mem
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +  non-pixel:
> +    type: object
> +    description:
> +      Context bank for VPU non-pixel buffers, including compressed and internal buffers.
> +    properties:
> +      iommus:
> +        maxItems: 3
> +      memory-region:
> +        maxItems: 1
> +    required:
> +      - iommus
> +      - memory-region
> +    additionalProperties: false
> +
> +  pixel:
> +    type: object
> +    description:
> +      Context bank for VPU pixel buffers containing uncompressed video data.
> +    properties:
> +      iommus:
> +        maxItems: 1
> +    required:
> +      - iommus
> +    additionalProperties: false
> +
> +  video-firmware:
> +    type: object
> +    description:
> +      Context bank for the VPU firmware processing domain.
> +    properties:
> +      iommus:
> +        maxItems: 1
> +    required:
> +      - iommus
> +    additionalProperties: false


All these subnodes are going to be common to _ALL_ Venus and Iris
devices. Don't define them in the Glymur-specific schema. Please post
the non-RFC for subnodes first and make Glymur use that schema and that
code.

-- 
With best wishes
Dmitry
