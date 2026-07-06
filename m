Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC44C77A9
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327769; cv=none; b=ppY/WF+xAigqkig3DjU+h0Lrk+moWVMuNddoglTLXSjGTLdH0XW+idBdtnZPXKXO0iPf2d2v/vzv7zLPPLbYUJFFVQL/FLRHloSk1/EXeLl5dLLYbxdQyxAt0IzCAqBeNkklyFFt7NXEKF57U9nWayhh0agd/cTebm71d3SX4aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327769; c=relaxed/simple;
	bh=1rV/OGFdt+BIYFKUw1YtYeydtLI+LEeW/ot6556DNQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZkIsh/ZKWULswKG0EHpkWh/OqITcka5DrgCyNQWg3y+wiIwP3Ue0GZ+CYUHMdw9WJQVyFQ7ELrESBu/M1uOztTYHo19lLfRnQsCusi2c7Y7fYisMqGUBqeMQk9utTdpKvu6NcxzY2jVlVW3fDM+3F6DfoQSs504RoQkUcELc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SaqEcrQZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bysIcVw+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SaqEcrQZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bysIcVw+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641TvB3623848
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 08:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oDj+GWBjiBSeF5JpgYDOTVoWkRnCXYhtIDJ7JnjDj8U=; b=SaqEcrQZixh8kqJX
	NIbjiiJv30noknviAqvmMqgcd9dLg97+KHUy1B+DowDAtFZdbHov2MJOyoJff6iq
	rqDYW2t4byAMNskkfn2DEmteAKvkbmtwdfnzzGWPM9pYwk9ipzRkB/unQDpp8wQO
	spC9sxDTJrVufwRQlROqiocRM89e1lPBV1O8a+WO5Ti9EHzSmsRDEWPLvWF6owNB
	KQMo662zF2+8K0WTRQ81OMSHEK20fKVNoKuj+ARZc+lVli3a93Wr8++tSyhr4abz
	mQhBlKRhfEKrta7A91FCOx0fOf8vmN+8cT/qCJhPL0qbIjn1JKUVPpUrlbkgGQV5
	z0EtTA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4swgh8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 08:49:16 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f2747d334dso8439356d6.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783327755; x=1783932555; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDj+GWBjiBSeF5JpgYDOTVoWkRnCXYhtIDJ7JnjDj8U=;
        b=bysIcVw+4ZH26II+ubVTceQUh/BGbUmRY5hmvzbCmoWeoNIDmPF9Iw+RznxsLESUtF
         qIWcG7lLtJyWQJ5H4i9DyAOcBvjA3RAFd+quJ6TLUbwkOgeuHphNNVauiACbkKjFz3PM
         h0G/y9XrqeYR3sn5jN9VKJgd85TdI5jL6FXyAJBkhEZY32wUh3KT8WeuL5nNYtBVAQXo
         JI+76uwVtafQrAT3UA55ubTdrWljX4fygPnFtFZQDcGpycf+Knu3B6M+ABKYe6roUsj4
         b/m7wNuy1t4I1ShYF2G7hvL9kcprkAn10NmvKXkQCaL7M+bLoVTqSrvOlPibf/c+V26i
         4ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327755; x=1783932555;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDj+GWBjiBSeF5JpgYDOTVoWkRnCXYhtIDJ7JnjDj8U=;
        b=Nw9FD+Fg8HEdu8+kPUq8jiPlXwn1F67XzdhWdlwzXmRm3SLJ2Y36An2f/Rws9xrss5
         kwZfWnm8ebMcFUEEoJm4U9Ur69wcZoP2vagRYpsaWaaLBh8+mfEEr08Fs9pcYry+JkDp
         zDFl6YGTCO04St5LFHJab7Hr79KYo95fWiKTegazAIdCjWuO/801UOutoEMJMZbx6UjZ
         17JxZGjsnEqrZVx82ZJjmuwzQzw746O/U2z1u4VYvFfBX1C87LAx+jmbO3LVwZKBe67G
         5ilKUkHITs3ISzuQaA5i8pxd/0H7XNldRTfb+PSeu7/3ajWNGupLhy3nRom0AwQXj54f
         5nQg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5DB7LW7OWJ7IKXmHHPp76byIfoFPco6RBXVuyvJqCqEIGUjdIvV4jWKE2/84p92IHipmRlw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3MtRp7McAesReahf8WaBW447ptUCAK1Dt55YKW1I2SxW5JlBG
	Gj30Ag93q40wcvVlmidT4UxRX+Rv5V1sq1W7L7VljO31A+7LCtQFSL9XZVDmMp3+iZdWVch4V3X
	jMfIofH+gwTdkB8EFVkEKrJPRBBLw0Sm0Eu17GrlPZPYQvuGBworw7Xrzeg==
X-Gm-Gg: AfdE7cliB1o+OqlqoRpIgmTAX1WSb5Pt1qxkHcKSne1DqjCE+GFq2hKQheuD2gxAETo
	J1ZMNtdyeOiqlMT1sI5J4RxNnVgeaVMVGk7wPeh4ldh9AAHkMpH+NI+cJNCacc0+loBdQe+GQg1
	aDXhs60OrZ6frmHe5SjMiGJpMzdJJh29PTtT6HkN6qFFQgh49Bhs7mEeZn0k/1AHPydvaD/Sm0H
	KUMAU7WhzSkq8FAMvwIOD7qNLmE9BfZ6ixI+ITnESL+WDbujbIb4mLwm5ivJvZ+iVuJiJIgvtsw
	Q2cqoG6SMGPar2HDjRTZ1Bba4I3dlYtjcv4S2hrq4kGJVDvrKmeBaIQXaQou00CNWlF3eklnA/4
	f+XZSI1F94qB7G4/154sGQfmlIj1nJQ0+prk=
X-Received: by 2002:a05:6214:5181:b0:8f1:7139:d6a8 with SMTP id 6a1803df08f44-8f749a7315fmr109104076d6.2.1783327755092;
        Mon, 06 Jul 2026 01:49:15 -0700 (PDT)
X-Received: by 2002:a05:6214:5181:b0:8f1:7139:d6a8 with SMTP id 6a1803df08f44-8f749a7315fmr109103826d6.2.1783327754703;
        Mon, 06 Jul 2026 01:49:14 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd88aesm3455501a12.3.2026.07.06.01.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:49:13 -0700 (PDT)
Message-ID: <a4f31004-8e74-447b-988a-e3250859e74a@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:49:09 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX-
 variant register
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-2-c9f1354dbd29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-2-c9f1354dbd29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX9Cotsx0D75Fq
 rrm3CdhRlb1llUT7Mdai2M8uTlNFcgiDRdprIWPUUiBKlZucaUwEzLOQvXPc14CyUOccw7t4mGU
 30Sa8+xKB2tH5z5xe8ZuvB+XRYmyBWI=
X-Proofpoint-ORIG-GUID: 2G-w6shhVAZYK3kkyRfkTEGt8STfwEK7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXwMfJpMDjoTRu
 k67bdfur2ychh4x/w5O6It+G09/Eklnq9JxMGHV1pn9Fj2M2K2OalDXuv0a99pVIP8L3YBlnxc2
 AaRd7LaRDjiIyBwbrcFdNCBINIMuNcc9m53/kYtTiQoPRV5LNQAnPwDUCczH3fpuxMuXJs9qk08
 dd3Q+Ggi2v4VBbtNFoc7w2AdqBjsT0VpczywOovoVmgSeCG2+GuT6ptt+ays4zXhCIKI9wKEKRQ
 i9DCF7ln7kCjhXq6PBvzeV6pvHXLyJPRQBi4t0EucS6l5FQpWIYETbOOsd2f1FgaRzKmjg23dQi
 Bue/AzlTNXpbUn4LqrDpszH0xu5jbSTQDGO24oCJXlxZQDL+T+Zg4r+6YV2gl6EbgQ/HHdqt1cY
 JSxbiThKm3kTSJqDXEzYS5znalW6cyW9w/z33QcgHMwIbty1NITIuQend7fbPflMVboRE8g7r1U
 2Y+aZ5S1QzIzaW+qGpg==
X-Proofpoint-GUID: 2G-w6shhVAZYK3kkyRfkTEGt8STfwEK7
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4b6c0c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=m8Bw7PwqJOGBpySAz2gA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

On 7/5/26 10:14 AM, Akhil P Oommen wrote:
> The GBIF_CX_CONFIG register exists on GPUs prior to A8XX (it is used on
> A722, for example), so it should be tagged as an A6XX variant to match
> the register spec. Widen its variant range from "A8XX-" to "A6XX-" in the
> register XML and rename the generated macro accordingly at all existing
> usage sites.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
