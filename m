Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817732E148
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059611; cv=none; b=ZjFEzJsTXdWWvk888IwX3AoH7H3LPjwmuhX9r7/uosxVcaYv15WcBDLqV9/57xHITEqgXcFCWv+f9fS0RMWW/GqbLpazV7RzJEgeiEdlf1CU6ER/2o4yjTNMijGJr8zcd4DY7c2w07SSDLqyW1DfQGEPlp/YVQYdEAdoUyoVLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059611; c=relaxed/simple;
	bh=XUQCtdy56jkLeN6CjpmFNuiQWWwM5ULplRmS1emubf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRcD4k9Zr9qfiBrD71vGpIQnpG1qvwrBO4JTdlkWeNpMTBxYTib0ZGN5UwscBcic6KoTAOjsUomk32P/KPX00dNB7q7/0k8Nqi3/2p5q7hkrJBVxEID9jFDMC1iZpKWQXcFnJiFcjOBeddWS9Z5hUDYaXkoMy5c0hX4f+JiNmW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EKl86Ush; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a+HLrmxY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EKl86Ush";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a+HLrmxY"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI8s1ZL174300
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 12:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tZnUSUtwe2m6/hm5+PNmIW5JMIFSGKcxs4eESP2A6y4=; b=EKl86Ush7TKUOEgq
	831rDXftpYGxQKfCpMm5QhAzeTCqmdCiC+gzBoiWWOz+w3UMx7RIJj/OsqkgzuVd
	grc2v5dnLO0fRYd9Vgjd6I82fTp1p7B4zRpf7bFOvWwdNtCyKntSGYTwoaet5Og7
	Cf1u69vGNdHkzQs5FTe5fPkHykHVxyu5hlQonZNQMshGLoVn+TxuTyOuEfz6XmmA
	z2X6Qf5ggTNd02v1pt+NeP0bRWP3NcOf4y7UtWM8U0m5+G6X0pstqERy1MhP/zyd
	YcpZoj4lecOQgFJ9hzSwntDc2P9eh10Ode7zmYn2u94bee3i8oUnk74Sij5qONVe
	4INH8Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b43nmthmt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 12:06:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f34b9ab702so1124271cf.3
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 04:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766059608; x=1766664408; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZnUSUtwe2m6/hm5+PNmIW5JMIFSGKcxs4eESP2A6y4=;
        b=a+HLrmxYljqfeshMo8+MP3UbtIcyZmm2NCskhFZ0h7LtjISL/YHKv4yjs3nKgQl3an
         l55nXuMBSiHQcj6j2OpvWhIXobMF2oQYlj3GZjK5ktj+7Mr9SUhbTN92x8qWFfByPuro
         tcqzc0TVMWsb52/fR1lMeJpF8w9Ei6ZS3F4XfY/FVrNhSHb51UFzOkhapC6aYiN3ohvj
         Sd9qtbLajQ0RZfOy+FWfWXWtd7irGrq0+vt87Ekz+r/CV/76Y/gUpkqAkXqq1BjYf2Y7
         8qAkpyLnp2zR7/oMCPH26uJeb+bmDraFMOIl0IMZ7vPp/NJNJmPE/88Vldd4XTUjB/e1
         t8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766059608; x=1766664408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZnUSUtwe2m6/hm5+PNmIW5JMIFSGKcxs4eESP2A6y4=;
        b=TNB2yglwa9iBsuS7kfo3+eRNZ7BLYwfy/YGnjLzm95p4kofr56bc1i7XvyQjxNsMKX
         CS/4V+0qqxgfzuqlhuEtiR4BUIrN5PxjoCWgmILUJSTlv0XmGDpkYksp+mJaVkhJ0quh
         Yd0Hv6R6HqltV8771Kq5J6rx0hRdPkYXTBIJmOj/E7Ugpb9IrEgwI2TzKdlgSBRv3W7W
         GRwV9bS+6uqIpoi/nuik51HZIX3CSfm5gLviNyRutOct3TyiaJ5IOdtndAQHpcD4BEC+
         jLkjPCCgO0TRwqVRBqGbmWl1lXEa1aLxfrbD9GVtyW6D9dwwlfJ0RuE/OSijcT8s0GQa
         ziTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPjfEk3BCTahh54RpWte7MD7NF0Z8QUj6SAPgWMgTXKgDXggPVZIgBi+tPbEHGLiavE70CdA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3RnhYpZ76BwKXhMmRyl6kXO4N5qhkPAlIKZZe4qyPhk4jh6Q/
	xyDg56oumKVcSNwWXmj15cVxrBGlZly0xTTMx+61qR4ywZyeFwlsRAddugv3RJz7HBqTWargNfr
	R0QHunP29YexzrUDvW+Rs76b1mddaIWd/aRC1r88jSDrxwKluSyiaeI1g9+gFlkkhNw==
X-Gm-Gg: AY/fxX7xUIvuK1E3DKWBTgavMHuU8g7FrdjhQ9s8TMzmn57ZupmLC5YWnW/oxxVq1m4
	y/DLz0aVlB/Ul8h5N8Cm6V4Y5rUmO7haW3Z+hK+CJZ64esAl2KIGQcd0elajMSivg8mi0/INkyt
	2XoYMWIWWvDmCoewEqa9yO+KLk7FDcg5hIW3YB8rOzKmzWe9hEle0kMBWclG6qu1x54Q4rYUIAU
	cJ6eA9g1Bsnql90r01/ZwljI4co6Uca9YgcohMDdTVGZApC7VmA6pn0fZeIZL30VKK90OQam1/f
	TfkyyJbkVfVJdbGI+mtpBl2hgrIqiRqh9SjQiuuWuu3EOuM79EM1MKrIAVH3O8WSMb2i6m1NHFK
	A6l4C1L0/qMWNCxPZl0HUSs0PnGwQPD/7yglwIizEWk+u+0M62fY8/BlVl+GEVkV4fw==
X-Received: by 2002:ac8:5d07:0:b0:4e8:a54d:cce8 with SMTP id d75a77b69052e-4f3610c2804mr17836151cf.4.1766059607876;
        Thu, 18 Dec 2025 04:06:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF+09EZkGiN7a1LxeerZG2n1/FnP21wZ/oFt4W9TqyZh08+f+1E8eRBAr3bsry0SLvh5dWfA==
X-Received: by 2002:ac8:5d07:0:b0:4e8:a54d:cce8 with SMTP id d75a77b69052e-4f3610c2804mr17835451cf.4.1766059607252;
        Thu, 18 Dec 2025 04:06:47 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80234a2ee4sm208657266b.57.2025.12.18.04.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 04:06:46 -0800 (PST)
Message-ID: <ba257b17-b026-4a12-aa3e-dab66a7aeaba@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 13:06:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 0/5] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com,
        dmitry.baryshkov@linaro.org, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Eric Chanudet <echanude@redhat.com>
References: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
 <CALE0LRupg93WsBVc62Lqt-T9qmK5MdEYoScxyP7=ttKJYXAsUA@mail.gmail.com>
 <33826089-54b5-47bc-8a5b-6004c7a276b8@oss.qualcomm.com>
 <5a1aaf4a-c5d5-42e1-9044-d12a6c231904@oss.qualcomm.com>
 <1db3d7f5-0cdf-449c-bbc3-dc40c89ab27f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1db3d7f5-0cdf-449c-bbc3-dc40c89ab27f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -l1-6Jk8-Yt0ZdWgeEsL77PFZNlVi29p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDEwMCBTYWx0ZWRfX3AS7W+Xf04CZ
 EvV/D+NyazycSllgSzo1YIvGtRKhK4AMM856hJC913qk7Dj7yyBrmUgpZ0qpUYxbrxSLXS+kqOS
 hTQHFKx25H7uRCu42Y4kDlScLLPB7qKIfHH2kfMxywucSCPVchW5PDcGpxHLhqcv3//lbos7i6W
 FMCdXzkjKriCL94aSnQ6zZKQNrmQwmBR0qEF9DIPdLLoDyIuL8YCQoOA24oCtGN5OHfNjH8ICna
 hXOJQ1YwU1LWwWEoYD3G0Az0HHoVqr8sNqa4rMYdLP5rx++17rK68hXxU1RpCadLsn8AoN4KUEa
 rdfsJAevPqH4qS6D9G3NGdBc6ZMySSLcIRw7ZWUq3vuYdsCTtEdxrqhJFELK2BtDUvjI6Ou82e9
 sC8N/sbIR6oN4YEFQJO7VQPCxDFCGQ==
X-Proofpoint-ORIG-GUID: -l1-6Jk8-Yt0ZdWgeEsL77PFZNlVi29p
X-Authority-Analysis: v=2.4 cv=A6Zh/qWG c=1 sm=1 tr=0 ts=6943ee59 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=GtmQsnjonZUfJvkuU48A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180100

On 11/13/25 2:55 PM, Charan Teja Kalla wrote:
> 
> 
> On 11/12/2025 7:04 PM, Konrad Dybcio wrote:
>>> Hi Eric,
>>>
>>> If a device has multiple SIDs, all serving the same functionality and grouped under the same "iommus" field, for example:
>>>
>>> iommus = <&apps_smmu, 0x2141, 0x0>,
>>>           <&apps_smmu, 0x25c1, 0x0>,
>>>           <&apps_smmu, 0x2161, 0x0>;
>>>
>>> In this case, all the SIDs will be associated with the same context bank. Even if the three SIDs have different ACTLR settings, since SMMU_CB_ACTLR is per CB setting, all SIDs attached to that bank will share the same ACTLR configuration. This is why we designed it to be "per device / per compatible".
>> Does that suggest the settings may be slightly suboptimal?

I don't understand your question

> Or it is limitation to use the ACTLR?
> 
>> There's some work being done to allow more granular association of
>> the passed SIDs:
>>
>> https://lore.kernel.org/linux-arm-msm/20250928171718.436440-1-
>> charan.kalla@oss.qualcomm.com/
> Sorry, I am unable to link this limitation for actlr setting with the
> work. Can you elaborate please?

Because your email client is misconfigured and it broke the line.. If
it's thunderbird, pretty sure we have a "change these configs" type
section on go/upstream, please take a look

> IIUC, unless the SIDs are totally separated per actlr settings and
> attached to CB(which are limited), this can't be achieved...but may be a
> question here to check is it really a __valid__ to associate a different
> actlr settings SID to use the same CB?

The last question you asked is certainly a valid one

But I was wondering if iommu-map could be useful to resolve this, where
we choose an abstract set of function IDs and then handle the IOMMU
configuration manually, based on the func_id-delimited sets:

iommu-map = <FUNC_ID0 &iommu_phandle CELL0 ... CELLN-1>,
	    <FUNC_ID0 &iommu_phandle CELL0 ... CELLN-1>,
	    <FUNC_ID1 &iommu_phandle CELL0 ... CELLN-1>,
	    <FUNC_ID2 &iommu_phandle CELL0 ... CELLN-1>;

But perhaps that's more useful from the driver-that-handles-the-device
perspective

Konrad
