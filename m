Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D82054E6
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351609; cv=none; b=t1kZ8B46gkMOxIIL19dwZ3on/VCHj/DIV7GNbSmKl+nerkT++tzb/2hkcMDEr6eOtdEOSC4hpT6Pnl32Gs1ZvzeQATPsSlPp2TeGkJ/2KKndt/RYS6+R+2FqH4aMJ3CtR9pvm3kD89+IQspB/KX+qY38ZBNpFmXNwhQK9Kt+60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351609; c=relaxed/simple;
	bh=ybgRkqth+vwtYw+ouWiPcZbJPYXXDnMbtY440TFFZKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgcCusyklHdTDSkZp162LckUXoqZl+ls7sM3svHmelMgDUYqLpNqtDDhBi+N8aTlSfwR8/lom9CYzBKW8g8jSsGyjDowyfOa1FcJI3tZi0OXte+GZYfys1GyL26iYF6EbcxjhZZJMS9W2LYun78t+ib5znEdvWzs7uOMyPR3xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljwNsghQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljwNsghQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG70bJl009278
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 12:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VOsyJZCKFlaXhdMetjiPjn7ZCm+QcoQaD1OHyhj1lNg=; b=ljwNsghQHT1/dn9K
	UdHd2TXkOk8OLqslle2mW6hDI6SuRkEjJiBVqGUBMPtFRs0M1YKjFaFbcifMCvlZ
	r0Y3Sn6O6B+GsEAxW7Iiqttk8NcEeP4oRGzXIetRwkWubTVevNug668xejMbd9L7
	0Cw9dgc8+NJv1suU3L8JZ4mVQxJowFU18cIhRcQoU7bYBcCYwy5pCzXZYXc/5jzE
	jpE7mHHYXByDFgunE8CNzn5W7vIvG+hAPakuOa1z+bVAvh5sJqd42fsnHBirgHQK
	89p72pO4ag+U9fBJD6vfaY3PvaKivKz4sJY+28xaIQdlOV0K1by0Q6oLcYc7iaDT
	gLdmKw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jfemguem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 12:20:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-467a97dec51so4057441cf.0
        for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 04:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351606; x=1734956406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOsyJZCKFlaXhdMetjiPjn7ZCm+QcoQaD1OHyhj1lNg=;
        b=m0OnqLvzJ3cBIXpQX9lzfA+UMrgzkOzIZt/xS0N2pllb3ocfaNKktHxj1eV4SJp8Zw
         7fySkX01S9Ovre+uUvkVc28zq0XS6WttIpi0sdmUBO1fqejfGYpZNSKupAZVn/5b87Dm
         iivmFHgGrqG/x6TC3HkItv+25UEs+TeMcrHyyQYQgbKVEfqa1O3Q1XuEYdaw4/X87BKb
         ZGcRzSiXmRCRdBfnyaVc1dDlLGMQhGb7YSEGfFUjW0GPyfSqsC/Judt651fAK14CRVy9
         3eaHOzX7eTadUUk/dAuyxB9/SOcMMGMlwKVYJ9iP6Gp2rDhFLnnGP37yZ/HRW0TBjqa3
         k//Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/M68z4UF3BSYKIU3LI3WGYu4pX2XlAJLv4soJihptdgbazqnhrAZijtfMuf93T1simAh3Yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlT6BqHKgP+V2KiXjEwto4COi3cJ+/FbWidF58Bv+DSVO0iFsW
	KmC9L9Js94EVQ28xUTc065vhuqRFDe7iZ8HG7YXO8BsYG7xhrESmpn+I4kKkfzOUYCF3ocf2pjJ
	DCw9U5rV+vIE6FCV2+T3qhxSFPXaH8Il7DsJlpGrtuYB/JgFTj80o3A==
X-Gm-Gg: ASbGncuxrYeZUuSeuCHeA7SNfdnb3ecKOHQmTxZLIMFx3nxBrO1e83oHUJCkBP3UdrI
	/YCGHGOKHMzKI3sQ5BTHz03TlNf/nhaSuRhVyMGYrNRVSJ/QKjCOepJ/dFyy/MvJGdbltwLbhEr
	Goy0nSBrZZvLORGPMVptqzhCSWsbk3eYz9sR90bnQ5jTwnNxZ28DlAZBBzQ5o1ruhLA1Rl9/30I
	MiZaYCmBtDzC7EonqTz3j4LtQQOtBz2VhUwy0iIKROjWTsVrGuBGgikzSMSIzlAM9xt5Am0yyQ2
	rYvNvW/FtTOuhk4HCa0eKDkaxpT+Qt2dOEs=
X-Received: by 2002:ac8:5d0f:0:b0:461:3cd2:390 with SMTP id d75a77b69052e-467a58137a1mr86824201cf.12.1734351601290;
        Mon, 16 Dec 2024 04:20:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9pG1Ysvkr5Hyq/nig+qT8t4gtr5EQRe9497XJuqjF5LANAYeaCtwgGtk6X8FjF5ldW00HDw==
X-Received: by 2002:ac8:5d0f:0:b0:461:3cd2:390 with SMTP id d75a77b69052e-467a58137a1mr86823711cf.12.1734351600845;
        Mon, 16 Dec 2024 04:20:00 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae11f8sm3285148a12.41.2024.12.16.04.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 04:20:00 -0800 (PST)
Message-ID: <3a67bc1f-dba9-4ab3-9c01-f889dd24359b@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 13:19:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/8] Add MSM8917/PM8937/Redmi 5A
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev,
        Dang Huynh <danct12@riseup.net>, Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
 <CACRpkdZ-ZEiGMUPObHU=kw=OUADrRGtxgMc-QC3EaBevp-Shng@mail.gmail.com>
 <vfwisdkjg3czwesi6yqaznvxcz2z5ksqezhsh6ytrc2g2ypszy@wqkr5cgr26vq>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <vfwisdkjg3czwesi6yqaznvxcz2z5ksqezhsh6ytrc2g2ypszy@wqkr5cgr26vq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WEdWn10PoT5oo6cLwSGV096GGMK2Ddpr
X-Proofpoint-ORIG-GUID: WEdWn10PoT5oo6cLwSGV096GGMK2Ddpr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=934 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160103

On 16.12.2024 12:28 PM, Dmitry Baryshkov wrote:
> On Mon, Dec 16, 2024 at 11:33:30AM +0100, Linus Walleij wrote:
>> On Sun, Dec 15, 2024 at 12:15 PM Barnabás Czémán
>> <barnabas.czeman@mainlining.org> wrote:
>>
>>> This patch series add support for MSM8917 soc with PM8937 and
>>> Xiaomi Redmi 5A (riva).
>>>
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> (...)
>>>       dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
>> (...)
>>>       pinctrl: qcom: Add MSM8917 tlmm pinctrl driver
>>
>> Is it possible for me to apply these two patches in isolation?
> 
> I think so. They have no external dependencies.

Green light!

Konrad
