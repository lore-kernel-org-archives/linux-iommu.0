Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82314508E4
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459696; cv=none; b=SBgeETuSOampgMx1ZJm+eloCIzVZrceXcRmBNCL+m8TC95v+XJzjWGbQWK00jNbqjrqGKxyYVvCpwLVxs5/nTd9Q0GJloKOXhag9xoSmthplhi+7Lfzqz2GhMxtouf4v+i5eb+lQC9N87oz1fIVT86fKysaUpAzue/H/7xn55WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459696; c=relaxed/simple;
	bh=8mJGK1FLLZUOOQnXFpViOauQDAtWi2US3DDWyQeF3nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHicX0lmRDdtlFzGmmQT+f3597641NEi4IjEWj43gt4NpcB/L2YlRpLnWjGxHjnqzZkG51GRM+Z7dO+GPC7/hZTWG1l3OVaHsHF5RHdAhslmw1ypQwh1qKYTVz3B74T37/8z6yy6E/podLuP8GtVpI4zjrrC5IjOKcBQwePWrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i53jBIPC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VzHKXPLb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i53jBIPC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VzHKXPLb"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MBZUuq1297958
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 14:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b9j+7eXCckmlcKUILjcOcoFvG2Vudf6r9KN2UMOzISo=; b=i53jBIPC/i0fJ+XE
	U31AvAFJK00Aw55SLFDhZpf9lvBlALSDqdHh83+TDNR4hZ9LMb4r6C5pvR3RF6sc
	tz+1NaA9oVMMfS2OE74RLPcfsTrOc+/HAHZfoEa9fToc+kkNpA+x94/S9Gn0hDCS
	GYa9PIdAmiM/jSqOm7/gjriNvVSLCf7fcILcUCrOgw0ks5dh7mQQBUpHLXTPAfzk
	0BygaLwdAcCIgymhEwPdYoli/ZQs7HGFxDmti17UqaVPnSOk6gh3deoEljrMKkim
	M+E9DVkYdXwhbXglNrn4dCnB0LTroG6qq5SSKRePg+jTBKw58ePQxP/rssPTbKkO
	8z4+MQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaah0baux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 14:21:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3692f395339so7472495a91.1
        for <iommu@lists.linux.dev>; Fri, 22 May 2026 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779459685; x=1780064485; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9j+7eXCckmlcKUILjcOcoFvG2Vudf6r9KN2UMOzISo=;
        b=VzHKXPLbNaY/fUPrDqekxYqVYSXcRcwsOIQRMD32ayXBZfXnUwWHVem4yu7Wym+Qx9
         wI18auH+ALMCTs542pgipoNnMuBL4vQQgS+d5Zb72WAp2AAvjNsI3M4t57C3LYgzGB4D
         gou5UdKQmnFqMMAaILcXK88QN97ga9kuQtDMHr7SNsmLbYecukWU+H+0y3ByOmObiYOy
         qByaPSrC16aaoqMIOS+Kg268ZUmOTDZ7N0Dzzbo35KsXfROJT7eB06VnFGbGG5Qhapd+
         zrOTxtSao38DBUpWahVWClItq5LzyhBrCURu4l5r6/Y0cbgwo4PWtVPUI86rLH9ad7I8
         6nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459685; x=1780064485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9j+7eXCckmlcKUILjcOcoFvG2Vudf6r9KN2UMOzISo=;
        b=E2PDJZ+gXiedYgx4g+pviiZYj9f/fBwjNzPTLAhxGC/2nsCM+tFGHK4lzr1C791nfO
         2eMmEnKGe5jk2Xm+lhyP/k/GpcXYhlxCnKG1eIGSpQivKDtCtDyrrvAu9tdoHwKHIHQ/
         qVMkOTYANfwox7tN54RzPVBs360kw4RHW0lt2iFdAKjyj9FXFFU3kOUWBUfg1GtlNyMI
         GGaKVdSfnoj6UCxYefel8AYPzhM7I8k3do5LzkX+tL7NhOKpQ8trnOgQ8EiAAsxs2Vko
         +lBrDxxGQZ7MlqRWsfezZvkhVXBOAjldlJoc41xAqSx9czgDQZv2Q0DHuVRefSkg7JY0
         05zQ==
X-Forwarded-Encrypted: i=1; AFNElJ9l7WQYVX6Qn1CyPd/H70VUC4MaSC/WnJrUYXVgrDe2gJJ2aWr7eK2F9duTxG9oX6KzGCCwwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoXYv90gLByWFmA5nggWpeEeMaGaMJQolHTksSvKa+IiAwoNNN
	apcIzrbtW3FJfBA2tjk5s4K+6FE+9btaemIQhj0d38f7LiMPlRbH5NaxPJ4o3q54CgrLMSj2+SK
	qgUB8pgpZBG+d3QDjQ5OAUBaOof0DrKPkVIFHyB8oT7vy01WRL35ziF/ECA==
X-Gm-Gg: Acq92OFxKrmBwtUlKzUfPexyMMj8O07MomIA5xu3k/n2srb3yUvzKIuHICPy6DobOhg
	5e/RO3DV2srn1Vgc9kYIalbUfXcCxYSvvWDkrvq18f9l4oKDe2l0aXxCEFTg2HCgAQ9YFYQ3DgJ
	BOfx+GiinROd4fYPlBavInu5tVJbeyJRECgemLh0Vc9v/4A0ymNAp72NQtPexatNx0kwtL0LZYk
	ZsOfU6c3Yu4c34q57ZP9exgbte4lFqndbDkmYXhGKkEl4WCfx50Jar58FmwU9CFXB1vT8xPpyQO
	xm/O09HBABAy3Mod720Ab0TvTSh9lARJQpfihzKd7ngzB6QK3DqPw2xO34QZRpur/4OB7zwcqQ8
	QXfL5sy0OkXga4rxjSTPYSfL4KGlR//ewWPnsFcBklAz8SnoCNRpA
X-Received: by 2002:a17:90b:5343:b0:368:83e6:ca95 with SMTP id 98e67ed59e1d1-36a671e98dcmr3494398a91.0.1779459684560;
        Fri, 22 May 2026 07:21:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5343:b0:368:83e6:ca95 with SMTP id 98e67ed59e1d1-36a671e98dcmr3494333a91.0.1779459683996;
        Fri, 22 May 2026 07:21:23 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6f0baca7sm1350671a91.2.2026.05.22.07.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 07:21:23 -0700 (PDT)
Message-ID: <8da827fa-bc60-4086-a424-5ec376f15e27@oss.qualcomm.com>
Date: Fri, 22 May 2026 19:51:12 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
 <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
 <iun4ziuei3tzvr75qbbqgxytto6vptvtd7j5mr5ol5aqviaafz@5m4yxgnqjavc>
 <e6572f5b-3686-46ca-956d-c06a7363cef2@oss.qualcomm.com>
 <vjdz65uy4pxlbt2e4wlwvdu5llwazyopeqb3caswvejenm5iv7@3s3p7iz4otef>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <vjdz65uy4pxlbt2e4wlwvdu5llwazyopeqb3caswvejenm5iv7@3s3p7iz4otef>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MyBTYWx0ZWRfX2gymg18H+bbT
 Uxty39bKq8mAtJq4baGay830Vl0TeMRE9db7X8h5gI9Ige6aHAzSBaLp3teA/FZlbe8uJa93nVY
 WlcphquqKTloxagHVDsJS0meDB5YzmTRwbU2aez+7HRPNOMyTnNGVWrzMIinxt+BBnEPR72JxTy
 KtAEnHgY9LCKxG36qVzdZZ8QQ+I7400HuCiVzTkIvYvyGYZQ/oRDg1Duc3lrY13owVZbE6nlq+L
 bkndW2FPfQxRHkMwgmMiwxkhzGNXU6bRYZYiNTnT/lKGlBA4PpJQqiaodbc2V5Iv7ljtoxNW4GK
 Yio/vW8rHoxh44G5xoT4OMyyj1hx90BXp3qpwFjNt3lXTN8+sqX+cjJm4zdtIymazbiKuPjeA3p
 z692+k6rnwjReDRocvFlTtGSYt/AR8wg1CQ58B8X8rpobg4ADSFk1sN8puN8Au6kSsFWXgaqVCl
 3ySyIl6OHYST5APZCoQ==
X-Proofpoint-GUID: V6Gx1PqEXYHIA4kWEMAaPw1gkKyv-gbY
X-Authority-Analysis: v=2.4 cv=LNdWhpW9 c=1 sm=1 tr=0 ts=6a106665 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rjDOXfNolGiz0B_7zKQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: V6Gx1PqEXYHIA4kWEMAaPw1gkKyv-gbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220143



On 5/17/2026 11:56 PM, Dmitry Baryshkov wrote:
> On Thu, May 14, 2026 at 12:17:54PM +0530, Gaurav Kohli wrote:
>>
>>
>> On 5/13/2026 11:23 PM, Dmitry Baryshkov wrote:
>>> On Tue, May 12, 2026 at 03:53:20AM +0530, Akhil P Oommen wrote:
>>>> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>
>>>> Unlike the CPU, the GPU does not throttle its speed automatically when it
>>>> reaches high temperatures.
>>>>
>>>> Set up GPU cooling by throttling the GPU speed
>>>> when reaching 105°C.
>>>>
>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/kaanapali.dtsi | 165 ++++++++++++++++++++++++++------
>>>>    1 file changed, 135 insertions(+), 30 deletions(-)
>>>>
>>>> +
>>>>    			thermal-sensors = <&tsens5 0>;
>>>>    			trips {
>>>> -				gpuss-0-hot {
>>>> -					temperature = <120000>;
>>>> +				gpuss_0_alert0: gpuss-0-alert0 {
>>>> +					temperature = <105000>;
>>>>    					hysteresis = <5000>;
>>>> -					type = "hot";
>>>> +					type = "passive";
>>>>    				};
>>>
>>> Why don't we keep both passive and hot trip points?
>>>
>>
>> Need guidance here, we are keeping passive at low temp so still hot trip is
>> needed for such cases.
> 
> I think we are saying the same. Keep both passive and hot trip points.
> 

Sure, will send updated one.

>>
>>>>    				gpuss-0-critical {
>>>>
>>>
>>
> 

