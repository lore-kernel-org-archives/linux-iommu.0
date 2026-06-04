Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD8374739
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578188; cv=none; b=KVGg2zyKBQUGxw2SxQwRwaMsKzLhnalrLrnaK6VDnEfkKzobSPj/x7i8muOFST/f4WXuOVYa+xjfjvI0dGhYzBpI2mLTOOFtQrji4lrqEq7gwxjy5p6KkX4S3DqB/QISsq+1RS0nPsfx+Qj14q0ExGYlAXDqV89Ky3gtzOcATvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578188; c=relaxed/simple;
	bh=aCZ+AS8Mf9BxnQNj87m/hj2teLLK19zwB5HLLG8xeL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIGK1sLffVafc8e8Ys4htPAIgs5QpiksAzqVFfpAuppQrATIGxIPRESKQC5MJWxJh6hnn3ootYs0ofrvUNIrJno53vYObOCJZMvnb+QoWpWY8IsnBnHpQCfJ4vHnf9Lzpc56kgQI3gtzvndX6qrItwmRSOKdQRWGiJinJ9Lj2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H8KFaz4v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gWMiG18s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8KFaz4v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gWMiG18s"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654CCcdZ3221147
	for <iommu@lists.linux.dev>; Thu, 4 Jun 2026 13:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JfgOto66Y3BLWLac1kUqpihI
	4RTvBJSSkEWoerZ0cj0=; b=H8KFaz4vgr9C3gNzdMlBYO6OFNtIQCeo1LdaNXs/
	YpfqyoP1Aa0ccSgUiwDXvz0HasZVd8x49Hp/pU6gksfHztq/6Wy3SKKixJTHzMtX
	3H6SmVJmEDX/HT4mdzSaj/+GXrz97sV0TjpxBSu1IjBnfEEisk/puCehARlyz8Ii
	tquZx0zMSUtxv1yU6U8NbBjtAPYUH4Zs/xHsTtMR1llEfTTIKRQuayosNPeVyuI+
	cmoNGQr8Kw4RmphkdGO4DLpS3cXrGD4iNN6BxL4TnhLJId7KslM7EV0TSYddCGxi
	pa4BGp9+7X3brrSKDNw7waXFKI4KS5t+xzjkAZnPNif/rw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek95u877j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 13:03:06 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6fd5f007eso1267871a34.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780578185; x=1781182985; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfgOto66Y3BLWLac1kUqpihI4RTvBJSSkEWoerZ0cj0=;
        b=gWMiG18sBjr/OoSZlKYqQ0e4CqwcSXVG9ylYddtuGcQ7rvao/TbpaO/Zk9ZESm4LQA
         TcjiZL8/975a5Ws3WvAa/b5z1udgWaPqoj9YtBnY2vCQGhew+5/8kX9HhrHiwjPOQ6Af
         NlthHTG70HpoqvLuEEE9l5TFOp150rEIqFsJfanDKhaYh/6udLEaZDGU3xjlPSShDoWW
         j5+iLIfXdXZyhhV/l+iOfCcoqDl2lmkZsDKHMlzkLkdoqZtrI0g9o/5fmQ9l4gUehVHn
         e5GZNMmQAX8XgWMZZD79fSvk3kweviZxnJesvUE4qORwVA7W2kRwiJcMNZA5k2RvQyNF
         nddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780578185; x=1781182985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfgOto66Y3BLWLac1kUqpihI4RTvBJSSkEWoerZ0cj0=;
        b=mTsjvyP2gRTS8uFXoBJ/BCP9rv3iECN1GeLx4iQIJfD7dVwzZBlV7uhMggBnorvVAR
         9dD/IWhji7ITI8kQ1ba2VNTl0TgE/hx0Og5BASUgsZSt+NoaAbcJp5EQ6WbKo15e1oOa
         VvLj314jKn7kyGLsConZb/GL1/TLGXSYDg+ypoQ47f5QyBqBBABWmLpEqBdw5+dosGsV
         FnUyJZGgIRYquSLOLGaAHhrC73nb/+1XU8l22z2fMtXO45DinTTFw22T0QZDpseyPYKw
         NOh/EY54ZrkG0kdp/bKRNdhcQ7vkwxkG0Tuy4SgEqrjyraRsXqP3kk3XQWXz0695oAAa
         LtAg==
X-Forwarded-Encrypted: i=1; AFNElJ/9WzuT7BpjQo4Kp4IOZw7jI1RagTga0dajPcWOD3tDoW5fmaBVNZreP/wk6PSJ2tQn1mE5rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGKFZt2wiJ0qYdK3GOp9fpl9ECBXXPwXcNyff+cLal7E4BVNKh
	GIieurSaUEYYgEG0VX0v5UtKypS8HJIzKO/d9Ga8NL237lUEKHLVOkJQoBqT86dm+uVL8AYw2SV
	+vM3/UBQU3q5UbgduvUNqp9Rv9+t6bauLGSkKdcPlqIsDIn44XYxB8C6i4w==
X-Gm-Gg: Acq92OGKbGw48fYvQCyfIzZeLmGa8maNtC3uPMo0tdlDa+BX61AFseV3nA/ypOBuPwy
	u4upk0aIYuFnzvDUaQeRI+1JXLOebM9ns5ifIhn6hV0FDhM2LkZ4atOkh/4mo6fl+pRpaP6s7eR
	bzUWf14h1CftZuvOFzvub6k1fuylQMxEvc5iIfA6cMpMFn37EefilUcHHN5qq36urpX+CM5DTjF
	7heXtfdkBYxQuMi/6tf6LMFfEl4E7+ca8kJbn+y3lB/MIseIM85MEZKd5pHhyf1PO9KNZ9BzH5t
	/J6WNVSZaKGbEqLS62wiXxQnxTeXi2gRY8ou9cjUmeBKmla37IldYaq8cgVI3ImXQJiJZikOuTe
	S2HYzUfUdYjLwOOzdL3UuxwleXp/5103AoiMmFC/j3J6L7zDk34BERWOVHRyaXVbCbaFbjOo0r0
	thpg3lPJWcbdYSOY/GBn0eYSyDyfqfhi7M7FCGRWBlSBOzUQ==
X-Received: by 2002:a05:6830:1e3a:b0:7e6:c8e:89f3 with SMTP id 46e09a7af769-7e6f9244026mr1380351a34.6.1780578185125;
        Thu, 04 Jun 2026 06:03:05 -0700 (PDT)
X-Received: by 2002:a05:6830:1e3a:b0:7e6:c8e:89f3 with SMTP id 46e09a7af769-7e6f9244026mr1380291a34.6.1780578184514;
        Thu, 04 Jun 2026 06:03:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2d5034sm16257901fa.29.2026.06.04.06.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:03:03 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:03:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Subject: [PATCH 0/3] Add Shikra (QCM2390) display
 support
Message-ID: <cvszjw5psd6cenek7ujczjkmcvrzhtckknrifb4pphxotca75k@irvape42pzzn>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=at2CzyZV c=1 sm=1 tr=0 ts=6a21778a cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=FTaq_hUnWkcAyd37DvkA:9
 a=CjuIK1q_8ugA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNyBTYWx0ZWRfX8KDEy5sAmzAR
 yXS4OXesaEvzQTXe+0a8gYm3DaqugkwOWB43rHnulJE6KS57kCzrJ1p6N7mkdbxyt/PIzmAn5nv
 K5jH9+jB9PMu30UMlh0hOu/8D8h+w96wFTxot8SAuEv1e/2mbz9iA6oS+xLoG2YL2iAeDwIU+AK
 fZsmI0x4ogd/i1F3gnycYWc4QwLcNEuUFMlShK9rk+jLy7ocW6Hy3Kyz2abx96m2gKE19G7u2YL
 UTnD7KUGWlnA8prZT3P6StG6+WEgHWNj6RO5R0DNI6JhW15lxyQrQ+pOFK+aasygIfJgQ5RSVFj
 0d5XgKabvWs+y4kKQzxE3BsvEIDMAOxtIkT6kbZyJCLibX2tE6yHZkZ0TsQ9oFVL2mzVKk9YH/T
 e1XEp54O4Qtp970If9liP8mSo9DItBkF5OblA1lqG27Q56IpyQIlp0IarzHIPmZAg4Z1xzdj/dH
 /GbyANMefc3r3doBM/g==
X-Proofpoint-GUID: jJsUll9kXQWL8SS4s__ECBo9YvrV1-uK
X-Proofpoint-ORIG-GUID: jJsUll9kXQWL8SS4s__ECBo9YvrV1-uK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040127

On Thu, Jun 04, 2026 at 06:00:46PM +0530, Nabige Aala wrote:

[PATCH v2 0/3] Subject: [PATCH 0/3] Add Shikra (QCM2390) display support 

The subject line is wrong. Please use the tools properly (I'd strongly
recommend using the b4 tool).

-- 
With best wishes
Dmitry
