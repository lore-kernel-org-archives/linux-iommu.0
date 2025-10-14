Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6FAEEC0
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480342; cv=none; b=hejrHd8vlNdxYbTs4spy80QM1YQCUTxT0aJlcXLmXyp7NeDKPs1U8lvQKzcVWuhtlnwVsx+9Hukf9bnrjW8XODyjGDjj9M6jUWFT9R775bG0Zb1a8gLCcKNZYj3mtmJVAsH4ywtVwL8tHGRvnAVgrhevnC/JhIPPapaquaHhjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480342; c=relaxed/simple;
	bh=BgOEdwjIa0sGaBXDZWeP/zbioOzpk1ibfhXUvrGElG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx8vtxuQpPsiUyNu+xfUljvSXC3ursnfi+e1bcOSRWgNPtlbNkajCL2iNHBRzXJ3tL4gdOq5g344cWcit88LHTv48Pi6Wj4AiQ57y62oSuZHwF31yYnUlDP1yNqDirbT/5NrDZ6poI+GjnHkxhWKQm58JrwZu4KPrjHjq8T5Q64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k3CZsYbl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k3CZsYbl"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKRMVB019015
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 22:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OkOpBf2jHdOpnY2dKRzZfr8A
	V66mGASDdTGyX8Gj1ZE=; b=k3CZsYbl6IVyzJiYvjp8IMg6+AloVJA7TyNccJR2
	QXNEHf1jD8GjHqD1oVkHRGP0GRO5oSGwFxDnXsev31VOsqRzUd/CN9CzFu8A5dor
	ViykUK8LI+t0cFXFKC/sDl3nertJ7Jj0NwFT1VmnohUoInfTxP5X4ipTnD9jGHme
	Rh9bALdkV0OO4SU426F9KVXeAUuy2peF74Z1yloAdoGufSkYWorDo4GN1b5ojhy3
	iOG2OdCDXSLn3vypuHgM1UvTeKRI2x9xxzNmgNi3Lnep+d+O1XciETJF0P5lQV8K
	nnzRmAsED9vCAfGp2EVIYFTIvPXZEQAaIPTnXedTZoXWgQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5j89w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 22:18:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88e35354330so17129085a.1
        for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 15:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760480339; x=1761085139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkOpBf2jHdOpnY2dKRzZfr8AV66mGASDdTGyX8Gj1ZE=;
        b=XC67o2JckgYJrt+mZ70P6odn9Ew5HiMTNubhWbI5mVJHggOhNFI9MBKHJJ7eUINJX5
         buTLzkUBE9Cvtr/7wTn6i1toZ7HQurIcXAtZ6MRnK6jN5ZB7FOQkPvq/aY5AuWf8Sz9n
         LIhDI2oRpDPgm2gghMwqJCbT734EUn61tm7YIzVpWNoUWQn17VX398Wdd5b1nHg1jDir
         bTQR1JejpxTTzrnDzvbYQaWQhwKBt7BkTfyKFDJXV/6PaJf5yjDh+mQ+qM5eNiF0SFn9
         b9zb+Wx8s1AILko6pVgYQm80iL6S7a5ctesdJ8/dvIqrNJjAsrSh6DHOAhXoPyQr5Ctq
         vctA==
X-Forwarded-Encrypted: i=1; AJvYcCWtoaxMXh3E1kwOk75+7vV/9c6UPPARvEk3Px/mZ7gQuynkbEhzgUMgYDZhyS1/fkOoaEnFVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm+Evq6WUXwOY3uMIZ++/prbRo3+Qs2/a+B5WHmKpe9XDX7FLB
	L8OXqK7Igl8Uy9MFd5tnECYmNDxWBLVVQEUSbsSp8X2Ma3JN4cXph9Iby8ZimMTzclAtJ+4bIYl
	Y5dgE5wCF+uoiJtzAeJiGIO060bcN2bJ9LkOszI4FJXav76Y7ZFGV12qJDA==
X-Gm-Gg: ASbGncuzLSohet0Y5PtSyiSYPbmt9pQg7TNtXV4R9BQ7f+W5G0lghxeKgCXfJio5zY6
	6khOBTb6/HKXqL8BDl/BidEyFiZbB0BSlO+s/pm6uZOopahOHGtllSsK2/vEuB04S8c/65D9f0J
	PWU56zHdd/SslhCpCdroHnQyrry/yllgijopk/A0iH+N/gh0G12DSADZr70wcveEQZhyDf4lJ4W
	ecSxwAT9JpnCvRmrR+Kh9qnTDxCnM49E4oeWOvhlr3+RIZppTAIPjn+zyzF7uotycMFr/36jjgb
	gm0GBGdZAzsW3ySOpGESRc5KqjKhfgeoMOBBZTSNAHtu3Fl+gkGqaMXkFHFyAihZIB2c1OOPunO
	e3dtZJEZdO8HdSl1xUjwEZrVg5Qs6RDrZmQWABfDrEiq1jZ2n0oev
X-Received: by 2002:ac8:5dd4:0:b0:4c9:65c0:7e46 with SMTP id d75a77b69052e-4e6eacbbd09mr386007751cf.2.1760480338860;
        Tue, 14 Oct 2025 15:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoofHc3p3XoPw0ntgLmVxwJwo1t56LJFp9p6rCx/UWs550Z24zInc1mT131SYTrfrcnEeFLA==
X-Received: by 2002:ac8:5dd4:0:b0:4c9:65c0:7e46 with SMTP id d75a77b69052e-4e6eacbbd09mr386007491cf.2.1760480338443;
        Tue, 14 Oct 2025 15:18:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088212380sm5592069e87.58.2025.10.14.15.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:18:57 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:18:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, joro@8bytes.org,
        will@kernel.org, saravanak@google.com, conor+dt@kernel.org,
        robh@kernel.org, mchehab@kernel.org, krzk+dt@kernel.org,
        abhinav.kumar@linux.dev, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
Message-ID: <mwthowuei7pcqp2b4hg5c45n47iakclkioumc6diyznhnldfv5@wloeoys224bg>
References: <nzqte4glwtpjs5bhkxz43yhdufelxvqvzmg5tepudxwetimir3@bvlw5csjizsh>
 <9d3eeb9f-b8ea-48e5-a1d9-0865f63ef991@arm.com>
 <fhb4woejzh3r6v5dxvdiopnsbuwstucfuuzbiymxg4wrxrjc7t@dt3z3utq6lwd>
 <8d88cd9d-16e8-43f9-8eb3-89862da1d0c1@arm.com>
 <hOs24ZavnUyKYyNwBWwRpYnrsefzBfp95yuy9zyp1ByxR9_3VacGX1Yntt8pCE4w3gllPwvevs1AZqghmwKoFg==@protonmail.internalid>
 <zcgn4xw2xghyna2eysavujbzbiydyki7p7upzzv7one5mdyjy6@sj7f75kc4vwu>
 <fb767586-a376-48eb-97b4-bf33061642b9@kernel.org>
 <a4WDx80rJP1GnGNEK0OOD5lh-m-MiAvireXdpiM9ETLKZ084sBJ2UthU_QqRbU_nwD4XtsdiyEqQ0AhxguzJ6g==@protonmail.internalid>
 <6gx74wxie4wcabq27wo5y7v36uuurez4jxlzanroepqazdlgtw@sdtv2ld47d3q>
 <fa3c1732-328d-46a2-8514-2e7f9ca6c63f@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3c1732-328d-46a2-8514-2e7f9ca6c63f@kernel.org>
X-Proofpoint-GUID: MFGtVtbEGcTK351xy2nVlygeGB2jJ1OB
X-Proofpoint-ORIG-GUID: MFGtVtbEGcTK351xy2nVlygeGB2jJ1OB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX7piHB/LJ3a0z
 EACiXjhHw6kDWI9QgeYSa1684gslgS8P8VulKj4Y3w7W4Ru6z4qmvWCNozWpNoxyAODpQvjDtKR
 tlqGWfi1+Jy4sTOAxgJaWKoTJTnasPbEWhXZiiaexuXHj4PT/08D2lu+hscOuoradPDnRzs+KbI
 xii+NPc5bsohj28j253q5nAqwpxGkKlA6dkXWBK/uIiixpw8VNlpWBUAb/ZAfS6K5kqEuq+18sH
 GvqmohdJhAZS+am6fM1dsxP9okjaDioUt8bxSMLovtluSfhQ+QuMIwUJ4c+NML1O2hSfk58nhMU
 QXV74AYCk92cOaD2AYgEroA4OrPSZVafMH8JR4mTD4IMsybcCcOYRbTK7HIdSfkF4sOgelkD4XM
 1kt/RZS59w4FgRmcfcfkNLVt0FMu9w==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68eecc53 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=GN0BuYHDo_BzztcbwqwA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

On Tue, Oct 14, 2025 at 09:49:17PM +0100, Bryan O'Donoghue wrote:
> On 14/10/2025 19:35, Dmitry Baryshkov wrote:
> > > Each function id can be associated with a device and a compat string
> > > associated with it.
> > So, which part of the hardware is described by the -cb device? What does
> > it mean_here_?
> 
> The non-pixel path video encoder, the tz video encoder...
> 
> What's not clear about that ?

Where do you have pixel encoders in the fastrpc device node?

-- 
With best wishes
Dmitry
