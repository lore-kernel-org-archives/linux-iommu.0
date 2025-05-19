Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4026A0BA
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652338; cv=none; b=PQUS3S2ITuamJugIdQpVO3Z2dasMmDqfmyzHS2smdK4wYpV4BHHwRT5o8+QkrkQ0m3Nb95f54BQbvePLVmvDoLIwvnoJFA191zwc7S0dRxW7V4zNULT7HbrQExHnwkDAVY9Y9Xr7mYwUUW3oI3FxqiDBl09ATljm02R2cAPeeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652338; c=relaxed/simple;
	bh=Skbd065aT0ZHQcN9uGka7V6r73b5ykLWPWeCTpFhdBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgkZf+hinPLmDiT6+5PnyFMAdl0p0VzDsxFnFaz2dCu8XwTJoZp77fjQZcT3CT5bcVzU0PEYZzOu/op5qtzU16khjVP0InC3M508c+eRFJzudsAXlVrq3sadcp6SIrpu8RYgOi7/XlmqUpkwOSjpynxoxqAlyp8N1jJ/m/qPgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ofkjOmZE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ofkjOmZE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J8dNVO002033
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 10:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UZZqo/joJUMTmddqZvrzyvK+OoeIHz4Jyy9kaXceNaA=; b=ofkjOmZErSlLIt1d
	mCkbYMVN6TGC+Zeeyp/dr2vOSNDHi5I7gYcJ4gAq4tHof7zmYPf/F4bkCN55suW3
	J3wsTvqI51Br/tQ/yLNYFwBYY49E3FX6M011ogCt7V0fFUsW3oSE2g2L50UfoLgz
	8hNaw9OjXQANs8i2P7IgxiDYqXK6+GhLFmz7arXhtKvbNAhv+ccPDtGSOk8xIsyi
	H/ufduINiGxfqdaiAQEBb/0jbg5jWEI/Tu1x0sXE7CdsbWmhTOTsOdtSSttFbV5s
	6MMsK4noJhOoArE2iKWgOvtgxiqGaEAsJ3Y5IFRZCiWnvoCYVPk04YxG6d93OzAs
	c1AF9Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r1atgdqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 10:58:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f8d4461e7bso10581386d6.0
        for <iommu@lists.linux.dev>; Mon, 19 May 2025 03:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747652334; x=1748257134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZZqo/joJUMTmddqZvrzyvK+OoeIHz4Jyy9kaXceNaA=;
        b=HyMMW3FqaEKfvXhRY8+zsYO5Nl4N8ZXzwk6I2Ftt/+7PcCWoEd4pk4fIFV71yUG971
         yCoqSN5Gcs22Mz2GLjh1RYbokYl9lFhGwKVivea3Z9L6kVgysmy2yMCP9rWPo7c0fIdX
         Vp8eVlSsDwdiPYl3f89atqH22b0DKj4KTBOpckpsrBth2RWEmCj21IRrhIE0r+h9pMOZ
         IBYRQfaGplsLR2fP4XxirSleBMlOgj8RF6sco9rYtkhpB17RWMbH05F1iGD9/Mu6UwAz
         KJqY4tcCGk3dzxW5mii+9x9mLNbFP3XTCHJlhSaGKrtoyIjRXzJuUi3HrnXp9ZogXcBv
         XOPw==
X-Forwarded-Encrypted: i=1; AJvYcCVarcOlg3ESWpVNi09MjI3+6dN/1XPEiTM2YiyCgOeM41ruZDGIe/LU9DcDEXM6QVYLdvgg/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxN7l6BK9b6bEs7obkWMSy10hniLruMnoc9sg8EF2EV2ZsDCkma
	8GxpHXwAEAiFfrxrivNbTpQzDOInUO90zmAtgWP1aA4y18vrsKMOXc7PzPclZNlIc9+4zdTDSbS
	FUC+brDiGM4Alxnhq5KC4GUtRxWhlmdGOYJnetoSCx8GexAOK+WxQUgekuw==
X-Gm-Gg: ASbGncvkossadyepjC9Xf5IGM/6078BDcb3GML33UG0av3JYTaGRr9s8XD3l0FLHzLt
	NzsrEKmGWCo8E1T6U6ziBiyYFEko9w2XhYq7ouYO/wiQQcZT5gmkBFT0/nM3bKPJO+KWSZGVsDM
	qAzBcTxk2Gk//AsuEKsPPkzf4Zz+Q83q8WFME2bMzWk5fLooU1+tFJTdzwcdD8ZwWS6NQWlVIrV
	5+xUPrGael5t5477+I3toC5TlTLK9otfLrRGFjmrgOUZ5PQqc6Jirr2yPfHLLpmGyhcoZJ1aw6o
	W/G+Ddk7Hzj4/uK7iSgHGGO5d2Jtfz96b6VA8ZT2jv6EhSm58g7zQGQAieWCAMelTmOdcZb5v24
	qC7eAVLmug/hkidTlkEbdaRan
X-Received: by 2002:ad4:5f8e:0:b0:6f2:b551:a65 with SMTP id 6a1803df08f44-6f8b094f396mr220670236d6.38.1747652334364;
        Mon, 19 May 2025 03:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9NmA4hTkaWiWt1DG/4qc7GE2Tx99AjTx/JlvVe7S5Gwt2EQWgtvBoTnNLcaq/78n2BYfQyQ==
X-Received: by 2002:ad4:5f8e:0:b0:6f2:b551:a65 with SMTP id 6a1803df08f44-6f8b094f396mr220669566d6.38.1747652333886;
        Mon, 19 May 2025 03:58:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f314a2sm1801140e87.77.2025.05.19.03.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:58:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 00/11] Various dt-bindings fixes
Date: Mon, 19 May 2025 13:58:37 +0300
Message-ID: <174637445759.1385605.15383087742490646226.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OfqYDgTY c=1 sm=1 tr=0 ts=682b0eef cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=AprTATsQUE9CPNEuHX8A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: Obb_nVRy_M1J6J7J38bL66LNBR9l6NfC
X-Proofpoint-GUID: Obb_nVRy_M1J6J7J38bL66LNBR9l6NfC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEwNCBTYWx0ZWRfX9xca+SjetI4V
 eDIz8lsdInV3JKGS+TpbUz4VVz1DxmahsliT8gjbNy115SNeRZrESAaO0kI5/WdWUIhUDztAcin
 DanKRus+J5V2pRZCu0teySQZZJe6qzxnm5GNl1p0W/ke8J4Jw5SG8iIC6ErSq/GL4rdtmL3y/jL
 hhK37MB0Aw8+wYMVKeAqWdRc6vU0uDBxVkcRbOia3xyM5ko9P8lwode4TJApk+A/wmLwuyldYDf
 AjnD4UaNT59wpyloA5GVIiZq4pAD1nQqH6jqEp9fMoLVuCO3vYlHEn2JdGHQD71Ekv2k1zC+o5l
 nc8bdlQc2z19NvNrsCwMuSeZP0g3jOhWnmqwrJ/LuJcB3sIo1k4TTfgr/tGn3p9cPCG9Af4gThv
 J5IEoZ9P9LZBnE7yn+nbL1Tw1oZzxFhRki+ry5wiFU+75cstFIc3v/6xAReqP3T2O9ndH3GU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=871
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190104
Message-ID: <20250519105837.rZXq35HRZPM5UgGFkJ38HX73LlfSVHDdpAoQcum0Hjw@z>


On Thu, 06 Mar 2025 19:11:12 +0100, Konrad Dybcio wrote:
> A set of not quite related bindings warnings fixes.
> 
> 

Applied, thanks!

[02/11] dt-bindings: display: msm: sm8350-mdss: Describe the CPU-CFG icc path
        https://gitlab.freedesktop.org/lumag/msm/-/commit/60b8d3a2365a

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
