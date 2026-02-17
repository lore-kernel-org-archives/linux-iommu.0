Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E1283FCD
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342504; cv=none; b=BkpE6bP3gSp/VGz/dNc1tdPAVsMbgCODMrGmgHOtc2KCSOMVNsbvbjyRg7itZ+9c7ItjA+qn102tIMX3A/7lUCdCsoAt1Y7bREki4Z6BWzWs+5hRcwDjo1/fbJds+GaLJO5ndTvfFaaXUYPOXYeF9GTbmWIPWAKDwj4DAm4wUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342504; c=relaxed/simple;
	bh=s/UCEVRgEYfNEzZ71RHuEOGWTZxbw6VaGhQmxYLphh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LI7jS4kvDlYf2S2RgL+R7SUnRi/B1bnOgSxpWOoP66vbmBm88RJIT/dPUsxD1HeiptdyAhTY9nslhvaZS2nz/vr8hEhpqLpPS0lM1igJhWYjUCrg4AkVRgk9mDnMCoJWzY69jyD0D4uhijtMggFZ2+wusePLM1k5F+RzpUl8ldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hybi/tIy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b73bmn7G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hybi/tIy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b73bmn7G"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HB47C01943541
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 15:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2iSuBcgCjBQ+kBQhdKe5EhYzO4nkXBajZ+4DR5vCa/w=; b=Hybi/tIycvdrFtRe
	JPN8ykQ6yHimUGhtFFiwCOnQrnL/QvPtZ/TOLBbpyqdclDhFzLVSimibcODdq9iq
	oGBrxzck4lJ0m60b+FQR3iPhAB9PvKsuyamZpsMZq1nCVmNCEfrRJylllcOhtR8K
	QH/tBKDGA3MmNCIs3W0UnaR/AR9Doun/5/3yFW1mtOQBvjSXgwNlVKPkas/P0Mqi
	q+GBL4ccEZ3P15ZeWP3R8YTR+Nsvism6YGSEK891jvhsiCQnd0y3l3jh/VLu0NJK
	/3FNs5eACEComL8+ARRFfNNype6qGVjxGRwMTHWcpCyETw5t0kzboQBpoLzDeVQB
	hvfC6A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccq4g0u4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 15:35:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a7b7f04a11so232327515ad.3
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771342501; x=1771947301; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2iSuBcgCjBQ+kBQhdKe5EhYzO4nkXBajZ+4DR5vCa/w=;
        b=b73bmn7GGOrDebS115tkVHZG/OS2JYHaiBAQcP7sKuupCNzDdHmJ5LivUrMYW9bRHT
         +JKz4aTZYTsxlByrZOn5X958nUtxVVQPk/43aPd2M206UnERHjdf5M2XLSCM5wTBrowA
         x3C64rxm+HD7yzuQW8H6KORnj7H39elhHyNi/WQ0WbiXkus02udzfJZXGPZVVdh0VBQ0
         NGLwGN/o+HOB63pmJdAoy7v+tFJy0AuihNLKWA1m5Fn8wC9x9nUwTDvdvczUpwIl4HHG
         7sl9ARbQmcLda5ANYVPruRhfkH8FiWGGyuZCbxein6eNMZB0cwaHHhBOEdQNfKBSWvMk
         7HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342501; x=1771947301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iSuBcgCjBQ+kBQhdKe5EhYzO4nkXBajZ+4DR5vCa/w=;
        b=Co6cUG1Ix8LspMRtF3kp0cZuZrpbuQxSLTrD6aL3/DGHQNWQbWX4svtaI9CYqYLE6E
         3MZg1vsegw3/LB8T5oJadMMgZYx61UKqSEQlW7qmKvRhl9wO+GJyuxRcDE1hgfK1+A+P
         EnCW3PTAeQu53rjlLkGoYAbshspSI7WFE5ZnDin6jBthF9133tAV7IApDb8UloU5lLt0
         tc7QJOPj4cCfid8erux1zPgTaZSDr7a4iokMVdPaLFQnZhNvScWUU318AxVr+URFu3Gd
         x3+V31Si3puJYYHEeEeFq/50OenFDNKd/ltPvSRCGfWuShclJjR6AXsLhemBV0xCr3bJ
         8Fag==
X-Forwarded-Encrypted: i=1; AJvYcCXWijVcoTpOCy9ZAGA/LdnJaV0kL67tomoL+Vfc6xoUndTC/MxqxHOl10GY7i7SiP998PAXWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy81xqEBMlOIh/wXnA9Kzahygk5uMXTIPrmnQVLRH43KCSa4DvK
	Lw+qYa/iFkxbUNTm4xcQ1gTQmP3yC1v5h3QRToLEiRtGw+wWkNu80lXcUr7M1xaim6Xhmcx5cDS
	PRLlPjAGnntFIMmaHGXt6pYQbQ4GwFzzmVrCpNEMDGA54/WoxWZUiP9PqdQ==
X-Gm-Gg: AZuq6aJe47Jqiz6LVFGmhTgpw4X2uvKrZvkOMESNfCIYYNL0H3jcRQX97BSOHyvhuRN
	vcBqVx7dNAr/M3a7qbdK5smG2oiQXXwZQPCvvMM//HL1J3Y7RzyFHVjltNi3ZSCLNbxsYNe/rLR
	FkCFQJ5xWJYKQGDsIRRu+JCbl4WHx7BaG77F9WCAlLt2TELXqMnPMxOcuKnp0fJ9dnsAByQdnef
	K3V1Z0Kqw0DpSqkdivmLMcT9UBT6RYq1El/5P9t0ksbVRE5UqIIU/gZjy7myMcn72lXeMZHig42
	uoB0Ur65/p/eV1JuJDE90m02rEEGgU+A5sgc7f+PwPS5DLygONiyZtzCgKEL72kpmja8nhODtfM
	ovLPzYsN7OCYqjencYdb4ImqmzItwvXLwLod+k63qNySzq9q3D/vlow==
X-Received: by 2002:a17:902:e787:b0:2aa:d11d:5c36 with SMTP id d9443c01a7336-2ab50598a38mr147079475ad.30.1771342501436;
        Tue, 17 Feb 2026 07:35:01 -0800 (PST)
X-Received: by 2002:a17:902:e787:b0:2aa:d11d:5c36 with SMTP id d9443c01a7336-2ab50598a38mr147078955ad.30.1771342500876;
        Tue, 17 Feb 2026 07:35:00 -0800 (PST)
Received: from [10.204.100.45] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a72e444sm112400885ad.34.2026.02.17.07.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 07:35:00 -0800 (PST)
Message-ID: <5170c5df-e22e-46c0-9713-3c4e7bbdbf63@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 21:04:52 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-1-e2646246bfc1@oss.qualcomm.com>
 <r642meaclfme7thmb6spkna6xiuhbjuqw6x32jndjqhwqjtbbr@qkcziz3cyxb6>
 <b5ac0ab7-2540-4691-99b8-18d67ac63717@oss.qualcomm.com>
 <dhcsnc6y2r2bcjlc54ebo2hakc4tufub6f4oluqq6etjzdlas2@ggwzwoz24kjc>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <dhcsnc6y2r2bcjlc54ebo2hakc4tufub6f4oluqq6etjzdlas2@ggwzwoz24kjc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEyNSBTYWx0ZWRfX2g++bWW/Xb+H
 NcQGxu+6FbcF25VmksnYx9koqgyMy6MNGJuJlZ2jH2ERSgM+5BquZ+6hn2UurNFOvogM8Y6wgN7
 84UA7JELl8Itk3konwzMrxnlCTbLwKP4y5tqUzeXqM0qzkW4WhuSVjG5kSZ0zTr7m7K7h9+fzZC
 ucj7NlpvGWyqWWr8uCQ8e5/xRNvtqaO2U57fChUxpjdk9XKJ/cwE/1Zsw5feYtGtsZKYbXmVuTp
 ogT3kMms3LbZXSoc6dnGjT1i7HwdPixBZu8oUlyoB/LCZlfJdwGWJ8yF2039ccBCEBUF60+LkE6
 U4Z6jHf9rLuwl9ijxKtaQEy2D6UrhQi3V5AG6t8hzY+m/Xaei2KVnXuYkxWtB3WhYM18nnkNFnF
 P2h7+poy4U+HRKeoA5iV+mSfUMUZyrFMz7weIwzeyFZzxNvOlvEzzVCMMysmDON7TdHq8nftyST
 M4wE+yJw5HLNiavF3YQ==
X-Proofpoint-ORIG-GUID: k97aGXxM2l8hhAaEI98gCwm5GdSvs6mh
X-Proofpoint-GUID: k97aGXxM2l8hhAaEI98gCwm5GdSvs6mh
X-Authority-Analysis: v=2.4 cv=YdiwJgRf c=1 sm=1 tr=0 ts=69948aa6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=FBmHkFZO9mc88S3EoQsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170125


On 2/17/2026 8:06 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 17, 2026 at 07:13:39PM +0530, Vikash Garodia wrote:
>>
>> On 1/27/2026 8:39 PM, Dmitry Baryshkov wrote:
>>> On Mon, Jan 26, 2026 at 05:55:44PM +0530, Vikash Garodia wrote:
>>>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>>>> compared to previous generation, iris3x, it has,
>>>> - separate power domains for stream and pixel processing hardware blocks
>>>>     (bse and vpp).
>>>> - additional power domain for apv codec.
>>>> - power domains for individual pipes (VPPx).
>>>> - different clocks and reset lines.
>>>>
>>>> iommu-map include all the different stream-ids which can be possibly
>>>> generated by vpu4 hardware.
>>>
>>> It's not how it can be defined.
>>
>> Do you mean to elaborate the different entries within iommu-map or to
>> elaborate the different stream ids and how they are grouped into different
>> functions ?
> 
> The comment was sent three weeks ago.

yeah, if you could still recollect, you can comment.

> 
>>
>>>
>>>>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/media/qcom,kaanapali-iris.yaml        | 234 +++++++++++++++++++++
>>>>    1 file changed, 234 insertions(+)
>>>>
>>>> +
>>>> +  iommu-map: true
>>>
>>> This is totally underspecifified.
>>
>> oneof would be a better approach describing the possible stream-ids.
> 
> oneOf of what? It is items with the definition of each item.

something like below,

properties:
   iommu-map:
     description: |
       List of IOMMU stream IDs corresponding to hardware function IDs.
       The number of entries depends on the SoC variant.
     type: array
     oneOf:
       - minItems: 8
         maxItems: 8
         items:
           type: integer
           description: IOMMU stream IDs

       - minItems: 9
         maxItems: 9
         items:
           type: integer
           description: IOMMU stream IDs
> 
>>
>>>
>>>> +
>>>> +  memory-region:
>>>> +    maxItems: 1
>>>> +
>>>
>>>> +
>>>> +        iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
>>>> +                    <0x100 &apps_smmu 0x1a20 0x0 0x1>,
>>>> +                    <0x100 &apps_smmu 0x1944 0x0 0x1>,
>>>> +                    <0x101 &apps_smmu 0x1943 0x0 0x1>,
>>>> +                    <0x200 &apps_smmu 0x1941 0x0 0x1>,
>>>> +                    <0x200 &apps_smmu 0x1a21 0x0 0x1>,
>>>> +                    <0x201 &apps_smmu 0x1945 0x0 0x1>,
>>>> +                    <0x202 &apps_smmu 0x1946 0x0 0x1>,
>>>> +                    <0x300 &apps_smmu 0x1a22 0x0 0x1>;
>>>
>>> #define the functions in the ABI, provide them in the bindings.
>>
>> Ack. will introduce a new header at [1] and define these functions
>>
>> [1] https://github.com/torvalds/linux/tree/master/include/dt-bindings/media
>>
>> Regards,
>> Vikash
>>
>>>
>>>> +
>>>
>>
> 

