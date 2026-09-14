Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2643F8B6
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385006; cv=none; b=lcAn61kpmaQpF0AcimEtBtEaR1IGCx5GLy1x1O78fD35yS+yEyeKNFnc71N9wqLge/fTv9C/JudhK6u5iFviyTzfQGcv1U5uOQD137O8IfLp3eNipwYSbkBsBCOzdeSIGRM2hmGhDIEhF9FfVViDpqBol/gOZa0fxDX/O5mJal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385006; c=relaxed/simple;
	bh=9NTdtJ/TSp6i9fELQDWEuFYvwbqy3ev3R+H2YTC2xv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E19aYPJkRpjOoCazxiTomAnk6KQrv79NK6l24KF2+Dpy33CoGlIt2ZMGNKkB7WIQDI0xLki/9LSbiWqgvoR/ppZNHka6iZdbsjc+Rs5CLsvn2nNYYLGSf9hLwF2PKi7Q+/rnI0hs9EeIN1HRnzbBdytYReemfUX9c/8nC9ACaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E/WVOCmY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UBANMgqk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/WVOCmY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UBANMgqk"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EAlwUn3860401
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 11:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=; b=E/WVOCmY/+5Enkgw
	YEeOQ9dPHJUB8CWxTR20yFYOlY8UkoMJaYfEbZw5mtWvnO47B9tf1wMQPeafNwuh
	wcPa+7jFxuwllxPm+71b/159YFvZtg/2RACZvfhGXsdX3lRflqfucbjNfAT60rpW
	nT2W6tgRlLZN6L+MSJ/TNerjJkANtic5DzviOrYF00TQxSgNoyEqEGVr9kcRPO/3
	gIuOu7yV0ud+xAE5Z0o7WnQCbf35GMdm9FpQLiSsBTvoxEBODy0Mr28DtrxMTC/P
	1BajQAshRn13edHqPJho+jbGH0cD+CYPJc+8jjhbFR5E60BgJZv+Py3P6XJNpBgD
	ZRcYpg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f0rek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 11:23:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930a312222dso32873285a.2
        for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789385003; x=1789989803; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=;
        b=UBANMgqkRFiewqfYVK7iLce4yO10mBa6PCV2j0I0H/cTYrFgblyWQ65qOUmSO9TKEk
         n0LxBlNadhqQKZtRGGRX4xyzenkOVqfFwVFyffPYQlUYoPFKbtuPcs9E0euMzu+ZQAwr
         KLPWMgcMVFET7vWJSe7mIG4IaueVDuig9xDhpsx0crZj1q/7vEYngMOSHu8Vr0yNd6LK
         qd7ndU/ItW+LtGpHo15sW3zvCdfiZiJpaQLdYnhSzdazPR7Daus0Jeg4LhRcNmqHT8ws
         /1u6ual2EPt2Sb1Nm40r8PuQbzoF3chjYvH/DHoKhE/di3qjEmWoaiHQp+k9leTlfj7q
         A3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385003; x=1789989803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=;
        b=p1SFhsjJex1iQMZx81uMh+mpc9Ga43e3tGpwl3WA1nBKNpzsXJr040DPVDqSqMmUoi
         Sp42d8oYFsAzXk8NBNow+s+0JxAIS1C9KbfO5E2fAxxldWqfcTdYBzzyCc4CBg2bG0jY
         eCfSAHmOmmIAQGP26fS//Lp23smq9Upi0RN3v+kblA4U3hmNl6edGx+npRXeP2MP2Quf
         TjJpsWh1HgAEgPBWIQ5FJD1whgQMECOy2Csva4jrxkJ9uTnBGyOa1PATLQganx1VAaEz
         6YZevkZPHFt98/g3xp3gamjzr23ANlkvYa7NHDztYMmQxlrXgjEID4OVXnI+SHRJNrxx
         BFrA==
X-Forwarded-Encrypted: i=1; AKwUvByOC9m4cJHuGdfqMHZ3ZZU4iBQauF3+KJN7DQr1GxIFQ6wJiXETFQ+n7cCq1rn94/hTxGS1ag==@lists.linux.dev
X-Gm-Message-State: AFuF++lJAZt4ExlmHwg5ki/o73klbAcuesmOxEAkbeD/m6lE93Z0Ptdb
	2Y5pD0/u4knIzysiqDKDPb6ZXMzc7Yt5hlU+uHQZqOg0BZv3vQAmZ+fxCQOcJ9N/7VxHrQNH/61
	m9pglTo2ShleTxG/IkxJS1Umt+AuVQLubUSTVoQeQYZUyH9uJTWS3pM0sHw==
X-Gm-Gg: AYBFou1cQWQfs8bYlIaCf/RRkzff07YS99UBWj3XuR/10fWuB97XOagkB213djfhugG
	lW3gkq1DlsikrrTllZp5MUdlSWvXLbeCzX4akI5Rrnl2x354DoggdpPuHUnW3OAuh5pxRcmqAMp
	W8UXaCOmvgy6wmXBd03TPOhIitF6FNnsujijL0XzA3+D+ujRx3aFQnybTq6KXS9DlQ6f1tGAiyy
	wUcnpiUvWmJAruisMxyva/sj+xvmRFyGeWYKZ+/xG0fCxZqb3qD1FuREpWkmn1cPyHpDWDbPgCP
	Y6rJ7SG3xfK5I0vB067jSXPfybxMTQOqeYEyjLFdPzUWWBqSn+XR9+qdAgk38PfxaAB83jpX8gV
	K1IGQPRw0M6oWSSVCT14wBA==
X-Received: by 2002:a05:620a:4555:b0:934:95d9:85fe with SMTP id af79cd13be357-93a29a8d250mr214251985a.3.1789385002640;
        Mon, 14 Sep 2026 04:23:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4555:b0:934:95d9:85fe with SMTP id af79cd13be357-93a29a8d250mr214244085a.3.1789385002074;
        Mon, 14 Sep 2026 04:23:22 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296601f4ccsm406660866b.20.2026.09.14.04.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 04:23:21 -0700 (PDT)
Message-ID: <757e124a-4c7b-4d3b-b73f-19e7e39f2677@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:23:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
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
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bjWn8px-QKi3Us2zXb9-mwAJENeY6Ur3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX8fx3eee9TZNe
 UslqctOFMC5S7amnJ0/OuiLMIrKncOotVessT74wv6oJzctImwx5Pg/VRsf/bUUPjVDW2DUiUio
 6tybhF0D47afa4vsMQsX5t8O0r/mZTY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX+CBa23NuKPP9
 7Y42IHBB7gVZ3eBuhQ0ZJoXUN58IQEMnKbDk4RgxJFOejahJ53ypF9I8XEG6EbuJ9Y+w7W6d0TG
 eaTF5gCwWrjhkYs6Al9mzsGHtFFfuS2UJM0Wv2xqrz4p9F3Oi/GIN9WG3389M0BDgCESwZWnFTl
 Psf8LHqs1QvjSqlHuB7C1+M2+1X2rKnAymZeKsxTan61vCJqu6wH60AO72UmEjGSzzagOekK+L1
 WI4CSrKc8N81oWcrVMk6HTbVU1oSFporsLMrRz6ZUUutCOrhIoz+kPA5OeGM8x2hhUZ5ABzmUEW
 YElA5FrWq7hTYsDnCh5O3d0dJrbY1pfFVL8gyN60rpKIt3bKFhPS7gsekskk7fFSKKt7a4eK701
 y3rb+VPw6b2SKL8S+VVvo01wi6I2tDt+2AKb8+BsOmoHGrCaxHObGnV3fY7zp7Jzmbvw9AmZ39l
 XfzMVMgbM8eCvhkfJaA==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa7d92b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=OvtQcJRYg_U4C0nSOkMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: bjWn8px-QKi3Us2zXb9-mwAJENeY6Ur3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140161

On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
