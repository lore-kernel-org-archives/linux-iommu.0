Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42E390204
	for <iommu@lists.linux.dev>; Sat,  4 Jul 2026 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783153610; cv=none; b=qIKqW1uRBAX4X60l5WTDaymQ1FmzAevVVIxbfFQ5stTTlQ1l+akXLf/lxJpBi6+xidVVblCu5YCvvWihU/e9Bnn7qF+ll2rRowqnMbmdqicGv8Vk3fGHrtzCucedERhWQFavSdvXFdy3WBn6hycJ4o1JY7aF8JBfkVqmUzeiYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783153610; c=relaxed/simple;
	bh=5pBxfx6NGzONIJ90pATmj6WKIeItmpcQu0YbmPEzucc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwBaZyUAPCHQozG4ljww/Mc64NtMt9llAtbH3SKXc3Enqn0ffKEaWg36sIRmgBbLJTQR7F6fyyhJ3Dm7OQIlowRAsRlpG12Nt7r6FgAFIaTFgp9PPGYynS92ajCtIJ3UbKFdGCTQNo+H1bRstYuDr7MhorfJf5Ig6Wskykxs3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZemKFxjO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QMenTRt+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZemKFxjO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QMenTRt+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6646hesE2145078
	for <iommu@lists.linux.dev>; Sat, 4 Jul 2026 08:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D6CPp0iJudsU6L8wSjPuRWKqGYqr17Tm7EBF+oYdEIM=; b=ZemKFxjO6AcQKlK0
	SCLwmrUnKICDVi4LvF863+RK7x0XoghxqaAI+vd2UKkMfM9GjsDYhEANFCMJqxX+
	5oMN+94676A8gao4D90SiC+WYIVk89xLAjPVeS5Mm8xHd2bqvcRqjw5mX6H8FnFq
	C42TDsuFiT0ZkYYskPs1QdAhaqIh1ZDvPye+EbsB7C6yRGTT4xs3PeU2phxTapSh
	eNdsY7dbeU+C6yQwcCBXuagTTOszxPEVr1fcfbnnnvUgwUF1IF64iS67VDN2YqdE
	prxG8NZrZQvPmzrD+a8Ii9XmJnS58IfJzdX//+AWlJ4Z0a/wkAxtEnCeOQO90dUm
	muosbg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txegdcd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 04 Jul 2026 08:26:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c89956023dbso1677404a12.0
        for <iommu@lists.linux.dev>; Sat, 04 Jul 2026 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783153605; x=1783758405; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6CPp0iJudsU6L8wSjPuRWKqGYqr17Tm7EBF+oYdEIM=;
        b=QMenTRt+kOJkjqWdrsgNOvvaVDk4uyMCaV+vwJB4S12fBkvBhl/xk8HW65dTyrhN3R
         1mqqp6ndBbbwcODrJ0eiv4E5bO7yHtr7j9ooxjLhgE7W1xi+Y2YbWpaE/t7mZ2LVZ0qB
         R0bwrRvddPLw3rZDFMLHaUxycu5RAb4l5p/gMJ5MUJNs6yoOTC7plrz+VMZk4eteDTf3
         XPW21t8AshyOfOcN5SNbxEY5UqS754EuHuBzenH1CzehIl4xI1zzzCELv4H22Bj2gdrC
         yFdjxcrs11TKksClgHHpLkOMnoegaYMTzCf5i6Wn/ZvyNWf1fT+sOKL1fJ7I68DkbWg2
         iILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783153605; x=1783758405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6CPp0iJudsU6L8wSjPuRWKqGYqr17Tm7EBF+oYdEIM=;
        b=grIRzN2JCq5onGFrJ8srzD0xiBw4jdcin/9mM93gRsRoJ8iMRky7ux9sE4gO7X6LlF
         IcMIofOjcxxyMBWPRZGmfQqUjL8HgKw67poAYiFYUxlLGqzGl2Sx3bH5mKN4c9ZzXJsw
         kvLQPd46hjIVzyyrISzAIX/Jz9EGGxRPhu/4UqrCmDcn0w01vYEgmn1mL9rIQqwq+D7A
         rdPNAK6pgGDowiSqfKNFpvfbZxZzFs0VZao7fbH4+H+lw1gq8tw7CR5lhEgu0oyk1ZnO
         gdf4Rwm1o1JupqRDBkp+5VNJo/5M/Ao50PqMYJme1IMwGVmOc3dTar4l6mhOJd1ti1UP
         y7ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Nu+3LaSpN4kMrsRPfclg7Ixu+Rg6U9T2P5VRLzjXsmcT+6OpmkYhOu5fbnetcIUjL6yC3ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLfE5Yvv0uLJsopT9qZRm5RHQ7HXHgRg3tCErKcZq4OsBIwUOS
	QvxvoGMC2AwQ3CvGMoYA/jYdwdnK0sfU/soLJCRzXx02hM7HT57ur+pEgddytJ548ODTXbx2JYL
	4v4NS7kjEc+HG/l3bLNz6dS291qqJHz3/XzF0kwS0xlI7L8foa6sCjSE94g==
X-Gm-Gg: AfdE7cmsPrzjjMEfjIt3kPure8n+u7VPx0fOuGvAaNjmju21vKSrkB7Xy59vx0In28L
	+4kg7QwH2IIb6F1Maigv+X/7/xmJ6G3Wf+ucyTRPVV+PCyNZ3Ek/lKxXsZdzvS1OBnHdwkSEXNU
	9F45BbQplpD38br+Gi18ls2hgUpNgIOhugyKq5WvwUyOW7kZeqKm+V93hdxbKufcWwFTFanbYL0
	QKY/aENqJSAdClJM2aOWibc0+Vg/tpGWQjZo5RzQuF6F0vrvtWf0WPEWQqpFFN9GmMcWqPAjO5/
	XdPFzjqO/RHKbEW3i/aonnW90mm9GbS2kkMYf6nuwvwcTuT1apgoSp6lZPphTjtVUvJ9jZsPRDx
	RGkW3AIM4T2b7vRmQpAeJvhETjR5QGr+GjgJsbK+xYLU=
X-Received: by 2002:a05:6a21:3294:b0:3bf:b5fb:d7ac with SMTP id adf61e73a8af0-3c03e1fa2f3mr2525737637.10.1783153605601;
        Sat, 04 Jul 2026 01:26:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:3294:b0:3bf:b5fb:d7ac with SMTP id adf61e73a8af0-3c03e1fa2f3mr2525713637.10.1783153605147;
        Sat, 04 Jul 2026 01:26:45 -0700 (PDT)
Received: from [192.168.29.91] ([49.43.231.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f376bf710sm10035822eec.6.2026.07.04.01.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2026 01:26:44 -0700 (PDT)
Message-ID: <ca8f3731-3f23-45f5-82ed-ba1a65514b95@oss.qualcomm.com>
Date: Sat, 4 Jul 2026 13:56:30 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] arm64: dts: qcom: shikra: Add GPU cooling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
        Bjorn Andersson <andersson@kernel.org>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
 <20260704-shikra-gpu-v4-6-90cf1a52e539@oss.qualcomm.com>
 <opgj6twppqwhb77itqelmyzniaifcja3wdazyzeal5axstr25g@a7v634mnimbm>
Content-Language: en-US
From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
In-Reply-To: <opgj6twppqwhb77itqelmyzniaifcja3wdazyzeal5axstr25g@a7v634mnimbm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDA4MSBTYWx0ZWRfXx7c8wc3QuXla
 oWeaA3b/dNYSPtKhS8qGHE5KIlekn/kO99ISXtHuwsdtO8gYeadGS+chERa8/ylmIzp2d/niCB2
 Qgf+CcmAImO3CXL859A4LyBZqEYfKVw=
X-Proofpoint-GUID: 2rY7vkIwKocRy0ozjbBmxuD1586IVZ0B
X-Proofpoint-ORIG-GUID: 2rY7vkIwKocRy0ozjbBmxuD1586IVZ0B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDA4MSBTYWx0ZWRfXxjaHztNl0BB/
 FDq9BUsbPg5yughtUeQCuLmZ+ZauTdAOgGHCPOTgog8sy8exa8bFLhQGcpmk5y8WvxHpm6fSN7m
 YsgKpDkdcmv+VeFpos7sRf1Pv7Y8l0jAwBxSZmpsZVTPmpiP1Gm0j9yBi1DF3Obmj+IKtt1PhU6
 +Ud/srHpU74rFxzqD1nISHH2VpVRMc7E8SwGULhi/FwmbVxT3njPztAr9+SzM8QNRqMEgDAxUZe
 3y0dAHwuVpd1so/s+eTFcBf40g8QYo5bhRvQDgAod3N4kxtCDqtNCVpo4smKQGlUyF006zi82DB
 nrPREG7cY5XNKp/kZgGeNGl0bDFvJss2RIibZ2D6FZkSyhoUf6MjlagRUYVx6AOOULviXxFt1B1
 0GIWIqffBKOgbAZMB1SanwqkDWKp0vqT5/7qic/YPFFfyMxGZB6+blEFWsQKVoMiMNPkauemiHE
 /02PiKs3TKI3/aNl29A==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a48c3c6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=lXa6t/u14VstaBBXcWJ8zA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=wGVdvqWwsIcFZm6VKzoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040081

will update why part in commit message.

On 7/4/2026 4:41 AM, Dmitry Baryshkov wrote:
> On Sat, Jul 04, 2026 at 02:04:32AM +0530, Akhil P Oommen wrote:
>> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
>>
>> Unlike the CPU, the GPU does not throttle its speed automatically when it
>> reaches high temperatures.
>>
>> Set up GPU cooling by throttling the GPU speed
>> when reaching 115°C.
> 
> Nit: 72 chars. It looks really strange to see two paragraphs with
> different line wrapping.
> 
>>
>> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> index 34261221664b..eeeaa369d3a7 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> @@ -2510,6 +2510,7 @@ cpuss0-critical {
>>   		};
>>   
>>   		gpuss-thermal {
>> +			polling-delay-passive = <10>;
> 
> Why?
> 
>>   			thermal-sensors = <&tsens0 6>;
>>   
>>   			trips {
> 

-- 
Thanks & Regards,
Aastha Pandey

