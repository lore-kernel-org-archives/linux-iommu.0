Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020C20E70E
	for <iommu@lists.linux.dev>; Thu,  1 May 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135932; cv=none; b=Qkd5f/U4Wc5daay31EXbsxyF6kied9IJKedJEza0Q7ufLJ65+uTQl9XtoZERzuGIgMVQWbQkAm0YikyONZayAyC577gL9jv9zRd6jq1ET3LRYXFlX4LtXDE6UF7ByZOvCX1c4HfiEphqEcAKuVKS/GOfGZ1t05hL+KtHuliEJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135932; c=relaxed/simple;
	bh=Vl91YjoG9bqUjwa4D3IQmMOeHqOlYv+Ub5TMWghr/ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H19UcO44xdhCYWeZ5k/kt+IbO1WkPOHge/6Jmev2WzDMs0yE1eVT2sFC8qsoauHjhXZzpwvqZ/O73nY1oIKC1+5bX+UJ0JPl+4Un5dTVU3DOZ3ZzLDZ2fOZrgcj8hN3h4RubXMNA9l0CMi83EvvxxPaHCljydLDheD1vSQT/5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K6vyi+7m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K6vyi+7m"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541D2910009840
	for <iommu@lists.linux.dev>; Thu, 1 May 2025 21:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZWvEe+y9fZ95LVZsDUiRwMr7
	gR6HVKRq8+OepTYfaZw=; b=K6vyi+7mToNIxjqq+Ofgd06E3o9S/X8ARJPRxMz6
	Unhkwgq3QdDdgB7/LoNv13RljEQ2wjstmw4D4y3PKkA7L+u6j2+3OBdSH0eklOdb
	trR54Z6tA+VB0OfEqSFs+thq2Yi/aStvjKUNbNSdbEJbaPV7bChyArEVh30sUFDx
	vr5NUHdJoS+pOtJbUDH9x/GWeF3PzTsOrp6tjU/Yh1ZR2BugoAqMJLO4qzW8WNR/
	spOs4ksP/c4jHEHpbSp+QCDAwjcKIS+x4n2rqgzYGJBU5vL6fM4nWtgbDF8cJUtk
	41i2MzIdzp/q9BCiI+Fv+N7hsX7bay5REUyT6LwjaAr+vA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6uaxfx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 01 May 2025 21:45:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5c82c6d72so230972185a.2
        for <iommu@lists.linux.dev>; Thu, 01 May 2025 14:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746135927; x=1746740727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWvEe+y9fZ95LVZsDUiRwMr7gR6HVKRq8+OepTYfaZw=;
        b=SeBslsUVnIh0bKpTKiDC80ehXyb1b4WRzOMI8TYw3yXgMJTYmn7qk8lU5TMlQeKc3j
         Fy9ejv1SoVPDjfjN2ei8NmxdVt94HOKm3UHYAnNHSqp2I7jqUE9xaRhqHDZOd6Re6Ovx
         fQSsKN8NmPi8631Ef8qfhHzVLX8DhT0u3rBFyp42ecCb2kDIxZG+qylSSFhdpprhrumt
         hbtNpQF5Fr/Ox86hgwP3Z6dyD/PksWmmGTAj2M/o9e6mjE2fIJ17xzo2isLNV9FNFTaq
         ePQom3IbQk0o4x/iLjwGrBjvc0J+cY9GS7ZZXuVKBEjFhCMFJ4ZakaWosaOBBpCZ654s
         y9RA==
X-Forwarded-Encrypted: i=1; AJvYcCWOqTnBbaeoi1sMRE+zboO5Zu1lyMuWWa6z4vBbpgvt1RiuEWgKtFF7bPivmy2JZIhLCJWCiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjZauu70m3lCh2RBkPMWM9RTzxrT4GhF/QlJ0aCkcJwLdlWzxp
	bpm03d3/vczPPobJQh6NLu6BbPKpiDXdbJhYIYCFqbPKqsHs+xUq0XwTrn6pc8LFxmqoF9+NuXt
	ajB2nn3t0aEj7NJ+ATNJdtJlJYf3b2XZrjojhToB4xaOlQU4rxq+i7w==
X-Gm-Gg: ASbGncuMohbWyKcqeo6+NElJ1y8M6c9YYjRn108Nvkd1DDYaHPcZCDpXM01J92fgfaq
	CzAEh/Adf0Jp5Tz+HoGGhhrzuYItgY8Byc9S3c8pwImGDi6bhedw8IRCU+yNwk4t88xvSkAPBYp
	hMRE5gjnralr/PR+1bBvVCH905G/vVUVmeqwWW0+cyZbYSWsaRilktD70Zl7scd6/x5W6wmnouB
	cfLXM+rtfYkL/e2USXQniOYlW4YveHiX48KvrR0Va7Qz/MFXqXETuc5Z2QOjuq1nYe73cyLLOuJ
	GmtQVYmb6/muevAaZSsFoZWhkILeKG+sZm94y4z6LtSZp9jvd56qIhMAnoo75BHsveU8Ni/mNX8
	=
X-Received: by 2002:a05:620a:4304:b0:7c5:9a6c:b7d3 with SMTP id af79cd13be357-7cad5b8e24dmr91835985a.37.1746135927301;
        Thu, 01 May 2025 14:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+2T3LiQpLagEU33hPpPGBOSneQuetQ2NiGG7X9LR4oyqvviiI/t4vmBzHx93FvWEjq2NtFA==
X-Received: by 2002:a05:620a:4304:b0:7c5:9a6c:b7d3 with SMTP id af79cd13be357-7cad5b8e24dmr91832185a.37.1746135926940;
        Thu, 01 May 2025 14:45:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3202930c92esm1997371fa.54.2025.05.01.14.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 14:45:25 -0700 (PDT)
Date: Fri, 2 May 2025 00:45:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Robert Foss <rfoss@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Kyle Deng <quic_chunkaid@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 02/11] dt-bindings: display: msm: sm8350-mdss: Describe
 the CPU-CFG icc path
Message-ID: <spvg6kmgzkmkknttwrzjonn3pshj3vvoqn2ffv7euucnkysbtc@vmiqfocytvar>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-2-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-2-0c84aceb0ef9@oss.qualcomm.com>
X-Proofpoint-GUID: Y3vcpBcbmIAISu5O2WsQi6xbZssdT0oL
X-Authority-Analysis: v=2.4 cv=KtlN2XWN c=1 sm=1 tr=0 ts=6813eb78 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=EuULMs42TwgxzVLzQZQA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Y3vcpBcbmIAISu5O2WsQi6xbZssdT0oL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDE2NCBTYWx0ZWRfX38+cI4tvzxxS qP/6yAVDnK9WnvLUpa2bxBKCDOjfLsgvxpQG6R8p85uM6acSXlSWaebdOs59KMJug5v+qCNf2n8 sSGyy1v8j+E4JMkpX9MK5eq0JhxTb8CljDxoqWH0Kw9Cu6vxvT+tlISUM3epZE8Z7Il7R+sxbLe
 U8dy7j0zkXE96cUYTIn4yskqgppazHx7S9vBYQ8oiNJa8H8YcQZzQNk4rna6shcUsP0Je20WY/Z gWBSMMrPHGcPSVhFVOfzVn+qeWYPzi9KrZV5IN7BL3+P3JSX9J6o2ikHkopHDtbTDOFukF1/tPL BtwIXHQKFgk7YbE+I7wM4Z3BXyuOQsmKH/Wba+77NCmk/Hw9NJBfSXXJVbcq7CU0mpbjqw7VfEW
 h1lwfaZj/0ehuKdJgko9IkvVvkci1X2AxaCjx+mQWJ2S9Ek6MkMbMd2jCXQXC2Yf9zN67nCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=675 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010164

On Thu, Mar 06, 2025 at 07:11:14PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> There's a separate path that allows register access from CPUSS.
> Describe it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
-- 
With best wishes
Dmitry
