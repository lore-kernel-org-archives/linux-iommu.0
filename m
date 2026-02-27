Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4E23A9B3
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221979; cv=none; b=YL9VeisRmjA1Etk/JIexZLVDNXY/2mFcjT40d1851vvQZO2+wwDWEn+Yp8DiBrYj5IY1Wb3KxBtc4EFaIf5AKSRGNWOuKu7RtcrYPa/nAg/d05q0dbmWzb3ZWwUZJnzpYR+zFR7Gx4eRTUSpsxkYh/BigV2J03IVVU5inFoBmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221979; c=relaxed/simple;
	bh=xQ04bpy5cT/HPxv8GhdIAXyz6uWldP+TKSsvStO1lsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlJ4z6stk0LPwQbGQo2LBxPZhavdeZUnlcramADJiBTcVpuQdVWUV6PJtBGLqFIY7xPTXUOtWoyQMYkphFGY2NBKPlJ4T7Q9yX474Bqdne+Q7+VFoHg/pm3GRVYeZCii7Srq2QHMbZIrxE3Lmukvpqs8ssNMGgpSPVb9LnsH4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQpUZ1u6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A+BEqzpB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQpUZ1u6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A+BEqzpB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RH0H0w131540
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 19:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GV2vdzc/TRaF4f8dfG4rJXZ2
	LFeRYlnAduxU+Ay8fN4=; b=DQpUZ1u6OkALzwe1XRol5kLad0bXNl8C3geIxs6O
	wHtIS5+mvtmDkIpnYSs5MM5NVFhzRqA4JbQq+mEsORuGb5/JtLx2Vz7vRHZCNg4+
	4gYzvWTICbkau3egFf7Nj2S6X/l3aeXc39zN/GBXgPVXNfsPtiq3K/eRHsEZ1sFy
	Xcq2nmr4NLvH/o9QbA8eMPHjbQVNkoBbMET4JxE0YGqyppBdG0as3mdUsCol3OvU
	SyC2ZRcd+wpiUy4ksVWeDvD+ziP83QOLaDKx1sLKmP18HACo2EK1AhJFmcQQsr1g
	Jztt0JvZ7GSJ9dcjuB/2ICRxLyqUDyBCro6uk0d1x15waQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck43ray3u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 19:52:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb403842b6so2247150485a.1
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772221976; x=1772826776; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GV2vdzc/TRaF4f8dfG4rJXZ2LFeRYlnAduxU+Ay8fN4=;
        b=A+BEqzpBRaBnzAcSLgUfPyf8HmJbvSuHEv9NiwVH5R4AjN7tkVJR10CDj2ed0IC0Im
         JJBchbc70Eh9kJlnljD8I3Y612tLCJIrcTDiIVCcv/yKcWGOxlv+ARMvvhQHirQEmTaC
         2TA6ciSzLOLZwM6ol886BmdgAH3faN9e7Q0vy+0h2Wm4ELMQzs7aRC5otEX2X8rnnSQq
         IbtD3dHwF9k5Wro7KzUy6r7ogWrJ0LDCBnL1gcEHkDjiFlPNYOKr7m/DHtPoZgFFJSnp
         +wrlUkzx26i2K/O0ZTBaqIDxO+f4jjdbqwxni7ZQtxa+BYAYp7gcr6ItEndzEaGfB2An
         hxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772221976; x=1772826776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV2vdzc/TRaF4f8dfG4rJXZ2LFeRYlnAduxU+Ay8fN4=;
        b=mA1XJBLQou3q+UCPw9WPlrxnwnLHIQ9EptS/kL3A+jlXENBEvnp1OV5FjTynnEMsTS
         2aGXxBH+yKVLqw9oM/Tiog7De9Wny1p94Z5q7UGccSEfrOzi7MPzMTYcP8KAKzM0r0Ts
         3lj3JQb3WfR/fkPP0LfG5dhX2KpCNIduHQfzvLQmjL1DNkYgdWjgszFCOaXw/LUK+0bl
         ulgEG1v5YrRaZNvZMqEYzqZMskyfV9CTDw8rBXHETdogWjbs9sIG+F3RyRvlbSC8E4AM
         jRJdw/C74N65ljl7AEGXfXsnqFTNnCXeSxdsV6WUOanGbJcnugFsPqa9PWdhOlAQjgVM
         /CWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfG32JjUkarDyQGydRtokNh83UAgSbt7tIbDc2P+M+vNuQyU5X2mtLYpBzo2pEhqDKtZ3mtw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq0/7Qk9hCaIzk0COAOOTZqv/47z10qrFb9s8X/DfJRiJOOjW9
	ivWfjUFn0ne+YWfTgVPBpT+/nh1qYpIQlQBmjYPPNnmLltS9c96wBYhNNOZqwNis81NCos+ol3n
	5/mkZ4EJt4EA+csT8R7BS17ddZdTFMKQzwvu80ZhIWH3Tvbk3zWHJiJ5+Rw==
X-Gm-Gg: ATEYQzxLTVMGixPhKPdGEE1jGoTqN/LK3Br/lOFqRue1PTwkpT61jjl9DnW2o4Tbc1t
	nRAZmyHs7cjwBCBWUWzBBfXfeWb44qs9jyDMyqPuzz9yqVtEzMfqV0HHfYg6PQ4DEA86kguI5LI
	yVBmfU7Z+oL5hw9GB7U+Bvl5uvp83Cf5YgjrAtITL5Hc+sTRk88ABet+lgn1l7EsU0RzILOM7lz
	sAYBOBQWKD7bn1blIfSwii4d6DzBnrXSQhThNTdUVC1CAD/y+hS+L/MkydmPcu88+XCMRBd16Fq
	ewul6PtbAn3ToYcEJx8KgUKqN2g9kItywHKKQ9oiCDyVi7OSWCpR2pYjgxh/KMn8zBXaBGjTZnu
	oys+oNkuFdxPqXygiXZetNVMs6SPZDoHF1xh1v1jWMpo9EmgwMPESR0hSLGWW2QmnVHMZhzNUMb
	C2B7NvrqmwU1INiGwOK04zUsoEg/z3CfYi0Z4=
X-Received: by 2002:a05:620a:7087:b0:8c6:d343:79a4 with SMTP id af79cd13be357-8cbc8ef670amr482959485a.40.1772221976091;
        Fri, 27 Feb 2026 11:52:56 -0800 (PST)
X-Received: by 2002:a05:620a:7087:b0:8c6:d343:79a4 with SMTP id af79cd13be357-8cbc8ef670amr482956385a.40.1772221975562;
        Fri, 27 Feb 2026 11:52:55 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f2f4b2b8sm15082771fa.8.2026.02.27.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:52:54 -0800 (PST)
Date: Fri, 27 Feb 2026 21:52:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v2 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
Message-ID: <nen35eqhwbikt7jlpxn22hvur33chxibrbmzd6awo425i3mujf@f2cbncxpcatc>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-1-850043ac3933@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-kaanapali-iris-v2-1-850043ac3933@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: MKcMgASz2T3teahwWgQLeyd_oAYid1q9
X-Proofpoint-GUID: MKcMgASz2T3teahwWgQLeyd_oAYid1q9
X-Authority-Analysis: v=2.4 cv=DOqCIiNb c=1 sm=1 tr=0 ts=69a1f619 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=c5cdqb5w248ZMfMtUIkA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3NCBTYWx0ZWRfXxNeFdL2X/i7P
 wGtw6DkPAgG5jy29nMtsIixLGAkcesO67F/OqdF7BTjG+V7s6w0jjtvFBT6HPXscx1mVQ2C/yYV
 fGvtKldfZAAmtaxGwQ3xQQ4/JatycAr0eqY3C4kpMG5cKM+mcQektpVf/Qb8FQyIUyHot99nYx1
 6ZeTa9D6yeJus28sNBG32NFVlrFQsoEulcutKLkreijDhsQUKctxgW3zencwys/y5C6PXn+lBXg
 Mk+q+2PVo/Z8K3LeGHe3d9qVBTAePzGPHgvZb9ZlwHgyhw8XDg7bNxW2riwiE5/JY4nE547NTxT
 tk43YJt09L7MoJq//tnuv+xnm8OxWTNMDjqXnwlJoKAArcBviXk03YM1yCLO7rZwNuZ/kdEg1nH
 9qgJDNqIKQyWc/u5Ni+zOKn/1tCMOoZmIV4pm9F2qXhwaRUR3+0lbHwJOFpLot8LuoTXqyTrPqp
 OdCE0ia6f0W3COUw2KQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270174

On Fri, Feb 27, 2026 at 07:41:17PM +0530, Vikash Garodia wrote:
> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
> compared to previous generation, iris3x, it has,
> - separate power domains for stream and pixel processing hardware blocks
>   (bse and vpp).
> - additional power domain for apv codec.
> - power domains for individual pipes (VPPx).
> - different clocks and reset lines.
> 
> iommu-map include all the different stream-ids which can be possibly
> generated by vpu4 hardware as below,
> bitstream stream from vcodec
> non-pixel stream from vcodec
> non-pixel stream from tensilica
> pixel stream from vcodec
> secure bitstream stream from vcodec
> secure non-pixel stream from vcodec
> secure non-pixel stream from tensilica
> secure pixel stream from vcodec
> firmware stream from tensilica (might be handled by the TZ / hyp)
> 
> This patch is depend on the below dt-schema patch.
> Link: https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,kaanapali-iris.yaml        | 261 +++++++++++++++++++++
>  include/dt-bindings/media/qcom,iris.h              |  18 ++
>  2 files changed, 279 insertions(+)
> 
> +
> +  iommu-map:
> +    description: |
> +        - bitstream stream from vcodec
> +        - non-pixel stream from vcodec
> +        - non-pixel stream from tensilica
> +        - pixel stream from vcodec
> +        - secure bitstream stream from vcodec
> +        - secure non-pixel stream from vcodec
> +        - secure non-pixel stream from tensilica
> +        - secure pixel stream from vcodec
> +        # firmware might be handled by the TZ / hyp
> +        - firmware stream from tensilica

Why are you providing description as a list rather than describing each
item separately? Then you wouldn't need maxItems.

> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      $ref: '#/definitions/iommu-types'
> +      minItems: 5
> +    minItems: 8
> +    maxItems: 9
> +

-- 
With best wishes
Dmitry
