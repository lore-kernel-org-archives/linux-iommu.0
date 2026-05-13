Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF726E6F3
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691192; cv=none; b=qTyGjME8y7s8AHwKQmf5ue1e/KAvwcrT8gzRCDEa9O4yxYRbmzVf6VMmXVVyvkcO7jU64VYcqCKCQitQ3mpilVS7E/zKZN0cYWCszMw5DdDDe8uZOw4azf7tiJop1+Wj4KA9ZdR75ClijSKIqB+8yuKjKeuEx+IblxV2H5u+2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691192; c=relaxed/simple;
	bh=HpqdRvguomuoFu8cYA9HoqXvq7sfUqnGJaGKOQnfdKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj2Mz6zs6EBkFiYkoW/4qe2UWSYqVPhG2JGbjV3xyMzo7A5JAj3MaK26pYhEYXhGobXcmxN/ETvubNxNI5oaiwOtBphb9CWiG3xCVoGWshoGXMAkNnPPguzVJqZ78eb5UyaHJC1+G9ZlPMUN655xbJD61MNFO3TP64B7XvjcALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VqcTOxGY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZEwCbg8s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqcTOxGY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZEwCbg8s"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DAvgbA1393173
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZOuwO8Oe7+fhFiUNtPbUZRGD
	3ndfLf9Y9W/ejus3N+4=; b=VqcTOxGY8MgLhpL7QdJ7no1pbuPJqDQSDCOQZvYM
	mMv2QA+Iibd/P3kLfEp/Ky0P4VHfBddRiB/PPRujgkEMFpfPetiBU6hWAsdCxFIR
	8Ut7dqpEQwHYBfUyicHI/0cWX9KFNFZE8rT3VOCjQcL8m9+BfElsdQUsIATm1skS
	pjqwAgJ3ViXZjsjoVldeMz5idJoo0ZkjKbBATknvuPAPXU97jAjlkJH4mqR05W1q
	VnYqmW12Qt9uGodhMDo4ORsMNGmV9eXSkRflCsy1J/r6OmTNtqFcMmFHAlhVr5RO
	81+YfJ1nhuBpv3IM31e6/dco5ewo+GlxS3b6PQ639X3PqQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4k262q9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:53:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fb6d713ddso38291241cf.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778691190; x=1779295990; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOuwO8Oe7+fhFiUNtPbUZRGD3ndfLf9Y9W/ejus3N+4=;
        b=ZEwCbg8sy+we1xenaT+36auBpNdLuAy6h+bna47iOZUV4JyLx5V45mhNdKWPvY2Rmp
         KUe7620az1/hTlqss50g8IBN5c4Gaxsr5/LAVuEjGveLe8Pj1Yb7Sv7Y3vr3WGQPTJRd
         p/p1EOmzAF8NnWxTfLc4oMVb+jlQyMngPJbyuIPb1eIuLwudEj+Db4GvA0o+QaWDQF+o
         HA6tKWdfIHeP+0NeNtMGpq/8U2LYSGEnTXirlmZFik46D8ucfrwvYjJ/uzzOxP3irwJr
         9UP3k1Cxtj1YMLkUNImDu8dXjw/DkUG76XtiXSSSvNhiYCkn4c/Zo38YUem6X5wZNiRB
         9FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691190; x=1779295990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOuwO8Oe7+fhFiUNtPbUZRGD3ndfLf9Y9W/ejus3N+4=;
        b=gKViOuG2Qbevt99LeILop6KGCYf2fGIREoH4LguF/aYW7UHJnChjs8+F6xpwpZrabl
         P14EIWW+kFZCYppDM8bVFzsPwWcPAI9sadVKJEJ2P1T8pu6ZSAeixhLU7TfpFBCR2G7N
         n+f8ODlb83ghAjPD/eJFvvrMjLeEaH0SBShoIXp+IuSzGV7ny3pG986DGDBworj7wJip
         dLrGj0qf90TZcFozP0sL1B7zfy9BmP2k7J5YWezgKOgnuU7y1Je18YgYa7nbxofww05s
         EDPGk8ZZJe1TEwuxdyW7Fo8k0K/uLd4H3Y41fwzT9Za5cWG1ErbMX/q/2Uzd/gKHR1sC
         nCrA==
X-Forwarded-Encrypted: i=1; AFNElJ+bY1EBDBFgRgmzPZ+hLhRfv30+4lDS2iMRtfUR+0PZVzP7/rBQ/YFpEJDh/QZ0C5l2O6w98A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5RoVcbGobQdAu/+DiHk22iRDCoguVnD9QK2xAW8UY47iF68we
	iAjTijZibYAd8hRW5KY+IwzKyTAlr1nge9XLL/kWs2if3X/op4WUT1GVMzCzA3xHuz6mrxrjOzM
	JVtNMY+KVfK4mvMggrb5tLi48la4JjUuQtJtI9JADmRyLJKsfhxJlCUZzAA==
X-Gm-Gg: Acq92OE8WbUSSqSgw87fe6RXI6aMhVuMJymsIftYccsjdtMKy6+Kww5pNNuERBuaKjI
	MC0K+qn+CC+1Bk6v/fnNTYUPZ8QbmEl5jSrq/0o0mMiWFxhdbwYLbmUcKDuh0JXktKcjEjysWte
	4J28WrK4v0uDO6n+3yYm14kTgYlvQi9t0cSGgPUaW7urDc3oaWLGZHz4VsT54gBQiU3j1RhOYpi
	koLsbVDGx91I2Bj3bVQS5xoCUy0i6lAXLiyw2W6JiFyGfpPuto6jB8O62+v097/ZYkefsxdNNpg
	tfr5U6PEs+mFLG4yBiEcy4jwuD/ZCbCG23lZ7g0WJBbpx/XNha+mvVLlVbVtQi9xvmOgj5D39XF
	uuHPC0POD01zX+nHftoXg4SnPlQwJn/76zH1hAjuhIJaowrtGwBW8pynCsWYa16XykDzO1nIEjs
	F4CN7KoGf+GU0+eIXUFTTyXG5tEESldqcaef4=
X-Received: by 2002:a05:622a:5912:b0:50d:7384:a660 with SMTP id d75a77b69052e-5162f43f2fdmr54430531cf.6.1778691189598;
        Wed, 13 May 2026 09:53:09 -0700 (PDT)
X-Received: by 2002:a05:622a:5912:b0:50d:7384:a660 with SMTP id d75a77b69052e-5162f43f2fdmr54429961cf.6.1778691189063;
        Wed, 13 May 2026 09:53:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f628a724sm40620501fa.39.2026.05.13.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:53:08 -0700 (PDT)
Date: Wed, 13 May 2026 19:53:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
Message-ID: <hdpvs6gftjhaa2xx3r3ds6ss44bvytnllv2lg6anoiq2iyxwtc@qd7ejefkxmwk>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=M/l97Sws c=1 sm=1 tr=0 ts=6a04ac76 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=XJtuOP1FUQBXJGSJDRYA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3MCBTYWx0ZWRfXzrueqzi6wPsv
 Rgor/4dm+QV2ZFhywHS3JeTtSFeVtKb4anuwgGJFMJXVEAFOlhVYEK3hv3A4LRpDf0naaJG/Hs0
 7hnF3HAx/gl5B4lCV48A8NwXQ6JldXlAIKKu21DHulF2qs+/shWZCW6Je5iBXvOBTQpWXhHVswA
 hSQgiaQzlNQ2Pilso/d1qmcMRusjM7g2IZpKgJllojuyG6q6vFQwDSECQBtZoXrYsTsy5rFqKGg
 CX/Vua+/qEs6E8Vrc+u/EbOX8r3RBQ5zHDIl7nJTiuUuH+cHo9xGL2UrQw2N/4+oFI5B070SPqP
 DBU9U3aucBgnVbO5VXT1lEH7WUmy4epMpmrBlkGJaCyTt8uXU1mJDCesOoqz3kAQZ0aTw1zZtv9
 apr4nZIPgwcFZuZIxtMRbEy6sohMiqcMxcw5L5KbMsrEAH2IzyCme1ZlUYDC5WiWC3IFBTKGhSr
 efbPtl2odaTNO/WpMtw==
X-Proofpoint-ORIG-GUID: yvFRdHLXAinYPLWRw6KuohmcV4wNWkeo
X-Proofpoint-GUID: yvFRdHLXAinYPLWRw6KuohmcV4wNWkeo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130170

On Tue, May 12, 2026 at 03:53:19AM +0530, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It is based on the new slice architecture with 3 slices,
> higher GMEM/caches etc.
> 
> There is some re-arrangement in the reglist to properly cover maximum
> register region. Other than this, the DT description is mostly similar
> to the existing chipsets except the OPP tables.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 232 ++++++++++++++++++++++++++++++++
>  1 file changed, 232 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
