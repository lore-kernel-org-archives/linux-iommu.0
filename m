Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299A3DEAE3
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876804; cv=none; b=qmzT/MGt3YMTgt4ozDbwMV6UGgCpd/fUD0lidIzCKkZQiYMitSktROCu7ybzACaP5eoz/Cm6l6rYIJjPR5KeohGLwvlJcmmaV5ZwGqkU3laL4BIrnTwQ8EOcgGQbkKbh100CNu7kb5BzZ4ayw3JL7l4s0Q43u6ai6H7SeLqqCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876804; c=relaxed/simple;
	bh=CqhWlI7Y3gRUpaoWJ+3vbINlHXt6wzCF7GmgQfe9zzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2ILE798T+oGzgRh7bUHdMNyLArzJjIZEyk8LCFJr9UWGt8hglIKYpJEgUt94OCm0PvxErYL6phkuNZJj7tAAMXs/VW6yBUY0bKh9erE1+9iCES36hZsKYWVD6K5uavziySNxaIse5TQ9s4NheTWsGRsKa0JT16kREhkyysvd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ROzmynIP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XINZygYS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ROzmynIP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XINZygYS"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FKKi3W2651400
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 20:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Vi18EPVEaeSJoAP2fZaJ0X1fMDfth3C+xWkw9ingqo=; b=ROzmynIPA6lwPQK+
	xKMW9KCUVMKLPdJ8Z9R/S1iX99nA855cRLSEyp2k2Urql3d4cDxRr7GcEQVe4PIJ
	2HcDgS8c8Xj+Gj0j+SiKNpO3aN21rwAzwBuiuFPMsBRp+JucCvBdZmBf5A2Xs7mm
	0py1fT3+flQLXNZgMlw48QqfWZIYOkUTP/Hh+sWqtk1bEPehlXdG47zH2j7b+v/K
	uBxcFmYcDNgIU5xCU+NFOdFbPEQ6ttSCWrSDcj/YYropdlGjRoxIo+M+PjDRqcpf
	75J+R9jHtD67h3WpEq8DBDnfKt6Tm7Aw/Zik5N4l2DtzC9r4BQDnRd7likqnuDSh
	2wK5Qw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6aep80gm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 20:26:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso157562b3a.3
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778876798; x=1779481598; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Vi18EPVEaeSJoAP2fZaJ0X1fMDfth3C+xWkw9ingqo=;
        b=XINZygYSUulhRKN0IY4J9AtzLUfhAVV1AojqmUurl8hsjQNFmRbqN5oWWk4NgohTiI
         6SThttN9Dv15XQ+xdHN2zRC0BY6+RKQuJMmT3XJoqdpsT0PZCQ5lbnrpfN7mW2GfYCpR
         Ro3ecTfZTuM/kKAKewOEPmCjHI09j4KPUHGYu4/7HkJwc0ZC42y5PLLBNwlcZmR6Rsjr
         19nfvIWYhVilGy9iDREfKk40F+YFQaczWIcpIFNCBJGDdGl7Jw6wpWkSShmqSD154lqj
         7hWnpMC9QXlrHTRpuQIklb5qhbAYQhVZ7aHm7XSLH8nTPNx98Wm/+9DatcTCsc2JE3Dh
         wV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876798; x=1779481598;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Vi18EPVEaeSJoAP2fZaJ0X1fMDfth3C+xWkw9ingqo=;
        b=hh03I3pWOOhQNhv+NEJrGvOLNRUdebb95G2MSv8WMDrebKGUkzG7E06cJ8Aw3aGlH/
         bW7zpfNgiJYCbzgu+bo8NxQjwxn0aj1St9I6F6tY+gZXN94o+McUcT+2RhsOS5EMxmlJ
         ZiqA5AFmfsxbaNdQ7SWPUyXjO4pFZz4GQW2AZQgqyOGV9KE4fAZ7SQdEYWXDOty7U6JB
         ha2edtdIgMP0mRr1a6vWkioqynGGmcG43QL9CNMbbFM6NOif9i7qs9YKZ6+J+Gpn3Wx6
         IsX1iAcNnfmbjC3Ge01JNSPm4z0x8cxLAGiLPpt0Z7MG80n7vulKzk0mplF7mjgPh8Ls
         r+Sw==
X-Forwarded-Encrypted: i=1; AFNElJ81hxY4fjL0mZBr0NWoJkjzb4gEJDVayHrp+ZEQykUN+vPnST92AxVhPblIaGVOd6DKzJW2fQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTMQsP2si+iG9U27xcmoOeAVVpoqItRnAgXe3fEViLIYkd9qKR
	5CLJ54Q6OhZnl9dGixI/qSrPn+oBWnFaiLnpoL3H9ZVxMiE/fbINIlKTO49GM6BITlIW5GPz5Aq
	bB1AwHVp/lL+EOEL/tDoEcoN/DphwfjDIH1tExtHa8EYtEcAXFLrDw+gGSg==
X-Gm-Gg: Acq92OFHRaLR88f+2QZIXtlJOb8pwOaChPpvAL3PVdfRbdITA2/P+59QCUKSRSdy7kp
	s/18F88oLK1rICjjLnFKHyC2tByG0paDJuWNKgpreH8GIWYU72eJJjcgaLSoJXxBiRw+iI7hI9l
	+1IAoKJs6XWgVv7+zDcZiKN0L1lUS4r6Wfy/5KJridx3VE2DIW8vSDGAUNWtPWwPbnPNhOAnr7f
	eAU0X/Nt8mosQPS0gO0H1DRfmU2gIKjojYTWYGQI5IpeJLeQEQngkyvUsNeRMN1VWDzRCB4eIdi
	Et0Ngl/ZIwNSfbHdjuAeZWFVN70KyvKcMr3i0z6qLXnEtOL9j+o7Z5XihdJ+MAT5yzDMFiubu8K
	RB0J+dljsDJA+o61sUguSkju93NBDQ4AnhmFkgzaVRAM=
X-Received: by 2002:a05:6a00:9502:b0:834:e092:2631 with SMTP id d2e1a72fcca58-83f33c3710dmr5683371b3a.8.1778876797981;
        Fri, 15 May 2026 13:26:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:9502:b0:834:e092:2631 with SMTP id d2e1a72fcca58-83f33c3710dmr5683325b3a.8.1778876797457;
        Fri, 15 May 2026 13:26:37 -0700 (PDT)
Received: from [192.168.1.3] ([182.60.13.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664212sm8255734b3a.2.2026.05.15.13.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 13:26:37 -0700 (PDT)
Message-ID: <8ceb09c5-7da2-4cc2-9e6e-0c08b509c212@oss.qualcomm.com>
Date: Sat, 16 May 2026 01:56:26 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: arm-smmu: Update the description for
 Kaanapali GPU SMMU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-1-13e1c07c2050@oss.qualcomm.com>
 <20260515-reindeer-of-original-skill-cb55a1@quoll>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515-reindeer-of-original-skill-cb55a1@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 246d0tWxNqd-g4xa6vz1ODzeQtJb-Ph2
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a07817e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ba8plz+5YpscmDk5DVa2Cg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=T9Sauys7PDlx7jIQPikA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIwNiBTYWx0ZWRfX83TO5R/QcLdL
 OuQG90TrMZ4oMA/hU9RYH7Yausqef2BZx1x2eY6nD+2bKRuDK7xTHVN4nDU+z6xQ8i1Wm57x8h9
 ZRT8TqI9zhsjmP0cYZjFkTEEGq4WTrnh4smbZ/mpFO7bUbkEoFMeO1/YNjaLSd5h3lYhZp3CsZx
 7VSdkulJJIzK92ffJAm31orMa5LPy0QL2urXCOF3p3FbOXNO0latL5BkFn9uZKRIhByCwHhi77X
 AzDc01MT2K5nYKzOjY0TA6AxfvCHPR+lMBr27qdnbPyCP0yoIq6JmPQox7G/PHpYXw7Wy2MkKi2
 lj1zsgKfLWEPg6ys/RW5OWwdYS+karERV1JNlKHuSdH5YqX4dX7bf79TGdBwry9kqBxOtscaJbQ
 8z8e/qtSQhHBOwvB6iV0DRWEo2mkWu3md7ezwPoi1HAVx7rayV+eYqsfgKOQ0ajKty3W7C5HQGG
 jwDANah+1O6BoLIWRFg==
X-Proofpoint-GUID: 246d0tWxNqd-g4xa6vz1ODzeQtJb-Ph2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150206

On 5/15/2026 2:11 PM, Krzysztof Kozlowski wrote:
> On Tue, May 12, 2026 at 03:53:15AM +0530, Akhil P Oommen wrote:
>> Extend the sm8750's clock description section to also cover Kaanapali GPU
> 
> There is nothing about sm8750 in the diff. Probably you wanted to
> document the constraint of clock for Kaapanali Adreno SMMU?

Before I rebased this series on top of the glymur gpu dt series, that
entry was describing just sm8750 gpu smmu's clk constraint.

If it is confusing, I can reword it in the next rev.

-Akhil.

> 
>> SMMU since it uses the same single "hlos" vote clock.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> Best regards,
> Krzysztof
> 

