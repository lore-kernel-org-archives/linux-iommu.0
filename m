Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8A4A014E
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874082; cv=none; b=QY70l8FN5CUeCryJ/vCmwR//e81vinpzXznE59F3tgCcBY2r8YivVdHjvdlUKXXVgbqM8r60/xRjGYeNXE2wTm3SF4tigo+kf0LtrffPOMF4Xqc4kplZQP7Uzy7nQXilpGyRsQK7LNO+LkPaXOxSdwqkPTjkUK8T6n4yJef16FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874082; c=relaxed/simple;
	bh=e8BuZAhC+MLAr3dIChDONBH6Nn9xUIL3CVxsjkAI9pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQjYrJc+XSxKyakEH/aoJUfZHbPDj8hx2gBoOS4bNpunYIal6Nmt0UwmfKzcqBL5w0QpqV9+px8ONwxzC1/zWcMkgyWNosA2YXeF2XPmKi8prhyCGninsVKZChcMf+p6cvwVXuNvq40EwQACAoe0pCDFlPcnemVb1oA1n1uPXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KHktZt23; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JOLQa3PK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KHktZt23";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JOLQa3PK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688Ckvvb3844377
	for <iommu@lists.linux.dev>; Tue, 8 Sep 2026 13:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xVBfE4bB6UBnPqaf4fcSGOt+
	V0oC9kKvBZySwiRwwVs=; b=KHktZt23Nu/EUKMhStOdFK/SatUoUuxEpdqpXY5e
	4UmrF5lo/Z2FvxKvsbUjbPstOQcuAv13/9v1KxWUAPxt6pD0nAcChhOPzfDisAKo
	lOfOMqKhyz6bv8YYbYChggjfN3Ri1/HwXhoCWAIji3FHwwyikwKlJILMHVLQksfn
	AIOFywXG3OK7+yDirBlNOA5YIUUInadxAlgUmRP+C1VEfFfCeY+2uVJMEO/aKjUF
	zgNnKfBCrKW3xEivxg/W3vRQ09TUCA3sJDycWc+25erxNkMsVYVaQ3S3VaiPH7jt
	HsLoF90GzWry+XB4WtkT8tVFt4PiNuUmZgeEdjHOeTpUcw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjg8xrrx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 13:27:56 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-78d25a8ff32so253830137.2
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788874076; x=1789478876; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xVBfE4bB6UBnPqaf4fcSGOt+V0oC9kKvBZySwiRwwVs=;
        b=JOLQa3PKJtWBumysfJjToY4s4iz3tbMqZSVtDGqyHro9U1PKkHCB7Znf1azdOeRuV+
         xj9wQo7Oc4EO8XFvvV2yOnhQbNDZLpgQtd19PqvN2yGG0ywAX6siH0Bp1AsEVOop8Iuc
         sGdmEqjVTtLOp+dD8JCIDlnfzpLqGjAZEr5gSd0NXV2ukvKuxI6uDDQxyk6JBDBIwnhO
         PNp916DQ5W+lCFumjxROmF78tq+i+yPkCKuNZ5pipfYUMTYNJUB+gyABAn7QRYrGf0z0
         w4tkBnq/ZdZOLRVBx4iYtOAMZesMTiB4AM5xED73cgfjXZswkHGiIT22aAo3QWDfYD24
         yOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874076; x=1789478876;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVBfE4bB6UBnPqaf4fcSGOt+V0oC9kKvBZySwiRwwVs=;
        b=nCO7chZRM+WNAh76s9JaxKcDEXLiPqhc5K/ABX7Paoo6/PRevAE4nm0JMTe9NV7nh2
         o3gHn5ZOFhsPobBboPD26/RWAO448G1jWP4lpNejtzawAyuPHpKG7CGtLTOkKY6zpI2C
         XGYlGrmtX61rmZK/JvK04Ou+bnTEXjoEO7ViiWzJDnCSbkfvtW+RAEWLQcZ+l0kUSH1y
         zHmSw81JYFzfsdqQLrfwHGJxCTSNnhIqFPxf+XFFdjjozwspCNV2TIysmmI8fyey14Vf
         dZX3tqL1w/iVgEaq5eh8fnW2ChrAUysrAKvpKmZQxgScfoEIKRqrhkV9rTnRQJgWkvYK
         hskQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3qIXm7fKfPzER6q/y8vFGbsJXKF3wR9LVSkoMV3zXex4nRLvIDa9Du2wNmLc9rZpvIqrNSw==@lists.linux.dev
X-Gm-Message-State: AFuF++nrcqrry7Xgh4uSbOfMAXSg+OCPRjG0Zo1U+2PBpmbCe3D19hoz
	/eA4xcDtmV4SFGv6LSn0QjVmuND2J8tJWPi/vcgfiRDeAr1BF9gUtxFB3j4ZuXXPN4hGomnU58R
	CAtB9vemwrCF8PW17eur+Y8Wmxo76B61ST7td9Fx8XFqSVIaiNlnAFo9WDg==
X-Gm-Gg: AYBFou1cAsdxLDV1lKhBhdDqAP55rLFKc0AZh53jzzSzUZPvDoOir0C8zeyT42G9YFB
	fkjqJJhPOZNp3+tuL0zMW4R9Z1rhRrcEb8LnJ6YeHigAyfYpApGzfs9kSKebfkREW4YxQv6+V4S
	0TA/WaNyxvyxKBx5eQHwuKYDue9S2LeOprAdj9SSprshtm/qbUpYMYfAanE1wEYQ+yu3Wi5ZQwH
	P1WFxUVahNoOps1EXk0gI3TJTjxEcGi00xxRfoa27yNumEZ/i5vN/rKU04B8LEtJF94TjUV/Pff
	vhcCIBfg+3DUAjGpXVbNee8fbwjmlkYGnDn0fXpCzZOKfAEDZ1I/oXgl143UESP821SNyXYhBOf
	pDcRkUGIyDFXjV2LxNFOasucwSRtETzyw9zapvrfA3Ti0ku7smvDTaUxgFQW47vzisU6LYUdeCv
	9MsQO80dfCUbA+
X-Received: by 2002:a05:6102:554a:b0:780:5605:743f with SMTP id ada2fe7eead31-78a4a8bb311mr10294387137.3.1788874075922;
        Tue, 08 Sep 2026 06:27:55 -0700 (PDT)
X-Received: by 2002:a05:6102:554a:b0:780:5605:743f with SMTP id ada2fe7eead31-78a4a8bb311mr10294352137.3.1788874075438;
        Tue, 08 Sep 2026 06:27:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b74cbfdfd7sm2572414e87.75.2026.09.08.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:27:54 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:27:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/12] iommu: qcom_iommu: support non-TZ-managed instances
Message-ID: <a2fy6smhao73nr4od6wo443622ym5exlj6qp4nb6wdfzgx7nkb@35a3nyftkhur>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
 <20260809-msm8974-iommu-upstream-v1-6-87f5cd492560@oss.qualcomm.com>
 <08bc7c0c-4e15-4e76-8ed0-34dbee36a6ce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08bc7c0c-4e15-4e76-8ed0-34dbee36a6ce@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=J7GaKgnS c=1 sm=1 tr=0 ts=6aa00d5d cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=JrPXT6BsTxOl0o4Vz8AA:9
 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: pKwbEHCb__pYt0xJni5AO3JtjSqnme6c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0NCBTYWx0ZWRfX2yhciTsAqW0L
 Gk1XUchA+azjdYtBtZh21zwv8+EcYYcAAh6p5S35uzeoNHAoO6/uCQUZnd86+G7pNzn5pOosfX7
 jB3DRJwQIhrNLK2FXymkY909OIIFob/T5dbz/hNJlgrvKyR2nVA0D/8QzHhQBsSLJv19in/I6OJ
 zBPMBwFZyoWDCmhB4EX7GvWJstFbSmAIQ5OYf3V/bN6bQggHgfi4FBp8rzkjJ10SkE7JghN62LD
 jN4epaTh2VxOekb60szH/dpaymlvtjApeS2gC3/RpwMOBcavjTSgMiLJwif5pP7JNDvZHeO9W9Q
 7WaNvPBB1zuj9b1h5hRKTYsW6eyHIXTMQxv5x+HD6wd+Wfv8hlzMYr2sd48I6AdIfWDG8GQFtTx
 1JxthdVT1QWx9bFqGb1quQicPkyEsBzOnUQlkie0OFfPwfbN138mzVLmyJK1pv4K+vQTO/gAnE0
 6F/w6qvr54xMoFESMuA==
X-Proofpoint-GUID: pKwbEHCb__pYt0xJni5AO3JtjSqnme6c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0NCBTYWx0ZWRfX14hVQbI5SKkw
 riVA17YWW4KonH+ZjHpFviWSIMz7KGanFLVWZsv4Ic65H4qiaCLJgGviGn5puG+kGHqrXpg1hbs
 a2dxuq0wtazQgA8aXoErrmzpKFdfYOk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080144

On Mon, Aug 17, 2026 at 01:40:43PM +0200, Konrad Dybcio wrote:
> On 8/9/26 10:15 PM, Dmitry Baryshkov wrote:
> > The GPU on MSM8974 has never been usable upstream because its IOMMU
> > cannot be driven: unlike the MSM8916-style instances this driver
> > supports, where the secure world owns the SMMU global register space
> > and the OS programs just the context banks after a restore_sec_cfg SCM
> > call, the MSM8974 GPU IOMMU is not managed by TZ at all. Nobody sets
> > up its stream mapping, so attaching a domain leaves every transaction
> > unmatched and the GPU faults on its first memory access. Verified on
> > the APQ8074 dragonboard: restore_sec_cfg is only accepted for the
> > secured instances, while the GPU instance exposes its ID registers to
> > the OS (IDR0 0x78034404 / IDR1 0x10000003).
> > 
> > Add a non-secure programming mode, derived from the downstream
> > msm_iommu-v1.c driver. When qcom,iommu-secure-id is absent, reset and
> > program the global space at runtime resume instead of calling into TZ:
> > clear sACR/sCR2 and the global fault state, invalidate the TLB and all
> > SMRs, install the per-instance stream mapping (SMR/S2CR/CBAR, with the
> > downstream MEMATTR/NSCFG/VMID/IRPTNDX values) and enable the SMMU with
> > fault reporting enabled and stalling disabled (sCR0.STALLD, matching
> > the downstream terminate model). The stream ID map is per-instance
> > configuration data since it is not discoverable from the hardware; the
> > SMR index allocation keeps ASID == context bank index, which this
> > hardware requires (downstream msm-3.10 commit 4d92ea10aac3 ("iommu:
> > msm: Use CB index as ASID")). Also set CB_ACTLR to redirect cacheable
> > requests to the L2 slave port, as the downstream driver does for every
> > context on this IP generation - on MSM8916 TZ owns CB_ACTLR, so the
> > driver never needed to touch it before.
> 
> At this point, would it make more sense to retrofit this atop
> arm-smmu-qcom.c given all of the differences vs 8916?

I'll take a look.

-- 
With best wishes
Dmitry
