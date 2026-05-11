Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702F3D301E
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515938; cv=none; b=ErTDIhvYwmCOtV5QCgf8MPVY6atYU6D4Jn4XCySzgoIYYUMOCe6fD7RBB6F9ZwzeXKHU9Dwqj0u00/PdBN1MSaMxJODHHdimAhB8Zry2N/axj8qUkQSnvUKvDFiE1DiubIm6Iw1BT9M/r/s5Nnf8QdsrUlrIPW9mqJQMC6s7GxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515938; c=relaxed/simple;
	bh=XSyKF+TTyJA2FxSDi/562C2tGL28+vNYmdnWMwoVRj4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E9ZdPzjaFndKB5Fr6kJ707HLJR4hKKBZ6kXgDey8RO6IlIq4HnwncaW7BgOdsyvAlrnk1Gp60dpslQJgGW01Jq8CwQJSAf0KyOcQXrD8NydsQDNF4dmJSjI2ttePanfD5mVxxZLX/BB3mSsRFtRGn/QlCjlx19VlozIfTgCnqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5PhapsU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pk6c7RYS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5PhapsU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pk6c7RYS"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BFCgeV018395
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 16:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bQ1uOY0G1kkuHO8Jn/3OlwXnnf2PYvGcudQO7cwuFjg=; b=B5PhapsUP6cpzv0i
	2NKupFdzbgp864AOGJj4SyinIzdCXX0lORktUqw7L1Ncqhi0k0Q0ZKIVqUq5arWK
	zXUx21ys2j67y/FBh+KmMcUQh6jYqfpemPFqcG5BzFCdwfrXCoRl7Kpw+ksDUJUE
	xPY4a9oRKHiHfxGyiNaBLFvaLU39bt8xeqYboniYgzajlcg1vuaeEYSF8SRWyWBX
	MTMoor94Xdk6IFJ7ToB5P7naHFwFvGeC8sawGC3qvV6s3nZfYibEWRoJVu2RkIKP
	kcNY8smWmVXuNi7oeifH5GNYpsqZOPvD2LukBxHmGh6dNPSOGfMMFixWoZnHculz
	smbtTQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xftq8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 16:12:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba838c5ff1so92467355ad.3
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778515932; x=1779120732; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bQ1uOY0G1kkuHO8Jn/3OlwXnnf2PYvGcudQO7cwuFjg=;
        b=Pk6c7RYSeFsCjf3kDqKEAecc8hHIb22KxMTJgCgbi6hg2wDP1aHaTw0O4q3uQIBK//
         KUUA0HGvvAwzo6MARNo40j9aKQmafai2r+4jkdNDg2s6x2HuxJDp5S+GTmnhSXjDGR7y
         lQbxj0KBgIqKxEm9Dtn0VeJ/LprkWMHDBR+Z4oWiPA+zViO2zNhGK0Dovabv+xxP1zfT
         VVFDHbZj50Nb67MPsq/FOZH1PQ+0t4IvR5VhtS4HMyud23Az8En8Np8CIe0OUkjFEQmc
         zyy6yiF/gO3qTTOoMPpgszdgOz06vWPjgQ3i6bCgKpQ5R1rOVmVC2Lw9QGO6WomQOrIA
         JwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515932; x=1779120732;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ1uOY0G1kkuHO8Jn/3OlwXnnf2PYvGcudQO7cwuFjg=;
        b=aJ8riCdvx5wDmk+iR8cV5Giohie14FaVr073q4YNdTNSMV6AZOFBjkkZEdVSbUbZB7
         gyBWLjE/Yw8fkx2am7ip9XiHql6vrziYI8ZHkNnhCKlStKO4GdRdpZksW7p4YX10XqR3
         x0gmoExYVvVMGWL4qqRwZP5jO2IW0EL29DAHzcg2XOYP1J8SSfGw2VuZz3UZrJqTHjNM
         c2XNV7mrXI5fxvjPjQDP2MW1BiHJtejIqGXR9kubweCeg/wb7dzR1edfRfTryILb0cz5
         CSbxJHwqwHv7+GptvygKM8Y6km2ZhE8vCohPl0i6avuipKMH9ed8Y4izFxfA2OVP0oao
         02Xw==
X-Forwarded-Encrypted: i=1; AFNElJ+StYfb5KjDYRdCh3WKoFZtjbUJrzbxeQwwGMt5RGfVj1W5FQrg1nol235TYSJNWM7mhtqc2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxE4WsoQ0h9AQMCCiYaF5BwHQpSc1dWenukayiMX6TxjYr2lek4
	1kylg9lUr/UwLBzELu5zts5bIvuQI+2UrMzdHIXMEwxQMSfOPZHTS75xHaZILROnSrpAxX5gmMn
	YoeQjiITvpDfWCCTnM9MpUqdHaychBn5j4rdK8G4n4MIohzEVa3qEdBu3vA==
X-Gm-Gg: Acq92OFNUmoE+gBfHV5cIXSd5JaGEcG3kiMhFQ3+WQGWhqSM6cGVyq8Dgc6TOErOUKy
	uLYrJ3Aqooq//vHMq0w3wVDNeHLswt9m/HB/l0GFmwciBCPMUUkVquNv0VrzG6hz6SFcU51Odid
	EHcdePhbMYIZrNW7uDGyqE5NSzPVnbmlzUpYDg0t6XzupsvsxgNriVpN9+ERZXu/qxWHDdooPch
	TVAGkZFw6m1T9vUKGP6I0437xvTInCd4N1oVRPqzFtmNFEJwCDQpRKB/CrmnGfB7/Yk8ifQ6Vg6
	r+d0G5VSMiN7pBxNCeQzG5Om3l7YctuvDskS9pw//Nnmr3F8KwOlDn5fxH8jiejy8UtmYhaimlk
	a1QYj/j0Zo3Ucmcig2K6RTsvukOFvYAOPFTvTvxq0f2uS3as6iU/jjtBGoxF1i/+d
X-Received: by 2002:a17:903:947:b0:2b4:5f19:1d34 with SMTP id d9443c01a7336-2ba798b629amr267633055ad.17.1778515932470;
        Mon, 11 May 2026 09:12:12 -0700 (PDT)
X-Received: by 2002:a17:903:947:b0:2b4:5f19:1d34 with SMTP id d9443c01a7336-2ba798b629amr267632495ad.17.1778515931864;
        Mon, 11 May 2026 09:12:11 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d3ffa0sm109901985ad.25.2026.05.11.09.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:12:11 -0700 (PDT)
Message-ID: <67157e35-8c39-b06b-eb93-602930168f4b@oss.qualcomm.com>
Date: Mon, 11 May 2026 21:42:01 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 10/14] media: iris: Add power sequence for Glymur
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-10-7fbb340c5dbd@oss.qualcomm.com>
 <jqe3ilzqzajuf67hvp7nw6mak36qyqu6dz2oiwtkf6zwiyclln@ydtyd7vkudm4>
Content-Language: en-US
In-Reply-To: <jqe3ilzqzajuf67hvp7nw6mak36qyqu6dz2oiwtkf6zwiyclln@ydtyd7vkudm4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a01ffdd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cQ-hqyt-I-3aP16jzQMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Sd9q080ng2MGgqkvM-Cv59yuaoZU1geM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3NCBTYWx0ZWRfX4hWAZ8nbI1wn
 3qdNv24bKK6+Jcx7dsKvLuDKZq6m1W+q15+fYbFjg/YgotG2NUZ2LgO8nBDbUpCW/DaG46NCt0m
 j53gjoUVwBAlGjGwjCm13ezz117dq9l/tPkBy81Ksl7uH6XqGgmMGdoBgtFehXptoW406trihVr
 nLFvTpSIJAS03JONf8oK5NWhrjI/F2y4JlwBIbM4tbhPl17Q+9v2n9aPjqQRkVoW0p3Uy6tNxgk
 0dW+Y1oxxdKmFDS8SVmHfPqOL+GJ6/9mxC/p9eKgbfSMymR45aSDo59lBTzw9Y4xH58vvnaTOFi
 PvPZPifKKYIOF/mWITUrpOgxuVPlnORASWjQKyPPl0lxHvRo4eTKyOpt5RGKSFPzO2Ne/cSmcI2
 zinHkTyN8UTsj0/ShYu4hWBo9fb9sVHBfMlgAP12NjMbEz19s2fsD+1HLnTlIP3VhnW6x31HLLf
 3CQKUdVIo86Aeg8IOrA==
X-Proofpoint-ORIG-GUID: Sd9q080ng2MGgqkvM-Cv59yuaoZU1geM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110174


On 5/9/2026 2:24 AM, Dmitry Baryshkov wrote:
> On Sat, May 09, 2026 at 12:29:59AM +0530, Vishnu Reddy wrote:
>> Glymur has a secondary video codec core (vcodec1), equivalent to the
>> primary core (vcodec0), but with independent power domains, clocks,
>> and reset lines. Reuse the existing code wherever possible and add
>> power sequence for vcodec1.
>>
>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  .../platform/qcom/iris/iris_platform_common.h      |   4 +
>>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 141 ++++++++++++++++++++-
>>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>>  .../platform/qcom/iris/iris_vpu_register_defines.h |  10 ++
>>  4 files changed, 154 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> index 7d59e6364e9d..8995136ad29e 100644
>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> @@ -61,6 +61,9 @@ enum platform_clk_type {
>>  	IRIS_VPP0_HW_CLK,
>>  	IRIS_VPP1_HW_CLK,
>>  	IRIS_APV_HW_CLK,
>> +	IRIS_AXI_VCODEC1_CLK,
>> +	IRIS_VCODEC1_CLK,
>> +	IRIS_VCODEC1_FREERUN_CLK,
> I think I have asked the same question while reviewing some other code.
> When seeing such enums my expectation would be that the set of clocks is
> more or less generic, while the platform specifics should be
> encapsulated in platform-specific code. Instead these lists keep on
> growing to accomodate platform details.
>
> Can we stop that tradition? Adding a peculiarity of the platform should
> not require touching of the generic code.
>
>>  };
>>  
>>  struct platform_clk_data {
>> @@ -210,6 +213,7 @@ enum platform_pm_domain_type {
>>  	IRIS_VPP0_HW_POWER_DOMAIN,
>>  	IRIS_VPP1_HW_POWER_DOMAIN,
>>  	IRIS_APV_HW_POWER_DOMAIN,
>> +	IRIS_VCODEC1_POWER_DOMAIN,
>>  };
>>  
>>  struct platform_pd_data {
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> index 13fbb21c2182..ff90c375e805 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> @@ -22,9 +22,19 @@ static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
>>  	u32 value, pwr_status;
>>  
>>  	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
>> -	pwr_status = value & BIT(1);
>> +	pwr_status = value & VCODEC0_POWER_STATUS;
>>  
>> -	return pwr_status ? false : true;
>> +	return !pwr_status;
>> +}
>> +
>> +static bool iris_vpu36_hw1_power_collapsed(struct iris_core *core)
>> +{
>> +	u32 value, pwr_status;
>> +
>> +	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
>> +	pwr_status = value & VCODEC1_POWER_STATUS;
>> +
>> +	return !pwr_status;
> Add core as an argument to the function instead of c&p'ing it.

Ack, will pass the vcodecx_power_status bit to this function.

>>  }
>>  
>>  static void iris_vpu3_power_off_hardware(struct iris_core *core)
>> @@ -254,6 +264,124 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
>>  	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
>>  }
>>  
>> +static int iris_vpu36_power_on_hw1(struct iris_core *core)
> Hmmm... And if 3.7 gets 4 cores, will we have 4 copies of the function?

As of now, none of the near upcoming targets introduce a significantly higher
number of cores. If that changes in the future, we can revisit and optimize it
then.

>> +{
>> +	int ret;
>> +
>> +	ret = iris_enable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = iris_prepare_enable_clock(core, IRIS_AXI_VCODEC1_CLK);
>> +	if (ret)
>> +		goto err_disable_hw1_power;
>> +
>> +	ret = iris_prepare_enable_clock(core, IRIS_VCODEC1_FREERUN_CLK);
>> +	if (ret)
>> +		goto err_disable_axi1_clk;
>> +
>> +	ret = iris_prepare_enable_clock(core, IRIS_VCODEC1_CLK);
>> +	if (ret)
>> +		goto err_disable_hw1_free_clk;
>> +
>> +	return 0;
>> +
>> +err_disable_hw1_free_clk:
>> +	iris_disable_unprepare_clock(core, IRIS_VCODEC1_FREERUN_CLK);
>> +err_disable_axi1_clk:
>> +	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC1_CLK);
>> +err_disable_hw1_power:
>> +	iris_disable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
>> +
>> +	return ret;
>> +}
>> +
>> +static int iris_vpu36_power_on_hw(struct iris_core *core)
>> +{
>> +	int ret;
>> +
>> +	ret = iris_vpu35_power_on_hw(core);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = iris_vpu36_power_on_hw1(core);
>> +	if (ret)
>> +		goto err_power_off_hw;
>> +
>> +	return 0;
>> +
>> +err_power_off_hw:
>> +	iris_vpu35_power_off_hw(core);
>> +
>> +	return ret;
>> +}
>> +
>> +static void iris_vpu36_power_off_hw1(struct iris_core *core)
>> +{
>> +	u32 value, i;
>> +	int ret;
>> +
>> +	if (iris_vpu36_hw1_power_collapsed(core))
>> +		goto disable_power;
>> +
>> +	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
>> +	if (value)
>> +		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
>> +
>> +	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
>> +		ret = readl_poll_timeout(core->reg_base + VCODEC1_SS_IDLE_STATUSN + 4 * i,
>> +					 value, value & DMA_NOC_IDLE, 2000, 20000);
>> +		if (ret)
>> +			goto disable_power;
>> +	}
>> +
>> +	writel(REQ_VCODEC1_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>> +	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
>> +				 value, value & NOC_LPI_VCODEC1_STATUS_DONE, 2000, 20000);
>> +	if (ret)
>> +		goto disable_power;
>> +
>> +	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>> +
>> +	writel(VCODEC1_BRIDGE_SW_RESET | VCODEC1_BRIDGE_HW_RESET_DISABLE, core->reg_base +
>> +	       CPU_CS_AHB_BRIDGE_SYNC_RESET);
>> +	writel(VCODEC1_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>> +	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>> +
>> +disable_power:
>> +	iris_genpd_set_hwmode(core, IRIS_VCODEC1_POWER_DOMAIN, false);
>> +	iris_disable_unprepare_clock(core, IRIS_VCODEC1_CLK);
>> +	iris_disable_unprepare_clock(core, IRIS_VCODEC1_FREERUN_CLK);
>> +	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC1_CLK);
>> +	iris_disable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
>> +}
>> +
>> +static void iris_vpu36_power_off_hw(struct iris_core *core)
>> +{
>> +	iris_vpu35_power_off_hw(core);
>> +	iris_vpu36_power_off_hw1(core);
>> +}
>> +
>> +static int iris_vpu36_set_hwmode(struct iris_core *core)
>> +{
>> +	int ret;
>> +
>> +	ret = iris_genpd_set_hwmode(core, IRIS_VCODEC_POWER_DOMAIN, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = iris_genpd_set_hwmode(core, IRIS_VCODEC1_POWER_DOMAIN, true);
>> +	if (ret)
>> +		goto error_disable_vcodec_hwmode;
>> +
>> +	return 0;
>> +
>> +error_disable_vcodec_hwmode:
>> +	iris_genpd_set_hwmode(core, IRIS_VCODEC_POWER_DOMAIN, false);
>> +
>> +	return ret;
>> +}
>> +
>>  const struct vpu_ops iris_vpu3_ops = {
>>  	.power_off_hw = iris_vpu3_power_off_hardware,
>>  	.power_on_hw = iris_vpu_power_on_hw,
>> @@ -281,3 +409,12 @@ const struct vpu_ops iris_vpu35_ops = {
>>  	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
>>  	.set_hwmode = iris_vpu_set_hwmode,
>>  };
>> +
>> +const struct vpu_ops iris_vpu36_ops = {
>> +	.power_off_hw = iris_vpu36_power_off_hw,
>> +	.power_on_hw = iris_vpu36_power_on_hw,
>> +	.power_off_controller = iris_vpu35_vpu4x_power_off_controller,
>> +	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
>> +	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
>> +	.set_hwmode = iris_vpu36_set_hwmode,
>> +};
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
>> index dee3b1349c5e..bee8ae9b4308 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
>> @@ -12,6 +12,7 @@ extern const struct vpu_ops iris_vpu2_ops;
>>  extern const struct vpu_ops iris_vpu3_ops;
>>  extern const struct vpu_ops iris_vpu33_ops;
>>  extern const struct vpu_ops iris_vpu35_ops;
>> +extern const struct vpu_ops iris_vpu36_ops;
>>  extern const struct vpu_ops iris_vpu4x_ops;
>>  
>>  struct vpu_ops {
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
>> index 72168b9ffa73..e67d98b8c91e 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
>> @@ -7,6 +7,7 @@
>>  #define __IRIS_VPU_REGISTER_DEFINES_H__
>>  
>>  #define VCODEC_BASE_OFFS			0x00000000
>> +#define VCODEC1_BASE_OFFS			0x00040000
>>  #define AON_MVP_NOC_RESET			0x0001F000
>>  #define CPU_BASE_OFFS				0x000A0000
>>  #define WRAPPER_BASE_OFFS			0x000B0000
>> @@ -14,6 +15,8 @@
>>  #define AON_BASE_OFFS				0x000E0000
>>  
>>  #define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
>> +#define VCODEC1_SS_IDLE_STATUSN			(VCODEC1_BASE_OFFS + 0x70)
>> +#define DMA_NOC_IDLE				BIT(22)
>>  
>>  #define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
>>  #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
>> @@ -35,6 +38,8 @@
>>  #define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
>>  #define CORE_BRIDGE_SW_RESET			BIT(0)
>>  #define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
>> +#define VCODEC1_BRIDGE_SW_RESET			BIT(2)
>> +#define VCODEC1_BRIDGE_HW_RESET_DISABLE		BIT(3)
>>  
>>  #define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
>>  #define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
>> @@ -52,14 +57,19 @@
>>  #define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
>>  #define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
>>  #define REQ_POWER_DOWN_PREP			BIT(0)
>> +#define REQ_VCODEC1_POWER_DOWN_PREP		BIT(1)
>>  
>>  #define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
>>  #define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
>>  #define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
>>  #define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
>> +#define NOC_LPI_VCODEC1_STATUS_DONE		BIT(8)
>>  
>>  #define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
>>  #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
>> +#define VCODEC0_POWER_STATUS			BIT(1)
>> +#define VCODEC1_POWER_STATUS			BIT(4)
>> +
>>  #define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
>>  #define CORE_CLK_RUN				0x0
>>  
>>
>> -- 
>> 2.34.1
>>
