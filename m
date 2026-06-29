Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645B3F8243
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723196; cv=none; b=aM3X5+hEL87xpVnH24pwBPcZk1pNFiBnrxavnquubkyRnJyVGXXwg87tNjwvPusGjFvxUkXANjYynr27z1gws49itSHaFXMbMsLvAz1fFqjGR2wzK1Z0dKD8O9mJdOaFkvNUd5T6ZUi4bD9lrvf0Okz9R1zEkzqrGHLwuzjXwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723196; c=relaxed/simple;
	bh=F3OFBLlj8lAktFcr+xkCCxECEwRA6j6tVLIvdSaQSe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJuYFUWWqDcUy/4km6vGe+St/oaR8afW+eRwIi4Xo13tF7yN1g4i+IBjF6daH1TXeJ5RqDuSSkavaKxjDKwwD7XR2VKBZeKpcjmkx6enU3wYFKEujVDYUyEqb8P7CnJmLYduphw/ZhIe2qjs2mKroxzsAV2Gzx30efCYnPQH6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T1XGg8hW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qylo4Gj3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T1XGg8hW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qylo4Gj3"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6sIi72143017
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MxKbFO3jZdx0YMVM28FnI1izFIXZoinjwwywDy6J9aA=; b=T1XGg8hWV+HFSMfv
	ZayRu3sTjrhGUa6K+hGv3D8cpX854IbY+g+3K1kEJjx9PhYbM/nKcJXTSEWQTBdF
	KtpLoCpzE4TT4oRoQZuB8FOlEtbzTe7bQzLxawr7FK92zZzcvXx0+6QqixNhgvD3
	n3Evhjco5KhEgQYeM9crVLtLFWnTAZEVG8xlnNF/cICa8358tFuA/q/IEPKHFkWw
	zqtwANNOGtfe3yHk4XjGK2y+jtw2WhR/z6d4qAC1EHj/7Hexil8tvf8KGtxl211i
	WsY8rbmK3yhARXp7f3J9iXpHRKdGsabAUrkNjtcZ7ECLuXKdbOiM0puNFGkwKHsJ
	N+0PGA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8nn1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:53:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51a8ee253caso1339421cf.0
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723191; x=1783327991; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MxKbFO3jZdx0YMVM28FnI1izFIXZoinjwwywDy6J9aA=;
        b=Qylo4Gj32fPTUtqgFPtZMxL5heWH0sNUl0GPIu3C6ptoBWuYR9dOorVlf1Czf+VU2g
         bHrmPsR5N/Sso26pBsDHjx9/8+8LpvA0mHnqqdgzW2LGH6GBn9wvhqj3ZKryl9KKmiR6
         oTNntLUftSAGUuTudN5z4c3LvqHxA/Lq7fK6RE8BtmW4W4oRJTSBHZA+1IGOQUCSzlHr
         oIa0KaZiqoeDqHsA6qGAugRwiubuAMu4xL5IpoOMB3hS+AUoRU89vuvsKURJ5/9wY5k7
         g3zO3MHt0Wx7z4vWKb+CVXieAMDwgrtIH3yuhqUSFEs6TlEAZie3piRcMVQENMVv33V7
         2qAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723191; x=1783327991;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MxKbFO3jZdx0YMVM28FnI1izFIXZoinjwwywDy6J9aA=;
        b=Df6NHg8yc5dRjIoIlWHMYY7g1B0iaOFhYPygS4+iYFAohiVPhY/Ku/ehGUNxZDfwwr
         ZdK8Dfj/f665T0+jbtdX0MOWOX1r1unz8nSd2Z1DvZqLFg8fNeMrsR+Txhll1qrZOxG0
         7GO2qvDyi80b59QSDhj/9ib3UjQc7dvAVISYrAZrFKn+1ZcdTOWWElEUFa98CN6iouBI
         ubNFw2kDvdr3Im+trReK42QT7sH+KiQFPlvtDvq2C31G/gYb3VN4GTbamHnKBZGEk15v
         d/00O0GARFbx8ukJi0LdtFbF0wSWQkJcDblxqm2d9mv05f+zb244Axtm3S/Z1CYspxYO
         B5bw==
X-Forwarded-Encrypted: i=1; AFNElJ/93wzMv3B3IptVHYpqN2ztvP/qxDYIghyK+guZ1Ukp7+0f/1tmKy38wLdnMuL79ZlrMGQxEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoN6Hj25xKxmxdfzOyVTQt5gGSUxQz5j/iW9/HDJB7i+r6yv59
	iRpB8cr/Y9B24WkugA9ZDgxRvYCQsG6RtOwnTHOGyVKBCGLZ/XnnQ/DSv9rEdEA9ILjuV9sneH3
	c/vd1SzeV705/KDUdshrmsyOGjuT5ZTPlXyXmMa0BDYP19OzowWTpVA455w==
X-Gm-Gg: AfdE7cls7cagEd2nPjqMkZn1gdcf28XSbPH1cVJKOu/pfByy0yLbaVKiN0VKRZJwmqi
	6EK2LVyj5Dc5oyWEER+DzO4g5Hg9lcKRcyR0miHH1D4xBMd7cxntiWAv1BNrimCPLMwCPZTKbq8
	OIzisWFXyRhJT7RPYNdzniaQ9eXqNWqsD2sBFfEfQrOIBYJvf7i+tAySaQbgFWZEw7zCOWiHwrn
	yicVd2HiYXnhzs8hrJzPhbxXHSg8S3vYmucxrYngg7HkBcsCd3Qc+eQH5AVAVVzP+jzxOfyGfti
	700343qIf2JX/dsnYWKC2VQnCRSwhbdC98ZU7iXOlDoqKzGtosQP3sZtfrWg8qyESJQf39mmcYy
	k5LGuXhVbz5cBXp5TbeLpaZWxXdHZLHqdA2k=
X-Received: by 2002:ac8:5dd1:0:b0:51b:e991:92bd with SMTP id d75a77b69052e-51be9919641mr61100321cf.7.1782723191477;
        Mon, 29 Jun 2026 01:53:11 -0700 (PDT)
X-Received: by 2002:ac8:5dd1:0:b0:51b:e991:92bd with SMTP id d75a77b69052e-51be9919641mr61099921cf.7.1782723190905;
        Mon, 29 Jun 2026 01:53:10 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05cbfsm739181166b.36.2026.06.29.01.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 01:53:09 -0700 (PDT)
Message-ID: <a509092a-1c65-493b-9df7-c8a89564bd7a@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:53:05 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: shikra: Add A704 GPU support
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
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-5-9b28a3b167e1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-5-9b28a3b167e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXxXaWAbdQMbyt
 BLZVvHTqbWU/XMPL4mJit6xZSGGXLffS7OP5yDLAB4ZyQO+s0pxsFAqwI8i9Vu+b0fSSUMb/YG8
 F+63qmoSkj+RfG5AKte/HV3/oy+oSt4=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a423278 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: yvDLYQMR6PD7yG-nxDFDaISoXMGsktip
X-Proofpoint-ORIG-GUID: yvDLYQMR6PD7yG-nxDFDaISoXMGsktip
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXzjyFXq9ncSWM
 1hp7XVmGGKQo5o5ljdx26XmMk/NsMPeK7UAlyjyfwzKxa4lWs3eHy+EPYF/31HhncAtlC5+lPZm
 JduVoAqODy8CQt8rxeTsGP/nwz0pPZLRWDcKKpbqa+ba0O+u+Xutc69ABJkOgA2lQNne57Mw6+2
 qChisbbVWlRzLnBWfuYbwLHpVSIvYb/FeomFlId+IreByyn4YLKl8+qaQAP4iaMvkJwns0rvVbz
 xe8/TukeaoaCMwA7QztCe+vaIk5ryosFfh6ulYiXTPoPFml7AUwK0Qjh+OTmZyV++M90nwyS3qK
 A6TV8JKxUCbx4etnSe5zNUwk6tywXUQ07hK2oYS6FFLLaHQSvShYgDNH/cW9oFjAh/Q7CsBaF2n
 syPyzu70WUV75A2qPBlomtvHIpXh8t6QWPJzMChUZYwuLlKtcaiqPCEXbzLzX1E9ly+G2ukFn9X
 5ZXnFxZJtiMeT8OzWCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

On 6/28/26 8:23 PM, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Add the A704 GPU and GMU wrapper nodes with register maps, clocks,
> interconnects, IOMMU, OPP table and the zap-shader region.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
