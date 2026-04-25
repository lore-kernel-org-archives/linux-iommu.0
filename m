Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73029ACCD
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777113345; cv=pass; b=poEqdmjOdObDAcy1Cpz+mA+dZUz2GSSeqb2LYmyt8O94SMoNMES5+iAzLqF/XJrex2Pu+YG2RNkhjON0H3miYY+Mhhcn70MbfR7s6o8EI7m7ces2yDZMnsii7s8h6OUR5q3319Tbxo0FZXZ+XpXQCFwAzQqwvf51Yij84//yBQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777113345; c=relaxed/simple;
	bh=4NBgU5nhiCAulZ8OH3gzj5HZxHYRUI3QHz5iaW52bM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYWYavEdFpwmBvwzRdrcDy8mjRS8vXV4LKl2vfXX1+K0QUXDy2WuDAlMyG5epmwP3t3/Cp+QkezlnPQKOtNWfC6VDG6F3Gj7IDwUNMQuFZDOWeGwytY2dvT9nEzMn146Nvu4UXAPx3/i6WgnWjt56mbhjtY6BgkyP/R8JBMsT9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGBFF5tT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VcWI/CcD; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGBFF5tT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VcWI/CcD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63P3S9cK2954633
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 10:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jxCmCQDJ+QKREcMZ2PcVDsOS
	3meXGSX8BjTm2djUMR8=; b=dGBFF5tTpOPFqq2QI4ayNBfnKhRP/k7EDxQIgTYF
	sGqNW5qPUHUXETkyh7iTM5vTeVm9lfUpClEKREr45gJneIbvw4kHmodwjLqqMHe+
	lBBwMGPTQWuzEgmWxoBk9Wi0UE21yKwWY997OZpr3nbrAqm0St4mgvR87fe6WSle
	vITCEfARKXWVSdbl2gUEAEljTKIR0F/ZeBRQ7JWsV+MJXV1I+YQPkAtwgVqWyFuB
	sl3EzPSs+264Drdh8r9xtX2gRqr6IxAuEstVGDGw8IZ6EocBU+dZxYt5DGv2pHrh
	YMbYTmEnSwJ5XvRbZTIKE+EM/htPgfVJF9WxWcBg5GPXuw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnqrgpsw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 10:35:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b4530a90fdso172020815ad.1
        for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 03:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777113341; cv=none;
        d=google.com; s=arc-20240605;
        b=SYB+4UR+0mWr9caJ1aYl5DaauQrhRzlVwR2ZLIQjpU1U/2hzIaJ7ujIRqP+gnGtOF6
         A1jI36iJQnxR0Knr1Lx1GZ37KIMHkXZ+nLVCha4WXJWxGulrc9DBFwjOxdQn7LAzE0xa
         u3fag/P7uVQ3Y5sJ15UwYz+kG2V+CUpbzaKF5v2BIA7uApK8/I9sHFClvc9P3yFxo6F1
         PrIw8AAbrLM8VHuipv9aGvmkxw72PPYYYq8+j3s6hwQ4YqlBaSSaYTcP1puAhIdjBdXt
         q6dBtQdkk4209k1DGgFgMMkMM0CmmKOB44G51Z41mAcnYEi6omNMnmaMHTJ4AbRg1fJN
         gCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jxCmCQDJ+QKREcMZ2PcVDsOS3meXGSX8BjTm2djUMR8=;
        fh=HwTz2iMUUeWtOBanukr5yqU/1fksHkm1vm9EpHpEFSs=;
        b=dtOAm4kxPx5tgpBNh4ymQH3ES7qC6f790fApSLeYrKAtQWHHgk1HXJNaggEbNttvnx
         1R+AHbU36VfWPQlAiK+trFi0fj0mJcwiNc4WNU2ZuDrlTCpK2TEDYJI1LxHQNfxiFqZ3
         Tm0pjzYK8TNETAE2wHuBnN/gTyxrdimn9LEIsjQ1gURnYvyN+kziQtOZF4ARtX757lIU
         xEqc3uccDjuTgUVoz0342hmM8fklgnhmZwNf+bxxiBJGbTME401hfXPh8ZPvGMvo5Zxz
         +N6KWpJ0itodv9OKVT3f1nDk5jZ/5xW7m3TRQB4TyGWPDZpyQIp1rmAr4W92fKGjMROI
         71Iw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777113341; x=1777718141; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jxCmCQDJ+QKREcMZ2PcVDsOS3meXGSX8BjTm2djUMR8=;
        b=VcWI/CcDfGVHuFn14WPlxhVD9Y133Eu9DeRvYjGUJG8LXDXGa0yahp9AtvGHLCgTB/
         /hqjW5oyv9Ah9qyDJU/WqjwxnMXGu4NJVIMa7ttktXQFSU/pAIzvUFkmRZR6ZxgGVX4D
         RQ6+Jccw4M7qUfkQiwHjl1JzUVPKj+8Ysg4jesgyjkkblXsRdj54rnvsPWgp1d8slU74
         hq+0gOIndA6nQ5ajhVrGCkJFl1L9F4IhQEu2MoV5lfpgEKdGqEUAN4ZLgSQSQXWbKmI3
         ADsDGAT1jZnxWxfmcvfmFlde6KqqJYb4SPrI3NI/p7QcRPJV/3CrSjU0jvD4NfqJY41E
         oXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777113341; x=1777718141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxCmCQDJ+QKREcMZ2PcVDsOS3meXGSX8BjTm2djUMR8=;
        b=lF6w7GLEyGR5CH06/DdF7mqAvHAImD7gj6noPgUghNOKMZUa2gjF5pmrebDvRaKoAa
         Lxl71Zh3uwt4NvGSgsTmn5vhASmN+3ydTl8c6IFUkzj4EXM65UB8vJnatBF4t4HaojkY
         GEX/h5MCLV4xkcwfv6w6HgWUiBFRysznUpGDY91UGbYyddhd8oSnF71hnup9BkEkWfcu
         AUI8FlWCqwVnXncVv6Vs/bmnbDoB2p00JUsjJ5qoc0BiDa6R0B3mp+GpBF6T+cqXnVXb
         fZ64XGLyftbkrqEg5c5mnNDl/rEf7US5xHulL/q5eMFbDfkerzJyxWXoDEp8SJEL5fhF
         NGJg==
X-Forwarded-Encrypted: i=1; AFNElJ/NEflP0Li8zbYuZ3IYYASfJ9UkrSiDbvR1/f2wh8Fj980xbfMV7gDDfNjOvxENs/t7B8j+0w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yypg295/56/Dbm7OH51wqn7f1E0WEYusixnMprv/dQDQYeCTxYr
	lEhCCbWyz1KMNjxyg9mtk/nrT6nl2FsYUokpJOzAW+m+ofS4NRfqJ8V3ox9OAHQX2IOy3E1CNqD
	X5K1ET95y7ZNwQWlU3MgAes4B2hF5OqLCOGDV2a8+draIw4BCGmS1BX6dgirq8OD0cVWEVcNTQw
	5feZIHG995vBmR8iExDI0ZguT/UpKpXH4J
X-Gm-Gg: AeBDieu5qH/wFssVaGmGWCv4kLpUqbZMqjNHdCrHDxG7kcw4sQcr1daNusV1up11qhG
	slqO8T+iWfP5OKaWwZmc9moXBTkyn2rKxRySDlZgCxZuUWYQcvxVfV/c/PD88UhPtJ8upx/j16J
	zSoNBm3xSVp94RHjOzQM/xWsda4s4yK8me6gyP+Mp4Bq/zr4n9I08rGHyirtWdIjIV2G0fd8KQN
	M5ir8ihJ/GUU/0mnyQ=
X-Received: by 2002:a05:6a20:3ca3:b0:398:77ae:8d8b with SMTP id adf61e73a8af0-3a09d099c4dmr37413525637.10.1777113341002;
        Sat, 25 Apr 2026 03:35:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca3:b0:398:77ae:8d8b with SMTP id
 adf61e73a8af0-3a09d099c4dmr37413465637.10.1777113340418; Sat, 25 Apr 2026
 03:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-2-0296bccb9f4e@oss.qualcomm.com> <2026042346-trustable-register-095a@gregkh>
 <06c04947-e72e-679b-493b-e112d693f391@oss.qualcomm.com> <2026042422-deem-chemist-8d0f@gregkh>
 <4c3fa710-f61a-4aad-622d-54909190cb9e@oss.qualcomm.com> <2026042428-blemish-helpline-7d8d@gregkh>
 <1e039dd5-da3f-19b2-ef98-29e64fdd925d@oss.qualcomm.com> <2026042442-luxurious-antonym-f20c@gregkh>
 <xuitjl6tzfl6nl4ds4vdy3637i5cqtjuqntcpqt5fnkx2ogcws@iapcavrwhyzv> <2026042539-swab-active-21a5@gregkh>
In-Reply-To: <2026042539-swab-active-21a5@gregkh>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 25 Apr 2026 13:35:28 +0300
X-Gm-Features: AQROBzCbHZ9w70YTtp6TmSB59GwDi5IqmqQ6RzKXe3MebdTi8LTOo1dC7YaDYn8
Message-ID: <CAO9ioeXWM74DEa=SA2vSvN_cmXivDth2VSmv2c1SOWtdL2i=OA@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] drivers: base: Add generic dma context bus
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDEwNSBTYWx0ZWRfX3t9tY6laRRoH
 hO0TJgQZxJiVdGQs6qUKW59I4TT+4fapWp2XOiVb/7tiM0Jkj2EH/JiwTIhAtYjJ1MyYu74Ljjt
 Kw8FILyQSXCyA4fSKOtw97iQ6wwG+tmTmj2l8p2ro4nrvQZ7YYdQgaPtOccSAzPu8PBgPEZ4FPI
 /CbGhxVvN3eJ0jCYteXIm/hQOIhXlv2ivFFVdHcw6qRovQHFkxoaBvqM2NBN8GfuWpndDcesBCU
 +3NGIZusqZlCXrpFw4QApA7iFgdEDFNqU05xk+eG7XMh2MpPKZ7/Qih/xX8xZz7SQmifoY20mSu
 0XKqtWJu1LJA0Zt9dpQI9p0nC3uK0WJJOlQKAanyW/WIyHFq9zf3APmbYSDR0cLRaGuByfXLIlH
 TGARBnUZnmieOXZTMlJvwELKH+nVVcNu1x8OzlBJ3c7vPcjO5kACyVbl7LZYk0ZBr/eQBWUuzaG
 8fVspIjpSftJNps9ZNA==
X-Proofpoint-ORIG-GUID: Nxn14peOAqZKMVYb1ZCtFmW7ujiWj5YV
X-Proofpoint-GUID: Nxn14peOAqZKMVYb1ZCtFmW7ujiWj5YV
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=69ec98fe cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8
 a=ag1SF4gXAAAA:8 a=G4jgJTYFYwyYmvXJBf8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250105

On Sat, 25 Apr 2026 at 08:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 24, 2026 at 07:11:35PM +0300, Dmitry Baryshkov wrote:
> > On Fri, Apr 24, 2026 at 03:34:38PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 24, 2026 at 06:12:09PM +0530, Vishnu Reddy wrote:
> > > >
> > > > On 4/24/2026 5:25 PM, Greg Kroah-Hartman wrote:
> > > > > On Fri, Apr 24, 2026 at 05:15:02PM +0530, Vishnu Reddy wrote:
> > > > >> On 4/24/2026 4:43 PM, Greg Kroah-Hartman wrote:
> > > > >>> On Fri, Apr 24, 2026 at 04:01:13PM +0530, Vishnu Reddy wrote:
> > > > >>>> On 4/23/2026 7:07 PM, Greg Kroah-Hartman wrote:
> > > > >>>>> On Thu, Apr 23, 2026 at 06:59:31PM +0530, Vishnu Reddy wrote:
> > > > >>>>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > > > >>>>>>
> > > > >>>>>> When a driver needs to create virtual device at runtime and map it to
> > > > >>>>>> an IOMMU context for memory isolation, there is no common bus available
> > > > >>>>>> for this purpose. Each driver ends up implementing its own bus type,
> > > > >>>>>> leading to duplicated logic across multiple drivers.
> > > > >>>>>>
> > > > >>>>>> host1x driver implemented its own bus type to attach an IOMMU context to
> > > > >>>>>> a dynamically created device. The Iris VPU driver now has the same
> > > > >>>>>> requirement. Rather than duplicating the same bus logic again, a shared
> > > > >>>>>> bus type is introduced under drivers/base that multiple drivers can use
> > > > >>>>>> directly.
> > > > >>>>>>
> > > > >>>>>> The bus takes care of creating a device and attaching the IOMMU context
> > > > >>>>>> to it based on the client inputs.
> > > > >>>>>>
> > > > >>>>>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > >>>>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > > > >>>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > > >>>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > >>>>>> ---
> > > > >>>>>>  drivers/base/Kconfig            |  3 ++
> > > > >>>>>>  drivers/base/Makefile           |  1 +
> > > > >>>>>>  drivers/base/dma_context_bus.c  | 77 +++++++++++++++++++++++++++++++++++++++++
> > > > >>>>>>  include/linux/dma_context_bus.h | 26 ++++++++++++++
> > > > >>>>>>  4 files changed, 107 insertions(+)
> > > > >>>>> as you can not have a device on multiple busses at the same time, this
> > > > >>>>> makes no sense to me at all.  "dma context" is a bus-specific thing, so
> > > > >>>>> please add it to the bus that you are wanting it for.  It can't be a
> > > > >>>>> generic bus as that just doesn't work.
> > > > >>>>>
> > > > >>>>> Or what am I missing here?
> > > > >>>>>
> > > > >>>>> And why is DMA somehow "special" here from any other hardware attribute?
> > > > >>>> Let me give brief information which was discussed, in the initial series,
> > > > >>>> the iris VPU used platform bus for dynamically created devices and we got
> > > > >>>> the comment/suggestion from Robin to implement a proper bus_type with a
> > > > >>>> .dma_configure callback.
> > > > >>>>
> > > > >>>> https://lore.kernel.org/all/02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com/
> > > > >>>>
> > > > >>>> based on the discussion, implemented the dma_context_bus and used for iris
> > > > >>>> VPU devices instead of platform bus.
> > > > >>> Why not make a irus_vpu_bus where you can do what you want?
> > > > >> Initially iris_vpu_bus was introduced, and it was made generic based on the
> > > > >> discussion,
> > > > >>
> > > > >> https://lore.kernel.org/all/20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com/
> > > > > I don't really see that request here, I see a "make this better and more
> > > > > generic for other busses" but that does not mean "dump it into
> > > > > drivers/bus/ for someone else to maintain" :)
> > > > >
> > > > >>>> Here, the device have only one bus (dma_context_bus), not multiple buses.
> > > > >>>>
> > > > >>>> Regarding the "DMA" naming, the core operation of this bus is its
> > > > >>>> .dma_configure callback, which calls of_dma_configure_id() to map the device
> > > > >>>> to a corresponding IOMMU stream ID. The name "dma_context" reflects this
> > > > >>>> purpose.
> > > > >>>>
> > > > >>>> I am open to suggestions from you or Robin or anyone else, if there is a
> > > > >>>> better or preferred way to achieve this, I am happy to consider it and
> > > > >>>> rework the implementation accordingly.
> > > > >>> As there is only one user, just make this your own bus please and do all
> > > > >>> of the needed bus operations for your devices there (i.e. don't hang an
> > > > >>> "empty" device off of it.)
> > > > >> The reasoning behind to make it generic was to have more users - host1x,
> > > > >> Iris VPU, QDA on the generic context bus, instead of each of them having
> > > > >> their own. Let me know if you suggest to have the iris_vpu_bus.
> > > > > But you did not add such users here, so how would we know this?
> > > > >
> > > > > And still, I have no idea what this bus really is doing.  Is it dynamic?
> > > > > Is it self-describing?  Why not just use aux-bus?  What is it supposed
> > > > > to be doing and used for?
> > > >
> > > > This bus will allow users to create a dynamic device and map to IOMMU stream
> > > > ID via .dma_configure callback which calls the of_dma_confgure_id() based on
> > > > the user inputs. This bus is under the iommu_buses list to register for bus
> > > > notifier callbacks for iommu_probe_device() and iommu_release_device() during
> > > > add and remove.
> > >
> > > But a device is nothing on its own.  You can not just have a random
> > > 'struct device' hanging out there that does nothing but iommu, right?
> > > It should be doing something else that is very "bus" specific.
> >
> > Unfortunately, it is a pattern of IOMMU-only devices. All the actual
> > programmig is done through IO region associated with the main device,
> > while subdevices are mostly used for DMA buffer allocation.
>
> Great, then you have a "host controller" for the devices, and children
> devices on that bus, with proper drivers binding to them.  Like all
> other normal busses.

I see your point.

>
> Yes, writing a new bus is a bit more pain than it should be, one of
> these days someone will get around to making that simpler...
>
> Along those lines, why aren't these new drivers in rust?  :)

:-D


-- 
With best wishes
Dmitry
