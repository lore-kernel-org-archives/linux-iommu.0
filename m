Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83305204C16
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352317; cv=none; b=EER7qjcxiQq/Kg1bkb6St6XZXR6gLdslLMHlHLlSwk5OtXTYieAp977EgNqQIxA1lAo0sGYwalJwwfGcDxwkqPF873ESLVr4SFxFwOYjOHXizgQYDK7XaekwDZLkM/AfcfQ2enHkiKx60LQZoz7oW+T6pXnuPdw/IuOM8R0+BTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352317; c=relaxed/simple;
	bh=NOGmwuUhx41uLN0wHBW0LLXHIBm/+VxTjHL0qIfPIxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xvo/uolupbkxCDaS++aT+SLUNu31H6s4MODH4JDkY52o8VkoSuiTfBTw4E3p8Jb3VKjZ4y7A5H/emT6DeJhEbWCxHeoclvtixPZZqrfPXNofb1D+4HBS/skfMmC1zN6/Q56xTYcJcfIsAIbsw0hTOiP9nj9eCQG5EFsBQvadJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lAOz7yPO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lAOz7yPO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG5WgfZ030357
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 12:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WeqvPqxs/zm+neW3dpwcGc7WggbqVo4nB/s2S/wzmDg=; b=lAOz7yPOamfLxjv/
	ODjMV5+2Kb003nv5eIAiAcD0qLYO56rc/VB+tbw7aRnoUGG8/Dm1/0Et8FZuYcm5
	aoPo506w01Wt5nshlTRiNec3s4xm/Du435v9FH7MISnroT/yAwcubt80H3Bae6xU
	NMok72cGviDIFgvgNmfeKhNTAtvqi7XI7L3pbByJXhhR11/pGYo6PLArEZDeQ8hB
	FbjV5hP9LuDWrmriFIA0dV1E07txNVzzjLEbIpjljX6y6MomInUIZFeGBX8oCOzD
	WACcOX451b1oLqdycuhiSLNVMGwmg9jjSXeWErLlWrAN49md/bv0HIAw/Ew3Ti8j
	U2RfEA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43je5ch6yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 12:31:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8824c96cdso15300556d6.2
        for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 04:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734352313; x=1734957113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeqvPqxs/zm+neW3dpwcGc7WggbqVo4nB/s2S/wzmDg=;
        b=rWsrh+/KR1iA9hcgPec2JEXBTGO60VWj52kfAmRqbu9jOfLcyLrgu5R5r7vKDc7SB/
         b9tylT6mvuvmppHArUQ5Pj2oEYJ1zA6PiP5DDAko1syipE+2ohFMX36JlXjeNIbVsv8h
         W0xd5P7dxhjhTeApkX/oIjOqW5I8JvIpzTi7uWPNExT2OJ3JCsTihyYoD+0ey+ekIDnu
         12bf/51UvftSXHfzBqsRY5M03pf7taPI7AbcrTkVOACdQ3ywsazE9YEjg+a465K559fU
         XBwjUPRz89bPI04XS7MQZ8eFSK+Wc74Eu3wbLkBhGXS8WHSyJJN4QCOELYH2NzXkKpGP
         4RIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz59dIQed3vKZZvs7g7HahZl6Vx+eIpECNghrx3Z9gFesTa554FF2jA8WkBnaSMpUdvMXppQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3Yl61bU4tjLEfEqIspZc4mEpB8tZ2Af4EH6xP03PMz5CcHQuV
	UmdJxbBAkDog/pcGMKe2bG1U8fxJI7gihcJpXj5Y9kahU5E3C+ZpwKTf4Wx4a+8lQmDvNEbe83Z
	xmYc8L+A4j9mr4+dK+NYkDiUrZZDG2hOji6H+6hIOO3BwfsWhUiwtxA==
X-Gm-Gg: ASbGncsUon0ybiUzJ4widctst6mZRTSBH7KDD+UPgewx8ysipuhFph5nFDTwdCCYAcs
	4vgQL3dpQelsJQGkbwY0Wntv7kVb/j1/Q751nf6hPewRmS8OC8+e3ybmk8MTSw2bmt01sl8gr7l
	La+fdt2caHQSxwbK1r4CKDk9xblAcNVgiGT+rahKI35bUDOumn9TtQqGdBz+LIggitOWWooGTss
	M08ZhockHGofLQFNAf+r+TjvJdxcABmj9b9W2eLHeezIpEa0CGC1r0RR+YPsGuDe2ot+90osLLb
	4QfeS3ND5dIfWIoFoK4W/aOJdCJkLDI42xs=
X-Received: by 2002:a05:6214:c4f:b0:6d8:8db8:43a8 with SMTP id 6a1803df08f44-6dc9683b11fmr74596746d6.9.1734352313564;
        Mon, 16 Dec 2024 04:31:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdrHVfyoU2etuQqyfIbiSLQe3FMVsNgCETbPhLwAWfRSOxp7xzi9URabDJLwUjep6ho8lswQ==
X-Received: by 2002:a05:6214:c4f:b0:6d8:8db8:43a8 with SMTP id 6a1803df08f44-6dc9683b11fmr74596476d6.9.1734352313221;
        Mon, 16 Dec 2024 04:31:53 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab5198sm3112039a12.8.2024.12.16.04.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 04:31:52 -0800 (PST)
Message-ID: <ee5460db-2459-4ea5-ad35-e9520247cb98@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 13:31:50 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] arm64: dts: qcom: Add initial support for MSM8917
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
 <20241215-msm8917-v9-6-bacaa26f3eef@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241215-msm8917-v9-6-bacaa26f3eef@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GxQwRWhbq_sSChj-UuBelebsaua5CYAD
X-Proofpoint-ORIG-GUID: GxQwRWhbq_sSChj-UuBelebsaua5CYAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160104

On 15.12.2024 12:15 PM, Barnabás Czémán wrote:
> From: Otto Pflüger <otto.pflueger@abscue.de>
> 
> Add initial support for MSM8917 SoC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> [reword commit, rebase, fix schema errors]
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
