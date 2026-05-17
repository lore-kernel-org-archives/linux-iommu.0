Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606253CBE7C
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041560; cv=none; b=g+goYs7rPNrBGO/u1l5OAGVgG4BTPhSt3ZLLVtr/ow0bzKTqVkrFMWJ9ncDM/gF0a4feskxxjM20PDu04HtG+UGkZGlAO3FHdt/npQbi5iQ+jCB0+kBfifDhnzVv53taOmnLWgzwBFDaOWoddKIO9PBIAyQjBwgCzPP7T8+BwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041560; c=relaxed/simple;
	bh=Xp5Ixk/UrdXHcKamwm4bzOPo9EV535L7yyFC9Vwqp6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyQFnx5GE73rdm+xuu0Qihfz4aUkQ8PDYJARPqvGPyCBxNJkHBRhjaO3BtR9vK5W3n61J2WnEU65bb81pvDh7SlEoHMSxBaTYGXKvgh07axxUxB+eVvP0e04IoXmDkoMk71J4vDETlZNQuRz0RczThekZFNnrBInyWw7j6tG6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fibiNalo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VSV5bwO0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fibiNalo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VSV5bwO0"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HBxnTN3924741
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+84c86+BTqUsmbfvYyoIFFXp
	0JFmH796Nm7BJ6t7KWM=; b=fibiNaloGlav2yQbI8Vhd3ypyF1GgAmwx86qdW0K
	qIBRJOf8g2LIfiPWKdU5ZS5qnM6gMNL8dzGmExzJ6/375sHinzPSRMOyMYmO8CqS
	zYyNfmR6yqxw0RHLHwpb5EEl6SKoLDSejHOr5PSw1YlJitxFkFx8I1IREh9rteDQ
	7LxDqechJkaxr0nEWcVOLMlUjKOr2txvuvjY7ofy8gsB2WPgrV5sRmnTvrWwDzKV
	6lOjRxfsyZ+sTLvrIx70KYzhQIHNvLEjceVID+0TyPZafkX2udbxwR4wOYXMQy98
	Dz8PrySb/9VP31hb/7maAK+O2BXzY62ssWqiJrvw79w93Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gy53cg4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:12:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fb6d713ddso20047831cf.1
        for <iommu@lists.linux.dev>; Sun, 17 May 2026 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779041558; x=1779646358; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+84c86+BTqUsmbfvYyoIFFXp0JFmH796Nm7BJ6t7KWM=;
        b=VSV5bwO0ImtQEXOqGDeC9Ff+x7GEJKT2H9CMxcXoLcwOxxieczfaqDd6BOAJQ6yP1n
         2ahyCvUIlaVdOXx/a99BE1NAClAL3nMI2NjURSBMhm7rUf6gAeysjrkrIzEgifAjSEfu
         dIPPSmZgKwCOfrr+Rcta+qFnX4YbNaUvykyGkGeCBAJM1AdV/CqkhvDgw8kupw6ZaGC7
         Q6bzomhzsxLPeAncy/QA18GB5iUNpC3h6OY2jWz9WPjh3on1p7DJpV+xBbwBhd66jh3s
         6cKZxRmBhZWmO4iNYMnBa1m0H+qcpf553tGZTV7dOUCyM604g2dN1QnXp5EpNcjoHnJM
         qYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041558; x=1779646358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+84c86+BTqUsmbfvYyoIFFXp0JFmH796Nm7BJ6t7KWM=;
        b=DMc5ICx8fmbLtcJbEFYYFvuiW/fkNakx/TTMkn4mKTPB8MAvX5GJMwd9TCJUqXQYm+
         37z75r5gmOaRupb+3W+dgeg5h7XQAhkVK2tf7QRoPBA47HEqfUidrLvdvRC2ILONLbiP
         fFElFNN6mJHb2OUtG+mlT2NWdzVkEqfWXbIlyoPHidbZPPTO07v/Jmo+PXsmsNbNXfD7
         PM0UkMsCzh8wmMSdXdH54Hyd4H42XHvld69heeIJQNEOqfustb6JhxMeVhc3fp8GqYsi
         1+iX9miCyQmASN/fsirgZHM/dYRojItHFQIqiLE8PejJvcTZVzzWLuThNGoN7wYQQmN5
         Bl6w==
X-Forwarded-Encrypted: i=1; AFNElJ++AofcywVkiJ0FzP1XHcTxF5TMUCIi64WU7HrdM6tNFsH3q5nguwFdT/4O5z57CXnUXF2lMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFXd3X9tTivk9wZ2woyL7Df1VlPLcuxhbYOUvgsvCyg+Jc+JwV
	C+QvAJIh4DTWEZBvkGQRxLqqSR+8ScEo88Zq6ZaJJMxcNK4xUFs/yw8UEXz88DdE+klR7Ep004j
	2KsWSyRyeJGbqDsqKvllkfq2fvph7ONgg/rrKLc4TEU/Gg3+zOCWKb52hJA==
X-Gm-Gg: Acq92OHFWvNPAOFKvhE+MJybDBD8RHAtdzUSxRIldw8IMOTju7aUkNC7kPFWjOgIFpw
	yOpe6Y6Fx66pWGJqPXWeQHAl4+roWrOjmq9fCXFGa54jmsWlt1r/r2ToqI5qdIrGH+8ECuFVehD
	Yhp/LWZFkxUbuwJQCsZ/icpa3KESOyWRivQoUYmen7b8UazrJq2/peqOBJKehZkC05fdZxM3i3J
	clm7oJXvK5fawbhceVILOnJopLb+XPp/K5ezfx/qOnkyeFFObaQSL8mWZBhopxpuOup8e5ved5P
	J5tHAbsyV//9ojBDCe2B3IDStGcPsyD396XoWoMHyI3xIRlz8Za8EAQpixb50tXWnK6x1jwbDXs
	wUtFtYwGheAfBBVa5DvotGJoorLBGUwMpawGc+7WPG9IW1u6pXcPFrcoOXIRgP07VIaZqc59Mrc
	2B9+F7X3JgXwYZAitG2/Of063o2ypvJTm91pY=
X-Received: by 2002:ac8:7dc2:0:b0:50b:3831:417f with SMTP id d75a77b69052e-5165a2c8c00mr167619311cf.45.1779041557763;
        Sun, 17 May 2026 11:12:37 -0700 (PDT)
X-Received: by 2002:ac8:7dc2:0:b0:50b:3831:417f with SMTP id d75a77b69052e-5165a2c8c00mr167618911cf.45.1779041557200;
        Sun, 17 May 2026 11:12:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c0c67sm6568821fa.10.2026.05.17.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:12:36 -0700 (PDT)
Date: Sun, 17 May 2026 21:12:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 14/14] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
Message-ID: <pockc2vpoobmhk6pwy5wluekbdgon5ndtltbs7lmq2s2hxwhxs@qp6bhwl5de7w>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-14-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-glymur-v6-14-f6a99cb43a24@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Wusb99fv c=1 sm=1 tr=0 ts=6a0a0516 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=1OBNivUE3TbfJcvUgGMA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: R8TF7uWReoheD_DdCEnl6rlYwpvR-uij
X-Proofpoint-ORIG-GUID: R8TF7uWReoheD_DdCEnl6rlYwpvR-uij
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5NyBTYWx0ZWRfX0Lr/PCVXDbyY
 7pllhg53G5tNjyMK7F1y8JBprVe2nB6lIZGoYQqcDV9E/0eSnNpskFec35HsQJvvAKnI3b8b/no
 ouOPrF5ZuyegVy3nP4jTFCNk3GlWKrGNxGIfeU0d/Rxnp1ONIslcfnfSqtSHMCqQ9vxiF4aKzE8
 KJf+WGGTVqkRdW5FQ7ip1+97LUpJ+UmzMIPUCWIsT11fULOXSwc5udvpA1TciTva2Dmxum9S0cj
 /WaE5chkTvWtrFIMr2CTYYVxhsHQQJq8F+LvN07JYamxaMGON/hVgID4oPRVWEI4xskEcAXNmbQ
 /E77+MFQC3sS0MklG2jdRGyyi9X1WNdTHX2vjOa5LmQQnFWWVITyAlAmHjVDOgSuZsJbyED5Ui7
 o0OkpykW0aEg2RGrmdUuyVsqdZ/wVEBamEOBZwGb2s9aWHRr4DFh3XQYtkxpHG1E65N9AtNPuwm
 zSQzsrONWHoVhfvSyeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170197

On Fri, May 15, 2026 at 04:51:29PM +0530, Vishnu Reddy wrote:
> The iris hardware block is described in the glymur SoC DTSI, and enabling
> it here allows the media iris driver to probe and use the video codec
> functionality.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> index 35aaf09e4e2b..8d6ea857634b 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> @@ -198,6 +198,10 @@ ptn3222_1: redriver@47 {
>  	};
>  };
>  
> +&iris {
> +	status = "okay";

Could you please make life of distributions easier and include
firmware-name here?

> +};
> +
>  &mdss {
>  	status = "okay";
>  };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
