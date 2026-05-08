Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C053D646C
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271613; cv=none; b=HAKd2i9JOTLe7HVFq5omeqco7DncVFcaYLDq29EgAC7qndgE1ZxzKnfHacdgtuZmuDaLc+JfunfcFWmHja/C9zmU11uv8Jo0WToIeqr8D9EKOg4H/ZlcuC2KV3SvUINe1UbQFyRzKGOM3TgpTOCOXmVjdz+6Hw8taufgEdnhDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271613; c=relaxed/simple;
	bh=2ttoDRFvuARsXM73aSa/iyFGnllYGs0qVza3Mt5VlKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/jSUcezypbS3SnGBUX7om4qvNkDsKYr2ZSahWW5uM4tat7W7xjWCt6McsR8HFyxLeHhkip+S+HHcREfaw5afcodL7XE5Gm7HUBfdgQA5J9vZem6jmP4QJzkKbXvkvWCyS9b4G9e6FC1+6sIFVjN20mFHEXn2S7WWh1srAXzCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VAe7u21T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JW8rvAvK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VAe7u21T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JW8rvAvK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648G47t01093543
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 20:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eo2cOr8LDHMQe3YBBwdT+ufW
	1HrZes1kP3AFsqymXKw=; b=VAe7u21Tk5sv2zpIwGJ6bUhWuVUFeT0XndTet4P+
	9Eep8twjpYbsFCH2JKEciZfmJcwDe1taNnOnwCqsWZJWgC3YlrQVZ408StwSuWgX
	AIkvLpZqWnCbTQfcH0AopSeFsBa+Eynnf0ZYCyZOes2qNHLDCBpmBJyyPCM0b3cA
	mry54d3Pe7BJoKVK+wsJwgb+RAG/dsROP/9thN9+2YLzHjeAGsyDYSoxtOVzPsgb
	ZevysEOhlcZZ9fCCwcdi8+/mlvExcXn5rW+U9HaSK9T5o7bendZqUueIzI0+rIXC
	OtjHNY5JTaWS/jBSuaFXWvG3ZnCu0RgND2tvlu2E1vaEiQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1d0v6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 20:20:11 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6312af106fcso3018067137.3
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778271610; x=1778876410; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eo2cOr8LDHMQe3YBBwdT+ufW1HrZes1kP3AFsqymXKw=;
        b=JW8rvAvKLryQIePtT+50irp7qKHwKPBf8ptOK26UuRzHayNz+3oLs0haZ/Mni1HxcL
         ySP7l5TcFO7tVIoPXbraCGQMLTMVVP6AQfVPaD0arfAZBOTrXcIJDAt8eLuQJ2z1SWgT
         8rYl2EJEavXtLEe472GRoUhSWEIhm6YD7jroQbE8SlNEyumTzdjRVvYvbD38pQuEPQCl
         v9dhQ/N4nIZunh2Z4VnGDjKZogsdiGK686yrzfxIapeba2+Cb70Ro1PUsr4wXnHtXZWt
         WMJYvuisUSRcStxsxxOVXDEY6OfFgw9/jBv59qlFUz8U+f3NOnH6wWNkYTCXY9g6+EzZ
         8v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271610; x=1778876410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo2cOr8LDHMQe3YBBwdT+ufW1HrZes1kP3AFsqymXKw=;
        b=DVZIUqRq4Ovwq7ECkunuSHIkP9hLrcvBAU/oE6lq2Geem/hJzU3ifXCr12a4sLl5sA
         wLFPD2RRfaY0LWpT8oogL1mAy0HxJ9AIHYJl4e6xWy6gpdOb+A+ODPK1g2229i0aq8T2
         V7M1v+gk4x6OSABE10MbuyTFnS9qAC+Rz8oCRyuIyfTn4Ueg4KB8f+leHYpvUKA3b0tw
         eBcVtk6dxVTv82e/L3M+s09nnxP26sX/Vsx915PvzIUiYuXx7fzc7dJI+skHpp7HyLdV
         yx4TE2WSIHWQu1/cxi7oc59G0YC0VIGj397Rm9UU0uBQkK7B4E7GcO0gY1FTx7FHuYSA
         Q+yQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rwU0TBCBtdRbWbT8q/FEfX14J+IgIHZWOHZuuRojmhY+VbX0Ax0J4myX8HTg1wEd4cZc1YQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+jNgVio5kpxqVF8c6sIBumblE2dv4hyQfOhCB1Fa3sR0plu6/
	fabN5J7BXm3jNqbW8/67NzFn1AI8MGGn0KV1FqZvo29y0xuAGSU6Pfxr2s1RgyxNUl2NRgAsi4c
	T1QdepI/yrcbuU8nhEu6TTUmnWhAq+cxR8BbFqmH1Z1NJvDquf6Ab0b6Rlg==
X-Gm-Gg: Acq92OGqYdrfN/8hJ3QniUOdr/5AGzBpjBt9mCNNLkJNrRu9rLAmozydcovUMuiL174
	LanQDAw/msC/9oSo+0DQiE3V1/Z+DyLW81WEub+IjDqLH+tAVzu5lNrduyyH/kUO7v9KUEM0Gan
	DMrNcH8sU+rlJUkgKbqdzAxGGM5NF1afR5OZcx1HcovgNK2X4XD0epzZCVO6HlaFpPhaq1EuMnl
	r/E+seb/ZvGWpVq0oa30ZwNkYoqVs0/lDJaBdUzel+dfT4hXPmiXY8PHIM+6ZdtOXE7gk4e5ICn
	0LAsO/N6YGygRQSpOTMOFcy5xUNq0MqBsovvSkFT2hwwk72aC7CLG8HN0zb/Dp+hSZ/H8qjeo11
	SUBSfo2s9wBx3r9nJWG6EIaBKbvfcWUIvHDCi/8zpcuwX9EUDjEBLBgmEf1sEd05bCNPdWG4chW
	eP844atnkFSH6xD3b5ehsDLvvKPgU/5u2Icoc=
X-Received: by 2002:a05:6102:580e:b0:631:41f9:ffa2 with SMTP id ada2fe7eead31-63141fa0939mr2402757137.29.1778271610162;
        Fri, 08 May 2026 13:20:10 -0700 (PDT)
X-Received: by 2002:a05:6102:580e:b0:631:41f9:ffa2 with SMTP id ada2fe7eead31-63141fa0939mr2402741137.29.1778271609727;
        Fri, 08 May 2026 13:20:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a955df99sm797786e87.45.2026.05.08.13.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:20:08 -0700 (PDT)
Date: Fri, 8 May 2026 23:20:06 +0300
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
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v5 07/14] media: iris: Enable Secure PAS support with
 IOMMU managed by Linux
Message-ID: <elhlmmmisecn7vylpsboiicn7dn4umrggktabyixthmevdv7eo@a4keayee2um7>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-7-7fbb340c5dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509-glymur-v5-7-7fbb340c5dbd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIwMCBTYWx0ZWRfX7sOjlXE6azEW
 GvqnB9ksiIpiSVaCOnbCIpL17cEXCZ0elzc9yMpQzwhFAPpR06mOxBo7VoxbzdRRVV018KVb2iE
 IanAQZF+oa2FZWo/8/26TL9qVyoePhgY8WtrTjW0ENR5acgv7nWMoUIn1g0MlhZo0JPkFenDDwE
 0lJ/ADdDsv1yGJTe7DCsgVJ4JurokZEKkTjqu7pE6JKoIh5g/6PZLZiYqWD0DzA40gqgBG9dJia
 qEj9cXezIyDpxVnQ+viIYHnBIo5gONh9+TkhEkIkqilwpIvhMMpyq/tq+lnmazlycKNJHZhfU0t
 UxobpR0IT7uR9wGKYj4fCWyJox2tWonYvpcrhnjj2NQ2T5cWvBzQIiq4oW+j7ccUzCBE8XRSkgm
 x012bbGl9n/JhZWqRg3F+diD9QL9+wM9lmCGz0ZNxSyR2jp1sMum0rgY19HJibHZnyj8KrMWpKT
 BILgBRixL9J5ojBssCA==
X-Authority-Analysis: v=2.4 cv=GLU41ONK c=1 sm=1 tr=0 ts=69fe457b cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=BowHXwPdtatiOUMbaTwA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: 6A5LNAukTC9LF-1VySInV6eChwHa7AfK
X-Proofpoint-GUID: 6A5LNAukTC9LF-1VySInV6eChwHa7AfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080200

On Sat, May 09, 2026 at 12:29:56AM +0530, Vishnu Reddy wrote:
> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> or QHEE), which typically handles IOMMU configuration. This includes
> mapping memory regions and device memory resources for remote processors
> by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are

No the calls to those functions are not intercepted. Doesn't hypervisor
simply implement the SCM calls?

> later removed during teardown. Additionally, SHM bridge setup is required
> to enable memory protection for both remoteproc metadata and its memory
> regions.
> 
> When the hypervisor is absent, the operating system must perform these
> configurations instead.
> 
> Support for handling IOMMU and SHM setup in the absence of a hypervisor
> is now in place. Extend the Iris driver to enable this functionality on
> platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).

I fail to identify, which changes correspond to this description. If
it's about the PAS context creation, could you please be more specific?

> 
> Additionally, the Iris driver must map the firmware and its required
> resources to the firmware SID, which is now specified via iommu-map in
> the device tree.

Why? You miss the most important part here.

> 
> Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
>  drivers/media/platform/qcom/iris/iris_firmware.c | 72 ++++++++++++++++++++----
>  2 files changed, 66 insertions(+), 10 deletions(-)
> 

-- 
With best wishes
Dmitry
