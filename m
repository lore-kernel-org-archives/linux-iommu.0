Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D33CFF79
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214624; cv=none; b=sKqwd6GIvEc3zAz5FIWybwYXcS9RL8IkE5KY1rR9hK0q5qlpZOHBnEcda/LTv+0p6J7ykKXV5CfMBGi9YRUK9RGvg/eDmExQnwpIzer76CQh5V7tdNF5C9YrmidyQN5YtnYX59YKTeJc50z8HTQkvQmcEv3kDqIM8Hr48u7xHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214624; c=relaxed/simple;
	bh=aTuVaf0nYfYAWfdJkxo7EvxAlbxCaffxQrDNMK/QZvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2BER96Yd9zAaGVqPVj+vf9/N6cL5DALHQGDfScleQs/DXXex5H/E8KPQUnaO5XCTUiskFnsUh6xh2LBObWYQ6dHH9ISS+4tkjPjOSNeEO63HzuVX245QaKD2GlSyKQUbhAlGSohtC0GppRM8kMk5iajDaD42HHnVbe4YSoHvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OetdD04s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IdZzPGFr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OetdD04s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IdZzPGFr"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBa3bk4053595
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MXNsvpmExzEXM1J7XKQU25avjaUjuFbYf81y6omDQEg=; b=OetdD04sMT8BXOHl
	P0ZfY0xGtL2vRhpknWkdpuLX31ixTvC6kpV0E7VQdx0gj/pE8GCrCnomrMVSoU1+
	L2bCcW3nQ+aUWuIXihofuZXtk6g13KrVR2/2baRhAnB8pdxL1JML37cHNUuDwsL9
	5MVe6YTHbtX2udMawnrW7aZgXiGhpEAyN2hDgmAJLUOFX6tzvK3dZK2DqvRnWAbA
	ndKWhmmmPYlyDqb7nmieAixUTjlWqAOE0oPFv8GUUkOsTpEFyBJ6bbgzJ1gvoniI
	XyL5R7akeITlahYsjQv8hfHbBlRRM23j5kPYYklFHNfS/zERxNBB56rvyaxkX1YF
	GewvCw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9yr8gj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:37:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5176891d0a9so13481641cf.0
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782214621; x=1782819421; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXNsvpmExzEXM1J7XKQU25avjaUjuFbYf81y6omDQEg=;
        b=IdZzPGFrmTyI8U2lPQ60TYW5lIz4CyqGzHnUrjtT6ncFKWmbTuIv2yrc2+/ZOY92TV
         t1AilL69o5EIAGKNHe0JikEEAYoeedYZ97/1kzp+mleJUFNmnFBx6dyou7DN0VVhoJhW
         sn/kQjfvFxH5VH8IwKEHUEX58RDzjuMjNCghrbAqbnVg2aNXigAAtNOW/6yObqYkTel1
         zvJ3g11Zp74XExMdMYd95EhEdBmnpVmRB9cGjYmDVnmDM1q5Yqyc5s+OXj9AJ9ZIPsJL
         mWQ90XyKpet8XlTvGeGEqAzx8nCQQmyyM1fsEKZgysqetXe8eWj4CDkS1Vgi9vw7gV/w
         RsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782214621; x=1782819421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXNsvpmExzEXM1J7XKQU25avjaUjuFbYf81y6omDQEg=;
        b=d8H5pVOtRYYXQNvmY5sxXO6dE+e9T+xa1hr93a1Y7QSvQFhu1PMo2cTaC6R84O1yyY
         +G05dTFerSyU/HdQzAewNmpX+wyjDexit4CMzsJgRfQqyM7Tl553JFbK6UQ5EzEM64KX
         VLDt+Ot3FFcFGWOoKfDBnQzVAUKvtYw8hGIxc4CUdDpyiVRjRawX9TSQGTWIZvp0usSG
         xca2Rbe30E776WBM125B1UNIDLEHHCQEQ1eyZ9ea6fDPUNI1eH7vp53w2rww8Nwc4Z9g
         NaDFh01xE3YT6nQxuj+hmSs5H3A+YmDYweSeUdFirZZNAcMplGvyABmMqcPQr/H+c8/u
         15QA==
X-Forwarded-Encrypted: i=1; AFNElJ+egHsT3HwApAU8bSUnjJhvlwCkWqKXgp7z7uJgUB5PERaq52xYzRzPBnsEP6KkpQCgcYVynw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxKZS+7S9sNsQ/YncbcxBDu0hMrIsnYu3eY/w5dZSVxBMTof22
	9RZkUlSR+/Y/Mn39HQ8Chgf0Tapw5DCfG43gEQfM1JsIZMLo1AVjTXtPZ3evGDkJrxAWapoqfUB
	9P+k5SLBJ/fEOVyvwSjkgcQj96pcW0L+rr1LuCXBejfQykIFzAlF9inrV+g==
X-Gm-Gg: AfdE7clFKF1kGPs+6LCgxsBXgDVTiiwWrl3yZAz0nUmYP1gAEVvp5NefFG4A9FR6Uss
	3nxMQwFNMY07N8b0hc52+s5U3weWHFMX8OwGtIrN8SXAI9AGYAKPknRwIAhXcYZL6d/PcPNompk
	GAyTGquwHHvaEwJP3eqDsW9nHKWWLedPzxuPAeg92/wZEC9tXoagIW85o9NVT4unL78cO7nlnYl
	ggh3tXQgIDlPQTzwV/3STJ8CW/+ModYVsJE+E9K3EvBB5cygSc2LiJr2RC2Z70r1H1nd01b3QI1
	FR3uLDjqUrTy28Aiax3lRl9+l2TMzdkl3NuvImd19ZY44OSXI6yrDGRE5272cDa/5580selnIKs
	temRCSc+gwdEVGDZVk8Z6ymb4iJ8fjw7NXwY=
X-Received: by 2002:ac8:7d49:0:b0:517:5e32:f3ac with SMTP id d75a77b69052e-51a4f380d0dmr47487391cf.0.1782214620882;
        Tue, 23 Jun 2026 04:37:00 -0700 (PDT)
X-Received: by 2002:ac8:7d49:0:b0:517:5e32:f3ac with SMTP id d75a77b69052e-51a4f380d0dmr47486981cf.0.1782214620409;
        Tue, 23 Jun 2026 04:37:00 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be498e4sm4536670a12.20.2026.06.23.04.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 04:36:58 -0700 (PDT)
Message-ID: <4635a665-f605-4647-810d-c9d83a271a86@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 13:36:55 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] phy: qcom: qmp-combo: Correct pre-emphasis table for
 QMP v4 DP PHYs
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-7-37e2ee8df9da@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260622-sm8450-qol-v1-7-37e2ee8df9da@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3a6fdd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=N-WSo6sfiX0bQk_JYPcA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: dJKimMy165RuWldkAxVEfuo_I0E8-TuX
X-Proofpoint-ORIG-GUID: dJKimMy165RuWldkAxVEfuo_I0E8-TuX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5NCBTYWx0ZWRfX6nkPWlnYYvDR
 P2pW2T9qxrdQgWqdHBNfLQZw98qT46b3MJB44+nvF2pGWd5VUHtQ1TvRvGBOrcK+yTFp68C+l3C
 pPZJEF48JTT3nIqQCHoEmpq2HexcBxzpsP0bCSUml5B+2aO+8GtOemfqpwmpeGAsgJ9CVy4C3/K
 cZXot1LPgNkzTo3O4i2vuGAGSY9XKGiDqzOkAg+2b+IvG0RI5UvuDmCYQDGJtr/9ffw8hEP1GmU
 c4NT+9a4/WZBti+K78rmnpGvowtNyZRZLAI98C2ElcD8DUAM93mTlIq2UWTNZ3pK3G+aF5s0o22
 ImHVkPUXGp85LXlhrZxmtH58IKvpF/arUlzoh0WELfLlyvv2QtMoEwj7LlCtpPcdriYniEkMkSO
 k3Gfaj1/NLWWWsKwZ1WaXBQ1Gks1+tYtwKeR164hkEuxISkzBSRrH33LmMq27azjig3UluNnOSI
 w0mk1B5FhZg7QkDldEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5NCBTYWx0ZWRfX3EJbDhZB/OCr
 FiklRiHYS4XgKkHRMv0gftgne4VWjKYn+1saBL6onZOn20ki1mVQES+Q8ryBQbsB78A1qysU3F2
 o+TnhfnhEOzuyRxm3FvoUohbiCIOj24=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230094

On 6/23/26 2:54 AM, Esteban Urrutia via B4 Relay wrote:
> From: Esteban Urrutia <esteuwu@proton.me>
> 
> Comparing sm8350 and sm8450 tables, this seems to be typo.
> 
> Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 9bd666ac2c49..5b278fd54a16 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -2108,7 +2108,7 @@ static const u8 qmp_dp_v4_pre_emphasis_hbr3_hbr2[4][4] = {
>  static const u8 qmp_dp_v4_pre_emphasis_hbr_rbr[4][4] = {
>  	{ 0x00, 0x0d, 0x14, 0x1a },
>  	{ 0x00, 0x0e, 0x15, 0xff },
> -	{ 0x00, 0x0d, 0xff, 0xff },
> +	{ 0x00, 0x0e, 0xff, 0xff },
>  	{ 0x03, 0xff, 0xff, 0xff }

It seems like 8350/8450 should be using what this driver calls
v5 tables, with this fixup:

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index cdcfad2e86b1..63a4f2127e3c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2134,7 +2134,7 @@ static const u8 qmp_dp_v5_voltage_swing_hbr3_hbr2[4][4] = {
 };
 
 static const u8 qmp_dp_v5_pre_emphasis_hbr_rbr[4][4] = {
-       { 0x20, 0x2d, 0x34, 0x3a },
+       { 0x20, 0x2e, 0x35, 0x3b },
        { 0x20, 0x2e, 0x35, 0xff },
        { 0x20, 0x2e, 0xff, 0xff },
        { 0x24, 0xff, 0xff, 0xff }


+Dmitry please confirm

Konrad
