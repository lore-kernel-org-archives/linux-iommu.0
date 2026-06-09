Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7838E5C5
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996794; cv=pass; b=o6Rioy+J9sGagc6j+aO6FsdYB2S7CyErqM9KTpNkTAR74Mt3MBiX/i0pZEDLuTHfiuwpDjrMANG21HwM6G1IyVg4iuV9hOOc7DzJCeWAthICzVVL3d10WnrKWqPZ90Ocxo2zQ0ieBtO/Zxjc0LKGlC+tpKe5Czkap1F2FZb1/FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996794; c=relaxed/simple;
	bh=oP7WSlZ6SD3v/Z5o7bIIkwTQmbLscnWGhDdc31wqEz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAT8AqsRPtxzYcIJTfs0WzzkuuGVHVjPZp6lC3YuSjhGoqNjg2armO+eGOLWNp8sK7VmvSq3irk56wohaGqwE0rLJGV5n/crrV71HspvCELrFf46N74GoQ9mDkF+gegyP1vRFnwd/4BBCTzBUHBnbLTkGwloW73Dvo+9cgEQnZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSzRjhch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T9+4ODzW; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSzRjhch";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T9+4ODzW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599Jkdc2223123
	for <iommu@lists.linux.dev>; Tue, 9 Jun 2026 09:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oP7WSlZ6SD3v/Z5o7bIIkwTQmbLscnWGhDdc31wqEz8=; b=dSzRjhchuv5J+lA0
	VNfzn1g/9zxFGeqrtj10w6mP+5Vx15ppW68zOAui5kM3IYYYrV/FVdhtdtFjAFNw
	Njo90gM6dPM/GInzXIdglHf2hVk7m/0SsMXmLLN50m+xjjCceihnhGAUlzr7AMtR
	fkz+GgyVYr3L2YD0dF61q0U1D4Kg4JHF6Qlk5v76WGgPnlfPZXMQNKfBLBkUAXVN
	hlsViLtumFWLgxE8/G9zq0IT+3pq3YbcwZ30UlQNaQ3FLXC1Bg7SreQ0tB6IPO6Q
	+uJCXUYqB6O93OSwbJuHpNx5SKbI/RnTF8kpSvscvF1oAfroI0Bx09Ns+492qPd1
	ICzikQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3v000r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 09:19:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915b3587972so419501985a.2
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 02:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780996791; cv=none;
        d=google.com; s=arc-20240605;
        b=FRMEFBHnwVTsMq31TiSzWhSBrQMQF01jSS70suby1P/Zpym9txpMg0ieo/OkCCtbeN
         DUqYHXVnJParB6NRnukEwHoMui9MZqzV3WZ5hakZ5vfXnHyH9AZPlWnX1AcBlCt55c/G
         U5slMSm+Y99MpWmwm7uQied1/C3W8ArG7vByBkMegP8U4guj4FqzWwiV9DD8YHyz8ZCt
         I2867Gt8WX36ZTyYtQ6cmN4JcpCqdir/YmGmxziza6ih/O/tkwntcQ2UIxBYkMvOrTuQ
         KFg0d5Ddt/Rtqkt6f4yc6SKxvLhZUZmic45KRI1pyUEzgnTZKsVX1yGrMJ3FBjqUth+o
         5eww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oP7WSlZ6SD3v/Z5o7bIIkwTQmbLscnWGhDdc31wqEz8=;
        fh=wrz6zd+jk8/IUzmbSGNHD5tb83WRDiHeK0zQmFSZTZA=;
        b=JIlhr8T7w2UPzMoRI8dK6t57+E6yii/ISxd4R6YO1dZGXCIxjT+qbOsRuMeDbLdep+
         8PSbNsgUgU3g+2AP1WuZkgFTUPXR40+CNDNB0ohESnm5/0lNsIF1kRXNgDtqF367xYxU
         vmHriBlJGn6fzeq6sgmdrxlCQRG3jTukyRL8dH32uMRs6Z34dM5ZE2wQs41QITSMAvk+
         434+QoHpLJp35AzbZkGo4Eb/u+qFlrzyELxldmUn2oOZ7Frc+63xoe+7Nc/YiuTAf2eo
         WuR9i8GRlED4zZ6UW00spw7r1OrDkgplryr9WHJBA9UTumzibFEOD8V++STvCk0OMmG+
         FaGw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780996791; x=1781601591; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP7WSlZ6SD3v/Z5o7bIIkwTQmbLscnWGhDdc31wqEz8=;
        b=T9+4ODzW38Km7mIC1u8gp9gJ28r1pqKfCuRwI/TyxMiPUNwULCBQIFQFghJruki9HI
         N2Gs5cwjyS3R4G4ozU8ed644IoCZ8rg0sjYt9EdXMsSmes2IYpV4GXDQAi/peW1+Posr
         Kt9dCLfD8alt1XI5lXYlyGMeCb0IYwwDUIg89zBdcyGi4yzYYtv2KtC47SmrsVhULy5K
         lQ/KSCG6knCLmKTwaLwjB4YMDfE60hoWDAKruGyAXVE+dyZu0r/kQ94XereUNrDQC4Cw
         /13jt6/J2wfporNTfiiJ4AzYyt/01JrcM6+uwY5lscSWgSF34cy9VPjisji/q4RZRHX6
         2Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996791; x=1781601591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP7WSlZ6SD3v/Z5o7bIIkwTQmbLscnWGhDdc31wqEz8=;
        b=iN7gCQkROdQMj8l5oU2J9Fona8C26MMRdh4vv0kueEFk2L+JNifjnXzFMH2WK6bSV4
         p0XvgWYVQMjqlaAH33B2dgq4DAuSg9Om41DCR9PVvAJ6lRoN9uShtdkbeuZKiQvXZtFj
         kXTRhmt496ucqVYMU0RFfeSTRNWB41eL44Wl/ZRynd43sU6ly8TxMQIwkcXIkJk4TG11
         TByWbwBFmGmMC7z7ndHGzUQ8N2puZZlo4HOVM+TahozksEt4fhiHiD2BFnQgMx9BKwkI
         O5FB1lfaCCOyRXc/BK9v/WbtpdY4ltVuzSbdR5Ud2Revitz3xkGNnVK5yuM4x+cMYbU1
         rq5g==
X-Forwarded-Encrypted: i=1; AFNElJ/QMBW481cHIjoBok92kufWuRtsp7swwF0xCohK0iWykI/neb5PWg+3TZ1xx+kf9o1TwCUwkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfOUN4pxKGRLPzcINQiYvtLWCdeXrxK9o+wwTYB30bs7Z8gMLp
	i4GGZttkF6Awry1AdX7Xguqvn8p25uo4WHw969sdVVjbgYF55ZuzI8TQVVeEoubBaelNaZso0MK
	LjCS8KamchAVdldVafaARuStyC3EYvgXCedqf8QWB4ydiel6E3vdxQ5beI5XkiHte2tiYOJvpyZ
	2z+B8J1wgkp9EjX3MtdfLmfHk3/PJ7QpZW
X-Gm-Gg: Acq92OH+iNThDENUGh6pTA+RCGJrP7b6o7KMt6vQvBK5uL4lBTaDv7LQ9dGwFvpbdR3
	hcXX4QonSUOjgT+4vTYplJotp1lK9FTcvhBT5lh19A/iSvbnlmOtfW5JUFkSxx+M6mfFcJeoSBA
	qclDsWcuEbfYvxNHIHUO+77Wx/RHQ8Bm8AJWKQKbF3M7IFLaNd2np37L4rjGbVEj5m5vlq7eVGC
	oIa1DhccKmIglnO03xwhvMUk8buSeLPIcrquGR/B83Vb+EKu+vsUDk6H3Jhak1GdlueZWEHwpaE
	AjFWyvwWp5Wbz1xOwZ/jx4+oN6g0YSt8
X-Received: by 2002:a05:620a:4590:b0:915:89d4:df22 with SMTP id af79cd13be357-915a9db5d00mr3035342185a.50.1780996791269;
        Tue, 09 Jun 2026 02:19:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4590:b0:915:89d4:df22 with SMTP id
 af79cd13be357-915a9db5d00mr3035339585a.50.1780996790847; Tue, 09 Jun 2026
 02:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com> <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 11:19:39 +0200
X-Gm-Features: AVVi8CejLh9w5S_OQ6YRu4HaLtjG5GDBpmdR78mQwKNwD0qnxyg2L6IjHLml8Xs
Message-ID: <CAFEp6-3imORRS5FqjTMYV2zOn+bpf54uwhf7Fy_4-uTDadtAxQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=St6gLvO0 c=1 sm=1 tr=0 ts=6a27dab7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=h5pAuauRZTFNeIU57NgA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: yjNW_477cyYUUPhdeJxsM43qv1vOrqmZ
X-Proofpoint-GUID: yjNW_477cyYUUPhdeJxsM43qv1vOrqmZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NiBTYWx0ZWRfXzeticLw5G8NF
 s3HiXaH9eIgOwEXoomvO5J/vOvCjiGXjMrMigAR4hPNPiAaLFitY+VqvCUi4Ap8s2jtULun2hiV
 4x99RAFAQY1+mQruAILams3sbXOgKvrQKav/8looBT+Waa6CgPDc5rfleh+u2MFpiSqLd5nC/0b
 f06v7Lr9FpdHyZerLA208rEWbPOaGjNgcSCB4cZGWJcZC6nH2qg1TS8g0qaek2tLc00jU9wzLD9
 aZikTKz2wkYy7OqT0i9lYLMYvcfRWwpwXrSVNH5qBPm+4tnZCIzhZ10njgLu6DBQlVX+NkNYUKN
 1Px5tA0z4k8MxIpDOKKvPCY2n73jE4BEJviwixrWjN+hcuLH47Lv5qb/ZJiihW54i+SeUNE9jRP
 w2r71Kb1S09EJ6bxgmXWfmv+MsRbUb9+PLeOb5GOsEbvl28m3p5wPS70T2mKr7no4COgp8uKwrS
 rpQqb2hekESiZ0XKacA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090086

On Mon, Jun 8, 2026 at 9:02=E2=80=AFAM Nabige Aala <nabige.aala@oss.qualcom=
m.com> wrote:
>
> Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
> the existing qcm2290 bindings to cover Shikra by adding fallback
> compatible chains for MDSS, DPU and DSI controller nodes rather
> than introducing a separate binding file.
>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
