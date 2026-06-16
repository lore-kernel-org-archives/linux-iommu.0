Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABCF23BD1B
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569342; cv=none; b=X6ITTXcrVJISBh0RcOb2bbO9FRe7MDLXlJU9m2HFktq164f7wj1CDQjdg0c1UlP0+1WO9gdg4ZXxBpsGs/U9ME53r0Q7KKN8yimIH9wMdS4FNpUIXroLedTawACi2rzOJyTUUCMmbtulcg6yexi6kGSamw/oZq+dDesY3pxvlws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569342; c=relaxed/simple;
	bh=P7MxXITSax+WF+IrLjY99CIeQHXpiEgCBwVoBlGs5SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii77tK5a/J9SSU7rAwNK2uuuLOe8/N+6XuFfUqGpARBUNIbAuI0tMVGMf+RyJ6571PkrZWUHPKKYtmFC7vLgbRUrkcLDcTugtX7GBO9MqRePHMijzpKZLIW9GGs1tW5R0Tfsqr+7sClSbeToxCh48nhXGOtQiLdHNHK2jL1ccF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=exV7vkjm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KcIR9g4Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="exV7vkjm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KcIR9g4Q"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FJ1UsO1367680
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+I5JPJ28+2C5Ptq2qq3gPPxE
	l8sJtso7kvE/1GSrC98=; b=exV7vkjmYRiBrHACB1F964JIl6zOi5w5Ae7TN+Eo
	O9OsDnvYllYprf0DquCfhY0PjaFyJOxlUA8qaF4NcwghLLEP/aO2CMrilizZBr+s
	lkUGeGBQEeKQOvAD1ZvHqDH7VHfR15M+4nTzc6e+ZinGV06a63H7si0stkWmqrFT
	3oWyTSwPv8NSvretIH8b/KGkVzl37PY+TuishGsPKk9eTvBaxDsF6FVoY/W1kusK
	kYPsV5YAv0RjAEzlLR5CzouvhkDN1/GLRjZ8mbOr8+KynNv4u5dZKm2DdSpN27Q/
	SLptKqfW7BR870293tgLOP7YCR2lzfz8LJrqke8a9kYZng==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteguut5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:22:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91931144870so442249885a.1
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781569339; x=1782174139; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+I5JPJ28+2C5Ptq2qq3gPPxEl8sJtso7kvE/1GSrC98=;
        b=KcIR9g4QWmUg6kRzq5kCdIJR0OdFfRj/di4nmgSPCxQxVxEOsJAKBoWvJ1QZxeMYvl
         mJWayn42TKXctFOD2VscVmv86AQF1Tr9zvfAWAlm8X7w5jE1KMAgxOF4ldow4PsqgEdx
         LLFLqFNgmXJKYmNoKRv5MoMfPAmEtsiRWxxDPDmL2sOTvPehaoFcFrHhzMd3rbT5S4+z
         BzVt9CysTqGL0migdqldou8JaZMBrSyinmYzRpCae4KnL+b9mh6/yWka/vXFnOihIfg7
         Wj5HaRXXKWpNTFCHNC4MBCCyVYkf1HfgxgxcrKSjvw7UQswjI+g8siaUCUFYxo1aG0zg
         NXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569339; x=1782174139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+I5JPJ28+2C5Ptq2qq3gPPxEl8sJtso7kvE/1GSrC98=;
        b=WCQB79VZg8BKYC90MgoqByexppQ9Ww4j+r1b8LnMRDV/IoWly7ZejQn3H8TSVf2YH8
         rSwFbgwuRNf4xoTeW5F6S/MaDt5nU2hlVAwdIPKMXFl15d5HynT3pvYoGJOF27UfyxLG
         YBx8xmyPiOGJV9B1gKrabbUTBJaLnV4UL9FCzLKgHKkjnVK5XSUIEM//bHQSvfIM4LEj
         wo8pGOsdgkPHTdaG4wiVacCC0s8Knq6Fzh57r9IoSjGlCwCbpnrJckoAHzC+IvmgJhdV
         3AY2lq67d2/UTDVwc6jsf4HIevaQ1MDrQWSmfzElv6i21jYYZ8p23Gcs4gIIFeSnbtdA
         V2dw==
X-Forwarded-Encrypted: i=1; AFNElJ/y/8toO0SaUPYPrsVVP6quuKfO3hrgLSyNj9jKOpq2ChImv4zm8tQ5MERMVzil8mfe6LDtfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yywc14UkXubvjaPEsuVIK0WB/9HPdD5lJnZWMVdHNLUE9lUJIZF
	MLmGhGBZfUpC+f+HLaAtxHu5JTohlJkI7XamShyJPdHkh8KIFt5QMVCAFUtkxSWuFadngqxKCR6
	h9j10m4AyKRNOfzqNTnrMav9j9APyqOFQDuRYhOahKmjxyMKbM7wSBYJICQ==
X-Gm-Gg: Acq92OEBTKvZEFnnH9pJjd9PH2+gEpMUzAO7UvThZwtyGXk3LYl6nGHCGkfy/AeV0xY
	Tzd8/ANcOKP/V3xO6yhKDK8S/uZ0rJzhiAUmxNwoUsGorVCuG3edtBZnWGlfAWDiR18CfH0FoDY
	gOxqVtEQJvPz3YnoRHCR2QHff+aCQ5BtNV9TcCln3LlSWjffeHxP0d84FQsxB8NB3R4hhg29hkn
	nt80Ti0h/UAQjP/AqRMGgb8NKYW9Rr6dSKuw3e+qZo05Fez6J0rLK56kOm66/6aPnI8VH34HQ6w
	VUAWkON21u5Ey4oRCCiLr5Oplb3+irhC2BSCE6oFzPkiAJkDGYrGXjroAGE8Xsdipc3fkddVnwl
	htihvyY6eetr6Pv6yADkQFE3V8oPKDV+lubBCYtyK6CkGptyzq0XhNvG3Aw0NDjhuTNZS4eb2/S
	LGRhV4HwMASjIXZyKteUm8N/lLgnI8TQmiBhE=
X-Received: by 2002:a05:620a:240f:20b0:915:aad5:e961 with SMTP id af79cd13be357-9161bc2369fmr1782861885a.19.1781569339090;
        Mon, 15 Jun 2026 17:22:19 -0700 (PDT)
X-Received: by 2002:a05:620a:240f:20b0:915:aad5:e961 with SMTP id af79cd13be357-9161bc2369fmr1782857885a.19.1781569338549;
        Mon, 15 Jun 2026 17:22:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e16fee3sm3056234e87.31.2026.06.15.17.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:22:15 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:22:12 +0300
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
Subject: Re: [PATCH v2 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
Message-ID: <2i6yzwu2yk5bngq723g75yeqzeg4ihvtbuydzunceltl526tjp@vnt6nmxxkfut>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
 <7xfxlxfqjcqdzl6gckaoyy2ioefglc7bgi66yv5khrbl6fi2zc@ivtiukdaj4jv>
 <8518a085-b8b7-4ee6-b08c-8dde3971a6f1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8518a085-b8b7-4ee6-b08c-8dde3971a6f1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX+bdL7uEYp1zL
 m0WPZfybafQWWj5/ZAaw2V4WngjDzVsnS/82YFystx+P9BICDMDp/2UMrU9SRfCE17sWqGtEEJq
 7I3acQguRJ9je6C6MTzfwsfAaPLAXhXjevq4H5jFehmgJl9z4NAeh2oHlSjqIcMUbAMIlsY5OkH
 CEeUjZ2DLPn0wZuI6CKCjbQbDhRCavn8/H/ib8fybm45vDJtJwLGBgRJuCxlX5MAbry3QujhGhA
 Gqe2+TkrFmyq7fKCmxn+sT6J3pkcBLNWFtpf6uNDYo3SiaBHnFQOIB/noJ+kZ5+wlXOxtyVPC8u
 FPyp17v+w2WUO/rGJa03J0o3QmuJr0aun8UI8WJYMyc+eSjrg6SboPXNEGvDGGkUQvQodCpidUb
 FRhbjh9XmYLdTSWwNmetLdVjJG8W/DhIZJcNnhcrZalfgs10Q4yuCtLxM0PidxK9h8vlxeqzcy4
 g9zF/3AK1JxrRcpYQ1w==
X-Proofpoint-ORIG-GUID: R7TpoTqe1__-CORYNNBZYrx6PpA6Da7z
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a30973b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ak52lZM5eA1PxQ1fx0cA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX5Tt7511TlEMx
 /RmrcYgf665/bxbkTugC6C/FFtFBvQ3/AGCVlSRzkMlp4aSUenhbt/LyMy2bUvE8dJAF5+HCCNB
 0iiD+mhUq2EVMAw4F5izc61G+ULf4ck=
X-Proofpoint-GUID: R7TpoTqe1__-CORYNNBZYrx6PpA6Da7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160001

On Mon, Jun 15, 2026 at 06:55:45PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 6/8/2026 7:25 PM, Dmitry Baryshkov wrote:
> > On Tue, May 26, 2026 at 08:12:03PM +0530, Bibek Kumar Patro wrote:
> > > On some SoCs the SMMU registers require an active interconnect
> > > bandwidth vote to be accessible. While other clients typically
> > > satisfy this requirement implicitly, certain corner cases (e.g.
> > > during sleep/wakeup transitions) can leave the SMMU without a
> > > vote, causing intermittent register access failures.
> > > 
> > > Add support for an optional interconnect path to the arm-smmu
> > > driver and vote for bandwidth while the SMMU is active. The path
> > > is acquired from DT if present and ignored otherwise.
> > > 
> > > The bandwidth vote is enabled before accessing SMMU registers
> > > during probe and runtime resume, and released during runtime
> > > suspend and on error paths.
> > > 
> > > Generally, from an architectural perspective, GEM_NOC and DDR are
> > > expected to have an active vote whenever the adreno_smmu block is
> > > powered on. In most common use cases, this requirement is implicitly
> > > satisfied because other GPU-related clients (for example, the GMU
> > > device) already hold a GEM_NOC vote when adreno_smmu is enabled.
> > > 
> > > However, there are certain corner cases, such as during sleep/wakeup
> > > transitions, where the GEM_NOC vote can be removed before adreno_smmu
> > > is powered down. If adreno_smmu is then accessed while the interconnect
> > > vote is missing, it can lead to the observed failures. Because of the
> > > precise ordering involved, this scenario is difficult to reproduce
> > > consistently.
> > > (also GDSC is involved in adreno usecases can have an independent vote)
> > > 
> > > Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
> > >   drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
> > >   2 files changed, 57 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > @@ -53,6 +53,11 @@
> > >   #define MSI_IOVA_BASE			0x8000000
> > >   #define MSI_IOVA_LENGTH			0x100000
> > > +/* Interconnect bandwidth vote values for the SMMU register access path */
> > > +#define ARM_SMMU_ICC_AVG_BW		0
> > > +#define ARM_SMMU_ICC_PEAK_BW_HIGH	1000
> > 
> > totally random numbers, which might be different for non-Qualcomm platform.
> > 
> > > +#define ARM_SMMU_ICC_PEAK_BW_LOW	0
> > > +
> > >   static int force_stage;
> > >   module_param(force_stage, int, S_IRUGO);
> > >   MODULE_PARM_DESC(force_stage,
> > > @@ -86,6 +91,36 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> > >   	}
> > >   }
> > > +static int arm_smmu_icc_get(struct arm_smmu_device *smmu)
> > > +{
> > > +	smmu->icc_path = devm_of_icc_get(smmu->dev, NULL);
> > 
> > Is there always only one bus / path in question?
> > 
> 
> <Apologies, missed to respond to this query>
> Yes for TCU, it needs to only have a vote on GEM_NOC interconnect
> while accessing the DDR in downstream path (client->TCU->DDR), which we are
> addressing here.
> Hence it's only one icc path in question here.

Again, you are describing Qualcomm platform, while the code part is
generic.


-- 
With best wishes
Dmitry
