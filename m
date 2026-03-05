Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B5272813
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 03:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682040; cv=none; b=aanY9rAx3pctTZBOxj4oQgmJHPKJo4oGatsMFeBGhLSbO8KXgBLecdvuNeuwz2lOJmj1xN4kr0NTiifZZOI5l1KfQ0uN455WQmPTU4iDmIE/H3uIMeUqrHyGYwz47uDu5Q3Ryqz1bvNsTiLxCXtfR+XdjQuyncWirRa/Y13mihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682040; c=relaxed/simple;
	bh=nDoC+qnqVRCZsKqhxdGrKL20obiUbD4qrET7VBrVKK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRcrpX1D/rxGzIPgnBfGQ50YNYVRyJSdSshmCNPdZ1WoUc6oKb7tzHcekAEZ2I+5itVJP0eLjQzy51OCYLJ7kZnC7bSCQazQI+P6hFqyR3PPF2CkN9LdoMbjqS2NclHgknywos+Vte9as1kJzwuUUmIYEXeaMNN5kG19Y9DTMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tv6KIY4J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MEn7LGB9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tv6KIY4J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MEn7LGB9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251BlMi3604180
	for <iommu@lists.linux.dev>; Thu, 5 Mar 2026 03:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BCkvYcM+Qnh0dWitG7lZ1F9Y
	4kuK+yrC8gFfslC4rbo=; b=Tv6KIY4JUfp2Qx25CJV1DXyqroVd11nXyEX74ZfK
	uds3p3QsLpIKEWE3f6hdpQS0tesbPKyEKWLk0eCM+nVrNWoyZ/JoMja+6TKwMLYR
	RERt1Ph0uTIE/VJhgMTj1UVI25tMfVAuTX6bbeeAYMsKzoiqvrCqRAvS75xC/whg
	Qc9US4ciu1duBAmY3CBorZ8R8DWIsguLvXk4T2ZHqKwesifwA0yujzqv+bpg8LnL
	TpKT5GjCWsk85lBykjQF+e8nPI9LjaXMJoaUMlHjErOAB7y6KFykdFCANLT8N8XS
	8Wf5+W1wNQovbDV2O8rLBzzByCIpA+CPu7FvoW1TwqsyjA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0w9k0q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 03:40:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3b0d938dso5197310585a.2
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 19:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772682032; x=1773286832; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCkvYcM+Qnh0dWitG7lZ1F9Y4kuK+yrC8gFfslC4rbo=;
        b=MEn7LGB93YsjQ/bWFDij9uoFhUkC9hhf0PSm3KdsXK+i9pme86+/9f8Lru7zzrURmz
         DtD503+TrI87ik6y1zskzic2pAQFiskKzVImmuZk8BQ7LV8clpAu85ErICP/oWQI4JoH
         hgJS+9/331dqKx3p8ZftZZJL0JVQ2TPNye51tOZL2uWaMoSRXqWS1GidApShuXPdb/5l
         omf8Zn6f2xloknoBp1xewVUjWVE0tmyuAMBg+sGgy8qurQ/iAyzM8yAqu3YnxoIFYDMe
         dZNgKY+qfvs8ZwR5+JMmsiZRksr3CMsxbaTjxJHHxZf32Fx2Ilx1MvWWZl9pR3ZEf7au
         60VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682032; x=1773286832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCkvYcM+Qnh0dWitG7lZ1F9Y4kuK+yrC8gFfslC4rbo=;
        b=ZRNqPIeS5SZJUt59TReEQEXwiVkkkUXQdDudZ9NFbYHPl7nU/uxF7neyC1ygbnipzc
         KXOczJ6UDMBiM9dOA5yV22f1641krYHhpUjAmKhp5+vG/3hubg6XLa8Pn8de/NxYHIkE
         0W9ggDCukLfgFTDTf/7WuBQ/sPqkkNqasRhptbwH8oqFrxRoxjhxHETzMVv0YeYDLz4D
         FjcKf7TC5YBQHf1JwWBrheJrqdc0paWOb4EzWwhABGQC+8bx3MwG41TqgSjX79aEYorL
         klD6DfCCvtgxD2P4hQns1HtMoYk1xghaXGNLfIdKyTRX2aM+XYSrX57waMVhWW1iuNeL
         aW4w==
X-Forwarded-Encrypted: i=1; AJvYcCWNYB1dFTZUmyDky3z0WzLi3/iUeZ7CkbXZAKKZYAnV88fK28AUAKWgrN3HUXYMMH3efYSMtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+coYP2BojMlKFL9PIQ96409tp+fevkXL9Qj2PdYAov5fsjAs5
	/aEig949dloce22jkGzCEUSHWzxp0wdYDHWnjxIOa1o8MhUJ9YyTgZVdKFgOGNHFAuwOJTRy58x
	TMX4Ls5Mh7T32xgcn1mqqPvNhbrrVkZfKf6FpXOPrnfVZQ12ZlD3E26fr6w==
X-Gm-Gg: ATEYQzzQZuLexDCNP8BO0NZBIZFPySsq/Zbme1qJSv5vo2lJT7lQcRi9y0vuS0t9Duz
	5ycRNjHcdbFXqH+5rry52GQjxzJAiT/CJGQuU/8nW1oiWWHXZ3TET+bwqbiji/JDXMyYDrYtOrz
	gWIdkb8HU0iyf1EJ0y71aUxxPY9iejI9NS+XMQ7LtuEr0WlTk0NMusUawmeA4a4BLDjbj1+aqS+
	8iRLc8Ty/spOxS6wdO+RPjSafFkk9mgYFYtb9g6ks599N83I5O+S6EPZlXTv3Q74N9mqGneTJHa
	dVREGUYRfxotAY/2QzJju1hk/VXRRaA/ljA4VCi7pizC7bfXyKV/oaZ07RWnAQXvXFRDTnQ3hxB
	Df6Ib7R1DqXoFO8R3ghjq1g2N5AqOgtxXpQgKySmw9PosAK1ay6p0SD/4gjgR6GAuuf3WF+CG/F
	4cOXq3vmGFGxKc6CPTRqw5GC/Ab/FKm9qlbQU=
X-Received: by 2002:a05:620a:370a:b0:8cb:baea:89c4 with SMTP id af79cd13be357-8cd5aef2c3bmr592400685a.24.1772682031630;
        Wed, 04 Mar 2026 19:40:31 -0800 (PST)
X-Received: by 2002:a05:620a:370a:b0:8cb:baea:89c4 with SMTP id af79cd13be357-8cd5aef2c3bmr592397785a.24.1772682031145;
        Wed, 04 Mar 2026 19:40:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1337e3a51sm85153e87.56.2026.03.04.19.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 19:40:30 -0800 (PST)
Date: Thu, 5 Mar 2026 05:40:28 +0200
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
Subject: Re: [PATCH v2 5/7] media: iris: add helper to select context bank
 device
Message-ID: <2coz4rmx2w3iz4f6pp5d26pzwvu246cavauiiiq6bclndczxya@r4cio7nwknwt>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-5-850043ac3933@oss.qualcomm.com>
 <bi3i37ho3ppzlgdx264ohxpcem3nwumjelzckf4x5uzdj5rt7a@2y2jrilmfimj>
 <1dc86b00-9a18-482c-94b1-96692c1dd530@oss.qualcomm.com>
 <jgygscmwovezkytizhh54cmmu5etgv23bgopfqrql3qj7zlhxh@adxo2b7izlrc>
 <22b3e2e9-b855-487e-868f-e72fcbbb22cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b3e2e9-b855-487e-868f-e72fcbbb22cd@oss.qualcomm.com>
X-Proofpoint-GUID: F86AVbyXsMh4s8zZLUjuzym1jb9Kjach
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a8fb30 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=gatHO16CKhhCwir7Zf4A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDAyNiBTYWx0ZWRfX7bTUyIATZqC3
 M5x3wIw/c1oiAi37b4HDMrm9SGcVArXcHs1bWdYXpprpv52Q45YYxnmrbKB4wCp0E8kd99zMwhh
 aPMdo2EhbaaJA0UjFhhrJQwvPuzFcsxRg09bc6jfCC2iEs/9v8Om3pb+pvJeF8RHv4efm3QrBhJ
 14qNEcfKYCcwLireeEudKveDn4UJfElt6xDFs/CRdc6BuqOU/8fIBBt8vDshm1osgGeShvUi69S
 GKfcbwaRNoDREhDnz+DAtwoOayc1pxl7USvsk+dZuCn5TIxnkSbkZopVU+xAVWcyCRkNV+csqvl
 4mF+210svOUpBGO+pNLlWlopjfP38+XdUK3RGAtiRia+JytvKLYL2LJuRSWAx/4qoBx72E/6RBX
 sV7HCfy2d6SCdkFJ1+SSzjFkgrP92hgJv1u+4ODW09Ea7XCz2R8AL5z6VjggbBBg8hLahg/H8/l
 +sC6f1bkgN9GDEW5LQg==
X-Proofpoint-ORIG-GUID: F86AVbyXsMh4s8zZLUjuzym1jb9Kjach
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050026

On Wed, Mar 04, 2026 at 08:59:24PM +0530, Vikash Garodia wrote:
> 
> On 3/4/2026 3:57 AM, Dmitry Baryshkov wrote:
> > On Wed, Mar 04, 2026 at 12:46:27AM +0530, Vikash Garodia wrote:
> > > 
> > > 
> > > On 2/28/2026 1:57 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Feb 27, 2026 at 07:41:21PM +0530, Vikash Garodia wrote:
> > > > > Depending on the buffer type (input, output, internal and interface
> > > > > queues), associated context bank is selected, if available. Fallback to
> > > > > parent device for backward compatibility.
> > > > > 
> > > > > Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/media/platform/qcom/iris/iris_buffer.c    |  7 +--
> > > > >    drivers/media/platform/qcom/iris/iris_buffer.h    |  2 +
> > > > >    drivers/media/platform/qcom/iris/iris_hfi_queue.c | 16 +++---
> > > > >    drivers/media/platform/qcom/iris/iris_resources.c | 60 +++++++++++++++++++++++
> > > > >    drivers/media/platform/qcom/iris/iris_resources.h |  2 +
> > > > >    drivers/media/platform/qcom/iris/iris_vidc.c      |  4 +-
> > > > >    6 files changed, 79 insertions(+), 12 deletions(-)
> > > > > 
> > > > > @@ -177,3 +178,62 @@ int iris_create_child_device_and_map(struct iris_core *core, struct iris_context
> > > > >    	return 0;
> > > > >    }
> > > > > +
> > > > > +static enum iris_buffer_region iris_get_region(struct iris_inst *inst,
> > > > > +					       enum iris_buffer_type buffer_type)
> > > > > +{
> > > > > +	switch (buffer_type) {
> > > > > +	case BUF_INPUT:
> > > > > +		if (inst && inst->domain == ENCODER)
> > > > 
> > > > Can inst be NULL here?
> > > 
> > > during queues init/deinit, instances are not created.
> > 
> > Is this function being called during queues init?
> 
> yes, via iris_get_cb_dev()

I think this is a part of overcomplication. queue init uses
BUF_HFI_QUEUE, which always maps to NON_PIXEL. If you remove all
indirection and device lists, you can access necessary device directly.
BUF_HFI_QUEUE looks like an extra entity created just to get the device.

> 
> > 
> > > 
> > > > 
> > > > > +}
> > > > > +
> > > > > +struct device *iris_get_cb_dev(struct iris_core *core, struct iris_inst *inst,
> > > > > +			       enum iris_buffer_type buffer_type)
> > > > > +{
> > > > > +	enum iris_buffer_region region;
> > > > > +	struct device *dev = NULL;
> > > > > +	int i;
> > > > > +
> > > > > +	region = iris_get_region(inst, buffer_type);
> > > > > +
> > > > > +	for (i = 0; i < core->iris_platform_data->cb_data_size; i++) {
> > > > > +		if (core->iris_platform_data->cb_data[i].region & region) {
> > > > > +			dev = core->iris_platform_data->cb_data[i].dev;
> > > > > +			break;
> > > > > +		}
> > > > 
> > > > You really seem to overcomplicate things. Replace array search with the
> > > > indexed array access. Much easier and much better.
> > > > 
> > > > enum iris_buffer_region {
> > > > 	IRIS_PIXEL_REGION,
> > > > 	IRIS_BITSTREAM_REGION,
> > > > 	IRIS_NON_PIXEL_REGION,
> > > > 	// add more when necessary
> > > > 	IRIS_NUM_REGIONS,
> > > > };
> > > > 
> > > > struct iris_core {
> > > > 	struct iris_cb_device cb_devices[IRIS_NUM_REGIONS];
> > > > };
> > > > 
> > > > region = iris_get_region(inst, buffer_type);
> > > > dev = core->cb_devices[region];
> > > 
> > > all the regions may/may not be present in all SOC
> > 
> > You can check for dev != NULL afterwards.
> 
> with one CB to multiple region mapping, this logic would not work.

I'm not sure I follow. We always need only one CB device and we can
always access it (or check that it's NULL).

-- 
With best wishes
Dmitry
