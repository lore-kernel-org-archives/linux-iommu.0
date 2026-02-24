Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82126B755
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904382; cv=none; b=itVvpqZXU9hHl5xYP/BWwL1kqT+bqKjYs3I0QLsO3VXbesWS3EpMMWRZgEne9Gne+QuVXHfB064Pof0Ynhlxx6DatmPpfTm97F35pc217aP9W9pYbLCiHMfkJA9mjfFw1IHORjjqTG8jqrxdEo8s1AVyzSFopndtQ0w9G56ci08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904382; c=relaxed/simple;
	bh=BIKoM8z9nstVrL4h5mDb+fYd9te7PInNqQQm2CNDpmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ot35Ndl2TaXEhhcusjzwKdBpPoU5nzKMMApaeJnFqdvdP9xGKspyfflLS5xqRQS3TWpaAoQAD8CGzjKS5knD3WJHqu+pstzls1CTMIVSxri7ir4TtNJls3v2yEcvyBNgNtWrYaF1obRE5WvOnm+niJMAR7JJ5eqy5NyqKYeA6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fL9LfETQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GQuv2Rxb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fL9LfETQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GQuv2Rxb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O3KqmI1625625
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 03:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KILrgs7d74mR23o2eIzLn2FfkB9mDLXK+R0lgubWZsM=; b=fL9LfETQS8Vb/1Xl
	jdJ4gaRZDr8qxINFPzWmOkXDWsoNl64GHSh9uT6icfJfocI69K0govoY/vLEp9Uj
	CQ3+L2j1FpVamayYUciAA9KGg62JWBozxHfk8SZbhbl1bLTFg/z38s/DdkOZcjJn
	5F2lgvkmXObVr7Fely/OBCEQ6muoRdp/b7rrIgJFNgm4HYUvZ7ym23a1w13eE029
	DBhTaP8LkwlQm0/cEo9+EYVXYE2lBZbZvufVvhaIuxbOFKiXazG4rEReRG7Bnt3o
	+NlKc6YJODZ0CbjBOnMqDYETH8RoXITeca4ByZl7YG3cq2nH9inbwRfto+EhaSkO
	BHurCg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn81arke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 03:39:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bda35eab74so614487eec.0
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771904380; x=1772509180; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KILrgs7d74mR23o2eIzLn2FfkB9mDLXK+R0lgubWZsM=;
        b=GQuv2RxbV1PnzlPjVYAxg5RpFkDhmhE2Hu8vOT5zIIxPYsps/OEBQFhJqFGZ9mCRor
         VXKXpZBse7ufbD0myei4UxEwOJL+Ab5Bvmjt1mMpsiuhrYx9fSd3Bei5FwiDdnjjPNiH
         /Wd+20Hj6bWzIvrwT1G8r2P5pXinluQNeP05LZodYcW4+fBFjlO4jitjUyM99AUCqjJW
         DixqCt1/f/71MO7l5ThbrsjB9xLQ3Jac1L5YyFc8hyvG/Ue9PIoeOhp/E4kicbKXml0m
         T1WWi8lofeN68mCAMvcghEvPR90bJfcv3vDcsmdhq5sY3MkHYoiu6NnZ4dhbnDNw/DPG
         n9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771904380; x=1772509180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KILrgs7d74mR23o2eIzLn2FfkB9mDLXK+R0lgubWZsM=;
        b=E9bcWAOxlH2ew6+KY90t0KE1PsZP1rxnDrrhop/age3MjphUNWX0ax6+XJUujeLxEL
         B8lmUww7VX81uyaVm1rH6Y7tS816kdC+7ukxvTdRGgQcjLI2SIBRZ9ummolxWz5B+mPc
         gNfU+0zZhPRmFwr2RKNd6k0Yj3/h2bev2AvidzbC8tMJJlYKev+6MwKdozoum2YU1x9P
         o0EeLDuoAKedTKfTW9R2FJiWdgMT/+c6AlOvurJal2PejPpzau/7s3tIROcd3wMNOLMS
         +wCPCZpGuQEn4EkjMZYDfssgzj1USfIU1zdZD9rnFZEyYCB5q5ZCVh9neKeakb27jFVa
         T3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwkUvBUNIs7+JGBKdzbaphi7C6ygsjUUCsRnF9pS7u+jGBO+VNSwXirJt46cdxomFZElkOKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywcy8eFAn4OUWL/K5qk1v6bQk7H55MOt7EObrHQI69nNFB7LyRu
	gaoP1ruphq3CU+byWvWpflRLWERyS91KaBpCklsg4WAVsK+41rO37BAsmVD15Gj1tNGfXLe3akZ
	lYlh3MMHPuIavq6ccJ7J+QIHmVZqrvj9njNZwuzi4uh7La08FpfqzkYQgKw==
X-Gm-Gg: ATEYQzx4cyvUSis+9xMGVhQ63QhNxn9Zz51adl9cfZk79PDHAb1WYom9gxMLLFNyEwc
	Ol7V7uoxPUXMnwJnrivd1na49Wv3P0IM4wy1C6CA/2GPeW3bMvDMpJGMjNaqG60O20boUmO27nQ
	g6SlQ/9fTG4zdz9lAcPrf6bG09+kevj2aC9VpGvHNRPk7TBVHLphlYgoWjOy0esW16ogO1l3GoR
	VLxwIMitEWBoEwvGElymC0usoQBCvSykCcjKwxy0jsAlkUrLCJ6OSWkRgutldzlH41Xa04aJwjP
	tDWXlvVlDsJdx5b9PkD1gusd8W1T8gvseoMFeTcmbx3MLLXRbN4LG6tHlctfleSoynsJYF3LUp2
	/SGRWIT2++hn+1NSDdclsmoxFGAsnr5IQf8FujY/JalQToapGBDE14LM=
X-Received: by 2002:a05:7300:d4cb:b0:2b7:f2e5:11a4 with SMTP id 5a478bee46e88-2bd7b89c2b7mr4123703eec.16.1771904379568;
        Mon, 23 Feb 2026 19:39:39 -0800 (PST)
X-Received: by 2002:a05:7300:d4cb:b0:2b7:f2e5:11a4 with SMTP id 5a478bee46e88-2bd7b89c2b7mr4123681eec.16.1771904379070;
        Mon, 23 Feb 2026 19:39:39 -0800 (PST)
Received: from [192.168.86.165] ([76.176.48.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da47778sm6089378eec.6.2026.02.23.19.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 19:39:38 -0800 (PST)
Message-ID: <cac08f2f-73b0-4629-898a-1e24840910fd@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 19:39:37 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/18] accel/qda: Introduce Qualcomm DSP Accelerator
 driver
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -9mLqk4JOxtRBeLK-eSiSMg6Z6kWPgf4
X-Proofpoint-ORIG-GUID: -9mLqk4JOxtRBeLK-eSiSMg6Z6kWPgf4
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=699d1d7c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=lsoD3MMNObdLvy1227ExmA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=aquNE3KFXbjoS9wDYHgA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAyOSBTYWx0ZWRfX0XQEpzKek0Fl
 eFJrzxf57ZiBspWSAd7+meu9mZDZgpX5NtgVJVxkzu/TRhua4meAWTdCBvxaLFSRCzZev1QxA5O
 u5ojTkLxBAEWRoboVVJsb+IpwzjXRfJXSWZ0tpkX2sXX0hNbqVGVBuYmhlmM4NLBr0ap+FFZxiN
 sghilDQfiyejRH0+E7ZH5yx1k6c40E057nUPq5ZumiAXbxm+P9G5TRKxa4Sl+YwDBkyTAB03nWY
 C/PAu2dbPLJrEedFhFdtrqgpbKLmTylgiG7gWBZhrjoiyuE0MknObqImfESlgL2ExOkBpEV04IU
 7Ny62aC0JGh9pialGT36njcI5TX54jzWNh0DDabVrvk82AgB91ut7SxkiZdihQjuXw5fzJ4vivc
 O2TT2i6tOzmG766AqEfKL4oVSbbhSpA/GjbE6WIokPMR+u6d0n9zL7up2dE1a2nCKzOWCBtdG+F
 u1GRZ2/zJJoTShWxY2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240029

On 2/23/2026 11:08 AM, Ekansh Gupta wrote:
> * Userspace Interface: While the driver provides a new DRM-based UAPI,
>   the underlying FastRPC protocol and DSP firmware interface remain
>   compatible. This ensures that DSP firmware and libraries continue to
>   work without modification.


This is not very clear and it is not explained properly in the 1st patch
where you document this driver. It doesn't talk about how older
UAPI based application will still work without any change
or recompilation. I prefer the same old binary to work w/ the new
DRM based interface without any changes (I don't know how that will be possible)
OR if recompilation + linking is needed then you need to provide the wrapper library.

---Trilok Soni
