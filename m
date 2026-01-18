Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAC242D79
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760153; cv=none; b=jmJ2737l2HrcsRwRZQ7Ex72gtOdfVD4FyhHnP/EWCL50poppuK0/sAlmi/EyExWoL0hm0IhzECcp5C862dc0CFzSAN9EjO7+LOL/SgGDqLbg082eLuYGtnHdoSfJTxDEpFQMeS6seu9lX4Fbwf8fc1/NX/mva55BHLf29sV/qts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760153; c=relaxed/simple;
	bh=UW2l/WUr1NmzI+w1eSgyTfUJnjMSLtC7p97KslUWzes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj5MJqqDcC5yyKGZ7Z1VixN4cX7Xg+j5ltMfFAH22ndoRW9fnOLGzDTXePqZ+w3PF2jCtxp/GkVT3sh37tucxQOjSk4EpcaiYrf1itFYul9fLzej5Y3S784NfJhxlYKzaz16V4cCHvQwFnzPkoEVqmNCSxgrk/xXkMQVg+MgZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gN5M+4PI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BcyCVmyQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gN5M+4PI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BcyCVmyQ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60IDHHcp2428567
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BIYjedIc7ra2IDxpaysdB+w8GNBqgMvh/OYIdrZUj1Q=; b=gN5M+4PIBjck/DU/
	yBUyi7dJj7UYTmRZmgE8bQk8U4CCoW+Xlj0/4lARFFd6D5iRWnlT93IApoda541r
	2fMrMSG1DHkvWaCBVple1uhpKlIUt+U0nr6piNoGr4LS3Sc1DNiKQZ4zgLpB2vRT
	xpCPwPGxFQ6t0VMqcorbmOkD/vIxEDBQEC3JevEpBt9KcVoc63BYvRlpbT2iufk2
	qd+iRGE+5WHX+Qf2l7SZyYJUC5gJE15zq37iaZgIS2dqMUdt8KG+9TfEdPYdokrC
	67vP43C2mST2b0OYg7KT0zAqO5vhKUdkfJaSY2+y62dyMQH+7hxABablC12hGYds
	qsJKvw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br3q9an5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:15:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0d59f0198so37826775ad.1
        for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 10:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768760148; x=1769364948; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIYjedIc7ra2IDxpaysdB+w8GNBqgMvh/OYIdrZUj1Q=;
        b=BcyCVmyQPgeZonoWprqhN5N2AxfFEv6vwPJ9L/ouhCMXnBf8VZCMJIHHpvBFCMmXpM
         eK/IhbfGHsYPHTIkI1wuCU6ePT9zJk5LeDdEODdrRJ3/CL+A0KlXEGkM6PZLY9VFZQNt
         wodRiU5q3CfPho+fUXnPofjds+/ha3uDb7Edm5pUJXRbNRFloABj2YJ1t8wKzPONQtkC
         IGVC8Pp/VaH7pqMh6vuBegBIpoH0jW9oH95/krv0yC4UYQx3uEXFLyFFH86nTdNaQxCy
         y8Dlweayo2guubnRHY5hU4cmZLZz72WhhDLJW3CIgzoZVTH1v4NFrtFcQffwaHSp7w1A
         kenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760148; x=1769364948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIYjedIc7ra2IDxpaysdB+w8GNBqgMvh/OYIdrZUj1Q=;
        b=ZAmMAfIfPBXruhp4VDnLasJh4ZyrnnRaCv4A+uUffnifsnjocqutTTQ7Breu6EUnhx
         bmVh8jIVc1qlxFNW9u6v3dQQ+PbgGGj6PI4a0SmQIIp5ZLROl3ijMU2hyVw6VuqCXrr0
         9kGTeUQssiK3JlEbHfafzyw8w/WhdJ1gbkvGqlbPfoFIxf/tbHYwqA5DceJKnAQeGFnx
         lpWFaIMBG7tF+DkoypvStUy3vqCvoW6CBuM3icXKrPlE5jNEbUEykLfO9wsnff1bKKUO
         VD9l9nQ3sn8hHNwWbc7I9BuD+BukJf0DqZnmUsyMCydj7RTCpB8oaWvmcfiREVCE05Ug
         r3pQ==
X-Gm-Message-State: AOJu0Yz5XF+j/LuFyyq04rCQvMofq3nkUXvGimIY5pHHas7cEu/eRz3f
	KOt06DZ7JTcshM4v+agxbC3DpBB4UpbYGcvn6jt3fXpjVVLwNein6DT2EOgXACpsTWitH0JtTI/
	gUQ0RrJi+PxVevq7Sr5yPzxnDhf8phHWTDGbYRS9i/l4WgeSBdlPZLoaHXw==
X-Gm-Gg: AY/fxX6nApGNcFyqMQ1bKkV5wjRMg63Yxb4eTcn+yEi13qfTmC694OE/bEMmBWx30xd
	KSUtHZDU2MQMyHLDz1Ji7Ci/qIYi8VYNsXt6c5GwB16aEXsjsQIlzaDfkWFn+5RyaWrnvlZpFW0
	qsjinRLeYeo8V/Jy9/a1tAt8zUFOGDCuyX1DzQOLNGwMRFXcG/yEKwU3bQejoXWylmuJtTq047e
	WE6Z4SSnxexPVO0Ov3LDba4FjodXlBVjOXRNgkX7V+XxWR8bfx+Lf0MSZ54d1+rZOvR0qK03U8P
	9aEso1Tj/CsR0lTFgCe8gODcjdRD0n63dXIyaT+PyOXe57Ye0+Zy4EbzhwgUiORp9kd21dK7lqX
	twGn+9r4IDtdmMNP7Tymspt1UtTqbD7R+dbaACPuqK+PZyLY=
X-Received: by 2002:a17:902:f64c:b0:2a0:9028:11af with SMTP id d9443c01a7336-2a7177d9887mr111233485ad.59.1768760148211;
        Sun, 18 Jan 2026 10:15:48 -0800 (PST)
X-Received: by 2002:a17:902:f64c:b0:2a0:9028:11af with SMTP id d9443c01a7336-2a7177d9887mr111233305ad.59.1768760147717;
        Sun, 18 Jan 2026 10:15:47 -0800 (PST)
Received: from [192.168.1.12] ([205.254.168.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fb2bbsm72098695ad.74.2026.01.18.10.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 10:15:47 -0800 (PST)
Message-ID: <aec4a691-03c5-46ec-b99a-6b68a2bcedf4@oss.qualcomm.com>
Date: Sun, 18 Jan 2026 23:45:38 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] of: Respect #{iommu,msi}-cells in maps
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, robin.murphy@arm.com,
        will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        saravanak@google.com, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com>
 <20251231114257.2382820-4-vijayanand.jitta@oss.qualcomm.com>
 <fde70548-61fe-41f3-9bdf-37ceda603e02@oss.qualcomm.com>
 <ec91c169-ac9c-4f44-a3a7-b6fefbf2be96@oss.qualcomm.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <ec91c169-ac9c-4f44-a3a7-b6fefbf2be96@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2MSBTYWx0ZWRfX+xcmELxahbRn
 a3oDbRHvcVFQDjzoOKBDAl0hRbm66Eo+cOWVj1w3b37bQ6iXp7COX96zdIbNV5nRum079H28l55
 8L3YQHGnI8uwqInfWBqGA3bDrQx9UsiGVShtXP/kT+blzz3E1rQ46Xb5k6DDZGazaqCVIwybDvn
 XzLvGzia6sbWzuKMckEXb/J4NaEpikYw1rT04unbMwhSqLRBN8L01qM9hGzQmRkjIIXMm1SpPLz
 fZh4VEggVAzhMueh2iCT5c7OkoXVuCMW5F2NN5oLRqWXMTN7hcLSDB3irlnzGjyWv+yFaeWjEx7
 qpphNkc+9qMnQfAR4z6pcMTWPdjDq4zL0HmMdtLGOwYvHuBGwboutsfwUAxyGE61xtWL+9oEK/V
 oZU2Ry6tI5Mb1Zm12JI1APansuvAfYH3Nr12E00hlhG3MNbFvJvOOBqhGpPQkGEcY2aT5CU+pjc
 JeaAUqbB6oi0e0HQvhw==
X-Proofpoint-ORIG-GUID: awBf5dn5XqZuE65xPEsLodzIW0BCKB_9
X-Proofpoint-GUID: awBf5dn5XqZuE65xPEsLodzIW0BCKB_9
X-Authority-Analysis: v=2.4 cv=dPurWeZb c=1 sm=1 tr=0 ts=696d2354 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iXsRcE/C3PG0Ejdleh9IGw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=0PCGqwN690N39_7ecfkA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601180161



On 1/7/2026 4:30 PM, Konrad Dybcio wrote:
> On 1/7/26 6:31 AM, Vijayanand Jitta wrote:
>>
>>
>> On 12/31/2025 5:12 PM, Vijayanand Jitta wrote:
>>> From: Robin Murphy <robin.murphy@arm.com>
>>>
>>> So far our parsing of {iommu,msi}-map properites has always blindly
>>> asusmed that the output specifiers will always have exactly 1 cell.
>>> This typically does happen to be the case, but is not actually enforced
>>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>>> cells) - as a result we've now ended up with dodgy DTs out in the field
>>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>>> provider, despite that being bogus per the bindings themselves.
>>>
>>> Since there is some potential use in being able to map at least single
>>> input IDs to multi-cell output specifiers (and properly support 0-cell
>>> outputs as well), add support for properly parsing and using the target
>>> nodes' #cells values, albeit with the unfortunate complication of still
>>> having to work around expectations of the old behaviour too.
>>>
>>> Since there are multi-cell output specifiers, the callers of of_map_id()
>>> may need to get the exact cell output value for further processing.
>>> Added support for that part --charan
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>>> ---
> 
> [...]
> 
>> Rob, 
>>
>> Gentle ping, could you please let me know if the latest patchset looks good enough
>> to be considered for the next merge window?
> 
> You have an outstanding build warning:
> 
> <202601062128.BCmw1wNO-lkp@intel.com>
> 
> Konrad


Thanks, I have fixed those and sent out V5. Please review.

Thanks,
Vijay
