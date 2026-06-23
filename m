Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4F360ECC
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213809; cv=none; b=Xm6MksBtFZq3W3hDrwEeWvRwdj0da08TLVjllnUY9kLnerIG24WV2YPTskUBXrBRJwGWA6by6Qh9JuEbm+wfIXpMZXqj4EBaCfhAD1+V0gPb5YbOkGSKNPaMhHzf1kA9xIachCWlB3UzE6MgH6Z/Tc7eGZGy/KhofVudkT7Us2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213809; c=relaxed/simple;
	bh=RXUS0MiuMi7p51H4Qd9KyX1mXELw3gVjHZCesaH4yws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccqpgHsna4dvH09kVqVFsTgkk0hBhyGKK2x6JObgdEAx0QKWFgzYFMQTmurO6LTKMKn7gvjOdV5o5H/Vy/SQ4B5K6iluYkZT3lX1pTnijPYAvlcQ/rYRew6hIwgLIs0b5ZQk8sW/MAR9pwsXlnr8ARvucr8hbRwW/C15D1YQ+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cbXilyVI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YCkumEtx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cbXilyVI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YCkumEtx"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NAslU04152380
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mAVIsyi0roMiNG+3y68083oAhmj4zDD/EfEM2kSD1qg=; b=cbXilyVI6wW8w1uJ
	sZXyG8GJmlYGOYwDI2JQHfWE9oF9tIeIQbhrCZjn0pvbKS7li7kBxH98HzdSka4y
	hFGhL+SDLgFikzzemVUbKThM20Xlmi4hoEl9jd/jv+nKs+Z2syIh0kPDS1LDNgf0
	zO1b3dSG+qfnTsNJ8yodH4frZdovKlS7FD6chm/9yp+dQxem+d78ngb3/OJwYiAE
	5uQbWjnerSM/+XhuM0y24R/kJCS2TUKgaigmEShJh3qp6xGxcy7NkB2TFpvgcnEG
	CEuHH+22bN0XUk1ePdfwwmZUlPpdf6ipYArWe/Vb+os/huSVJ6y1B4I67aRCdlEH
	mNNngA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n44gkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:23:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9229581de9eso32357385a.2
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782213806; x=1782818606; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAVIsyi0roMiNG+3y68083oAhmj4zDD/EfEM2kSD1qg=;
        b=YCkumEtxHQJI9Zu/kgoTbvDkmHsoOQflg3qR7nNXJ9buhnNw4vyokwRYPDaV/irvBo
         PCfi1kQj1/y2Vsk5Ymw36B1hh+0d0x/3XVXYdKXJgTZStgYAJYiUF/r6jueFvjTF33/p
         X2S4zjLN0CCsaZsc91PLty/Kd9jhjclMlKsP66OMdpHTUCuWNUFhR1r2YH4gOmkUUUAd
         1cylrd5833duPJSff3QxcqnIl4eupsQz2R1Sm4dSM77C3j5Dz3LzuE+2fPjAbVgUKk9c
         FuNUI8oxfRFHHJi6PLrhzgakfCYrspsYtzHyP63uO2WnPGp/nc6iFww9L38TAslYJ6hd
         QpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782213806; x=1782818606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAVIsyi0roMiNG+3y68083oAhmj4zDD/EfEM2kSD1qg=;
        b=ClC/luKZI2DQhbokrh9dfV6ZYN6895Vg/9gFJd48rUQaf1pHDTRPhDvjvPNpD4vKMq
         HIe069zDb1uezHU84Svfd6jcE82Q0VwahBcOKYfhkHn5ddtsRi0QWTOK8Lb/K3wH9Mb0
         71v0Owgmlq0bqyOKKIThqx5DzmDzKiorS9Xgk1fcMDr8HK0Qlox/SsiZl7MgXdnzxOPi
         bTqNicQ5fmYghcbgYXYRGN0YKo6qeWWqsnB3diGc1/1b9GztmCFgQC74w+2hIMHRId76
         9WfvzJX0JT3jKs9g6tAAIfh/j9kw6xBkhS5MkAUr0ABIOa41TDmer/bivWpeD1XIxYjf
         /zBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VTdj7ASnYVBAcVuc0BrRldLaMpO4BG5WtGbF3juK4eqJIIzO4BzwGDhOs77yxZWN6RZdFYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvpD5nfbgaNt0DnesfTdj6WWQ3F6VUIe9by0CFJjTOhP6ZVUBr
	1jhsQPscLJiGWMnMMt0iUw9L0pM67OygFS8L6okxNBWFfWqykYe0og6J6zUBzJPx2BkGN3pJ4N7
	wKfe+KifN6UbmC3El6KW3YnDQAiR/yJ2FCr+gdt91j7a+TwZpH21Tj9SBqA==
X-Gm-Gg: AfdE7ckbUIjgrL4pSj9TOQWe8qkueOF6VIJ+Ow6MW9Qa2j9N0W9wJeduR1nN/d79/h+
	lEraRjtsMId3gKsWU0HRFvs9ItziX26jRDEhmWAFG1myB/aPs4RNTPVXyLvdFjItow4inC+8mub
	IbyPE9pWdeFfN4eFYTIUWf8j80cT9vyLNZhn6kN7QoDLKFnXuWO0+X1kgvR4JrsVT3tp/fCyzMg
	rFIKl16ydtHdMWXslfUcoZfA1VL2DPV9LGvLbhmN4Cif9A+tWT8PAxkgGjRsYqbsgEkQIH39sQp
	CKZ0MYSsxl9EjTemSULCIEevpmmfATXG7ccLclHhegNnP1D4EDdhaynwN5kPsoCcHZt1JBRqyoI
	PZfROorLoiKegPnEYau0w/2knE/eZ/vOIE4o=
X-Received: by 2002:a05:620a:6cce:b0:920:6579:bee8 with SMTP id af79cd13be357-925c6f59e85mr504349785a.1.1782213806262;
        Tue, 23 Jun 2026 04:23:26 -0700 (PDT)
X-Received: by 2002:a05:620a:6cce:b0:920:6579:bee8 with SMTP id af79cd13be357-925c6f59e85mr504346985a.1.1782213805798;
        Tue, 23 Jun 2026 04:23:25 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e49a759sm503098866b.6.2026.06.23.04.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 04:23:24 -0700 (PDT)
Message-ID: <27db2e06-e3ea-4edf-a0b9-1baac1d5bb50@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 13:23:21 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: qcom: sm8450: Modify GPU operating points
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
 <20260622-sm8450-qol-v1-3-37e2ee8df9da@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260622-sm8450-qol-v1-3-37e2ee8df9da@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5MyBTYWx0ZWRfX0aWwZ/iQH1qX
 V7zDBhNzz1NGK+XeFz+hKs485YnvZJHMi/i1w0cFjdnhyjTot2ardoLksmlSuRpFNfHbWtpqJ1I
 xUeamWlfhPTiZVoQt9jNknjo80wUaAA=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a3a6cae cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=yh-zqMWk-TAmMPKcllkA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: TciNwsgxjmmzYoSnCXCD0aiJMa8Evnev
X-Proofpoint-GUID: TciNwsgxjmmzYoSnCXCD0aiJMa8Evnev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5MyBTYWx0ZWRfX6ikJD+xzTxom
 WafYPx+onhp1fc5Rk47D6JX/VN+YIcLjV9fisKA8T33uWR6aoeYCczm45whrbRzUmBBoJ41Y9at
 Df08fCkCJhoeaAMVJo9LbnpitS6L6OnaCnB6CUilPjS06ujqO0hJyX6RNDxVNwxFMoDrhsaeWLN
 q+qyK4qeFtPYSPIf12WX7CSdh+v3fr7VMTnFESzuBA/NYRlZ8UqgOdX8jB/wTaNGLbTKRcKjg2p
 ZDJoGMKTs6E0BOKhTMAGcBZOrBNYy6xk5rVndVsy2i+SK3WdXU/fxqRaaIUg2tOHY/jvXit3nNZ
 tnawab72uQ7codwQgxiFTxJAn8R6tRJlljs8XU0HgpPIzSO2VjUytTHInLLjT0GoXxzg81lBa8m
 L7M6zKJWHfJ7/Kb7RCssYFqFJimRM1nclMzsSPJyCWlcmLvYNHtSeWXPM1DTiOmZtFL4eXarXBs
 cOAuHsqY4tR9tjhx2+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230093

On 6/23/26 2:54 AM, Esteban Urrutia via B4 Relay wrote:
> From: Esteban Urrutia <esteuwu@proton.me>
> 
> These frecuencies don't exist in downstream device trees.
> Both 220MHz and 285MHz belong to SM8475, and I'm not sure where 317MHz
> came from.
> 
> Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index e34e3c05bf74..5e331a25e22a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2495,21 +2495,6 @@ opp-350000000 {
>  					opp-hz = /bits/ 64 <350000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>  				};
> -
> -				opp-317000000 {
> -					opp-hz = /bits/ 64 <317000000>;
> -					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> -				};
> -
> -				opp-285000000 {
> -					opp-hz = /bits/ 64 <285000000>;
> -					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
> -				};
> -
> -				opp-220000000 {
> -					opp-hz = /bits/ 64 <220000000>;
> -					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
> -				};

These are valid frequency points, although downstream didn't advertize
them.

Funnily enough, the frequency plan lists them as:

LOWSVS_D2 -> 317 MHz // in downstream, at LOW_SVS
LOWSVS_D1 -> 285 MHz // in downstream as-is
LOWSVS_D0 -> 220 MHz // in downstream, LOW_SVS_D1
(the above are what it says in the doc, yes, lower voltage for
higher frequencies.. certainly seems like a bug..)

LOW_SVS   -> 350 Mhz // this and the following are in downstream too
LOW_SVS_L1-> 421 MHz
SVS	  -> 492 MHz
SVS_L0 	  -> 545 MHz
SVS_L1    -> 599 MHz
SVS_L2    -> 640 MHz
NOM       -> 734 MHz
NOM_L1    -> 791 MHz
TURBO     -> 818 MHz

so in short, the existing map seems to be OK

Konrad
