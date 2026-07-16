Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACED3B6C19
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194968; cv=none; b=ifvuDron/VDzpNm+HWPn81LfS1mXiXEOKQWBT4mSGQWfef9zs34M3Zf5RoEu9zHcDDPeKz6kcULnM6k7+cq8tOZG4bJx77HbRtuz/tVh1qiNhjEEEmKR8zvj4tgmhlhCEn0IvADeNRZMYAcp9EFWCV3wYo7fywQN3goazwueXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194968; c=relaxed/simple;
	bh=5HkbT5VTjQEbCphRnfj+qtVR3I6tfp3ysrSh9PXdd8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIWIKM4Z39pW02PHd3D66Af8GgOu4AONvM0qlOii93pTqmBtGp66XQXFSoz5aaPH+jJdSaQJkEr5bmncrathufHWrzuThYBfffFynzj83rzzi29yZmvhhTs35OJHsQJmjyG7cFatMaM4tH8RGmo5gNKW+7G9ER4n5xZBmSv71mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HaDXCFgl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NCFj3A1K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HaDXCFgl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NCFj3A1K"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7XOjQ2175862
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 09:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HzsM35EiZJ/yzPPIs0XjKw5tRsijyewrzXg6CrcCnPo=; b=HaDXCFglMZs0ti8S
	pzu3gBUeeawMCDZsYTLiTxpDkYKE9KNf+CRRt9U1jbC8Fb/hQYixA8KGO7puSrsS
	7ljMkbD2umyqmI97nEHvFoMZZ4wdLNRNQ0DtSqg/lZWVq8TYBp0FweIWkAmeCSNC
	tjLLDpCvEKHKaCfNFRSlStd/xTDo0kfdu9B+TGGSCq1/tNXthCMFKlIziL22xBHs
	quYjWGBaIyx9hqWsE6lJq+2lAv8P86Y81cojjd1XLeG2U0XqOUBDtgZ6PuXOeRpD
	b766iclZDEZkSd6cjegBOWvS/Pv+AIbD7X41mO+NV+elMXqkA6iyNGXDTWXDqvar
	C9OlzA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu108fse-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 09:42:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9309b0f05fcso30539785a.1
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 02:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784194965; x=1784799765; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzsM35EiZJ/yzPPIs0XjKw5tRsijyewrzXg6CrcCnPo=;
        b=NCFj3A1KTjeInJwMY6KM+5PbA2aiZBUq8pxgjee9wNkNER8e/TvnCm1A170cjgKaBi
         M81dyQlupZ12kUTw2YDigq7qPD5q/Ao3d0OTk9YOmJchOOSrTi6ji/2ySkzS6dLlbcJJ
         gcglEYITPwRMidzOYfGe0zM4cGoDckhQOB8giyuqcpErlg23jERaHCIhNa6BZAE/DQN2
         YH3zvuneMKqAuYpJc3r15YLRenJ6dPpzDWATE16bDLgiRuYQYu5Sqi+7NWVo/isbAeRj
         OcKLHy3nchD393WzBJ/RRjhPzw1BlZxz9qFftm3eR/k0hgTbci6NJduOriU6dqqXrHK+
         gDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194965; x=1784799765;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HzsM35EiZJ/yzPPIs0XjKw5tRsijyewrzXg6CrcCnPo=;
        b=rgwPbxqpblgx9B+xfF+ClCigwPMB1+c54xLCmW+KOjUaAEVmBKpqEmhk+u7sL3Iixg
         KPUEmnYMaWS9x30WMDBNG3+OMV70fY4dJFRhNPf34fbLWJoUhQZV46WlEXBghxCdLfot
         fIU2ykw84P9u/b5ZqFSTzPK9pp8Dnyn/FXaunPpkZvl3/P4/R/YLpmAqlxyJT2GTi2B4
         xJg7uP6cBOMMPwrnFkYOODUgxGDmKP+gSqKe9jkJc3g6stMwH7CH9TlTMqYpSVezRndG
         Ia18MeFr12inrl/nOV6jioyP5cqDOx5eAmcXgPl3NPRyjgjBUaHxfmIAt3pRHCjqAlPk
         Qz7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrs337SeZwVmOmTX38lO94F7MOYAlrC8ZRbodnLz1253zxGpbRW5ZGb59kkmSrcZ47m0HL1iA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkExaVj+ixpBt8LTvHJaCgkyNWNHPuAhfuMOqRBB4cMAMSZoH7
	KUB55C1NxxPDHKSZb9T8ur0XoMPyFtB0GKTkyjbOtoZ1EiozmYmCSzhI3gaP2j2j496gYX/QB0U
	btTpQlPXZeO8vt0qXryMvZEViP2Y0R47fhN9ZhgVOP2Ccis/YB8UH7ATjs4fPtZ8fFw==
X-Gm-Gg: AfdE7cmydMtB7DnRCA+UeanylpuPzMjntLeR+nbjD2VU/uPcQDtsCxNLC/J0ed/Kdyr
	Flo8mF2cEzQoCTFm/1Q+xbzM6YAwjB4Iug6F3GN/VSCAwnegXiXkmMqWNnpMR+60xXfyDPLVB8i
	VN4BPOwYS3qDJNXaEEFCHnZPPCLEKtp3/Qab0QXwsNLrkpAGskfF0QGzbHbqi/gPO+hVKqChiwm
	KaQ+C+3F58DcfkUfcyRRtsFhWOO6t1fm5QVA/kINRjxCHY8lkEAMcrkDKBNlIIdCxVNEk+uj5tZ
	mfaAaOij/4LQ0VBOJTUPE9nG0YKA/CJfOA5hA+Fd3NPat6wgOHcRM2pBLGn2sU6izZALbtkdbsQ
	sRXEyvLumDwq0d6bwretlIrX2
X-Received: by 2002:a05:620a:318f:b0:92e:705f:1626 with SMTP id af79cd13be357-92ef2c65077mr1810282185a.6.1784194965155;
        Thu, 16 Jul 2026 02:42:45 -0700 (PDT)
X-Received: by 2002:a05:620a:318f:b0:92e:705f:1626 with SMTP id af79cd13be357-92ef2c65077mr1810281085a.6.1784194964806;
        Thu, 16 Jul 2026 02:42:44 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16871264basm176210666b.7.2026.07.16.02.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 02:42:44 -0700 (PDT)
Message-ID: <6caf8ca0-8be5-4935-9766-10d21c71ac37@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 11:42:41 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/msm: Fix dangling list entry on probe failure
To: Weimin Xiong <xiongwm2026@163.com>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, robin.clark@oss.qualcomm.com,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260716013229.91014-1-xiongwm2026@163.com>
 <20260716085313.207069-1-xiongwm2026@163.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260716085313.207069-1-xiongwm2026@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AD1HvxC0t5wjU78aWFG99BrL5hXC9na3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5OSBTYWx0ZWRfX0xwb1eErs9I7
 KyRNJikM8qCJIm2HPr3fgCJXIOL22eUv/jl2WO3VCT0Xd1OiPfaY2+uosstxMYka0IgzkxroeD+
 zDWt540uYCFkFKwfeJ9/OVgIwdBrVtkunTBaflsULwWEahZKh9ylSSKafBy4ZVHdjkq6sBwDM4c
 CYf9fHxkNf/JWeNYkFWMT+S2ASIsFwiJbz1a20VEKAg4Uj0UtCyT+mkQ0HaM/er961uuZVduZz+
 ETTKmkpEKz/Nd3iK0KwxUjeVbz5loNSxwVdcoXRXuu/+Lwosdpv9iV0Ec4cB/Vbani2vqERQ9kA
 BcHTvKh7o0hU6o8INr3qFAySAuTPn4t3dKLVw86gy/11sGI/faqdEP5hlZlWvvb7+HK9ZULMT78
 zymrhQyXYd9dkyAE5mtmrkaHcJVTpwxbIGZNatTbcITybkMSRL8w+G2drn7B2Z+psLlZlb9ZRdc
 iaO7LEg1WL1pTlg/Dzw==
X-Proofpoint-GUID: AD1HvxC0t5wjU78aWFG99BrL5hXC9na3
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a58a795 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=n3OY92c7DukLRWByAxYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5OSBTYWx0ZWRfX9E5mSvJWHkSM
 1PNb80FFIaqWvGzglBxZx19pTj9huP4FxJRd59mMA1k6EfI3tpAxisuAkV+opNW8rqv9FaDTvXv
 PfMSeLkkdczR9oc5xfTpCImSfgWTIPo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160099

On 7/16/26 10:53 AM, Weimin Xiong wrote:
> Move the list_add() call to the end of msm_iommu_probe() instead of
> adding cleanup paths, which avoids the dangling list entry problem
> entirely (suggested by Mukesh Ojha).
> 
> This approach simplifies the code by ensuring the iommu device is
> never added to the global list until after all potential failure
> points have passed.
> 
> Changes in v3:
> - Move list_add() to the end instead of adding cleanup labels
>   (suggested by Mukesh Ojha)

I think this approach introduces a race condition, because e.g.
iommu_ops->of_xlate() depends on the item being present in this list

Konrad
