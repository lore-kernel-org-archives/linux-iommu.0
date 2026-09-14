Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B844683E
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387296; cv=none; b=OrMu4J6j67o8Wv+Uv4jWvB4jCqG/XrgaaA+NZopEgBziVJYVZzNo69XXC/SaLpO6e1a5ulRmgjRAXbLhITIWhRlR1NJp/CcuvL07QLjX5r1E3duOWhNm8ti6xwL3rD50MWL2YcCnGiRtRjZp+D2oIpoCthY5ZU+r/+w8nPlXArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387296; c=relaxed/simple;
	bh=86eYR0i6ZVOAL+yOW9gV5s1lTtVfbPgehRLwOGUh8MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=us+2Sg/GK9mqgUz5ruj8Z2tMrJPb3YR34cGROzlDQ5AWXZUa+J+oUSNfUgrKTkWThQA596FNVWS8D+QTNZsX5ApTXiZJFkheWqCATJLrMR5Vl1JyquyxFG9kOuKzIpa/p702+16m6LM3GujTe3w7b62Mb3SPmar91FdiJdo5/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnamtNDQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WU2jXaYP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnamtNDQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WU2jXaYP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EAm4Jk1216222
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 12:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=; b=nnamtNDQQ9gHj/1u
	8u+wb1s8mTP6JWRKxKfdX3d8ABVXd5kMHmfW4wQ9nsSyRrjYa8WkAnjy0dXdtaEo
	h2enOSMboZOQCYy8H/CFLdd9f7u0SAjuYTs6HsjKsSMJyk6o6xUB+uwhBjPWBiyu
	sicjPLoGajNYaGVa0l8fMYcMn32TORMoX1I0eqFvp30N4DUbJntsg9O1Mb2f8SY4
	vyxc953Q5FSjtqXmzyZ3M9e1jVgMce4t+MrG76KRNx7HpcRB8WhzKnbYVSsGWoj7
	x1ZSWv1V0N9dsqSCWcPL2ykRO9F2MIYBz8r5t+u5rEJnunkGwCFUwiCOgKAy+DCQ
	w4ofBw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k0acg0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 12:01:20 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97cc3dee8aeso29141241.1
        for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789387279; x=1789992079; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=;
        b=WU2jXaYPumYninu3dwZfvoQBYqhcX/IkKCeaovOXD+blGwd6OgeL6YU1X68AJ4f2dt
         1JpWxlzvuXuaLKUTSEjL8ZBesVqOl+jVdIRYGeHzyLV8nMMW7AAQlnXis7/XtxpqZVSR
         OUjNWYxSg3HY7rGCxEp0FeYYb3btMMqnzH52Uqg5HQ2SRXNSMR1/KAoLoIR6JFb4XSsx
         kvqrFF4A3G48rNNq3Mnzyu86TbWWCRSrJWuHvX72p5qBhe3jBUkCTmLoJJNk4F3AfDO3
         +F5bmq/s1CDTIUUBNx5CAUlP48+lQS+F5UX1LUogxT2R5UZXLBAj4RdcbV2cp24Pjk6Y
         kUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789387279; x=1789992079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=;
        b=fklblX2fm1IoQx1Ud9SgHF+c8++yBsZ62Yd9+r4zi7BlyzaWL5t15i2dpkmsksXfKQ
         qDl54QeE1Y+bVXUUZ4S6x6jxJ3pHtI6hW8oiiPABxa9w710M+SKyfezu+2GgEuWBqAPn
         cszAFMZk0TUsOeggbcFQjXpx/7boZFd+W1Vyduc88BfYIVI4+r7e2ns4SopDEAn7k+YR
         9TWJtvx5NCWxJi4ZBiy6ayVrPmgQxXsGlOR5DGhfgzSmegBzT9ro0h1YTgF/nytAkj8+
         zC4RDNoCas4Dx9xNiAxAvNZcnFwVv7XJ4kf38LFn22xTSsBoxK0kee7W+3GzpFzc2Jzk
         YCnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBvHY1CS7eUxoLsbThBx4lRsfYoXbswqLK7KIZpHDWGh3odCfuClbBlwCPhOKRJLJnwOhM5w==@lists.linux.dev
X-Gm-Message-State: AFuF++l9WBYRP29tD7qfhhF28kd2KZHKDCyX+I4fsZbht1BXajRir1my
	r5pxyx0o++GkWT5U/LJDC7bJPST828Ge3VqzduK8LN6FK0QCAULssU78PE7Jr6RWMSmd99uX6/O
	dYFo+Uazsl4BlJqTmBsp4MiPuQGuvQMhBwdNS/fGPaljSHIf+B2pW+egKBQ==
X-Gm-Gg: AYBFou2On9eIKWz1L48VHN3MhndkOk94b4Spo+nDGuAqFvOcG3YRnvzAD5Zppn4rfcH
	YGuOHVZITt8dY3q01c6S0ZPm4BEUy6WGHhjCrG6gHrTTFeHJYO/+qcqa1NtkLO2pbX+M8GeTluZ
	cme55ol9o1UDPo41LpmtvJiT4SVnSDMmVK/dzEvKVmi7PGprfKpAVpijvZkN5wz5bEmi28wHdtS
	WzY19Cw7wn9d7L78noctypJ4VBR/CO0IdH5/34hIPNe4wqBEqeBmuQY4BPEYFD2JFXNj0zCj7Da
	Fv82PEzOB8WSKpbiZxv6Csox0MfrSX+2OY0PA2/KCTwt6dUkqafOoOTpDbMYPHP9HZRPsFkDKbq
	Ph4p/8P9vw+Oxvo8HFLhyvA==
X-Received: by 2002:a05:6102:149a:b0:797:576b:a9f with SMTP id ada2fe7eead31-79b5be3a274mr321810137.2.1789387278920;
        Mon, 14 Sep 2026 05:01:18 -0700 (PDT)
X-Received: by 2002:a05:6102:149a:b0:797:576b:a9f with SMTP id ada2fe7eead31-79b5be3a274mr321754137.2.1789387278364;
        Mon, 14 Sep 2026 05:01:18 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4dfc7sm417817966b.4.2026.09.14.05.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 05:01:17 -0700 (PDT)
Message-ID: <7f3aed88-fd53-4cd4-a316-630208e7c08a@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:01:12 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 20/20] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
 <d0d7e3d0-15bf-4850-99ec-44d429c6bae1@oss.qualcomm.com>
 <42ef03e8-112a-4689-aedd-eeb7ec9b4f58@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <42ef03e8-112a-4689-aedd-eeb7ec9b4f58@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX5+3sSYffFzrO
 8LiwSyaFbvgpwSrkQxWL9nsVUwWjFNjX1lLJOCL7L1yIga3cIrC9E5rROdpj3nIfAp4NftloS+N
 HoqbULWu2L9IdzIkaC7stDw/FwKwINM=
X-Proofpoint-GUID: mQ8u8FU0MBS-NR8vTrfp4n0luQYvzf2C
X-Proofpoint-ORIG-GUID: mQ8u8FU0MBS-NR8vTrfp4n0luQYvzf2C
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa7e210 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=OuZLqq7tAAAA:8 a=NPzieGulNsBdfkreKLwA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX91YFmhj9GhcL
 YZgaYUyolIjVF3KdO2Szt1DICyn0SjhJ+Az0QC1EQADWGwNq5ngMVlgicXgp1kzFMQDtEcChDi9
 zhTy9q1JZ72sc/OyubPpCFZm+2kuqioroLoHLA9q6VrfHWEEn3aiR7+KhSlGM3Nv9U1+RnaK2/0
 9cM6Rep5/nAMep5IsiSTvH7gVMhhamQ7D2IgD6Iaz1Dq07B5I/DQzBsOtObQ/9u5APSU71k22UU
 7kEzTbKl7/t2HR+xVUyOT1ncgEzrF+misUtmNpuWFpIuZf+5Kv9/NofTUbDs7EQn+M7XZlHA7cE
 t0NUM7CcA0I+fZo4Umv/gKpCm9sEgTwgA2E+BGUVWLp6kdz9m3owUQAw4mui32ESu7uoOlvoqoM
 tt/ERzkUKJpOcoEzZxXo+pgRYDYJNR4aItMLKQ8D5+c8pUSgSun50nr5n7q9PdMqBThzoElmTIg
 Sa2o5Ax9gluVVHemfOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140171

On 9/14/26 1:58 PM, Muzaffer Kadir wrote:
> Hi Konrad,
> 
> On Mon, 14 Sep 2026 13:22:52 +0200, Konrad Dybcio wrote:
>> On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
>>> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>>>
>>> Add General Mobile Shamrock (GM 5 Plus).
>>> Shamrock is designed similar to L9300.
>>> Downstream reference is [1].
>>
>> Please feel free to
>> wrap your messages at 72
>> characters, otherwise they are
>> a bit hard to read! :D
> 
> I am sorry to hear that. vim shows
> it less than 72 and I can't see which
> line is bigger than 72.
> Only one I can see is url itself.
> Should I move url to Link trailer?

What I'm saying is that you wrap your messages at something
closer to 40-50 characters, resulting in excessive newlines. My
previous reply was an exaggeration, pointing to that

Konrad
