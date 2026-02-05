Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D73D3D19
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303233; cv=none; b=YkARJ3Mj6PDJqraBAr5n5yVqV36NNlr20iQfVRyemRdTkjhVeL4XJ0p+PiVW+oWOQ/ersgHyVvlUacWNyoZtEE4Inyl01ImI3A5MdkcG41ofYXEBZJRkllfXuYoDW1VyNMjAkNRa00lY6+12sbVwRP9l71po3TRLKRU0jUtfrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303233; c=relaxed/simple;
	bh=ZwTws5Wp3s/3u+wvh0h7sn7pKfDk+8i3+HfkFTjhvSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrFQUwsPkV+t2S9RgrjXN7PnnjsIdx82Fw+XnW31x44J3mzbFjs6gngOd/Yk5vr7sf5dhXwMV+32iIXNx7zFyIkV2ORJN+cqzqobVzQbaSQDXUmlZbVmSajZcDaex7foo9J1juZJCWzOclItmEYoiBTMxyX4tko8QQ+ITvF1LYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j48/J2jw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YLOchVea; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j48/J2jw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YLOchVea"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615EOIhP4126293
	for <iommu@lists.linux.dev>; Thu, 5 Feb 2026 14:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3zdqUJw9qtQU1loPiEvujh90
	oDIRx6jke/+KDijdHPk=; b=j48/J2jwaL8GuMAL7XIaV/2wrifuuuZlbBV2O7Dk
	4Q95eKsO3sRpl5R0Kr+e6Nkzi+QrPIrW9dw0QQvkIyjusSTkvFw251lf3WN34PRv
	YhoNJJAw5o/Fcz/8BOQdvVVj8RC/duuQLAINukC88Ve+mHlu4C1ETenxW117jp3W
	vQyrXHIpkBGvkEbUzxwoYLpPK3DTI9LSWUqU/7r60yWTqeAoaArgIDiS3NQZBteM
	BtdG2VHynHWRnA/HygnyOgg5Lam0oUy/EV9ans8tVkJXVqvizSjH84n0TUo/KkTv
	W6raBkfxCJ442Od+YjsAtMZoVfhIjZcL9Njlgik+I34fUg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4vxhr2nh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Feb 2026 14:53:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c538971a16so255697485a.1
        for <iommu@lists.linux.dev>; Thu, 05 Feb 2026 06:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770303232; x=1770908032; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zdqUJw9qtQU1loPiEvujh90oDIRx6jke/+KDijdHPk=;
        b=YLOchVeao2D59nIyQpEmd28ANT/xwrud/EKGgobAT0v7M7tcZcx8iTH8keSoUwMgX+
         paSQIjDPFKjyyvBV2CySahrNURnyEwhDCFo3IUWX5qHPdULe8rYSPIMJ8jEUo2H9Ys98
         DU3dgma5MJljg/Ls2q+B19G1NeqzW3h3uNfXqh0+HcP5F6DckXJrVMAqE7n9q95Vd5ZA
         9INfdQty+yfcxPBT+QSdIf8b8djNicIFkBuCMr6sSPKOX2v967II1UdcE3vfzkrhj/VG
         oQJOdMODGwUm2qcgo90wpnOUHgxk/MYXzGR9c4QMHcbq1qRTHjfpstiuyLZqQey8VnoX
         kRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770303232; x=1770908032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zdqUJw9qtQU1loPiEvujh90oDIRx6jke/+KDijdHPk=;
        b=aIhZj8LZ1QGACNkgdlWuGbgnmwfBIifXTrlCGdsGrK5OFPLA5lfx4RvC2lYm2y+425
         Xc502U33kz1XcrL4E6demOhY/66jxocG2m8ybj0RmUF8xd0eP8XDRv2ySTKLysrRzXKd
         1BmY+jLCBL/8xo1qrv0RbgeEeXVQM9ILRO1qa9qWzEAcKFfH/hiaVXT5R+eloonhAw5Z
         AhBdKeWIPDdUsrgqecItYa3cDfGvdPvO9uVXaqredyuw6ibMA8qk6musYsXR1G20zEfX
         GGFa3P4osAP4ltO9K63cLaqpO/CQ2BQWE+dO/16LJXF+6m+PfhKmc5PhrE2vQaB2dGnR
         k+8g==
X-Forwarded-Encrypted: i=1; AJvYcCWZdjoyBOaStA54jbBwINV39OuM6qppfS7Pf+Csjk7454KX7WjhnAdIKsEiCCvife6noFFoQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX08WTqCpS3J+joa+jw0Rwo/4UgLVx9HzdKwgQzseo56SHFLEV
	saR6Qgu98FXF8106mCDyVqEZ4B3ldK2Fec9Ow7faXjejpTZI4ONhU0jio/O2UakmCnBa2tR/cmm
	9vpjTp/wroyCSV73Ajv6Q48ImkjbUKfDVylm4HwIzk439m3bleYeJf6Y1fg==
X-Gm-Gg: AZuq6aIM6jAS2V41MvBRoy9MlbLtLHjX8on4PKXOwCzw7h+3y5gs1Fn8yMfwp3VFSqL
	RN1DpqIbDNsu/qwDhxHfudc7r9QFTq071VbD9xUmL3W3UHQnuzuPmzUpv6xF1MvVYZEuEN5vYLt
	OxWVSEhSlNb5fuM7mMZ3WqH7WGOOLIOlkpQ53fYTu44iKjXREVCA+vagXCyslBmwcQ/nSFiYy8M
	Ev0d3Nf3AkzvTry2LS73mX04wwUDZyx+iWiAO8WA0ttZp0CJ/WZaeNDqv2uYb21sgVRGcpKOEOC
	7slx2XjvAOUnsCI5z8SXEClVDpxdbS49ZQnwuCqlMSdhkFQl8/VJdzh+TljaOn7ALsuNLMINQyO
	3/wuGIbQm/luJgkGi0DG4PO2MK+nqSt3g8mZw1jFjnTTWlTcdxMzofI1aTP6WWxtCmvNuM2MGpW
	cOTfY7LhrbMv7dIkvSnoZY2WY=
X-Received: by 2002:a05:620a:17a9:b0:8c6:b14e:655d with SMTP id af79cd13be357-8ca2fa75386mr869026985a.74.1770303226688;
        Thu, 05 Feb 2026 06:53:46 -0800 (PST)
X-Received: by 2002:a05:620a:17a9:b0:8c6:b14e:655d with SMTP id af79cd13be357-8ca2fa75386mr869022885a.74.1770303226121;
        Thu, 05 Feb 2026 06:53:46 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e3881b1a1sm1467745e87.61.2026.02.05.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:53:45 -0800 (PST)
Date: Thu, 5 Feb 2026 16:53:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH 2/7] of: factor out of_map_id() code
Message-ID: <zz7n3x7e7dsqgfw7qgppeaqnb3uz3i5bzd3tybzbv6q7zmdcgk@pojvxhui7q4v>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-2-e2646246bfc1@oss.qualcomm.com>
 <47fbba15-6375-40fc-bd2c-8ebf2788837e@linaro.org>
 <7d1b5897-8f17-4213-b893-d99d96afef94@oss.qualcomm.com>
 <j6euiso3pcg7nvewscsfjkqyfl55ajxxybf2pib3622uontj2y@aqj4satyf7b7>
 <4835d0b0-06c2-42d1-aa33-34daa0e7a8e7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4835d0b0-06c2-42d1-aa33-34daa0e7a8e7@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=6984af00 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8BOpGF2gbpNt03PPG4cA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: vw_1qIo6p5qMyLTvgy6Gc2kAi3yW1Wcf
X-Proofpoint-ORIG-GUID: vw_1qIo6p5qMyLTvgy6Gc2kAi3yW1Wcf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExMiBTYWx0ZWRfX/finqAh+w6Gm
 Ps0CM/9nYrmXCIRxH7aDGB1q3H2Z41VmD3p4MuRUtJTk6xplThk0PTziiQeW2qrlbbZbfllLM2A
 vZp9hR6Dve5DowYwTArOxj6629U165weQHmuPeCQ+yCBTCleaSP0KacA41KLXQbX+HmrYuy3A4+
 Xuy3wx32aigTkSvQkGKLV0znmUmxoOWEBOrYGu5L81E3PisisDXslQLZ6DVeuzoozQFSMEhN6Jp
 zjYyMP9ya4HQh+KL6pDEG3tqqm5PgDgmby+knxAN9Gn66DM3zrocpqg4H1FbxX5kpHuLSCDCDFi
 /oX4bmsjoShqrwEM5hlJxaPOWVhe+KE9pigs25L9XvP+H8kQKQZxZ7XbT0mVxy0TSP51Sy1n/ww
 jkmif8aGm6gGT44T8/5t7XmLEF09sUBi0jQh0brDXBDf8YTwaKcx+LITi0WUGDJOvoWgabHvWpN
 liqnCAYg6qqgJXDnOqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050112

On Thu, Feb 05, 2026 at 01:39:54PM +0530, Vijayanand Jitta wrote:
> 
> 
> On 2/4/2026 6:41 AM, Dmitry Baryshkov wrote:
> > On Tue, Feb 03, 2026 at 03:43:58PM +0530, Vijayanand Jitta wrote:
> >>
> >>
> >> On 2/2/2026 8:22 PM, Bryan O'Donoghue wrote:
> >>> On 26/01/2026 12:25, Vikash Garodia wrote:
> >>>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> >>>
> >>> This commit message is confusing and inaccurate.
> >>>
> >>> First up, you're not factoring _out_ of_map_id() - factor out of_map_id() means to remove of_map_id() - you are refactoring of_map_id().
> >>>
> >>> Your patch title should be something like "refactor of_map_id() to prepare for mapping of multiple IDs to a single device"
> >>>
> >>
> >> Sure, will update the commit.
> >>
> >>>> Linux interprets multiple mappings for the same input ID as a set of
> >>>> equivalent choices to pick one. There exists usecases where these set
> >>>> must be maintained in parallel, ex: on ARM, a dynamically created child
> >>>> device(s) is referencing multiple input id's in parent iommu-map.
> >>>>
> >>>> Factor out the code where multiple mappings needs to be maintained in
> >>>> parallel can be achieved through callback from this factored out code.
> >>>
> >>> Which callback ? There is no ->function(pointer, here...); ?!
> >>>
> >>> Just make some plain and straightforward statements about what you are doing and why. There's no need to resort to dissertation-speak.
> >>>
> >>
> >> The callback in introduced in patch 2 of this series. will update the commit descripition as suggested.
> > 
> > I think, the callback was NAKed already.
> > 
> > 
> 
> I'll remove the callback and update change such that all entries of iommu-map are always scanned.
> This would handle the video usecase ( i.e; same input id's mapping to different SIDs ) and in other
> cases it would result in few additional scans in iommu-map compared to existing implementation (where
> it just returns after first input id match) , does this look fine ?

This probably means that we can also drop of_map_args.

-- 
With best wishes
Dmitry
