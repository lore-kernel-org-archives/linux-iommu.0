Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45F296BDB
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886434; cv=none; b=kBIH1SBIx9lsMsUS5YHxnhfeRuMrGJzggYdnE2Mydg5A3+qDwmqAt4WaoZB4F2aEwIfCvWnKn8K7CqlLXfSxeP8Npnk4ROKDUPSrcUQbaHb9Ii91feTXYawGq5ypUGu5LKHTkzLRS/vDfi6CUx0EIMkSEHMA1YzcEl/PbbLVWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886434; c=relaxed/simple;
	bh=Qih0QhTFQ3wj9ErAiKpynh4DfMe40Ro0OOLK8vFqRyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPQj3cBxduItmYC0ei2C4G6H1ZEVGcxO/rXhhkDKCeYCebJpuTgBnJpBEM4lfbti06ZhLXRHxCpG5eHGnePca+a709YG1xEU9F7azVjODZ4lIzHhszmgyWSjmbQGLe5qkudo0rTjUIo2Q+NOFjptKudGutOynFl4H5jtBFqn3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CIL0pWDy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GdX2GSdY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CIL0pWDy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GdX2GSdY"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NIG9Ld3732749
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u/ELNB5NNSNmVG1lAxOxXYaU
	P/G6z2rnLtuVVe2l8Dc=; b=CIL0pWDyAHnR5vXk18SDZA7lb6nyCoTjULcjQfez
	Fd8EZfTPq5EtM25/5Al218WuFiIs1Mds6C/q0/EfPi6fYF11Kjzwx6jCUAbIgDF3
	A1rfdspmIF8aTktTYjxCTIWXiOVT49AQe6OgVD/d7sqgV9sm429j8EW2IRKZz4jR
	fB5J9wnQcdSkjZaVqOSd5qSOwTco8FKnmcALeH23N4obi36U1A7KduH1zlGlZF0v
	fzA8y6OA1hpylxOWNBU4cB3CfpjfygvgTMTuSKgbyOZQlcaUIs+2f9R6JhJfZLxW
	zAHG0AR/GsaSlxM7FdpK2WFea2c5ABblEUPd36w12xuwXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn7ta45w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:40:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb390a0c4eso1905452885a.1
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 14:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771886431; x=1772491231; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/ELNB5NNSNmVG1lAxOxXYaUP/G6z2rnLtuVVe2l8Dc=;
        b=GdX2GSdYxiXgBJYS677Gvj9dyRiMmAqaYXHiDU7eUa+FCqxGW7PseGBRHcsVqp2AZO
         dxE/3j4+Cd5f9AcPAe9EXRtJUjSASuJ/WcLv74+d87jgm/H7uLnI/U73iFwYlWmDNckc
         MEDi4kZm3HGAGvfsGZczcKJiOgs3rsB1n48mfksS4S2flHb9Ccyxv5vlFfciUi2KpsRf
         DS21W5BJsYqlolR+OW38xYQypxs9c9yUQTgSz3fZndDOQEFyGm917Zwiw+R1/NAIu1aU
         TfHGXXFQKT5UF++E4FGlXFqVm5kt98l4LvIDcNoQ+amFQBCQdwCsxeq6tingCfH0xa7Y
         higg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886431; x=1772491231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/ELNB5NNSNmVG1lAxOxXYaUP/G6z2rnLtuVVe2l8Dc=;
        b=CPhWU1JQvOVANFCEkTau0DzRP4THaFL1rVJRNeq1+esFBI4W1cnz4P0aseLpZ8VWLd
         7F1+SSCyseK4ml3rZfgjKKdj6Evdz3cPZYxepohorhzvMg+K4GzlAouDRhxfFRlgOXdK
         ywGQK1vSqhbuoa6dK25nWlrXxOBsC9PDQBK2BgpLCOmEJyb5B54JiIp5hB+X2E9NSpOl
         1sQP+VK4tXiQDXHjL7qH9zWhdTFTwQVadXrNNWmVDDO25wh0Jvq9I8klVQsI9pH6TN+C
         wuNPz4IVy81ff4mBe7eXGLEz5lkzuW2rCq0w0lvjiDuT/iuS0DzSv9DbAC9KyqEuTMST
         wM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFJmnX7zPVUuUjLNdE8Itf2bcsjNI+BMLASQN5C1s3g2C+mFbm+SK68TE+qsBY3qQqN4M7DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLBrsrmunDBSPEQqvCMD7D0/lLOogixbSBSPG4b3bX1urpe/Ad
	BIUsV/6lxOOkH+FCrbHVu3INYyYuGULM9uk9xitcEa7CnvbmhBDESr+XZwAdXUiO4hKst7eXGXo
	8/AThaG+NVc9VCHPAtKElx9MD0MlnTS1/EkxuWOt7S3Y1IEaAk4VHguj/CQ==
X-Gm-Gg: AZuq6aJX20JF3INJSsOORm/IB47+WNEicycLkYrK5lUh87kAi3vzTb/IK8OaWzfoFte
	KYhIZV6eO4l9Jb0QGKTUa2RB1/ywkXjzKjl3N2sWezxbNmu0NkPAaGhcpIktsFhgp4MRMOTjFKr
	k3OyI0Ta4gcT+OY8cdu0F+hQKh273W7Xnp9Z613AZNYKEkBfRXj7fPfJ66rds40OLrGyYfSQUY3
	M9jOaKUpwbumSwWHlDo3uLwscIOqrEpJlKq05YEbaP7sEc4UnFh6UUn+WqPInvSbSHT2sChzjuO
	aOKFd7OUQgQp0sctYwnLoabVPxmvaB2/i5NXf/DQGwmEs825S7BcuV0EqjvLOj/GK1svBVbofQj
	bIZa0MXKxrfGqX1l+hvrz6us5DHWWuLCYy36JodYCnGAZwyPe7nKh4V7/4h239r0fn7WCRCSgDE
	P56BKMnyx/1pBDgyDXAUWcBWM1+RbnPdOhDWI=
X-Received: by 2002:a05:620a:f15:b0:8c5:2d4c:4f0e with SMTP id af79cd13be357-8cb8c9fd576mr1266006785a.25.1771886431284;
        Mon, 23 Feb 2026 14:40:31 -0800 (PST)
X-Received: by 2002:a05:620a:f15:b0:8c5:2d4c:4f0e with SMTP id af79cd13be357-8cb8c9fd576mr1266002285a.25.1771886430804;
        Mon, 23 Feb 2026 14:40:30 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a78b4a45sm18140691fa.13.2026.02.23.14.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:40:28 -0800 (PST)
Date: Tue, 24 Feb 2026 00:40:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
Subject: Re: [PATCH RFC 18/18] MAINTAINERS: Add MAINTAINERS entry for QDA
 driver
Message-ID: <zideovhb7djvsbydqmdyxbgh6cte7xc5ouhm6gsreww6klqqae@o6w6wd4tic4r>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-18-fe46a9c1a046@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-qda-firstpost-v1-18-fe46a9c1a046@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=c5OmgB9l c=1 sm=1 tr=0 ts=699cd75f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=gmMn6fPPSMme9wD3190A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 3SPJamx2o2M9MJ6XoiL1_XO05LjG1VYr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5NyBTYWx0ZWRfX3U0YC1zYFRS3
 tzwBMDFPWDMTaW40jUtQOyKI1Sg8VAOnmP2BHGxHDsNZBN/Z3E75QMXquz8rqYOV8aR2BHZs/Wx
 0eXcNjw45MkCmjYRUrDodBNeBcpSeR4R7gXTlFODcTXTNd6Xs5Q0zMooth4CiU9g6pWXqEsy/8H
 YQXY3Y+ZzxeOyGFcvJzYd8Wd8E5avcA/D4ka/iFyWIFb644kuURs1eZwKUgnkF0dJrAlmEOI2k8
 mE+F65hZaVLJR83tbr50puRF9mlW04pB8soTkisfM3ZHCkQkJkjpVwfU4l4YQWAQDroebYrtC5Y
 xFuoz+WcDnOYNTobl1ad800JH2igdsTbWWysl6Od0Be4+vd6lCddMLq4lEQw+vD7l/VzEoCpA9W
 23gjBKGPN1GZC21iWCAqbUJmK85LviG0RVlwswvnMFozR+ralPVmzhwMJHbWOUOLSX0pQ2L8n9M
 quLw4oeLjbQjFncyhcQ==
X-Proofpoint-ORIG-GUID: 3SPJamx2o2M9MJ6XoiL1_XO05LjG1VYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230197

On Tue, Feb 24, 2026 at 12:39:12AM +0530, Ekansh Gupta wrote:
> Add a new MAINTAINERS entry for the Qualcomm DSP Accelerator (QDA)
> driver. The entry lists the primary maintainer, the linux-arm-msm and
> dri-devel mailing lists, and covers all source files under
> drivers/accel/qda, Documentation/accel/qda and the UAPI header
> include/uapi/drm/qda_accel.h.
> 
> This ensures that patches to the QDA driver and its public API are
> tracked and routed to the appropriate reviewers as the driver is
> integrated into the DRM accel subsystem.

Please add it in the first patch.

> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 71f76fddebbf..78b8b82a6370 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21691,6 +21691,15 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>  F:	drivers/crypto/qce/
>  
> +QUALCOMM DSP ACCELERATOR (QDA) DRIVER
> +M:	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> +L:	linux-arm-msm@vger.kernel.org
> +L:	dri-devel@lists.freedesktop.org
> +S:	Supported
> +F:	Documentation/accel/qda/
> +F:	drivers/accel/qda/
> +F:	include/uapi/drm/qda_accel.h
> +
>  QUALCOMM EMAC GIGABIT ETHERNET DRIVER
>  M:	Timur Tabi <timur@kernel.org>
>  L:	netdev@vger.kernel.org
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
