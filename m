Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4264435AAD
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442406; cv=none; b=ugHJObeI0/0JqDNtYpe84mf9OVprzxO623jC+SId0s/dJiZHWkM/rXtvEcUfVEf4AU8xG2fEpO8Ru5hO/LHHICwDCT+FT2zoaA843yFXi3nHTsubItyIEZ7uMJOnpNDk1V2r2qVCq+bl/aLyqhcWmjHMMTL9Tc/NO+pNZ+Sp//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442406; c=relaxed/simple;
	bh=1XRsvNIGdAMhpe6h6Rmr9ffQO30RuYSohh6zIGmdAfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bloN3Ve7WynHjFj0eYtTxoFZ6VwftLvIX7U1lGFd9i/EBghL6blr6vxpL22oX83Pd/Vq2cqJYXMA+FpXIfBokDtjpaEOVbBEcdVhHUaG2ZrYPEGjACYIEsI0+P1aML6yO5SnASd1PsYFVjzB7anIqbVK9K5SqUlSM5Y51I22x30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MiYr/TPI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3Z8Ip3K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MiYr/TPI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3Z8Ip3K"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FT7PX017879
	for <iommu@lists.linux.dev>; Tue, 7 Jul 2026 16:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ngMJFXW0MVpSyT9cIuB08wDD
	gujyroBQVzUzKlhc52Q=; b=MiYr/TPIV1tgnI2ssrts3PiyItGY+zxGj8RBOb/N
	1US8orSQS1Kqkf5lDLxiYel8uxWhE1agG5lZh4l9NrQ1+3s3uU1iu/VQEr93MVLy
	hLqRCwJEW2fTBgHh+GNsCmTRW0NE+TllBeUgadAL6gokqzklRbdaJk/4GDfpKVaS
	GHputQFD0WBQhDtgOgcQjtX3N97uCAAqy2nFq2EYtzlm1iqSm/Qqzu8Zs24Dk0Fx
	qg0cPK8IkgftVeeByYZ39VmtZm+mreJ4g+8P+NdkDKHnkoDGrdFPyJKu3opDXq/4
	EQnaEm8R8JojofSQZN+MI6uHIH2aGXhvJf9hoINEC8deWA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep26vg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 16:40:04 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9674fae89e9so527497241.3
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783442402; x=1784047202; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ngMJFXW0MVpSyT9cIuB08wDDgujyroBQVzUzKlhc52Q=;
        b=C3Z8Ip3KnnVNvGyJIUhbJfQFoKrCipy4esyFwJh9AH8OXXAxH1QYQSAwJA8KQcsOY9
         OLxH8W8fAoEguBFNQGhSpvMN6Mr9wr0itlEgjvo9rVe5SyOS9frpzBx/9kqJOYsBJYqO
         IjziCcVAXKvW1JICr5/t1GLLDNWbTx5QEKLfIz1DIXXQ4MqfJUd9dOL6gHB92EGszFyG
         aBXqxz17qm6QQQNWUyr70EKHVBCZ+yEdw3g8FQtBU9NqVP3pyEpN425MZT0uSl0Mp2yy
         Mg29vZVzwhDjXGWcYNp8N5t7UpJG5nmWj36wGGbtCfRqrL4RFzuP51koxlTXLyDb3ZK5
         DdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442402; x=1784047202;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngMJFXW0MVpSyT9cIuB08wDDgujyroBQVzUzKlhc52Q=;
        b=CtX+BtSpYhyrNevRG0k7IE7JzXY21U/0MmYftA2uUQkBDZ7VBsTeme6VlR0ugbAdYD
         cgH/BBzLCphgQ1V8rcw/ZIBmTp/N+JoZIqdedP3SgUL5JOYjdNsk406goOAaHwkXCuD0
         jI9B3ESds55d189P9qM4laBNekyT1xNmXrac29y9EAVujQx2YSYivN5D+TvKeDrH6Zrj
         YHuRln//QIfJtorpjtulT5HqKEwjcmGlfvHaGpAaHKApgwZd7UNRqLGsAPlkZwi/9kmq
         OSl/pnZxL0JPPTuJtdxETicx/+Jl5bvdJPfIATHd4k2ahyCwBZTNJD5t3gLiFNGUUTV7
         G8hQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyZjrX9Kf8ZIm8GTLlubSexOXNC+UUZy6E/B907ptEhaR4mkd8gCCPhDptt7pw9RcHeydcAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YySQz34E+0yWD3rbA6wBB9fcjjHmb4vkjPd4agWP7EXyYULwHGX
	w039v3IbpbVPd5RT/AOA71olwsVAHvNwlKMB95qBX4tMmDJEL1c7xJIkWj9aRVJXBseKrtzIl18
	S80csvqqeAWJIXwUYkt7+aRt1Vj9G81Ch9YkBcfSDPhBZoIA6M5d1i3Z9FA==
X-Gm-Gg: AfdE7clo8ZaCt9TUk3jWFMTUM8hT54vuCGSsqF/MiV03T3dgNbc1ogFQO8Zx9miZQmF
	8WblG4HYZrd0GQeBGPM2Fs3YV96Oc93vJ/GWOT6qDEmv5EXNd/EnsOpD2NZloT2kWw4J/seAEzU
	4jtp+8afERxggOwzgT+m4gJo7G2PQPzeSp0i3QLPgrBri6ujuzctP3qazvFuQnxbt+kSVdIL4sb
	iXnNMElpE5ByfwJHL7ZKpHpRPstPZbUrQP913q2Mwqr3C8A8NCKh0rLxj63ZLWW6FO50tbrue4c
	nh2zXUclJt/OGU4TUepzNiSA3TaXbD9sR/4bEMReUtiHujouSK/XmqsXQRMurIFCZb1zxUinO/4
	OD40fOqSwNaxopeOr1d5xsCkhldizhir8jXo52MgkIPDRTeqt7gV9YHVAajXSZB5pIqN0X7Vj+k
	HdCgL0/lNQu+PtzGOevzeOGK8L
X-Received: by 2002:a05:6102:5f05:b0:738:be7b:add3 with SMTP id ada2fe7eead31-744b7ade412mr3295745137.6.1783442401885;
        Tue, 07 Jul 2026 09:40:01 -0700 (PDT)
X-Received: by 2002:a05:6102:5f05:b0:738:be7b:add3 with SMTP id ada2fe7eead31-744b7ade412mr3295690137.6.1783442400917;
        Tue, 07 Jul 2026 09:40:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb3aasm3792026e87.53.2026.07.07.09.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:39:58 -0700 (PDT)
Date: Tue, 7 Jul 2026 19:39:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
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
Message-ID: <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
X-Proofpoint-GUID: bbsZutX6fN1AUWu4j2Dt-OWMFWeQn81Y
X-Proofpoint-ORIG-GUID: bbsZutX6fN1AUWu4j2Dt-OWMFWeQn81Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MiBTYWx0ZWRfXxik49K6cZSmM
 3GAGbqwvd7Qo66QCDcLeeCUUQSVdasusyWV97/FkeEEqSNUUHNhqaaxhRPxBOJkFRiFebV9kRQ/
 jvXr3OcEn+jxln6fe/KfCtantf5zU8EAplk0/QP5E8sKO0pFd5xhn/saXkf0uD7s17sGyfRLtzE
 OxaEFfl08Cg8GWJiz+cXDgoSc4UUK+cVrjlYuFMONuZEapaT/Tqowzp49vQS1HFeh0TG1KZzreH
 xfUGFo0Cn5tx4n2OI58bnlkpQwcd/a3FV+LhBFn1WoLT8S1Wot/ondP0yUahVyIJb4RBvlR08B1
 +TD3umV/CO7MVraangP/qH+SN7y+wch0WlFJRVnPwJx8MyxJg7QZ7oYjSHLWTSrll7eHO0td0AV
 eAyI0TaprpOJg0YIpQbb4TK2/8d8Tn5gXfFGsA7QFQtG0qdSJ8UUa3aESGurzMQTPWrqNjHPLba
 xg37Zz2DA18PeJ1CU5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MiBTYWx0ZWRfXwS+pcIxpjuPS
 or9DeCQUervg6T/GFXD7w2o3lyEwpMDpgnKPD20l3NbY16SvnNvsy6AYb0vdpZOmxsinm2R6aeO
 eT8iOP5wV7SiJdQ2qUvYfq7kp5ML6CE=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d2be4 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=1fOCVGvR8NE8L1w4xeIA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070162

On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
> > On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
> > > In order to associate the SID used by LPAC to it's own domain and
> > > context bank we need a separate node on the DTS.
> > Can we use iommu-map instead of adding a new device using the same
> > addresses? You provide zero explanations, but it seems like you are
> > trying to separate a part of the GPU into a separate device, but it's
> > unnecessary.
> 
> What I was trying to say is that we need to map sid0 and sid1 to different
> context banks.
> 
> From what I recall, so long as we use the same dt node, the iommu drivert
> provides no way of doing this.
> 
> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
> and secure.
> 
> The address on the lpac device doesn't really matter. I have very limted
> knowledge of DTSs but I think we could just leave it out altogether?

I think, you were poined to the Glymur Iris patches. Another option is
the QDA driver being submitted too. Both ot them use iommu-map to
describe the same usecase - a set of SIDs which are used by the device
but which should not be a part of the defaut set. With it in place you
don't need to have separate qcom,lpac devices, no additional properties,
etc. 

I'd recommend following the same approach.

> 
> > 
> > > Add the code to look up that node on initialization.
> > > 
> > > Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> > > ---
> > >   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
> > >   drivers/gpu/drm/msm/msm_gpu.h           |  1 +
> > >   2 files changed, 21 insertions(+), 1 deletion(-)
> > > 
> 
> Best regards,
> -- 
> Anna Maniscalco <anna.maniscalco2000@gmail.com>
> 

-- 
With best wishes
Dmitry
