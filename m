Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7F3B9D84
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926610; cv=none; b=TK7TteBwQu/Y0v1Fz5ImjoHB9YnhKvJuPtI6uSbRHJC5+s7/6dGlBbPtsK/f8fnzL14qaSIlAc9WeUQB3HWjr9hOX3pahpTNoGRa8GUas+4DrkaMdF2ulo/6OdTaGjyjiinOY7E4PoEJ0/0xoel1COFxB1eQ5KPNUVHF+oQORew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926610; c=relaxed/simple;
	bh=mAVANFWtLDtgAHnSQBDOOB+4RTESnvMxY8g61AhDU7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyCtFeN0SDQ66jsZRaExtyAoTiNw5RQJVDY+pNeBA4NEF0PJam3BxoN48Ym8RlnP4AJz7s3NYNhc1k0MLc++oa/F627d5BfMlzwh6F8r+qNA0jgUjtHC/snGiKXRc3eSqGkiBbadWXfZf8dDjUkH/IT6knLJIIe7ptC9JDUovp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YvJgFHCf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O+eO2H1F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YvJgFHCf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O+eO2H1F"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRODQ3346978
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 13:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Rn4SKsuOStAQRXD00Glk2pD8
	NtpGz2H7OLN0fQ2CGPs=; b=YvJgFHCfHUmbSTsXt1NQmdmu34caGzgLNedm+MEE
	HFinemN9/tnZHwDZISbr9U5CNtl2eeg9ZFMrM1bkohpALSY9KQrNYrRgm3uWgB+x
	w+kapoBckdwGqVRyOXQOWCgKd+70I7wiuDD2dsj067Hq+W3xtuKDuiGmzTgxjWMP
	/m5/vUMFHiV1dTdkf4SDjI6N5wUGxDTREJEoqrDjqpt+qCq2TwuRnAnjvNMcwlOf
	PDTBhtZ2dv2aa53hg9GHP8mFKU8uOARhwjIwaekJyPUiRWczpKZszy/KZuB2YKsC
	JlL4u+0o7RitaX2dLASjBG6hqTZYnX046HkDZUkRuxLbSQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj8rsy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 13:50:03 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6798c46f723so2333723137.1
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780926602; x=1781531402; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn4SKsuOStAQRXD00Glk2pD8NtpGz2H7OLN0fQ2CGPs=;
        b=O+eO2H1FkaH1nQpMtgOFM1Z8KfxLddimJ5TNOfo1RwCRXKPV0b/epvfv8BrBv+rJiU
         KXC5RzNFMMDArerJw3UWi79mJBtt8QqGZm9tc+2gEBTTMPUbGs5aCmj5pgOW604PlUHQ
         PL7sdnGMIBHXwp98iX3QtlTSttaLbZi7/li7Ptw4MX4ElS1PjSDR0RLrTP/EkSelm7fX
         8d6vhcYrdqx+JXxdGKFP0DqgRzhQkdNeGxi2JLj0SVFlrvsYEUjCzGELKo3CJZeCOWC8
         YMn7kRD9gGufs3NDZXoBGJNRCIbJqm6HF4vFqjgDB/tCZuAljksyBOTIRBVpHtMX8SX4
         stng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926602; x=1781531402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rn4SKsuOStAQRXD00Glk2pD8NtpGz2H7OLN0fQ2CGPs=;
        b=FdmP1ca/Ukx2P4s7aREtAatVxzgliNzBMyjCpHK/pxkKcfCEYQoE0+S9NyhU1e7M8k
         BB9U4NJhN0Tki/ttyzwGGLxSa1HZ35PnhSqyMeuL4CrmZTOUE/Fxf87eHKUw6uvnQWDk
         1393ZEvTRr2CUP6BBn+v6enlnvUwh5e4vD0WIcqq/kozSHa5slbtWjvR1snfWpm0YM79
         z0ULfgfLiOBwnU9XPfQdLSydYQHGkpxXrRsz1rIq8lci/UbxkZA0xQpniU+gX2gZyLL9
         bzH6WVPQ2jzOOuE8gy3+i2hGJV2eIc619UUquadA9XzJgpiJ02X/5YUoC1Jpiu//VTrz
         SUuA==
X-Forwarded-Encrypted: i=1; AFNElJ9ywWuMDSMN/4WyeMM2g5xFeJ2yYcw/zxk1eyEQSikFDHNNEOVNee5RGSBA6HWac/yJ0LnpAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkl7gLdaXbX7rb8+tP9NPiViEfuSd2FkSGdp6osG/1YZoLu+/L
	RA+0lUuRwqTZVMG+nZmIuGwaORSZvEVDkQaTD76ZqOsIlfTgQqx4MR4DH329+x9/ikgtlgP98pR
	r7zHFzad79D3YfU0X33N9JY+07OA75KMuDm5y1c+xZ3diWvqj6GPhx3q0nw==
X-Gm-Gg: Acq92OGLKMxugMQZYLGED0ofnpAl2ZYNmo2iXb6j/oFOIDaeT03W0M9YprVKMtjjjFU
	riPz742yXaLL3wIcoH/2tFVp0Yn6BS8cb7k3YtACWPdwEFmOf30JgL6FD8MS174MNS6NHiP2C4Z
	KmfFgjgbLmWWatJjjoVgBjTR4daodBUXH0UGDFatLa9u+EMq514bk873mKptBC6cwIhGw5ZF8zg
	uS5g158Y8zWeyV/UFYSHo6zhsxok+/OjY5GbESm0cW1Ix4cQc4iVBQs0NqqJqSNQ/wBh3imng49
	CmxOx3c0fctcYI5Up2g2dW9h7+97nOsAZQYrDOOHr6e6SgxZnkhyvbFW31QglvDqq5otvsock+B
	4BZ5b9mVyZUAXXSjzGLH2z4/pFGxrP88JXskYv1Ig87kzejrKrEK4UMekYZ6YhaY7Ed9oyKaiLH
	XUlEefRGzm9+i2My0v++tijptySNgIp1g42NrE1yZsnjnRHA==
X-Received: by 2002:a05:6102:4485:b0:66b:a0d7:abc4 with SMTP id ada2fe7eead31-6fee79766bamr6807364137.0.1780926602395;
        Mon, 08 Jun 2026 06:50:02 -0700 (PDT)
X-Received: by 2002:a05:6102:4485:b0:66b:a0d7:abc4 with SMTP id ada2fe7eead31-6fee79766bamr6807345137.0.1780926601852;
        Mon, 08 Jun 2026 06:50:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2be038sm49107501fa.22.2026.06.08.06.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:50:00 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:49:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
Message-ID: <2roy5rvazzb5p3vl3dyutft635n3acwssqnqvrzqziivh3ebq2@wptxg7exupmr>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>
 <1b5ef5b8-c9f2-4eea-8040-22c1d704b529@oss.qualcomm.com>
 <0ded611e-1932-470c-8e80-9a5e94268583@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ded611e-1932-470c-8e80-9a5e94268583@oss.qualcomm.com>
X-Proofpoint-GUID: 5U1SMn4B0TaMjLSrMsJ_a9SS2qkuE_5r
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a26c88b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8CyBazYyq9SD5gnPOlcA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: 5U1SMn4B0TaMjLSrMsJ_a9SS2qkuE_5r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMSBTYWx0ZWRfX8E+H9CKUTLEG
 sc3OTR8YJkKiDnH2HZOaTvyajBI7cL4ylaSpmdN28YLmPTXMffOnVX5y01anSAmOtoHsT+TGMj5
 i/azNCRqWoMN6e177Qg9Pxn8cFoXEyiXi/uTdrAmgtiJon2h2mrnNbUM3o6yRhEjFiqNnTqUqX+
 3g9bGzcxJJ7clPH5NSIWZPz04Nph+g1wpoM0BYKEEiCn/ZViAR0Nidwp8iYt78TqcmBJ4X82hwi
 BEfQGOqtKkq5ZSdeH3NV7PPVmQhof4QBj32uaRoMEgmvOj4Mhru2BbUrgKwTC04h8izgpSqnkWg
 SfsqMv4nQiUT/AFkjx7ONCOY+wk2+HqPTC5z2zhsOY3VxJtkO+R3jzaPER99ZoTHEe/BPmY2B77
 wB+1iZzHjbSZ7NRU8dEFdNBnwYC1RG0uB5YXOdSVMEiHDyXKVqiJ0cmI/m7rqHH8YpZt9DwwkNn
 2//Aod7C7AMxkQROmVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080131

On Mon, Jun 08, 2026 at 07:14:43PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 6/8/2026 3:22 PM, Konrad Dybcio wrote:
> > On 5/26/26 4:42 PM, Bibek Kumar Patro wrote:
> > > Some SoC implementations require a bandwidth vote on an interconnect
> > > path before the SMMU register space is accessible. Add the optional
> > > 'interconnects' property to the binding to allow platform DT nodes
> > > to describe this path.
> > > 
> > > Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > ---
> > >   .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
> > >   1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > index 06fb5c8e7547cb7a92823adc2772b94f747376a6..3a677ff1a18fcdf5c0ca9ec8a017d41f9eb5ff09 100644
> > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > @@ -243,6 +243,13 @@ properties:
> > >       minItems: 1
> > >       maxItems: 3
> > > +  interconnects:
> > > +    maxItems: 1
> > > +    description:
> > > +      Interconnect path to the SMMU register space. Required on SoCs
> > > +      where the SMMU registers are only accessible after a bandwidth
> > > +      vote has been placed on the interconnect fabric.
> > > +
> > >     nvidia,memory-controller:
> > >       description: |
> > >         A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
> > > @@ -602,6 +609,26 @@ allOf:
> > >           clock-names: false
> > >           clocks: false
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          items:
> > > +            - enum:
> > > +                - qcom,qcs615-smmu-500
> > > +                - qcom,qcs8300-smmu-500
> > > +                - qcom,sa8775p-smmu-500
> > > +                - qcom,sc7280-smmu-500
> > 
> > This is a list of targets that happen to be supported by QLI.. but should
> > this list not contain _all_ Qualcomm SoCs, or at least a much broader range?
> > 
> > Perhaps
> > 
> > if: properties: compatible: contains: qcom,adreno-smmu
> > 
> > ?
> > 
> 
> As of now platforms where the issues [1] getting reported are added, the
> list will grow.
> <We still have to evaluate and test on other non-QLI platforms hosted in
> upstream [2]>

Do you really need to test, which platforms have an interconnect, or can
you predict it by checking the SoC documentation? I strongly belive, the
latter is the case.

> 
> [1]: https://github.com/qualcomm-linux/kernel/issues/297
> [2]: https://lore.kernel.org/all/a437f9f9-3560-40f8-85ea-35433e33c428@oss.qualcomm.com/
> 
> > Konrad
> 

-- 
With best wishes
Dmitry
