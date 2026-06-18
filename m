Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1E3C4548
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774939; cv=none; b=ffmW8BOyxHpE668Qlwqcj2q3w32T4eavKyadzRh1gG6lyVp3bQS1oHKGDpCjf6dulwQ5fou8SRCyzaTa3O2YftczTBry3lSVnIJaE6Zyk6O+MqmcafhJ/VwjK4Td+6RT4wMUApY39Dh0Ufcl2i9lmvYR66CRsuMiZBD5OXI6Wpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774939; c=relaxed/simple;
	bh=n0ehsZOkSmTfJUHo1S4dKm5sKDNwaeJI1q+rZLaqI1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZIyM1rWkuoSXx0A+EGOOid14pRD8+7bB7MkmUQAcFvzkFZvLQT76MCGDxQJ/CyKBvbHYZK6GMWCg8PU/xp0z//K0W7VXn5jSHTYsrna8BbeHQSQi7kyfsdNCGMCKL9o276uFSTfpqUVDIEsW2CljUN2gSW9v36ykeAcMcJxGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nb+ExJoK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=exY3Zref; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nb+ExJoK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="exY3Zref"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8FRTk975749
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 09:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eG5zsQP87SBHZTXWU9NhLhnIuxMOy7HmwxVPsoHLI5Q=; b=Nb+ExJoKPrZnZUDd
	7ZNuwFiLLwUionlJ0TLwqBXCS/Csod2cbRdklqc8B13YBTjkdHz8kjEriLfbTx8r
	M1/T4UGZbS6akBVNdIzTYq3PuLgoQwV90Cr13XPM39RjdbOKtFx+QkBRnGtUnxav
	KXt5a+ou+cmZrbfZ9IAxC9UvLsK0y5kQ8OxtZJ/UYxmGldjC77sopevEcMHp1qbU
	0hUUfkzDuWpKlGZ8qMru1tAY1rDqmIxD3QG+6f+bvXxzsgU60TPzdBTxgWN0sTZM
	VkXqZyeM47VAr0KEqv8U/d0u9ieji1ITrYMAYGbiRB9PDMHeMtuHRN7aXjjiVZ2H
	YChpIg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc2hyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 09:28:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-914b9d0162aso21675685a.2
        for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781774935; x=1782379735; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eG5zsQP87SBHZTXWU9NhLhnIuxMOy7HmwxVPsoHLI5Q=;
        b=exY3ZreflBmGTY5ojNhX9CY6oLg/9sYXoU9x3VspYZN6GbCiN9UtksQH99ZPViC7qj
         ThLoIFa6mo777GFgYW3h7zlP3UQOXaI0M4DakvWtHD+DVUINaENwuClh8LWgItiW/teL
         +rOR2NyFuDukv6hVMMTrNVWYzKatWlQcgofD/i9u6TGD1upUegfBVpZLeIT84GjIrdPG
         gifoyUEeNtHGXvthfnyBDdrDVWuvepFh8aFwIz+E2fX/GkA6U1rqMY6xmkcehU1ItDgN
         gVssbJZeurDdlPgoJwtESTUjT0E9FKWB7H4kKGJ6AMMJG1VN2d4pA6fG7bYXgAfU9JBX
         H2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781774935; x=1782379735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eG5zsQP87SBHZTXWU9NhLhnIuxMOy7HmwxVPsoHLI5Q=;
        b=J8LfgcJWJ0/G+ynPFk3hGiXrhTZfRyimsAlmGuePawA0J0Y9HEEncM60WMswQrpCML
         HBdJGBOK8NlRZPgj33G/wvEIwhkUgm5yJohu/CXWg9L8eqYXEPifoJyEnuhEyA3PNOCo
         3UJSW/XdLjmyICRhFz/uiAexkle4elj0BbrswCp0INEEz1m3VzqXqFuSEzkDvKzyTYzf
         R2/CAM0yVvFXFngAJepZyQaukFE0KitGpBJstG2z/LTLkmQpjYI4G3+TBGwJpsc4P4Li
         7PSw8vjp6crrzlOfAsklz1y0/QPkwGaDaGiuubw9BG9EVg5lU05T1pPkmK4mvOxKvMTR
         e+aw==
X-Forwarded-Encrypted: i=1; AFNElJ+a1WJAfOeLhavzVal4oOhlrQ/nRERdf1zlYXL7DlRBFvg7yWPEhaaBugAqnGlxYtSyBI69xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDvJkX9QKpMjJoUEN0twBl0Jp9TKRaSjap0aa72kyGHnFv4ZsC
	CempfGZDe72vrZ64fB5KigJFB4FzbycwovIh8BQUI9MhqcDndXE4WthZuokqS9dajhYx059PWUa
	zhJ/w160jxHEqMcYjc9H3lz/tYbDQ3vNVFSsxx9vFuMy2jJSZRj6wBGCFQg==
X-Gm-Gg: Acq92OEm6OVbb03r48LVDxTl/Bb7oNh7cYayh5+t3iTBjmXhfY/VoNwB9YONQUknd9p
	lwDUmdzxIQ851LB9x27tjfA+d049bKJNbO64Mp4bWyB4QKg+6XtjIXEUx2c6wjI40dNGr44A9+Z
	h29xbQfTdKdfOg29cHnqlEIZXbSX3OWtx3e6cpzXmqS6R+rrGCDyrIGKgiE3ud7AOVaDBL83A0x
	n0LaBn6z4t8cGOgpvsshuF3uUocnTd9bZeR0Kz0HKiArbVrIMvplzosYx12wRXWOvA5jj/S/YeK
	fbThwITeTmyFtocmoM/DtnfPrvOhc4o0TPPRMS46KeF0Zk7hX1ny8RH0nytfLXkNHrHeCg9Pd7N
	VQU0RafBNLFm0Ntz7I3RbvKPPbShNfuOqJGI=
X-Received: by 2002:a05:620a:1991:b0:915:f92e:86 with SMTP id af79cd13be357-91f27cd63c2mr293828885a.2.1781774934789;
        Thu, 18 Jun 2026 02:28:54 -0700 (PDT)
X-Received: by 2002:a05:620a:1991:b0:915:f92e:86 with SMTP id af79cd13be357-91f27cd63c2mr293827285a.2.1781774934250;
        Thu, 18 Jun 2026 02:28:54 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69595d7934dsm1638902a12.30.2026.06.18.02.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:28:53 -0700 (PDT)
Message-ID: <299d54c5-fb93-47ee-9495-fbf48a3204fd@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 11:28:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
 <7xfxlxfqjcqdzl6gckaoyy2ioefglc7bgi66yv5khrbl6fi2zc@ivtiukdaj4jv>
 <d25f24ca-5bb3-4276-ac8f-8340e8fb4ce8@oss.qualcomm.com>
 <sdm7sqiokmsgczeat2mxch42ois5rwabav6c5fm7abct2xoepf@j3kraqrjvpoc>
 <ea345832-711d-4e32-af0f-bc74d8646aef@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ea345832-711d-4e32-af0f-bc74d8646aef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a33ba57 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=gDzzPNA0uyMDLQwxZz4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: yJshDLiH_9E5p7yu5wa5ky8pkDOHLvzm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4NyBTYWx0ZWRfX0lEL9KnuTziN
 UWfm1m2q4u1SV8DrlOWgh8RI5mOf11taJntglYuACZeoDXJTwOF0JIv1IpTLNI8OZ9WfORe1naW
 phu9a/nTjFp/FUTlg45wMRRk0FOBBxg=
X-Proofpoint-ORIG-GUID: yJshDLiH_9E5p7yu5wa5ky8pkDOHLvzm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4NyBTYWx0ZWRfXzy/kuQUcA6Pg
 +Gwy5BYvA5VzRnEvNvBzLmyamlBf3xV5//Te6f96fi7n2lj5QOzlyNW6h2C1HzkNvIcegKlTWD+
 elrnH/egYYMw9xos10n4xA1ehsE4Vsz8cmNHtcUvci/f2mn1FeX5rjrpkjUYSM19hOaurgg9aNL
 Sw9zZ3tOOd4MN0zVtQuURNg+Y2+ifQ0XuesSb9bv6zH+MgZRR1QisGdWW5dm22UdWmmjHtkZXlM
 KmyoRrqpWxkDZoAsDMiCnIYfDE6BWtKHDTWAO0AtwJ15oCgvT7sjxRD6MpBqkTqSGJ3oY7GedZI
 +E5J03Tvec+9NLl4FkE0/Rlu438dRfQR4kSql2HKB+o2PyxecE2j5dJcNEhKCuAqLGmyPsWecao
 YB0wCBJld/VLTgoYxjBV+VZ2s/1WuvqSDtOgkB4jsCR4UTS2T2bs56PtWpAn/+tUEnQtl+/fjVM
 x2HcSGQ58iuKFNj/EAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180087

On 6/17/26 4:26 PM, Bibek Kumar Patro wrote:
> 
> 
> On 6/16/2026 5:51 AM, Dmitry Baryshkov wrote:
>> On Mon, Jun 15, 2026 at 06:36:51PM +0530, Bibek Kumar Patro wrote:
>>>
>>>
>>> On 6/8/2026 7:25 PM, Dmitry Baryshkov wrote:
>>>> On Tue, May 26, 2026 at 08:12:03PM +0530, Bibek Kumar Patro wrote:
>>>>> On some SoCs the SMMU registers require an active interconnect
>>>>> bandwidth vote to be accessible. While other clients typically
>>>>> satisfy this requirement implicitly, certain corner cases (e.g.
>>>>> during sleep/wakeup transitions) can leave the SMMU without a
>>>>> vote, causing intermittent register access failures.
>>>>>
>>>>> Add support for an optional interconnect path to the arm-smmu
>>>>> driver and vote for bandwidth while the SMMU is active. The path
>>>>> is acquired from DT if present and ignored otherwise.
>>>>>
>>>>> The bandwidth vote is enabled before accessing SMMU registers
>>>>> during probe and runtime resume, and released during runtime
>>>>> suspend and on error paths.
>>>>>
>>>>> Generally, from an architectural perspective, GEM_NOC and DDR are
>>>>> expected to have an active vote whenever the adreno_smmu block is
>>>>> powered on. In most common use cases, this requirement is implicitly
>>>>> satisfied because other GPU-related clients (for example, the GMU
>>>>> device) already hold a GEM_NOC vote when adreno_smmu is enabled.
>>>>>
>>>>> However, there are certain corner cases, such as during sleep/wakeup
>>>>> transitions, where the GEM_NOC vote can be removed before adreno_smmu
>>>>> is powered down. If adreno_smmu is then accessed while the interconnect
>>>>> vote is missing, it can lead to the observed failures. Because of the
>>>>> precise ordering involved, this scenario is difficult to reproduce
>>>>> consistently.
>>>>> (also GDSC is involved in adreno usecases can have an independent vote)
>>>>>
>>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>>> ---
>>>>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
>>>>>    drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>>>>>    2 files changed, 57 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>> index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>> @@ -53,6 +53,11 @@
>>>>>    #define MSI_IOVA_BASE            0x8000000
>>>>>    #define MSI_IOVA_LENGTH            0x100000
>>>>> +/* Interconnect bandwidth vote values for the SMMU register access path */
>>>>> +#define ARM_SMMU_ICC_AVG_BW        0
>>>>> +#define ARM_SMMU_ICC_PEAK_BW_HIGH    1000
>>>>
>>>> totally random numbers, which might be different for non-Qualcomm platform.
>>>>
>>>
>>> Ideally, any non-zero value would be enough to keep the path active.
>>
>> This is true for Qualcomm devices. However, you are adding this to a
>> generic code.
>>
>>> Here 1 Would be enough to keep the path active, but might be too small to
>>> reliably keep the bus active.
>>> Other is UINT_MAX, which will reliably keep the bus active but might cause a
>>> power penalty.
>>>
>>> #define ARM_SMMU_ICC_PEAK_BW_HIGH    UINT_MAX
>>>
>>> seems to be suitable here to reliably keep the bus active by BCM
>>> for both Qualcomm and non-Qualcomm platforms (with some power penalty).
>>>
>>> LMK, if you feel otherwise.
>>
>> Shift it to the qcom instance or provide platform-specific values? (My
>> preference would be towards the first solution).
>>
> 
> 
> To support platform-specific values, we may need to introduce a LUT-based approach in the driver. (Bandwidth voting values cannot be placed in device-tree property IIRC ?)
> 
> Currently, all Qualcomm platforms use 0x1000 for SMMU ICC voting. I

(you used decimal 1000)

> can evaluate if this could be moved to a Qualcomm-specific
> implementation.

Add a vendor hook to arm_smmu_runtime_suspend/resume and handle it within
the QC driver

Konrad
