Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C112DB794
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374985; cv=none; b=tZePxctuSY0fWh7ymNcscyte8BD3qR8oCJTM+KeJYCBAScfYzeYJiUB7tLx+dzp9r5YS2ttkL0L5bGOWR3Kr4KOYO4qO3SNLRAsL22Zqx0a7UdEgD0MaXWIV0SEuaTEKmXOK+VwSTUMN4cqoeyaCuzQ3fTKJJv8K8hM6+NUtG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374985; c=relaxed/simple;
	bh=UpO4tKWLM6NpkjaToU5bkuiwbjykqdoA95uxnkZptHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhqkvK8nJK8sZsbo/2EhsFQND9pAePJm9vRAxIB0wFGdeqjikP7jhLdlU17vMWdhMb78Js9ZJKRJ++rBP4dVE/7twm/uKkaz0CGqAhhhRETsU2vZvjUjVMa0ezdwjr26FbF+lLCOKvQs6SKJ+CsSi+tiYizT2kNUk5BzG9HGd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSlxawR/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uh96mipr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSlxawR/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uh96mipr"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KF2eT1506341
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DVdlz/AoF+GYHSUtVQ5knwxf7V9QHtqCyB2a5fsaD8Q=; b=aSlxawR/BBrrsLrp
	S3V4J3GgdBLFVH5XsOppLOymMo59D1CcyK+MsnVve7Xg8I93VdIAqy/Rb+2vPqjr
	qo4uc1b5gPUwyAagrMaFTdRWnCjyA8JXRU+Ip7WGUxq8dXhqxZ8ljDUCSvgRBZHc
	v3HN1fyYz/aBTB9jd9QYwx229j5YIT9hrUHTIniakWSL5de1l5DDGqjbFPPB0Usy
	ctjuHWEBvMsAIi3PIFQrGdnIRUWKEPo82upPFGkhkapz+jPJK/YB7Mutu7vmLS2J
	uXtkmaiJcgYuLaMCiV4VSNSLtKM1svV0ILMYxrVktt+/zD+eGP7+rwJulfaj8iG+
	vbvbfg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98jy99-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:56:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38127ae6b99so26603a91.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783374982; x=1783979782; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVdlz/AoF+GYHSUtVQ5knwxf7V9QHtqCyB2a5fsaD8Q=;
        b=Uh96mipr9e1es1KEikK5VUi4ayltwvqk8osbyKOaQRdQBT079sbKAVnzTDphh5et6t
         7jo5qvfIPGSMMQTTegOr5SNJ02IAp6JqI7j984nBbfU2dhqrGKX1WFwTjxJvzxGAHQG4
         rSC6sqHrW7LkWMbF5cml7L7HSVM/Z08WFhhXOFPO0/jPXz36dbPQw1PeC6bg+BcFXUvj
         0RaeblYvz9b1nS77Rqf23MLCz2j7WSnoUUcAAuRvR9EfY0gjAzL0dHmRyD1TZTbFJMQN
         nJmRkTFjswtXCApSIaEcjeZRsYSOwWq3WcU6cOKYpBQuHd/Onz/f5lMRTkm3WiNFU0nF
         Jxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374982; x=1783979782;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVdlz/AoF+GYHSUtVQ5knwxf7V9QHtqCyB2a5fsaD8Q=;
        b=VDuywgDklAhZfBc/V5pqmjRndKN3Pp0RvRurHswSS738+3cG3mFaO6h19bU1NSKwgD
         dbX8gXlheQfA0657gwQjxry7odsz4e6phjp29n/mKZMtRSYl2muKmHyCZ03bRhMApoJN
         w5uriIkYmL2ttm9dYzs9vbv9XVlg/zzLKkMDxOV5ajFHyC9ixyEMH+TLDusHpLFDtna1
         IqhJTVar3HRA/D8suemVb/L7YK0LmunwsILGYo/J1lzPZZFDRMkD6dBIk219DfwxJ4iP
         CVRGeCuNgTwkiCPsYFpG3szB/I3WEGHX1EmDmx+4YGpZ4hNYetR5HgA2uF+V8y9nQ/0E
         AjDw==
X-Gm-Message-State: AOJu0YzxWX+YDT2oBJsily3tX2vp4AYGEXzIO1LI/AiQTot0pdnzwVRy
	IxCxrK7vhy//TSytxUHpP5MKDaLRq+5GSi6tAh+0oS5LaOfytA8XhdM4kmu+FeI3Qab64vQpnwD
	q/8gq5XG8n+r4Hv74n/tywcGMYj5tdqgs5yXSpePloYjo3hJKlbeJBQ/2QA==
X-Gm-Gg: AfdE7cnz9S5iJdnsdyZGQ4xueWDEau7T0JuLjmsVAzVd6ZFajwzh5YPGGTuJPsS7fBs
	MS5DtVkIX362zZegNaaGlPFh+Fj8O7z1domR0NDMJv7lOp11ufDOudT05Wl/5fUMamgiWBGHucL
	hcso1on3S45HdIwx+sxvtytTsmfJVFMUqAHjyu6tLUg37RX1kE+fSwOkfyENqDp7jx7qPh4WV9C
	GwtDJc3hwnTo3AZwdF7Q6dZ/XtqBl+sDl7fTaVq3N4LqMsKQrerzkYJ4O67PTDGXjFEaxxzs3bO
	ena3trjMCbmdXP01RjO42xfkbEA7yZNCGoCc8D4R0M3i+4e8T7O3fSwsS7MM/mLSHnDObb22M7g
	8ZO5QaKEBOm1rTchdgoyMbPn5RHblg0J38lk=
X-Received: by 2002:a17:90b:3a48:b0:37f:ee3a:12a with SMTP id 98e67ed59e1d1-387d6b978a7mr102071a91.2.1783374982391;
        Mon, 06 Jul 2026 14:56:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3a48:b0:37f:ee3a:12a with SMTP id 98e67ed59e1d1-387d6b978a7mr102043a91.2.1783374981910;
        Mon, 06 Jul 2026 14:56:21 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.230.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311748394acsm762251eec.8.2026.07.06.14.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 14:56:21 -0700 (PDT)
Message-ID: <2a556ca0-d276-4c56-a44e-9d8b92a3af6b@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 03:26:11 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/13] drm/msm: initialize LPAC ring
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
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
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c2487 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fsdq8dFr2Uux402FS9br8A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=mx_oZ8J27MAni7-wUjsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyMSBTYWx0ZWRfX1wacqFaGdbGU
 CDs3xA9jsWZ4aohBugsyWHbOsiz+pdxZVNCEVxNHujRkgOyMFCO9cVPy8/BRAabcj4rg1iuCMhz
 NJJdw0U0rccNvtoHZUCwbhPTfOaMSycpdRx5u8U96vRBx6W3Fx6GiuU2/XHHU62GNXbSFRN8aMK
 XNPtc7gv4alIe1g2THdKTOjgOntRFaa/MoalFcTtHyhnfabPGRViCkr31x9+efv6zpb9d+pJd/H
 4OV4fqP9wEFWTQaXCgM/tJ3pl4bzXpkiTW5kf2o1vVWoaa7BId4O8WNYYzeTlQt0P+L3CWJv+Bt
 YXEzl+j1mx1TKgHuMlKo76JATsFFKsAnumLDv5+1ZewXBzDADcdbE7ehx4Q999N883owjuHRhL9
 oHpZCPjfjsnGakzX+WSm9DFP4NEMHUTboregxnnGoxuRRWI9l6Ya2r/KH1/NQ2JoAmOC1TPmnu8
 v9cy9uliQLtsNF8LM2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyMSBTYWx0ZWRfX99Ab9agfcETP
 GLkZXSali6+pQbq7tpT4tKFmGFTA1PS66LxwDVFxPLogK53yA+u7YcNLWDqshki/0RRK9QeZ+e3
 jEmRu2nVhoKFmS77WvXRcsNUovOo/WE=
X-Proofpoint-GUID: NTWdu3VZaTN-yigqCXlCMOw4djw3Gv7v
X-Proofpoint-ORIG-GUID: NTWdu3VZaTN-yigqCXlCMOw4djw3Gv7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060221

On 7/6/2026 4:37 PM, Anna Maniscalco wrote:
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

We can introduce a new QUIRK (ADRENO_QUIRK_LPAC?).

> 
>>
>>
>> [...]
>>
>>>           a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
>>> -                              sizeof(u32) * gpu->nr_rings,
>>> +                              sizeof(u32) * (gpu->nr_rings + !!gpu-
>>> >lpac_rb),
>> Should we rename nr_rings to something like nr_XXX_rings
>> where XXX is some uarch-generic (i.e. not SQE because we also
>> support pre-a6xx) name for the main number cruncher?
> Qualcom calls it GC so nr_gc_rings perhaps?

How about nr_gfx_rings as those rings can handle graphics workload?

-Akhil.

>>
>> Konrad
> 
> 
> Best regards,

