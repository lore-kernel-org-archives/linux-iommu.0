Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6147884F
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327735; cv=none; b=Srl+AYQD1gAlOJXJkbKaxmZk+0W3TgbxX6FikVQfHaBP0lBNDV8sXdFfp2QPQ8A56clZcnZldJp7GYO61U3tsiL4tDeKYeRMQInXl+WqKPatigzpd3yEczOV/iIfjzz/P2OM8b/O6HP69D9njwmo5Bip73rrrgEIOVe9s+dzOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327735; c=relaxed/simple;
	bh=QZbdVd3wDcjbE5HqJ43PJx1XHy6+qgXALVHgYnjvA4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLbiFzJbxxuU/U/RMMroNx8m2/uDNzwImC4m393VLHO2F1xEenwOwKVKMWzSocclIkkHImKEIRGQ8Na8e+UuByr/0IcKLwNuaLfq7jRdZCd7UM9DPJ+d4vefRfivl0ENtqp3GmcKW4WXE8hyK8VIU/b7kLgTP5fzmJnKoamwaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RoQsyK5f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LznsOv8s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RoQsyK5f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LznsOv8s"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66683qg74156693
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 08:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UyCrsVtN/vgWmUocyd2gtWqkOjFDvVdxEkewtddvF+I=; b=RoQsyK5f7fV1iWo4
	SyCXOG5Wkn8sUyU2MNNAjdt+XvirxwPpqH+Vl7KXVFEVxe6G13eUl2I8KVybA5Fs
	bSvo8oIfzknqPfNdnifuLyviUJ6qvjS7+XgDfmJkkkad+KCKBhPrhToiobXU1tIl
	YFdVQfN0zAjEXkvCYS/RJwZyzBnhTM0JKyMah2Xfn8xtenWxWKQbuFKggz6rMm1c
	f7N4t3sUjBejdx8EkRRKelOmwe/39PgIO+IfwWCzvdTvih77/oAKY2UL4gfGdrid
	viv5xUbpgVRpsw0bW5UH4/K4NFST7TWUs7qPFG3KyW7Gj3qOHq9VQRRK1bEMR40S
	50O6Og==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h986bu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 08:48:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c21be5bb4so20865501cf.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783327725; x=1783932525; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyCrsVtN/vgWmUocyd2gtWqkOjFDvVdxEkewtddvF+I=;
        b=LznsOv8sKk84/opaz52ma1CyGfNF9ePxLHU3LpY4F2D7sK+YWzG2wUl6d1gVolsZ2d
         OfIbNcoAjR+VLSBY3wfJ2EZWtiizQRFYtpY9wdfgcJtmNMzWSrLZ2tHmFMugk7V5tk5a
         /v6JSGN2/P8nrod+VYUlQLwM1z2B2BA0E04wvrv5dNaJb0h29oohiOcbWwmOZ5DKmciM
         F9a8mK6x3EFM3YOqxoB18Ivpvr+LYFnHptLPReknb0OH0nJcOICX0RoyKBqaNbSBkf7H
         kHkW0xCk0KKBeeL3VoXftiZ2ccVohnGEucCYuAO2Ki/L5eDeeC/vcvObAacASZJ36Bqj
         GqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327725; x=1783932525;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UyCrsVtN/vgWmUocyd2gtWqkOjFDvVdxEkewtddvF+I=;
        b=Kz/HiqfrdGbd2a0PTG71LHOgUTvsAkx3Kz6KeB1Oxy4sTiBsO8qpv4BR5h1VTDO7mJ
         h+yNxsiYNnqqGSuKrHtKRUqbY/hwMrR0Mm6NTj9lbn3Wtp20RrdDdkhtPVQmMcU4RLBH
         DCwVGieX4AwO50u/1FgUY63L6ApepsSmmZEYVXV5KpFNlaeDcAf+B0aeFcoGKlm4wBvC
         Yg9LkKKv6wYXgyz3FQrvIH/vJ0r7hSjJlkHa3QHgG9vKwo5dLBEow1+YQCckpljDtDVm
         +zWafHMUESub54O1bfWnVzZTLt409pIdd/oAPR9eZvwbKNrR6ptn7JgPLW1127pteQv1
         JKEw==
X-Forwarded-Encrypted: i=1; AHgh+Rpx57u5ndTg8f7rRvUf09YVfHxHqsCwH4CLFJk2HrdXqP5jX8Cms9SvfZ/HzDo/+knni3HJ/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr/QOyWJXKko8JkT+P2SSSMK4KNeloTXmAjJdgXKHdlsLt+Xqa
	5rF4Gv4EF4RRXp0r+CpAj0rJdq9OSWacvfbTGwxc5cd5HeR6Ra310xQorZoK3qTTo7R6NoghHeR
	EqLNE635BSXjESQdoNMbAf0UFxd04E1DfpWS2VMaBt/OJ49+ctJVFO1p+vw==
X-Gm-Gg: AfdE7cmWpYeX3zeYqe/q3QWlQb+D2bZHBGxpf5vSOYTTzeZ0hgTmuWy5kYlxj7u9Z4D
	i0zsI5rTslqmKLlXIMWsPbF56SLvWGK9+EcZo6DbFDqJs0TqiQKeDKXEiKD4DTnjRcK1xKgayWr
	JuwoWjvZPdwcEi0u7mBEfrr8YjTpfueMZ/z1Si1VePa2P+2DRfeHmaPGF2bxFeFDgFRauJs337m
	gwBva4V3/mjM5PhLObMbax9pfJtMfrCzOnPRm7UIO4wIMpxd8u8O9wDOBWbS9iT9oKSyxvAh8jw
	R7WM6ip14WDBnha7ywKcax0J1tBocj4qcj0TRy4BoV4ANcFaeAWnMeUjZBJ1uZK/JyEySxPDHby
	CBmkvmza/gZFOsfE7J/nqjZb40S+2zGYON5I=
X-Received: by 2002:ac8:58cd:0:b0:51c:223:3c57 with SMTP id d75a77b69052e-51c4bf30d44mr87210771cf.10.1783327724794;
        Mon, 06 Jul 2026 01:48:44 -0700 (PDT)
X-Received: by 2002:ac8:58cd:0:b0:51c:223:3c57 with SMTP id d75a77b69052e-51c4bf30d44mr87210471cf.10.1783327724419;
        Mon, 06 Jul 2026 01:48:44 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c2d37sm691730366b.42.2026.07.06.01.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:48:43 -0700 (PDT)
Message-ID: <3208407d-05ea-4b1f-bb65-91afbcbc858e@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:48:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in
 a730_hwcg
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
 <20260705-eliza-gpu-v1-1-c9f1354dbd29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-1-c9f1354dbd29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1dXs6i0a6BhaaW4eyKciPcajyBRWbPMV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXxUB/4/8UthZd
 /fdhUOHrL6mLkE2BIDEX8H5S3M9HoxnHr0SIXa44NG3B2U12BgmVXivOJjVb6C7jO441woeg6jX
 I0CYJLY04r8HXD0Q2QcKFpUlkOk6v7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX8PhsGhIUL6KM
 yR6qtR6AljTM3BrOY8r6Jx+1yXGP1PnhdAUebFz3PadTcOhvRymqdysINoOi+S0JSsrnfD+bmXM
 +26EeqD4q98qHp26nXMOn1SLQ+tWiv+aQL+ZHFJkVGpDHMwvLc1zJq3HkxOOUvxrgpnIN2KdSaK
 kRbwTMeMAu8VxPJaf2P81wzDdHu25SOgcRKWS+YS7Sl157uT1UhsTYM4jS+qRliUYPxq7PZm+Ys
 ++opp7xvrN0b/HRzJJVjMpe5BaZexKrpfpb9f45O+t71ZU4ORznHgFlDIqxPSW+jvvCsi+xjd1p
 mc6ut7xI0p2dshzqP5orsw4UjF8Y4pcIj8rp6TcgpxjrTiFnc+c2kltjoOGNQp1jcefe4dCgEmz
 Cj0ID7niKl+G45Eo/OycFLH/ioPmRCQ+ya50+2XtJobYUZr5sbMYA5VA223o/LXNjS+g083used
 M8WaDlR+xouv/b5psHQ==
X-Proofpoint-GUID: 1dXs6i0a6BhaaW4eyKciPcajyBRWbPMV
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4b6bed cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KnFAnPMC3uCYYmJdzeAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

On 7/5/26 10:14 AM, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> The RBBM_CLOCK_CNTL3_TP0 entry in a730_hwcg has bits[19:16] set to 2
> (clock gating enabled for that TP0 stage). As per the latest
> recommendation, clear this nibble to disable clock gating for this
> particular stage.
> 
> Fixes: 9588d2f860a4 ("drm/msm/a6xx: Add A730 support")
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
