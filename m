Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339B35C196
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958163; cv=none; b=p+zid2hzIH5ZW5AuY3q4ulUDkOEmgJnVqqg28tJObNDu6TEgPGdMiPzQQhH/P9U7D9WY3T2ZN3CkTHKM+C47sPUMXElZmxdtczCyxgoCIJ6HxbZfvfghzlO1C59xLGQUCYZsTBM7LjAYfw75DpWcXfzASKFnlV5SvUbyoOVFBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958163; c=relaxed/simple;
	bh=WyCg106nGKR6N0qQgLVpFXQ3QrbcvI3T9MBEnnP3Uqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpu+siNeJi+zxNFTN3sr+FgsFiDDIScFLN5sJApt0qzPdpeoaTnUwklYpmk93ZxoqkcpEXAqMAeskQnodFXFI/0S05AcMkX4oJj7V69ztJbty0pSydE5yU6RpGFXFNjSWjNihSCkWTyBrIoFaxM9+wPVLDXEFDHAJUYzVZ1XynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TkGDZOum; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jhh5yGU8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TkGDZOum";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jhh5yGU8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099N85c472749
	for <iommu@lists.linux.dev>; Fri, 9 Jan 2026 11:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BVW+etPTwHng1TzFtm9HNMleUWiaF3BSfRIIx9dFhSU=; b=TkGDZOumltMRFjsF
	ICltrjTdVAFUG62nJ8XJen9TX3bKmgEACfOP8mq6ZuzjuweaqgTTd3ft6I09NCNb
	763ipdEueEENWJZGUWHdCh14/bYywB9nKK37ynCNLHUb2FFc0iSqJSd6qPfF951h
	OjqXOnZ0xHNj7gb9glr3/74gAGzNRB9WiCUY6uZ8utRU8qUZugrGvmsIG19PKXoq
	kawlVvYrFh5yO1lKG5blir+ujYEThkMRfrIhUidvAQiMlC8DlN2/9ZrYl+9i7Ugf
	gU6vL5NYGEkqf4zHUxWB5KyBY/ol38pbm1AaXqedUJZVuxCWN93N0/STEXx09/5b
	hIa4Dg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjy0a0c17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 11:29:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81c5e1e3beeso2007286b3a.1
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 03:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767958160; x=1768562960; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVW+etPTwHng1TzFtm9HNMleUWiaF3BSfRIIx9dFhSU=;
        b=jhh5yGU8qrRpHam10Rl1Z3eax6qfU4ArIWzMF34A4IIaDBZHd65587bK9UJVVpMN47
         RA5A1dtuJwsGe9O9RfQ2oaXp5h32aH2Wlr+zb0aa1sKgmtBCdX0bi+vuW8j2sSGhMH5q
         w2on5rT46S2XSM1IT0wf+5pJPqcsSC0ws7/EbN6VmihEwas+Ms282Sym0e807sr83sHW
         nu5ebczYZsmimR+OX256zetPfmGqUjgeozvUT6ouVwPBWCO841fXyqSygXueLkwcxbvf
         H+ncPLaiWwhjWazwSZzaQ5Cya7ESVmv8LZzQRFr+WXxJOL8hQMfE7zRslvRgQ+cQnRPu
         fJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958160; x=1768562960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVW+etPTwHng1TzFtm9HNMleUWiaF3BSfRIIx9dFhSU=;
        b=YDEEAa2v5fyldIGR7DNjDrz6ivYon4ZM1mGioTdATovoRFq55/IskOGKWNi7vXWXOY
         o2o2d4WV9XSJ55ElmBwqW4+p4FgaDe8Dq4bey5TT0jKPM2vQAwtVTeRLzvJQ6RyXSNdR
         C2yRoYqpPq35zuP4GovsZEg0qfPqBj83iuwJyg3F8kjwWc60SpZrfVIWQIishRVrcI3q
         +dUEyOJe00kHdybx+R59KMzjsyXIYjPPLP4sBNQ91SWKgGyIG98czD5TCmpaeGh6yXl0
         MEqmhXQ+t13sUtSuU4OIoyK5AqheL4WGbB6NqBwV5HAI1aTEiftMGufjfRufcy+zzN1h
         SOqA==
X-Forwarded-Encrypted: i=1; AJvYcCWubU85XeuKYBu7aFpmK21qeWJtVNYllv64xKP+DpxP+VjTK54bgd33JtNS93+fbglLcd0+xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzguQbfptoW9zsDZvqHEfG5MReTFJ5iawa2CmH9X7KcxUuzqois
	8sg3+L7HMcouaHx4LVwiUWK2VVCbsNBCipfTd7xkOwb7N4xGTkiHueRahTBxC25dk4mMZ61Mp2y
	nDOs0LCp0a3exsh7lWjCJCcpAYoeyjY1MlFdmFJjAIdLxLNJooe4s0JVLdw==
X-Gm-Gg: AY/fxX6a/MybpcrkFbaUmLPHyZ14fc/Cn/HqJAX+7FqIr3ixh54NWcTXiPB9pWwsIMU
	OEAoSQ2ypYoTRHs5pBDGDur67fRFdGi6sumokT7cUqnAWqn0XTAVFlkHbbSSrk1YzlK51kkgoLp
	yGxMxyeGAYE9srrt77njFYDiEng8vekVxRap09XxSPTWS270LYDjP6AxRwykWZSm/nNF4+Vj5zW
	x+/vysX6skZEb7/HS7Uo5WQsHa1AZQouVlibhXupb/MJh/ReQsC/ibHpctjfuHA/RV0lfnfQJH0
	3oWHQcO8Z42IvD1x/8V2A3CCgsn7agY4+49L38BTOVGawTA8KL/BKqT+dOkuhOjZYyiroKB83Su
	sFIKao31k7HeKhJm3JOUy5uq2ehlJAJPIC7BG
X-Received: by 2002:a05:6a00:4387:b0:781:17ee:602 with SMTP id d2e1a72fcca58-81b7f4ef1b0mr8391921b3a.28.1767958159719;
        Fri, 09 Jan 2026 03:29:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXnYjMu4puvMm6nxYJUa98/3GAc9CeW5FaojpFB0W6CqLL53DeHyB5cvLk9bH+2EKkXFdCqg==
X-Received: by 2002:a05:6a00:4387:b0:781:17ee:602 with SMTP id d2e1a72fcca58-81b7f4ef1b0mr8391899b3a.28.1767958159142;
        Fri, 09 Jan 2026 03:29:19 -0800 (PST)
Received: from [10.219.57.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e46339579sm1667009b3a.18.2026.01.09.03.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:29:18 -0800 (PST)
Message-ID: <b0a39971-5616-4768-b08f-b359cabd2f6e@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 16:59:13 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/arm-smmu-qcom: add actlr settings for mdss on
 Qualcomm platforms
To: Will Deacon <will@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        robin.clark@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        robin.murphy@arm.com, joro@8bytes.org
Cc: catalin.marinas@arm.com, kernel-team@android.com, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20251209052323.1133495-1-bibek.patro@oss.qualcomm.com>
 <176764799410.1451727.17568755330994660848.b4-ty@kernel.org>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <176764799410.1451727.17568755330994660848.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA4NCBTYWx0ZWRfXyS+vftzJ00OG
 hbjxVimcG5LWjv7+2ngZ+z7sAUKTPkCqXyv47+kzV7wS6szPtJv6K12Bbm8HbGkeABUM+D/uoCN
 zMdOSBEC2+3Dqll47gOuDWEQBwcRTwr78X5chomtL90A7lv3LIDRoi3PCH3WJbSGCoeB6MTGGUq
 iu+vDoUvRnreGFuHBk7MEH8IZC/718eoEFY887l97Qn0vwnNXrc8FIh1zYxAGSxOG1uQskAk/it
 Y263XEF7qXNlidR6hCi9skFAxeIs46G6Y06x92A6VXjb3iOMyocpFkkp6RjwckKofWmO/otL/1g
 FlezOBIs5Aoudo0nSlP8Rb+qvxdIqyL5ZjNosUcGyrcQQXrKP+1UpEjZFdL29fiMoPpvZS+4NuG
 wut22Ht0sIYunE5zIihUXVG99B3sVsGRklrJ8bXRdsXKLO0gib3QVIJ9EjYaoVohB7xlo+UqYWO
 omwUdGcFGU5/bEozWrQ==
X-Proofpoint-ORIG-GUID: T1qgZJQ797eDNK77B8ULeO5Vv9cxn4oD
X-Proofpoint-GUID: T1qgZJQ797eDNK77B8ULeO5Vv9cxn4oD
X-Authority-Analysis: v=2.4 cv=QPFlhwLL c=1 sm=1 tr=0 ts=6960e690 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=y7gZjIUQjNkmgTN75kQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090084



On 1/6/2026 4:28 AM, Will Deacon wrote:
> On Tue, 09 Dec 2025 10:53:23 +0530, bibek.patro@oss.qualcomm.com wrote:
>> Add ACTLR settings for missing MDSS devices on Qualcomm platforms.
>>
>> These are QoS settings and are specific to per SoC thus different
>> settings, eg: some have shallow prefetch while others have no
>> prefetch.
>>
>> Aswell, this prefetch feature is not implemented for all the
>> platforms, capturing to those are implemented to the best of my
>> knowledge.
>>
>> [...]
> 
> Applied to iommu (arm/smmu/updates), thanks!
> 

Hi Will,

While reviewing the applied patch, I noticed that during the transition 
from v2 [1] to v3 [2], one of the SoC entries (sa8775p) appears to have 
been dropped while addressing the review comments.

Sorry for not catching this earlier.

Would it be acceptable at this stage to send a v6 including the diff below?
Alternatively, if it’s easier on your side, please feel free to squash 
this into the existing patch currently applied in your tree.

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 456d5146831e..718d102356d9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -43,6 +43,8 @@ static const struct of_device_id 
qcom_smmu_actlr_client_of_match[] = {
                         .data = (const void *) (PREFETCH_DEEP | CPRE | 
CMTLB) },
         { .compatible = "qcom,qcm2290-mdss",
                         .data = (const void *) (PREFETCH_SHALLOW | CPRE 
| CMTLB) },
+       { .compatible = "qcom,sa8775p-mdss",
+                       .data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
         { .compatible = "qcom,sc7280-mdss",
                         .data = (const void *) (PREFETCH_SHALLOW | CPRE 
| CMTLB) },
         { .compatible = "qcom,sc7280-venus",

If neither approach looks suitable, I can send a standalone follow‑up 
patch, either on top of your tree[3] or on tip.

[1]: 
https://lore.kernel.org/lkml/20251118171822.3539062-1-charan.kalla@oss.qualcomm.com/#t
[2]: 
https://lore.kernel.org/all/20251124171030.323989-1-charan.kalla@oss.qualcomm.com/
[3]: 
https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/log/?h=arm/smmu/updates

Thanks & regards,
Bibek


> [1/1] iommu/arm-smmu-qcom: Add actlr settings for mdss on Qualcomm platforms
>        https://git.kernel.org/iommu/c/f91879fdf70b
> 
> Cheers,



