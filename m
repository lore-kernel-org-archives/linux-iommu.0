Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0221A453
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569094; cv=none; b=t+gx9nYac98DE3+JvcAk9Wruit9wXWEOlFi9X9CX2gnjmJqZFFJmpF/tUgupHw6QkM+a5E5daG5w3VGtzi/PrLcCN0UVpzjbANgS4zzB7fxtSkBeZziwdZY9GZaTJVm39rRgKiiR/f3O1Ve2gAaRCMfeVKv1eNBBR0gsa5UdPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569094; c=relaxed/simple;
	bh=9vCegOvm02QK0AtqE2izy4JK/HP646VqdIZW7JindyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+DlSnmfdb0YEjK8/HsR0+oaeCkiduCfJmQgPyMAwgQ418l4ai1iWUJHWAD8vnimWx61ZW3AVVdsGmKQpOQkAIIyMCA4e0vjTgNEMl2QI0H+rzTYr57YUhNzc05hOud3u8Eo324Qu9QqglIhl4XkjCDTcUWCUSiqBEBP2xXJjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ajKrQt38; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IuA7OsII; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ajKrQt38";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IuA7OsII"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FIwxKJ883717
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=i20IcmKQCtSpRNFUs8gx8htg
	mWtH8qlgtcQsTvxKC3o=; b=ajKrQt38ygS+n4lMp6F59aVCCgMCTv03uQ+bp3rr
	uB1127SRL7ivvincdM15beeF2Rj8Zk99pApGrI5U93riFFSBjkFkzuEIaneSZcnE
	Hh7wNUPL3Cc7z7z5ji9NfKuaOKimTwKP9IYrtkwFGrIBhltO9JzWcQjYBn2k6C8N
	13cZgqyrBXi9BMoU0qKal+v2iC08L/se0psF6wS9V7y6EFB7SiVZJz86jw7WV7jA
	VqO7X76mmzCpncUNKHjMjoyamhZzZQ/lauQM5vZm0rQ0fTBAdcQ4INkYtZymkAoV
	WnBq+W/2BsLjM2YE4HR76i5mTqv4yjlpy4TgnhY+/ipmBQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa73nym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:18:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91598ab3a1aso458361885a.3
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781569091; x=1782173891; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i20IcmKQCtSpRNFUs8gx8htgmWtH8qlgtcQsTvxKC3o=;
        b=IuA7OsIIUEhrvM9rKB3gz7vdjy/yTNNk16GY7b1JNvUQtFY4tFB5KN48k2CoKe+CUS
         dwT2e+SWZaHQPaIWv46KV6fj8Cd/FlmEXcm/bj6xjDc3FioBQNfhoonTi9HcljbJ1Tyw
         FDt/70cu8GGQg0PGFv6LFpgHb0Y9Z8PXRnW3re4vDx0JxV2HnBcw949GmiLruxeuvtkM
         RGNuxQAAmEzKj8oTVSkLccngDDd4tPiIi1fR8oRx1icHYCEL7ZlqHUoP4VqnKnbwK0Wx
         vlA+D3z+9V0DyPr5aoy39mWDEjAkcr6b+SFuZKSc0yK3s8XguAf3OlKJdVST5K86D0Jm
         Bf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569091; x=1782173891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i20IcmKQCtSpRNFUs8gx8htgmWtH8qlgtcQsTvxKC3o=;
        b=Qb81wAZXPipfh5nENr9cEAZQOXjeR6tkSoHlUdCPXR7qaW4E/GiSEjsdb9ZSDIZ4UP
         ywzgsEQjZdhMTDRHiGzG84+eLwpYaM3Mi4/YYIbEGw/U7N58jV5HmytdzTHFgQx7GeeC
         p0RE0S7OyJpLPYIbefcobDYkyA7u3RkNII8LKjNoUwnbQVLUgi5lxP6QQeykZ0vDqfU4
         cbvwYwYKSQ80gHXcTMtQA4LER5v4vnAGe4SN7+4Y3ERb/C6JVBspsjeaCTPo6n9bWyfQ
         qLbH66bumHunz5IewDO31N4jVc+d2ItTdUfVHWC2zhDGZW6uoYUDrBTWcmcIV3qQJ93p
         SD3g==
X-Forwarded-Encrypted: i=1; AFNElJ9xuplbyp9J97sdHO0/Ziwk5c0lLXQIsnjPzaAD54gy8wQoW7gCTK9xKophoZ/44fL0gVM+PA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwezHMddCz2+kRBr5k4vsHd0A6aqJc62sb4Sa6XwC15t19eziQO
	fM9gVhobUiM2Z+fYU64BmTJ+ZTdtQcsiFv5k3EOx5Jawio0PXHzJFT/tbglZkqvSlY2jU+AVmuJ
	dm7DSjtz+RIw2lctn05eEu/+V1uoq5shxAvtSf96cQ0KQ3eZfvp+3ICnc1w==
X-Gm-Gg: Acq92OHSFx3Jn3vwV4pMW8SegTJcfnOr+HBZv2GOSFA5xzWwOPjQLfuIL8eE5jfXy4q
	C+oBjbUStBgk2VezW+m3jMa/LqqZKlCWvmCcvaO6F9IlHDpnAxV3pML0GNZk8gjwCbr4ii+f/RX
	vSvtwecZS2OIXYLbXlYAhFYFKWgyKXgvDujhPkS4guEAlw/0JaoFdC/sdcoINvxVTJm/NdqWreH
	sllf85IwD4USh3YfEZOw6LORo0c50PFPiseFXvAjfPV6CbsteCZEjavPbx1W3se9RCrViM6xFY7
	kOjvInFyF/D3FwZJ211ZBdix40JTw3/hNTmAvWrFpGqUnyfbPKMTQN/08VQoJkhA8immx9gGBfh
	gyTCuwxE+wQZOHppQmK3W1m/QUDzl7CtOFBqJC/vrjq0TxgAEGWJBCKewJAGq2Dma0EPBa7Rnkl
	HQ6aHEJQPnTqR410t3nAgTPmuLCJHnBtaa3CE=
X-Received: by 2002:a05:620a:1786:b0:915:9229:4223 with SMTP id af79cd13be357-9161bfc078bmr2522039585a.58.1781569091139;
        Mon, 15 Jun 2026 17:18:11 -0700 (PDT)
X-Received: by 2002:a05:620a:1786:b0:915:9229:4223 with SMTP id af79cd13be357-9161bfc078bmr2522035585a.58.1781569090689;
        Mon, 15 Jun 2026 17:18:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c059bb8sm2529131fa.10.2026.06.15.17.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:18:09 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:18:06 +0300
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
Message-ID: <4wu33lbglqmqywhwntxx467uigkpxzctwkdtues4mcpbzjrqyb@jokhryzdph73>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>
 <1b5ef5b8-c9f2-4eea-8040-22c1d704b529@oss.qualcomm.com>
 <0ded611e-1932-470c-8e80-9a5e94268583@oss.qualcomm.com>
 <2roy5rvazzb5p3vl3dyutft635n3acwssqnqvrzqziivh3ebq2@wptxg7exupmr>
 <a1db573b-bcb4-44a5-89b6-6d1c76f4a18a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1db573b-bcb4-44a5-89b6-6d1c76f4a18a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: YTpVW0D-F9nE5uw1oMqedFfr1fzm7qDL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX1tU0E09OjhaL
 4URiGml7cwaPS9u839t6dHoBrZEI1ckKmDumAkQo+RyDIZ+xzrFWEhlrKtnhwZ1i+iadkkSPKLy
 O5Dc33z9ZMd3HFWQHsMinrGfF7A+Cfw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX4OHDy3Km+Rd3
 Y9tbUyqD/R9H5UL3igkqX/7IirdPikhaCtPjK1X1cQ+LWO/A627S7s0z6QMu8gnaiWG1RJxMRZK
 m7tsoB4HNmTWnUvH9hsPRqhza8XxlVwODqdSwnG927g3CKvi2U1V3pWKp12DHU8IoKf3oyoejOH
 WX+5NkjTS9eafwWF5Hk5S3ds9spPWdxtmqTtzgfI2iq3LOAADcOtsDPneawIBuJp/0aXoU1P3Q8
 VmeFCBeHO7DZDPCumb81o4kuWEhhzjbZySjTh19ocEEcOwZyqNkR9PBANfCfW8szENRYpeOKxIe
 pO/gZgqHv1BROzJCAPio7zZr763znAQRMzTJ3i/hROoWBL3iDwRv+3eQT/0EGvrsHRj27yBi1hN
 jRKi8yxuO5txMlzewNCNqMkEDXJ6rYOnQdb8rS+SPgA5tqv38UcKQZiD9nd5r0rZhDdnTmqpk6V
 woqrRxs6+gkssF1q0fg==
X-Proofpoint-GUID: YTpVW0D-F9nE5uw1oMqedFfr1fzm7qDL
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a309644 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=V2S91bIb8oTTECmzoZMA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160001

On Mon, Jun 08, 2026 at 07:32:45PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 6/8/2026 7:19 PM, Dmitry Baryshkov wrote:
> > On Mon, Jun 08, 2026 at 07:14:43PM +0530, Bibek Kumar Patro wrote:
> > > 
> > > 
> > > On 6/8/2026 3:22 PM, Konrad Dybcio wrote:
> > > > On 5/26/26 4:42 PM, Bibek Kumar Patro wrote:
> > > > > Some SoC implementations require a bandwidth vote on an interconnect
> > > > > path before the SMMU register space is accessible. Add the optional
> > > > > 'interconnects' property to the binding to allow platform DT nodes
> > > > > to describe this path.
> > > > > 
> > > > > Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > > > ---
> > > > >    .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
> > > > >    1 file changed, 27 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > > > index 06fb5c8e7547cb7a92823adc2772b94f747376a6..3a677ff1a18fcdf5c0ca9ec8a017d41f9eb5ff09 100644
> > > > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > > > @@ -243,6 +243,13 @@ properties:
> > > > >        minItems: 1
> > > > >        maxItems: 3
> > > > > +  interconnects:
> > > > > +    maxItems: 1
> > > > > +    description:
> > > > > +      Interconnect path to the SMMU register space. Required on SoCs
> > > > > +      where the SMMU registers are only accessible after a bandwidth
> > > > > +      vote has been placed on the interconnect fabric.
> > > > > +
> > > > >      nvidia,memory-controller:
> > > > >        description: |
> > > > >          A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
> > > > > @@ -602,6 +609,26 @@ allOf:
> > > > >            clock-names: false
> > > > >            clocks: false
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          items:
> > > > > +            - enum:
> > > > > +                - qcom,qcs615-smmu-500
> > > > > +                - qcom,qcs8300-smmu-500
> > > > > +                - qcom,sa8775p-smmu-500
> > > > > +                - qcom,sc7280-smmu-500
> > > > 
> > > > This is a list of targets that happen to be supported by QLI.. but should
> > > > this list not contain _all_ Qualcomm SoCs, or at least a much broader range?
> > > > 
> > > > Perhaps
> > > > 
> > > > if: properties: compatible: contains: qcom,adreno-smmu
> > > > 
> > > > ?
> > > > 
> > > 
> > > As of now platforms where the issues [1] getting reported are added, the
> > > list will grow.
> > > <We still have to evaluate and test on other non-QLI platforms hosted in
> > > upstream [2]>
> > 
> > Do you really need to test, which platforms have an interconnect, or can
> > you predict it by checking the SoC documentation? I strongly belive, the
> > latter is the case.
> > 
> 
> Agree, for interconnect path we can surely predict from the SoC
> documentation,
> But for the corresponding FLAGS/values (MASTER_GPU_TCU, SLAVE_EBI1), it
> would need some testing before finalizing the change on corresponding
> platforms.

I'd assume that corresponding values should already be known. The
platforms are not new.


-- 
With best wishes
Dmitry
