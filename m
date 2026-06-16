Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA621767D
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569170; cv=none; b=n2OnlBSwFdYR5NiQigP1442PGtuOAhy8tXDASVG72mJpZEnpEj/X2J6Vzc/rkfZRU0T0drTdXo9kXDlx4Ws6SoxrOUkPhliK2+8lcBp1dNGXa8caSNr7lZC8mQdpeBoxyz6Plc7pSi/ynIweaij+FJxIqcnIoH+BKY0bfBf8jk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569170; c=relaxed/simple;
	bh=peBnrIwG8su5Bxb1yQHNnKYZ4q1gc/Q73SMJ4UjY6gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN58BY2ahGX6TE8VVQ9cbbpygpyaU6iqYxTlRjH9e8LTUQmWzWPbbaia1jfdWXlcnYybtsgz+txeHAdB49SksJgWKXDALDyCZDIpszUc69r5s7jJB5rT+KpU6X5wPJiahF4Z3KPhTgko1/fQV+LhqOxBdmlukBhyKQlcI3MifAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jx1rszsO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AQ9SxRtA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jx1rszsO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AQ9SxRtA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FIxUhu844612
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KorrUBh94Ss7D1+qQOdc29iD
	hATuENeNSAm/3rBOeq8=; b=Jx1rszsO5ny/jhVDUL2G+0JMtZimuv//fL1a16P5
	NMo8DG5M46RUtxvGs5tsjIQ5IMfOIlyLPuK9elyHvX3Tn9WNQRWxOSuJSFj5ptnc
	Oc9IBaxYqt+KL3PN40dok+x7ja8tuSMerz0U2sUMHmLx8Re2oB9hYzNO/8epGdF1
	WSO3IbThNLClG7ggxmwQvjtcaQEUSLpNtuddg0OSOjFam8gyCqfC7+2gjv/zxdPW
	vzJ/d6Nmp1S5rdHOly7BWGVylQ9IxL90Yvo8hgdKWUcrQucWpufnlpbk7Cavn4Nd
	mP8HuetMKTzvLygy47Im/2copivxy2j/Clk4fVF1j5cruQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter03ph1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:19:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91574ad6871so603107485a.0
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781569168; x=1782173968; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KorrUBh94Ss7D1+qQOdc29iDhATuENeNSAm/3rBOeq8=;
        b=AQ9SxRtAU7dkyV/k2yPDbuA+6VEJ8cmUPyCMfdGt384DVCEquVKXPJH3wL5ZTbNfQz
         hbetbD6Te6Koy/EZn9Z6CWHj8dOA3XsI4zzgF9X3OGmAJgD5RFV3pu2XPoDX9Jx/9Bm1
         yjm39IQqOLImyyMWPYfr29lWYI7Kz2Q9dLrKnhHI+DaowRVlgJ2pn4rsMHvVU6//hjGI
         X5ZuwKCjaN7fQVUiUQDU47jKScYKIK0z5mdHNNCjDcSE8D9AMOLjZXsvKKo0Y9Ojozyr
         lXXXPiobXqeHR4iDKSENEPxLAMnsWAN1dmMZMCt9uFkvVMu4GyG2f/ILJ5LoLXPLhvHO
         9KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569168; x=1782173968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KorrUBh94Ss7D1+qQOdc29iDhATuENeNSAm/3rBOeq8=;
        b=m2IhxSb6yFRQlShOpZOoQkhWnJDzspddTYmcfBaEdKFx33Wd2eDfVcKKynSkCNsLIe
         xFgQ+VPmfVH3zRmCy6m7iaxPj4WJnFmLn1Ed2AAw4VB28C9tmEznoq9TSRiudfZvHax2
         mgxaqCEKJ7yEZbYlSj02WISUdqbUUeVPxm4s+jBrwMdvoV1UKcVS+flyvU/gPiJ4K9G3
         g04uXsecprrKE6VWN7jxSMwo4QiYuJekajQqj2gzgi6msMr9nssWGbaSqYZ3YRoRbqbj
         fCXUcjLzcxKXTgbFdbW4u5t6DjmfSwwjMTQb4tyrvkoGYuaCqvr41mevtA0OLxNtm+mj
         Fitg==
X-Forwarded-Encrypted: i=1; AFNElJ/Puly3PGhTNE2UIomQEGqj9AQ7I8XU2yXLfFcXXYvmF51H98/TSu3oSoSXbwV9W7nUTAHt5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyflInaSvtEI/syvEFkMJlR4AYcy8f8e+krF3nEENaJiwwT9k5k
	nXwqZR+njclDTwNi6mcfIykffiftbx+ojNw/pf1o7ztjFbp9464z4iY83I1XTP0/Lbl1G+yPFAe
	J2dJpxDmi5mhFH9fhWCpzCL5InJVNJu8pN+D+sAUqAQvoSwqvj5zNmxXwDw==
X-Gm-Gg: Acq92OEQ5gmoY3y9n2TCnlRCMeaonds+Isdu4obYLQWvvFFC7mJQsvH0bLEfHO/7QxZ
	yunrZPWda4wEP2jEK76apJ/PWIGg8KtvbnczcNaB4Bn4shAWSSNmweItuE3nPefnn32fOvfDuhw
	N83FeOkTetSqwW4TbXE0nKkqdRoVdQna641kUDHzYPCb+r96+phZHKB8qgICvGWMf7gsL+nbG8J
	xz5vfoMmkw3bYc45ccgCHHEnny1WCRuSNPg7KWSxFNCFuv04fyNs/FXszJYac7Qu5PvIcincu1y
	aqcQnr1jRzZgzHVXCqpquAdsd6gDXu8HI7ip0LTEbmCzjxSZtcl5umQ1ZZcnjeQZmoEpymmkK8z
	n/SDRUa78GtI18aMzKtRhpKfXInGEtdvGD7CUo9ht2DGemxemollagFz/0odY1lGpzNLVDIdWww
	UNip2XI3b2BHDhdurilmtcIXY2bz33EbbXLVQ=
X-Received: by 2002:a05:620a:19a1:b0:915:7f9e:a407 with SMTP id af79cd13be357-91c42cc5889mr232610885a.0.1781569167581;
        Mon, 15 Jun 2026 17:19:27 -0700 (PDT)
X-Received: by 2002:a05:620a:19a1:b0:915:7f9e:a407 with SMTP id af79cd13be357-91c42cc5889mr232606585a.0.1781569167101;
        Mon, 15 Jun 2026 17:19:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c05abe3sm2595591fa.15.2026.06.15.17.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:19:24 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:19:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <zhdacu4upv5kyvyqx5hcm6im4p7r3z5bsnup7hqu2okxyxmeib@snpseurpvhtc>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-3-2a6d8ca30d63@oss.qualcomm.com>
 <p4xnrkcpbufkkbv4kq5civbt6hiwv3warrz7jiyinsfkihfedh@jfa7sgyzot6j>
 <26d51cbb-2d87-4564-b3c6-cc61ab900e19@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d51cbb-2d87-4564-b3c6-cc61ab900e19@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: xjMHIFiDQqNsf0WxjwfZ3yOVX-PjlwYF
X-Proofpoint-GUID: xjMHIFiDQqNsf0WxjwfZ3yOVX-PjlwYF
X-Authority-Analysis: v=2.4 cv=UPzt2ify c=1 sm=1 tr=0 ts=6a309690 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=zWXYthO56evGz8b0qtEA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfXyS/jZYXcCnH1
 jkzJUDYBI7UrkS8fUcGzHlDGT+8IM2GeTTkGQV9CLnGn6dYiJ59jGh4/702ZK/p3HGGV9A1bnll
 a2NX//iR+c+Vv+pLznUncBdAskvYCLAZs9UJgo6/PFZdF6sO9EN6ErU0F5lfCUvng6xF14IQN5n
 lwdw83PjjV3WXb8zIkt2ssTFyGu6GnyP77oTPWcNkzpqAV+MVt3/jpFhj8pItPL5+yXMmgLteJ/
 2nKnBubWkVRpEQotv9wct1Hfo9Curggf94cTSvE0NsOqs+RgcUThVqOlOOqTp0kUWbg9eLwK7Hx
 k+SvFd8W6nq2f+m1pAi1g+4ZQow/Mb1D5JvkVR/l/90W6Z9Q58TyON0FZhs3F1bWwCBYLoIxH3K
 02tSM3wIpoNIW2O68t8VZjvFS50l1s1Chydyum3pIH87LH6xnLUxRtP7khRBc7PSQop+JlOWjAy
 gwDOHjWDLjs9CUQrhDQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX4CyJDeHb0PSK
 mJ9mr6Q62SRhlrwA+wNp+Irnw/bWlMjjt9lyU9nfv+J6OM4mQTiH5UOKgvp1KJnbNdrDNdrWnTG
 /cBY9+7cwZG4avp2oNmHJtftIWyT1is=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160001

On Mon, Jun 08, 2026 at 08:07:07PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 6/8/2026 7:27 PM, Dmitry Baryshkov wrote:
> > On Tue, May 26, 2026 at 08:12:04PM +0530, Bibek Kumar Patro wrote:
> > > On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
> > > the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
> > > are accessible. Without this vote, the SMMU may become unreachable,
> > > leading to intermittent probe failures and runtime issues.
> > > 
> > > Add the required interconnect to ensure reliable register access.
> > 
> > Does it only concern the GPU SMMU? What about the APPS SMMU? Should it
> > be voting on other interconnects too? I guess so, because currently I
> > see that TBUs vote for various interconnects. BTW: should apps_smmu also
> > vote on the power domains?
> > 
> 
> This race mainly occurs in GPU SMMU, where the GDSC can have an
> independent vote on the Adreno SMMU. However, the GEM_NOC vote may
> already have been removed by the GPU (or any consumer of adreno_smmu,
> e.g gmu), unless it is explicitly voted by the GPU SMMU (which acts as a
> supplier for the GPU). This mismatch can lead to SHUB timeouts or NoC
> errors.
> 
> Mostly this race reported in suspend/resume cycle (when gpu/gmu devices
> moves to slumber/suspend state before adreno_smmu powers down
> and the later doesn't have explicit interconnect voting).
> 
> In the case of APPS SMMU, such a race is not expected for any known
> use case. APPS SMMU is part of a shared infrastructure block, and its
> power is typically kept enabled as long as attached master devices are
> active. Therefore, explicit power-domain voting from APPS SMMU may not
> be required.

This looks like a good part of the commit message. Please add it where
it belongs.

> 
> Thanks,
> Bibek
> 
> 
> > > 
> > > Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > index fa540d8c2615dc02d941eb16bc7253204c2750bd..eefa4b836a81374ff437ab4bbcbc3fecc1590ab6 100644
> > > --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > @@ -3386,6 +3386,8 @@ adreno_smmu: iommu@3da0000 {
> > >   			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> > >   			dma-coherent;
> > > +			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
> > > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> > >   		};
> > >   		gfx_0_tbu: tbu@3dd9000 {
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry
