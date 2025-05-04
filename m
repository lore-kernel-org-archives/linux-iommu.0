Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE791EB1AE
	for <iommu@lists.linux.dev>; Sun,  4 May 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746375226; cv=none; b=ASWxDqM4rq2n05VbLpA2u0ne9U9TFaK7fq6Kf2P9vN8XPBxiZ+V7txujJnN72HDEaBYIeo4KfL2zyZlgFKmQCkufi8kdYGqLZyyoyoKqYZeIWyz6qRqnmFkU8fqKhnBXkuFuvy5QOU3qOolLgO7ngzxh2Dmz2ojkDiugOcOay7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746375226; c=relaxed/simple;
	bh=O68Yf4MVfSbvrTGnH2tyPtJDd/D9PTw/7oag6m4b3Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyiFz/ZMk7mhzLtkK/ot0YP7BJfHKGtW7g+Kkh7OFrHuRScwCKVSBEVK9rPhx/HEO/qpJakusQu1X8/FolPcQSfxfOhoIGj/HFIRDYk70eLe8VF9KqTMAZqgMIAXiq7ifyW0pIuOyL6qxKEMIB1v+l5gOPspFwc4wCMC5u5fEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KmuoZrem; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KmuoZrem"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544303lO023631
	for <iommu@lists.linux.dev>; Sun, 4 May 2025 16:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VqRNS/AP2L0HYV/XzQMxzhswyBS2iB5hSp0sUNl5kjs=; b=KmuoZremEiorgmv6
	hZ8N2J1KRhkxb3L9zQJbG+Vwnt1Ki+ZvBh8uLNPQ3LzBeVueVVb2dCfIsvhQ/T/m
	ZXJs4Z5p5W5H/Q3Ikmk4H3EjF5dSmGJ9aI1NU7zXqhBc/uIDsa088TteaElE4RQX
	dc5iUulHFfafIrOBKhwzXy0gWXSUTDXJAVTcJ7/hmrfWe31Ij7qU6WHk9ARh4DJJ
	jkGwtA4HS8orNBfiW9BB6Jlf61e9njSAzEl/fppwE6QYxxMiqFlTgtK+BgRj7t7A
	8RmJOKvzpLGK9aSIzsvkgX6a25X0wk+5fjH8OB7ouNjlbj+CoMsbTpCCQmmkuv/7
	fS1NCA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbwfj3g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 04 May 2025 16:13:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c543ab40d3so4821385a.2
        for <iommu@lists.linux.dev>; Sun, 04 May 2025 09:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746375222; x=1746980022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqRNS/AP2L0HYV/XzQMxzhswyBS2iB5hSp0sUNl5kjs=;
        b=b0h1x4eVxzxV+zm0RJLditvshNBYBVx+o56EfbKzLF1KjluzSasu/jCPXaMzywqid1
         I21sS6wJ2j4OsvK968CAAwxNRqwBvpyWQUHMrR//fX5pcKm9NDe+rYisi8RDe2EM/2U6
         4ylugHYk1qZHJb1e8QxoG59IoURPVh9a9dFdEfoaWwHslymJcfB/aPclM64t3rHh1u7r
         T4E1825q89hb0xNbICk3WjVgBJDegLcbWzDMrIruYP7g6Ke57xrJOEa6XwR+5m6HmD05
         Rvslv1DODzHyMmBUCQzIgQdQj5JA6PANBAX/Xf8iAr6+4tGYWssJUmooHCYPjnBsK+6z
         +mFg==
X-Forwarded-Encrypted: i=1; AJvYcCUNafMuMoe9mABC0ZBJI1jzKFRifeJdKl39u89ybXRgVprzZ0Z21LRLEMJak5IT1V+3YiAaxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaXfvJWhyRAw/Bb+jeoiKHcxDZSIntR4r9f4rWB5md3k85k0h8
	8MEynzepl8W1ZKhDWlHBcqy3tA+uje66U8Z7cLVxwhuwLqY4KIE2phc2fQiNYhtFsgoyzVa9N4m
	C3iwx3Xb+InQFxkQlhETTFDZprqXZ3NBEXc6Jtyr32vc7OK8mNzRaGA==
X-Gm-Gg: ASbGncvTSGdi4QHb5V8nhsiK+XLUcRrOQMafigYHF3zNcak5yDNoIyz+vCDjBKUgZyT
	meuIsKAicWW4TLf8JXiQ3MTHCSWtsC+3m26reAmEo/oISKhj7XEWBbhi9iTDJr3UwBsKdu0jGjU
	9ElNSCQ4uCWBpZq035WmAypOPALMRqSMWe9BXudQUjLR9+gGbiHlW4cx/cV1EUTpNjiPs6LZedy
	J/rwh+/WLxVqZdWAQjbOSIMD/p4/nb2DNZ2nAIy/MX9+qARTEQoV2bd9ACnrF9lY1YpEJi/87l9
	9+fBib3QhwldSIghYQHsncbCaDVMgXjgXmF2frrZxlO+zXwODgjDmH4/D4+L9PSHbSj6BWJuphJ
	qlAUuN3qjQHmn3BjtUhTxQlYT
X-Received: by 2002:a05:620a:bc5:b0:7c5:a29e:3477 with SMTP id af79cd13be357-7cadfeda15emr898765685a.53.1746375222436;
        Sun, 04 May 2025 09:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9jh4HRhFrjaplPP4DWWTXh3MXHXCDhI5cVsnoV7jzD3rgGA1I0X5J69xbTqyP4ckpUfqShg==
X-Received: by 2002:a05:620a:bc5:b0:7c5:a29e:3477 with SMTP id af79cd13be357-7cadfeda15emr898759485a.53.1746375221999;
        Sun, 04 May 2025 09:13:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94ee937sm1335231e87.142.2025.05.04.09.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 09:13:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 00/10] drm/msm: add support for SAR2130P
Date: Sun,  4 May 2025 19:13:24 +0300
Message-Id: <174637445761.1385605.10286310480029078025.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250418-sar2130p-display-v5-0-442c905cb3a4@oss.qualcomm.com>
References: <20250418-sar2130p-display-v5-0-442c905cb3a4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0G68oG0C8CTPODmk5ozuY4aLfaLfDoB1
X-Proofpoint-GUID: 0G68oG0C8CTPODmk5ozuY4aLfaLfDoB1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDE1MiBTYWx0ZWRfX59pK7Y0IV0pj
 iGhCyRVZ6jjn7dx68RZVnpJLMOie75Cz6RjFQvHNV0m3MaggMJVLYdSc+ZU8dzyBtL9KPyHfuBO
 Xu+bPe5091iR/VfaEB3Sn+Syehj5eFfa8vuWTIwPf9phj+BkkEvqkOLfIanI0vFbHXxYlDQ3zix
 uJw9AIf9JG1SSk8goYS01SxfC5vBUSUdx/DEFfsMzSc8cyGCPrVjvRbOIKg83TY3CaCw88cPJJc
 GNkoYVyXTDU5KsEOdqSx4aQl0eZpvitewUOCAe9c4CRc6oSn2Tr63JlpNvIivqmDwJH6UsJCuLt
 /cNS/cDDaaW8yHro3eM577zKmdgI6kLbW1/57EQzlG9txHM9kkqEqDB1ycx/VTkgGzSu12jE8rp
 C/rIf1C0akVQZrTuvMlAv7I/MOR7sIW7g1Qt4EdffdFSROWyff8qfUYtHPJxgdGGXs25GGxV
X-Authority-Analysis: v=2.4 cv=AfqxH2XG c=1 sm=1 tr=0 ts=68179237 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=iEGPaXCqe01J9_RIJz0A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=914
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505040152


On Fri, 18 Apr 2025 10:49:55 +0300, Dmitry Baryshkov wrote:
> Add support for the Mobile Display SubSystem (MDSS) device present on
> the Qualcomm SAR2130P platform. The MDSS device is similar to SM8550, it
> features two MIPI DSI controllers, two MIPI DSI PHYs and one DisplayPort
> controller.
> 
> Note, due to the technical limitations DP controller wasn't completely
> evaluated.
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: display/msm: dp-controller: describe SAR2130P
        https://gitlab.freedesktop.org/lumag/msm/-/commit/b341da1172fe
[02/10] dt-bindings: display/msm: dsi-controller-main: describe SAR2130P
        https://gitlab.freedesktop.org/lumag/msm/-/commit/3c70c9d0a99d
[03/10] dt-bindings: display/msm: dsi-phy-7nm: describe SAR2130P
        https://gitlab.freedesktop.org/lumag/msm/-/commit/262650e71854
[04/10] dt-bindings: display/msm: qcom,sc7280-dpu: describe SAR2130P
        https://gitlab.freedesktop.org/lumag/msm/-/commit/759fe7181723
[05/10] dt-bindings: display/msm: Add Qualcomm SAR2130P
        https://gitlab.freedesktop.org/lumag/msm/-/commit/3096209b7a62
[06/10] drm/msm/mdss: add SAR2130P device configuration
        https://gitlab.freedesktop.org/lumag/msm/-/commit/1e7cbfea6624
[07/10] drm/msm/dsi/phy: add configuration for SAR2130P
        https://gitlab.freedesktop.org/lumag/msm/-/commit/8e63b2075e01
[08/10] drm/msm/dpu: add catalog entry for SAR2130P
        https://gitlab.freedesktop.org/lumag/msm/-/commit/178575173472

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
