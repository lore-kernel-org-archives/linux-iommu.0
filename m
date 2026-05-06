Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A314014A0
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084907; cv=none; b=jEPBvWPmVsgzkI2rMlmOG9byaq81oPSb+QP1g8XraANUT5K9+lJnr+uwR+d2gm+C663BouRebmXcOftapLoXWFIvtQeeWZ246A9v/vQb+V3FKlddzTCblH0pIsaKNZdLB2enSZMexEXN8l+bVy4jRQ65q2ninjqbq4SCjk1lH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084907; c=relaxed/simple;
	bh=QYVtzd/xc7fLQtZMy6ElulTvtzvDpcvThePe9t+u1iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFDD0qb98lLL2swOs9Nh5XrIPbBuyCIh+LK/F+NDFlqeOMG55CIwz0J0JmiXCD0YzU3MS8rgn6YI9DllPN0eFYNSZmD8e9BxqcUQR81kJ5DkLS+QCaTtqipCtDmmn1jMbLjZmBsJF+vWMthR1C1yMvsRljDWTsPPZ8d/pfYUlNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m+4PBVCj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VX1oIhhU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m+4PBVCj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VX1oIhhU"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646A4gHE3524218
	for <iommu@lists.linux.dev>; Wed, 6 May 2026 16:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QYVtzd/xc7fLQtZMy6ElulTvtzvDpcvThePe9t+u1iU=; b=m+4PBVCjRBUt8x9Y
	1V4nTnB8Xt8sh0FUCkGcY6iMdibhGGM6ZCSfLGsXjpgwBpzNbBJqfigCaWNSfgA7
	fkdoh+95AtuqpBEhTd4EwB7rt0ZSCnDVfYLZZynMPrtVmBJ/T/4FbcTnyMONpYnc
	+cEoGx1eBHT7GJKL402X4JQZBh5EQbW8kUGja2razBFLZB6Rq+ukNtNi6hgH29Df
	8Ug154SyyiHoBpX2pDqdVJlyBC1pVPJdANWUFRjVzVSXtnGhabx8y7im4iDrkjHr
	es8/Uq90zcIswIcITlJGHHgJ5P/92WUd/S+EJT/Zq+X/JC5QwcAG1uOBmgvwWdMY
	6x0MhQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jwsesv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 06 May 2026 16:28:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so77854725ad.1
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778084904; x=1778689704; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYVtzd/xc7fLQtZMy6ElulTvtzvDpcvThePe9t+u1iU=;
        b=VX1oIhhURcQTDaZl4IDYSAp7zJD0GVAREMoB1wCVL6MYqJ8GilIwjrCCizQLx3AM2C
         IzWn4xwVCwsfNFNEltP98QQqhtfqKwAodY+HVHJRNiDAnFgXRIeONGzm/oPTH79azeMv
         gWbBbmb1mAkIq5ZcJqPO7LehHJSO6W3K7J1wQ+KiIooytK90EUnhOJi+iGYhE9+oHT37
         tw7Mrh2G9bAjQC+ftS6B1nRyawV71LelF79aG4+h2n+4BXscG11yUgR404Z6SQwleF8e
         HFA2RhiYfKVplUzE68eJNhA/wrULYeuzAqKqqnwwkSCRqoq6vxD50rbmfe3aIO86c9sn
         2cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084904; x=1778689704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYVtzd/xc7fLQtZMy6ElulTvtzvDpcvThePe9t+u1iU=;
        b=AQno/I5HKkkaT9cii7V+Q7PY9O4P0E99519KEoidDyRAGJh2HSNYSA6Z4xCmqFXdgp
         so4QzjLsXVCINSHEwLXOiA8rAvqhv67TXeZn/JJYJmP3aV6aNSpy4I6emryY5Ll29KPJ
         G631Oqwq6dQjm+2RcQ+pd+NBE5RyC1Q3RuxQP+87ufls11eDZXI+D5xoinY0vSfJnhuO
         8YnVQ90gjWSKzWuX7vVFpTAsNrNAM7zPtVZRxFNXqs1ur48oPNrE2Uy09t6P3xAbtyu4
         VLr8OKYcIisve+lN5D1JqmWJxH7osHeV/WAcLDLO7pW9h+j849kmkRXhXgTiGl65VOfx
         mYiQ==
X-Forwarded-Encrypted: i=1; AFNElJ++pxwUHmgYz2i0FQanXYfmOdrXVqZzH3NjIEMFOMRt3Hu6TCwwaOBC5zrZH1DjCN7JUZODTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YykJ9ZFLdWUiscB2Yl9tEiCD3/a4QruFLiLZ5TuWBTGsqGNxWMH
	J+4UES/oYhphP9Qdy11w+1M1ZQmX32t9Dfy4AWuUphBQhuEc49Yj/xU79wPLkePf4pkEYnpa1VF
	uwDwsCGd6I7Yvuc5wMLf98XIj9mBD9waBWGxks6UWvuTlKpfLs7bwNxSZ2Q==
X-Gm-Gg: AeBDievHlERMiRFQtk0WKcifcLpg8Ze7iKkV/LRYkknNwrf2qsb+ykwamP2jUXXzw0O
	hjzBVCA+K/7YtPvPSn74NOT/2Vpi0+21jrgW/M2yVQUtXH8z7CRc1Fc1EUMbBVKsogtiSLJDast
	diM3sX/fNkweL6EJz70W2S1kZcfJjaCQTvRVmFpTYauPcIzJ5W4bNGPOPk/hfFyO7QXO7rRzNnF
	JnDqTWI7P4Y7WvXJeA67FSnmdSL8toBCvij3p+xwYab0PwRmboWc85JQBALGoGWnAzo1DCeJ9vw
	ObNac47Uu45+E+fk2B4FhpgTgMzDZ+g2w2/7Gj4J/POfIqRG65dfNMDhxrf/6fVAvJ3bu7e4u8x
	RDSQykeHjwleNLoS30sarJ9Dowhm0JT8Lswpu+jUQT5lBsC6esHG3tHiU2Rc62YBq
X-Received: by 2002:a17:902:ebc3:b0:2b2:3eec:c75f with SMTP id d9443c01a7336-2ba798a9396mr43247005ad.28.1778084904329;
        Wed, 06 May 2026 09:28:24 -0700 (PDT)
X-Received: by 2002:a17:902:ebc3:b0:2b2:3eec:c75f with SMTP id d9443c01a7336-2ba798a9396mr43246545ad.28.1778084903722;
        Wed, 06 May 2026 09:28:23 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca106e8sm32048405ad.62.2026.05.06.09.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 09:28:23 -0700 (PDT)
Message-ID: <bb008913-1100-9b8a-c7f5-1194df33eea8@oss.qualcomm.com>
Date: Wed, 6 May 2026 21:58:15 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 02/13] dt-bindings: media: qcom,venus: Remove clock,
 power-domain, and iommus from common schema
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-2-17571dbd1caa@oss.qualcomm.com>
 <20260506-inquisitive-wondrous-lori-a9e639@quoll>
 <455376f9-48c2-e663-3be3-fd310afb7f7f@oss.qualcomm.com>
 <333ba4cd-8168-41f1-afdc-348f99ed0611@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <333ba4cd-8168-41f1-afdc-348f99ed0611@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J4CaKgnS c=1 sm=1 tr=0 ts=69fb6c29 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ao3bqe3Qqjuf2QKdZGMA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2MCBTYWx0ZWRfX4OfdgqPKOG6u
 JDw9YKsEESPc6UuIcCKePWzzQ7il2OKKkK1T/4VZsCNINnK2J+bDbW0BcaA1KsFGm08DcNe+qV4
 6HqavgQ3C2ykHlfKbRSvRDWFkacq7P8h9qGxcgKJZPrCYFJOjMdp3txusXvqLPqZePXTBm5wyaf
 SHlcN2o4u8jDQkzy1G+ujMS0BnUewWhR/SwJRAldRALbHZkYXikthCcnFi0dnodhdbNn1l8QjhF
 YU81k0mwcRJnyrnszu9sQF/g4xuRR1ZL4Ok5OUiQZlXrV90e7sFxQDAsUiBpzMdr9fdPI0mm41Q
 q+4lOfJY7UZu8x3ZQ6JdE7T9yI3WkkL4G9CjoWlXC8F5GeyppnVgJpf5jFyf/SaZ472dmDIkSpt
 F9NniqGwg1QXGio5PYhUVRxlCZRv/sb2ixXFJ03fRFAuvFIaNttuaJ5pDndQSTDIEegZ1gDfcHU
 pOg4B4KoWnFOvZgxTvw==
X-Proofpoint-GUID: 362SH_xTqlJ-Of9PK5nufqlzO0bgD3JN
X-Proofpoint-ORIG-GUID: 362SH_xTqlJ-Of9PK5nufqlzO0bgD3JN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060160


On 5/6/2026 6:39 PM, Krzysztof Kozlowski wrote:
> On 06/05/2026 11:32, Vishnu Reddy wrote:
>> On 5/6/2026 12:11 PM, Krzysztof Kozlowski wrote:
>>> On Tue, May 05, 2026 at 12:29:23PM +0530, Vishnu Reddy wrote:
>>>> The common schema defines minItems and maxItems for clocks, power-domains,
>>>> and iommus. This suggests that the number of these resources can vary,
>>>> while in reality they are fixed constraints per platform.
>>> OK, that's interesting approach. I am fine with it, but then you need to
>>> remove these from "required:" list as well, because requiring properties
>>> which are not defined here is not the most readable.
>> Ack, I will remove them from "required:" in the next revision.
>>
>>> I still do not understand though why you cannot just grow the properties
>>> here. The point of this schema is to define common set for range of
>>> devices, because all of these devices are supposed to be veri similar.
>> If a new platform schema uses this common schema but does not explicitly
>> re-declare clocks or power-domains, it will inherit minItems and maxItems
> But new platform MUST define them, because each platform has both clocks
> and power domains.
>
>> range from the common schema. This gives the false impression that the
>> resource count is flexible for that platform, when in reality it should
>> be a fixed constraints.
>>
>> If a new platform requires more resources than the current maxItems (e.g.,
>> Glymur due to its dual vcodec core design), we need to keep bumping maxItems
>> in the common schema every time a new platform exceeds the previous limit.
>> That makes the common schema a moving target driven by platform specific.
> That's pretty expected, I don't see a problem in that.

I am fine with increasing maxItems in the common schema. I can set it to a
reasonable value (for example, up to 20) so that it accommodates future
platforms without frequent changes. Anyway, each platform schema must define
fixed constraints, since clocks and power-domains are mandatory per platform.

At the same time, I am also fine with the alternative approach of removing
these properties from the common schema entirely, since the fixed constraints
are already defined in each platform schema.

I'm fine with both approaches.
Could you please let me know which one you would prefer going forward?

Thanks,
Vishnu Reddy

> Best regards,
> Krzysztof
