Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2F3E928F
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282658; cv=none; b=tv5yBvI3vrjwpEbMMEzwD/mrtfLBDhmv+Pxtx3BDRBh/nd5MO7enL18rmthI/DNWFtahkI72RthsInTCR7sO5834auapMAjuTT/2SPmQiDQ2hH/D8cggF7ZkTuO2ch0sRXK6QcpuzkklhWIm6YgLeHDKw6ZfKhjBaYPB55qROsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282658; c=relaxed/simple;
	bh=b+LOl3IQIWey+yqKD15aAKzUfwpcbFTQfAYLBqw7JY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdNdSV/IyTVb8MptCnFP5lO22agPBdIb3FGfQPS3ie/r8bjUykM5GbfkfMR6YDk5SIQIaYqo2Fk7NVVhWA+WmeE69v992DDMF1RCIe3PqPVjWQVv7kCGjTdxuQBNYSyibhPAtfDLaPyva+Y2NJgFyvr+Qg+ILQY1P0ao1xIN3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MRg1oEUb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RpYGa6+1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MRg1oEUb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RpYGa6+1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cHAr2098521
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 10:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	anIBn74AomYL3LvVUUMgs2E/qq+99IUZOlzTnnvEbFM=; b=MRg1oEUb4Ni+i2BO
	85OR+1wFl0TJaLyWh6kTHFHLaUjOj02Cx1mtmUilXdPxNcb0DnnWBJ4skh/mCkA1
	b9KmpzUt8yVzFY74+PuBChac/gqyBCLx4yJSJuUtjQRhswQiicgCzK7dF0qiqqfQ
	ZTDxKD4gxoGhuD7/cErPwg0+vk0CNPQrRZwg0/gWe3f1970scNms3dAHTOvc7KTv
	ufs39S7hoqiVvu9aqfM5PZtTG2D/LXlUwgVqL+nYmT/VPOdL9aSNkMxEspzoN5H6
	I7VeS0QMmRCoU3UZxipET5FLKH06WNTwwJX4p8qPvCkSqGNLywbVhAM++An3KYPh
	qeuKDw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6k6bk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 10:04:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c07313be5so15253901cf.2
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784282656; x=1784887456; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anIBn74AomYL3LvVUUMgs2E/qq+99IUZOlzTnnvEbFM=;
        b=RpYGa6+1WU4c6lNLRyPrqvdHd3TrneC8lGtFRb5irqR86QGyqYKDsbIZQZJ9pffVw0
         xU6FwRYkqT5hVnKnSuD15/q3G4V8sK9f52HNTsf1N7TyvYlX1Byl4D65kRFI1+ugvNl9
         dDNrcOLDpKupWdIfM4oYth1V0oFIWT/2GrT3PM2JNH4KzoWJho+wftYQaSykcDmJMaOd
         IW0zHbe+It74dY72TqVQzPpGBBz01e9jIior8H5HuSD449Pt0oTJeaAwOQJbf/zMVw66
         mIzB0mejYFLwHWYX+4BtTWzKNfQJrewE8Z/wvwtMICpo5zm4+wdwa0Z9oaeFl3QiMffb
         /zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784282656; x=1784887456;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anIBn74AomYL3LvVUUMgs2E/qq+99IUZOlzTnnvEbFM=;
        b=TnK/jfWQk4AqHB9soQk1wKJlHUigGuHTkL4mekPxJtdfODycd6vk6y02tPRcaTQgUj
         9FdWpbF4dYNAaqhGQgBtd/2DpYIZuzllJp14B71Sn4UCTK4X5OORWyYypRW3K3ozXs5Z
         W3UM/NqU/k7C+cHWwHOLVJ5gq7TYFn6sIEsQnx/JLCrC9gZEFRUsIEMSa4eM6hzk335J
         SzoJPo+16ZjF7J/ly+V/t/Zljb67KpQHsDWE1fvSNcrUwJH3Ygt1zrwZj9wd3kUk3HIY
         fSK7Qi/QX+P4PXH+JqJK3ZTE3kAU0yNRpr5h98mrg8SaOs9cTIt0cFaKo3aQL0Amou8v
         RtQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAOMxObW4htYuJVqv3jBNp2d2qyGVW0GlBwe4CvnfaAsKxIY79RXXwBCBMr8Sa3kfHTzm73Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRygX5VMk27tRLdMyDba31Z1N8ZTOqS2cXf9EmPGeqaNQrKSx/
	qwx/oQm12KWQKtydOJCPpyNj7aRJoWyvXcWBt0ZfYJTcPUJwMHrjmtpkPRUW9na9bs1SAB6uIok
	WoitO5pllyf/jXSNz0vMqIZtJ1r5ZI1Xj7c9jxGyjnIplj5fe2ITRaaweyA==
X-Gm-Gg: AfdE7cmSbo8qNxjmZRDxj5As43/G6F2KQ8MF5xaaUJ5hUNd43t2zcUMoE7j6nmdbJ2x
	r3hk1KFBNXtnTH2J4qjJqhZaBlnGwZjINWZmz82JPahS8ax8fEbiy2mJr6lmv+8eitQflEFZX8s
	RoMTekvJl1wA1A4gCk8Jsoyyiw7E/VZWUFaq+AfTtAS4DG5TZIVd2qbJaQhuLdozI9eVEC54dfi
	NcNKyfIX0yJi7Qzw44eeR47XUciqlznJs40WwtczgWYwKFbhXMrcCjiFZRkPHegz2+kKTKhF4lx
	44icZZh7J285kDoLeFlEnVVyH173SmMKHGr3QNny9Y8rcL+Dyar5vXp4239n6wABSsK1QiDezF0
	Q9ijIZU+ZnH8fFMAnMBZxPhau
X-Received: by 2002:a05:622a:1c15:b0:517:5e32:f3ac with SMTP id d75a77b69052e-521382dd29cmr12698201cf.0.1784282655978;
        Fri, 17 Jul 2026 03:04:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1c15:b0:517:5e32:f3ac with SMTP id d75a77b69052e-521382dd29cmr12697701cf.0.1784282655380;
        Fri, 17 Jul 2026 03:04:15 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c17127358e1sm51516866b.25.2026.07.17.03.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 03:04:14 -0700 (PDT)
Message-ID: <2c6b3958-696b-46d9-ab70-87081610524d@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 12:04:10 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: dts: qcom: eliza: Add GPU nodes
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-7-c9f1354dbd29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-7-c9f1354dbd29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMCBTYWx0ZWRfX8IkAXUT+itEz
 g5omqFj87W95cDEBVAqOjeWn5sW7HMqJHqBmYEseUc4VvG/yjoDtJJuBe9HsBM8eKDG36DankTZ
 dPY1QN1yDgW7cjggEGn613+AT3JHdaHOXo4007rjDMUG5vtHNWBZAi+kDngXOyjuOneGyTtkdvZ
 nKcb3WXiZsDr783MWK+CnOibB8Qw7zDKrkRh6CUsC2arbtvaENbmWGH+GHc429maxS2D7aAdUFS
 ASCkBrKdJXBOAkSHJr4mOMzug7YoIM/HsbIh3xNuOp3192K9qg3WmSr3lmkQFmS/Ir1BZeZaGGR
 piEkXhlRHddbOi6AAv/HB/HiwCMyMQf8SULbA09QHyj6+72+cJgNKqOJltMvFy1akBHnJoYgTZr
 SFJmsYsLN5iPTlEu+lx2cqqBOnKveKnnFTXNc2H/FAhURDI+baT+rg7Qe2042NM6K64Vi3XPKmv
 FuS0FCh7VKUsKRlL4ug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMCBTYWx0ZWRfX4axG6SJVETFZ
 kX4RvBAhlzO1gIZVS2k1aQxohQK+6NHTVufO8zIdUcyTlY+khY0bFMEvE+X7rDgkFggV23Et++h
 iNwBiynLoiFAtroNb0QriOZ1l0sXmsQ=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a59fe20 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=LzKdWfoJb4QxxMUDPeAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: l2E__-Rerq6H-3oFDYNowoFNin98bw_x
X-Proofpoint-ORIG-GUID: l2E__-Rerq6H-3oFDYNowoFNin98bw_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170100

On 7/5/26 10:14 AM, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> Adreno 722 found in Eliza chipset belongs to the A7x GEN1 family. It is
> derived from A730 and shares the same IP-level configurations: HWCG
> registers, protected registers, GBIF CX registers and gmu_cgc_mode.
> Major differences include lower cache/core counts, 1MB GMEM, no
> Concurrent Binning & LPAC support. Some of the peripheral blocks like
> RSCC are from A740 that resulted in updates to RSC layout.
> 
> Add the necessary devicetree nodes to describe this GPU.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

