Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9836C596
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338983; cv=none; b=OzsEP/bh7bOuSMaGcWVkZ8EtCqO4MalSbM5Dexofo8rcNHDCtre9khUayXYzOba8vzuLamVfnleNyFr9Wfm/mBl2dF7i0sgkqvaio2sOS27KDokXCP8qdRW/ZkhpS1DeENIPt+XGlzigu7fv65u3/MoZOsjTqwlfE9yYvZKlVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338983; c=relaxed/simple;
	bh=vqxcOwwcx7UttqakK8UD/DRJlcVdC0Tnew8a7zoT+gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWL6LJBDWtOdc6aEJAMSQwpDs25pr8OH0a6xAm566FEEMjzRLxGoNd+iYYjJqinjHytzxHSD98Shn2gx3gwoUcaPsBmLBGnusMfeqfbZWv6tmHv+NJfq9LCbfVALcyq/0iuoxumEdO7dRiYC9gmB5eUg37riQF4msPBG0B7vd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o5Z+zH3g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KiOHVQeJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o5Z+zH3g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KiOHVQeJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HB3c2S1942831
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 14:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tMhccVFu61JlJeoDv8T4kyXC
	SoA4xV1WLyaSv7jEbCg=; b=o5Z+zH3ge8DoftYduU03EjXOrNheSDDZss9g/ACU
	BBWyHJmjPLw7gyIqumxxIE+fjkq9EHtAKiKKRwE/OY8R0ulhzu2T2tP1RovG3qDg
	6S55O3Nm4CM/MApyqEDvO7TLmsya+Ka1vs5FurPusxyuvRKTFwoK/nWrRkXIq5xl
	G204Gqo9PI2LC/pXoyeyXeR5xLlCZ9dGWS7OkA+OmmB+aKYlLACsp6UXaW4dlZEu
	uOsxvZf0O1CHEJPlACyFPCVNw9HeMzSSGi9BhZwPcuXGpH88QpQg3WB19FwJShdn
	SI+wj2cLkFABKLu6Cm6Q5qpiKwsv8acMqtIecQaOw4+nlg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccq4g0n3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 14:36:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-896f4dcef67so379997186d6.2
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 06:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771338972; x=1771943772; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMhccVFu61JlJeoDv8T4kyXCSoA4xV1WLyaSv7jEbCg=;
        b=KiOHVQeJn4oSwWL2VSKRX3hJk1wK/VdpSTrU9/ohK4KuD9s4MzrsD+EeIPmO2i+l11
         YOnnALf6Ft8CUuYZf+WRtygDEuOQdE/IM0i1BJR1Mm5IEgT35A8PRvp5lonrefHDD+ax
         kBfN8/XuKnUJbSB5/yJRweaETrZlxTXYxgZ/HDx86gdncqEojK2N6SeT1c16tykngV61
         hluQlivZxXotdWf/6A74ueD416Gq5Iu/sXgMrV/d3PYiRcq4lHlMFNeqFMITqTt2bU4l
         BQmSC98ilRVU4kze+NAZ69U8FbiOeIekTUUvxQ/b1bHEUEY2U5zBCUmrOvONvxqwkTlU
         ua8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338972; x=1771943772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMhccVFu61JlJeoDv8T4kyXCSoA4xV1WLyaSv7jEbCg=;
        b=BQLONVVHY8p6s6EuouHECSL0D6EIP/6Mps9sc4+nIXL+kPhNvHQBTikOiS4QeBXWAK
         kA5r6nzVNYiIHGJRYLo9WXUV7nKqQWIwiPe5QZAwVmdnwxp5nwOqxl8TU042DEChYsDv
         KDDq/PL6DLX6mSYpl15JYg4S2vi23Q/UMXBazGWfKUR8J/HFiyqU57ujnUZ9bL5Xc3ae
         tNVGG1VWSqcy24BXO5fHCqA7ThLJLKkgJo+En0VpBobtCQtOsQmgtBJqjigZGHTkAn1D
         vCUeulyCSjGtgmkcNFgNEjgjooXaTNCqSti9iM5T+RHlDDIGmkmbyXKkY5RFYGt5nFwX
         eB2g==
X-Forwarded-Encrypted: i=1; AJvYcCXHfsHpENQuUA/HIuxaCx/rB8eUwVtkop1SRbMzPYFBNoBpfecL5DftRKRQQOpHxleEwpKXGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw48nf5f1d/GRGr5M1jnG1CM0yMs4mbPRh6r1kqnNrWnoDdxKpL
	Doi3F5nooB1mzN9mmyw8RrgxbxtS0ymv4VkYafbC926BL+/HPfHgaExuq6oaE5wVo7RnxHr/6W5
	HtRM+4uD9s6xkyZHF9BM1eP81D4h58L86+GPZkum4jF+UbRimA+r0ON3sbw==
X-Gm-Gg: AZuq6aLcnyTHHn5+tOxIlSUwG0iEhBpbEnYCLrqn2YFpALgIk1pA4UQyj8mxKQpwvM6
	5c2JG53uU32POHtte6xbVEJwfUbqCUnDuSWnV4EM7mN4JnT5dVAHdmFFmO5xzBs1VPtyWcjgqNo
	D7owHMSynONqj976xir2G1zS0gnRE4UzPdJrF6n+0uNkwL60z5yrDiOleAFUUjWgF/W30F5LexG
	HAfW510qum+g49Po/DpvIW1bRoxY6tRQpxZkHztKeNiVDLQr0Th52bUpnAEdipUKsGMw4azd67t
	Q1h1CF9fn33fXZxvlXAoOjpM9AnRmq7miGB9VhbZbDtJHlqxey6tL8FmSRn15viGkoaxu4lYdCz
	r2zAZGmxXA64fQyuA5KWLztL9IIN5cAXXzCCy251xhI66MqqXDVq7ljgOc/kpViaMZ7kagyFNbC
	m0NbZuIOpbmMNi9nsaQCiGPudP0jGf7R5nB0A=
X-Received: by 2002:a05:620a:404b:b0:8c7:177f:cc1c with SMTP id af79cd13be357-8cb4224b6f8mr1589786885a.16.1771338971749;
        Tue, 17 Feb 2026 06:36:11 -0800 (PST)
X-Received: by 2002:a05:620a:404b:b0:8c7:177f:cc1c with SMTP id af79cd13be357-8cb4224b6f8mr1589783285a.16.1771338971237;
        Tue, 17 Feb 2026 06:36:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5ac180sm3850704e87.63.2026.02.17.06.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 06:36:10 -0800 (PST)
Date: Tue, 17 Feb 2026 16:36:08 +0200
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
Subject: Re: [PATCH 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
Message-ID: <dhcsnc6y2r2bcjlc54ebo2hakc4tufub6f4oluqq6etjzdlas2@ggwzwoz24kjc>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-1-e2646246bfc1@oss.qualcomm.com>
 <r642meaclfme7thmb6spkna6xiuhbjuqw6x32jndjqhwqjtbbr@qkcziz3cyxb6>
 <b5ac0ab7-2540-4691-99b8-18d67ac63717@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ac0ab7-2540-4691-99b8-18d67ac63717@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDExNiBTYWx0ZWRfX6aN1M23X2CCx
 E1D1kNxe0h6dzKYMfN/5QYBuC6fD6yZG2nOZZbMWYrYNQUWCqjklu8Ru9INVcLm4/zqXXzxH7Nk
 4pPnIKJKgfU3aIMP904GcW2K2woELm9bvPXxHowUivWdxQ6RV9uU4dPJN2R5y2UNTszv/RQIOx4
 D2hw9vBhDaSsiJNR45xqI/8VLiMdF5YAQaoM2sISec86EqWZn4qnSI1D3gL4E1WARFRfNrkf4Zg
 jCNIpwQ9q4xKWKbx8rHHZ6EtMDUEQqtjM9hoUI1ofkC2K1J5o7rxfFwPcugpxGZjk7txAGie3Wo
 UD4k1ois9LA+GsmjLAcc3FYSlBn/EvyV9NtCcE2NF794bBcX1MOWKlZi/STLztsItilomS4PLGY
 JBRPAhq4xOj4HfXOljymyv9NN8bq+0GOWtNFEkJBFBVcla3m0c4IIjyfamQCb/52gVEcIQLfMj9
 42IohHMbid7ZU2XOugQ==
X-Proofpoint-ORIG-GUID: Yebp42P0c1xFL_bAWvL5FGv28g7Y_qTt
X-Proofpoint-GUID: Yebp42P0c1xFL_bAWvL5FGv28g7Y_qTt
X-Authority-Analysis: v=2.4 cv=YdiwJgRf c=1 sm=1 tr=0 ts=69947cdd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=W_8qG7m2_GW5Dq_Wf0QA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170116

On Tue, Feb 17, 2026 at 07:13:39PM +0530, Vikash Garodia wrote:
> 
> On 1/27/2026 8:39 PM, Dmitry Baryshkov wrote:
> > On Mon, Jan 26, 2026 at 05:55:44PM +0530, Vikash Garodia wrote:
> > > Kaanapali SOC brings in the new generation of video IP i.e iris4. When
> > > compared to previous generation, iris3x, it has,
> > > - separate power domains for stream and pixel processing hardware blocks
> > >    (bse and vpp).
> > > - additional power domain for apv codec.
> > > - power domains for individual pipes (VPPx).
> > > - different clocks and reset lines.
> > > 
> > > iommu-map include all the different stream-ids which can be possibly
> > > generated by vpu4 hardware.
> > 
> > It's not how it can be defined.
> 
> Do you mean to elaborate the different entries within iommu-map or to
> elaborate the different stream ids and how they are grouped into different
> functions ?

The comment was sent three weeks ago.

> 
> > 
> > > 
> > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > ---
> > >   .../bindings/media/qcom,kaanapali-iris.yaml        | 234 +++++++++++++++++++++
> > >   1 file changed, 234 insertions(+)
> > > 
> > > +
> > > +  iommu-map: true
> > 
> > This is totally underspecifified.
> 
> oneof would be a better approach describing the possible stream-ids.

oneOf of what? It is items with the definition of each item.

> 
> > 
> > > +
> > > +  memory-region:
> > > +    maxItems: 1
> > > +
> > 
> > > +
> > > +        iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
> > > +                    <0x100 &apps_smmu 0x1a20 0x0 0x1>,
> > > +                    <0x100 &apps_smmu 0x1944 0x0 0x1>,
> > > +                    <0x101 &apps_smmu 0x1943 0x0 0x1>,
> > > +                    <0x200 &apps_smmu 0x1941 0x0 0x1>,
> > > +                    <0x200 &apps_smmu 0x1a21 0x0 0x1>,
> > > +                    <0x201 &apps_smmu 0x1945 0x0 0x1>,
> > > +                    <0x202 &apps_smmu 0x1946 0x0 0x1>,
> > > +                    <0x300 &apps_smmu 0x1a22 0x0 0x1>;
> > 
> > #define the functions in the ABI, provide them in the bindings.
> 
> Ack. will introduce a new header at [1] and define these functions
> 
> [1] https://github.com/torvalds/linux/tree/master/include/dt-bindings/media
> 
> Regards,
> Vikash
> 
> > 
> > > +
> > 
> 

-- 
With best wishes
Dmitry
