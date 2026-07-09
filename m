Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB837EFE5
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604572; cv=none; b=d7p+ZC3WagV1jiqgLtOW2fS5slpOLawBFoQIub3fMIVAG/JozPeq9wk2BvqyItK2PYtow83Jkba26tjhsPBaSPqqPoy+RK7ASpxIkTO+arojY42m0Vpq9qc2Zq4PvVXT0gawfKIyGZsIx6H25iP+vsqmH+zeslMdKyXtw0Wt0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604572; c=relaxed/simple;
	bh=Gg4niW8kVv3b3g7jDE+c+5OksWid4lupNeBKdemEzvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcoEV4lsmF3uysSoL1/7xToMdtwzt694sfUz4rRsVLJK70pbs+ovttanKNgebtCTL81EwgGcn/Dz+S02n9sli/gMxJmRr/vcHBYIFYN7DanmbDzFzYoqbTpzOR7NKlmlup68+tNXd6hOw3yQMKpbj+pH7Z0l3TibgYSWS46RRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F9Hch3o4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d4XbpGAS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9Hch3o4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d4XbpGAS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNIBl1525642
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 13:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g8bbQ0UFrJNgIEmJIIRtCAu5z0XVNIydSzCgLYqggsw=; b=F9Hch3o4T7NJsf1P
	wYr85a/DCvN6Lk4nLUGhMp6PTQ8FGNyRBL4yiBFkchly0uHRxjitwucI7vHbO41Q
	tJnar2UtGCxsFj+B9TnV3UlOd8lNnGyad1xFdI9HqkhQGq1dnAAE75yCjkndoECa
	R4gcK36CkRDIXEBDX1V7M1Han+SiynAuFBVvkiZwvIWLJuLueTQRYwWZH1yDT+z2
	4fLwJINlvXvRhk4t6gZnB0o7DCb9bUdfxln07nk7QowDBzRE+SHAg+wyvCC9DSbz
	Mmq2P3Ufltc2M6WYNQiyUmUJ/CIbHY6mcohhCoLsG2pqULDA3YRb2fhaUH9vjLSW
	DbQShQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u45a5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 13:42:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so2823996a91.0
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783604570; x=1784209370; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g8bbQ0UFrJNgIEmJIIRtCAu5z0XVNIydSzCgLYqggsw=;
        b=d4XbpGAS7UOtw0s1m/HO/FDBsWv+T3uvF29ARDHeQhfLprMe9IUMDOidUiK+OccKFE
         G6ITophoF2EABVbcAAafRq8JAExTbyWJHYHoWK1XQ2LTQM7AHRo6nIeHAc4dhyhMTU2n
         42Sud60BXeubyPPUgLygTLW9HU3Rs5VMPzWBbAubG6w6K7yTVO99wzWagSRocCYN8miB
         /HnGhL2naqLPFV5i1Zq4kOCBcBKmuajnhrP16ViK9ZudnoRirQDZY/2WQJFr4VE+ikBV
         tlkIS6Jl8Vq/e3D2e0P93RIxnBCy4L132cpG3D7+NZJ25PjkGJf9myr43V/G2IFiXgDq
         mRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604570; x=1784209370;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8bbQ0UFrJNgIEmJIIRtCAu5z0XVNIydSzCgLYqggsw=;
        b=cTq9ISZh3ERR2/Ea4UqOeDL/MAb8YSALN/ivPhC0dCBpHcVkYI5W16oLbnyPNAHZJG
         R05EuNOVhybblsSrCPbcE6F8P6T/hRWPImoR5ez/Dyxb6NQ3rqU0+9yTZkQxLdRkLn01
         2m0BYlAbWsMEfwYCSb6krhMiXAwHuruDt7tX4u4EpzQUWEbxRuMXEyCLYdnqdWnwL2C/
         kJLqVtuEg+t3MqbSU6agSBCiT0aMKbSxXXYc9iHXWXZwv1y93AtlZ1G3RRrhhb+rKH+0
         Xpu9ufnfUAi4bcFJCN8oE/zgLpzVqRnzyKJYHns/3Dl9h6DOeM2MZjHrwH/p1DpQp+xN
         7aIA==
X-Forwarded-Encrypted: i=1; AHgh+RoYtfx6zb1OckeGNk3SoxFFSIvsbp7FptylBKXdkd26o7dbaUPUjhXpJJdfBMpyb3yJr/gUBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YySPbRPvveDAgnqSOtLjBDW0+3h6uGj7Gw38Ki+jTXIJ6D57dCM
	ewjNML09DxPs2lTeWVQO61/5nR84wFiZQ7ozlS/5JuR/J/kAciqWo+fzbZt7EPAEqvYOiLNxFEd
	rrImn8D1AsxfRJHhIArAXaRbtuatx0K85bS/vsRdqGK0I+c2+wXqYSqpnFQ==
X-Gm-Gg: AfdE7cmEgLb8ZLUkgNXjuDxhCgkvRYjqyJukQmlv97w8wh3BkRDa/IbupySEIgHCcrq
	Qb823WVP1pDlIUMJySOdStns672OYeCbTFUToozLA/kjCR+BI3BEqRwIO2QGES5r0mTQqkq1LTu
	JIUBIMysoou2w+5M2SN4WS0DcshmFz9zdAwyLj7hiuwPq9DmUqpI5T0HIll7LqwyYKA7b4YBTR7
	g+YjCdY4aGn8jreOHEzSywYu0iv7p+UDwuqeVehWGoKpJ+i89MZjfq8WL+NmoYLcCCZ3I3wqdA0
	Sqm/3w6I3iKu7bA4zJs0MQ8EgVKerRK9YHFTY8st2psjOiJIo8lLeZTeVaAV3JLz5x9kYPkiP5Q
	oWfhWhXFHKSO4NydtrmpljfC7cBVxnup1POk=
X-Received: by 2002:a17:90b:2d91:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-38941102108mr6905011a91.3.1783604569786;
        Thu, 09 Jul 2026 06:42:49 -0700 (PDT)
X-Received: by 2002:a17:90b:2d91:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-38941102108mr6904955a91.3.1783604569291;
        Thu, 09 Jul 2026 06:42:49 -0700 (PDT)
Received: from [10.204.104.211] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174892711sm32820196eec.13.2026.07.09.06.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:42:48 -0700 (PDT)
Message-ID: <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 19:12:39 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Anna Maniscalco <anna.maniscalco2000@gmail.com>
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
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEzNSBTYWx0ZWRfX5P1lwlkL0C3E
 exgeue71YP3V0/lM2J3Hsm/0OJiFT1e01J7rzYvK/rakinpEKROGZ4H35G+TUIJ6lvCpfpyZhfL
 3rd71j8S4sQW3IkoMAOvGQx6syhJvCs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEzNSBTYWx0ZWRfX9Avl3JOwQSp9
 /ZWYaMr9Mm1iMTJAiYnsHzbajvdsjSeAvPxXkHCMHitFdow25IJnd3Sgz/WDnPnrpGM6UWI63FQ
 EDBdAa418YcoOLYM78yfzzjA8cpqY3RlahYojWzWC2dWHuhv8E6UThmLgObSD1GrbY7QnmZX08Y
 IV8jPH2LaU+vLR/e6VJO/isoYFNvz7iTlcJCWPgtLPidkX1gqvb5Emhh8a/pDbXJYhydA7cjj7T
 OWll/iv7FFw+QsjPcnXpFOFS82ZARASA76Y8MOAcqiZxead7mhIcvnMb39gqj9AH7JNrNbu76Kp
 JbqWCIOM0BrP8s+AwL2I8XqIbQhXJuT2ACp3RAlskS421C8luLotkeVtVaWNA8upPlHRweXXven
 xvBBKkQwlQJCoecfOEHXqGvtf9JgTleU/xwRNtwRFnRJDDRtX8RO/s7ajh4pewuIbWhCkK7SQG/
 xoWjpdiE11GVs1dL6dQ==
X-Proofpoint-GUID: 3newAp0BjxFGvbFyqJn8EkgpJK_hsD8D
X-Proofpoint-ORIG-GUID: 3newAp0BjxFGvbFyqJn8EkgpJK_hsD8D
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4fa55a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=mritAz9d6wIG9kTKuDcA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090135

On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>> In order to associate the SID used by LPAC to it's own domain and
>>>> context bank we need a separate node on the DTS.
>>> Can we use iommu-map instead of adding a new device using the same
>>> addresses? You provide zero explanations, but it seems like you are
>>> trying to separate a part of the GPU into a separate device, but it's
>>> unnecessary.
>>
>> What I was trying to say is that we need to map sid0 and sid1 to different
>> context banks.
>>
>> From what I recall, so long as we use the same dt node, the iommu drivert
>> provides no way of doing this.
>>
>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
>> and secure.
>>
>> The address on the lpac device doesn't really matter. I have very limted
>> knowledge of DTSs but I think we could just leave it out altogether?
> 
> I think, you were poined to the Glymur Iris patches. Another option is
> the QDA driver being submitted too. Both ot them use iommu-map to
> describe the same usecase - a set of SIDs which are used by the device
> but which should not be a part of the defaut set. With it in place you
> don't need to have separate qcom,lpac devices, no additional properties,
> etc. 
> 
> I'd recommend following the same approach.

iiuc, the conclusion in this recent thread is to use child nodes for a
similar case:
https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/

-Akhil

> 
>>
>>>
>>>> Add the code to look up that node on initialization.
>>>>
>>>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
>>>>   drivers/gpu/drm/msm/msm_gpu.h           |  1 +
>>>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>>>
>>
>> Best regards,
>> -- 
>> Anna Maniscalco <anna.maniscalco2000@gmail.com>
>>
> 

