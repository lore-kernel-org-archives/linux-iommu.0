Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA23C73E5
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040133; cv=none; b=ewLNDEI3swTjNGuUlf1nz7/RFb76Xf3Hjn4zTzofYoWZBQvJNNunEMnPd5SI+eDySbfRasgIzUtNnqPABUgCrvMaZlqtdnB9Tj9oqxHTWH9U3BtaHjTkFqgnjypOrzhIIaRSHJAIvqSzlc97+dN0qE2MgyV3J+EP9lNqgM587ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040133; c=relaxed/simple;
	bh=LH31HdscTScQYadkTVUyNbrfZEMAWXcUK9ZjS2AH6/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqjWt/A1drFjA7GsW52YA/53ya4ftVIwQLDBVHjyli93lFxykGin5Brkm/gWOwvCAkofE65pRGXltxRe/BtiN86e7bRcVIv6/cIbodxYVYYjYEwv3UAEpKvWjeIrT2x6CDxXux6dYsV4wm27hb4TuvbofRJdYkqClmQTF0YqbIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAx3RNV9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C4P4X3t0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAx3RNV9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C4P4X3t0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HATlXZ327129
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lpHY7oihfb3amRFxiPEd1m3a
	03YdGFnYGYRDDtzyi7M=; b=ZAx3RNV97QNDaeDPBm0eQJO93jOxwpMPGzb/TJah
	dqsXoFDz51gjgpaSU8N7Qzp+AUA2My/19D6jWfO4UdtlZMVXDiUakPU1Ou3UfRaz
	ezSxF5WpCIwrtk0hinjywm2KTy9ROpY892QaKlyHKuaSAPGfH2J36oRJZA5cC9GC
	l0MsRguIRvO7luEi7zN1PiUnz7iddvoYHEr18Nn/7+tkGp3xaLi1kBJPfVqVfX1I
	tnwFwth+FR6U4sMg7cpfckuxWhhE0ko3IlG6rAfQo0QcygceqSX/l51jCphWDY6X
	vMlkZWddo7/fLJ/oFbO23EFnxIIiULneRW5J2nvgs+UpAA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvyuapm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:48:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-90fb1490e2cso404429785a.2
        for <iommu@lists.linux.dev>; Sun, 17 May 2026 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779040127; x=1779644927; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpHY7oihfb3amRFxiPEd1m3a03YdGFnYGYRDDtzyi7M=;
        b=C4P4X3t0I74Tu+vfDno2A7I+V0ljexq4t//wZw3erVyUdnqvzjyVJZG6TZgLMxVpnv
         i4ar0qFGq9ahJERUkNZwdkO0UBx51pv149AlbofvG7kTggrlK3OVVJ8Aoqpku6xCv7bC
         G9NB6tcs8GvOZiI0kEkN3U3lSYLdJiJfYumRJoAi9dort9dhwZAY+wvtZjxWJcm0iK3D
         ea+hM6fburXiCedxTAF6w883UtLx6R/U8/ujMnbQFRbLRFod5+kqSSbQM5QGh/JU6NR1
         8APFIY/UIDin9mKGI2wbiTJcfjePH43gl4+AADT5B0Vwy8vDYYc0x6pP5si8wVG4e6RD
         QcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779040127; x=1779644927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpHY7oihfb3amRFxiPEd1m3a03YdGFnYGYRDDtzyi7M=;
        b=R3kEFnl8C0Yg7hO0htzVGpXXhvjvoQjyT4GhQgroxzi6yuTZ1ohA6yc1dk8C4yAv9O
         HWo89d/cl3P0Z2/SHNXz10ZT/aQhBSpx45pcCrvKnkTx2PALSfy1fX9/lh/X5Gb973Ei
         T6w0pTLBNZy60tqRui5AO23XlbWiv/ly3lpcN/W4faomXjzvejbYIFYCE+gF5N9aiqeX
         qnJePgmxMl6cyRgwZ/tA8IQn/vf1M074cl2UmfUnMCFwsRD4A1q1KZT0tlvwAA21h+Ym
         Yjrl2uJ7HjlcfD6oRSAPT87DFH/A7F8n3xQLsrkqi/1S73Q2IFIVEKbAuxPZLtIn3RDD
         5Uqg==
X-Forwarded-Encrypted: i=1; AFNElJ8vGuw2BZouLAwojXTWyYZmP4F5iLgB3SbcUaL5JRFSJ53b7Rar/GAKEtidG2ilphLzfErrRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGCgeO2FAANUXYt7G1sP1ozQepKgr9Jn+edhKoazUItYd+Dcw2
	g4LwLXd1NnZziU0KQR2wU+HerSBQW7EBFlH74kGVGykLDyGEc7hHN0y4Ns7Aun+PvFz3iqdao11
	61CGs6ZY0tWFFwix30k5WNAWUZyooWC5prDIbDSV7jGWUTSP/jsD/MTAh3A==
X-Gm-Gg: Acq92OFyYVB1RdeJrvAaG4fonOgeaAJT/Ltp5azu7UmYvb56E7rnwEOpgPlryo7Miww
	v9YkKe93HrhZcBa5bwtvmTfcBT0jZ58sYJ6NSHOZPDmYfjGp+FPo1POIHrumZGcXzekiqlOmcpg
	8E18Iy3wXiNhjfpNaYtm69PV0ru0zuM2bzzBqUZ4fNJ/3UAykuKu313OKgbIlDtfJnRpVNw5Daa
	A9ZMIJqZ1Yde7es9uoM8fnC8Wz9zt6sFVJqROqumUerSxQ54U3Z0AX+nPmBwAO/pfWt9J2Jw0TL
	GUvfnTv8H+wQJZV9BcxH7Tk1gA3f2OiYE2JbHvVyuu12xEI/YfdeGHVnqjIhj/b4civEDaEao56
	OFj0DwbU9MlOowvSU4tDVmkN2jsPkL3Qks1xhout46d9IV9xtC45zU8y/0wqsxBYUcF3rwS8hyT
	dA+yv4oFQrIRSMBPUMPNHMBRbTYS7bzDiJAfw=
X-Received: by 2002:a05:620a:2685:b0:908:e262:52c3 with SMTP id af79cd13be357-911cef034cdmr1880919885a.46.1779040127356;
        Sun, 17 May 2026 10:48:47 -0700 (PDT)
X-Received: by 2002:a05:620a:2685:b0:908:e262:52c3 with SMTP id af79cd13be357-911cef034cdmr1880915585a.46.1779040126788;
        Sun, 17 May 2026 10:48:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c797sm2804811e87.8.2026.05.17.10.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:48:45 -0700 (PDT)
Date: Sun, 17 May 2026 20:48:43 +0300
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
Subject: Re: [PATCH v6 09/14] media: iris: Use power domain type to look up
 pd_devs index
Message-ID: <bh6g3vne2cnknvpeus3fmwjgyqk4ngstdn5fkvju72rd23lqey@ip2gt4hoqqmd>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-9-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-glymur-v6-9-f6a99cb43a24@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5MiBTYWx0ZWRfX1jphYtkTvygD
 nJ9Yym87f5vdeynjbov+P4dqLlykKJpk+FAcOvgiMJoLEbuO3bM0HkxqG3/Glqh5vO6ya4A4zzk
 yy7Z2E7rF6FU0AdmbTCGGjhhVZxkWLU7zbaGSP/LM5Tn9VGc5VpD41x5+WrDI+Ry84MFo5W8Kb0
 L2demvrzh1gAUh/X9ylRfL3ODTvLC/tibVoWyzs1BpUevupK42lhQDHfoJUZfEBzpXEUkppwghO
 L2AzvtZN8a/tico8yxiKsg/goQYPnRlNE658LpWJ1NB1BSfXaEYpj1YxR+kpG2da95kR+1YtJOk
 dL0oCMPipOVWADgV+CQYyQU3B4OYRHyLiHn+/0H6ybioM9EVmQ6qmKcKbYTkS15epNqIozk+OJ5
 rRso/cHjN6hlirZ/4jvtSfpX3d8bxxA6vr+CDAIMmZK4fG6qw9NNHYaWhcLXmIXNfogGlIeyD/d
 /mWPD3t83pM20SWoZjA==
X-Proofpoint-ORIG-GUID: BBlnxvQW7QZuxJTNiqU5gTr6bzustwUq
X-Proofpoint-GUID: BBlnxvQW7QZuxJTNiqU5gTr6bzustwUq
X-Authority-Analysis: v=2.4 cv=X5Ni7mTe c=1 sm=1 tr=0 ts=6a09ff80 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=wVukXIzjBZceI6JPWPsA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170192

On Fri, May 15, 2026 at 04:51:24PM +0530, Vishnu Reddy wrote:
> The pmdomain_tbl was a array of strings holding only the power domain
> names. Callers had to pass a pd_devs[] pointer indexed directly by the
> platform_pm_domain_type enum value to iris_enable_power_domains() and
> iris_disable_power_domains().
> 
> A future platform may need to introduce a new enum value that aliases
> an existing one (e.g. IRIS_VCODEC1_POWER_DOMAIN aliasing the
> IRIS_VPP0_HW_POWER_DOMAIN on Glymur), which would break the assumption
> that enum values map 1:1 to pd_devs[] indices.
> 
> To fix this, replace the string array with a new struct platform_pd_data
> that pairs each power domain name with its platform_pm_domain_type. Add
> a helper iris_get_pd_index_by_type() that walks this table and returns
> the correct pd_devs[] index for a given type.
> 
> Update iris_enable_power_domains() and iris_disable_power_domains()
> to accept a platform_pm_domain_type instead of a struct device pointer.
> They now call the helper internally to resolve the index, removing the
> need for callers to do the index lookup themselves.
> 
> This prepares the driver for adding new platforms where power domain enum
> values cannot be used directly as pd_devs[] indices.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../platform/qcom/iris/iris_platform_common.h      |  9 +++-
>  .../media/platform/qcom/iris/iris_platform_vpu2.c  | 18 +++++---
>  .../media/platform/qcom/iris/iris_platform_vpu3x.c | 24 ++++++----
>  drivers/media/platform/qcom/iris/iris_probe.c      |  4 +-
>  drivers/media/platform/qcom/iris/iris_resources.c  | 43 +++++++++++++++++-
>  drivers/media/platform/qcom/iris/iris_resources.h  |  6 ++-
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      |  7 ++-
>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 52 ++++++++--------------
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 23 +++++-----
>  9 files changed, 115 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 07cc0ce25b84..1d757cb8e9e1 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -70,6 +70,12 @@ struct platform_clk_data {
>  	const char *clk_name;
>  };
>  
> +struct platform_pd_data {
> +	enum platform_pm_domain_type *pd_types;
> +	const char * const *pd_names;
> +	u32 pd_count;
> +};
> +
>  struct tz_cp_config {
>  	u32 cp_start;
>  	u32 cp_size;
> @@ -270,8 +276,7 @@ struct iris_platform_data {
>  	unsigned int icc_tbl_size;
>  	const struct bw_info *bw_tbl_dec;
>  	unsigned int bw_tbl_dec_size;
> -	const char * const *pmdomain_tbl;
> -	unsigned int pmdomain_tbl_size;
> +	const struct platform_pd_data *pmdomain_tbl;
>  	const char * const *opp_pd_tbl;
>  	unsigned int opp_pd_tbl_size;
>  	const struct platform_clk_data *clk_tbl;
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_vpu2.c b/drivers/media/platform/qcom/iris/iris_platform_vpu2.c
> index 41986af8313b..bcf873829fd3 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_vpu2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_vpu2.c
> @@ -62,7 +62,17 @@ static const struct icc_info iris_icc_info_vpu2[] = {
>  
>  static const char * const iris_clk_reset_table_vpu2[] = { "bus", "core" };
>  
> -static const char * const iris_pmdomain_table_vpu2[] = { "venus", "vcodec0" };
> +static const struct platform_pd_data iris_pmdomain_table_vpu2 = {
> +	.pd_types = (enum platform_pm_domain_type []) {
> +		IRIS_CTRL_POWER_DOMAIN,
> +		IRIS_VCODEC_POWER_DOMAIN,
> +	},
> +	.pd_names = (const char *[]) {
> +		"venus",
> +		"vcodec0",
> +	},
> +	.pd_count = 2,
> +};

I still don't think it is a good idea. You are using these lookup and
indirection to make _platform_ code take care about _platform_
specifics by the price of complicating the core and the core structures.

Instead it looks like it's time to push power domain handling to
platform code and then hopefully drop all IRIS_foo_POWER_DOMAIN enums.

I'm pretty sure that the clocks would also need to follow that approach.
There should be no need to bother the core code to introduce the
platform-specific clock type. It all needs to be handled in the
platform callback and platform-specific data structures.

>  
>  static const struct tz_cp_config tz_cp_config_vpu2[] = {
>  	{
> 

-- 
With best wishes
Dmitry
