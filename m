Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53E19D06B
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677902; cv=none; b=if7fHBuVHHK/2NZso+onF5doYYeRPMZAhKJJvkACPlG5FLNnxy0XOiw5o2reMjHMmU/MyDSjEqRHS7RQtItlwM//u2l59Y9XLeuZDiVEpJfmfK1XYPMIyfyZ/KCTkzfXRGtNQDXLxkCti/0OCLce9T46I63is+ZaHijxOkwVP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677902; c=relaxed/simple;
	bh=fiecLZEgxwBHhvCtE3OC0jqMMMcMzWtkxcrkMLboTz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIX1vgsfoJaz5TiWf4INg5cX/DTwN9xUjJnz9VDdypsrXStOdnhUZN4ZEUJUp1DMLwVbXjb+L9QeIA4j/0c6l1RYYsC40ynbOLqFEIvShSre7RtpGzatLiXtns2VHPF4KbrMAjBwFY+66q63Rxmx7jrQEJqkf3Zbkf4URDBG+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S/J9NI6+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S/J9NI6+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDVbYu024502
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 14:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RDf8cJibEjhiFo83apzBrmHpgcz1vDYMn9bRtB9wako=; b=S/J9NI6+NVkFsLcs
	HyzjPCyusqVoUyOQhQWOgN30XCuBEKk5jTJU5Y+B3miL5fodY8U9LZQeELU1aApM
	VnZzSxcvy9uAKZkpdTWMcU3cky8nB1Eu+LZijxs1Yg+xajsblzBzy7RP5Q9tNFa6
	3HtV4uepI0W3Q/eQf23HGFl1hrc+YuFbNImCTUJKu6B3aVADDa2RLU9mbRt766kw
	OGmRzP+CDaEeIu3LSmlgn6XZQUlUySbfbHlVoKyKODb2UJ8rGvAja3qOG420brXl
	3Lt01qrG+mprDqi5EVACmAsUG6WMtFffNhOMRCjvBhBZKfw6N1PTIdJ8O4s2s501
	fYJC2w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpfaxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 14:58:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e348600cadso64875285a.3
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677898; x=1753282698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDf8cJibEjhiFo83apzBrmHpgcz1vDYMn9bRtB9wako=;
        b=U4xhW7ZJXirdQ1i3yyb6YZH1V1WQ8lcDVW9JdLVGxVat4kyVYcPgFpNgHi1IMhta3i
         BszUInqRPsgg4VjFxJBkx/iC+AS4kxTZgCn1C2Vn0UgCJNhSyF3Lx0ph+8tUs7EklIVh
         6i34ZlfomA24soe7KHN3OXOiYfLb8H1BvTD9yG3hNc+A70BU5eN3SWHeTo3GF+HR70JL
         5kpGzZ09p9iqWvd5nKHdx8MU0dS6CI57iFJ2CXdFBxaKcgTZCeqHlz+lfbp915XJEOkK
         H0GTUv1g0IWwwjnbU3DSmkEXnsgA9X9B8gdAtGAkH2nZmFI7aZe8U4PC1p6AHpPgJYu+
         fPKA==
X-Forwarded-Encrypted: i=1; AJvYcCWwKb7E/Eenuj0BxD1Q5d/LxcRI0DkfbiEptRCNYxnKsoqtqXo0BR879K2U2U0NQe3qfhsnUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzfZLcEzKnphkXwKPjp7wbNs4HVDUp6rUFsA3dLhAMCX7ryn4w
	uoGJE+KRcPdeNx2qfR2MXGHjqpe30f+CzkkZBvaz3BlLpCxJ35lTvd60QtNrEdqTsaupg8nkwJN
	LooBYo/4fX8C8fWANju3KtkwPEwPdgd+7teCu7KDOVPe7o6cBN7zaip/JcQ==
X-Gm-Gg: ASbGncsKu4XPHqekK3LFWcon40NLIHaoGeC3KyZNymD3ohh5HZREVDeQiBvbe7ofseB
	n1gL6oGaYWBFZ9gERoAy2o51ZZj8Ch4zDtd6olZx8W3LKSGAZy9wb4lQe6XtkdygwrKeoF0bkxj
	wfrieYWh4+gyKRdFPw70dl8sfcsehPRupCgPGWn8FC+PFDrUyS+rxjMbBj5BVYDSV7c0YOq4fJc
	lHtbZMtQH9ubMLTPUS/4n0+OHd0ud42THUjzfgOEmizESXkHeYv2lemGJNuyxNSaQaNzQnM6MrB
	vxPb4TqdqUxivq8l5eS7zFqizgsGdjp28Nyn1uFv28qh/xO4VwF4yP1QDCki28fJsnTTeSCW1qf
	OO/C5C9q/5TLWLHfQjdQq60lr23M1/DMcA25hVxCC4Fei06mpKQP7
X-Received: by 2002:a05:620a:22ab:b0:7e3:4413:e492 with SMTP id af79cd13be357-7e34413e876mr264145885a.62.1752677897602;
        Wed, 16 Jul 2025 07:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0jOujE3U+BYkwFkxZi068fm97ejo79VB/1BsmjFpf/HPzJEDPZJZLcHh9+NAlr5Fw707ZVQ==
X-Received: by 2002:a05:620a:22ab:b0:7e3:4413:e492 with SMTP id af79cd13be357-7e34413e876mr264140585a.62.1752677896933;
        Wed, 16 Jul 2025 07:58:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a0fe70bccsm1355597e87.30.2025.07.16.07.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:58:16 -0700 (PDT)
Date: Wed, 16 Jul 2025 17:58:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: arm-smmu: Remove sdm845-cheza
 specific entry
Message-ID: <2kpb6lwr36izbbp45dbv7lg2akjdxteiadhtc2bbphmsreycwu@nre7uzuezydq>
References: <20250716-topic-goodnight_cheza-v2-0-6fa8d3261813@oss.qualcomm.com>
 <20250716-topic-goodnight_cheza-v2-3-6fa8d3261813@oss.qualcomm.com>
 <CAD=FV=XmwiA_gX9pF5Dja1vezson7f21WHC8u8+Rhg_6OUJ+rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XmwiA_gX9pF5Dja1vezson7f21WHC8u8+Rhg_6OUJ+rw@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNSBTYWx0ZWRfX6pFqjiOeyNr4
 eZZ0rTsLuNjch9SyJ9I2yM8/ln3K11pOqrF8SvY7Bpo5QSVzos5k/FZSr17b7fgg0kUVgWMctsP
 CcwmVzWKFf3CZIcYQVYvn0dMsQtyhYrutsvkfcJHevzj6oUr7Ea1lBuelp3Ijd4hVegWS9X+D9K
 NLJ3XYedOCIbWC/K3vKehFx4mAKaP7m3L+UHEF9+XpN/ltJ41ygWepsxs0l33loWI4Dv2FAENpv
 h+Cva5QZ27nle66GyAwEelRvqIW07v27HNcTE1d86qCxc2wxHn5sI3IetTO2TxcXLXGQmv7pZ/M
 9DVhMdnVTin/rFGyoxv1VeT7Wf091BA1BVZHVBH/dpIjFG+Qvt2UesXG7EAnY7GEVi0ws1wtJlb
 QdjxIiXAwIpCwtR4hrSuNK8r+naWYZROlOQCIjvwPXyGyrM6stKEgJaGKvXTb49Nq9+Pez7n
X-Proofpoint-GUID: jf8xU6oFxB6NMeB8nzX4B5lW1dGBkply
X-Proofpoint-ORIG-GUID: jf8xU6oFxB6NMeB8nzX4B5lW1dGBkply
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6877be0b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=HCTRSnsxAeQ6huVMZXoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160135

On Wed, Jul 16, 2025 at 07:21:51AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jul 16, 2025 at 3:16 AM 'Konrad Dybcio' via
> cros-qcom-dts-watchers <cros-qcom-dts-watchers@chromium.org> wrote:
> >
> > From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >
> > The firmware on SDM845-based Cheza boards did not provide the same
> > level of feature support for SMMUs (particularly around the Adreno
> > GPU integration).
> >
> > Now that Cheza is being removed from the kernel (almost none exist at
> > this point in time), retire the entry as well.
> >
> > Most notably, it's not being marked as deprecated instead, as there is
> > no indication that any more of those ~7 year old devboards will be
> > built.
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > index 7b9d5507d6ccd6b845a57eeae59fe80ba75cc652..646814ec7d15f6d8a0136de73b7eaddae232ea64 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > @@ -132,10 +132,6 @@ properties:
> >                - qcom,sm7150-smmu-v2
> >            - const: qcom,adreno-smmu
> >            - const: qcom,smmu-v2
> > -      - description: Qcom Adreno GPUs on Google Cheza platform
> > -        items:
> > -          - const: qcom,sdm845-smmu-v2
> > -          - const: qcom,smmu-v2
> 
> The code supporting this can also be removed then, right?
> 
> drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:     { .compatible =
> "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },

No, we must keep it for the Adreno SMMU on SDM845.

> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

-- 
With best wishes
Dmitry
