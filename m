Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE6224AF7
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750148; cv=none; b=SGlXHcIBrtiGwshmj+4JtBnax1IS+pYkYG6W52ozwc7rePYY+dEmjILpMJOhfgxOIsIKG7wicjt7kRhQnV7bg14/d8Wcf6z2vNnKDmRp1/J3Ei461qFuB5OhpvkdyQ/Ml4O9FhWo+44gErYVbnlWAicBPFiWoZ2UkXemsJbobxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750148; c=relaxed/simple;
	bh=EMh4j++1f5WhXslOvJ4Ymu6NYRqvOpseCcxszIz8y0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZiRd0M9RvIKuDru1kQ7O+eZwGRbBR1VjtuXSnqwRw0QGCJqDU3kXxSic/jx9HR1WfPJoltgPzUoFjAh8W6DcQ+TURIcVb7P/+kE1/LeNQgRRb8eZir06IP58xGpeWEpjeBL/8/JYqtUp6aeDm4bJQpSpE+/NkaM9pzbLKWvx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7u33ClC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g7iDo1cV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7u33ClC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g7iDo1cV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E8XsmA2134432
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 09:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RydSWD30OpcHxZbKOrUFMI4Mbf4qnOtNKAlT2KF9B90=; b=D7u33ClCeisfK29n
	f/90B8OAj4z+WI+mnnwv3R84+i8xsdHQeKECVrZW660t1ed1UEG1+LL5Cx9GT0wM
	7sWVUgbXWq3GQ1krxsAZOQfULcES8d7DSzEv7xMHH8MXK6wniCEcGXN6xpJMnGS1
	noLrUey/aHDptkD2smhBhHMZPcBI+BAHKc/PQ+YTcrW6tSj2dftwxFTW30tMBSAS
	kwOh6eBDwoLBKawsAIZzLtxQcXc9COQpzJQJpxLHP9kRgVXuN3qVOM1toXcXwOpr
	y4i5p2Jj+mIymAcpSz9d9FlAF6Ra39r3E0XzacO77+FmQxY/5KGVxVVLkPcE9bFw
	R6eG+w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5b0br5jb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 09:15:45 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-631bec27874so309293137.1
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778750145; x=1779354945; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RydSWD30OpcHxZbKOrUFMI4Mbf4qnOtNKAlT2KF9B90=;
        b=g7iDo1cVxV706equSBACjUTds2hYqbjDF6Rt7I/cKs7jfzKI6hIWJSSWDyqWWU1B2p
         meSyTX4wBw1NiiBK390hFYmnjGnfGsizpPypNg49x3UNO9WQL4wSluMaJjypysNkD4m+
         8Cce8SF8PDrdV4nE8Ub/nZtBMdfYh4KkTG6vAqLD6EiCwLzlNiWkQg8Xa002zz983I35
         7BufsokxYzliWMhyjcz+k8T/4oqOgqOvsVUMqllWrvsBxTi/yzb+489+qvoMzki6Q06J
         LtKwhGN0vsGOOWI52BiAz2NyULSw+kgfUObm37ar5/v3eLAsxA8vm51Lb0oWpljuly6G
         wYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778750145; x=1779354945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RydSWD30OpcHxZbKOrUFMI4Mbf4qnOtNKAlT2KF9B90=;
        b=TlZgJxk7ZVh+f8OsPM6zD7Pp+h4eagt4aq4IkbDpqYDigKCqHTLjgGO4hqPZ+oTVE/
         qo44J0koNG5uGWpEar+E0K6JrlBo35lqaG3YpIavvXXXgXCsa3NznqjN3Ybw+RyZhT7o
         TEm5oLpa/HTx65cNBdN38NcHckq4elqiDVaTxDGyWNAjynxo/y61bavOS0Xas171oM7q
         PlUR1yN1TR/jfmRkY30VQ19FCnyRqf6jb+72/WzsHU2rS+Ia0i1A/Jlzb1rKEQPJ+Dh9
         uz/eCvAxksXDRoL/xYJoh8PFbAx+5uCbjrTxewVkew84gBR3fdCdT3rR/ohXdVhyqFaf
         Uv7w==
X-Forwarded-Encrypted: i=1; AFNElJ9WhKA02aXN4zycgXiQvyLbYBnOIqCCwthSMgsFsoMmjSWgJVRFEWYqvccXfiEf9Ad/pDiPMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC+Z3iVLXUlmbeHZXaqvRhMdGQ6LeqXzpvJ0nv3h77ShqXx6/R
	CtXoD0OvNpgwpfdICnJ3lWv2iDmiz02B/sSh/zlqTrgTBbAl51Sz3o7v0zGbeIMDU6wff9xLxSp
	+KyEedGd03o6c5U68NqZMkim0zBS9tSG1u4Il0wpQKO7BtkrginC+dT7Upw==
X-Gm-Gg: Acq92OFZR8mJzYH/aEnn6F4FLAD8NADnorxGjMrJURTLFtR+5G3HeSvhsQRAoxE4529
	WDhG16z3y5FBgXu4qQr+DEETY98XKgUPnAfOt9fOkkjlsMM5RvNTRLKg+gMmIDCie2oibVDef9u
	NT7pvW1aZUUvs3UWahBIqvvq15YSsPb2i3JC7olWnGMwNYWEUuT4iJUjUPRk4nt3GVAd3vsGef0
	qMVZjnjGdcMZ+sZIXpsEFPLcKnvwpMtjQ4CrkNJb5zAACc5gTPBaHQEQDnKcYMeVFdDxGu2gxap
	PLbAU1P/Ulk9yRR8OU/nxmrQadQi5DaW27vto49Y2qd1q2Rjg+MAZbZOG62TqC53pbgKReyJB8C
	iXaLdKKWsnytuLz351gn1dHwMva1jM2hfPiasaQOeRuC3YYrv3iyH/jxe0tM+9E+KgwzykSKXv9
	cy+s99oij3aLlNuQ==
X-Received: by 2002:a05:6102:3117:b0:632:5db8:f656 with SMTP id ada2fe7eead31-6377454e692mr1064121137.4.1778750144583;
        Thu, 14 May 2026 02:15:44 -0700 (PDT)
X-Received: by 2002:a05:6102:3117:b0:632:5db8:f656 with SMTP id ada2fe7eead31-6377454e692mr1064096137.4.1778750144145;
        Thu, 14 May 2026 02:15:44 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e21235sm66451166b.43.2026.05.14.02.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 02:15:43 -0700 (PDT)
Message-ID: <54abb8a1-e894-44cf-87d0-2341660b7ae1@oss.qualcomm.com>
Date: Thu, 14 May 2026 11:15:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] media: iris: Rename clock and power domain
 macros to use vcodec prefix
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-8-7fbb340c5dbd@oss.qualcomm.com>
 <6hr42ins65rf6ftdmme5lok6ham67piz3343kdwxaff2acktcz@oipdhket32og>
 <4eef8b17-47b5-e8f0-4a44-87fdf1d69d18@oss.qualcomm.com>
 <cyjxjidbe4qpeb5pwv6u5yqwhldqffenzgp6z4irgxkloturt6@buswzuou2w7z>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <cyjxjidbe4qpeb5pwv6u5yqwhldqffenzgp6z4irgxkloturt6@buswzuou2w7z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA5MSBTYWx0ZWRfX9YaJYY1221Et
 B3cuHKRy21eBhrzOasVvCmSTaX8/7JqPpQVq5SnMx3u0Y9nf4P1R8VQ9qs/p+eQhsXqQuspVtdf
 mQg8A04XY0DbfcDsibMyiruRi85GnAN7YM8QmPlB/lJqBlHRVLilyVxZbcFNyiV0jweMYhwnUuc
 2wVdOU1dJfOTjtSq689vviNE1rqRM9UnHfxqD8IcLFDTJJ05vo1hBYoahkmyBq4yL0GYV78ohtw
 j+zZ9WQh3MoarG/i/Ttbk3CZj1cUpx36x8US1Elb9OO1bl7TcCyNeP+QNN0ZfET/Uv2UYL+a2aN
 GCOWf3xUB4O7HvAvRAdw7cQFBiMtkg0TOK+WT30xuvLA3F6rVTqvK7bVejHIbxDEEaPuDSdGGJD
 VP/vP/sk7Qnem94RoHw3Z0BGiRMHq1vU/FnajLU/G+cMs4e08XtwOxbe+HuvvhR3WvWW07stTc1
 w7z/JYW3pn09ATXXhqA==
X-Authority-Analysis: v=2.4 cv=b+2CJNGx c=1 sm=1 tr=0 ts=6a0592c1 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JLCR6Gb03Lu4_UV5QcsA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: t6yjmYn4ePbZZsmu0CrICWPWgxg24VSD
X-Proofpoint-ORIG-GUID: t6yjmYn4ePbZZsmu0CrICWPWgxg24VSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140091

On 5/13/26 3:47 PM, Dmitry Baryshkov wrote:
> On Sat, May 09, 2026 at 10:37:20PM +0530, Vishnu Reddy wrote:
>>
>> On 5/9/2026 1:52 AM, Dmitry Baryshkov wrote:
>>> On Sat, May 09, 2026 at 12:29:57AM +0530, Vishnu Reddy wrote:
>>>> The current clock and power domain enum names are too generic. Rename
>>>> them with a vcodec prefix to make the names more meaningful and to easily
>>>> accommodate vcodec1 enums for the secondary core for glymur platform.
>>>>
>>>> No functional changes intended.
>>>>
>>>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> ---

[...]

>>>>  	IRIS_CTRL_FREERUN_CLK,
>>>> -	IRIS_HW_FREERUN_CLK,
>>>> +	IRIS_VCODEC_FREERUN_CLK,
>>> Can we at least group them too?
>>>
>>>>  	IRIS_BSE_HW_CLK,
>>> Is BSE a core or a codec clock?
> 
> Unanswered

Is it the same BSE that requires a new clock on Purwa?

https://lore.kernel.org/linux-arm-msm/20260507-enable_iris_on_purwa-v6-2-48da505e23bf@oss.qualcomm.com/

Konrad
