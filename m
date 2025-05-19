Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414627465D
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652334; cv=none; b=Uf91NKohpAtNbCgE8zNxGSxgEYak01uLdOcDC8Rrltx6RcfVcSvdsLImFWgevSp0/jJFEEErC8liADmSYv9XzrI60gH8DEbsPHEjcJMnqp0zn4Upb/5LzwMc+9AKumgTmAi0vTnjXe3kiU9MxByMQncJ1k9io29qYSStcUktHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652334; c=relaxed/simple;
	bh=O68Yf4MVfSbvrTGnH2tyPtJDd/D9PTw/7oag6m4b3Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCnkfeVbFKclVRftTrOH9AL17dInoCgrGtFEkol4KIKqvScBIuEYlsFnHahg0oBfydYqhgJ0Xqt/S+AUtiYbAs5aRb9JURMYCctmxV5Apsn4fwkPvxH5dQ/QA02w5wngqv+S9pV5/C5gg100mVwbqBjV3WXcZw6EpDIzSNAWWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXT8/90U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXT8/90U"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J92AOc025672
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 10:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VqRNS/AP2L0HYV/XzQMxzhswyBS2iB5hSp0sUNl5kjs=; b=nXT8/90UtPNYFOVl
	lO89wI7YQKOORwYNbXDwpUcHcHCYJEEnnNE/d2sZ5vcwuHD1lFP11G1pUGwuApvn
	crn7cvzPlakbrP9FtDv28Tme1qNFW5ZXiRzXro63fVro/1EzE9y+ORx6CdZU5kVi
	rEfcFJbXwaegQ5suYLTplGNyNMYqWGlfiH3DZS897k6cc/FtEa/We/gu8MTjqb9C
	ADDaqr8EiaX1n9jIdugSl6TqJSdZ0c1Ye0BZhms2r5FATXD1L/q5fPAZ8SoXha6p
	tBpVWX9dOeQB8usjOVYApGbmeeIfE4fEajD+zFGFF4Z0ZoRp0tLj8e/dMAwXwI6X
	kbx81w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pju7c2xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 10:58:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f8ae0417b6so76296786d6.3
        for <iommu@lists.linux.dev>; Mon, 19 May 2025 03:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747652329; x=1748257129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqRNS/AP2L0HYV/XzQMxzhswyBS2iB5hSp0sUNl5kjs=;
        b=jHDZnGGf7OJu33SlJfX11YBmN2l+A/fHNpFIwkWO6MwQMB/eRXkfLQtgvHYi0nikwR
         L9QyMoimQ7FxgXfB1KlzBcWFKGovrA/tez7zhAnCsJaZwQVZ/hcjqCzQghn0jSMFZisu
         0PvDBThx9ygVSwATgkGzIj/bPeMRXxKsluSL4IJFeoWKa1RjPcLyVfH66JYjJ2ApkgYw
         aWNcUslxWJypSOfINHDD0QAkUlhniFmmIlhlnxdzBxDRpEq5HK/16O9NpM/fPqmmc5En
         Y36ZbGt2BOVUaw/00V6PIyfdsVXzd3X/Z5iJzc6V7qMHuTSaUZhqqCy8/YNCcj1ecfW/
         BPYg==
X-Forwarded-Encrypted: i=1; AJvYcCWRYHho4mRHcXJj4kr2UtRBwZfuI7yqn7l4oD/jVCSzhp6DwJg6weZ1mNHPbBlFVnh1OUmIYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzHaS8tS5GphzAdgKc+oEd15Or8jt88ZKR3yUT+TVG5ByCImfK
	0WynCyE2MZzOao+pmtAj4ZXJUM9JtmC78iHd1xd1Y+ffXeGl1vg2uv+4UohfuJpuIksqTXoGRFK
	8457YcjIF8WJpSoqfIAzFRIFO66chOUVZR2wtpC818vK8NykGN2OYxLJBUQ==
X-Gm-Gg: ASbGncvZZuvAUZWi/blFLx9c2FlsWWdmomPlMZ8b8cSfqPCc3poMQl3w81aBwn7GAqa
	yxGWUzoGP+PYN5Z5aYbj79ZA503D4kMlfjdObgt1M0LkxFSwP9mZnJhceVTfuZloJvfy23SKnuC
	zHgenIIcoj3MGr0oyVAgm06xC+eirYOMWABVET29LM+aZ2m0xL3DbSlxHDTsypY7OeFRNOSxLh9
	mt8FTrXAo8xvbX4HXCJ2J+KKxdrG4465cvb67DW/qWNReNCiGC/icOWxx8MxAnMV5sxVYD5Btyj
	L33R+M92EUJpcZ4B8E84l8j94rXz7o361liLCvb+fXrNT4QG4cahdXt9QxWTC/tQ3KBsCUeGTOs
	twZ72TwedrA60ILiTWON5ADgq
X-Received: by 2002:ad4:4eee:0:b0:6f5:3b8b:9115 with SMTP id 6a1803df08f44-6f8b085299cmr198058166d6.33.1747652329552;
        Mon, 19 May 2025 03:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ8hMq2kgsgTEUTk7YggTkRUuA47iDtbotHwLHe0Dgywfs65yOnHSbIBuW35N62G91KOkcXw==
X-Received: by 2002:ad4:4eee:0:b0:6f5:3b8b:9115 with SMTP id 6a1803df08f44-6f8b085299cmr198057586d6.33.1747652329096;
        Mon, 19 May 2025 03:58:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f314a2sm1801140e87.77.2025.05.19.03.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:58:48 -0700 (PDT)
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
Date: Mon, 19 May 2025 13:58:34 +0300
Message-ID: <174637445761.1385605.10286310480029078025.b4-ty@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=XKEwSRhE c=1 sm=1 tr=0 ts=682b0eeb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=iEGPaXCqe01J9_RIJz0A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: L1_LrRcLrpHloQcNx79y6jjW-x-v7A0d
X-Proofpoint-GUID: L1_LrRcLrpHloQcNx79y6jjW-x-v7A0d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEwNCBTYWx0ZWRfX7Wm2EUS4GpHX
 1iRQSnPGYMo+KcdNUmYl0oMbCmqvK4zKjheAu0+Bb1u8lCTIDzSAbyatIO2c3T8xss7z2myY1yj
 GOLyCL5EZMetn7jNvp5tiKw5dMspqVAXGXFdkjc9/GQix9WI/3RtdXwLe/YeKET2e+eEnDI0HPy
 nYw99Cy6TO8BirKswJfgH+3q6HgClIYCegUHli1eGRUJ0WB5z+o7+ry+qhIEBAC4+FJJoFpzntX
 adtCTN/TXuAyiwGDfT4F8HyLoD8g2WiwoVfwiOBfvZE8mFARd1xg0xvH5GRRDKn8sf2K+PQbyRa
 rHB/sgBBHLUqLVaB7z8XvKQKV/6Y5tBNduPdSzxF7L6g8zGN2w5gQ8RunJTY3ypi/Xq/jPeiQxn
 +gneEUruS1AZqy2evBJ6MuNau484SqFWgo3ydVi1/+9Sfzyiz1FRWSKwhKdbrvalueq8gvqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=919 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190104
Message-ID: <20250519105834.xjGxkXwkJmI-2_sh13CmR_TYHyb7aRBJYd3-rigd0-U@z>


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
