Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B193546C7
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783972067; cv=none; b=lTq1P8DVOd+Z2CZNKwn5M5qXry3hgs+c5BJokP+RNp299jsouO2Vz5tXS9DU33ZcSfH6tf0dO27U3kthmhdvv6Y0HQVylxiSqB5Tw1Z0D1WXwYN/0HSmKrR0pHG5ItcCAKSwqiJDMIp7PBX/iw4/PhWFzZ4QPq453S32Ex+KAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783972067; c=relaxed/simple;
	bh=Gyg+X4oTM68MBPwzPDsOfJPQiDrapGPHKUYm2GSqCgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R94ghClqD7Ieob954Y9hXM4fv84Eywd/Axa6Kw9EbivqKGxMhdpxcg1pJm0J/+ySgI5Y/bEyT+32mFrYjrexsnaefdf+ejVfewuY4zt1UJg3ksdJqzHZvN3tmm4wSN/gi+Ds9SzYdrwBsGrns2YtNoFOB+Wnme9y7TLnTMrUEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E/gg9+NM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gNALwjLw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/gg9+NM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gNALwjLw"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9Z3p2389624
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LsYB8yHPbPP+skFaM9JiYXJZSC7Kk8Ggqc+cNJG8mMI=; b=E/gg9+NM7cdqU6GK
	J1bGF6571fqlPr11tx0ljupGSTx+WHiufAYJ0CWbEGlT9oszrTgyU+z9FAknSGwy
	fG9jvps2RIE10yGfVj2sWn/RcY8J+JeBzsMePAQJVgF6/in5qK7E7c1fTkvv6XhF
	cSG2MzLBtd29VIrn8aHj7+wshe1L8u998/J6n1ewYeW/yUZ1r+nwS1ky7lk/74b+
	AdR2WG4PBFDPeLq3sJYZyGo3Z+eF9xf9+oRcovn8qc+W8YqS63VQisAf4yQaoOwb
	46FcO5uxfjisKfE5RqYIzistF+zZ4KclOKJJMXUzyENA2Vm344ngFQJMnXVmPosR
	iwBOMg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44j0kg7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:47:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso5247092a12.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783972064; x=1784576864; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LsYB8yHPbPP+skFaM9JiYXJZSC7Kk8Ggqc+cNJG8mMI=;
        b=gNALwjLwvswqL4Xhzm/dVgD9bS9YFwYla+Xhr3zMLX2OmRmBjUoI0KsBcORpA1NqAu
         9chk9lWSaje2uKKPeBn0/2NmktCBdvlVQ0u6feUE0SqHvXStrtqap/A6kfG2S8jRfv5M
         E7VTJ9wkvLtA57dFkWIzl4ha7fjSGtzJ0HpOHqDSVNKD1j+wKfi3yVyzUfAxuDpS7vIv
         UsyVrgYgPaKj57Ec8C8aSrKimbQOg3uI2ktTHT2cSCBIzbfCZPrq4FTO5Vd3B+maQuZf
         0ziEReQgDbFeU+HprK3dX+iAh64BFhdY8DKdf/q0dbB8QLsX+dQuTB7/UUF245oRUg/t
         Ha5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783972064; x=1784576864;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsYB8yHPbPP+skFaM9JiYXJZSC7Kk8Ggqc+cNJG8mMI=;
        b=gkFCfwuzqvCFx8Kxc/1hHsz77k2iaMxFQoJVT+07ayV6Nx6gSvb39j/LsMk/dEuGTh
         L2t2cMbWHuPK41hwQVKUZRIGWWnKs7+VvKVYycfgEo107A9o7PsKN6itIvXrww9IIqEC
         vx86fmLurI4mzV//wfO2YSIdu1AHs9VFtEFqMrRvWYtGHw4dZsSM3b7qJtDEvtH/pkBM
         xsx5qFw29FRZhuwegw6joFZOzesIa5AnA9N4Wcorj4Q3OCKkEAHpJ8QXim8gHymjJeFx
         VnGIGRZpaL/ZK3h2f2oLiRcZi1GzZY8905szNmpGQ9IEhuW86bn6LHNFHMv5FkAk2dlr
         wJuA==
X-Forwarded-Encrypted: i=1; AHgh+RphCFm/eYjMthrHhlGbL/uO16yqliPTNnCfxM7RokDFKSM/ThabDV8QczTamcsLvsxVMGy3Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbKmaVvFs4sgVsR04+vO7wDWowSwkzmz0TbpXJtGB/z+dvbdpR
	kRfoV2F8YX/aU67pahQNDZKLkqSE9j7cS0WGuA7ME8vSl/Zc/U1JIJVWxxbuOnhPsN5FOeEWdgI
	gPHuH0rD8rYA0pHWGWiQPQOO7xlIJXLKDKvJt0ajLT+MEeX761idNjzCBcg==
X-Gm-Gg: AfdE7cmRJXNjUUmCYQeziJJ8cCsgkQqrU82keIAWYMu8Zyd8XZxNIRhz3QxXYAMaKym
	sQow7maC+IsjguOJXQvvk3DN82IxrT2LQ9Q7ZxC7KJu6hFwpDQMZNKLbZBFhMN3/AHH77zom+LB
	GH3aaEW1tiYSL5WUCRqIhfucPy3cQ4RXeoWs91DpGyW3W7M9IBOCUIzkDLwrGqjBm9nm1H/gFmf
	uVqVXUZIJWbSb//rS1gjxvj8d61JY/1LMTRcy5rZqdcSPRdhaGLMfHjfYCzArExVhdbLSYYRLdX
	x0g4liXicWMHnYFbGH1g/iBKDYGWbTU7oyhH4v7GXvT1cJ4+3WkM5BX+S7Roz4uTji7bv3xR6Lf
	4TgMKd8pXgxzQG0lXmpNRoljB62gTeEkwiiI=
X-Received: by 2002:a05:6a20:6a28:b0:3c0:9c19:65be with SMTP id adf61e73a8af0-3c110a74421mr10454878637.70.1783972064012;
        Mon, 13 Jul 2026 12:47:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a28:b0:3c0:9c19:65be with SMTP id adf61e73a8af0-3c110a74421mr10454838637.70.1783972063592;
        Mon, 13 Jul 2026 12:47:43 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ba45b7049sm6823350c88.12.2026.07.13.12.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 12:47:42 -0700 (PDT)
Message-ID: <e8255fe2-a67c-490e-a905-ed056c6af950@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:17:32 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: eliza: Add GPU SMMU node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
 <10b0ad51-8766-449c-a51c-979364e6c781@oss.qualcomm.com>
 <5fcc0bc1-7f9e-4611-be77-42860e0f4c74@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5fcc0bc1-7f9e-4611-be77-42860e0f4c74@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwNCBTYWx0ZWRfX0knH1CcB4RTZ
 ck64EF/bsCaPKJePwEFrhVt//zLB55uaJEFdnMfRDTULIuTlDMwOTG1484S2HfA03xNY1Wyxd33
 O5hIk6LWisxQ1xbcZHV6pe8g8pVO8To=
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a5540e1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=yNfbWwvibup9Ri9izU+P7Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=sy2TSPCRsGNh5uQNLmIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: Ex6SChtC__BVjc-Sm570nkELAFr6VbBZ
X-Proofpoint-ORIG-GUID: Ex6SChtC__BVjc-Sm570nkELAFr6VbBZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwNCBTYWx0ZWRfXyTAx1vke8pBr
 ZVnEEXTcLuO2MoYqn37Mw6ACF+tYmvZwC0+ExcTFP6CTZwt5OlSqAMpXcAJ/1BnLkdtH/F1VeZt
 aYRl7kCQSDKh2x6RjfyKPRUYEsKEmf6gfT5mSauHeg3GbZBz57oqHFiMnvpDhAlJeOEy+jI6lOA
 DKhhRju2L/woLXTd2EOTNFQgrCeFnbA0lGDPKHuy/hoJpG7WQtyazhHg+D5hDOzQXmP80ZfBGDT
 u86EjsDUdi13fJoAwuh6Tze5vyHopU5X4sswopT66x4uK3EagYIhP90RiSlUpJV4ovwledQNDmK
 /9zy0a/AYwnCzSE1F0k4zjcv5WRzyTPWGvCOAsEcORpSojc0hirr5QWZ4FE9x04Y6cb7SmLqGE3
 w+MUEOWjU2kOT7jygYnhWVt34YMZyudVVjrUXFMyxtzXS2fXmHvBxCQOlJfpCXfo6bWXmjXn37r
 EJ0ewoi+3J1KaztDxlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130204

On 7/6/2026 4:38 PM, Konrad Dybcio wrote:
> On 7/6/26 1:07 PM, Konrad Dybcio wrote:
>> On 7/5/26 10:14 AM, Akhil P Oommen wrote:
>>> From: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>>
>>> Add the nodes to describe the GPU SMMU.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 38 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
>>> index c5635f22e2a7..e5b8377e6c3a 100644
>>> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
>>> @@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
>>>  			};
>>>  		};
>>>  
>>> +		adreno_smmu: iommu@3da0000 {
>>> +			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
>>> +				     "qcom,smmu-500", "arm,mmu-500";
>>> +			reg = <0x0 0x03da0000 0x0 0x40000>;
>>> +			#iommu-cells = <2>;
>>> +			#global-interrupts = <1>;
>>> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
>>
>> 674 is the correct globla
> 
> (modulo the issue i explained below)
> 
> [...]
> 
>> This list is not quite correct. It must be sorted by the context index,
>> to which a given interrupt corresponds to - the driver relies on that
>> to give you information about where a context fault happens
>>
>> Moreover, I see that the interrupt sheet has the bug where some
>> interrupts are offset by 32 from the base vector, and others are offset
>> by 31 (i.e. the SPI number doesn't equal irq vector - 32) - please find
>> out which mapping is correct with the right folks

I reviewed this and looks correct to me. Also, this matches the
downstream configuration. Did you confuse with Dest Port vs Vector ID in
the documentation?

-Akhil.

> 
> Konrad

