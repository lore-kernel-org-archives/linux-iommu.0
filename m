Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0839D6F6
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735575; cv=none; b=WmJRVMnIgocgzskZfJK9dOqQGgQYXNAaxWdBKgdUF/Eu5zl2FXSAzcLOxWKYRY4jCB6VrYizEkSBYCnZLlL6Bx+4nQHr902JAvnf+Hkah7APq8najPYO23YlO6vyK90jAug9z5X5U7+o9VjkVj9WW428q5SY/szyvsAwn3atPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735575; c=relaxed/simple;
	bh=aB68XFFYRLmpoGqMlKRzfQZGNFVqrsQlDdc5m1k/3bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDcHcSnJ7ONLnN0k2fHTsyac8dgmVo4Bhkw0jgvbu3dBxlG2GufylO8/jLBY6lNLa7dxaffwbzFxazEjbn+NiRIsTPyG8Fo30l/DK6FwLHYWc5WBz+SN+zrbp8RQ6c8G83/ka54aA0otFn1g0DqPz6gRg/NfqPaVNaLXniGKbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nEUsnEwO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cZGO8A/y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nEUsnEwO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cZGO8A/y"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625HUOrm935974
	for <iommu@lists.linux.dev>; Thu, 5 Mar 2026 18:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=07iZIVXXI08IOJ8ob15wib1I
	ig3A0HI31MaQUD8/wgo=; b=nEUsnEwO10p5nKkvA04KFppEgTdvmETK6h2DN6EQ
	YQdgzUi+6E4wNOMzHkUgJAEabU7RD3CKmCifr5fAC0dceijwhCTFcx/J1dojrYMP
	yNvtl98hxJwVsPyj6AcOGxDYYFh3ZztUoxvHCnGAzwtTXyJyZtELwRKJ3t1p8Pr1
	mcz35WTJrnN26xJAmlm2vfKU9eL9vOZIgkwwwYbWZ3L6bmRoLDICVRjxri/sS375
	35GNLjUgZ39AAsEs4kZiQdzWYdrOB8sSCHeu12PKADVnJCIIsnUn0rgxmgKQ59+H
	TZmghTm5bcZKbzkxfn/6EwQsjbtb34iT7kvEFrLbP27Cww==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq04u3bhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 18:32:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c71156fe09so4755818985a.0
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 10:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772735572; x=1773340372; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07iZIVXXI08IOJ8ob15wib1Iig3A0HI31MaQUD8/wgo=;
        b=cZGO8A/yT3DXf6YxrSSB1iPFdVnVd6fdT4VLsGkopTZyCBHhmW1RMEKivrKAfcvSrh
         wYsLpOLaGlVBCcaH1UJ80NbgDtNfkkcg4QaIV2naG+HnRVWUBuNK2nWfzyz3yPV8dzkJ
         4E3hEduLxx636eZZS/INXjjgodPMBfM5LxZH+mADWu+CSGdKwV2LPbbMOnGDLhiEPIFH
         UVR5P4Xya2bnr/fhVQwytCYoUzexIrzS2woNrZpt31bkqk8Ajg49BaNv5454USDxGvgm
         3VyBEjeeQBrTpidTRWFVSNmitIrlyS+8JdYlhqB/93wNcHLGTzrFXQiVx/yc1R3AV/op
         z2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735572; x=1773340372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07iZIVXXI08IOJ8ob15wib1Iig3A0HI31MaQUD8/wgo=;
        b=sKsZgYzi1Gb6ved+k2lbwd5+V+Id2QsTnwT6ga2o79EKcVxHWfzXSfK/oZptFaAuqO
         U4SLNTwMru6QXDYGUImRXWpKlEhnlKJoHSvBjSrA8TUNeQJQWS7QBIC6xxdJSxaGcqg3
         ut9j8YreJ6s6snAYOKxaA4rpxnn5sW36ds3jKRCgwGUcEMO324eWhDViAzdg/SlqIFXf
         2nMov/BPkXwEK/ImJHs9kz5amXXQkPiXPjjFY3hDvtD1ohOxJZSlCz7XWYcAm4nXJ2tK
         z8x640eOVOYObTQPqzZtJc21E8ARm8haL+y0rZ/9ORA4ixRFlaEbHKWH2mS9Nx+COsYm
         md3A==
X-Forwarded-Encrypted: i=1; AJvYcCXXDTAmcTnl7s+drLGXPQZCyDDZUHXBn/N1YjQ216/ENzRZWU+dyjXH9EXVlhZPLXJUU8kBPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo/S5e+URUkdsiOi1sF8cEv6UgBqj3Z5VHNVe1OlBtc45FRzZ+
	suRaz86Q9+BPSiEI0eM3zEpbRv8T9YH59qPYCGw1dTsKU8Dqb0xPrMC8A+rW21v3R8cCCgnGWwE
	fs+kh1AKl5JS6GwcTmJC4u4rRwvY2VrDN4/xMK/iS8wZjIfKVpiT+WEN0og==
X-Gm-Gg: ATEYQzwsFC2dXV2amamV7zCGc+F65ou0r5RJI45/lXWkI4mTpvR68KF7Z/tTbbIOT8L
	RhdvrGqxWo92KNVq4WxNj1mCT7FNlHHSlMUgJ/PK0dTAn9OLoxuZNeUQre7KqttHNe/yEYZKVxh
	TEWlGel947qCBlI1fspEVsuZuW+C7dJFekuvvGJ/FzX4zcNNvs5SK6ZbfQzzKjnXNoyXV9bVFHe
	0FgpygLZWqQ09NG8Ijbd6IM6h+hSyMfiiWcIyQZ8/RUCJKRnDpe7S92CbFqxPMbzhX3WYYstZuE
	SZuX/FpCky9Jj1yK3ix7JGIGgMHhsbyTMtZc4rqTk6uYEUlmHv6r+66UQoK9uA80CBjSKINMdaW
	zIC1nGFuUv2Lnte1g1J2/p8CtzD06u359yGTfrW1X0PvU5qT9TBmupB186L3mEA3KPxcEjfmrd5
	QN8DkKxlYY94/18ziktBRQ4TO2sHLTHnZ/sME=
X-Received: by 2002:a05:620a:31a4:b0:8cb:4c79:b44f with SMTP id af79cd13be357-8cd5af81919mr927054985a.51.1772735572211;
        Thu, 05 Mar 2026 10:32:52 -0800 (PST)
X-Received: by 2002:a05:620a:31a4:b0:8cb:4c79:b44f with SMTP id af79cd13be357-8cd5af81919mr927050185a.51.1772735571621;
        Thu, 05 Mar 2026 10:32:51 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12a6ddd3bsm1366694e87.0.2026.03.05.10.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:32:50 -0800 (PST)
Date: Thu, 5 Mar 2026 20:32:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 4/7] media: iris: add context bank devices using
 iommu-map
Message-ID: <7wvdcjajf7ro3c4y7jq6tmbxfg7kfvdpmyfzqm4vgjw5wly4zu@jcjqudf7vrgd>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-4-850043ac3933@oss.qualcomm.com>
 <rzi7qmzsofocwcqxhsqz3f3tl4ahqnwn34of6qcc54odpben5d@7okuqabxgdqh>
 <e12da06d-cad5-4967-af07-64c7c6e540f4@oss.qualcomm.com>
 <vi5v5bczg2wx2adfpr6ppqcad76oecitoyc7zd2i4lahla4buw@mqnppboxcyrs>
 <6553cfcb-9399-4d17-a529-b07b421ed7e8@oss.qualcomm.com>
 <mqyg7cebyahkrngvnxcrenkdd3dybpnkecago4lqonfwqzize7@yawbtcsli3vi>
 <1d2b55d9-42e3-4459-971b-e276a87fb843@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2b55d9-42e3-4459-971b-e276a87fb843@oss.qualcomm.com>
X-Proofpoint-GUID: VCz8kf0IxO3_nAMlcBZ64-s10Vk-lLpH
X-Authority-Analysis: v=2.4 cv=eqTSD4pX c=1 sm=1 tr=0 ts=69a9cc55 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=k2QkBiQWYh7aNo2zAsoA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: VCz8kf0IxO3_nAMlcBZ64-s10Vk-lLpH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE1MyBTYWx0ZWRfX5Tlnbu/ionhs
 jpcgZc0s+Dk/VY9mStRHHKx57N7yKlZP0njy3hH+ycfiglOCcr4BI38nz/6FZ0+oZohYjg9Nb+L
 A+x1ojoBFI7YYV0kERhce5shfJmy8/d+9dyUMFA5Itma4Q6xiF/K93BpJW5RUXVfPenzOyBm5xm
 CDKdDOFF8btEd81Ns10zGBJdalC3ybryeIytKVa7Cw9HkzkWCBil4batGEpsBlOHagxRN9uCSKH
 xtSnVCpK0+sYsPIrTK0Q0rqfSyduNvN/PTyNsSLl0uBI746VhczGQ6OZuXNi0UAi4sim2lg+SH3
 9zyKNNP/Ezjr9L8R+oi5tPyH8CWo7bUX/TY9VtCslkJLInR9Dg2kYtfFQEY0df9HJnVtjS2sbuo
 jDqSja8Q1YfOKnPhxCqEGVVxWyVP/eaaKRa7nz9byco6ygkXVXuYfm3kcLVKkz82y1iHgM+jF/h
 6uDAQjzIJ5Oh7TKBabQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050153

On Thu, Mar 05, 2026 at 10:56:40PM +0530, Vikash Garodia wrote:
> 
> On 3/5/2026 7:51 PM, Dmitry Baryshkov wrote:
> > On Thu, Mar 05, 2026 at 06:19:52PM +0530, Vikash Garodia wrote:
> > > 
> > > On 3/4/2026 3:55 AM, Dmitry Baryshkov wrote:
> > > > On Wed, Mar 04, 2026 at 12:16:50AM +0530, Vikash Garodia wrote:
> > > > > 
> > > > > On 2/28/2026 1:50 AM, Dmitry Baryshkov wrote:
> > > > > > On Fri, Feb 27, 2026 at 07:41:20PM +0530, Vikash Garodia wrote:
> > > > > > > Introduce different context banks(CB) and the associated buffer region.
> > > > > > > Different stream IDs from VPU would be associated to one of these CB.
> > > > > > > Multiple CBs are needed to increase the IOVA for the video usecases like
> > > > > > > higher concurrent sessions.
> > > > > > > 
> > > > > > > Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > > > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > > > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >     .../platform/qcom/iris/iris_platform_common.h      | 18 +++++++
> > > > > > >     drivers/media/platform/qcom/iris/iris_probe.c      | 60 ++++++++++++++++++++--
> > > > > > >     drivers/media/platform/qcom/iris/iris_resources.c  | 36 +++++++++++++
> > > > > > >     drivers/media/platform/qcom/iris/iris_resources.h  |  1 +
> > > > > > >     4 files changed, 111 insertions(+), 4 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> > > > > > > index 5a489917580eb10022fdcb52f7321a915e8b239d..03c50d6e54853fca34d7d32f65d09eb80945fcdd 100644
> > > > > > > --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> > > > > > > +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> > > > > > > @@ -204,6 +204,22 @@ struct icc_vote_data {
> > > > > > >     	u32 fps;
> > > > > > >     };
> > > > > > > +enum iris_buffer_region {
> > > > > > > +	IRIS_BITSTREAM_REGION		= BIT(0),
> > > > > > > +	IRIS_NON_PIXEL_REGION		= BIT(1),
> > > > > > > +	IRIS_PIXEL_REGION		= BIT(2),
> > > > > > > +	IRIS_SECURE_BITSTREAM_REGION	= BIT(3),
> > > > > > > +	IRIS_SECURE_NON_PIXEL_REGION	= BIT(4),
> > > > > > > +	IRIS_SECURE_PIXEL_REGION	= BIT(5),
> > > > > > 
> > > > > > Can a context bank belong to multiple regions at the same time?
> > > > > 
> > > > > yes, they would.
> > > > 
> > > > How? Each set of CBs is defined by a separate function in the DT. How
> > > > can CB belong to multiple regions? Could you please provide an example?
> > > 
> > > SM8550 would have same stream id for VPU hardwares (tensilica and vcodec)
> > > accessing bitstream and non pixel regions. Thereby non_pixel and bitstream
> > > regions would map to one CB.
> > 
> > In my opinion it means only one thing: you will have two CBs (one for
> > non_pixel and one for bitstream) having the same SIDs. An alternative
> > would be to define fallback rules (if CB foo doesn't exist, use CB bar).
> > 
> > > While kaanapali would have different stream id for tensilica accessing non
> > > pixel region and vcodec accessing bitstream region, thereby having different
> > > CB.
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct iris_context_bank {
> > > > > > > +	struct device *dev;
> > > > > > 
> > > > > > Separate data and the actual device. Define a wrapper around struct
> > > > > > device for the actual runtime usage.
> > > > > 
> > > > > we still have to store the list of dynamically created device. Name can be
> > > > > used to fetch the device from the list, i think the existing approach is
> > > > > simpler ?
> > > > 
> > > > You don't need a list. You have an array of the size, which is known and
> > > > fixed. You have at most 9 functions, which means less than 9 devices.
> > > > 
> > > 
> > > as mentioned above, its not the same for all platforms to have one to one
> > > mapping between CBs and buffer region. Thereby indexing based on array would
> > > be an issue here
> > > It would end up something like this, considering [dev region] array,
> > > 
> > > SM8550
> > > non_pixel_device  non_pixel_region
> > > non_pixel_device  bitstream_region
> > > pixel_device      pixel_region
> > > 
> > > kaanapali
> > > non_pixel_device  non_pixel_region
> > > bitstream_device  bitstream_region
> > > pixel_device      pixel_region
> > 
> > I'm sorry, I'm not sure I follow here. Could you please explain? Maybe
> > by explititly mapping DT function values to iris_buffer_region values?
> > 
> 
> Kaanapali
> IRIS_BITSTREAM IRIS_BITSTREAM_REGION
> IRIS_NON_PIXEL IRIS_NON_PIXEL_REGION	
> IRIS_PIXEL     IRIS_PIXEL_REGION
> 
> SM8550
> IRIS_NON_PIXEL IRIS_NON_PIXEL_REGION | IRIS_BITSTREAM_REGION
> IRIS_PIXEL     IRIS_PIXEL_REGION

So, why not:

Kaanapali:

iris_cb_dev_bs = iris_cb_dev_alloc(IRIS_BITSTREAM];
iris_cb_dev_np = iris_cb_dev_alloc(IRIS_NON_PIXEL];
iris_cb_dev_px = iris_cb_dev_alloc(IRIS_PIXEL];

core->cb_devs = {
	[IRIS_BITSTREAM_REGION] = iris_cb_dev_bs,
	[IRIS_NON_PIXEL_REGION] = iris_cb_dev_np,
	[IRIS_PIXEL_REGION] = iris_cb_dev_px;
};

SM8550:

iris_cb_dev_np = iris_cb_dev_alloc(IRIS_NON_PIXEL];
iris_cb_dev_px = iris_cb_dev_alloc(IRIS_PIXEL];

core->cb_devs = {
	[IRIS_BITSTREAM_REGION] = iris_cb_dev_np,
	[IRIS_NON_PIXEL_REGION] = iris_cb_dev_np,
	[IRIS_PIXEL_REGION] = iris_cb_dev_px;
};


Yes, it would require coding of those functions, however afterwards you
can access necessary CB device simply by doing core->cb_devs[region].

I think current code is overcomplicated for the sake of having the
platform flexibility expressed as data.

> 
> > > 
> > > 
> > > > > 
> > > > > > 
> > > > > > > +	const char *name;
> > > > > > > +	const u32 f_id;
> > > > > > > +	const enum iris_buffer_region region;
> > > > > > > +};
> > > > > > > +
> > > > > > >     enum platform_pm_domain_type {
> > > > > > >     	IRIS_CTRL_POWER_DOMAIN,
> > > > > > >     	IRIS_HW_POWER_DOMAIN,
> > > > > > > @@ -246,6 +262,8 @@ struct iris_platform_data {
> > > > > > >     	u32 inst_fw_caps_enc_size;
> > > > > > >     	const struct tz_cp_config *tz_cp_config_data;
> > > > > > >     	u32 tz_cp_config_data_size;
> > > > > > > +	struct iris_context_bank *cb_data;
> > > > > > > +	u32 cb_data_size;
> > > > > > 
> > > > > > Do they differ from platform to platform?
> > > > > Yes
> > > > > 
> > > > > > Mark them as const, it should be data only.
> > > > > 
> > > > > cb_data_size can be marked as const
> > > > 
> > > > Why is cb_data non-const?
> > > 
> > > dev is being updated once created dynamically.
> > 
> > That's a bad idea. Please make the platform description constant.
> > 
> 
> I can give it a try to move CBs in core struct out of platform data and have
> a buffer region based lookup array to fetch the device.

It might be easier to express that as a callback, filling core->cb_devs
with struct device pointers, as I wrote above.

> 
> Regards,
> Vikash

-- 
With best wishes
Dmitry
