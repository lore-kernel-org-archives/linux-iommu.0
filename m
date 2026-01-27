Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6BB345CA1
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769514337; cv=none; b=VhRg1QfGjullFu+Gd6MsT0liIqFuPXCdlLbygwq+m8aKkLc6IaNYm68wK9GSpuoX4HgNyGPDrzhYIGo/IS6PR3pt1kWH2CtyzMGE1mYe0EFoVY4EwJBnFTxGOIP3HTCjmzw+8gIX6Wzxb9gqlnVcikQzL9OAxO4vcPl/sPlhqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769514337; c=relaxed/simple;
	bh=vC5aMIheQI/i5LOb8ieNJ8xBdQ2Nd6mfRPdPEfitCBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1K4UX68wJ5pTy5kAgg77cUQFlDY/YKwtDvy4Egu2pZO6Uufo+B0bDrL2jB3yTBveJzYVqalhAaFBezacz3/n58iqGMT+7CSEcvK5epDHULfDMiB84IO2vxQjnz317zIobdjnBzh+2Jorm6MDXclhGvizfyKx++LYTwXfo/v2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KQP1Q1sT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LZiNWsSX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQP1Q1sT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZiNWsSX"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAKbZw700199
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 11:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jYN++O5MHPni7REvt15Xxqk3
	I7fUUxuK7gifc+cEAcM=; b=KQP1Q1sT3GHkqJK8U5+VNCDjkwh1x/829RDJTiAi
	7lXjJjnkl5iKBx/Rvm5lXfjr7KkJV+Mt4dJY4za+jE4K17/u6sr9hqiTLb1Yn47F
	5WdNvpKiYG7582PCf6qcm3Xe2bPEHtV6tIj62H69/EHTkxtRtp5wdvZmFAGw4aIi
	lu6XvYS2mFxrJ+nLV2pyu/slymXqSojJPtIhVFNVj0PI6Lv5oAoNb4t5WPrh6Y8W
	iAYTWLj7NHf5vUs7L833Ohz4dAtM6bUhlfV0iBGQGf3co6tbBUSt+vcAw3+43G56
	KTh66S32T6L0rN4RZGGLc9wWMHoDXHAxGXzcVWtKJ6/9tA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxew3tmsm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 11:45:35 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-93f59bf206dso7312548241.0
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769514331; x=1770119131; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jYN++O5MHPni7REvt15Xxqk3I7fUUxuK7gifc+cEAcM=;
        b=LZiNWsSXxh/mkCKDzrULzUKGsKn6lIWO0eU5qRU/V5ogHefiXYMYo6OJaDh3rzYbpv
         xUmQ390fKxIlm+KJt+5nVJLcTsz55ykBX5iF+VdrTXOXLV8MypP0GFQ3t2WmfvOi76Ms
         HWZpI5z2ijqIWmOGm3Tve9cU/mzGjnhL3I04aJLLt6ei9TPVrN4vnT2Pq880HG1KISGG
         yqpAJVOwPZ+k8UjsO8j4Yqm2LPo0DWrJQqXT4Y3UkRTHVi3FaALHAZv1KAQlYuA90q+w
         ZBvT5E04JH1g/nrj4PLwgV2rZXrVDBhmFf24qNjclyXpHMkbNWxW2UnYifEseUajCMbl
         LhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769514331; x=1770119131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYN++O5MHPni7REvt15Xxqk3I7fUUxuK7gifc+cEAcM=;
        b=JSy94J8tKPLLzNBptW+to2YcAqr+tNYH2spgz/Nty/+wEpOASfqGMZHrE7Whvw4PN3
         DGDoahPfVYBH0WxzrSuqaGnbnOZWpH1Qr8A0O97BuSchJ2MMcahndHa2mPUa8aXN33ft
         ooYhRgqQYqlPvLYJe2RKfTPTrf6+mjPFIywCq4rder33q1PAT+TgqFE9IZRgknmIMABc
         dp3QpT2IGXJnCaZqnqyMhaTXV3HszQsZSAxZ3kQvFbc0WO/BbSX9MiE6yGzi2GFWuAA2
         ELw7r1lvIMH/0JJ1VO65kc5lXIDa53h24K+2f5J3gH8M7P+nhkHbZ5aawJCjAO8U7uAu
         Xw1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaEk60xyKsTvQrGjmeO8ffKbaE5UHOSjBi3NDrSg28W45u4pA77vRjUxB+8p3m3Re+6QpXVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzxfvg6zuvlUE+rO4eyl0FDwG0TyhRFU8HvJm8umqL17+5Vamee
	c6kGT5oT6eYKnw0mKqPtRDSk8QN/m9nDJk7KI8jp9fpPthYml5xWT7BOV/jj/OynSYcPiJSp3Uy
	PVXQqr3W/1t/R4GzmAgQDVqC0URNYbwAuahWxcA0F0LjDEdLrmL8JZZP4GQ==
X-Gm-Gg: AZuq6aLBoTMQpRzUyl4oI4xkxp2NpklTEAFWpylsG1sSPgFyRa8+gGPPekjt85nOBWE
	AkngdHkzUGtdxzrbmmz7GCaQKN9Hmpo1EXNvo0F5q4UzIZEjX+BO4gHu14iDRsGHgTfJW1ExgNy
	Xy1J78EX6B5zoFCI4/xUHO/GlQO/AXgHMHXKBwYX9DBVfsHJYE0CC0UoafHz1iHDc51UpVuF0eI
	PwqC73XyNTo0SXvaw7R/R/JPRyW+VBCwvPzpAy0SVxMO9D6H/wikZkOLd6BaG61hOb0QKxXP64n
	B2pYT4zwj80TRBSaQwOkHjXtyVdD1pQuQLhH82vQfJ9vgMEr1WgXTUpBkjT0q2fG+/bYCOoDL2L
	pIehqAJ4wXYGcvf9Oa1BaaKYe0t3sDeFNugMn9a8+o+ixCPaurG9yAJ/YpNoNuPapwRu2HXV4Zm
	8+ErlA5chuQDJcu4VdjRsFblI=
X-Received: by 2002:a05:6102:4405:b0:5dd:b5a2:b590 with SMTP id ada2fe7eead31-5f72366e745mr585657137.16.1769514331042;
        Tue, 27 Jan 2026 03:45:31 -0800 (PST)
X-Received: by 2002:a05:6102:4405:b0:5dd:b5a2:b590 with SMTP id ada2fe7eead31-5f72366e745mr585642137.16.1769514330447;
        Tue, 27 Jan 2026 03:45:30 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48df7f6sm3450910e87.10.2026.01.27.03.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 03:45:29 -0800 (PST)
Date: Tue, 27 Jan 2026 13:45:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH 3/7] of/iommu: add multi-map support
Message-ID: <hunwsdkmeo6efpv3yt3izkgmarelnubd74dywj3scryxrreq6p@njijwtoyjh46>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-3-e2646246bfc1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-kaanapali-iris-v1-3-e2646246bfc1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 35X6caIpsWwBO9IJ1YKTHUoTsxoI0h1b
X-Proofpoint-GUID: 35X6caIpsWwBO9IJ1YKTHUoTsxoI0h1b
X-Authority-Analysis: v=2.4 cv=J8CnLQnS c=1 sm=1 tr=0 ts=6978a55f cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5JH2DIL-x3vr5n02JuwA:9
 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5NiBTYWx0ZWRfX2oIu2ooMN27V
 Z8SNflj4CTBPYrs8lw0s7b8w9lMSYKsNQ8cXbf2gGcFw+ifRh0uoRRuUVW6zMTwTU3/7mI2qqWt
 2m1vsv4lcRAOaEmYC/Q0VHVyaIB85VuoI4yUPHACoxWDXdB1HjU6sJmokhOeylo4KuRev3BGx3j
 h/mJc/gY2cAYWrTzeh7//AGmkgbpwDm16M09YEf1jAcqBpajjTwZzxO6Oid4KdqUuRyvVb9Rz4n
 6ZwUV5XF+wXpmFUWJmX068GKEStG5Syj8ttPa6SIXAt9sYcmVJXOssv6tSSqNE7eZJiueyp9VK8
 l6DsefyhsLUl/M9SQBjke0rtLZfRLG06Aj8prNjIrVV9pMGd2qs0vXNpSmYrx3cmwggleExnTb9
 gqYTsng6teYDiib27tvDvhSCypc4AGbRQcJ/y7kOUyJgQ96GRqMbqx4DGZ5oh8BMO9GhRuV1Pk+
 bBvIl4ZEs+f4ocTC4Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270096

On Mon, Jan 26, 2026 at 05:55:46PM +0530, Vikash Garodia wrote:
> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> 
> When multiple mappings are present for an input id, linux matches just
> the first one. There is a usecase[1] where all the mappings are to be
> maintained in parallel for an iommu-map entry of a same input id.

This contradicts the IOMMU idealogy (at least as far as I understood it
fom the maintainers): the device (driver) doesn't control which IOMMUs
are getting used. Instead _all_ defined entries should get used. For
iommu-map it means that if the map defines several entries for a single
function, then all entries should always get mapped.

> 
> Whether multi-map is needed is reported by the callers through the
> callback function passed, which is called for every input id match.
> 
> Since the requirement in the usecase[1] is for platform devices, not
> sure if it is really clean to maintain this decision on the bus type at
> the of_iommu layer or further to be from the respective
> iommu_driver->impl_ops().

This doesn't tell us, why do you want to control, which entries of the
map get used.

> 
> [1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
> 
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/of_iommu.c | 36 ++++++++++++++++++++++++++++--------
>  drivers/of/base.c        | 38 ++++++++++++++++++++++++++++----------
>  include/linux/of.h       |  6 ++++++
>  3 files changed, 62 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 768eaddf927b0700b2497b08ea21611b1a1b5688..067bb2298973671e1eaf01bb2ea52df3d2a52a44 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -16,6 +16,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/fsl/mc.h>
> +#include <linux/platform_device.h>
>  
>  #include "iommu-priv.h"
>  
> @@ -41,22 +42,41 @@ static int of_iommu_xlate(struct device *dev,
>  	return ret;
>  }
>  
> +/*
> + * Callback to be called from of_map_id(), that tells if
> + * all the mappings for an input id to be maintained in
> + * parallel. Should this decission be from further layers,
> + * iommu_driver->impl_ops?
> + */
> +static int of_iommu_configure_cb(struct of_map_id_arg *arg)
> +{
> +	struct of_phandle_args *iommu_spec = &arg->map_args;
> +	struct device *dev = arg->dev;
> +	int err;
> +
> +	err = of_iommu_xlate(dev, iommu_spec);
> +	of_node_put(iommu_spec->np);
> +
> +	/* !iommu_spec->np may be from the bypassed translations */
> +	if (!err)
> +		err = (!arg->multi_map || !iommu_spec->np) ? 0 : -EAGAIN;
> +
> +	return err;
> +}
> +
>  static int of_iommu_configure_dev_id(struct device_node *master_np,
>  				     struct device *dev,
>  				     const u32 *id)
>  {
>  	struct of_map_id_arg arg = {
>  		.map_args = {},
> +		.cb = of_iommu_configure_cb,
> +		.dev = dev,
> +		/* Should this be pushed to iommu_driver->impl_ops? */
> +		.multi_map = dev_is_platform(dev),
>  	};
> -	int err;
> -
> -	err = of_map_iommu_id(master_np, *id, &arg);
> -	if (err)
> -		return err;
>  
> -	err = of_iommu_xlate(dev, &arg.map_args);
> -	of_node_put(arg.map_args.np);
> -	return err;
> +	return of_map_iommu_id(master_np, *id, &arg);
>  }
>  
>  static int of_iommu_configure_dev(struct device_node *master_np,
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 606bef4f90e7d13bae4f7b0c45acd1755ad89826..a1c3c5954ec7e8eb3753c8fd782a1570f9eb9c17 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2122,14 +2122,21 @@ static bool of_check_bad_map(const __be32 *map, int len)
>  	return true;
>  }
>  
> -static int of_map_id_fill_output(struct of_map_id_arg *arg,
> -				 struct device_node *phandle_node, u32 id_or_offset,
> -				 const __be32 *out_base, u32 cells,
> -				 bool bypass)
> +/*
> + * Fill the id_out and target for the of_map_id() caller. Also
> + * call the callback passed to the of_map_id() as part of the arg
> + * that decides if to continue further search.
> + */
> +static int of_map_id_fill_arg(struct of_map_id_arg *arg,
> +			      struct device_node *phandle_node, u32 id_or_offset,
> +			      const __be32 *out_base, u32 cells,
> +			      bool bypass, bool *multi_id_map)
>  {
> +	int ret;
> +
>  	if (bypass) {
>  		arg->map_args.args[0] = id_or_offset;
> -		return 0;
> +		goto output;
>  	}
>  
>  	if (arg->map_args.np)
> @@ -2145,7 +2152,14 @@ static int of_map_id_fill_output(struct of_map_id_arg *arg,
>  
>  	arg->map_args.args_count = cells;
>  
> -	return 0;
> +output:
> +	/* pass the output for the callback, callers may further decide */
> +	ret =  arg->cb ? arg->cb(arg) : 0;
> +
> +	if (multi_id_map && ret == -EAGAIN)
> +		*multi_id_map = true;
> +
> +	return ret;
>  }
>  
>  /**
> @@ -2179,6 +2193,7 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>  	int map_bytes, map_len, offset = 0;
>  	bool bad_map = false;
>  	const __be32 *map = NULL;
> +	bool multi_id_map = false;
>  
>  	if (!np || !map_name || !arg)
>  		return -EINVAL;
> @@ -2264,23 +2279,26 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>  		if (masked_id < id_base || id_off >= id_len)
>  			continue;
>  
> -		ret = of_map_id_fill_output(arg, phandle_node, id_off, out_base, cells, false);
> +		ret = of_map_id_fill_arg(arg, phandle_node, id_off, out_base,
> +					 cells, false, &multi_id_map);
>  		if (ret == -EAGAIN)
>  			continue;
>  
>  		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
>  			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
>  			id_len, id, id_off + be32_to_cpup(out_base));
> -		return 0;
> +		return ret;
>  	}
>  
> +	if (multi_id_map)
> +		return 0;
> +
>  	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
>  		id, arg->map_args.np  ? arg->map_args.np : NULL);
>  
>  bypass_translation:
>  	/* Bypasses translation */
> -	return of_map_id_fill_output(arg, NULL, id, 0, 0, true);
> -
> +	return of_map_id_fill_arg(arg, NULL, id, 0, 0, true, NULL);
>  err_map_len:
>  	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
>  	return -EINVAL;
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 9efa6f93712c6024f05476f9fd39f3294f942ec1..abab73a76682351f5635c1127a6c899917525050 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -25,6 +25,9 @@
>  typedef u32 phandle;
>  typedef u32 ihandle;
>  
> +struct of_map_id_arg;
> +typedef int (*of_map_id_cb)(struct of_map_id_arg *arg);
> +
>  struct property {
>  	char	*name;
>  	int	length;
> @@ -76,6 +79,9 @@ struct of_phandle_args {
>  
>  struct of_map_id_arg {
>  	struct of_phandle_args map_args;
> +	of_map_id_cb cb;
> +	struct device *dev;
> +	bool multi_map;
>  };
>  
>  struct of_phandle_iterator {
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
