Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6E33F5B8
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701560; cv=none; b=qqe2mmhOQbOv49xJyPPU77TkJoGgJIeGJZomGE6Z/OieSZ0jfXIywFbfG09pkOteJLBj0IjOjFt70Gp3bSnn8utauKRCa0tpDjMTi5ziTp1foQNO+4wbu1Eha06vY3dNKLyBtQK/oRxBdW+tgyJvxc/bFq81t7NU3nadScGwHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701560; c=relaxed/simple;
	bh=Ddaqyw1m/14YYHGc8xCANc13nNu41Di6AXWRLFx2tX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfbvo37baU1/+e/MC2vdalua9p/lNWXKhJd044L9nXWw/r0YFMCGSKYiyAKB3SGlJzYHJ7qVa/KRLdEuBljKQKudrOm64qV2Y0dQN3WSWfIwJo05lg4AuqHPerE97a+8yJcswH33K6iIRGCmLs2qQK1wwtErddxkVj0ZZP6lGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dOqbvS7T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P+khwPsl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dOqbvS7T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P+khwPsl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53gLo3473632
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 06:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rtCPHKhPDf9C+0niIN8vrfYp
	sjSbZrHpfE+J0tDFNoA=; b=dOqbvS7TZdyE+L5yVBE9M8wlnmjlbnVBE7U6iEKU
	O/CIbInbAh5fOlLBEuBfQ9SeFOTX1XMNhh7P17DMSMvhmnmXGP+Jml1wr5r/DS0+
	EGba4PjjSN2Vqh6ehzEtRohcwCKZw/LXDWXoVSRavoB36cKYfDJ/Z6xi64N1C5SR
	F2gjzwl8LKdRJxjfyEaj1tb931Y9AVFZF+olLBfZMJOgwB4udqA/3qTdkVLOXhge
	Gz7gforDn+ZyJsVQzgJspHHh0hqwjLlR2GBRl4OBXv89BfZpLnwvk0HjvC2hpICh
	ib3hZAE61M6NwzbmrsE2ivqEe5iXQxHij6lPhMyrNe8BzA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6ftjv1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 06:25:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso246875761cf.2
        for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 23:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784701557; x=1785306357; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rtCPHKhPDf9C+0niIN8vrfYpsjSbZrHpfE+J0tDFNoA=;
        b=P+khwPslhZD99PX0ll+nul21WUL6Zd4XIhtJTOirp6Tb9oXvSvJLjj+McfUvmPMI62
         imlW1ALQC89gJPs17ZK5hmASP1/Wuw4WlrIYZrCv1FeRrQmH/xo5rqivMqSBGSyGguZU
         nSr8skSIx3jo2BL1Ovmt+YQBMAQ67pYUgF7fxKAeEl+KJd0NFvSQt1DAlxx3jgVWlEKt
         lDRQIxAiRtRVejvdo1tn5H/+NfBCZ6qgJMyfG2u8ECKNY0C9w9QG8cNGSp4BRVUm3Y2w
         +m+md4LVKQh6gmVPtjAU9SLQYu7HHYOCcaPerh0Lkt9+XSUo70iZYUkkIhh8hDvUOtyt
         ztZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784701557; x=1785306357;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtCPHKhPDf9C+0niIN8vrfYpsjSbZrHpfE+J0tDFNoA=;
        b=anTUHBdKq1rQHoWeKouVX6zbmD53eYSAqvxGS5FsiK/hwSZqcb/W1EjKb/BnonLR6W
         Vd8RAXkJXSAsifJ1FKR6S4LIMqQBPz4FQORWTAYKFroDyE9gPV7FM/iYnlnfQN4aK3r7
         KZ86uCqKlP8PrwwPJTKCdvITwlEWLJWswSdsXxJtc651V4iQJYT8IXkFOR+/w/FS3Gx1
         +tu7b7dA9m7yspUYua8DmaXyVAV+wKhQGuHhWRcUYX3GTFDi7ZDkXCv17ApH+OEdfJ14
         ptV3loiJEeHHyJTHSBU7vxEZyoWKzK50Yul0v8H/fya/QhK7D8nP296+sFTjxxJTIfn5
         F30Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp5GRr3dBXyMuIQcK2slrqKLCc1bVcm35/Pt7rfOVuZRZNE6qFGPO8lG1u3eNOt96B2aMOORw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsQWq+i1ERLvgu5qROztFn2dOHjP7wCFUG6vT2cPsgu3tl6s0c
	p2KNeJLYQymeBIWmVntZKTuCw3W+ZpnaGRvUcQgnU2osyKVjMO1JpV39eF8D18SCH93sU49lz8d
	LYyL1MO0yNgFJerBWKr7WWSlnUxbD3CWEqYGQZmkCBj8M6a+HGTReTA+VzA==
X-Gm-Gg: AR+sD11j68Iba2+PUqV2xbC10ka7k9jRhLBWssI+wQawThNcqWMXv8tXmeOxUvgEOYL
	lG/X9N/glnsmfPId2cJ75zCpv5RF8l1ktWAVk3Ifiid3tjpKE15yD5GFoI6Cc2YTLdDPmUQa9gp
	sMHeZ7QujtG1wHdsqfWwUFheH5zkmtwd27GR/yFy5Rc2fPAtvGuy01NfBEEIhfM2LgxrV1pJUgT
	mF3gwUmPLrQ53uvjhlanimTNwup1mlnGz5IrATafOtJGvCAj7Osy23exi4shiDI0xWDWcWyLAs2
	sI1O4QekPQc907BGrOTfe5UucwyKuLR0eG7pPIyl2boeEiErhtvz2ql8U3PqX2ew3Qjv7ex5rKc
	OdUhQRv9Z2IlDUxktRHWD3fOcCi7sbnk4wWu0KukC8ypiYE8yiivyQImIGMXavmDLe3ANGqLwoA
	sm775GwxzoPpqcvA==
X-Received: by 2002:a05:622a:2519:b0:51c:21d1:3852 with SMTP id d75a77b69052e-5213c00ef25mr200940851cf.5.1784701557488;
        Tue, 21 Jul 2026 23:25:57 -0700 (PDT)
X-Received: by 2002:a05:622a:2519:b0:51c:21d1:3852 with SMTP id d75a77b69052e-5213c00ef25mr200940531cf.5.1784701556887;
        Tue, 21 Jul 2026 23:25:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9b9a801sm293855e87.19.2026.07.21.23.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:25:54 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:25:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/msm: limit the per-master Machine ID list
Message-ID: <luaghwrvbxffhgku2y6pwysrcr5zcd2s4gn3pu6z3rtu2ryevj@uaqnkvlkyvhp>
References: <20260722041619.17735-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722041619.17735-1-pengpeng@iscas.ac.cn>
X-Proofpoint-GUID: ND-9T1l7rygrcuaHADO2H37JRrEu4bMN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NyBTYWx0ZWRfX837St3+WkUYm
 cfPD/r3WT+tovl2SmEj0pZfQnTYmZSaNAhDwmRPSAM8nE15sNXEN26W5O3HwZYyW6vEYKxIKAsW
 vfZ4lJB9xGcixCCK942SkCvbugL+yofm17ERZVP/cZEowEOjvJmkccB9BbND6oVCerPW3Xm0mlQ
 Bm1PIuMjeuVm3tA6XsYXNSYI5Kr7qizaH8Y4AcGqamkxl8XGt50pNnF8Wp9m4HzI5ywFOc4oKTP
 aoRtRnn3ne6jX7i0jjA47LNrOAIEdLNb8zDQBjnwHzy27LbD+E/iQlz5JDvYe3IT8q+hj1wKIIJ
 4gw53qB0WdkKDND33UzGb0hsyXt558/YsuNVlm81Xq7LS58g0G/2d93fI+5US+FRWzPt7P+ySU1
 q/AVNGk9qFgSpyoMSi78ezhbvIX/HMXmAUatKFjdLoZJ9JZP2wUVsUiAIOQWd3bn/uLqlSwR+VE
 s5CcBvH2oi5pv/giL0A==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a606276 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=zmGlE_0ODbVwEF9q14gA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ND-9T1l7rygrcuaHADO2H37JRrEu4bMN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NyBTYWx0ZWRfX24Dk+zz6+IFi
 6oveRYVBscTDZo6SPG+TSd1s/x8g56zWvKtK5YqsRq9arzmdmnXCQxODsbfhlLVBy6lSEaZcEzk
 59NUI/4xgzUBV2p0DYrYLExNfnkd5S4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220057

On Wed, Jul 22, 2026 at 12:16:19PM +0800, Pengpeng Hou wrote:
> The OF translation path appends each unique stream ID from an IOMMU
> specifier to the fixed mids array in the per-master object. It currently
> has no capacity check before storing at mids[num_mids] and incrementing
> num_mids.
> 
> Return -ENOSPC when the array is full rather than writing the next ID
> beyond it.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/iommu/msm_iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
