Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF944C4EA
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322877; cv=none; b=QG9voVhqPbl6c3Pj9ETf6g5dejKc4t7WhsaEJRsL3aMLBasYRQVQkr+6KOjcBEyigKYYTPd9Zqg8jvSP3PqQ2kJDHzrEztJCHDDoNMGFrzhZM0yYT0QD0z1yru4cJmfjOsBbs7aTWd1BrLRZmobWmoiIhBzatsowl7pkBgHSYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322877; c=relaxed/simple;
	bh=0LkBYfAZsJhifD4zPW/pw4O1lnq0kFjI4F2kXScG2Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXoyB/RYYmi5dfcpIbyDP29MEKt0bJRxBzE+73tERWI67GaNVEnatLv5/Z+BlW8woPTVLxdptnZZ9ozc+uiWw8b5sMQEAVcgEx5YvhClqi5T3ZBJrky4+h27RkmIaoEAnGTdUbIiMnYeUFCSo8YSc8IDP3L4IN8d0o9oa++EaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NeYLVEjh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=baFlI9+Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NeYLVEjh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="baFlI9+Z"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7f3rr1309849
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 11:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0LkBYfAZsJhifD4zPW/pw4O1lnq0kFjI4F2kXScG2Ww=; b=NeYLVEjhcVvjgyC8
	Qw0yx1EgRkr5w7rXfko95cuXAe5ephuRwZkCDm5CZNbpDCgNbpLYU8ac1ayi/emu
	crLVhW3JkVFYOVH1xuRb8EL/3SkMeqtdRp5RZLrBrbKZdL6Lm0V/ocxWZY5sLiaE
	/HcZKarqMwB8i0tbvsh18Q4mXYYlD9JwMFnfosu5akSln6SeQ2TdHS87hOSbzSbN
	nZISupus4n3KpSnTCh6/Y1V728gPEamNNWfsR7rjJt88oW3UBGxGCkQ/B+c5X/yR
	is2p14iTAlVDjGRj0gC1mHqLeyAitRQNcyqj1HAKTZMseXDDDk5HtlqGZpEPuLYu
	7OE9jA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqa331mv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 11:01:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b13so1107691a12.1
        for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 04:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785322874; x=1785927674; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0LkBYfAZsJhifD4zPW/pw4O1lnq0kFjI4F2kXScG2Ww=;
        b=baFlI9+ZRnxD1qLe23kc7MJVqHcXGwCHFwhEL7Wjdc3554s1+8vvhkau7a4rKep4Q3
         4t2cs2iqdVf4DzNCoe3VGOP/orLSO4qEB1zhUSE6++xl7ZpkkDmp14Hs9ZveATvAwtSI
         fGfggImmGKTKX/Nrr8xtPGJIhgPF5E8wHCZE7hLE+Uw/sYqRBN+lDfoagvIL6Cmg1rMd
         Y73UH7wWb0iKvYvwV3ZnTuPUsVFCKGDLADlnW7scFYRGAXn/tCWZqePe1LswGtiBsfnM
         c+FeO67sWfl9Y6TckyU1dWsABUwerVY6KE8ZSGr91/BBzwPkUfgGNlXQVkhuqHos8ycN
         U0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785322874; x=1785927674;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0LkBYfAZsJhifD4zPW/pw4O1lnq0kFjI4F2kXScG2Ww=;
        b=h2XieObOSddbQ5ztdR5MKNbWruLOnz5Y2phx6vSeBQG8e+xMDzAPNoWZbhJ1Jjwn7X
         1lGgMw69iXqDeejsyGZkG91YzSHGXXR3mS0Hg4+bfp2th+E9pPnONcfhPT0syEWZqckO
         fJJS1hmb5xi1Nh24KW3uG4hCoGwyhqNdtDfDmSfTWPSQ+ApEE4ocdq8FKANugJxOBsvl
         4sSBmObUncV8AKEp6uM+zQ6h3hHenx8nh/AAwzUHb1uuQEWyl1dvUdgbzFViukmbTdqD
         EddK3FdHk0gSQOZMFjWMV6rwe5wok1Qbi2cozCYyYiJcZB4c+aoYW6RP2rsr7/iFiJsV
         hR8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqqgIViNq1Yf1kNfogvWiSpOm6PKPOcl0ENHbrDQHfzwmijOSE4OiKp/Hb2guTiR8SRl2s92A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCHWeIGB7LT8q3Ux2sPZyvWM98nRmyqCfbPAezBlaSjDvd0Mby
	ReNKERdX2eP3cZZqCZ5c9/DbWAhbxDVlFQESx8CH6RyXBA8hK4g0KRFLk27ZkHYny5oL6lyRoBJ
	wIyHpUz+U91bx/12qX+4h+6rvQBMWJII6FBAGlrcGsnog4yFON/A/L3s4fQ==
X-Gm-Gg: AR+sD10B4/EwjN80uqdnjoCzC7B1xPp1WPnGHZHUqX8amRC0P8b4FaXrNxbeQUopJla
	BBKqfY79IFPUZ+eojxP3FdUqKszhArAvvqZB8P9of/M7JYyqgkKY5ug+LTTrknIaj+POJDgzjQb
	nQyA4DMmB6u3mpLoeTpLBDTHWRjPtL9hRvuOnmeSHBtbBGmTNxW1Aw1Oa1A1H2zeQiaA5Q8fm9a
	HGijU5fL+uPVFX/JtOngQQmZ/1J+ZYXvDb9jVUauj8oQzqjfEp2lXKSym//jv4V40biR0dKJtey
	nSpd+ldz+UTJSnKB+sGAov36ZbMSf2Us4xsM8MtI1Wp8Cw7iP9qrXP0xL8kY+CGmTYES6eeVNCD
	H4n3VeoPZu1PqWuv+4153T7zHGpgdSWqV
X-Received: by 2002:a05:6a20:9143:b0:3c4:2fe1:fa28 with SMTP id adf61e73a8af0-3c8ba63c421mr7492076637.71.1785322874342;
        Wed, 29 Jul 2026 04:01:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:9143:b0:3c4:2fe1:fa28 with SMTP id adf61e73a8af0-3c8ba63c421mr7492019637.71.1785322873871;
        Wed, 29 Jul 2026 04:01:13 -0700 (PDT)
Received: from [10.206.101.140] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dca6a8sm8990545eec.29.2026.07.29.04.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:01:13 -0700 (PDT)
Message-ID: <cb344e15-28c1-16de-b871-a39c01d52345@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 16:31:04 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 01/14] dt-bindings: media: qcom,glymur-iris: Add
 glymur video codec
To: Bryan O'Donoghue <bod.linux@nxsw.ie>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
 <20260726-glymur-v10-1-de451559e88b@oss.qualcomm.com>
 <cTyvVlG4njDAALGERZCnJMS54r5ZomPQ6aLejsdTWw3ifNJ3yuz38KU4j9_PrlabOH4e0Oo4XsuftZkODeXPg1ecfCRdlKHTLkw_JWXWnRY=@nxsw.ie>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <cTyvVlG4njDAALGERZCnJMS54r5ZomPQ6aLejsdTWw3ifNJ3yuz38KU4j9_PrlabOH4e0Oo4XsuftZkODeXPg1ecfCRdlKHTLkw_JWXWnRY=@nxsw.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MCBTYWx0ZWRfX4/7DOE+LVggk
 LvdlSt55M/pnvJ8eScmSeUMik+BTlu3njjdWyBH0MxEd9bZJlRaElNgYJrMBQsBLktRNICpO/1p
 3INOV8OO57PO2CNqF37D9ogcKU/o5UXq6R6BeoW04LMGhXtGdRsMUQUgEZsqaymcNheIuqM+c43
 WxWx8mYIV/V3CL79RjcmukiktUOSYDXZnpnfH7Ifo+zSshntemmf+MWB4nYoqmB17UYD1sFMoCC
 oewPTklY3QZkk54UOfGJ1dVX+QAdom5gM1ZrO5cEEJcRDfntfKy4ODJ6efraVsyKe/wMc9i3uMS
 YKSxIJv28C309agHNm+BRDqZM8xMwGDuRK10vqb1n+3qu2K3LPQaGp0/dvCQJKpXxHtvPiojBrO
 06XrZV603RnkyEBUqjDyuWtMzvNvGwq/GdMmptQ5A9kHxnDC3BVnX8f/n6HkcJWeYQ0wPelRC7i
 naLHiVAwKAGTd6tg92A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MCBTYWx0ZWRfX06hZxYr6GwQi
 vTi6/e9eQMUBzI47t4U8jZaMYt83QGlkm/xihJ4zEYpAm2N48HL2en+GUhbc/qBllt6LmHvBfhh
 iHj9d17jHbx7O/UOU8Qkn16j1QxTyNs=
X-Proofpoint-ORIG-GUID: ZVeBpLFQeFB_DMH_OdYXUlMKS6-hz3PL
X-Authority-Analysis: v=2.4 cv=Ap/eGu9P c=1 sm=1 tr=0 ts=6a69dd7b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Mf6ET5Z485SzACLcFDwA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: ZVeBpLFQeFB_DMH_OdYXUlMKS6-hz3PL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290090


On 7/29/2026 3:38 PM, Bryan O'Donoghue wrote:
> On Sunday, 26 July 2026 at 06:50, Vishnu Reddy <busanna.reddy@oss.qualcomm.com> wrote:
>
>> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
>> is a new generation of video IP that introduces a dual-core architecture.
>> The second core brings its own power domain, clocks, and reset lines,
>> requiring additional power domains and clocks in the power sequence.
>> The current maxItems constraints for clocks and power-domains in the
>> common venus schema were sized for platforms available at the time of
>> authoring. The glymur platform introduces a dual core architecture
>> that requires more clocks and power domains, exceeding these limits.
>> Raise maxItems for clocks, clock-names, power-domains and
>> power-domain-names to accommodate the glymur platform.
>> The glymur platform-specific schema have fixed constraints for these
>> properties, so the common schema only acts as an upper bound.
>>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Krzysztof's RB has been dropped from v9 to v10 here.
>
> Is that purposeful - all of the other patches in this series have the relevant RB's retained.
>
> Using proton mail web thingy so my email may appear weird idk.
>
> Anyway please indicate what is going on with the yaml RB's here.

Krzysztof commented to drop it on v9 as the binding was updated significantly,
so it was removed in v10.

> ---
> bod
