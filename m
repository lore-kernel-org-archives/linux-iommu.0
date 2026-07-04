Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546CE3002D1
	for <iommu@lists.linux.dev>; Sat,  4 Jul 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783168395; cv=none; b=VBhWqNDC0Jcbnzn6b8SEjx5jFY6xiPnxdG2Y2zLeqhvrZj1Gyd+/syyp+9JYdkk3H+h0ZJSFQDH6/K/EUHmSVyN/daj+WlS6qJsK1oj//zrhgxa4pPcz7YwsueEJVe1hJu7qo9xjn0LOEEjTLHpZOtu8gP9oskuy2QL3TlbP/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783168395; c=relaxed/simple;
	bh=ZqLIdjiIL4PaEbHPy9ZDj4gnrcQqTesCsBp7hGwIhYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCjg5K2EtKMZBwLEIDenmaXrMP99e6Hy0hEDB6fOwKcbtnAc4w8Xu4lXqkYekxEeJLyEDMRfx9q6eeKebHlLT/2ky/aDrlQs+5Q5EZhHlVkwZCtiCAABSg6/HLklLAdgOXzbrfysfclGwzV3slGBxe+23F67r3c54ET4aBSZ/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NxwSLxln; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dmb1vLdU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NxwSLxln";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dmb1vLdU"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6646hhoe2145145
	for <iommu@lists.linux.dev>; Sat, 4 Jul 2026 12:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7l+w1LkFRue1ZQFudjsniOqbsa/avBSZQtqmMh9NKg=; b=NxwSLxlnSUC+g1lR
	7NVdxQqrD2X5yEP9GceoXfoUjZh44a4vGxUoQ8nhE390jEYQSfUgen9jyHzUGs2O
	D5Bl7af9JbE0T9NtOGr0BWCOaaI/RPPDRqSAZ7ibwp8/GjX8JJKrJ5IUoBJ/STIc
	+byoJEJ2LJJmEaI7i3sGeBmcuG4zYZaRNqHV3Fsai3x4XZzu6f2irzrW+JvBADal
	b5PT7fNps+909/4cB/5uNGhJBY20GRg74igOXJGhxGlzsszkWnqmmQQK+isRhf31
	R2Lcit6DPc0dptb0CaKNoy4YmEUg73b2VE0vlpNyqpNIjBPTuI2dbAMqlqCfDgFB
	5JyiQQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txegrkv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 04 Jul 2026 12:33:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e4f27f49bso113428785a.0
        for <iommu@lists.linux.dev>; Sat, 04 Jul 2026 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783168392; x=1783773192; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n7l+w1LkFRue1ZQFudjsniOqbsa/avBSZQtqmMh9NKg=;
        b=Dmb1vLdUj/x1etiQ5jqXoZh7puEW+for91jDWs7Lq4/iOf59pco3wNy6TWNpnvyLA9
         CxeYzu9WNxgeaPXIDIY+b2UlqeYO++OkPl44wIEpoeVGIfXtmD/zOvJ3S0Gdz706xIE4
         g3CeM85wRMeikfR3QYF0F5DP30mPtDxxkhIbi2JbBJUbc4vb1yoRHrOuENhSHPdUNa/m
         ThrHNLL5aa0NLPQUsihAasnWGbiWUT152B/opjFMUA7tShFSSJOspqNHKqwm8pLK/nUh
         66lq3wZo81GSXyHGxXnkCBIo+81IadxZiuOnF85kQ/uvpMyMEL00Cqh0Y5SLL3EPaZbI
         3nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783168392; x=1783773192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7l+w1LkFRue1ZQFudjsniOqbsa/avBSZQtqmMh9NKg=;
        b=mDwnNhlXaVnsAHXMCaEDGycZv+mPNd5T9sbqLakkAVw3B4V9zizhC1sQkE2ymEawAl
         wxGTqgVKZ1TiA4V++17u30MoCRa6ohc2Xr9x2wqG+JWHIyL1XA4ftM8ZGLYRmpcZq5HW
         gcSqZ5vEHhhsa6G5Fn+mstd7N7vsWqvHggQTsNieoRjL3OMpIAx28mWy2a2i4eq8k8Oo
         mmnVp9aKf6Jp+9Lzmkc+S13NiiN+FyuQAsgIg9+yJepRKFKpsPJuMFZOuKcwL3k+qKGU
         YbgXZdR4XsWH8bTIYdjrOANZcUIWkABGUU6AiUrThguFGPwaI4WeLfG9Iw1dx31Kkqqy
         JkyA==
X-Forwarded-Encrypted: i=1; AFNElJ8Itpsl5hQTivZ06zY5go9qHIfVZtRc0oEPJqDVj/dIbs47XWLZ4p4ILyeC1VBMFDmufsNoSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYJoL348l8/zQ0512Xiq32leEKt5vZQj60o9sRuGokZQo4zMAd
	0hKNBCVtRBtWz4AJ6Jz+TJqnKdOkNjE2zNpp3G2BdxeTOrxtCH1xnXXTbxCpoc2Yyn7M/omlChL
	Q5cjQ3V9CR63RRbFX1CKQ6W98/BtLOfhTTsyj16ryeyv0fECXGvQ7di0onA==
X-Gm-Gg: AfdE7ckMIV7p+1hxLaBiv7RjJw8wud0sXFinSVCbDe/MqA0M6pN80sJ9bv1zFvsEmpB
	aXPX2n3Jqm+Kdx9zTlM4NPGD0VlepEnfP7ARnwlvaGXIodMvek4R6vgRAH9v6KKDZKPmHE4Cl6O
	9mnae3T26jblF2+eYH6G3XOKNrauZAOdAzYjyuUjeXw9v1zGivfyPtlF5+dXUXhbl0D09CYW2Dp
	hF3dB9CgG8ZNSCxOmKUSXJAjpLCB6xjKxILzo6WIk2kw4xJeldcunrWmjqw17Sfcu6XTR+BkuG9
	9KiVjqYGLjAsuxtXgFn85aCTXulos6kP0eTr6RJSYdRmZ2U7gBfUYqKVHTD6tCYr5eW5Yjx9jRf
	G5vyBpZLM1Vj2ER69hcoHdbuoW10qUGmvVGzDGAtoCocnXR3crPh1JcGYlNSKSB48sgVDu3FerI
	wf1e20YWxUf1SsD1Q+bwMgszd4
X-Received: by 2002:a05:620a:4398:b0:915:9d08:94e1 with SMTP id af79cd13be357-92e9a43b335mr448896985a.46.1783168392435;
        Sat, 04 Jul 2026 05:33:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4398:b0:915:9d08:94e1 with SMTP id af79cd13be357-92e9a43b335mr448892785a.46.1783168391916;
        Sat, 04 Jul 2026 05:33:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b4aba9ef2sm8519151fa.0.2026.07.04.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 05:33:10 -0700 (PDT)
Date: Sat, 4 Jul 2026 15:33:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
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
        Bjorn Andersson <andersson@kernel.org>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH v4 6/9] arm64: dts: qcom: shikra: Add GPU cooling
Message-ID: <qqdaoc4tacx3dlh6bp43gu56w44cezkm345iconc7iqngircxm@hoywvq57otpm>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
 <20260704-shikra-gpu-v4-6-90cf1a52e539@oss.qualcomm.com>
 <opgj6twppqwhb77itqelmyzniaifcja3wdazyzeal5axstr25g@a7v634mnimbm>
 <ca8f3731-3f23-45f5-82ed-ba1a65514b95@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca8f3731-3f23-45f5-82ed-ba1a65514b95@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDEyNiBTYWx0ZWRfX4rqq/kiv+k39
 U4rvfXt1yzfRQqiAnoc16/ZRekzJ0GhHFXRcey9dX5tE3qHKNmRnClxE7D6UYI5OiV3+kWc1liw
 LAhIOGBTQiqSAv0bspjtM6n1m2ao1Kw=
X-Proofpoint-GUID: yzHCcTbWJk0sqxI_yaW7Wzvdhr2YpOB0
X-Proofpoint-ORIG-GUID: yzHCcTbWJk0sqxI_yaW7Wzvdhr2YpOB0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDEyNiBTYWx0ZWRfX9C1xFhgE3r9p
 05cqUTEx49Iven+WC5UuBzZLs45t6ZwQJuDviKYWX5Zrxo4AMjL2H+IcVTSwmIVV2g5IxnH2yom
 H0cfGQ7ojKct0IjDgIWhe53PtJ3RMUMB84s213+QZUwqU7sskZWCsF65ahbiUv9pi/EbRdhoJBC
 56d1kYIZQZfvEkikzd/O7JVLhsGxa2gy01rqgapMcp+jJAv+x5ElGcndOeNRlA07FipOFfvk71x
 /0eY7XsEt3xSnqeTmNhp6OpFk2HNbQTn1cBbHvOfDYYm6rfgP36PaARTOjS/OqC7R1eWl+n1ogK
 EUmdkiGRCeTfHfCshw+AoKjoNqM2vpL6GPEL2hjxnzgEenkAfm8hqIDL8+NsUJ+kWK1KC8ePota
 njh/CYGEpq9p+V46I9MxFKp9hpCXyFgIOTPQbodyzAa6r5C5ez3is3oLF4fiIKoeoNTmGWJ7Zmc
 yPYWWf5TXybo3EXBaAg==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a48fd89 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=CvX1hmVerT4HThdZ_8QA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040126

On Sat, Jul 04, 2026 at 01:56:30PM +0530, Aastha Pandey wrote:
> will update why part in commit message.

A. I should not
Q. Should I top-post on the mailing lists?

> 
> On 7/4/2026 4:41 AM, Dmitry Baryshkov wrote:
> > On Sat, Jul 04, 2026 at 02:04:32AM +0530, Akhil P Oommen wrote:
> > > From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> > > 
> > > Unlike the CPU, the GPU does not throttle its speed automatically when it
> > > reaches high temperatures.
> > > 
> > > Set up GPU cooling by throttling the GPU speed
> > > when reaching 115°C.
> > 
> > Nit: 72 chars. It looks really strange to see two paragraphs with
> > different line wrapping.
> > 
> > > 
> > > Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> > > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
> > >   1 file changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> > > index 34261221664b..eeeaa369d3a7 100644
> > > --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> > > @@ -2510,6 +2510,7 @@ cpuss0-critical {
> > >   		};
> > >   		gpuss-thermal {
> > > +			polling-delay-passive = <10>;
> > 
> > Why?
> > 
> > >   			thermal-sensors = <&tsens0 6>;
> > >   			trips {
> > 
> 
> -- 
> Thanks & Regards,
> Aastha Pandey
> 

-- 
With best wishes
Dmitry
