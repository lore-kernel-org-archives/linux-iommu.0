Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623160;
	b=2SitS4eqWszchYHFFmieExOZKzk70LbxPrI15g8TcGtiNre9JUctJFeeNsNyR+PxxEqO
	 YMV+0zMytgrNWfZ6QTnWd4eh0qx2gFafQovXvyLjzm2hpm/6rl2uwpsSiFdT0JJBeYuNw
	 5dW7uAYQOOJHO90f4iBuUnU967VurrhCICIASARlNlTjJzGN6T6OjFGd2lg4bHANk8Eoa
	 uiCb6faVmImYDWTjL+Jq8uosnBfWNjl/RyZw0x01g8FKtR6DkFMGDL0tG82sCpEowe9KC
	 iBLOePvt3QH5tsuzGZVpKm6Gs7LnmPuWqRrPqCSPq/zyJIWASD30A6EpqB40mRIVQ0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623160;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
	b=JUKrKRVlzIEH5ZNliX26FJXkSX1w3Ys53wK0CFw7TGY3XEk/CygTt7Tlweh3eBa97VIz
	 2U//lc+LngW2dFDBXAkOwqclT7zYrAuUH54tcRs/+TD3Ld+8fCvW7+sreHMGwb/zZahaJ
	 W5Ic+TgcDTrORSnzzq15uGPqnVKuOI/SAX0cZmMcKldxWnQsSF3HwTemQ40KML/lGH81P
	 QYEdIkBntIpRnndHd8yeSYNoulzWWz4AAOzMyaJAbIEfTRwoxDgCH3a+md0dOX6Cy5Q17
	 hV98nW2mX/QTKcuMKWQV4050jVxBCaDlRUp9c1oghcUvaGAEOPWU0ChDRJ08ouDe1fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0saIndc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KTdsGCGV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D5606A32E
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 12:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC4D5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0saIndc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KTdsGCGV
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2B2wG7077142
	for <iommu@lists.linux.dev>; Mon, 2 Nov 2026 12:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=; b=o0saIndcVHp8vZ6f
	CZ2rkVhjH6ouSd/s4V58y71yXm80mPHeAGEZO+CC0GP+LnpJ9lCUFhD7KjU0mpol
	LhVJHiTkF72NE9l1LmUq3b+c80HrkvP15aK90GU2lJB/zwQOfZqylENqYUtyeX3T
	AU2f5gRStFfAqYDzzvyjk7lLa8GfK7f1LNdcYXLNO11BPKqQtLcgkmyZ8Xpsixgn
	g37lQ3M1AHJJonE/at+vRCNLpPUe0IyzOUE1/wTnknCOiKOrUGj9i/319/V2CvHM
	KJxzu1UhoCsqrbX7DDFAWEqBWoRlU9cGIIM+8f3H1kFlqq0kV5l1Wqm0ffwKkjQG
	GNbzDg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6rasp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 12:39:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-536540909e5so8622371cf.2
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 04:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623158; x=1794227958; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
        b=KTdsGCGVSzPzPyNvHpiy+X52I/rxLUfqG1XIWVCz5+rbVLImMHJpoImVN2JJOudCFj
         uzrZHEor7PkgTI/klAP/gjILasrEdXveX7JWWcuIYed5yDRJCQxkhqIquyLRluZC5a4V
         7HV+b9B1ssF5TUJbtcgOblVyapX6Id35SIfSbBw2fL6e8a3KY840x+Em9TKW23HG2Bm/
         P8VCEGmH5G4GL63RTCtQ17Xk75qLqx1o2Rgs0X2q6C9dbMJb6UjbjQVLSyRqjRaBQYAm
         UZlEIPJhpteBuvDLtfmoTlUqIOutKHV9cEs2tD9EYZEXbIJS1sdaLHilL8IbwX9+6uHF
         VWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623158; x=1794227958;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
        b=0Om13nofvek24n1coqiIQonTnexDkDeb/wM9Nc/VsJwD2u/ycFAYe0rLwVCtH+p22C
         H/UrrL/7yUz1X0N0nkTEB2VBHKIY4St4OFaa9vb8lxzxUvm9w7HJccIqLh1YwVZXxO4B
         lgYa+i+/fi4X57oi0FV8mQ+jocgVUsNGu/FquWTMq++8VS93CEFN3kOyc4jiyyIjX0K5
         3FMvuhAtqovi1AfrwAdw2FwCFlnJiABrqEKkNSxhB6hkY8vGcnFLXDjifTNjYsVZnf/n
         WqrJgBsrr+JsIyliM68OM2c8K8sEIYksNKNWbgSynelngOUBnY/ACSCSx28MR+GGK6O6
         xj6g==
X-Forwarded-Encrypted: i=1; AKwUvByhCPyTjQh5OgFRgiz7+7lirA1OxsxHoLYXQqT0SuT8S6yy+tBthw+cWmlcHpYkcMg5JmrtEQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJIcC/wA0IFPEI0KYLtV/c0/lmKePyy7MxZgV0efVae/MiqMO9T
	JAcL1q5yUCW9b9iHXxihMPwkgnr8YTDiR2zpWjnj9y8fe6ZLnSB03XORxWVp8Ee5uhNjpnVa0T4
	DYjh/r64ZYAeYI/HVK2oKInuwUMb4PyTkr6nc/06vZK/Q+js+iX1Msq5FIg==
X-Gm-Gg: AYBFou3h0LwlwwH0MKE3qWCFLY74rp8i5D3j9b0wmC6lS5XgI+SG9tFjv0LriWxzzbK
	ZSP/4syQXOBhs4scyeosluAUY+NX/HjuAgCo6euuOhcAo9IQTEZ6t3VEqPbxjyxDxLl6bwNLFS2
	q72OFhh8bSMXFwMeJTSUYUsLBG7FD0G7WT3Ku7d3HmYQwwHrN5hocpQZ+RfuTU32vXGHAANvInG
	9ueqymNDptMSpGKRad3ZA3l2Xdl4fE0S26CShGtKObOI9gOH/5qUAA343XgrlDtUL9RMCltS6pb
	iHS/65VIHuiaHE2NOnoIKbsBKdSK8ha/nnBdZW+BJf2YM2+PnjHgiMNmPvv/U/6an+th6F8t5Cc
	e1NTvgjgVVs9XNw7jIQrXlQfalRDeoIO1gSHoZhU+0KCfUTjXbGLo6FEAENXef4o8BCdUvwM=
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id af79cd13be357-94421666fadmr1815614885a.3.1793623157917;
        Mon, 02 Nov 2026 04:39:17 -0800 (PST)
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id af79cd13be357-94421666fadmr1815607285a.3.1793623157435;
        Mon, 02 Nov 2026 04:39:17 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acbbebddacsm23222831fa.6.2026.11.02.04.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:39:16 -0800 (PST)
Message-ID: <ee443167-963f-4a12-a49d-0b4523afc14f@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:39:11 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/11] arm64: dts: qcom: Add initial support for
 MSM8952
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Jassi Brar
 <jassisinghbrar@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
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
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX2/qPOgXX6Ktm
 Kk7AFa6F2Rw4OuW2In/in6d19o2yqaxGVGvSzGrl/Fmml/KbKk7RqjOSAhatip8CtX5pAZ8yOlu
 udwgxnQLopMGgvGek+WI4o5yeiQ+j+8PDCd/a1w9XlS3OXPWuKBH1KRgNbt0lymO4nL8dpdisI/
 Xow2UP1CZorXZBeYt+5/DsnPbjbn0urNloC1QSw+gca92ji5pspfz/evi4P+KUBIzsi4lxRKcGo
 XRR1s3WpZycpGsu+qTFWuBZSSaRoaGonDfCead1Ubp27F3dlrYXnUfUeZOSVA0tiZuB1SPNj8h0
 tStZIpyzmsc2bxizADCaCpAdR7MR2VBW25whahK9MEqWXF7SK3IKrGTaVipFeKWBVJ+qBO9iILt
 wtCLIdf2pYuMIb9k9DSZJdrR3Nf0P5IongtpsiI1gdVtMZU85tQ1KdJWShvgAJkGUqqafx9f1z5
 D5+z+AHAU1zDqG1RW4g==
X-Proofpoint-GUID: GHVFlfkR0xHOvwkmrtzBgjKP04Np41OX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX7BJvL+8kyGJN
 6BRzjppzQB8QzTDaTVJ+wcGw73HJBJrPOzlj5IOp+2ACCJAvTGT4SBO9Uap7Yp892kH2goke9XO
 akAQdbGbgxSIRDHcryhxrloOqWeGxjc=
X-Proofpoint-ORIG-GUID: GHVFlfkR0xHOvwkmrtzBgjKP04Np41OX
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae88476 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=OuZLqq7tAAAA:8 a=MxLZmUXcRv2kY27zAqIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add initial support for MSM8952 SoC.

[...]


> +		gpu_iommu: iommu@1f08000 {
> +			compatible = "qcom,msm8952-iommu",
> +				     "qcom,msm-iommu-v2";
> +			ranges = <0 0x01f08000 0x10000>;
> +
> +			clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +				 <&gcc GCC_GFX_TCU_CLK>;
> +			clock-names = "iface",
> +				      "bus";

The robot suggests this is missing the TBU clock (and also
sister iommus)

Konrad
