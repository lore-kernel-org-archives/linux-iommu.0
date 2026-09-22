Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79685545DAA
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082145; cv=none; b=IeeFc6+YLPKuhQ+m0WcQhlw0P6rEFAq9lutmxCJs9pZUgO02aY138NK3E9nQ/B5ZIxi2LMj26SpsvTRtFpsudMJB2W49T/CUwpFMkp3G+5HcsyN3fOwScNtjse5DsffWW6LfGPHt/qhNm9v6IZcDH/1GcD0dgEU2O+Q9IbMMtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082145; c=relaxed/simple;
	bh=LLUNgr+JTLVIsA7tRQ7tzGf4PiaoeK1+F2kHwWJ+SUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3Nio2god76XL5pcT7UukOzMUaLnowM5T+AeIBAR8mI0bjKVt/C7nwU5M19GmJBU/4G5VNHaaUDHq/5UVPmVIH/GwTD0pzmTTHru4n8Kr3gAFTUMZgnOBCt2O/fFtgBPhjFIv1g0YVAaYHcTU+mVGIilWXvBl5SCaeO/RBkxSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cq+N7rmM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L4JY0EIs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cq+N7rmM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4JY0EIs"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBOvYr984480
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vMPZw4XRMMmJIbHmlyrL3fJr
	7/HG4Z5DoMUR3Yhy7x8=; b=cq+N7rmMhHSRdt792B97zQ4tvO6DSCzyCokGEWgP
	0l7nkIikD8mjnvCxj0XfM+sExJ7pauZdmeyr5WuEzEgstdeVyM5IQYkK/9jAqLHy
	t2AgS6URL3HMRrhXZ2ojUbN+pSVIDMmTiRXcP9MdDucV8QlgaL7xGIMTKLCiXSng
	1j6BY1HkLDQFRe0E22et/Koh70oEHiOcgW1caZrJhgsQ6PTFXa1ohFHBnRtRox9i
	Pj9CKtXGkjuhWudQcS/NPYIm/ycI9VoJ4k9mbcgBVQPgKEX2xTRZyYFU60l6fBpv
	o5JmEsuAEwKiszx7RRbOQRqWqH5QhM612JzYXUaAfbg+Sw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guqk4rqaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:02:23 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c82fe2ba8aso5021133e0c.0
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790082143; x=1790686943; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vMPZw4XRMMmJIbHmlyrL3fJr7/HG4Z5DoMUR3Yhy7x8=;
        b=L4JY0EIsI1f6UgeHkLGvBQPog3I//EM47qE+VLQKSuImURQxXvgnIkwncnnqrmQKvW
         +KiF/8ay3NGnybFKItAu+hpTowdw8o0wKdsVlJ5T89Nztf0dnA/6VZeLu7JpVmmCgOVF
         BLdB+P8iWxJl5Y+d62jRNyJehOlNv20FOUliciJzULUCd3s2eGjXaHsqLUf6oor1v61v
         eG8wvjayxNKSR9jVtcE/hSpT88ek0Cdb7ZA7LVbnNq3IT8w0rPDlZ28lzoJtu+YVaY81
         vWtSfcCIibGZD70phb/unIRM1ouddfXMpAts51Xsdb6RcpEHVr6CNhzsSYvYfEbW0CGw
         ai8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082143; x=1790686943;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMPZw4XRMMmJIbHmlyrL3fJr7/HG4Z5DoMUR3Yhy7x8=;
        b=ViPm0VBlNEy+CQJTse7orA5OzoSHIu1qICdqNLbTOKOgQR0zUx1Ogpr0KGDbzUcVfJ
         EYIVOeZ8lHdkyUTHQxpTsGpZ2mPvj+yy7/3Gu997uqa8ldEh9RTYYVENXbGRE5QCp1I7
         ORZJ6HFt+y25fA6zgqgOdSYyXONZtknKESJbKmu8KSrt67rSroN6JMDhJai3U2T20Cl0
         ccEIgKs4CmH39yKoDLerpx2Xm0UPvqFjhxLMp+OPS3g/wGg/UBwU/p2dB+vQM3rNFGYD
         FKGcG/rZ33KxTayxtPLjkb8ZJi7HhN7ixknMcWBo96OQoZajjjdIxpEYmi9JxwwHaAKX
         DAZQ==
X-Forwarded-Encrypted: i=1; AKwUvBw51O/YQXsE/1qQH7ICsXNrBiyb+q5Hkl5sNA3jB5YpO0WBOuZwjvt3xSXXwv7dWHRJf0YEqw==@lists.linux.dev
X-Gm-Message-State: AFuF++kB+kx8YAUUa90QkSQbWN8TRdFmC8cnfQDnHGSgHQBZ5zA97aDo
	P6RI830JDVgAiEJSzQeDzwXVms2GuMODdgf0Czkz3G/mueebycz7VTlQlsAH3lmCNLyGURizzdw
	zhpAouewHyqivjrNRogi8RiVrsz2qXpm0f9F8JV52fySvjD4CvFYf70KIRA==
X-Gm-Gg: AYBFou1myDIODsNreY1a3FSpyw/sZjckNKjHKVekIiGkgTuv3+9+gOmIitAVYjk/c0G
	D+t6nRQqS7uL4orBmUmjSM8HEZnmBA3Nj14btcctbiGhpmbw2OhH35LMZdn0POkcmFwZKC0qVNs
	rHPV2u1GQuElFCAbnBIYDAAB4XCEhJB3eWXojlDoau0CS6C6hUBU64uBx4zdNyLQBrp3tGN5p/b
	CzmvFRoBicHzKPMEejeWnWU5yCSaY/cHSFpFGVmzR8hJECGUf9QDznmBbP2SJcwJQtWVJ5p5rKB
	tCbbu/aBqVVyqJR3NTKgzlEAs91HzM3OkI2S9mH9fi8i++6kDZ9FGoijFVAcHVMWJlRf2HA9B6T
	AhDcxQ5mRUn47QF8MntTYigbaCVSx4GMMHlaixerT/VKx8OJTG1jKbbHiOLctA6IkOkfLAZ8r2Y
	gE8Q+MxS/qdu5u
X-Received: by 2002:a05:6122:54d:b0:5c9:c60e:3a47 with SMTP id 71dfb90a1353d-5c9c60e3d80mr5853043e0c.19.1790082142450;
        Tue, 22 Sep 2026 06:02:22 -0700 (PDT)
X-Received: by 2002:a05:6122:54d:b0:5c9:c60e:3a47 with SMTP id 71dfb90a1353d-5c9c60e3d80mr5852752e0c.19.1790082138994;
        Tue, 22 Sep 2026 06:02:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46d670fsm479365e87.40.2026.09.22.06.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:02:17 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:02:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/9] media: iris: Add power sequence for glymur
Message-ID: <f5ynb3fixzn2fy4f4cjvalw7n2jbbrejd63t4p4455gktwa6yx@erkmcd6x7vu6>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
 <20260917-glymur-v11-4-e0c8bc914742@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-glymur-v11-4-e0c8bc914742@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4OSBTYWx0ZWRfXyRjS1GSTPo5q
 8Nwqp4bltynGIZm+zt4jUBuL6A1tWj6ktEHdCF7QbXpAxofgpXhz1uJd2cRj7bz2mANGYfBPWI4
 pWIINGdNbkC6kzMEhc/f/s0kDayPvoIl1/C9TmT2uOKoaZlLIzhpBC96XYvAq8Met6ZWDc4QqG8
 wtYIecCtIEAoY0Ili3G18qYcM5Nbqg4dkXWhptOWDFs+c0yEsDhA27YQoRI+R1MVm/iLxwmWYVb
 6vJ8TQ7lJxOLWjU9HXgpEPIj0RBozCK0IuDVS8+kjkl46Pk+IX10AuQsMtwEmoNnmmfkJmJuqSS
 tjTQ3C9bL128MOZaxl5PBPpGfPNO+ZF+thsVqGnOCKviINL0IHocJyZuVmeKyeQs6sMg+L7DtjJ
 tqO2ED5Z4HfYoiKhY/m3WLL/zbOTAObduUYXiESkMENFe/KWmykOj6oOh5BF7jeBxL4ByHNVopX
 d76ErajeK75IwVkf0Xw==
X-Proofpoint-GUID: N3KxIs35tlp2W_ErIZl8hwTa1578iwnl
X-Proofpoint-ORIG-GUID: N3KxIs35tlp2W_ErIZl8hwTa1578iwnl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4OSBTYWx0ZWRfX+TbQ4AZnkbq1
 cGxvKilTrrmtRSwQ0vUc92ayOI0tXkddVDIIyv8rtJ4wmKPrwsW5RoJWPr9bbGu2rOEhOtPneGD
 28jpHdrhviPnmUH2ViHtwdoB1LnShf0=
X-Authority-Analysis: v=2.4 cv=XrVvqlF9 c=1 sm=1 tr=0 ts=6ab27c5f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=7ng__jp-IBtt9HV_xosA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220189

On Thu, Sep 17, 2026 at 10:30:23AM +0530, Vishnu Reddy wrote:
> Glymur platform has two video codec cores: vcodec0 and vcodec1.
> Both cores share a common clock source (video_cc_mvs0_clk_src) and the
> same power rails. The clock dividers between the source and the branch
> clocks are fixed. So when both cores are running, the source clock always
> runs at the highest frequency requested by either core.
> Since both cores share the same power rails, the power corner cannot be
> voted independently. Scaling one core's power corner up or down would
> directly affect the other, leading to under or over-voting.
> For these reasons, both cores should voted the clock and power rail must
> be based on the workload of both cores.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 127 ++++++++++++++++++++-
>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>  .../platform/qcom/iris/iris_vpu_register_defines.h |  12 ++
>  3 files changed, 135 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
