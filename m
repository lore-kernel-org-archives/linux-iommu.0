Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD722E401
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367129; cv=none; b=TUyzi5BM/41SU1wYKKKZ+3lKO+o2GmBNtcrHVm2j6vSLn3Tae9OUPmR0qhghaXXu0DohCmrtaOIXk5z2DZ/vOUWM0SCHvo4Aj64YhwB8f1NxGc8M8KFaDCXu9TZgd7iweCpJ7NeahftKO7Jq1cngbb0LeMHGdgifGeISK0ic1wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367129; c=relaxed/simple;
	bh=VIok+0rxwHZLaPmyttbi6WBJmDoh/Kww1KzGe3A4XEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdGiu2DnAwBAjW86gDLVRu/8L6Bz0tlTt9AtMxUCAdX09ZVw6tZonPVT2znMA8UNwahaeRmlThBkuGRogCiEt/trKeJRsWg8iRbx1mBnnQqz1ZrAqzmY0olVGBrO3Lonm+WUPo9OJXmEAuhsh+sdxjMQF38Ls9tgFlBONO6d42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvibUwMo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvibUwMo"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IccgO010746
	for <iommu@lists.linux.dev>; Thu, 2 Oct 2025 01:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rENwoiSg1tzLoiAPGqkjBCSK
	SjDWlFAHIwunjXnHHZk=; b=LvibUwMoWmMPV8/gulPd7d0dqzFKMrYzfeA3+kpS
	UyMKugvPCYLzj1AuNij2Xe8svkm61T3Nu+uMurHXzcEKuqqsTN+11a/TKpkLew+P
	6pt07NBg2AdyfG5L06+6Gd/0EQWwGpnU9F9JS+usdLdyoh9huUqKNKlqvcdDUV0s
	X6pvSnisQhvuX3vRO3vbpV/vMsWxsAjHkjnhUcICF+SrbWEul4xAfoZecWtAt/81
	uzzhLZSpsCW77T7GZsahnUPXW9hcFZimBFIH571ZJvZSqAjqn2whHU6u+AatH7Xk
	Kw6NFXO9OQoRfekRWMumaIlG0Op9mqvX2seb05sxiW9rLw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hp1w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 01:05:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b302991816so9716391cf.0
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 18:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759367126; x=1759971926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rENwoiSg1tzLoiAPGqkjBCSKSjDWlFAHIwunjXnHHZk=;
        b=l7uslQ9LRqy7b5ZjrV6mw7diNHfX2gjo5C4ldNUcbCEm8QRIXQBi1QUGnqWOTUj2xG
         SCi3vSbZ7dxEaHAZOT5DLY3sIl9kQcXL8eOeYVt/UhBgksSpQU4iSXjg71YH2++K3Wgo
         kM3bW5nsseQHy6XKl6vmr8FL6fn/p5T2LLcJ6MXZzd1Zqn3XYJ9pM9iOCHXo9kTEnFEp
         rXX6oDP1LQiOhEnbAG3WsYowVN6xtuF12CAWNlZnOeBPCOil+zIhjTf7OfFUQgxnmh7S
         mHDO7xYXLj0G+i6ytlHNcxqaDPvV5y4AWBoSq5Ud4xF5nMNCSYK/rFa9+2vZWO3VI8RV
         Thdg==
X-Forwarded-Encrypted: i=1; AJvYcCUyeITG+v3/YhjysCCmXVLuKTl1nCWRnsHsShbVSFTla8/CqMQ6zdnOY9NBmxcI4ZncRViAww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIMJRh4g+crZQXvnteVyfjgPUbZN04yeXi+d2FCOiPoM84yYl/
	SeTPClaWNpsbVcYtEvyZdX8FrxrTVjhyjQvcwSCbjHlz0Yy60wilCARLA0SWOEPCx5XsHS/EF6a
	6JSSBJiYiAlsA3GLDdQD0gsqE3Z7LK9v61LHlGXF/Yw4qwwuBnzwEnNJKhQ==
X-Gm-Gg: ASbGncuk7FPwtrzUpQPZTGU+JNkOscKRPK0bH4sIOq5pImxQcPaW+Iap6ccBvTpyeji
	qIsQjhng9OYsJYShk6HUzY+W066Jyktck1UnhnPeATgudsXPUCWkisIlpXJyigXzt9FzthTfwWV
	G3LJv0ciM73H5/BaJjB+3ksfUqQdLFHrrHuoCFY7Rlb/q/pb+Krn9260zD1n51d9rBr0AsmY6Ho
	pQ8twYy2i7zq+bEVugvqqVqMUo/JMqAwKALjncbr0D58mZpN/mHbK7EbjNtY9OPkZUaU2mAf+Mp
	87uxgaoClXL+tWLAcUQbAS0dyPKHin0CjXsVo+BoBgABzXSvIzK4UHvJRKzLmVSVF9VU0VjOPB3
	+cWdcus6scpcWfbF3lrmMECSw/86CGZ+h7Es0iCzK8YpTfJBuI20nC66P7g==
X-Received: by 2002:a05:622a:303:b0:4b6:2ffa:ac4f with SMTP id d75a77b69052e-4e41e542b1fmr83681841cf.57.1759367125547;
        Wed, 01 Oct 2025 18:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeKctloyAQifsz5OI79+M2Awu+QEw5vBOffum/dFuw5MctXvZ7WXCFsn+Kj+KiiKDncHvDRg==
X-Received: by 2002:a05:622a:303:b0:4b6:2ffa:ac4f with SMTP id d75a77b69052e-4e41e542b1fmr83681451cf.57.1759367125094;
        Wed, 01 Oct 2025 18:05:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f01bsm345930e87.48.2025.10.01.18.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 18:05:23 -0700 (PDT)
Date: Thu, 2 Oct 2025 04:05:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 11/17] drm/msm/a8xx: Add support for A8x GMU
Message-ID: <sgdbegsvzwg2hc5omrcmtifhp5543rey6jax3zhaqrdqot4l3e@wp635oyywxlw>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-11-73530b0700ed@oss.qualcomm.com>
 <mbx2yihv4z3y5w6fptumw47rc3l33pbdduqnu66bgv2re64cjy@wgd2qq3uv64h>
 <20fb9f76-558b-48c8-92b0-9820407bb82f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20fb9f76-558b-48c8-92b0-9820407bb82f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX+68zawKYamZ9
 0u2m4e5IyL1V7hcEVwyCqxld7sAhxzxiR6SJrRUJiVacVHdUzBZQ1wztNgVAR0Oao1DKbadscDW
 TmcxAZhFZ/X6tqFcfDLlzP/YTUtAq3V96E9zZUO2FdMLgqyAS/IIvUIdkKGWGWGiYxBNilo7A1T
 CkMdLnj90agRHuN9qaNONDdAjP+rp165L4aSKhOFYNqhsGFiBkWE80sdbgxuKjaFw64C3RmQAG5
 rAdhH2agr+fz/eGRDheyvp/h7Q8VsfBdiSUtJN3p30H+wpSC4JPii8bUfnHt1N/nUcs/JwRniWz
 OgbGeCWIaidp6KiB1X4eGAY4Y49EPym57U61ouySkR6aAZCn1vUWStC2gNlbvF08+ebBZI49o0y
 +npYZfDRyo1ylAm006JA0SXmwNz77Q==
X-Proofpoint-GUID: r_1FoNivKtXwaOoPjOPrraC0Q-LKGs_d
X-Proofpoint-ORIG-GUID: r_1FoNivKtXwaOoPjOPrraC0Q-LKGs_d
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68ddcfd7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=FDlLM7KsKmT8az22HMIA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On Thu, Oct 02, 2025 at 03:00:03AM +0530, Akhil P Oommen wrote:
> 
> 
> On 9/30/2025 1:05 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 30, 2025 at 11:18:16AM +0530, Akhil P Oommen wrote:
> > > A8x GMU configuration are very similar to A7x. Unfortunately, there are
> > > minor shuffling in the register offsets in the GMU CX register region.
> > > Apart from that, there is a new HFI message support to pass table like
> > > data. This patch adds support for  perf table using this new HFI
> > > message.
> > > 
> > > Apart from that, there is a minor rework in a6xx_gmu_rpmh_arc_votes_init()
> > > to simplify handling of MxG to MxA fallback along with the additional
> > > calculations for the new dependency vote.
> > 
> > I'm sorry, I've sent it too early. This looks like a description
> > of a not-that-related change which should be split to a separate commit.
> > 
> > > 
> > > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > > ---
> > > @@ -555,6 +557,11 @@ static inline int adreno_is_a7xx(struct adreno_gpu *gpu)
> > >   	       adreno_is_a740_family(gpu);
> > >   }
> > > +static inline int adreno_is_a8xx(struct adreno_gpu *gpu)
> > > +{
> > > +	return gpu->info->family >= ADRENO_8XX_GEN1;
> > > +}
> > 
> > This and the register mask updates can go to a separate commit.
> 
> Which mask update exactly?

I'm sorry. Changes in register XML files, adding A8XX into the picture.

> 
> I can split out the hfi table addition and arc table updates into 2 separate
> patches.

That one too.

> 
> -Akhil.
> 
> > 
> > > +
> > >   /* Put vm_start above 32b to catch issues with not setting xyz_BASE_HI */
> > >   #define ADRENO_VM_START 0x100000000ULL
> > >   u64 adreno_private_vm_size(struct msm_gpu *gpu);
> > > diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> > > index 09b8a0b9c0de7615f7e7e6364c198405a498121a..5dce7934056dd6472c368309b4894f0ed4a4d960 100644
> > > --- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> > > +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> > > @@ -66,10 +66,15 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
> > >   	<reg32 offset="0x1f81c" name="GMU_CM3_FW_INIT_RESULT"/>
> > >   	<reg32 offset="0x1f82d" name="GMU_CM3_CFG"/>
> > >   	<reg32 offset="0x1f840" name="GMU_CX_GMU_POWER_COUNTER_ENABLE"/>
> > > +	<reg32 offset="0x1fc10" name="GMU_CX_GMU_POWER_COUNTER_ENABLE" variants="A8XX"/>
> > >   	<reg32 offset="0x1f841" name="GMU_CX_GMU_POWER_COUNTER_SELECT_0"/>
> > >   	<reg32 offset="0x1f842" name="GMU_CX_GMU_POWER_COUNTER_SELECT_1"/>
> > > +	<reg32 offset="0x1fc40" name="GMU_CX_GMU_POWER_COUNTER_SELECT_XOCLK_0" variants="A8XX-"/>
> > > +	<reg32 offset="0x1fc41" name="GMU_CX_GMU_POWER_COUNTER_SELECT_XOCLK_1" variants="A8XX-"/>
> > >   	<reg32 offset="0x1f844" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L"/>
> > > +	<reg32 offset="0x1fca0" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L" variants="A8XX-"/>
> > >   	<reg32 offset="0x1f845" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H"/>
> > > +	<reg32 offset="0x1fca1" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H" variants="A8XX-"/>
> > >   	<reg32 offset="0x1f846" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_1_L"/>
> > >   	<reg32 offset="0x1f847" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_1_H"/>
> > >   	<reg32 offset="0x1f848" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_2_L"/>

-- 
With best wishes
Dmitry
