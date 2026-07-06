Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9333F65EF
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336188; cv=none; b=NmEH90PBw4YENy4UpTbmAabyJ/Y5g5QDExUV6Ipd+X065Of148prf2lmmQ+LaedXJnzo30cWHTv9DjpfA0l8zEc5BZZmZqAiLbNFDOQA++5NvgEpp7GCZyUjsL7smuITKEzCO4Nj0k673B+0HkTF09nEeYDwgSHcrVLi+AxlQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336188; c=relaxed/simple;
	bh=hUL4WYPSAJ761APDkAIw4UQvLSCj4JJeRyBGiBBra/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5nH7L3dYYMmZ1uYu9Ar8CrYaubB0tm2cjQcuu+V26HfJgHP5CRmo/SU0EaCVThu/2wnlXy5R7zIiS8SqCkQh8Gonzo76rV9d9nMT8eytN6Zt8uwVlwR4aB9m8moVobSO5lP/FeHOBAaeDkm1CH+CM3azWC+XCLRN78d1tPY8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pX48h7Ta; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JiU1SmVP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pX48h7Ta";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JiU1SmVP"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxOPp369506
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 11:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OfCbzrTcTzIGJaYxsh7AivF35GEsErrQAAwwonLRtdM=; b=pX48h7Tawms+LHRc
	QZc63peXyBM/dHemiteAjFnn/Dm2atMcCHHtHjAIGSpEwCzEX76VoWqNvieJ7rMj
	jhuLKOBhmpaOeHAlo947z/JyekqWGxbqJGELhYB7aQA33Ur3W4V81uTtJuQt6aUe
	/MxPQB6y04jxto9wPJ01Rgrks3cr9GydohIvzflZsmnyRbMnQw7jtzRkiFDuO2i0
	o4XEylXqicGHOBXUX7bspiKuK0uPsI9/0CDU3rDpVvoFSZJx8iBq2eX0+T5ex/dL
	cDQSYLJvAwrDYvPQOzv+bINABbftfw0HftfrJn7TStgNXU9IsFNkO1wHHqQxsbyO
	gqyJ+Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h98r31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 11:09:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfa45b280so7956111cf.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 04:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783336185; x=1783940985; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OfCbzrTcTzIGJaYxsh7AivF35GEsErrQAAwwonLRtdM=;
        b=JiU1SmVPexjdXTMld3mkaa3pcq3bOJl/QWXIzrf3++rb8MMw/NwYmfFdpvj454cycs
         un+jxmMVWWJASWs99HZErSsOEwoLOQ2L2w6Bp9CZ8hYk1vBBahqSB12PmSzeeveIR6b+
         3IfLmlVgk0HPodT28D/S4RZ/ycwydkbWXw1WMcVdBAe7KRS7XXkRLsoOVpm4EQRg9V0G
         McRjizWnR1gqbbeVVkGtxUUKNEQa9PIz+IR/SlFB0dW1tOLNHpuWmlTJuVa0cLTfWWrJ
         OiUlyyvcVccDmh+woz8VGLdQ62YYx5SyWRwi9AXXYNcFjO5SwirFbjiF0cDYfm/0Qtlp
         kdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336185; x=1783940985;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfCbzrTcTzIGJaYxsh7AivF35GEsErrQAAwwonLRtdM=;
        b=DGQYzk2KmLd4XUVhLtglrZwk/vNIXflk71tJaO3csI5ngYYXTivzWQKf7HGEHsmw2o
         SBNuYnRdq+AdyUWQpuSQ3qQ28zywE7xiY4ruG/gCVxiHpDHkNUMUfSscPgCKMgydUAk5
         Pgyg5wkhRj8Zn9Gj7mbaDEqphbgC27X+DgoF48sNOMiWxO+x+mJ+D+fu4yQNIZV9zwjp
         66+eWQQ0+meVpMkDsnNzoH5gueeLc2T1sogUdUl7MF+4+42S9l/AvGlFsQuRic7cSqF2
         /Rdf8VaqVjx0uTttY78CJ0ExYmSLVN6fvc5StGJpGVWfaWHZYG3K/POvLF+cGnAtb6Ap
         KU+g==
X-Gm-Message-State: AOJu0YzGYUyQ2+VfTw7rBeOi+pgQib8Gd/D2hSWPHQ21bXE/64mB8kcG
	H67knW0fPVKER9N+Y9ZbHUkVDMN6VXuZvMirnhtDhiuUOSWAP3ieBtgNvPgC/1N+qCI8OMrRlPO
	xCVa76S8FE3/zCJlgIFjKUCifPXJB/dvUZaxR/KOkwaRvzgVtfmplZOrblwkFO31vyA==
X-Gm-Gg: AfdE7cn7I38Xle5w4//qFzJbgiWDU+36z/m2H1aOY7N1tAJPZufqSnNRSbywSeNtLUe
	hMe/km5VVnUpu1hA2u4WQsaE7+9QjxfGKKnA99D3CenddkKpvlu3Z94/WeZp6zTHES7Yaq1p7qh
	SgYc9INeJjzW5tdKiNMR0qqjlAu3xOhI+S2wDbMQZFyjp75GX7ucPbuMDH+F1FGjHuIkTjOq/Us
	ms7pO+jyJY33r5Uqc8qX3/YluGT6JE8xLtDhJQcqaB63XO3GlgPeBawO5e8hSIsOSgprttRXi5t
	Z+4eHfhfKvAfJ10X8xKepHpDPmA2uKM2kx0UmKO5E1MO9qVOCoxydDNiZw3fltKv9h9uEUAAr3I
	Dm2YStcsBNdW9uV2+ydpIvTaH6vkBDXOj+JM=
X-Received: by 2002:ac8:5d0a:0:b0:517:5d21:9899 with SMTP id d75a77b69052e-51c4bdf1baamr92273061cf.5.1783336184818;
        Mon, 06 Jul 2026 04:09:44 -0700 (PDT)
X-Received: by 2002:ac8:5d0a:0:b0:517:5d21:9899 with SMTP id d75a77b69052e-51c4bdf1baamr92272611cf.5.1783336184315;
        Mon, 06 Jul 2026 04:09:44 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c4b52sm721233166b.47.2026.07.06.04.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:09:43 -0700 (PDT)
Message-ID: <13522517-8e40-436a-b6bd-5ed5f68f1da6@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:09:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/13] drm/msm: initialize LPAC ring
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-10-01d50c3e0c99@gmail.com>
 <93b78299-866f-4a3c-9423-a990d9a7d4cd@oss.qualcomm.com>
 <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jFDmoFubkKoJTIjC1uMfxpr4cpswyXR4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX92/948KorZIs
 fCBN/5Tl5Iilh0EXQ2Sukp43dYyohD32XGj0BcaoLfOguRJQHEJIc6d96mjrHXnPzMIPevLLyv8
 h7BszKsthlGvd0KTZgh0DcFneRWmUNM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX18J/4JlnII+R
 0HhZM0mUmavJT3qnpdCOfXTAgk5QVJl/LWmMr5NnyVkSbL61u8Z4kOPQ0GUzZrW1alpimpf5EXW
 iA6MYGtSWFB/tb5SoaIaFOB89eR0O7LGbgc5xQ1mnr/OgTuc54n0FIwGzmP4kBYdCtp1no3M2EC
 TNIlvGUdcGAp4v3PeLVc0bifzO8L8D6PM2n72Z/g4RjSQmbYzlhIXuL8FJiLnKB492q6PS3eqyO
 gAvmJ1DqXud8w+1mi5gwB20kHBLIKZVjwVbjANMuvErXGWtUd49o9Dy77pckp/bHN5Fm2113P8J
 v7VvgBxFOlVNPfIiDDh4FOjY2NR+/bA0MS0RrAaiJ0p5BLZKIHT/EKARgiNIt+HhXW5qJsnugWn
 RsB+dw2l1Zg4Y660qJeNbP0zIQ6g/uISZMh4X7vn8L1WAHQIizGk9TG3X2D879nONhHpagphwiE
 AX3CTL+DkSUji7i6dOQ==
X-Proofpoint-GUID: jFDmoFubkKoJTIjC1uMfxpr4cpswyXR4
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4b8cf9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=mx_oZ8J27MAni7-wUjsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060113

On 7/6/26 1:07 PM, Anna Maniscalco wrote:
> On 7/6/26 10:44 AM, Konrad Dybcio wrote:
>> On 7/5/26 9:13 PM, Anna Maniscalco wrote:
>>> Program all the register needed to start up LPAC and send initialization
>>> sequence.
>>>
>>> Additionally, now that the LPAC ring is live, make the code aware of it.
>>>
>>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>>> ---
>> I believe some/all of these writes need to be guarded by if (has_lpac),
>> as many GPUs lack these registers and there may be side effects on
>> others
> 
> That's correct yeah. I'm not sure what has_lpac should be though.
> 
> Something we add to catalog? Or checking if it is a gen that has LPAC?

'Generation' is very much an umbrella term that we can't put too
much trust in in the feature department, kgsl defines it in the
catalog, per-GPU. I think that's the right thing to do.

> 
>>
>>
>> [...]
>>
>>>           a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
>>> -                              sizeof(u32) * gpu->nr_rings,
>>> +                              sizeof(u32) * (gpu->nr_rings + !!gpu->lpac_rb),
>> Should we rename nr_rings to something like nr_XXX_rings
>> where XXX is some uarch-generic (i.e. not SQE because we also
>> support pre-a6xx) name for the main number cruncher?
> Qualcom calls it GC so nr_gc_rings perhaps?

I'm not in the right part of Qualcomm to know, I'll let others comment

Konrad
