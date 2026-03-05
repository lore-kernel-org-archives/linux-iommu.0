Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD83A6EEE
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720517; cv=none; b=HgMU0EnYT02eOSjOQ3VC6hIN2l73AY09aD8/i3GNG/IxoApr+ZOLGr9wmmhpX0UwRAccE5BMbj86KfJda0B5Nbkvjvhe5nPeYxMe7HU2dEJxFtxChGDzOk76yvFU0zJVlhIa5d/mapeSrXPO/tgfJ9uDK3IOV2ms1GqGDppTgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720517; c=relaxed/simple;
	bh=wd8r5uIc1SRDv6xBEhA7sLo6Np1+P4tvtporssm1mbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiJHktNVVqsk3lGY5KxWXQ5Olnnu8OmbefGh4C54YjhLgSpLcHY2j3VvnKHed30ZZ+G8QjYjk4Pu2NCPbojYZet3M5V+eB4P+1DlaFjLM7ZjFPzSpJkMq5oV8CtoDq56mS0auBPQ8bXOzAR7TGlUMdr31UYBREbVgr5glQCbkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jgzHtLDM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z6bi3nmO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jgzHtLDM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z6bi3nmO"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AGAlH4171325
	for <iommu@lists.linux.dev>; Thu, 5 Mar 2026 14:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8n5yASa6UKYdxa6WAwgbC8uy
	VQlMLNzzc/irYA5mdHc=; b=jgzHtLDMnx37FaU9EaUiO+btP1AMKHNSzsTEmFgN
	Yhd2S6BPV6kauKyn8ncNubp1uN0RTNK4giNn+aRjuzhIhDzlol+syI9aEXC+GIEJ
	K4AkXY/V4rBnrWLkilyh82nuauhtnygMYDftm4Px+ZJTzDRCw1HL4odZBvjw8DbF
	T43v1c08uKz1LjRayY5N5opOuDPumxjgJY5h0+CaV4sUd1td2N04W4RBsMYVmm2b
	Rf95jQkyHxfB8T1UnyUS4rrHN0r2IgvEOxeWpqWy+3FjDDqpAwGABtzfoXjG08PI
	DKvJOmVgdhuNhTDxj/YTBHIKuZuWWAodKPzFy/jFC0gV0w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuhb33dg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 14:21:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c71500f274so853703785a.1
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772720513; x=1773325313; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8n5yASa6UKYdxa6WAwgbC8uyVQlMLNzzc/irYA5mdHc=;
        b=Z6bi3nmONLUAssoJm+yqkYOsmUEah71m93ejbA53WMHumXmDJRBG9hEyzn0ycwTYIZ
         IESwANo0Vi7MME6as+CK/3S+bql/4q1pCzajn4SP9pH2pnerJFw4il6y5ZilkmI2K3dI
         bJi/nyygPzVnKzCv3I65Bf18GiPvXBUWhhaXgMDDSMRMPWQUfOZvpbw+yQIUf0G7qNe4
         UTl25rWLYImx0svdJ60N/tqd4aZoQQA+1U1ZXE6aQwdPC+g2Y+MetLVMfTfkrMywHQN0
         GKAc+yv1TxbIBQxyLXcQJQkldABRSo3cojgDoGn6H49Kqv9KXfF/OB310IlBACTJosgA
         vk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772720513; x=1773325313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n5yASa6UKYdxa6WAwgbC8uyVQlMLNzzc/irYA5mdHc=;
        b=ev5H2CSllvSwKWphPDf65rOaVSyEloOMNMTwYY2CN7mDXRxoOdBsLCVYEfI3qDc3tO
         wxbRMmsJcB0OTwonenep9FBT0NX9gY/cwhVuXCqdy0A9h8AItYpZQTG1TGrQMSXEbj2T
         DJOqlqkybHJzi90XebkcPuyf8xROqZTZ0oYCTz7rSM7OcdR3iNC2Hdaa536y1Hs6lBn2
         PT4bnltPhSPa6t8coTVZu7hr7n1kJlfaEwsjhX8Kg9CdtffoJABS34GRV/bCoE/io/0R
         j6bKaVX+AzYxR9CxpNSCONTl9GvJvpra00sXhniowXXyRZreWGqhDBzX+WWeo4oZj/Ak
         viWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdNLF9AN8AA2KCmlRnAWYxEf5DetDcBUgwmnvHPwLtH00fQgiMyOcXAEoRmnKavgxK3SuZig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze4gv4EoKWO94+SAbc6l1arO7zbZHmKhH5MejeeX5lfVRlrWvN
	Gu2vPomeDTAdKbgja0cRDA5HMR+Wb3HRrFVzrjOIzrOClb4mRRqt7LExPyYi0bmJWCgRH/t/7dq
	Bvo58Uh8/Amt+yZbdCOxLBvwAPANfZRGpPcXoUoN2eAoWCp19SUmgDcniOQ==
X-Gm-Gg: ATEYQzyGOXIjhh76f7Q3j7mAha0cMjCNf4hNsW5kRrw85gDSdMjf6Wx0w6MGgt9AGpo
	cSh0+EnPsjcZRcze10kLuAl9ayy7trvtyEV+qFc+Eckzn3QanfeH2uyoyPWX7iqXQ1DpCy4WodB
	cqqSHDGHW56r2UclfeEWglg2CPWJMOpd/6Km6Qdud7XVpNikcSNFsetrQ1V1vw4XtWJCJyPtfH9
	IPX/Wlzy8h58DbxLAbwGr/1Os+89kqIkjhPB71hCJCEYbX6Rk+BKuLlMY9MzvtBIgkBKuEPE6fO
	Vm+dGiTNkyYdZTVaz01So3bFi3thzv16HMN54qoMeFr3LCeh4nHFVLLZcdCUypyYTul+/d5cQeX
	/VLf2+5ycLccRGT0oTfQWSQvDblVzqgc8EApnhjbbVlGcBjWhN4OvXIBUHPwqfSIIoe0IdoqFDI
	EU1zuUglHvBkXoQeHSCqegablJNruFQrQDCek=
X-Received: by 2002:a05:620a:4495:b0:8c6:ca30:fbe9 with SMTP id af79cd13be357-8cd5aec376fmr698519785a.15.1772720512515;
        Thu, 05 Mar 2026 06:21:52 -0800 (PST)
X-Received: by 2002:a05:620a:4495:b0:8c6:ca30:fbe9 with SMTP id af79cd13be357-8cd5aec376fmr698513985a.15.1772720511878;
        Thu, 05 Mar 2026 06:21:51 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a135678c75sm226867e87.20.2026.03.05.06.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:21:51 -0800 (PST)
Date: Thu, 5 Mar 2026 16:21:48 +0200
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
Message-ID: <mqyg7cebyahkrngvnxcrenkdd3dybpnkecago4lqonfwqzize7@yawbtcsli3vi>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-4-850043ac3933@oss.qualcomm.com>
 <rzi7qmzsofocwcqxhsqz3f3tl4ahqnwn34of6qcc54odpben5d@7okuqabxgdqh>
 <e12da06d-cad5-4967-af07-64c7c6e540f4@oss.qualcomm.com>
 <vi5v5bczg2wx2adfpr6ppqcad76oecitoyc7zd2i4lahla4buw@mqnppboxcyrs>
 <6553cfcb-9399-4d17-a529-b07b421ed7e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6553cfcb-9399-4d17-a529-b07b421ed7e8@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDExNCBTYWx0ZWRfX8cG4UtTdR36S
 G+vqXeIW3JQf/VLRjDExKJlErFdfM2+KKtH6Uyyc44KaZrc5khc0UNQCfzaeq5Wu46tV/qfMdcy
 aOKhmIQiiGNCwHA6FeEpvvlrHE31NJFEdWllFnVU8gvgbQoWlEHLpmyGDtyp9bdpK1qFv+0SaNu
 aX1FKOTGeTa1bHHacr3sgc3LrbicD8Jwzev6xZGVDETKv8MV7uLGu7r5+CT+I7fFPo2PIhLlYVd
 Q6wC+xqyByVuWaOirtd1/0z7ZTNU6wBwHdRIgdq0Vz+0OzywQ8A8HxODOCkP2uEL0jogjLcXxa4
 SnUyBmILev0dmKr3t3LNcyMF8T/gfWGp+xyvsoHGLD0+BxARlCR0gApgGqX6Di5Rq4WKctgvHmD
 VXVXdkpzqq9IFEFzP+R8enXlXHx3oz75Sc4tiWXHxgTY4ZsbIfisHso37iBUEzcN4OcHPlVaHte
 /xN7u7yyPrk+z8ubAag==
X-Proofpoint-GUID: hvgsrEpzS6rQCEIes67ERoSQsrh-Ex2G
X-Authority-Analysis: v=2.4 cv=SqydKfO0 c=1 sm=1 tr=0 ts=69a99181 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=FVVa7Cb_h39M_4ok-hYA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: hvgsrEpzS6rQCEIes67ERoSQsrh-Ex2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050114

On Thu, Mar 05, 2026 at 06:19:52PM +0530, Vikash Garodia wrote:
> 
> On 3/4/2026 3:55 AM, Dmitry Baryshkov wrote:
> > On Wed, Mar 04, 2026 at 12:16:50AM +0530, Vikash Garodia wrote:
> > > 
> > > On 2/28/2026 1:50 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Feb 27, 2026 at 07:41:20PM +0530, Vikash Garodia wrote:
> > > > > Introduce different context banks(CB) and the associated buffer region.
> > > > > Different stream IDs from VPU would be associated to one of these CB.
> > > > > Multiple CBs are needed to increase the IOVA for the video usecases like
> > > > > higher concurrent sessions.
> > > > > 
> > > > > Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > > > ---
> > > > >    .../platform/qcom/iris/iris_platform_common.h      | 18 +++++++
> > > > >    drivers/media/platform/qcom/iris/iris_probe.c      | 60 ++++++++++++++++++++--
> > > > >    drivers/media/platform/qcom/iris/iris_resources.c  | 36 +++++++++++++
> > > > >    drivers/media/platform/qcom/iris/iris_resources.h  |  1 +
> > > > >    4 files changed, 111 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> > > > > index 5a489917580eb10022fdcb52f7321a915e8b239d..03c50d6e54853fca34d7d32f65d09eb80945fcdd 100644
> > > > > --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> > > > > +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> > > > > @@ -204,6 +204,22 @@ struct icc_vote_data {
> > > > >    	u32 fps;
> > > > >    };
> > > > > +enum iris_buffer_region {
> > > > > +	IRIS_BITSTREAM_REGION		= BIT(0),
> > > > > +	IRIS_NON_PIXEL_REGION		= BIT(1),
> > > > > +	IRIS_PIXEL_REGION		= BIT(2),
> > > > > +	IRIS_SECURE_BITSTREAM_REGION	= BIT(3),
> > > > > +	IRIS_SECURE_NON_PIXEL_REGION	= BIT(4),
> > > > > +	IRIS_SECURE_PIXEL_REGION	= BIT(5),
> > > > 
> > > > Can a context bank belong to multiple regions at the same time?
> > > 
> > > yes, they would.
> > 
> > How? Each set of CBs is defined by a separate function in the DT. How
> > can CB belong to multiple regions? Could you please provide an example?
> 
> SM8550 would have same stream id for VPU hardwares (tensilica and vcodec)
> accessing bitstream and non pixel regions. Thereby non_pixel and bitstream
> regions would map to one CB.

In my opinion it means only one thing: you will have two CBs (one for
non_pixel and one for bitstream) having the same SIDs. An alternative
would be to define fallback rules (if CB foo doesn't exist, use CB bar).

> While kaanapali would have different stream id for tensilica accessing non
> pixel region and vcodec accessing bitstream region, thereby having different
> CB.
> 
> > 
> > > 
> > > > 
> > > > > +};
> > > > > +
> > > > > +struct iris_context_bank {
> > > > > +	struct device *dev;
> > > > 
> > > > Separate data and the actual device. Define a wrapper around struct
> > > > device for the actual runtime usage.
> > > 
> > > we still have to store the list of dynamically created device. Name can be
> > > used to fetch the device from the list, i think the existing approach is
> > > simpler ?
> > 
> > You don't need a list. You have an array of the size, which is known and
> > fixed. You have at most 9 functions, which means less than 9 devices.
> > 
> 
> as mentioned above, its not the same for all platforms to have one to one
> mapping between CBs and buffer region. Thereby indexing based on array would
> be an issue here
> It would end up something like this, considering [dev region] array,
> 
> SM8550
> non_pixel_device  non_pixel_region
> non_pixel_device  bitstream_region
> pixel_device      pixel_region
> 
> kaanapali
> non_pixel_device  non_pixel_region
> bitstream_device  bitstream_region
> pixel_device      pixel_region

I'm sorry, I'm not sure I follow here. Could you please explain? Maybe
by explititly mapping DT function values to iris_buffer_region values?

> 
> 
> > > 
> > > > 
> > > > > +	const char *name;
> > > > > +	const u32 f_id;
> > > > > +	const enum iris_buffer_region region;
> > > > > +};
> > > > > +
> > > > >    enum platform_pm_domain_type {
> > > > >    	IRIS_CTRL_POWER_DOMAIN,
> > > > >    	IRIS_HW_POWER_DOMAIN,
> > > > > @@ -246,6 +262,8 @@ struct iris_platform_data {
> > > > >    	u32 inst_fw_caps_enc_size;
> > > > >    	const struct tz_cp_config *tz_cp_config_data;
> > > > >    	u32 tz_cp_config_data_size;
> > > > > +	struct iris_context_bank *cb_data;
> > > > > +	u32 cb_data_size;
> > > > 
> > > > Do they differ from platform to platform?
> > > Yes
> > > 
> > > > Mark them as const, it should be data only.
> > > 
> > > cb_data_size can be marked as const
> > 
> > Why is cb_data non-const?
> 
> dev is being updated once created dynamically.

That's a bad idea. Please make the platform description constant.

-- 
With best wishes
Dmitry
