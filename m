Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021012BD5AF
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466945; cv=none; b=ZA4VCzfqJ7mTWu4ISuoeIUEyfScuc/BAbidwoadLLkqA9+F7K0CQ3PdtGJcZS7lzwA5q91TpIbJqGxwLocxfooAFFy8TK1qz1jCKCRYCG5ecybkHEh4W2ySzGw0zxB03WCC0KdCmew0PX2JeKX+RzOwR8L8jlk+MG/rxUNjiS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466945; c=relaxed/simple;
	bh=88MwhoLBLl0h6gGQJ/l9piaAckp8mCR95svQBZRY0AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0MLesxXj20ws5KIMIJEvcdiEmSnvo9psa3wbt/FZwUG5mQaqxKGnocOfIGxecMIrGxJYL7dlFhC6T3ecT7TypHP7tCtRa5Bz4KyUWGPNwrPESQ/oBQvTfg9bqKtX9lOBELVkLJbnOtcqtkYnE/Q0KSNgbz2gJO3shw9qtqIcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0mpjO1K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0mpjO1K"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFwjhd018214
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 18:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JgyeBCAKXfxEVl9M5RNSJ9fG
	fb4hvj/8SPvA2yhEbrU=; b=n0mpjO1KKHOTDOS4Yf8/cnKMs4fBvLpkCuZ56ZrV
	pnrP8HuX3pN0YpoyWTbK4EdcU3IVziN5RT41XeBY9FlEtA5Hdk+RnnnRJJOacPr8
	eUY9aZupFsvNphTb6P9PpLkysRcRj4oFI10/+EE/0zQ5eMhqH356NqeoRNr5ZA3S
	1gdoDKjNSQeMGfM0YsE/1bKAljIECX32IvWbjMl1W+3ecgCYsaIEXEjJ2GLnl3Y5
	cgynbeiiNYeKw7KqyQgAux79yzbD0zgfc4vHY+jx8elR3/s9WbdELeIUnVsNINka
	VjsQNDV+6IAAuVD3TjesPQnomw41/IeJ9auKisQl+zw9Dg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1adxgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 18:35:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-883feb13e83so3260743485a.1
        for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 11:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760466942; x=1761071742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgyeBCAKXfxEVl9M5RNSJ9fGfb4hvj/8SPvA2yhEbrU=;
        b=SWDeVrI8ptUIVBqCBL9UeG72xJjnLTVYNM3jlKPTynIej71hz/GivffvcUloBCAbZV
         A5qc8AIyk/gTrqM0ql41l0D8p2fF+J4crX4MlYzGBRSIKxdLAF7LaOvPUJRZ1YmDA0UR
         12q8ow++TNn5sRfms04fuOitspMdmUniqlQMx5UzGkZNrjnpDX0eOsKaIVf1/TBdUmuo
         MQmSveE0AO1sgdmVMGABw3+fFj8+9YDJOQ3VFpzgsQwSKTaoJjZrdi8Uwt78Zb0LRxIs
         yKuWFgFwpRC/LZcvddamb5CtdqfsYV1h7mA4ha115iih8Xc//k5dUDrwJSqVGxrcyRbT
         14kA==
X-Forwarded-Encrypted: i=1; AJvYcCVC3wdi7kJNw8YR+UgIGFg2/7UGT8DAHJ3nF8vQcM+KNssFAHc6QJD/5MFBjK/CEFNP59JTAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YypydXPK1Wt6Fv67+sYweh0DA7oQDxin327H7e31+OcE3GWf1Dq
	xX+f79AYe2yyrnDxc6sO5wKsOBTGGVxy16erjGhYfHtXD57DuzwXqL2ldmJ/fMnyChMhqZR6Dbl
	eCNnW+M8wwSgYAp2D9c4PJv0h/IGtRxM9jto3CZcn+U6QTubwZPVc953Y4g==
X-Gm-Gg: ASbGnctF+f8ZZawjhDfP9WTnTS+x4MUb+yvtCtreECqRq4ivSB+7pK6goPETztoQJAh
	Qi/+H70wa4AxFaRNIIbCEFoOfBf+/NNMCTz0ckA3bSsRymFK2G4t/0F4UwxL+8inGi+QBHrXvt2
	QxJLV2qfZGNxHiciotJp4m/+olnqT4peaKUwEMfNqFtH//YA/yp/XR1p8Qi2H+DW0Jxs2Mii15e
	7loklPMPGLnqV5bWe3DWYC8FmTtERHl/Ro9Po0C15F+5ZhTr6//U5nwCMHZa4inmo5b4BClWJqw
	McKlqg9YnX66KCVjuJeNhqjDRE/y+I26eygFcdqio+MKcacdtksiopcLxbFku0Qng27nTkZvcnj
	zz8b6nettLGWS40HTvbdP2o/bcOemSaTfTORWXeZaC+eWWqYYlmVg
X-Received: by 2002:ac8:5754:0:b0:4b5:f369:8e30 with SMTP id d75a77b69052e-4e71bd45691mr167116521cf.71.1760466941758;
        Tue, 14 Oct 2025 11:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHofj8LwYDeK6yXRXtAUxitNSZSVVk6QKkZX8yZloH/rMjOd5sZzIPxOGDAxCmCCVgx9cAzbw==
X-Received: by 2002:ac8:5754:0:b0:4b5:f369:8e30 with SMTP id d75a77b69052e-4e71bd45691mr167116061cf.71.1760466941284;
        Tue, 14 Oct 2025 11:35:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e2csm5477278e87.14.2025.10.14.11.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 11:35:40 -0700 (PDT)
Date: Tue, 14 Oct 2025 21:35:38 +0300
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
Message-ID: <6gx74wxie4wcabq27wo5y7v36uuurez4jxlzanroepqazdlgtw@sdtv2ld47d3q>
References: <aec0f40a-8346-4194-8b18-1022fe3366bb@arm.com>
 <0d0560cc-9757-4c7b-8de4-170148d99481@oss.qualcomm.com>
 <ead7cf8b-fbc4-4242-a9da-b313dded1abc@arm.com>
 <nzqte4glwtpjs5bhkxz43yhdufelxvqvzmg5tepudxwetimir3@bvlw5csjizsh>
 <9d3eeb9f-b8ea-48e5-a1d9-0865f63ef991@arm.com>
 <fhb4woejzh3r6v5dxvdiopnsbuwstucfuuzbiymxg4wrxrjc7t@dt3z3utq6lwd>
 <8d88cd9d-16e8-43f9-8eb3-89862da1d0c1@arm.com>
 <hOs24ZavnUyKYyNwBWwRpYnrsefzBfp95yuy9zyp1ByxR9_3VacGX1Yntt8pCE4w3gllPwvevs1AZqghmwKoFg==@protonmail.internalid>
 <zcgn4xw2xghyna2eysavujbzbiydyki7p7upzzv7one5mdyjy6@sj7f75kc4vwu>
 <fb767586-a376-48eb-97b4-bf33061642b9@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb767586-a376-48eb-97b4-bf33061642b9@kernel.org>
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ee97ff cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=hQP1gfvqEBNhzPyMEHAA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: PPOlNuFFfiAz3QqI01jKnhtl-lkxeJ38
X-Proofpoint-ORIG-GUID: PPOlNuFFfiAz3QqI01jKnhtl-lkxeJ38
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX3g4jZCs0mEpf
 XHk/1r3opucXiZ6Mtw/drHMQZHYDBRJFwmeO258Vt/lt9bSPUhiWC42e49YfUOQq0Y3x+nm1Rja
 e3v+tuqIAzkBSBxs6OYtGVgFE0Q78Aiqu8shx5a3t53ZJZ+xLeNu8v1fwNNlpNP9zRQpJyuPHgW
 6ZW4Q81PUbNM4X2W6RG7CjoSQqpeim7mQFVCb2fWXyeLRzQPeWYX7+cH49AInRelNccD35UMwUe
 d5H1dlZmobqZrdfg+JjD+ha0KEh1KSf40YlbS3D626ntX3MHVXtRVjCdY3HL/9BkpCtTmAcVjnS
 projZC1LrSjylQFRiwDoHrJ8IXaSGU2byVV2DBzIS00I+y4mn6+Xa2Y1z3g1vONIJHzljDdrx0B
 +RwryfaIOxkbYxcL3r/O3y86pqza7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

On Tue, Oct 14, 2025 at 04:07:37PM +0100, Bryan O'Donoghue wrote:
> On 13/10/2025 13:31, Dmitry Baryshkov wrote:
> > 
> > And from DT perspective compare:
> > 
> > 		fastrpc {
> > 			compatible = "qcom,fastrpc";
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 
> > 			compute-cb@3 {
> > 				compatible = "qcom,fastrpc-compute-cb";
> > 				reg = <3>;
> > 				iommus = <&apps_smmu 0x1803 0x0>;
> > 			};
> > 
> > 			compute-cb@4 {
> > 				compatible = "qcom,fastrpc-compute-cb";
> > 				reg = <4>;
> > 				iommus = <&apps_smmu 0x1804 0x0>;
> > 			};
> > 
> > 			compute-cb@5 {
> > 				compatible = "qcom,fastrpc-compute-cb";
> > 				reg = <5>;
> > 				iommus = <&apps_smmu 0x1805 0x0>;
> > 			};
> > 		};
> 
> Sorry this is perfect.
> 
> Each function id can be associated with a device and a compat string
> associated with it.

So, which part of the hardware is described by the -cb device? What does
it mean _here_?

> There's no weirdness with iommu-map, you get a struct device for your SID
> and you associate the SID with the FUNCTION_ID you want.
> 
> In fact the FUNCTION_ID could conceivably be the reg. It could be stored in
> platform code.

-- 
With best wishes
Dmitry
