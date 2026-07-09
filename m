Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491A385D8E
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608871; cv=none; b=hC2aWzt5dGnNQlb55BavZnx6BJaF+uJsXoNtjbtxEkE9gnyQMUMCrN7pjHC7K/tWSRp6uNbKjrWXRGifCJIzEhoR7ossAz6noUFX0bYzbNYfc8B99SOrfOorEpjGuR2UaYTHJaMNRWoIxWUomVHWLJrqS0Xk8R9jTrx96fg88DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608871; c=relaxed/simple;
	bh=Iad5UADQt9fXiFcZiRSv6DKnb9zI3RyEtPOMI+t/pn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7hAB8VaTE/gngc98Je5dCz3JRYBoKPfKjJImaUF39tT3bN5MpkKqxOjRdPyPwyfS1gICGTdNLXZvMts6rgji+3sKGVxjbUX7WLuTq4VBWPdOMy0k1qv3ALaOUBr9amxfgrqSZ4SrRfI2f/6kbWwuZ/zQ+IEsKwE1JVEmEfB19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fgFK1CrJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GshEHhFf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgFK1CrJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GshEHhFf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669DwUDe2014496
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 14:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZMd5SzYa2JtJsuef3gXqhLim
	tjjWD7XXATJ3fVJWKFY=; b=fgFK1CrJsVkn9+lyI6grWkzihN4jSETSO5v1zhyx
	yJs1ZTq+7KHtpwkUTbuaxhcF3PrJU2srnVT/38qhJ9mzZM1mQ4QjpOepB4feKAhb
	qUCPsOaFsIoCJtlfRnch1AnGKK1yM4fPZZ7L0NHLzFKXA8C32Mq4xZlovyMONOpy
	As1q+d7o8m7GZ4QhEASjtxVGnbHUjp59LzbgeSQo4ZsQoFzzQ+geRApF82v6PJQj
	J5c9kaLgTPyqOhu17GRIOLVfHTARtljnj0obrgas9663NRdQSoTqMvFGSqpoDCT6
	DLVVepZvtOFYWaPqh6A4NGKOmJiJpHkHoVfPC2GrQjWg2Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6mdfn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 14:54:27 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-738ffe90415so370276137.3
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783608867; x=1784213667; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZMd5SzYa2JtJsuef3gXqhLimtjjWD7XXATJ3fVJWKFY=;
        b=GshEHhFfjaie53Gtp3dUsJG6ZAYhMCgqGSh3w0vRxqXgvtZTbPr+4M6jaEJyBtMXUG
         n44f1bXi8J7MAo6OxvrHnWR7SUcnhP3UDWAemsTrShWW70w88gPOOPIbQiI8YDYcyrUc
         /lVdNSWXPASR8dc+cz9AycTn7MrFT3jPLivqJ3HAQypdr1Lfzlq6G/laByfhVie2oBur
         zC79DrzaTSaG/wfCrWUsROJSzqQPWfnGtXXwg4heJiEVKmqypQzJpwpn6hZcNgkscPEM
         peDvi0iAf+1b3uZuNmmbl405WpOolU6h/JxQWqdyNqLApRHb8cDNX45zTeiPXfUBCISe
         4fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608867; x=1784213667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMd5SzYa2JtJsuef3gXqhLimtjjWD7XXATJ3fVJWKFY=;
        b=d2iu8pwbPl9rzkMIaMQj7B4UOKopVTygV4vzvSgfVRG3nYZfHxg0tV4udLzFfQab71
         zquv1Ro4lZMnWLo2z/rtr6Itp0gE9EXEy0hgeQeInnw68Seu6v1KZ9ilBwX6xzWYmOLs
         vkzjlUWyWL+rR6D806baDGNvLwD/QBPGKt8bz7FfaqWgXrkQ9Pm38bLncM6mNb/k2py+
         I+8KTJE0w0aMOXBLS04DhDlKOw2xqVbT8uiu5+OtaKndUMXYgHVMqfA9i20OWP39mUWN
         foqYPHLp7+ACttD9Uw/EkM++yvzT/Ds8PU0gMO3O2S8SqLzXX2fxvEuIs+h8zzxaESjr
         hIhg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4TDYUSEwVu3XZn9G6CMtzaDsydAOrEbRVSi6AWBVB9ogjJtiXZfS1YkJdtNFDqwvtMncLyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFvorKUXayLWKV6oNv6OKdSyjGT0d3bXWHQFodjkZEfiUDDUc6
	L0R5+poqKCEOgCo0P+OHpw+J/hvPnTmfeCExbCTJW1NW8OVCFbtDr+YE7V5GZvkLj1zrDkLzPhl
	G1BzbkaIrZU6aH4jYq6AG4COEoMuIHCzy35HVNjS2BW0J608wJJvZC3TFGw==
X-Gm-Gg: AfdE7cklsIa7fDB7aI9CWVHoRGUCTBSbzd+dPBRFlkdzjV8WjeU+HdnRQG4maX5PzmY
	h1PNpmqes1zmAygwq6OnbA53U3QdkMWg6cnRqB7uWa6ym5WUmcQYWUN5+D5DDVCGfpo8n2tRjKU
	6s5yghtx7ve5wxKEIrRCCPMSJIsd+Mn9jybGCGk4JCv/Tu96S4ujw6IFkKYUKMlfIo1A36JzYmd
	TDq+I66jbhcUlPSR9zbmk/mMSm5AhjmU5x+wq3YKT49g6/2kiFf01Pz4j9mpmtjbZql5rhRbNkR
	oWR0FpOuqEhLz5dFByeolXakaq+0X+sEOoP6NpyFY+/CsYNFAi02keOztL/R1Zi/B/Iu4RKl039
	2cp7Z/2uRCs4HKhsK54OwbqVCFlf/WTQOYnH7RN9gvhXFLQKcC1fIsYxve8HcUEdr1qxAIG0Xaw
	oAgr860uT9J7nsNJ9Dz1yBvl8i
X-Received: by 2002:a05:6102:5cc1:b0:62f:522f:5b2a with SMTP id ada2fe7eead31-744e03d0408mr4194094137.22.1783608866717;
        Thu, 09 Jul 2026 07:54:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5cc1:b0:62f:522f:5b2a with SMTP id ada2fe7eead31-744e03d0408mr4194057137.22.1783608866193;
        Thu, 09 Jul 2026 07:54:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b017c29961sm500429e87.29.2026.07.09.07.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:54:25 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:54:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
Message-ID: <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NyBTYWx0ZWRfX9Ug20n9naUjt
 xVtpiG9rXOMRkXAWMz4EnvDeICW/RIaGA43B92GeJHVWkVsMM4b2CdFafgpXX3LthWeyr73Siuj
 6AGTmmKkwJLYQ52KaRnVKQR/Lajcnhk=
X-Proofpoint-GUID: CDrluoS2EiVNoQnPZeMSVnklnbHtH4gy
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4fb623 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=gTY0VpHTFMgWGwS8g40A:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-ORIG-GUID: CDrluoS2EiVNoQnPZeMSVnklnbHtH4gy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NyBTYWx0ZWRfXwqzWNDJVvzRz
 SdPYHfUvQ8AOawv89YdR3tqfeFRguDPW49chPFVN1EdITAl2jOIeFk7lLUQyB3ScYybfCw1ODDY
 bTlRj6Y1iFeZpUuRjFLktkVO5m9MWOuR9/pdeDv6udC34McssrL8HRn7DFmxAnBL1IaiMfZRolp
 7ECwo6t/pNLjNTWNu8rqCvPACkKH3niobUdcJRjOr7siGu8wS7ZfoD6JMlQYQLIiVXfRCzP90Qs
 glmaNHUSmiYI2OZG6LrtiQvzpAUA1rTl+EXGtamrIsBS9m/bYqbuGje8ThJDkkUIMAyAsbNkm2m
 ziPV/pA1rn6ne0igqe/ahHFOXkBTjus/26cf63wkEVubr0K9nUL8vHXq4YMfcW3McT71kZ3aaW3
 eEiEmyuRXDS6jTWww4L3rBTb81stEHMWeHJX2jzLyP0PbnsHjlMGjcCt53CyDiMQf6BWQiQdNlJ
 82fnDVjxHqeXYC3Pgzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090147

On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
> > On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
> >> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
> >>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
> >>>> In order to associate the SID used by LPAC to it's own domain and
> >>>> context bank we need a separate node on the DTS.
> >>> Can we use iommu-map instead of adding a new device using the same
> >>> addresses? You provide zero explanations, but it seems like you are
> >>> trying to separate a part of the GPU into a separate device, but it's
> >>> unnecessary.
> >>
> >> What I was trying to say is that we need to map sid0 and sid1 to different
> >> context banks.
> >>
> >> From what I recall, so long as we use the same dt node, the iommu drivert
> >> provides no way of doing this.
> >>
> >> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
> >> and secure.
> >>
> >> The address on the lpac device doesn't really matter. I have very limted
> >> knowledge of DTSs but I think we could just leave it out altogether?
> > 
> > I think, you were poined to the Glymur Iris patches. Another option is
> > the QDA driver being submitted too. Both ot them use iommu-map to
> > describe the same usecase - a set of SIDs which are used by the device
> > but which should not be a part of the defaut set. With it in place you
> > don't need to have separate qcom,lpac devices, no additional properties,
> > etc. 
> > 
> > I'd recommend following the same approach.
> 
> iiuc, the conclusion in this recent thread is to use child nodes for a
> similar case:
> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/

Let me check internally.

> 
> -Akhil
> 
> > 
> >>
> >>>
> >>>> Add the code to look up that node on initialization.
> >>>>
> >>>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> >>>> ---
> >>>>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
> >>>>   drivers/gpu/drm/msm/msm_gpu.h           |  1 +
> >>>>   2 files changed, 21 insertions(+), 1 deletion(-)
> >>>>
> >>
> >> Best regards,
> >> -- 
> >> Anna Maniscalco <anna.maniscalco2000@gmail.com>
> >>
> > 
> 

-- 
With best wishes
Dmitry
