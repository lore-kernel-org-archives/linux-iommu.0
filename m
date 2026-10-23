Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743177;
	b=kInB5ugoqX/BhXSi351mZcYxNvurGSmENW9/tDCkEnx2/5hQKuo792a90MNVEryX5AA8
	 WTd7isbdozwJcegOW7eG78P8RGNNjhz6H06JkVSTAdEb7Ff28rQH0Vwuhvl0cTNI3psb4
	 vusKy0oGC87j+ebOwIGcddW9+1/gPF3ZgfvmwdycyFA+Dygmd7B/9F2wyBH6syybLxjNQ
	 06PyyD0BRGA8VJro7HvRuxbWoaml9FPCVwK1wCUWvE6IjGeLS8kzISbDRFiwrOixRqjVS
	 XNsDSxM2z+23os3AfxJQLzCykELj4yxT9lSx9rNth5xuvFugF0fU/DNwXOBxTuYL2ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743177;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1jRulH/EkPuyO1q9aYJ1vrfBy26MO1RC6he862OqI9U=;
	b=IpHbPICDkbaj4sKvKN5yLUXCjokL9WthXtv+TDlAondSHqAD6H63VEumITIiUoJRROvk
	 xiK5UA6Ce01AcIPfl0feaLuIJCJcEZee2DYCki9BO9V2jUx0gS1MJdY2HW0Oc0mD98VrR
	 TGfOEsSZu5IbEsp7YenLI3UjQmZ6K2gMBl2nQAZeUDABMbR6kQYaCi3vFj9HK3Lt8UTim
	 E4UXo6wOGKe7sWj2UPskPzgnteK3q962XgTikv8webiVOJdbAEzzpe8Ai/0uoUDYZNBcm
	 BRn5+VeBWm6YjACN8TDreMvCyaambV9ZjFYkNkQr+NvPG9D9alZq1242CiZyvpus0RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eyvWj+ot;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R4LSSkoO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4F606A31A
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46E4F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eyvWj+ot;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R4LSSkoO
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F8A22112107
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1jRulH/EkPuyO1q9aYJ1vrfBy26MO1RC6he862OqI9U=; b=eyvWj+otLQ0BXr1c
	5P4DKyOze42qntnvS0GIzRTMcrX2YMQcsvWL4X9TisOmvnlnSgnL/jGkiGrhZGB/
	JM4nCAMccp3ipJsz0sPhTehZi1lstygdrYT0d9g0Z5B/gi+EmIN6ynR9rYIdJQvj
	lKgAuES/X0d+AeS1N4UDPko66iKbUghw1jHtZ9EFSdNSfBsFk2A4Qo+qMDgWuklb
	ltwcxdfe1hf8V0ImNLcu44VH2Iffni5PZ8YCf3QzPrGJ5Hn6PLtYNkOw5RzzeWTi
	M8sZTKvIQXiE6IGIzWyymKcwpKKR0gTp0gZEfqk21r0KQt2qKZ5WNx0DtmkMiZLH
	+ZMINw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyka3sm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:12:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a03834d8ffso1003039b3a.3
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 01:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743176; x=1793347976; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1jRulH/EkPuyO1q9aYJ1vrfBy26MO1RC6he862OqI9U=;
        b=R4LSSkoOgUUAw1Lddl9jzuamQNRwA2GZtgXndk+DVphM0gAmq89Rzj1jXnYX0AAiQe
         IQTER4rQsZ+toYmSo2H/rL82ySWAYkQoTCtsp/8HPMcpPdzoKzuHvGHWUTtMIeoiNerT
         r4qx2EuLtVbkegQqzRiUYOR2j5Et9lMS4HxnvQNQUO90BiCiNklF9u/vqFTlsmRCq1L3
         TiGP6mBeqHQbogeMT/HXA1GBWV7/mZsf4M/0yrd/q4TWTZfwQx6wccp7zr+DU/kB/Lzr
         DVzbDiBwVuKR2oEcjLqS/Zp25p2YaQ0Zs1BcwQhlA/T/4h03pSRCQ3y+3lYQPQgJAfp1
         ifAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743176; x=1793347976;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1jRulH/EkPuyO1q9aYJ1vrfBy26MO1RC6he862OqI9U=;
        b=IaYE1bVkcA7nDHdwE1eO4it0WYg/JrIp7XBeeDI5JMz1wtQxWKamrRrsWWv/jw2Gn/
         CionjkV6robnB742dWZ2mNwlOu7MBd05MXBZFb/hfOT5vPpK1BUs2zhJiGxo89r57he2
         vOkMA7Lw0SV+/6kCFk6R1T/5G07RAu5I+yEXhVqRH/ZsXSfgehPjZyfTMkRMutj04uwt
         C6kZOflKByjUOssoVsqJKNpJct3bjnbWR4czKMsQHzW7sUyWNRlsSfCK+ypweDlFu8El
         YirUFlE1FwD1h9leKwm3k0u+QJ87akr993uZt0wlndWfLoaYFXrZemPtV/e+wYdJrwnJ
         VSQw==
X-Forwarded-Encrypted: i=1; AKwUvByuxdQUNgqILD73YH/0LcA+7kE6ntVjvViS26eyrLk/jjBknhv+aFKvgPllWSOn7rIluGQMoA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJjw31zkFfuJzy7Rnmr1i849rugd0NoIl6cIZS2WWQEzFHP6N6s
	9Ep3at3EeM0mRiMnNGxpQc5IHdWPC8emDn0y2mdHH2YpM0JTD/ozG95UrJeqqDY2rvKJz36zvQQ
	+oi5rYp9JGFTTY6Itr6ELFAbAeKRsWHeuBLSVkvg8MzuifXry/Qk5Q1d/UgyO+hMcqqDC
X-Gm-Gg: AYBFou0AhDPylS0TBYRRHdFndl8QR0zx0ishdm5F0IdvosAgFQQ18bLTCulWD4uVI1H
	Y3L/63ff3whqzsW1+TSDLpLMhszAzHZHj4Fnd54GPZABwChQpxjDDMUsXufYDERt5ee2/N8O0S5
	gFZ0WUJOVK3l3ly+7NxyTVbIM9d3kpT6Jux5eUaShasNVEU5je59tvAnBLktmGEwCjG74pex3bU
	m9eiBDxaq+T4GLHI7sX4Y90GWcVm0MPloRPLR0H42XzV4qbJHBQF3+0kWG3DlTOMW5laMY0Wzz8
	WT0CIZcFDyIYOgmUNuaodZVern0vyfz3UMeYwKqAIlVJENwiJspKo78p67NI7GX3KXZy8n7PAQa
	VgdmZ8ilkmSYmGKKVmP5T8trLBlTmB6NVMA==
X-Received: by 2002:a05:6a00:2d91:b0:8a0:21b2:7c7d with SMTP id d2e1a72fcca58-8a2c472056fmr1403988b3a.0.1792743175963;
        Fri, 23 Oct 2026 01:12:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d91:b0:8a0:21b2:7c7d with SMTP id d2e1a72fcca58-8a2c472056fmr1403965b3a.0.1792743175484;
        Fri, 23 Oct 2026 01:12:55 -0700 (PDT)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a2c797b685sm455376b3a.1.2026.10.23.01.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 01:12:55 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <c7bdcdf2-1fa4-42a5-a89f-689e688af5ae@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 13:42:43 +0530
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
Subject: Re: [PATCH 09/13] drm/msm/dcp: Register DCP display pipeline
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
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
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-9-48aad0fe4f72@oss.qualcomm.com>
 <64603812-672f-43ba-9c5b-783d666d0ac0@kernel.org>
Content-Language: en-US
In-Reply-To: <64603812-672f-43ba-9c5b-783d666d0ac0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX3QsYIY4qsWd8
 8O17Nn15xHFrZ69OCjXG7XOYnqluafOS4x/jruxcfRntuTTWontoeCx1nU0Id+oQmL1N1eNVD1y
 NA+i5I3BunqR7zuz/+7VI9MWgKoZfRflBHx09R3DIC2VepTKnPQXmg6iLMvdSirJV+yelgM1eJJ
 8wvbFv8ze2eaNU/8f6wVQ4allj+vx9hi9JQ6AU1vglwrEl3R8i0ybkYz9uRyJ2SCuwOQbTBj2sR
 EdwZZkjq9NmXNP/tWFuAvtLmM5k1t+hke8W8aDkzN6GIrzBdqHwmlFc1Ri5fBHcB/X0FuRHEVVi
 aR0iUPeDRdAmy2igo6Ru32HgiBBUDvVF7u9ZvKNM0NmmYhvMU0+aQFzas8ZFxaXfFAHqKN6cq0v
 1GgaQ9EQ4fKFN74NtAV07Iph9nQqXK0mwBCl5jq3rCeWYmTLERnAIM6IGFzwh7ETPRwdhrp+XUx
 hp6K3pHTdA8zsHy/0MQ==
X-Proofpoint-ORIG-GUID: nhVphclTqNXPY9HuQrwUz_ZQg62WZTZD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXwkoPe+Q3zSkc
 0tGPNI9KB1s/S/u9tVZvObtDA+4WeH+v6c+2I7OLGvWLcztqhttrHKS9+3q+JoEYV8Xy1W2IdVw
 mv5S3VKLbRmF5o50fGf4CBcJbs5zub0=
X-Proofpoint-GUID: nhVphclTqNXPY9HuQrwUz_ZQg62WZTZD
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb1708 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=eWRtYoRFSfl0Epy3KhoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032


On 21-10-2026 17:35, Krzysztof Kozlowski wrote:
> On 15/10/2026 09:38, Jayant Shekhar wrote:
>> The DCP firmware exposes display resources through capabilities rather than
>> through host-visible display registers. The MSM DRM backend therefore needs
>> to build its KMS objects from the firmware capabilities and device-tree
>> display graph.
>>
>> Complete DCP KMS registration, including power and IOMMU integration,
>> capability handling, display-graph parsing, and creation of DRM planes,
>> CRTCs, encoders, bridges, and connectors.
>>
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> Assisted-by: LLM
>
> Your tag is the last one.

Sure, but I notice there are checkpatch errors, should we keep this or 
remove?

   ● env: :3: WARNING: Non-standard signature: Assisted-by:
   ● env: :3: ERROR: Unrecognized email address: 'LLM'

> Best regards,
> Krzysztof
