Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E46439F96
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142117; cv=none; b=UW7oEY/3jwdq8VQ+YAzW5dj0BHF2AuNGIEysB90dCQrf/3aFZEMMUDBNz6wp8jLs3QBYQ9Vh5MeTzQz7yxUnwBARwEyq+nsWQ2GN0pQLrNKpMlT2zLEbQMRKT/LITPR8HY/rNQEDe1Y7rGhi373lUFEmgzzCNZZ9tWK7a0YqOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142117; c=relaxed/simple;
	bh=UIAx05CZrvM8N5t8BucuFcjpo4iq7isDMnPF5+mhZsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2cgoKuYlMkG/1N2+fRf09Hdz/cziYwUdXCzPXRPddtjuqct8yP5+pVYUnc8wY8HsFT2dH1sH1dDRgn2Urkc1a4HEDXHUDy715Zq1OF2pz8XAraTaRqZOgkE9Z+eXcaDjO3Osltu+L+CLtImtL++wJi7q85OfdqRIjM4I7w8O0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxKFFDsB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U9nm2AYv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxKFFDsB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U9nm2AYv"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3iVZt3096026
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 05:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G/aKOtHIofqNw5/DRlGI2QTk8pCfM57nPrUMsZyHrh4=; b=jxKFFDsBPSA38++5
	WNRY7oUGBrf7pXW+w8jns5gCg7oMJf1eOsGgCAG2O9O69HB6zn5B8Iw4SpArKzyV
	9nCxPYSnlYarNwO4WcM/o0jDT0vcJgjMKSqVLYrzA3FBOpMrEf4xJUFHCTdYup7C
	QQjlOrIrbPvorCFvHJrgO7+FaTMeTxyEY41/OgulmmDx0f2mVP9g62P4Kgh9JJao
	ZKtMv241Md2x2swRm8JzOjpVboawXUNbGc0zpGmicNmeREIYRYAyBGa8XNzgqZPw
	4lrNNlK4X8OkvgSOqP5cx9QDMU1kUg/+vqYwf+J8BMsnLVBHeFifscBqwnq9hZlG
	mjHXrA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv428s0y7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 05:41:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-331b2ec616fso2164312eec.1
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 22:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790142109; x=1790746909; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/aKOtHIofqNw5/DRlGI2QTk8pCfM57nPrUMsZyHrh4=;
        b=U9nm2AYvwfBayOhvDxsN/oSJ2otcFEyNWX3YFi/VORmNiiOH6FuHVDBXRW+9ttLuxO
         eeOVRFxgqoZYKIiDnCN/mPOFzk2Njp/7nJNP7q7BrbCCGlKfPOvZY+7j4K8qgLGO/6Vu
         wRMqgW89sVhAY80Lvez4Qy0AVyLK6k3SinfA9opvwmv2bknu0yXWUa39aTFuqXxnQTJ3
         pQj3Tlhy5V8TjazWK1a1HddRiww49+9yAN3axi1P3kECEVdE63N7PMGm9ap0A4Yjeb0a
         wka1h6KPKsLkrJMjN7aukdARWRYvAgu/XFt/ax82ug5N9D8Mf+CGv3etKZNf5b2SA7G2
         wShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790142109; x=1790746909;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/aKOtHIofqNw5/DRlGI2QTk8pCfM57nPrUMsZyHrh4=;
        b=qaNjYxs28/HyJlbiQYOD+kA6B6JMc48x/x8aqBCbq8xeIURg8dAzLyOPHdxF/qkeyF
         eKAEXXE/aiOlHmpo9HMSyqn2ILTKpvM/k78Jf881l6VdZ+ufF4zaB/ra3sWMZmmTKO9Q
         hDoZB0x2xO2G2ELCb9vwUBhHBlbZXQ8E6qvapG3KzrOrHrdNzxBtOTw+hz2vlPiKKt3e
         fze9/vjLCIJee0d2NNJYzKWkmE5S88UU8fv5F0IOTThciQ74zL2E5sduozH99AiEO/yA
         erWwOZHXsP5DKr0vW7Nf65QnSLrOTFN6LjJraOnqkkwRHdSho7zrCO9VJEPD6NT7xQMW
         TsNA==
X-Forwarded-Encrypted: i=1; AKwUvBxUqG2wvLnpA8fRwvipn9dnDKJjTnm7NU0SORCLqlgrjTJBwZABqSGvDe1PeF3XqRfrUO1JLQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mXZzzFCe8FsTBrnqlriJXFjjefzyiB36IQDBwPSQNT5dtmFMr1
	gQC2idZJnbtqlHwKp5V70WhxvqHmDrP3NQKe5mabUasQBud57291nfsnmkI7BZVrmzMhAoS2mw5
	3cplGbghWPj3lIFffDTBGX3wV9tN4OFPYZg2+pG9yMxdpPaKy5B4i8j3KdA==
X-Gm-Gg: AYBFou0o62FXsKXkmK9iaCIwUd4+Wz+B8Wvbb3jr4+0CZ7U7zyS8W6+s7sDqm0Ujlep
	8+dnmJTBYLJSdEnJJuW/Q+/mkCxy+AyETvDw2WemPMu5mYu+2cHf5Fqu3KOD6PXRFohV0uuG/go
	yvNwzYG/NHKA1sOMNdDCzp4170iDdSnsFG1Lrs7JHTlPnFMt1cGveqFRh2S0fp01pt9A3TfBPxn
	4VoRBD7zqmEimFxgXvontIEtl41LPoujIH8ZnWjatCBebUbh8+B8/YaNw3CBmf+pSqCFNn3byG+
	BQ1jQMDkoOzq41HY5NL2S6/33f9XwOfLgqXrn1sjS8ZQB6a/AA+au8bFD41ZhFls7kOBTzfuJeN
	YbAZl2GHafKNylndnwQj2lmvTXABJGOA=
X-Received: by 2002:a05:7300:b291:b0:33b:e21e:4a3a with SMTP id 5a478bee46e88-33e8e69cb4bmr1709619eec.40.1790142108703;
        Tue, 22 Sep 2026 22:41:48 -0700 (PDT)
X-Received: by 2002:a05:7300:b291:b0:33b:e21e:4a3a with SMTP id 5a478bee46e88-33e8e69cb4bmr1709602eec.40.1790142108165;
        Tue, 22 Sep 2026 22:41:48 -0700 (PDT)
Received: from [10.206.101.140] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258351sm3193280eec.12.2026.09.22.22.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 22:41:47 -0700 (PDT)
Message-ID: <335528fa-72b1-b61c-a2f2-aa1e15c8f3ec@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 11:11:39 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 1/9] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
 <20260917-glymur-v11-1-e0c8bc914742@oss.qualcomm.com>
 <pk5j7gr5m23eocsliy2rtqcwbtzonzxidxdon7w3doysgehiiy@yxtjrrp337ex>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <pk5j7gr5m23eocsliy2rtqcwbtzonzxidxdon7w3doysgehiiy@yxtjrrp337ex>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EZdd0/mC c=1 sm=1 tr=0 ts=6ab366a2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=6X4DAO4X2HBH6bcfxsAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: N-6g-es5e8yt2YLaPBiRQyHl4qRiDwIU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyMiBTYWx0ZWRfX8Tv63C6ZU4Eu
 ITPH+Quhs+GDNfUej/xPX1jmPa90GMWBlUzKABk5Qb3rnSpWg2w89thhLiWItGlqz2nmz+na9jo
 AgtzHgq7HLUDuLccHEzOj7+eAgQGEmm2TlpzR80Qkwlj9Fu3Bj5pSwVAXX2drrltE447omW/IOK
 xg4HtgvTTHxpkKXYdN7Fng6s+ucL+P/chjnPEKYVpsJC1jf6BoU+Lwqh7BFfdsxiHZF0fQKfCQm
 mCIyTKGd6YAuVAeHYwvi0dObBu1nFEnr/GkQ+EpWFIpJ0LS15ELOJUYz1e7bpU6ARKY+LKwdCxQ
 EJ/YbAzdqIpSVYUPEzigaMAt2QnqUkjGYz01lzB+wUJr3AcPzxTaZkwHx1uL1Mceya+iXxvVWgK
 +NdwOJmGkZg79uy1WL5ElZR+iH6OwmbFBtWuGjdBvqEEpmcS64eIFE9hzbc7vC9WuICXQi0YHtg
 DXJSVJ5QnAR4Ka7HazA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyMiBTYWx0ZWRfX7alS9b5NTelE
 XL6uX67blydca1MJ9aAzzX3SD0oJqSlViiLdrzzTkl4nhsvjGMfrmExQgG5s3ywAK83Y9nbERRO
 p2IKjuEc/BhXWntboG5g/mGWoKaSOng=
X-Proofpoint-GUID: N-6g-es5e8yt2YLaPBiRQyHl4qRiDwIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230022


On 9/22/2026 6:29 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 17, 2026 at 10:30:20AM +0530, Vishnu Reddy wrote:
>> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
>> is a new generation of video IP that introduces a dual-core architecture.
>> The second core brings its own power domain, clocks, and reset lines,
>> requiring additional power domains and clocks in the power sequence. The
>> current maxItems constraints for clocks, power-domains and non-pixel
>> iommus in the common venus schema were sized for platforms available at
>> the time of authoring. The glymur platform introduces a dual core
>> architecture that requires more clocks and power domains, exceeding these
>> limits. Raise maxItems for clocks, clock-names, power-domains,
>> power-domain-names and non-pixel iommus to accommodate glymur platform.
>> The glymur platform specific schema have fixed constraints for these
>> properties, so the common schema only acts as an upper bound. Since the
>> common schema now only acts as an upper bound, add explicit maxItems
>> overrides for the non-pixel iommus in the qcom,sm8550-iris and
>> qcom,sm8750-iris schemas to keep the fixed constraints as before.
>>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  .../bindings/media/qcom,glymur-iris.yaml           | 218 +++++++++++++++++++++
>>  .../bindings/media/qcom,sm8550-iris.yaml           |   6 +
>>  .../bindings/media/qcom,sm8750-iris.yaml           |   6 +
>>  .../bindings/media/qcom,venus-common.yaml          |  11 +-
>>  4 files changed, 236 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
>> new file mode 100644
>> index 000000000000..de4792f3b658
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
>> @@ -0,0 +1,218 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/qcom,glymur-iris.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Glymur SoC Iris video encoder and decoder
>> +
>> +maintainers:
>> +  - Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> +
>> +description:
>> +  The Iris video processing unit on Qualcomm Glymur SoC is a video encode and
>> +  decode accelerator.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,glymur-iris
>> +
>> +  clocks:
>> +    maxItems: 9
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core_iface
>> +      - const: core
>> +      - const: vcodec0_core
>> +      - const: vcodec0_iface
>> +      - const: core_freerun
>> +      - const: vcodec0_core_freerun
>> +      - const: vcodec1_iface
>> +      - const: vcodec1_core
> Nit: is there any logic in the order of the clocks? Why vcodec0_core
> comes before vcodec0_iface, but vcodec1_core comes after vcodec1_iface?

I followed the clock ordering from the SM8750 binding for the existing entries.
For the additional glymur clocks, I appended them at the end and kept the new
pair in the same interface-before-core style as the inherited clock list. That
is why vcodec1_iface appears before vcodec1_core. There was no specific
functional dependency intended by this ordering. Let me know if you have any
preference on reordering.

>> +      - const: vcodec1_core_freerun
>> +
>> +  dma-coherent: true
>> +
>> +  interconnects:
>> +    maxItems: 2
>
