Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6986431E5E
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558429; cv=none; b=B9W8rGcGaRBawyKSD/WNP6YC+oyIQ8dxd3rrMOj0KIVuupfJZ7Nws8Q8rkQeG4gX/xKgHqgfb95qBoluVVzjeeAtLQaTJfVcsrUgpX2WNtrE/TdQ1iUSzyZGuAUaqnexWJ7gNb+UKBMur8Orca+7q8Jb83GUvv7Rr3XoZGqMbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558429; c=relaxed/simple;
	bh=z01B6BRW9p/66IR+1aO9/NJXHg731gM6FPMhiWGQyB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bpe3c7tHi1BwlCbd8OUnlfAK/2F6F/wcj/bC/2/+/tjwnm4eGkA/34ibB21W2TkCkJvxgQ3NrDKuqNxJZTkS02y7sba6tnWMhUlKbdwEHAUDu3m+nUfKNnYJKUd5c9nqxn7QzGGtYv84LUnJe0gauqm53MXPNf9395sXff+Q47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OU7kYiXm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jmXg7kHN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OU7kYiXm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jmXg7kHN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KDqPYQ2745323
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 14:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wSO5367YESKMkFVt1i8cKac5
	Snt6OfCdaS9XJJ3y5UY=; b=OU7kYiXmrgETsJWBfjMAoAXmMw898WmtwenwhKud
	MmKi6/JnEuXGQHhxwpdBm83htCaW79nPl35kdbIfWCn6oGAxxR2pjIu+MaUspSQx
	13QeApHhNphTG50jkXPu0SZHTVL3Xil4Lz65oZOekXutV0QiYoHhi0TosyjMLTxp
	f9Duii5K8r9bkGpsCIiExfV18N5BpjPXrhP9HoUUVeSgCeq44WOYsF7Qe8V5dg1c
	eMRfeWshMRox9hMYVJRZbKOeV/glByP8iZPOKQSlBC+T8WGws5FssnKH0BqaIJsa
	ZVqaM8dPPtIazlsZ/41KM+2Y3apSi+VuLiuG2fjrVMkmGA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhk2f8r3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 14:40:26 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9674d6a4ca4so6373835241.2
        for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784558426; x=1785163226; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wSO5367YESKMkFVt1i8cKac5Snt6OfCdaS9XJJ3y5UY=;
        b=jmXg7kHNA1JVpvtEgqcT1ebREf30kwNIEcIajWZmu+FNG7xSsI1BsVfbe3WYmm2SLZ
         9wb0iTuBIM+qSq8q0SSSxA24n2GrpXY0gsZ29CEqqtunYWMsed0objnTE1HFaXycwmkf
         AKb0l91xK+QApGTffM7blUefNJz3T8Q62/zpDTG40DPzYGMwUKM5Fq6vXSsf+3O49545
         DJ7sr3agdQoOm8NIS6yM6VkounAL7k74zCITn23IbZ8VpKPzo//x7o6uSFD7nRQEhkAg
         //6t0ZwL3YnspEUqjckJ4CtmYfzEycrxMJRfigpfbX45L/v6shrdQw58+54QbnbpSpGo
         aycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558426; x=1785163226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wSO5367YESKMkFVt1i8cKac5Snt6OfCdaS9XJJ3y5UY=;
        b=rV3hlEcGHavK6jkh3QrdH8BoWh2fSWS5nMshBLChoPpuRmAQQImVaEP/WI4+254H5Z
         ZwS8zeBkb8iwHH8R8ORvSO1jySk6aDpOIliYynrLp72DoI2ltbT5ZS6yYU335m3we7uh
         eViObNICBw7+HQv4j2BGw5BbreDyKDKvZXyNvvMWeOxy2i3PaMK+KSeeQHMDFSX2zaRV
         RH7Pij9OJmPE9VvVyoQewz4cj5CY1OpinD1AiKQvW3L2vE3pkdlC6wmz1bryEHcmIYeH
         WQu3fIaVQspdjNPu0sEBFsIBuYwuKSo8bYvk4QVXlh2iWyD9g4cCKu3CU8Vp7dPtE++w
         a5gA==
X-Forwarded-Encrypted: i=1; AHgh+RrSxSzxnSM4mSWcp0YFsf4y/E9sMymOcAEVH6ieuF7lUBmo4wMYgZMSDQRbe+4CuyxN1RMVxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyG5PIoYFZXmXF6cfhwIo84Y9XthivlK6wKPfFAlIf8QeAQ5ZyF
	F/i67hKeS9WqXY80647mETzs8FxPmsdbSU1gVrKnTR4D84lTfNTGD0Fp1vfHkUkcG8+M8idAzfB
	Hxj3TmtTVz1kFWdAOSIOTnpAl5X1Ulz0EQ39sj6WDyFFdS42/3qwh+LFb2A==
X-Gm-Gg: AfdE7ckOstjWxVrDGXSJQ3zyVewwK0wPY9ugu4/D0P0NFqHZjjBYVatTyjv6oOU6xe8
	zQJd7kM4l7pEcL/mmcSdwYPuSARE+560XN3uDbzzcXjI2iD5KVfsj9iXtPP998VA9kgQRmC01uz
	aG90Lk+eEkT7SWJE8LAnIHepp3ApRx88jPybRbYMiTuLNXj4WrjN0xu0BmOp6/FcTj/bzbWIoPW
	KefWaVeZ1mm+yevaa0l99pXM5VUiGzNBXbU9oH/QSP1Cs9lSTDqoDfrfrcA1pVs9PdcUbM4iaE8
	cd+giDGPBP8HCl9QdrWd7ODOwIku4k4XvAHfYIAG0di1LFlJizEdy6S5Wqbp1eMHTn4GxyCQx0n
	yhHEiMxIrozogmpp40b4b1XncbE18L8YUHZkZE3xYC8D29k5vJgZwkx37KS88Nj2OjzpS/Qq/iT
	s6ePJ7YYcvN4p4IQ==
X-Received: by 2002:a05:6102:915:b0:737:783d:1912 with SMTP id ada2fe7eead31-747534cee1cmr4346822137.12.1784558425626;
        Mon, 20 Jul 2026 07:40:25 -0700 (PDT)
X-Received: by 2002:a05:6102:915:b0:737:783d:1912 with SMTP id ada2fe7eead31-747534cee1cmr4346803137.12.1784558425161;
        Mon, 20 Jul 2026 07:40:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39eb4ff84b3sm18078581fa.29.2026.07.20.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:40:23 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
Message-ID: <kb2ftnhyvewqgfjdsteenrd3vr4qbrcy3ooiasiui2rchpytol@u2wqjrsc6ebb>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-1-afdca0125a65@oss.qualcomm.com>
 <nrht4irqtvt2vk3lrqvljonarc4kanht2nrwjt7pppsfhozffv@o4xei47l6gcj>
 <e8b247d9-d60d-497f-a831-a9772d27481a@oss.qualcomm.com>
 <phlk6zsxr7szdadsvgoecf7ewcqjkuaj5aeqmfqa4uvvvvnsmj@57u2pofxewuh>
 <4e266d45-ee88-42f8-91da-6253927686ae@oss.qualcomm.com>
 <ak5pC_meP8KRc3wJ@baldur>
 <9f31bf3d-3c7d-45ba-bc25-e6349f689b70@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f31bf3d-3c7d-45ba-bc25-e6349f689b70@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: OAuJQVh3PQwy0SKcb_GfMINZWySwdNZU
X-Authority-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=6a5e335a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=xbAeKRMA8YLAMBIC6m0A:9
 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MiBTYWx0ZWRfXxWGj89WPCoGC
 LQfIyAdDq6HAMwPWzMMI7aFxRPlxMFmg35y7iDwlXU3rwipwRjSEu+SIgts3Wav1KyT5FmDD2gV
 QXghdmSYsBM621V+QTSLqa4a5HQut7E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MiBTYWx0ZWRfX0TtFf149e8Gr
 ewgZC9gId1I+amWnXfTT6ACzlIJT5pYFxOvfZYYrhjWzzQO7GHtRpWXOpF4QTAGr5edSUTXmVOY
 NaU6L/VFsSCEFzpORdx+QK3DNtG1jxJUHZ5sSRTbpzo+RXDGpY0/6nFjCSQAOZ7jJyQ0cZ4cplb
 6RlxZPM8tgql+9PsN6IEm2XPCwCfNAlZUWpZaLB1rvaHfEWCN4GjSibqGdz56wkD6ijEk//It0d
 ozMhMChfBNCeEFYERrJC+UnhPvcHH/y5MKL0WgIyffi+uNleVH1PzIf2ZN5rS7WBSgdE18ncBa2
 wKhhCGHWR9l4QCgwhSCzQ8e3FeRZXBTEVhqmO5LSDi/qY2N17J8z/K4LKQqbqJhn9DAO35gdEOX
 mfTiG+deLkrcqgIHffToQ0qq9I8S+iLFuhDrQEZWK83EAgU7aKPnA7wXcWR+/PEwtjc3D1X4gtV
 6MBBZdB1dwvQMZIo0YA==
X-Proofpoint-GUID: OAuJQVh3PQwy0SKcb_GfMINZWySwdNZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200162

On Mon, Jul 20, 2026 at 07:41:35PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 7/8/2026 8:48 PM, Bjorn Andersson wrote:
> > On Wed, Jul 08, 2026 at 08:22:00PM +0530, Bibek Kumar Patro wrote:
> > > 
> > > 
> > > On 7/7/2026 10:12 PM, Dmitry Baryshkov wrote:
> > > > On Tue, Jul 07, 2026 at 06:06:59PM +0530, Bibek Kumar Patro wrote:
> > > > > 
> > > > > 
> > > > > On 7/6/2026 11:09 PM, Dmitry Baryshkov wrote:
> > > > > > On Mon, Jul 06, 2026 at 10:26:34PM +0530, Bibek Kumar Patro wrote:
> > > > > > > Some SoC implementations require a bandwidth vote on an interconnect
> > > > > > > path before the SMMU register space is accessible. Add the optional
> > > > > > 
> > > > > > Why is it limited only to those SoCs? Is it also applicable to other
> > > > > > Qualcomm SoCs?
> > > > > > 
> > > > > 
> > > > > I was hoping to keep this series focused on the core infrastructure
> > > > > changes: the bindings, base ICC bandwidth-voting support, and DT
> > > > > interconnect properties for the platforms currently supported on
> > > > > Qualcomm Linux and have been validated so far.
> > > > > 
> > > > > The additional targets have not been tested yet, so I'd prefer
> > > > > to add their support in a separate follow-up series once validation
> > > > > is complete, rather than growing this series further. WDYT?
> > > > 
> > > > Then it should be a part of the commit message. All SoCs since SDM12345
> > > > need to vote on the interconnect (and then, in the cover letter mention
> > > > that you convert only a few of the SoCs). We possibly can help with
> > > > testing on other platforms.
> > > > 
> > > 
> > > Ack, sounds reasonable.
> > > I'll add the first platform onwards which interconnect voting is required in
> > > commit description.
> > 
> > But to what degree is this related to a specific set of platforms? If we
> > look ahead, aren't we expecting the list to grow to include all
> > platforms in the end - resulting in a lot of noise and churn.
> > 
> 
> We have seen this issue consistently on SM8750 and later platforms, along
> with at least one customer-reported instance on SM8550. As a result,
> downstream Android implementations already vote for the required
> interconnect bandwidth explicitly on these platforms.
> 
> On Qualcomm Linux targets, we have observed similar issues on Kodiak, with a
> few occurrences on Talos as well.
> 
> My understanding is that the interconnects property remains optional, but in
> practice it is needed for Adreno SMMU operation on these platforms.

So, it goes back to Kodiak and Talos. What about SM8150? SDM845? Earlier
platforms? Is it limited to MMU-500? A6xx+?

-- 
With best wishes
Dmitry
