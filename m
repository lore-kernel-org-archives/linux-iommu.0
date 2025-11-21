Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD012EAD15
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743226; cv=none; b=M1ft10Rwmm2wDhtKmVCZqFKobAw84ScGUIfjGtHjTeWQ/vV+yHmhMcgzDHQE7HTdmyc/hdsUO0b1fdSh+/W0YpEtfX6QxMoz46z6l6SJ846FrztOrKzJb+1no5g/lU0Z0hpOX36TCeWo/RRu9QmjVFlrj7fB7+BWFyP7Tu3rezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743226; c=relaxed/simple;
	bh=niU/0bNMZVJc9XhH8RelUI2nqUiVxLvkZfCT5b8yQTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPOYTW1SeveKnz4SYaqS3Sk3WE+Bu9QLhMQQ807UwZCleKMcrOjfS9e1iKBPxfCtYSRlJO34jge/hq6z+bxTBdU25r8SmmyAwz/RvOJzelBLqddTtWZ8ajPNt+mUhSEApdtpWtN7m/vaDvMeXmj0R8LMqLBlcixRxAhT0jZejpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UnI1TEGl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PBtrRZ4d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UnI1TEGl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PBtrRZ4d"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALFphmd3139652
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 16:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kprjKRtKl0n0i/dHrrgwjUEd
	NIGv2YdzG2Fgt9Vl3Y0=; b=UnI1TEGljlJeuSU3ut0BWCMcO2r/AAYhkFJ1lqwU
	T6QUg+YMM7CuQh2VP2QHmx0rV9/c4t0jcsQVNdJ8BVxRsI8bUXfY7JoS4KemizQ8
	3MuWGv7/ydIvJ9vp+nA86EAuQtZKOTPBCoBdnyDX4sw6HrvlMrwqaaOQHIyXM5rt
	Ou/eIgiC5pR47EZgt5Btkkqf9mMOlBzxNWChB+DgdR4K5xZzjWW2CSCnHbS/pcUb
	7y1PDNmFCoNhUdpSZsmqPVZ7PLHHx9NoHO62gj/3joGTDeo7y6oT2HoI5t599nwz
	AHd9di66dybx0fTKenclCIfNAdlyu8cKv8IXgP9EmGw3DA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajmpphng9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 16:40:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2e41884a0so654762785a.1
        for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 08:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763743222; x=1764348022; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kprjKRtKl0n0i/dHrrgwjUEdNIGv2YdzG2Fgt9Vl3Y0=;
        b=PBtrRZ4dK0UZkwWcVyYuHAHYZebx9COtuAgffyxS2nGX2Tst5iun3c5hapJkKqXW+6
         bPxjdC1NvawWF1X9Gg0bytchAQSsJJNLSgJsPejVWLaeDXGOk/i995lL+6UvG2vyRm83
         t6INSvnSqoqAiiWvAToVwDNnlw6Yb4QpgP5rsAc3hxEmhlzgqrSCJyN5iSUmi672pttH
         b8mKy05OQVsAPw03sZHMTbCfmIADswJLtuMwWW0Px9TI9+PfahC6z9P0k3VADVwePA7/
         KGNcwcna0UD5x6cJX4kR2qk+Kx0KJFaeLO8NLAK0a0I1MX/auS/C63CAIJnZghqMBhJ1
         Wxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743222; x=1764348022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kprjKRtKl0n0i/dHrrgwjUEdNIGv2YdzG2Fgt9Vl3Y0=;
        b=gvmPX036F25aUyr7fAzMPqsb3BNwm7gv0aDgMbDZvLBZrvX8kOhYveNiqYv0Hwd4KN
         GanGf6vzT+d0RQuNx4d1+IixnTzUelu2R2e7OzPh2j83iXBeJ/xZo5ksMax8GppZT+S9
         3dP4EX3W1O+4rHniqiM23vLwSVCDS4MfBGIE8/3Y0THH1zi/9ZG3SCPDuLLeF2VUAuVZ
         JTO3YcrgEZIp3v8nsinZIxkpflFHDnO50+tzmCUbVba2yykywDCbJq8kYGrKWvHMnRAm
         +7ABI8EeGFDlw4UbZ89cOEJVUuh+Oa7ISxioA+v3Q0IubIoTDlKIF/pWNcrWJejw/QW/
         Pwiw==
X-Forwarded-Encrypted: i=1; AJvYcCV3xvjubPqgWTzWszceEOrzLwFEjXLBul0PTwOviq/MgGDP6mHq3aDvVjdIOZcydF3FwCaLPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxI0BYSn+YewL+4dJPLM3YJvJiqxH2mPV/gR+JhgNZGmIvF7ID8
	Kzhlm98XvoYP9674GA7NmNg7PkF5h1lVGej6tzdQLQHc0GvD2tp7/8iAmmv/Zb2T0avcJD1QJM1
	0IVWe/GI4+KtpfHfM1DtupJhKJsTE0nTuFM1Aeg1OPp/uyVXfiijLE5e9hg==
X-Gm-Gg: ASbGncswC4M0NxcwUamKZ6ZkRixGKMt3UK7iYUsoX06ID+RhGwmGaerI50X6NnDi/LC
	07rdBBwqDm/YjgsAFXlvP8q7eDxXo+rdC4MoWc7a9bm2utUGj0TrApiMLDEPBb6ZTHgqdYSBM2J
	htBkrI0Ho0C8SkzXiRwmBJDxnkOGrKOa8QYmWxaXZ4BPA3TIn0m+dGs6Pnd1ZKpe2A7+oG+vIKx
	c8ae/kU1m9V2DMca1BWHL9yEi1xXE1AvZAj8fRvaTjdSQmzZN1QECIJHLZ1JDgpOAbvhYCgV9tR
	wi74PD+qo39WKyxxYb8/TALzTT6PqDKyM5Un/oPRMg/NFNm7pduUfYGOEH2wUW8ZbL9WpkCrxP/
	yLzu9nU51o7kzDdAH0bKH/Rv2QChrwwpT2JTawGOKg8OMucjB9wwlOJcGIbYqDSLI+trS4B/ihX
	fd3ncShZjBIpDya/YNQ8eiPSc=
X-Received: by 2002:a05:620a:4629:b0:854:b9a1:b478 with SMTP id af79cd13be357-8b33d1de1f9mr327026285a.18.1763743221606;
        Fri, 21 Nov 2025 08:40:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+44Keo/qyO3jQHDmY6hSHEbl8ueDkc9bkqlJNNG+Ts5L9XKK8P1iiUYwzusZL9p/Qebr8fw==
X-Received: by 2002:a05:620a:4629:b0:854:b9a1:b478 with SMTP id af79cd13be357-8b33d1de1f9mr327004585a.18.1763743219235;
        Fri, 21 Nov 2025 08:40:19 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbcd137sm1750884e87.94.2025.11.21.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:40:18 -0800 (PST)
Date: Fri, 21 Nov 2025 18:40:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] iommu/arm-smmu: add actlr settings for mdss on
 sa8775p platform
Message-ID: <mxvscsve6otq6pdqfi2w5tncyvg5sqezmw7lrhegg3okl5yznb@276udpr3kdse>
References: <20251118171822.3539062-1-charan.kalla@oss.qualcomm.com>
 <himyof7napywkc44vre5ncqsatkkaxqnqbhjht6hjt53lakper@4wlwsvxkkamc>
 <50bd3be1-63dd-4bf5-915a-02d923fb0376@oss.qualcomm.com>
 <09b933ab-eba4-47c2-a667-370dbeda2749@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b933ab-eba4-47c2-a667-370dbeda2749@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: _ca4qz-CLIFrmmMVaOejadXTQxVXrOHU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDEyNCBTYWx0ZWRfX1JsDai3YA4tR
 q4vB3cD7cZs6xAuVSRtjXFSCDfyjbot8nVgBTUk5YLDdMr9l8hSEYw+Aupm30rGceaIPdOKczhJ
 Tt44Ypi3Mw3I24bZzfewLSCExwS6UoecX0x55Eug+vDo6J6UU+b/YlGwKJhXOHvk0ydp2B7Uibn
 ij5A82p1kCPy6ESMVCKDHWBAkOeTEIfdojc+hmxzMSPYBgoDMSVEL/QP2a7W7SOG4mBbBv4ywnM
 fpMlC8GaSlurBTBDOpPVD/L803s2WH8ZFx8kZniifXo+bMPJpo26/hFZWXbSXdMIowBMtn8gy3+
 8R4vy3riLYP1sZwRbPSgkNnTawMXedEAeJcXaZ5FjzZLc5p8RK4JBXB51ZWAnjwztRQ3ubtTYzq
 lXMqLBzK56PEfCpeUWqpLBIhQfc82g==
X-Proofpoint-GUID: _ca4qz-CLIFrmmMVaOejadXTQxVXrOHU
X-Authority-Analysis: v=2.4 cv=CK4nnBrD c=1 sm=1 tr=0 ts=692095f7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=X_2vKkYTdwsKauOBYDwA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210124

On Thu, Nov 20, 2025 at 01:33:29PM +0100, Konrad Dybcio wrote:
> On 11/19/25 7:06 PM, Charan Teja Kalla wrote:
> > 
> > 
> > On 11/18/2025 11:33 PM, Dmitry Baryshkov wrote:
> >>> Add ACTLR settings for the mdss device on Qualcomm SA8775P platform.
> >>> This is achieved by adding compatibility string for mdss in the actlr
> >>> client of match table.
> >>>
> >>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> >>> ---
> >>>
> >>> Changed from V1:
> >>>   1) Added actlr setting only for MDSS and dropped for fastrpc. -- konrad
> >>>   2) ACTLR table is updated per alphanumeric order -- konrad 
> >>>   https://lore.kernel.org/all/20251105075307.1658329-1-
> >>> charan.kalla@oss.qualcomm.com/
> >>>
> >>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> index 62874b18f645..0b400e22cb00 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> @@ -41,6 +41,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
> >>>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> >>>  	{ .compatible = "qcom,fastrpc",
> >>>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> >>> +	{ .compatible = "qcom,sa8775p-mdss",
> >>> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> >> What's the difference from SC7280? Why don't we need to set CPRE?
> > 
> > Sorry, I'm really not sure If your question imply to talk about the IP
> > level difference compared to SC7280 for mdss?
> 
> "SC7280 has MDSS, SA8775P also has (a slightly different) MDSS, is there
> a reason these two have different settings"
> 
> > Regarding why don't we need CPRE -- these are QoS settings that does
> > control how well hw behaves i.e., related to performance settings not
> > the functional ones.  I guess, these settings are derived from factors
> > like how many masters are sharing a TBU, how crucial are masters using
> > that TBU(like important ones may be allowed to +7 or +15 and may be
> > others upto only +1 prefetch).
> 
> And this is a good answer
> 
> Perhaps you could reword it a little and put in the commit message to
> make it clear in case anyone has the same question in a year or so

Yes, please. It would be really nice if you can add settings for other
MDSS devices too, not just the very few that management is caring
about.

-- 
With best wishes
Dmitry
