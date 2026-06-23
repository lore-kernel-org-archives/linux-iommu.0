Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F42609EE
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229825; cv=none; b=q3y64SPoGV0h+FPl3DFb0p9QGBQTLyyR25Fit91M1nBajMEA5u7rEpzF4VBUISzNvI2PmVr26K8Isl0RpuslmbQi7rV/SLHzWNJaPHH8F0/RC5k2tFWLdrUJox9mctq40ifwuy97nGLmnmZi4fA4lkLuQG4NFJqaIEfjxKS4j8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229825; c=relaxed/simple;
	bh=q7Jc1YY3GrhcgpyOUs/OqzKf0RPP3KjpisQthhPq/3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b89jkFUCWJNoNE3Dc47cW0EDrcTLmF4vMvmPHkCl4MdLc0Angb5bEiXjfXcjwfWU3AwqXn06vb89mUH8joG3mk0mftmdhymDKCE7idBMMH1vbdiUMbpkAvxqTonwGmvBKCKbS3P7is5bd7AL5v8mAp/soRPuHvF2iHyP5rIwtro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OD3Wuu9R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KYvAMg/d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OD3Wuu9R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KYvAMg/d"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZD1k031271
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 15:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ym3P2gofeeAjlRIrGWhUFZ53iCiesVQBX5oel0MUm0k=; b=OD3Wuu9RehYOeWG5
	bVAJExNQBqYVK7WKimu8zDrs5acO+dqSR484E7mTf83B8QfCuu++cnDHuiQb137h
	slxiyjceb0ZgqgSIJQ78vIBLFEpaRHEirTsX/jJONZeLMprlV1U3MfgpuEkHG9KC
	0RJMz8uYKLADBxv2DRtBC9y44X002FiqsSEWe/kaAyUJLVyH9N0ayIl2WbAf+UXO
	7OtcvSiU70021CbFo+IAp+kcj6pLAG15QSBPTJ0/Xu/eeBSFGsGy8ght9iGJhKFa
	6WrpZS81aFmwFl1jqRmxjuoQ7uVLL8T8A8Ohj2otvR9pSDCMUk7aguiw3RBBoKAg
	Tpx0Ow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe69mmr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 15:50:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517647fbff1so17974961cf.2
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 08:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782229823; x=1782834623; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ym3P2gofeeAjlRIrGWhUFZ53iCiesVQBX5oel0MUm0k=;
        b=KYvAMg/d++IyELxKf2+esedDCCgmnruQT5A8tHjOwGooOy8r4/YLayZrL31J5q3ygm
         GcTzd42ZTqfvcIzMtheuNW1bPBMvJToRxZl6MqqPnnGMf44n2zwFIpUY0FDvZxRTmOwB
         hORo6F6FN7uPrJlqKuENc8kbzkkvZwARR2A6LlYEmXfRSNAhKLGAT7Rz6QGV4Gio6+fY
         cRFDNiTECIh23ahrpyclsmXZPQkNbQDZfMvZDleNMbG1MV0I1kE9t+MOjcpgsKyu/WTD
         MGuFZCHU/JRv3Ln/qrx+cr1wJklPx62tJIyER0S7q5z8L/rpSM2XS0Z2EeMlgE6LURx3
         X16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229823; x=1782834623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ym3P2gofeeAjlRIrGWhUFZ53iCiesVQBX5oel0MUm0k=;
        b=fR8jwPZtWr3Ew4+rsP69qhtBU3QPvdCVuyq7oLp5eC3UvnKIjwNqvPKQS+b6Ip1xDv
         1NeygxyNrpUqKBix9+Xa0YlvfUTkC5mFqir5ZVyQ9wS84RbOm+LH51ICpcNaGI86jRx2
         4vyjBp0IOS1X7XAfm3Y3Pow5c6fIbSqru1y7sgyL4bD14EdaEJ7+tesM+aBw71BAdcBn
         FraFhbInYNjXxG9xS7C8G7KkFkyaWVkeVODeZBG1noFbfDmHbvP1fhcUZcaNfsqh5y/a
         Wco1JRZ3rmArLenq6zWxWAXcikytOiItP9t4vz1tyepXXYQSCGS9QEtMVvfI93wtV81E
         yR/A==
X-Forwarded-Encrypted: i=1; AFNElJ/6gN+TS9eG6ryocSXfu1fmtdEPDVphi9ZGDcat3tesc7gRVAofTStcJgA84Nb5rkMRHxUUEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGpUpijxTJK+s689QXtU2AWnQUdfgpg6iGayUqsRDOzJph18T1
	hGD/5ZC7TxOKK/hD0mSsZdJ5g5RAK3qB8MuNRRsh8AXY9KnG7PROo3bjUVvcefLfOKLTvMFsv0e
	Tk7L9Hg0QN+dlZtpav63H+gizjSAYPbP+Ps17tKDOXJfdayIQKVU8p6F0Pw==
X-Gm-Gg: AfdE7ck8SzZv700VEgXi7z63hyo68QzwWjJoWGKFPKSKHRNm6Pn5Mr/njYCC99GUT3u
	qDPnSL3o4KymONiNicKVAU90oA4L60FvJ8c3ATJ6KoQ0hPm49jYEiYZIHtB2r3SOKIt3tHmWpcv
	YDXcU0BtHXtSL4XnmaKjHKYWvIepJVQCRnwmpnPIBMou0td7KeJ6/qvmZmxb6TNMLqj1QuPzTw7
	kB58wqAgyPHXv3pykZ+9XdfO7wiVCysfRHNephEb7ODFUNPNzjHY4m4+pFwTWkTHDTsl6GaVrC1
	8e+AB1SEEKiHFME9KyDjNaCBl/clg09Rc8TZjsbHDeuryISXpnvh2XKvcVDVDL6iKQ7HO9sEJg8
	tLwt+ughRRePM2ZUgdIXbCY1MZp0ZmGOfT7Q=
X-Received: by 2002:ac8:7e8a:0:b0:50b:5286:f756 with SMTP id d75a77b69052e-51a4f4d4c47mr51048331cf.6.1782229822754;
        Tue, 23 Jun 2026 08:50:22 -0700 (PDT)
X-Received: by 2002:ac8:7e8a:0:b0:50b:5286:f756 with SMTP id d75a77b69052e-51a4f4d4c47mr51047741cf.6.1782229822025;
        Tue, 23 Jun 2026 08:50:22 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697ee52f216sm32857a12.3.2026.06.23.08.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:50:21 -0700 (PDT)
Message-ID: <65873506-1a9a-40ec-ac67-60f61a0b4b4c@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 17:50:18 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] clk: qcom: dispcc-sm8450: Fix mdss clocks
To: esteuwu@proton.me, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-1-37e2ee8df9da@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260622-sm8450-qol-v1-1-37e2ee8df9da@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gW5tmEMTGS5UXOUlZgYHxJLOx5GX2yWe
X-Proofpoint-ORIG-GUID: gW5tmEMTGS5UXOUlZgYHxJLOx5GX2yWe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzMCBTYWx0ZWRfX85kYdX17HTwn
 hBjVlpDWx30l8GB+r/PsStqZrMKg5Q/knR/JmZo8CZz+Mr0J7Vn5n4ED1WsPZNxLgyGJxhREBOH
 SSviSFOrZftYrCtB244b+ULOT8q0N6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzMCBTYWx0ZWRfX6NDYiCkTAzUL
 GLvfJqOo78hALsesRow5+6M0Rq23O6Ow5tPiZEQVoMC2Pi0cjlkeihjnsd+JnuD620yvBx3nq/r
 EsLYEuTHHSfjpcFGvVwk3MQAZu7+qoAvvzGPYhlTu+obtY5V5G8d9KJTzGYW/0ve2lYA9WcST9+
 J4B8X0wiZ3KPyiIIbC6whMj1jzEsaupwG96gGerR/AQCojSHfHUe0DQcNxUgmgsnTLbkNIYiNFH
 P5+kEvimB69FjRokdxUqQ6SquzpwGN81DILUVj/ZaNXQ4v4MFmDaRraS9KaYpL4ZH+dU8KhgDug
 hGBY3hD9V7ojRQAJ22e5cxgPGUiiUjt7V8obRroSSe2v9rORFewFBD8Yn4W3spzSxTyhyB5skaY
 Eg6SALwtoMlxQTuirY9/Sewt55+3a/vfttaD3Yg5GlqUPugoeImajumMmM8w9eSGt6KrpTVWqsa
 GOQ8Xu73mVJ46YLKqeA==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3aab3f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=1aW_qPit1WSy-zhaZFYA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230130

On 6/23/26 2:54 AM, Esteban Urrutia via B4 Relay wrote:
> From: Esteban Urrutia <esteuwu@proton.me>
> 
> Both of these changes allow the framebuffer to show upon boot and let
> the mdss driver take over afterwards.
> Before, none of these actions were possible. Only mdss takeover was
> possible, but screen had to be turned off first.
> 
> OLE configuration may have been a misinterpretation... that's not
> something that's done on the downstream driver.
> 
> Changing disp_cc_mdss_mdp_clk_src from clk_rcg2_shared_ops to
> clk_rcg2_shared_no_init_park_ops fixes this warning as well:

[...]

>  drivers/clk/qcom/dispcc-sm8450.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
> index 2e91332dd92a..b99d3eb5e195 100644
> --- a/drivers/clk/qcom/dispcc-sm8450.c
> +++ b/drivers/clk/qcom/dispcc-sm8450.c
> @@ -614,7 +614,7 @@ static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
>  		.parent_data = disp_cc_parent_data_5,
>  		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
>  		.flags = CLK_SET_RATE_PARENT,
> -		.ops = &clk_rcg2_shared_ops,
> +		.ops = &clk_rcg2_shared_no_init_park_ops,
>  	},
>  };
>  
> @@ -1824,8 +1824,8 @@ static int disp_cc_sm8450_probe(struct platform_device *pdev)
>  		disp_cc_pll1.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE];
>  		disp_cc_pll1.clkr.hw.init = &sm8475_disp_cc_pll1_init;
>  
> -		clk_lucid_ole_pll_configure(&disp_cc_pll0, regmap, &sm8475_disp_cc_pll0_config);
> -		clk_lucid_ole_pll_configure(&disp_cc_pll1, regmap, &sm8475_disp_cc_pll1_config);
> +		clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &sm8475_disp_cc_pll0_config);
> +		clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &sm8475_disp_cc_pll1_config);
>  	} else {
>  		clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
>  		clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);

This can also be fixed by migrating to use qcom_cc_driver_data,
which takes a list of alpha PLLs to be configured, and thenthere's
a switch-statement in clk-alpha-pll.c that always assigns the 
correct function

Konrad
