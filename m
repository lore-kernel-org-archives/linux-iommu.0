Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922B30B520
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559063; cv=none; b=b7Dn+MpI+GOkM28/4I/VYltRpFofDSsw1qxC1tmVZa07hnSiPoV3UnidbTm6YaGViK+BFyRjNBFYIvSQxSDwfesWgiHugCaa0GI+kqTW8b4u2bjFpwxrf5hBRBUhpPE0lff4EC1OWii314SqWPFj758ibYK2/xncQyIDyHXl6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559063; c=relaxed/simple;
	bh=sL8XlQVWDbCwMxkOGY+GElcggW9WEH/bRfpKika/kno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBKZytjRcpMeA+0pJggQJmJrhC9s9bwRd5S5a+w1hkMVUiuJ4Ns7JryqkUW4Rn8cMIJt3FnvYYupZ1Z8SiWyqEhf/Ka5braBPSs3mwRkVoKoGIsc/N7wv4bCbBlpbbsfsWJRMB8mTdJBOT9Tita+VPFJ6nSU4YZ0fmYQJCPhbig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oI0tZ5hX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oI0tZ5hX"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FIcYwD004682
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 20:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/t1dCpZdqV7X1GUFpSEVkBel
	pnG5Nvy1baTgwTwFhOQ=; b=oI0tZ5hXRsmVkvIp3yVduM/Fb5Ze08QMasknNW3G
	KR90J6rTB3TA6qEr5k4rZGFN8MkvuZhziUONN+OWllEQ0zTgpwrTJp7r7k0CyAkL
	uWGTVA1maNugwqGSW7Jb4iLoxQxC6csqeF95N/ZVsVfDo/YW4vs2Fbm2TRX6oYsJ
	OQxmQD0DKXRZIRZZaIBHwqIbLsBzUE17U25Br0SU8Zh7veibg4k0zodmDddYsDTI
	12V0P7vnQUydLZUs2QxsA6NaAGuNu4jTKSm8MDwCty3p6Mkml50Aowzwn3uU2Q0O
	dMPQ1qyqIccATaJ5Xy2lpdub07plqyxDGOhhjNM6XYV9GA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwr3b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 20:11:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8645d39787bso4225136885a.2
        for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 13:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559059; x=1761163859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t1dCpZdqV7X1GUFpSEVkBelpnG5Nvy1baTgwTwFhOQ=;
        b=Mnky/WaA3o6SUbL0OYemorRNbamFArIpjSCPoXWgPREiRKthjeJ92EDbO0EvFj1h8w
         cBh3XVXKE1syuMieioDYUODlVg5ESifOq68g6omdWqIN1NeQUAfs3DudV9Fb018BF6gM
         xhKS8RQrvo7481kqCxUtS0yACKkvs6ib00eLbVOjZDw45gOrFWfAzEqv6MNoMs5M32f4
         NBBHSgFTqN6etmLmSrj8uPetoFxfqIMqHLkZjp07tLbdUxKEtoU5OVuj3qRcc6AkDY1A
         yhhCLc7vlKbXoznkz+bjnjImKx0paPxkMBY6NHdZKGFeO0KFojHEZTu1KphLL7YxHRNF
         1dCw==
X-Forwarded-Encrypted: i=1; AJvYcCXZi5sBWQ9L+JFXd+Itcv4pea1/WqYL06PdA9IaZpeZg1Yh/xPhR3SU1RmA9LOQH77reMXyeg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywftsp7FXyLu7OjBpGlGZw+NAH5KkwSNx3APu4PI6CQUdWfXyXl
	W6ohdfIWHWbExmXOFjiAwQ/5Xw8VVMPjVBqVi0iv+vXs9PvDP7JYVvSD9gTg7wsEFc4cCEzxeyb
	PFMZSaQkjdu2f2kgNRa5NNxllJjsnZ1u0cxyy0W351JDoe/SY07k/ykhc1w==
X-Gm-Gg: ASbGncsuG8ESk6sB6vTIpyRPySHgjvY8vIvK0goytZ1f8LPRwwrTycbhMKU3adYXVOi
	PzxRuwisW+7OO0G5OtsBOc+t8fePr4VVkAsUkG79izCgpCVyFDXUR+bkOGLZLJ1xiPBC4O6PXdS
	seQdXWYG47f1MmtXZYkUdLWIF5Nr4SfPSTmx5e24nUodHrZOBh3gTaHtTGqG/d/+WXE2IjHsh4l
	AwXEepLVTjolCfbxgBzz1EK62DTOdB0YKI3BBdnPSGHKsMfmZIzRRXmxkwiuXYZ21xfqa00JK7x
	aaIq6rQemu/H4hEJ3ONTx/Gm8eCBknuAjhbUp284o3uDBh1foA9opT3aK2nb13mkHnekg1y0z39
	DqiNHLDOeEd7BiPEH2S7LDTpxTNuBTD9RHTEyar4rckZUfRD18aKr
X-Received: by 2002:a05:622a:1894:b0:4e8:8590:f9ab with SMTP id d75a77b69052e-4e88590fa77mr43148861cf.60.1760559058848;
        Wed, 15 Oct 2025 13:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/vQDmK813/cqY6aMyybRLQ+i7/pAaAqNshFsyxlW1nEMLUL7OVwu9YAiN7ac2zmKIZfOPGg==
X-Received: by 2002:a05:622a:1894:b0:4e8:8590:f9ab with SMTP id d75a77b69052e-4e88590fa77mr43148541cf.60.1760559058211;
        Wed, 15 Oct 2025 13:10:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088577f2csm6516484e87.107.2025.10.15.13.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:10:57 -0700 (PDT)
Date: Wed, 15 Oct 2025 23:10:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: iommu: qcom_iommu: Allow 'tbu' clock
Message-ID: <56fcl2ip6ecu4inig7ecpjt7qrsdt6sehkrzrk6joysbp6tea7@4xdgxhhe3aso>
References: <20251015-topic-qciommu_bindings_fix-v2-1-a0f3c705d0f3@oss.qualcomm.com>
 <8e7a145e-6871-4974-ae19-40699747803b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e7a145e-6871-4974-ae19-40699747803b@arm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX2eGK16ukpKGR
 GxaXsJaTl6bTAPs5yYBFb8l8+uCWWaqQEwucByVGQ7UJ9uZIZTHBB/TQgFTGH4qgkYmIzb9ZXXO
 bxal6uC+OldwQvA0mdlJsGqE2QGDbsyANgxzVshbael8+LZG/xi7fKwDsHuQE7lhvGnr6cgVpgw
 SNtGWuzgCUOFaW7ZQOUM+RoAkVzmVERFefH2PoTrzVmWW0gTxGKwcOcdeMa+Dt+E7/MMwG5cine
 XdU4QBzf/kVdNfXeQzIXlMn2Qj4HnafWrnP/Ft5k4BH3tN+7suwl26AQKemaIsYQiI+LQkNws/u
 NBxLYlzqo65vEi/PnL9/mcr1H2nc2EBZSZgBAgV14VYusMUfgV+LcxZeqve6v00pWYUmFnHmouo
 mWQdIS7U9aGl0UzXaWScwm0s+qSEuw==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68efffd4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=0xTHEX-RkNz-9oJQ5AgA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gPRZl_1Yclr3u7Y6ruvEk2mqgM31MSUb
X-Proofpoint-ORIG-GUID: gPRZl_1Yclr3u7Y6ruvEk2mqgM31MSUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

On Wed, Oct 15, 2025 at 05:48:05PM +0100, Robin Murphy wrote:
> On 2025-10-15 5:41 pm, Konrad Dybcio wrote:
> > From: Konrad Dybcio <konrad.dybcio@linaro.org>
> > 
> > Some IOMMUs on some platforms (there doesn't seem to be a good denominator

It would be nice to provide some examples here.

> > for this) require the presence of a third clock, specifically for
> > accessing the IOMMU's Translation Buffer Unit (TBU). Allow it.
> 
> Hmmm, but isn't the only thing that accesses TBUs the consumer of the
> qcom,tbu binding, which already has its own clock?

qcom,tbu is only defined for normal arm,mmu-500 platforms. Here Konrad
is fixing the older and more obscure Qualcomm virtual MMU device.

> 
> Thanks,
> Robin.
> 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> > Resending from a 2023 megaseries, no changes
> > 
> > v1: https://lore.kernel.org/lkml/20230627-topic-more_bindings-v1-7-6b4b6cd081e5@linaro.org/
> > ---
> >   Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
-- 
With best wishes
Dmitry
