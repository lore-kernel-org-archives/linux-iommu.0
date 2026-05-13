Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4214219A8A
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680156; cv=none; b=MUC/+pOuSRVcMBZ/w+pzl1i8Pv5xy82x3umCrx+dUtMZBkEgjeDCHeIgT/ByhdxorQ8VqHJHomtvpXkXr5VF4masNEyk31RwnSk7DQNk6+1AQimpP1ZGDkUb36+gOTktCLj1P1xRLegy/yYGOxDYKHx0G3PJkhzi5qdBVyve4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680156; c=relaxed/simple;
	bh=jRxVsvYK08hJFPCU3r27mn2olm89N9iKJ+Bwl9hLev0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiQzwJSkaIRU0NYgMeDUT1lTcwE9TPr/d28ygWQNmJFfy+PN5qtd2B2E1K72UHSM2j2ceCAWKbnn1TKFWQBaxvMyfQpZpBXpQNpiBm1gIPW0XYH3MAs9zG/qDiYlF94AJyPvgsyzskgZcucnd2j+OKncm4qrASAfEPjlnN5xcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yazv6n5e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M8mo6O3g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yazv6n5e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M8mo6O3g"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D8rM354082621
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4HsjvmVEDvo4Axfu4dOFUhmv
	OEIgZDUu9Iaidd4gHf8=; b=Yazv6n5eUZGwUjYncwcA8wT6ufqmJbEx9zFL8ghP
	xZ4cgTkxvbiMtkyY0n3m3+yixndIF1BNlFClOEsh/bwv9pjr1BpgyVSWfzvu3EEG
	0mvl1Ali57IffdSGV764p+ZB29wc8i4dG38AjPKhBYeYnKJEKe8Z90FnN9nd56qR
	z//S2QF0AgdCb/bS+cnbMrkrpXRpIVv3nzzOgqjI6qFEKQUfmGUpV76Hxmhilin+
	qZOwXXohHK0cXOx79V1GHVWKPdmsnk6SawU32+1c0YdflDKihKTLNAitLIRYtl9x
	2giJ7vrYPb/08YCeqbwsxXSMf/1UthJtcDKiiUk1ZPymhQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p6e127c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:49:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-514a182b90dso52363721cf.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778680153; x=1779284953; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HsjvmVEDvo4Axfu4dOFUhmvOEIgZDUu9Iaidd4gHf8=;
        b=M8mo6O3g5SGgoyoW/7yCkvYmItw/jnHXeQA5YjxY3C/4yVrs+821cE5Ij+cJ6Ti/N4
         dOIKjr2/ZeAhiEDAVZTgLxgc4slDd5THvcIgai64QtjxeUodhUQi50QozzCGA06KrhC5
         iZcu1kzyBAZo/u/LzaCmOjgZp0DhHNMtlDIFTAQCCoHjJxMWC1cuAkUVYcvGJWv9cpFA
         r1tvSIuOlc2DR/UCDcSTzizZ55WJFIh/JJAhRqZ4nHOsMupxMpsM4N6Jdr4pj7rbTqG6
         GKvRm91wkqDPNq5viyz1EgzpjrvgQNwb5Pks7I5PNeytP40g5lADqBNoqZARKoZm0Y/2
         y+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680153; x=1779284953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HsjvmVEDvo4Axfu4dOFUhmvOEIgZDUu9Iaidd4gHf8=;
        b=dPfI4oU7ReI3YNWlZ4AEIlHIkJaLfxecc0nM4pvSAITrM6Q/WrOfIIxLWafprUz3gk
         +4d15PSkIHvR4kFcDVC4FkJPr/8+dlHsVHXdVWjzVOWMsQNy7vu2R4VCn9xer2DimcdY
         5Qwg3Q+rmw+qSjz3yvAMPP0vzU6SHp2nQ2d70gE6b4OTrzJXPuhBzm5e7+TQweStROiD
         0PBwp+3LYpGkiDS6GwRo/iwKHCG/cWUj4BVhgKunaefYUrB65yv4WOiDKVUf10zPecOL
         NlbsYme/ppEPcVGcN8b89oPrr17XZie19Ukkyn69LbYx1S8rp7pTMeKE7fFiBLuvzCp1
         k3/w==
X-Forwarded-Encrypted: i=1; AFNElJ/Y+nv2vvnCktAaTty2VwIn97L4Q1KFeOsY3Z5FJFOTuQ1rOvmRj9OmrQSnaVEyFMxiOveqDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkVaLU+VlI2DRrP5JKk1fq5jrfKjYh8TX6pwKe+Gtw3npZYSRB
	03AUJXNv5Kxi94RBag66PPpsnBlXnRMXDB2C6RLLy5aAcZp0XlM0/op8lg46PZ6ekM5puqVZy0N
	BYny2W+sMJDXJQUqgH9cAkfahG6Lpcjqwn7v4VB1wSipKNka4eQ7sfQOChg==
X-Gm-Gg: Acq92OFvgBQKbQUQrPripib3YODjrONALpietnlZrjNJ+KszRlIYl/bYWiaUIivGdU0
	zOZIvP2KZ2+HRiOE6W8oNrY/kAR1t65qqLguJFg7KLq+MoINzwZ3VpUN/ukYdgr+J75SbQ7m8Y5
	Vjkc34Wsg4NHB5V5iC2N84af/mT4IKhtFAMyS6jKJyCal1L44VqQxrlWTLYwxOx0dEsKSMgBTXE
	guWbc1C1YYYNg3XwMM+T3rSLZFaKfEISE0zsHAlYcZJkTZu9X8bGsguntXdVyTasSfffwfnUUP3
	0bE77aH9m39+pfVJH23tLMpKHHpMJVpcFkzZX6wBxQcIgRfN7XwaAnw6ksXEkoO8Jp2oWxTojld
	3T7puaErFuO3VnrCN6LQwaNZMtzbuEz8JfcVfl3DshcZcAoQeaA4mngH1fbdnNeVTa7vVAPlz79
	2CYvzXnikByhz09Iby30ljtucAGYRe800xmUM=
X-Received: by 2002:ac8:7f83:0:b0:50e:6139:492b with SMTP id d75a77b69052e-5162feba35dmr42576381cf.23.1778680152953;
        Wed, 13 May 2026 06:49:12 -0700 (PDT)
X-Received: by 2002:ac8:7f83:0:b0:50e:6139:492b with SMTP id d75a77b69052e-5162feba35dmr42575781cf.23.1778680152434;
        Wed, 13 May 2026 06:49:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f625bd3bsm41952051fa.34.2026.05.13.06.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:49:11 -0700 (PDT)
Date: Wed, 13 May 2026 16:49:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 10/14] media: iris: Add power sequence for Glymur
Message-ID: <h2clkcgpr4uki3fq3kbdutsqc2h64hwf2ibtbrnjipilsnhk4u@w7645stdorq7>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-10-7fbb340c5dbd@oss.qualcomm.com>
 <jqe3ilzqzajuf67hvp7nw6mak36qyqu6dz2oiwtkf6zwiyclln@ydtyd7vkudm4>
 <67157e35-8c39-b06b-eb93-602930168f4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67157e35-8c39-b06b-eb93-602930168f4b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: oMj1TzyMEnemIyIaiQeIoQUg4SJaud4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MiBTYWx0ZWRfX9iqn/zFWyziR
 AKPcTCZRfkYFyskskQsRs30fBXS27Kzfot2J/hb4bqpjphSNiVVfu/LDEq+XvH+Lthks+8+Bgzg
 qicWKKWPTiMmxGzi444asDfL1ROHY5R2i3ezSGQyZ7qJG38/NPzSbW62dJNvNrlMdcxtpTXb8r8
 exld9PA3CaO56V9mAbwuNQ1a++QW4Ssl45CIHScKBvJ85bfQ9vucBXdC9BsEuRVYo7jv8t9kjlD
 YbaCEfBHbTUrKlHy0YizCbmJ0YDU240YaIzKYqjLapsKOpnzgz2rmw1LE5g8NPHMNmkwBTiWXxO
 mSTVMD5qfyrMlyilzfI8DYgpWP8VXdY8EiPpkt1W4r6Jeb/e32AkPFuHypNOA8TCaNhMcGgP+6v
 1K9q8jpTtH4BUN9FpFDrr8+yF2F+0PP5BY1nUMu8SRiZ/fu0LCDqZZ+c363/DxlWo9C7Lo/zeVu
 LglU4YyRSMYEr/WtUeg==
X-Proofpoint-GUID: oMj1TzyMEnemIyIaiQeIoQUg4SJaud4K
X-Authority-Analysis: v=2.4 cv=Wukb99fv c=1 sm=1 tr=0 ts=6a04815a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=7I-VUM3uW_oGyASaGJ0A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130142

On Mon, May 11, 2026 at 09:42:01PM +0530, Vishnu Reddy wrote:
> 
> On 5/9/2026 2:24 AM, Dmitry Baryshkov wrote:
> > On Sat, May 09, 2026 at 12:29:59AM +0530, Vishnu Reddy wrote:
> >> Glymur has a secondary video codec core (vcodec1), equivalent to the
> >> primary core (vcodec0), but with independent power domains, clocks,
> >> and reset lines. Reuse the existing code wherever possible and add
> >> power sequence for vcodec1.
> >>
> >> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >> ---
> >>  .../platform/qcom/iris/iris_platform_common.h      |   4 +
> >>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 141 ++++++++++++++++++++-
> >>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
> >>  .../platform/qcom/iris/iris_vpu_register_defines.h |  10 ++
> >>  4 files changed, 154 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> >> index 7d59e6364e9d..8995136ad29e 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> >> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> >> @@ -61,6 +61,9 @@ enum platform_clk_type {
> >>  	IRIS_VPP0_HW_CLK,
> >>  	IRIS_VPP1_HW_CLK,
> >>  	IRIS_APV_HW_CLK,
> >> +	IRIS_AXI_VCODEC1_CLK,
> >> +	IRIS_VCODEC1_CLK,
> >> +	IRIS_VCODEC1_FREERUN_CLK,
> > I think I have asked the same question while reviewing some other code.
> > When seeing such enums my expectation would be that the set of clocks is
> > more or less generic, while the platform specifics should be
> > encapsulated in platform-specific code. Instead these lists keep on
> > growing to accomodate platform details.
> >
> > Can we stop that tradition? Adding a peculiarity of the platform should
> > not require touching of the generic code.
> >
> >>  };
> >>  
> >>  struct platform_clk_data {
> >> @@ -210,6 +213,7 @@ enum platform_pm_domain_type {
> >>  	IRIS_VPP0_HW_POWER_DOMAIN,
> >>  	IRIS_VPP1_HW_POWER_DOMAIN,
> >>  	IRIS_APV_HW_POWER_DOMAIN,
> >> +	IRIS_VCODEC1_POWER_DOMAIN,
> >>  };
> >>  
> >>  struct platform_pd_data {
> >> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> >> index 13fbb21c2182..ff90c375e805 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
> >> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> >> @@ -22,9 +22,19 @@ static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
> >>  	u32 value, pwr_status;
> >>  
> >>  	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
> >> -	pwr_status = value & BIT(1);
> >> +	pwr_status = value & VCODEC0_POWER_STATUS;
> >>  
> >> -	return pwr_status ? false : true;
> >> +	return !pwr_status;
> >> +}
> >> +
> >> +static bool iris_vpu36_hw1_power_collapsed(struct iris_core *core)
> >> +{
> >> +	u32 value, pwr_status;
> >> +
> >> +	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
> >> +	pwr_status = value & VCODEC1_POWER_STATUS;
> >> +
> >> +	return !pwr_status;
> > Add core as an argument to the function instead of c&p'ing it.
> 
> Ack, will pass the vcodecx_power_status bit to this function.

u32 core, please.

> 
> >>  }
> >>  
> >>  static void iris_vpu3_power_off_hardware(struct iris_core *core)
> >> @@ -254,6 +264,124 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
> >>  	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
> >>  }
> >>  
> >> +static int iris_vpu36_power_on_hw1(struct iris_core *core)
> > Hmmm... And if 3.7 gets 4 cores, will we have 4 copies of the function?
> 
> As of now, none of the near upcoming targets introduce a significantly higher
> number of cores. If that changes in the future, we can revisit and optimize it
> then.

Okay....

-- 
With best wishes
Dmitry
