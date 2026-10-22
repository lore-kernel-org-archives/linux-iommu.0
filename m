Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705607;
	b=1v7ly6tsDTAdiAz5eCYAZUg4r0cLwNa91K9Uxrab7tnLeGgis+zaNL/KYBVgs9ZXxj9G
	 gPxuq+egqEm5Wlt0M2nmN98uAXM9f22dRVmwoEKzYRNHfVkssfQACF/3BHPhgX/sJuh5x
	 LaVKE/IW/eJJOOdXPpUdH5abp8xQTYyHBImw52skK1XMciXnD/Q+iYNggFGQa6KrsEMAq
	 XvoSXXIA/KgMgcX2YwT1gXlmNwNLSPEWa2IkdgYPw6U1txc4ysowU9vWs03238ChDllEM
	 Li8KjZ1TVC9HQSAr+uhPvponKAS8XfrlKYlvQmaLi3j2pGCc2gFb+gBxQzlemABbKEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705607;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6QE+P56C2nYaSieRX/rS/N9gClwTb0YY8JP9mDQoasU=;
	b=zwQEbrXt1p6yYDQQyW0xC29EIYam9JrR1wOs9qNYaXiLb0WjNLQbFwakZw4C+Zm3BpAq
	 ls08oVtyOwgSNKZqNgADJawkIeV+zjDoqn2r6YIYqINtdLQk/jt1MHJmCY6l6gQtnQRJ0
	 WTRXk6PD09/sAZyg75xO9jBQ5kke6sqBiO85Kq6DN+OBybBPqlBx9IDDJ3/7ksrGOrrfI
	 uDoI0hJrTxPhgjCddzB1xQr+ASDpaPJezD7EfB8q8FSjyWiVlOKtSrNB4MhpxU60mLtDy
	 IbheFGVbDkXMnPLiGYljrbSU5QLojtYy/ilm9huqtmXXr09KLXzGD2YskOcN3UXiz5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UNq+hvA9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hjlzmnCd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A75606A31D
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 21:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18A75606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UNq+hvA9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hjlzmnCd
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MJs20E1189912
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 21:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6QE+P56C2nYaSieRX/rS/N9gClwTb0YY8JP9mDQoasU=; b=UNq+hvA9A8DEwJLN
	NSYfFSTtglUNNRNcKnXpBoF+eJxXXmuGdMTgqw7kmS6wZSsb8jP0zZbtAYPZSzvI
	sKxCKw85TSNNzD8r8KAvtkuj309mg2YOI9eQdAS7L1XUYlYegnK3AIzwdnpPabzR
	ts1NDX3Mhqs5NgWyklR+me2lpJcGfo2BgTM6lffe6lljiqxNlxwjjqWlaMcYRcZn
	7/v6+pT603Hh7qLgcO3a3t8hIvCiz5xj+hQQuoDccw+7GKskfaEsyKy2wsD1D5s8
	e5B3IBFArInFKq54Cfemsc0cdvi8cf0svwEMsRslmd1Xlg78ZZ+q/UsIiFXWZdty
	4wjHaQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmj8q4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 21:46:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c3c370b17so427447eec.0
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792705600; x=1793310400; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6QE+P56C2nYaSieRX/rS/N9gClwTb0YY8JP9mDQoasU=;
        b=hjlzmnCdQFwedQoDapMqP8fyTnib0k/ddL+nFur7rMQIlUtVQd06O+i5K96Jj65KZl
         aWm727cgntYjfb7py1AMsdftfnQBARBPP6IsZ9AetlQT5e6i/jN1pIIlwURVsH811PLz
         OSIHYbb5eNRZ0U+bmVSFTOWD51x1n2ItAV3b7HDOjuwbr+b2rsq6fFGtWJvrWRdXWtUG
         rdGW9OSq1IAr2vHrWpGBkUqGqmo8Ukp8KXMQUWSfSdCEdidk8yzgvyc4fAo+s5MqW90j
         AAET7zezjO0w11gbAncH0yzpKrCWpW2xduQ6hmfkIjXGLywusJvggfGHdJLqQLlgEuZB
         YiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792705600; x=1793310400;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6QE+P56C2nYaSieRX/rS/N9gClwTb0YY8JP9mDQoasU=;
        b=1FGH5qmcUThfH0SeJz1xfgtIDnRBIHQaQgO53o21EQuR9OXEJANE7esRrgZvl4glGN
         CX0goHcokGOZZM8+EPsioQSqL5xdEhSAHDTIzkP70BXm0dWy/m4ITm5FLILHNXLenpvk
         qcbyIAWhdt2U2V41MOntQsoLnUjaIBNyXguxOuxdnAtIpwVmYiblSWBJmPz/NLJzdp1X
         dAO1xLyAtx5rbMf8motKNIjLvPwpRPufegmKLe/tSUyfLyFAyJKnmMO021r6Qf3qk8XJ
         WfHTLppbj+tDj5ggtvZ4vxpkZwvxfGfz+8KHFphRmTrM11FkllDL4TE8nHJ7EgdySexG
         PdHg==
X-Forwarded-Encrypted: i=1; AKwUvBwo7J2EE1Jiaxqxa+RJr8GDsUgvEkJcE65kl6TF/6yBhAWpqiCXzhcsuBVFSgVBM41O0aHKcQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJkvm/Y2sHQSUI/YcoJVk1aFFcDwPasLNOM0cQ+WO/KF4uHmFlH
	i9135ygKfWJFZkwDxRv7FVaoY+YdsAQBO+Ii8ukvRxSZQzmJrVNI1BR+NWQCm9/ni5g/rh26T2M
	QnzQQFdSEcsC/P5iR9jdP+cKoCnfUa+mAmNDbz2ha4lZR5jmT/cM6o+oTxQ==
X-Gm-Gg: AYBFou2SZFjWA4mlMpnWssyUP17MUeGvRT5Y6ANuG+DknftV83kWN6SRw3UdSjNvD93
	5dkJ181wmQvGtm45Tun0BedX2Mx57ZngCZImPj30RD0VdFJ7olSJl7qgMnp5QBMZhteQtGHi4wQ
	Y+kMzzXNxchFQqCzOX036UJGyawtgrWbWC3D1Npp/nfdndQ6fAIrOZn1afoqIcATNMqt4Dc2L5Y
	Jogl4od044dAgF/2PUBByFVWs5uwsMu2S3mFJ5ehICbpPcwffME5DDfO8uDp8aSln539bfDTyGV
	vsWgs/ltGghW2T1T1gJSOM7UW1iskAdU9Cn7S1UipNpBYINAinpTjWVXcOnkfmBUKe45zVOTcFJ
	a1StD/K/h8YWXhVyQDTU3m6kb
X-Received: by 2002:a05:7022:1e13:b0:18b:48c3:287c with SMTP id a92af1059eb24-195c693fa23mr494663c88.41.1792705599649;
        Thu, 22 Oct 2026 14:46:39 -0700 (PDT)
X-Received: by 2002:a05:7022:1e13:b0:18b:48c3:287c with SMTP id a92af1059eb24-195c693fa23mr494632c88.41.1792705599029;
        Thu, 22 Oct 2026 14:46:39 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.228.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195e9e9c4c7sm954775c88.4.2026.10.22.14.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 14:46:37 -0700 (PDT)
Message-ID: <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 03:16:27 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
 <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
 <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mdQhMqHhPfqWBu0NqU4gafxj5A5ksKmK
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6ada8440 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ipsIN8yD8anPosRfiFfp5w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=9jRdOu3wAAAA:8 a=InArmlTPJEDsLdIP4zgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX6VR+1FwmCUQa
 lIWxRKlBo8BdeuKDeVnYRKxJdnVHOPpIj07mKfYVQJVmrSgL5sF03BMYquAvKDYe0mAl8kw75+w
 gV4sSHxmXoIKtjvMw2KYy8yw1DIYrCs=
X-Proofpoint-ORIG-GUID: mdQhMqHhPfqWBu0NqU4gafxj5A5ksKmK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX8OH0xond6QGM
 dUer6IwbfvPGmbMQvZCcFfj4rK6x424E7vL6+qVBuqBHtk8f6jXt0IZ8PNqdYvIaeMFg83rOw4L
 SCFHetXebXNppAUPmBY4QMY4lSN7UCUlQPKGLDpc+lVd5bJgC/omA8CzRrR1YzxWRN+HwB2iiaN
 WntdkSjOurCHlae6Pw6lrurQHpRoor+M180iXmPOPe/dRseE5EoHAgm7p3LWQv6Nx0t9Hye4cDM
 l1VSOFDthgG1Tc6XKkB70/YqyUsGLVhVcFPdeOG5Yyyzsa2cGD/7FK4axUvuvE0ZmGjtRcQYLcb
 JWT7O+6/MuA/8BNI6dgtAauZ95obiLiwNQRgcimbqdztDDk/jc1ds2k5XcavXLIvQ834qQMmJEW
 GK5cXB2LPhxQd9+RX/CLjsN2ABKay2ooBTEy+bCyx5bVb9C+5sAlj7rt3/q+4k0XLWAMzKyQ7AP
 Psi/ZGc7HxqyhDc6VSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220086



On 10/22/2026 6:24 PM, Anna Maniscalco wrote:
> On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
>> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
>>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
>>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>>>>>> In order to associate the SID used by LPAC to it's own domain and
>>>>>>>> context bank we need a separate node on the DTS.
>>>>>>> Can we use iommu-map instead of adding a new device using the same
>>>>>>> addresses? You provide zero explanations, but it seems like you are
>>>>>>> trying to separate a part of the GPU into a separate device, but it's
>>>>>>> unnecessary.
>>>>>> What I was trying to say is that we need to map sid0 and sid1 to different
>>>>>> context banks.
>>>>>>
>>>>>>  From what I recall, so long as we use the same dt node, the iommu drivert
>>>>>> provides no way of doing this.
>>>>>>
>>>>>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
>>>>>> and secure.
>>>>>>
>>>>>> The address on the lpac device doesn't really matter. I have very limted
>>>>>> knowledge of DTSs but I think we could just leave it out altogether?
>>>>> I think, you were poined to the Glymur Iris patches. Another option is
>>>>> the QDA driver being submitted too. Both ot them use iommu-map to
>>>>> describe the same usecase - a set of SIDs which are used by the device
>>>>> but which should not be a part of the defaut set. With it in place you
>>>>> don't need to have separate qcom,lpac devices, no additional properties,
>>>>> etc.
>>>>>
>>>>> I'd recommend following the same approach.
>>>> iiuc, the conclusion in this recent thread is to use child nodes for a
>>>> similar case:
>>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
>>> Let me check internally.
>> After a brief discussion: it can be either, depending on what suites
>> better (and if you can persuade DMA / IOMMU maintainers to let one extra
>> bus or not).
>>
> One thing sashiko is pointing out is that new dt should work with hold kernel so, in general moving sid1 from there would break it since old kernels don't know how to handle them separately.
> 

+ Bjorn/Konrad

Not sure how strict is the requirement for compatibility with older kernel version. An
option in your case could be just do an override in the board dts file of the
Steam Frame.

-Akhil.

> Not sure how to address this.
> 
> Best regards,

