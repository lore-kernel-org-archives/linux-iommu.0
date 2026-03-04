Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BD33DEE2
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636585; cv=none; b=qgSVtwdnmzSyF+62ZFS/gtpkWAvl75gKOESTrD/Y50zbbG1AdAlHLKeprCWNXNUWCW0cccfOnvquqsSjeds78VkeXieqhmZyfb8lP9+g5Ddm8CITMO0Apx/FzHqU/+zKJEH1Bn919pB+wzxkzcddoEV8yZO1NzO2FR2k/SCmxfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636585; c=relaxed/simple;
	bh=uVM0hFJD90JywvxgR9SbXm3R6fTJLlHTk99xipDVlBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onIMRFeLWdweZduBVDFH2j8MDtnKONDzJcRGI5g+RFI83HreDufrayI6DU3ubLPAt3R0IKQgzuQA3Kc0bawLdXFTFo0iYcwM9AbSVlb1KPhIVyAwPmqcsWnpfo33en34EhSsgNg9Fid+xoeJ6bbXO5rO+Nuc/NNtyIBPaWWJtcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QvLhR/A6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JNLU40tx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QvLhR/A6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JNLU40tx"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624Da8k31203235
	for <iommu@lists.linux.dev>; Wed, 4 Mar 2026 15:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YznXl/xLkt2ZLJrpg7QUQar3vLrClyj/Q5njw19yf5Q=; b=QvLhR/A6+9khpe6+
	b4vHB6T7iMRvGXskX98wfpn9dAejPUUeJMlSwaIsVZeoAkwVpfWSItrbmaMjGA09
	5ik3jPElTxpL+AYCdmDXbTysrwqCr/T0hyLr9AZn/x54icqD7RCpaLfEdo9kFmi7
	UQQipK2isZvsQdtVa/Djt3hfezDX4742vIThCYVJpC2dH7wviDJgnEOM4ZReIQLa
	PhitXKj97DwdZGXXb9viYdMO7L6TIXmJzbeONOWQmSKl7fxnXsmg1UDVfe43aVoR
	f082F8y5lj24vz4zTLsRnwP4iiVnDVL4sdbpAA00PbLrTBKciNtRDXehjfiX2VIJ
	EAxgew==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpf9c1msc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 15:03:03 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8273e7824e4so5110054b3a.1
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772636583; x=1773241383; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YznXl/xLkt2ZLJrpg7QUQar3vLrClyj/Q5njw19yf5Q=;
        b=JNLU40tx07idIlZUla0tnTm+dpxo+j5AXjmya8tZac5wQGYNFbEsv8ZNSdgLHBuPy+
         BF0asQMjp3tA+kYV4NzbteIpgDmOCVW1pL3vHes9nbeTcu8Nbi5YwbUh0OUXeLnj+TND
         +tK85jRNv3T+ut11GpNaWu9AlDKjwRKdEawQkZW0cu+1n3Ffuk7gxFB0N2TZ3kD4n8MW
         4AaNlNAdU/2W1uD2xcDwVyYZFxboKSVVlCkEDGGjseSTqMNxfnrSio7SkST4RmIZXDLc
         8ZuVh5O95KiOLc9QMm24jyP+H1G4NnI6pGxpCY8FvS6kTja1C06DdrHM7L+H29aoNQNP
         0XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636583; x=1773241383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YznXl/xLkt2ZLJrpg7QUQar3vLrClyj/Q5njw19yf5Q=;
        b=BUIXwgFXIE3QMo+yNWj0R9Fat//IsnF5UuoxSsxYbv/wcGrnN2ZfuXms3BiBsV5eiU
         ctQOVHE/w7Yfq+hxUF9R/zaRfXxy0D0t7cAzbRklUGMAJ1/A1MOfIhEhRVirPRhOd6PY
         jKeGq0WmNVuKgEIQYvVcfiximC0mh6HH/NmCOSo70IUy+Ai0azRbH561+eNhULS1d3Kp
         gdQFBjIMGclOXlyUyzHXed9k6ZCmCTUN9cJTWqecT73OYwLVrDE53viETIMtDVxhDcFS
         AL+V+Al3WffAMHDH0HARcK7E2qV/8mB0oGQU5uhgwWwWglnoMEGJwu8RiIi1kvNOt/Gu
         JHgA==
X-Forwarded-Encrypted: i=1; AJvYcCWFTOq+ixYMpW0ral5BmSVy2eco/SBIxej6Ep+IyIPrLA0fgVHYCIyyBrnq4CyQa4Ko0urSKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkupTMPOtCbytbd/O2C525MixZtT1q4oqRyLGQPfzHBms8leF3
	sExmQQxNcBXAMtUnw9w2i1DUgxRX3+g06Kd3H+XaUlgSSxD62r+RGxhHn1Afqqe5plVZYXIiKkW
	Ercsc6ixMM2uNVuseRup3vMlElvV8KW3NApGu4EtQ6qfW4IEgfCPQP0XDrA==
X-Gm-Gg: ATEYQzxN7elw5iOgYWiGVKIiN5lux5N1cqe8Cog0lo+WAAGiCJAfXQjousS1Z+bK0Mc
	rUb08ShsQUHi+++wy5xNLMhzj1JA0ywk6nTATseLgWg2VFaMrL4iKfcY3phmQaueEPI8sj80LHC
	KggE6Mu8u0YYZ/OPsZQ5njd0oWL0GPws7wBt5Yibz8os1CjzMCRpyaWDea4FIYMNGy/A0azcQwf
	Yn9gDB+6cW6zqdyCmUxKMGcrDEvAAPSqYRJvpjN1xda5chymzQDno63ntXRdrVi42GavRHmvE65
	FKwJissx0WjzVZkuE/1HwhdVK4LtODtWDVUeH4qxaEPcEKdoesGe2YA0xHWsHTswcnrmQDT+vXp
	oW4jZfXDgqWSZlVJVGFTMAyD/secvBK2dM8hgdhs2vSqsTOJWOYwZ3g==
X-Received: by 2002:a05:6a00:2917:b0:81f:4529:83a7 with SMTP id d2e1a72fcca58-82972ba66c4mr2094254b3a.15.1772636582954;
        Wed, 04 Mar 2026 07:03:02 -0800 (PST)
X-Received: by 2002:a05:6a00:2917:b0:81f:4529:83a7 with SMTP id d2e1a72fcca58-82972ba66c4mr2094222b3a.15.1772636582281;
        Wed, 04 Mar 2026 07:03:02 -0800 (PST)
Received: from [10.204.101.56] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db1d6dsm17136424b3a.26.2026.03.04.07.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:03:01 -0800 (PST)
Message-ID: <b0d04ced-8f3c-4bd5-a5b5-0b2f12aae25a@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 20:32:53 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
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
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-1-850043ac3933@oss.qualcomm.com>
 <nen35eqhwbikt7jlpxn22hvur33chxibrbmzd6awo425i3mujf@f2cbncxpcatc>
 <635cc998-d530-42eb-95cf-99b0d5baab68@oss.qualcomm.com>
 <fjvug6snigssgheuduzjomzjq6apte2ggixqzjzziwcycee4l2@irh2mkholacy>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <fjvug6snigssgheuduzjomzjq6apte2ggixqzjzziwcycee4l2@irh2mkholacy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEyMSBTYWx0ZWRfX3IkLMSVuCAIR
 Dx16PQKopw+y3GdUXIHbfZvPnBY4gh5PYJ4Ty7l7q8S+yL/ToXk24s2DV3QhUgGwDBxKneJmVVn
 dnjmGWJkadIRzVbSfWIjMxJjTQsmqYTVSuzEGLaVkSU+IeRMTC+rJNHjxraJtVpzVMIUeCb+i7Y
 qL6VGFbWHeo1zSqvOJiOOXgmICFADJ4G/erPQwYXizqiPiyM/wn3t9x18tIf2sO4RjCYxEUAmqn
 +0n8MuM69MA+8pCrwitOPTG/6CkB4jEUUguY/MPuNwf04f5OAbDWxsT/4C25Xo6soZI8pf5WfsH
 4CrHWJ3kjzOWX4tq16XLyptlJvMLJHtoGeafJCbsZijBsMItKURU9AQFzk1XtVVMqhwbVoiW6LO
 L0jRzmBYaEa99zwW59yywGFFFXmcHuhG1MJ4Z+emZy7msXA43tRkKUPH5E6OA3r0X635jsub0V3
 6TSvEVVheGp9kvHGJ5Q==
X-Proofpoint-GUID: asenJt8_Gq3nXgvGd8I6gwmOxwfJfOhi
X-Authority-Analysis: v=2.4 cv=S4LUAYsP c=1 sm=1 tr=0 ts=69a849a7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=puI59K64icZz00i_70MA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: asenJt8_Gq3nXgvGd8I6gwmOxwfJfOhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040121



On 3/4/2026 5:23 AM, Dmitry Baryshkov wrote:
> On Tue, Mar 03, 2026 at 11:43:40PM +0530, Vikash Garodia wrote:
>>
>>
>> On 2/28/2026 1:22 AM, Dmitry Baryshkov wrote:
>>> On Fri, Feb 27, 2026 at 07:41:17PM +0530, Vikash Garodia wrote:
>>>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>>>> compared to previous generation, iris3x, it has,
>>>> - separate power domains for stream and pixel processing hardware blocks
>>>>     (bse and vpp).
>>>> - additional power domain for apv codec.
>>>> - power domains for individual pipes (VPPx).
>>>> - different clocks and reset lines.
>>>>
>>>> iommu-map include all the different stream-ids which can be possibly
>>>> generated by vpu4 hardware as below,
>>>> bitstream stream from vcodec
>>>> non-pixel stream from vcodec
>>>> non-pixel stream from tensilica
>>>> pixel stream from vcodec
>>>> secure bitstream stream from vcodec
>>>> secure non-pixel stream from vcodec
>>>> secure non-pixel stream from tensilica
>>>> secure pixel stream from vcodec
>>>> firmware stream from tensilica (might be handled by the TZ / hyp)
>>>>
>>>> This patch is depend on the below dt-schema patch.
>>>> Link: https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/media/qcom,kaanapali-iris.yaml        | 261 +++++++++++++++++++++
>>>>    include/dt-bindings/media/qcom,iris.h              |  18 ++
>>>>    2 files changed, 279 insertions(+)
>>>>
>>>> +
>>>> +  iommu-map:
>>>> +    description: |
>>>> +        - bitstream stream from vcodec
>>>> +        - non-pixel stream from vcodec
>>>> +        - non-pixel stream from tensilica
>>>> +        - pixel stream from vcodec
>>>> +        - secure bitstream stream from vcodec
>>>> +        - secure non-pixel stream from vcodec
>>>> +        - secure non-pixel stream from tensilica
>>>> +        - secure pixel stream from vcodec
>>>> +        # firmware might be handled by the TZ / hyp
>>>> +        - firmware stream from tensilica
>>>
>>> Why are you providing description as a list rather than describing each
>>> item separately? Then you wouldn't need maxItems.
>>>
>>
>> rewrote them as below and dropped maxItems. Please review.
>>
>> iommu-map:
>>      $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>      items:
>>        - description: bitstream stream from vcodec
>>          items:
>>            - description: Function ID
>>            - description: Phandle to IOMMU
>>            - description: IOMMU stream ID base
>>            - description: IOMMU stream ID mask
>>            - description: Number of stream IDs
> 
> I'm not a pro in the DT. Is the itemization of the first item reused for
> the rest of the items?

yes. As a trial, if i remove one of the itemization from above schema, 
then checker throws error saying 5x9 arguments in the example is *too 
long* as it tries to fit it as per schema i.e 4x9.

> 
>>        - description: non-pixel stream from vcodec
>>        - description: non-pixel stream from tensilica
>>        - description: pixel stream from vcodec
>>        - description: secure bitstream stream from vcodec
>>        - description: secure non-pixel stream from vcodec
>>        - description: secure non-pixel stream from tensilica
>>        - description: secure pixel stream from vcodec
>>        # firmware might be handled by the TZ / hyp
>>        - description: firmware stream from tensilica
>>      minItems: 8
>>
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>>> +    items:
>>>> +      $ref: '#/definitions/iommu-types'
>>>> +      minItems: 5
>>>> +    minItems: 8
>>>> +    maxItems: 9
>>>> +
>>>
>>
>> Regards,
>> Vikash
> 

