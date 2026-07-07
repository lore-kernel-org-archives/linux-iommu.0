Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDCA424646
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442573; cv=none; b=gg87BB21hvfYjjCzbOYjhMNU5D2WucQoUVROdpDzt250o9/b9gxZhfnF+qf2MtfZGJKFgg4SLi8XYYUSGMmV+DL39hbk8N3JcTsWbq8lgakcLhx7idxRGxzyk9O8MGAhLt54d5aDxKimt+gOrkNHxWJ3Rqj4Y6xLF5YqB/xczWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442573; c=relaxed/simple;
	bh=zmmmXJpEFQfT9LL96zAN1n79uNV+fe4mehteFTXk5XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twtD2SkXhnCFHYa0ydiXBWsnBXAuwAlxTCTBXV8ra2eCY+XTWZMnWrlGUToiE4Pb88n+Km96afb1HOiLwUj1XBLcTB2+Wk+XOSWtVZ9rIJ7/HN6hVlsj/ZZigoAcgBmDtCCpkX89+kPZhsqf0oPzfyZ0s8rnaWLLtqzndvdZ0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DDhLK/AG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W51ulFwl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DDhLK/AG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W51ulFwl"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FT7ru4045073
	for <iommu@lists.linux.dev>; Tue, 7 Jul 2026 16:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/Qe7pk8a29mkB/ToP9tmorjc
	IpiQB2oLiDgFYvMoFYg=; b=DDhLK/AGst7Ue6QNhxSF4MvK7XU1G78tumVNHwOM
	EzXTz4sonhbzFrqn5CjS3GAIUkzpNJJyMXBGrL4IsDwFDH+kwUlOX8zKiOBMNgCr
	J6MG4SpbtUn2P9zl6C5kY3EDE1qJCIgngchwnwf5pZqSSEIEtJYQpqnbTmd2JJ5C
	9Ye4FoXgEJboC7/QDGVpEtsGsDGNe7e0VKrq+Jd+8VewbNB/X1ECYi30VF0IMLle
	Tiq6y2Js3aZNW4aDloTDxgXrIHi2IEEaEib8K0K8adIoDLtZ4W1ZqOpGRNIX84BQ
	XLb2tu3L608A31Cxy4VNuUC13LHhJczzT9nnxN4B09zhbQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2uaaej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 16:42:51 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-737d34a0dc8so4527863137.1
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783442570; x=1784047370; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Qe7pk8a29mkB/ToP9tmorjcIpiQB2oLiDgFYvMoFYg=;
        b=W51ulFwl917Qtlmuia2oe0QzOcG+43NPXmye6luSNhzT96GSrwKPIKq16ZqvWJ8ELO
         WpkMXncSIjtviSLwSZ0AcN8um80dewDuBG9l1EsWtSMXKi5M7FLRErGroDnoiqx83cHW
         yzAHl588tM3cVSCccelHxSHIpiebbo0cIBRTirhvi+CH1gzCmRwHI0dejfZMOihb4g0L
         nK6M5KBnoYblNkOkxkdi6/SvnVLua5sACxaDpUVt2hBRSGxT7PwuiNOYAEOM5y2J8eQG
         7X2teHTAQfOrT+z/OpU1TkBNA13rt3FpdmtP1bLgLkKcrNlrt9YEsG86PJSWzG/Mr1/d
         VmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442570; x=1784047370;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Qe7pk8a29mkB/ToP9tmorjcIpiQB2oLiDgFYvMoFYg=;
        b=hkh98iVZqTxCeaShq9os33zUHpCBe/llHFJw1FQ2VgfUNNAb7QYwpD7Ftw6kgnQaBb
         ci8MgifkLcRvoaI6fEf7f8NGUwRtYYg61H+Q+q5ss5+wxAoqbY6nME8SSdbcrXTYJO57
         9siFXARHTU8MKakYGvz7LB3lEgYmNJYndAY2rfdkUEjcz0HpO7k5xyKthzL3VGh2nsiM
         JReFI42lgbQHhyinfDqHA2G6L28sOEZY48hE89TttPdhGnItJierfTs/hhuS1lmN0DYQ
         cpOFpwOQDBpyI/rvtfUnHZeeRXCORaaalWLxz7OnQfxlhwJBwSz5E+x459IDbX7gH6Tf
         ARPg==
X-Forwarded-Encrypted: i=1; AHgh+RoCdUobUOM3Ia/s2qPGcLxWtj/KZX6pr4uBE1cxF/ecyqOl5wCS1tzHP8FYW50d39VoYldHSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJV9pPL25DXOkstCCUPvBzMEIesg/0llCT2rFYjd7iAhKmNd4k
	3RZd4hL36v0P0Vohb39WDPpuYsUk7MRmpRzG6j3/oWv8/fFXXRURDkypmcbfZoWvpb/RyasAtwq
	XHlGquQDtx5dkjv3OJPTKmgtwiEsuOn47NCgESTw68pljg+6he6W6dbEY/5syN/jcYQ==
X-Gm-Gg: AfdE7ck13yPvfMTu111wkEO+WlDdvzIrP3M6d9g1Yp6esOnyxZWSKra5Guoa80m9bJq
	dsno5PpfwHV/mDxfiGuFmMWhcdGpaTguTM4+Eqkhce49UOAFGesF6WTtplsdQYPr1Uf9MK6uuA7
	pzorbtrXsCZj2lrrG5kDNe0gU9bEBZJi7qzDxWzHpIewLG2EPG1I7XpvYc0kIdFG1O3e3jP2jd9
	0GkrJfSZ0wDS4GNbuIn0ZB/ABjOSAYji42TT+qYXlIxQft/Q3Xx1vWSRCpQD7rak7Q2TWNIUwcQ
	f878rcrUZ5nrcPcHOHRV2D5Fa6xYCW5OICpRUULIRxskeqTxlp1fkZ57jCFPtffnMNyMvNo1KQw
	Z5w15GqqAPplq2JziAz+Gn2IAr9G5hHshSy/v5la94y1Be61Gc46Ormy7G5dFRPcOvyq7wc/e+w
	jhCfK/jqbP7fuLAw9xzu72MWds
X-Received: by 2002:a05:6102:5491:b0:739:d787:be5 with SMTP id ada2fe7eead31-744b7e91665mr3674826137.29.1783442569183;
        Tue, 07 Jul 2026 09:42:49 -0700 (PDT)
X-Received: by 2002:a05:6102:5491:b0:739:d787:be5 with SMTP id ada2fe7eead31-744b7e91665mr3674805137.29.1783442568650;
        Tue, 07 Jul 2026 09:42:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c7312bc25sm391001fa.40.2026.07.07.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:42:46 -0700 (PDT)
Date: Tue, 7 Jul 2026 19:42:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
Message-ID: <phlk6zsxr7szdadsvgoecf7ewcqjkuaj5aeqmfqa4uvvvvnsmj@57u2pofxewuh>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-1-afdca0125a65@oss.qualcomm.com>
 <nrht4irqtvt2vk3lrqvljonarc4kanht2nrwjt7pppsfhozffv@o4xei47l6gcj>
 <e8b247d9-d60d-497f-a831-a9772d27481a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b247d9-d60d-497f-a831-a9772d27481a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2NCBTYWx0ZWRfXySMUgJwo+MnL
 pxujMsBe+sH5KfamMDYvAE38GZc6B0sFfoaEw6Gnzh/KG18rg97j4JEFGxWF0Ljnw7QJUYrIKC+
 9IIPXHqJ+IekzdnDn5b4oN26WZOEeqY=
X-Proofpoint-GUID: nf78_1ByrmUa8FDCRop_jMTqU3LA3IpI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2NCBTYWx0ZWRfX3kzmaBaQleFn
 OrEEnvXNNDKwSvre5DFqwturZJhiLepzmkMCsxpdNSz2UllOFrkYuDM8Vu/iowIBPlpSk3d2RIe
 /HU5FHc7Kyl8qZe/WKqB383xnKbhKFLKQZk190F52BukChDMnRIyP/CZw8zFYJUNW/AJttNYwLw
 vEk+5dsClTQJOkAoQ7Bl0RvBPp1UeA2F+gkfaBNnCL1i46UFbJTx3cZsJd8pO+3DNsSMlBW8svB
 TN+szNc4v6cgw3fa90QQuooTlKbfkUUEIXxFTWXlgTrLBC9tvLqXvrBYbk9hhh4D6yOiKymlNmM
 yB7Zne7PjXHNtdckj+zalbjkoLnvfUSJlheZXCrlo8i9y5pH3CTTHsQGKqytFfzlK1rf2sH3oOT
 BQoSsTXPrvmlF36jcv2tZTjTfGIM8bmnsX1DhkooNFUAiFRXlabmypg3xJqJxDB32/3g+s4GIA9
 NqGab33oZq5Su0i7Vjg==
X-Proofpoint-ORIG-GUID: nf78_1ByrmUa8FDCRop_jMTqU3LA3IpI
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4d2c8b cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=51R1jNVWGJiQLheemG0A:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070164

On Tue, Jul 07, 2026 at 06:06:59PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 7/6/2026 11:09 PM, Dmitry Baryshkov wrote:
> > On Mon, Jul 06, 2026 at 10:26:34PM +0530, Bibek Kumar Patro wrote:
> > > Some SoC implementations require a bandwidth vote on an interconnect
> > > path before the SMMU register space is accessible. Add the optional
> > 
> > Why is it limited only to those SoCs? Is it also applicable to other
> > Qualcomm SoCs?
> > 
> 
> I was hoping to keep this series focused on the core infrastructure
> changes: the bindings, base ICC bandwidth-voting support, and DT
> interconnect properties for the platforms currently supported on
> Qualcomm Linux and have been validated so far.
> 
> The additional targets have not been tested yet, so I'd prefer
> to add their support in a separate follow-up series once validation
> is complete, rather than growing this series further. WDYT?

Then it should be a part of the commit message. All SoCs since SDM12345
need to vote on the interconnect (and then, in the cover letter mention
that you convert only a few of the SoCs). We possibly can help with
testing on other platforms.

> > > 'interconnects' property to the binding to allow platform DT nodes
> > > to describe this path.
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > > Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > ---
> > >   .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
> > >   1 file changed, 27 insertions(+)
> > > 

-- 
With best wishes
Dmitry
