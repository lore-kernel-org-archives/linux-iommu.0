Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1427467F
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868041; cv=none; b=brvQzK9oyXvAkfqkVgchmjeyHULARQ+lY/Jw4aN2gZ9mv20SXjdhBgSusLtBJ4LgEtWebfqKTHR+qeFuG7oIW/RF/nUnYZfhZ2RnAT3LgOXKyM9uiTSm52CGfp+k6owDwXcK/6sBvmkXpFtjwb5MF7ZrVAg4z9G8bMur0Lnzlb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868041; c=relaxed/simple;
	bh=/CyOZppcNe93Z6hzK4bpoNbGHi+JfPn3kvzt6swWHXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWsOmSRohhc/AtHtzEHm9Z3bJYIxdnj4S7RkGO14z05Hf9cRiGzn86WvAoGktoTCBmFvqbInRGVSZeUKxrwPckwkzIZDhFdnCOFNJhcWpYMocCJ+xSlp4gvJT4OISE6zMfOzXr5uQ9tBk+A+j11udFSBdc01tAgYeFkpHEVuRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YB5i6dT2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q5ry1LWh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YB5i6dT2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q5ry1LWh"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M9kTe02000973
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 14:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZI6un5BavEyqM1TDZRUrcytw
	/TcpFzRRDb/rENA3Y38=; b=YB5i6dT2eGcXvox8T92EPViCm0RU+bJEYkR1HOtJ
	6TwEV5POcOa5q1EftoUHoKeSD6OVF4yHZV4+mERGTVKP7XYiuTshKDei3ea69Fx9
	4zG6F4ehO+SS2MdYx70+gObpVGaYwex6vWr63VdId9bd/FDvyxdJgJM9ptf/3BGE
	Cq+Nvo+qnRbOB7a8CMX1wjqhpwEQLIEH7wGpqae3wZn1nQXdPJ0npZVk5GH6Fn9s
	NlBzOZth+MhCTqfeZ0s9nEDFUYoeTYjRNLs/JOHTowf8P+dDO7DpDAwqpw2b8V8+
	JoLrzi15Y/EkvC/IRKfukcXLeX/jRjgSgrs41fVuyt133g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfbug2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 14:27:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b24af7ca99so73937255ad.1
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776868038; x=1777472838; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI6un5BavEyqM1TDZRUrcytw/TcpFzRRDb/rENA3Y38=;
        b=Q5ry1LWhicwLaRgUESA+KACPQQuGtyziG2hoJVG3L7BVfkpQ9DwFab5I7C7TmwOoF6
         5+Ls/Ab1gcITQClY1QNlSS0s4PTVBZl30Sy57RkFqnPGJApTjTQq/XB8FsoyoNcmkGvN
         JBVwf6wehVYkNMn5kN8A1F7SrdWouLf9v9kqdjFr1uVENgwWOmvuWGVu7efwQqryof6I
         xAVN4DMGScEpfpKK59M63LFOyxLh9ovkDjs25c5WJlOiv2tRVKJqfdR5ngN0nyNZDgIf
         YPegrCIw65KN4IxmyZgZX0hnc0HojjTH0rbWidSU9tDgk9rBCgDlJsqr6hk5lml5JT9D
         tHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776868038; x=1777472838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI6un5BavEyqM1TDZRUrcytw/TcpFzRRDb/rENA3Y38=;
        b=r1/L12IK+cL48V/NuZ3VvHiMamwJDq+HO1o6dfCns4SMvI6sGTEVrB/KAkuO6YBcAv
         eN2gJU+j3r70SVJPtOcaUAOPltaOpNzATYrZEHxnYtrQirV6HkjE+SF4nmZwiK71b8pD
         MISi9ATYBcSn0sVQGyesV/8dwG2UQiyVtXKRCtVafv5cy3dzoDDxOYMW+Q/OjIzAsg6v
         vjSqWr3tDgFCeYXQI6EW0ywgJZn4krs+2A4gsGEX7SdCYdVSsfAgLjGTNmCwLARM4PKW
         523CbYEH+KAv9HcixqAS/Ag59WEsDsxeo616P0FgWcj3wp3ACUe/m9DuZnHxh3K3ITB3
         VMYg==
X-Forwarded-Encrypted: i=1; AFNElJ+AiOvn15N1pNGx+Tp/bmFjriM4XXUI8rWh22xC4Ktqus9Tt88ipiDP4KnOszVjZ76nU/53qg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxu9MU7OMPdWjvGOvARneEdbuJuAIGqFwPb2SQY5Zgg54Izk7pA
	glkP3NzBD3V/503bpll99SyiRAt5wyfqpjnm9KuEkKd0JI0ZLv0folc7qmHRHuRI5W/+WT9xDnZ
	q1G2xgK5l0yLUI4p6lwbKXZmsETuFCxrP3oeKfDy5SsS1jWgsb9DFi7eElw==
X-Gm-Gg: AeBDiesxDEot6QhHv9X94j6Q4jaoL1vrCBfZZEvmiXGPWekq7z5f04NKbYusyIt4vVI
	xu3x6/yyWsCvXG0/lU0vhh6W1T2GHxgosKtp5D315FiyjTGYLp/48ih3fkbzFQciRws/di+sVni
	1LDGuNcZ5F/ErYCSDw8t/dqjwSkp04nPp8lOKfP+osE4DV5jjU/GRipxnOLE1JOaxJNDk3gP0dI
	e5wuwllYKhllToJPFu0UgNaera9b8MtWr7gNDbM+is1rQTY+Oxo4ghYDS/v2oGE+49IFMrLwiSA
	G4aDmM/6Jq5bgK3ztGkSR36F7uQzSkzrTUMRmGsEULUeQ57kSaqG1gzhTXjIGn67iz2YeM6RHuw
	jIX6K7NjB25GLxJ85pcCU495JOlQyNsRLDcerILasaHQ6UrBfBmBECTtvAqc=
X-Received: by 2002:a17:902:d58a:b0:2b0:ac1e:9737 with SMTP id d9443c01a7336-2b5f9ec5ea7mr239645405ad.12.1776868038367;
        Wed, 22 Apr 2026 07:27:18 -0700 (PDT)
X-Received: by 2002:a17:902:d58a:b0:2b0:ac1e:9737 with SMTP id d9443c01a7336-2b5f9ec5ea7mr239644405ad.12.1776868037484;
        Wed, 22 Apr 2026 07:27:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab40786sm180030785ad.79.2026.04.22.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:27:17 -0700 (PDT)
Date: Wed, 22 Apr 2026 19:57:10 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: qcom:: Fix Hawi compatible
 placement
Message-ID: <20260422142710.2f6f2oijbsjojbmi@hu-mojha-hyd.qualcomm.com>
References: <20260422083329.885979-1-mukesh.ojha@oss.qualcomm.com>
 <d1d24380-06e8-4833-b893-631c063d77ff@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d24380-06e8-4833-b893-631c063d77ff@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: bGFjkHN4I9sddDtIjsTX2y-BAyIo4zGW
X-Authority-Analysis: v=2.4 cv=fozsol4f c=1 sm=1 tr=0 ts=69e8dac7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=IoJxErfbLMQlTqDHTqwA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE0MCBTYWx0ZWRfXxY/DoJy72lda
 DPyta5SRi77tUBttDA56l8dGCmPEqdc3AWyDvHn5K2jAstpeKj1OSLgxdiF+OuP/5j5bt52H/QP
 HKzO1t5UjO3oXEZkTKsv1mAhB8bbskH3UY7BkYCTkEfhz4E1zQCXmv3bBVs5OdYhC3KwsHBDs5A
 Q0L6IUkE1RkrAh35X6wntk04vP6esTvtxLoWGbsEVrB+frXgq2dt/BxFlgPTC5vR163MvL96T7f
 /PGne6Je/JbfsC9F5bjbTdcpuGbhMt+C7hEVk53Wq2lgBxEXwUq8/1sMx1XIhjoAaHOKTSLtC1x
 4dUEGWOlTY8ZCzTf11rEkwmcLHB1szwYQazE3WkJzCfcQBNN3iYUDWuGXpOrMwNa+0B+yIT8iyP
 YFgxx3LflZ+UVJHpHyqWE6J7+Ir9KM6vzs0GB5tPmTz9dfKfYCaoQOI03S5uYJpGZcEWTyQHW5v
 XAxiEwdsvNqdoDCBPJA==
X-Proofpoint-GUID: bGFjkHN4I9sddDtIjsTX2y-BAyIo4zGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220140

On Wed, Apr 22, 2026 at 11:04:09AM +0200, Krzysztof Kozlowski wrote:
> On 22/04/2026 10:33, Mukesh Ojha wrote:
> > qcom,hawi-smmu-500 was placed in the wrong enum block of GPU. Move it to
> > the correct location alongside other Qualcomm SMMU-500 compatibles for
> > CPU.
> 
> How could it pass dtbs_check?

It was bad on my part.

> > 
> > Fixes: 5e8323c3d528 ("dt-bindings: arm-smmu: qcom: Add compatible for Hawi SoC")
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > index 06fb5c8e7547..ba9ad1f5a8ff 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > @@ -37,6 +37,7 @@ properties:
> >            - enum:
> >                - qcom,eliza-smmu-500
> >                - qcom,glymur-smmu-500
> > +              - qcom,hawi-smmu-500
> >                - qcom,kaanapali-smmu-500
> >                - qcom,milos-smmu-500
> >                - qcom,qcm2290-smmu-500
> > @@ -93,7 +94,6 @@ properties:
> >          items:
> >            - enum:
> >                - qcom,glymur-smmu-500
> > -              - qcom,hawi-smmu-500
> 
> No, why? That's for GPU. Why are you moving GPU compatible to non-GPU place?

Earlier commit was meant for CPUs and not for GPUs, hence moving it Or,
Are you saying do not do the movement and add one for CPUs ?

> 
> 
> Best regards,
> Krzysztof

-- 
-Mukesh Ojha
