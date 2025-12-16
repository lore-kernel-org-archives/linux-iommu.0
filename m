Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79659357A35
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886589; cv=none; b=i2fhwY85w2Vp2KJR8yhUDedy0E5bpHd5TkAj8oiChVY8BpItB9esGupsLPXM2TNoVuLtAMny3hLoWygZzmkDt6ECIxbhO8HFh6HdYIs5FDYqVzscpmFzuywLHVc/YdHhY6epQrwEmq6OQxIS9JX+SeVFdXeCZzMEFavw8bTZKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886589; c=relaxed/simple;
	bh=1fqkqkNEzTSWAwW3B+qpzd2aY6yMg5j1xLcgYYtCn9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lS8fuy/dix2KBs+lrRTIO8cBkRo3PIk+6QffXr/36swO8laZbBYvdPgwjjqZrWtwu9xF2KuDns/pggXD3lbcqmpFJaYxpY0fNLv3MAys8xED1464YskDdj15gdSZyMFkI4ljK+bsQZMYENTZ4IwvmHD4uE2qV7cG3kpd4i0ckow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WTuuKQx8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EPBzXNtO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTuuKQx8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EPBzXNtO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG8SHoO3745764
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 12:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S1bUZC3wQ09/vUi2Wz/LwL1M7PS4s9jI4u+ipA1NkPU=; b=WTuuKQx8zjT7yA9n
	RcbkvqABZwczl032YJYNNIyEMQQ0tM+vIYIzu5g3Dn6Vu8y9nSVDA/pHjGy0I+DO
	kf15TiqGU4+zNGPYK06xCKaXZJ7qclWs1jao4YkvXbKIZ+pyozusvyzYCINi6/br
	lzPLi01djXZzGrCWTp/xAGD0biZWoAwBN3OsG6oF/2MURjRalhKBPSMz+q37jOOJ
	ZGEoNU9XbiyPLo0IR26nMlkTduTn/0lQvy11X/NvYy+zjberHj69u4tyOk1aPwTS
	9jI8WWAUDGCRH2jNuU0sknu4VMLaz4s2VrnNfRIrO6wuKogI4/A5TufHPHXhPrLf
	BdTovQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33xj0tvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 12:03:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b9fb4c55f0so81375785a.3
        for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765886580; x=1766491380; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1bUZC3wQ09/vUi2Wz/LwL1M7PS4s9jI4u+ipA1NkPU=;
        b=EPBzXNtOqm7/XQyV8O6do5k1dgBi9nQqiiOQK1SYLZl72i1CWWheYUcyoHx3P7Oq2m
         krvOILpgw6dn4baFoyyLGMIQGhs8AXq/Nq2zaObXcpZMEE+vY7ByBV/SQzgrFm9DZFbQ
         xomzltPbxmj0aeHoXpesfSxIaX2IonV0ZRFOKCiAZP2rnun0oB9ks1VMmEUlaifTQaGb
         Es7ym6PrliDpxEGJecIlO4FYcIkzvjM1SKX5KVA2LMh3vPNZ6/H/IhKv1gGio3cAAXy0
         SREbwucQUmMOx4PL4SzfFzjLgwhhKWV+XDEPeYE/lw1C144QCf70J6Aw43ZhEKVl/5rM
         mR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765886580; x=1766491380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1bUZC3wQ09/vUi2Wz/LwL1M7PS4s9jI4u+ipA1NkPU=;
        b=X/8OhhCynDehFQp8ok96mVnXhizJoqRvLk7uXnE8DyLQYYUfV39Wh0fifHo+0TqAL1
         n5OAwe+s02D4Gv1Bim+tFJvLoMUPzy7/kj5uAQLslPBhpAMe9jvYJ0euI+YzDhVnVnOn
         Z2Hk8CzjJDJnUA8sFObDGCv3czH7ftcM9A4L/EqahcY8qxtkgCxwE8uB92d/Q/rEMd5h
         w6KHZ0+hhFKScOBu2Ufa+6aXVcAXremRRsXGsIkPmyhfL8TCjeUxmV5jZzOU4y6mYoTC
         VRFu76ca0AshRoKtdHTGngxzO6j9iMqt5HR/sL0l68RfS2iLySYe8jzjPblPG6GGXOCD
         8x5g==
X-Forwarded-Encrypted: i=1; AJvYcCXCIVACuPmRl/jNQ/dBLZgXsFtLkiGmHaPvqRz3VeikeHxQB0N64hwZvIBwn6hLNn2LwMUCmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSwzr+f9oUWNF4KS+m8/jHZ7XsaeQg6cdPRJFVLmNTZZNC1fFY
	RWENrcGU24pp4RPzMxLrvnWG/LHH8Gull5JR90Nt7ECkhy4rFaCMW2RvBQ5rC8P0urHsiDCNIYn
	9uN87yDlHTY+zxiVkHz28BEdW4mUycvoX6DfAFyU/yWwvkgKd9TydMjUsFg==
X-Gm-Gg: AY/fxX6Cp3ReNoB2geZEZX8/e630Rt+gKVrHr5yLteE9PIku5l581CGVBmvsg8WtJ0B
	U+SGu1zXtGi/RpBVjJsEp5HmgWTiKuXKXhLrQTppdwVdd4c6SqEHcKUTAoXHAHOeMOyluQ6PmQf
	6fx9nULWowoEVhCXi/rp4OLvyL3aRm+Y3hthvumwrFvY7rzHRGS3ugrlXr5khAiMzEYoc2O9U0z
	npbo2s+XPp4E3r4PRIXmboTFCgmDkgymGUQjLofNxSGC+WEcDayqOgTJ99yjncZdsI4NNF34Mgf
	HjF1tb8RXA7p2SWWsiiNPe1SCCspt/uYb64mnlVb2XFhVDmViEhT/kme7D0iFKkmVe/BK3ZvRPy
	Fj9k9RXEGr1ko6ikQtwxac5VhrSA9GXO9SuAGYBfxZmhRgH1rBiIMfwKydIwUYVJauA==
X-Received: by 2002:a05:620a:468f:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8bb3a0b7e5amr1437507985a.3.1765886579687;
        Tue, 16 Dec 2025 04:02:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+LwGQhgX+HV6xSu98Kp8PBKIcLhjvja7byx1nEf8nekydl7DDS37zTtoZtPzNHvCnZUEeTw==
X-Received: by 2002:a05:620a:468f:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8bb3a0b7e5amr1437499185a.3.1765886578963;
        Tue, 16 Dec 2025 04:02:58 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-649820f77e3sm16041066a12.18.2025.12.16.04.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 04:02:57 -0800 (PST)
Message-ID: <695ca5d2-b713-4838-8427-a9d31751c0cf@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 13:02:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: Remove unused includes
To: Jonathan Cameron <jic23@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michal Simek <michal.simek@amd.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Peter Rosin <peda@axentia.se>, Linus Walleij <linusw@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel
 <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
        linux-sound@vger.kernel.org
References: <20251212231203.727227-1-robh@kernel.org>
 <20251213165949.4b51f7cb@jic23-huawei>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251213165949.4b51f7cb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3ElG5sH-913bPro-PvsFOT7Ew1MG0LYw
X-Proofpoint-GUID: 3ElG5sH-913bPro-PvsFOT7Ew1MG0LYw
X-Authority-Analysis: v=2.4 cv=KtNAGGWN c=1 sm=1 tr=0 ts=69414a7b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=i0EeH86SAAAA:8
 a=UbNXja__m5_aMge2JzcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwMiBTYWx0ZWRfXy8nBhOnQE5xD
 3rEomt6Xx2nXOxhBhNx91MZErIICyGhMwcgcocFo7RyKQN2MozSjbNKl57IEqfYVYgcVcCNMMyI
 zdph60eeubTNt83OA8mTydN3T0oEeUKSeEIpv3oHpRKY+l4fiJB8s9TuAX1hD3vqZXpNGt7MuXW
 V3J4F+Bo41DrJiKorjVwJNshGXHHLVsPlx1oqY/heA52qfmBZy5S3GEnQNX8dYRkTfT5/lxjIVg
 NEWrvcYBMfHnRsb0Ngbuyc/L96LtahLcJ4QgpWBsyWjP6ibnDE6D+RXc0fOnHJKOmQ+Fb6O38AB
 W//EW+n5ED+v3yqeqhork5cG/yOeajqw441So9aNRa7GyhYiW5+QuWApVGCSDrufid16YWOCoc4
 dy8U/ZgLgmFaQRcT7fGVzr6p4dpAag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160102

On 12/13/25 5:59 PM, Jonathan Cameron wrote:
> On Fri, 12 Dec 2025 17:11:52 -0600
> "Rob Herring (Arm)" <robh@kernel.org> wrote:
> 
>> Remove includes which are not referenced by either DTS files or drivers.
>>
>> There's a few more which are new, so they are excluded for now.
>>
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com> #for-iio
> 
> Ideally we'll get a QC ack on those as well.
> 
> Jonathan
>>  .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  |  30 --
>>  .../dt-bindings/iio/qcom,spmi-adc7-smb139x.h  |  19 --

Those are being moved to dts/qcom:

https://lore.kernel.org/linux-arm-msm/20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com/

and will hopefully be in use later in this cycle.

Krzysztof and the submitter agreed on that outcome since they represent
hw constants and aren't "real" bindings (connecting sw to sw)

Konrad 
