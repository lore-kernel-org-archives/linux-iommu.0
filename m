Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB775625E9
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874154; cv=none; b=jUpJ+EMMgxZehi5dwODRv8HrjbcedD7Pg0Z6H0MMIoIfb1MT/Mt3+V82IoUhaQQsxNVfqIm3MQEyZj8ObuofuCG9tBVkJz16J0GAM52F8e3rorBM4fO3N54HqML3CiT4cZsKo8/haONRhf8Nbnk03rWYudGz7OjQn/AbKUCQstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874154; c=relaxed/simple;
	bh=k5HCTeqFbMi57vKLkj2X7I2avf2P/QWPZAnpsRan1nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQfpZicW8215rlNgz1LwzW5oiF23FM1cV0rGbfLbxiyF0ZtKtG5ishe3xCkKbvIfuaiFQXF+TiB/DIcFThaIipmNfiWsr7GSbxUIo95/FviJ9g42OVIwyPEOn4w1zlvEX36eDfvMpi4UtSOK5qgrkSygBvAuMvs6nTubaBuG/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTivlwwr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kxtW2+Z7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTivlwwr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kxtW2+Z7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688CkfDv1807599
	for <iommu@lists.linux.dev>; Tue, 8 Sep 2026 13:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LvFFq7I3YnVJDfVFV9SMgv5R
	NwImgPOEhF+SmMTxkq8=; b=NTivlwwrnwlzxFRnUFxldBN/eOUOXanZpJrDmPEi
	PwFbeBqjwtJ3WRLAj5OqONcO+mFxHFzzc5RmULIGhNTcKj7vCGvIMZvQEIoqSQyH
	XnqzHAyH7vLlzZz6u0lpYeCuuYq+mkpv/8zdEzG4FlEH4hHLORky7EqyC8Tjrvuj
	cUz39Om5GnyznOOx91XC3O0rEx5ygfwg8oHCYsl1Eu6SowI+pxlq8tuSjJZmFlYU
	WQCPirjuiZra+4zo1RYOMB6VcbJtagVF7dVfLjRYUrXOtt3j8wPyXqmGA6e1u7YP
	zTFAMt0hNT9nCtx9AEXYZbwNCiKkhIOgkfNOdGqYWvr/1Q==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcrp9py2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 13:28:57 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97c3796d17dso190801241.2
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788874136; x=1789478936; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LvFFq7I3YnVJDfVFV9SMgv5RNwImgPOEhF+SmMTxkq8=;
        b=kxtW2+Z7ZnuyhiFOABao54GwpWzFowZLQjfXi/P+zvz/YJ4BVgOlM/5zpx8PBElmo0
         UPhWlpyLV7Xfl2N/HysTTXo0iRjpOtHweC3BNUMVbnm/uaHFaoAtcYMI30wzgKI41XIi
         VPLVRe9yDFuR9pdBeh1cdjutO/EIDk9NOWGx6xpun4D7vZAUWIDVILDESLzCIhMGjSwX
         WVPCOGVMC+3xZ5fcrdtP4NTptuUDEHcP79b2WlokXYWe2/MYWwwNqYw1mwArf1VoynnE
         9ay+ovPiDOIGLVywFMirsNAd2G0fHONe7buWK3u54dCQifw+buhJ0ck2dmFk5P2W3p6H
         cHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874136; x=1789478936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvFFq7I3YnVJDfVFV9SMgv5RNwImgPOEhF+SmMTxkq8=;
        b=AFkLl1OvJAUPL2VRIJl7c5VrwPvyxqjEVkc5hQ9SDM+JI93GaGxn/8ngFiOGzSsFzF
         mfh+8fISy10+4d8CqkT6s53RbnkXC65j7/qf4s7w5p1YxmNQwayQTxZ9nFbJQbyhf9uT
         ZfqYU/2wLo+lZ+cLQl30/XCWMDvyU4Y1xrcPqlTTet9dihoXQz9VW4dEAhp5PHShV5KZ
         wL7FdkwYoBifaJGySk77BuaOPGEJv+0VsXlXZgCvAUGtwCc6S8qdFMAO3AJf0r2FeE0L
         S0XWzn7sMRlqSccWGxjKWhzBFW+kcMlei1QzDaPENuY2vUzJ1oCVZqetjs5oxiQD8laQ
         lSwA==
X-Forwarded-Encrypted: i=1; AKwUvBxNqhFYX/Vk675xflSpeS1GvI6LDlFTRgQWw9SfJl9aqYJWAz+W5G6krQXYuMcnuCGhGSBHrQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n06kKKpCOw9cBt3N40sfN5zLX0S8HPoG4IZiuuwYC6m8vFQot9
	JDk7MlEgyMRLzh+hI5a10lsz4cQEi2mRm2egwgxDxRef9l8BgcYVF0MEmlqMqI4/gUPhoGROn6S
	oPQSgZ9FPXpywQkyKiEKq3VBf4AZRpIx7u7l9enI8J6WNnIx8gpkUTRwgAg==
X-Gm-Gg: AYBFou1tryBP6cexTC54ApXvQf7YFSuflm43Q/lDRDCPa1iRL2jMeMcStmRxcx0uljP
	54M3de/uu8Xe6dz4vkju3xep+nPvUefxjjbtS98/XJ2FjqCxdknV0X/5Q+bdjdfnKi+NU2NTYTo
	g7EGXSaJBaNvkh6ewliB7fYo98n4azVo+XYO8o53XnrzEEgne7DGv6Z5sRc2s+WMLc+CDE8snEb
	co/A1c8cfl8Z34VzS0VzGmWyNu9nixXoG/lMFgXPGH3LrDVsYWxYpwI0pQojJwe3sBwgPYbgduy
	QkhMQCblVa0IUNXnZLIlXFgvZk1IP7C0+yV1KU0l7B3n4ONc6u8nfceYvQ+Krr7qDQ1D7lP8/3o
	6fPrmmQmMGEV/M/GR49mt1fGXB8sf8QGIsM44mDeNKAgW7IDyUE7NVB+pbrHnhPu5l1atVjL8sW
	T6vRarcjjUpU0D
X-Received: by 2002:a05:6102:4409:b0:789:56eb:39a5 with SMTP id ada2fe7eead31-78a4a836e1amr8346233137.5.1788874136321;
        Tue, 08 Sep 2026 06:28:56 -0700 (PDT)
X-Received: by 2002:a05:6102:4409:b0:789:56eb:39a5 with SMTP id ada2fe7eead31-78a4a836e1amr8346200137.5.1788874135747;
        Tue, 08 Sep 2026 06:28:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166ed043sm3118098e87.24.2026.09.08.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:28:54 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:28:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/12] iommu: qcom_iommu: implement support for instances
 on MSM8974
Message-ID: <ssleznoahzs4wgf5irjiagss2rjwl2s2jjnqrrnlpp74rdkgfs@au6x63ykyjfs>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
 <DKL6P7G0WTM7.UJ6KZERQZDFK@fairphone.com>
 <iv5radfllym2bjvkrdu4ffs25bqixyos7k3ymncpcdtc2uobn2@zlhsybrj3pwz>
 <DKX384NK76OS.3NNOMAH72PV2P@fairphone.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKX384NK76OS.3NNOMAH72PV2P@fairphone.com>
X-Authority-Analysis: v=2.4 cv=UfRhjqSN c=1 sm=1 tr=0 ts=6aa00d99 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=uEsHIfJi1mZuTdkiAjUA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: bCF6GC6koSyx8JOs0kxkQbwSc7Diulwj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0NCBTYWx0ZWRfX+JJn/2Zy5kqj
 YP4T6j/FzBm+86GPNFRIW3UoyWHTrTDTDWKmdEGkxFxGSNCGK9OajHtlEe/PeGS2WxmfJZYycIB
 WV9pvnA6VrhOvglzr779RTCUh3FyxIRs83OTTH02Q/J/ZjUx0YAPsdttzHyQR1G/yTMPs+4Ij7d
 x1tO9lmS4kwukBPO8U5tbDWgCgeJ8jf2XQVHhq1qEIbZBgk3/tMhobZo1wqBR2e0UFw5FM/6nLc
 oZXvtQPbIOJpS+GCh0lEfGSg2z/8ALceBh/oOynSmna/9MwdoignDyaD4Tz05pp1IuZzXMr1laA
 +VMzm4VGnEJzr4aDZL9yviqlmPQr1D3Lki/iC6a1qFZ8gz2Dki24k9xV67rCS733HA6SV48nl0C
 OUGn/1+8M6PkQOVNgJ1oZqVIAZHsaRjwA4ld4sNxPB436vXZF+QBit11SMELpPC1NOMRcvJOF9y
 r0omCkoUZZnrxMiXr+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0NCBTYWx0ZWRfXwYxR/P2Z8216
 To/GhNSrEiNoi/Xzt2gxJc9VpDKkagrug1BDwRC9aMfz1K4GusFmhnYN61M6OF1sN0oTEF0wACt
 8qjj0ITTXfctWANT9p1G+VBkoU+ugEY=
X-Proofpoint-GUID: bCF6GC6koSyx8JOs0kxkQbwSc7Diulwj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080144

On Mon, Aug 24, 2026 at 12:04:57PM +0200, Luca Weiss wrote:
> Hi Dmitry,
> 
> On Tue Aug 11, 2026 at 2:43 PM CEST, Dmitry Baryshkov wrote:
> > On Mon, Aug 10, 2026 at 12:16:19PM +0200, Luca Weiss wrote:
> >> Hi Dmitry,
> >> 
> >> Many thanks for working on this and sending this patch series!
> >> 
> >> On Sun Aug 9, 2026 at 10:15 PM CEST, Dmitry Baryshkov wrote:
> >> > Qualcomm MSM8974 platform has five SMMU instances, used by display, GPU,
> >> > Venus, VFE (camera) and JPEG encoder. Each of them follows ARM SMMU v1
> >> > spec, however they differ from other Qualcomm platforms in the
> >> > implementation-specific registers and also in interaction with TZ.
> >> > Venus, MDP and VFE SMMUs are secured and require programming only of
> >> > CBs, while GPU and JPEG require full programming.
> >> >
> >> > This series skips IOMMUs which can't be tested right now (VFE and JPEG),
> >> > and adds only MDP, GPU and Venus (although untested, it is required for
> >> > display to work) SMMU instances.
> >> 
> >> I do have a patch series (sent years ago to the mailing lists as well)
> >> for CAMSS so I can definitely test this in the future.
> >
> > Ok, let's land these first, unless VFE IOMMU blocks display on your
> > platform (Venus was blocking display on APQ8074 DragonBoard).
> >
> >> > Note, to get display to work properly one fix is necessary, [1]
> >> >
> >> > [1] https://patch.msgid.link/20260809-msm8974-mmcc-fix-v1-1-50f2dcf18d2e@oss.qualcomm.com
> >> 
> >> I've applied this series on v7.2-rc7, with the extra commits between
> >> that and linux-next for qcom_iommu.c backported so that your series
> >> applies without conflicts.
> >> 
> >> So far I'm stuck with the GPU not being able to probe, adding some
> >> printk's shows that in msm_iommu_new() the call for
> >> iommu_attach_device() is failing.
> >> 
> >> [    5.971154] msm_mdp fd900100.display-controller: failed to load adreno gpu
> >> [    5.972991] msm_mdp fd900100.display-controller: failed to bind fdb00000.gpu (ops a3xx_ops [msm]): -16
> >> [    5.974073] msm_mdp fd900100.display-controller: adev bind failed: -16
> >> [    5.974152] panel-s6d6fa1 fd922800.dsi.0: error -EBUSY: Failed to attach to DSI host
> >> [    5.974230] panel-s6d6fa1 fd922800.dsi.0: probe with driver panel-s6d6fa1 failed with error -16
> >
> > See the patch [1], it's picked up for 7.3
> 
> I missed replying to you, with this patch the display lights up again!
> 
> Unfortunately the GPU still seems to have issues, I don't have a log
> right now (I think even SSH was dropping then with a bunch of log lines
> appearing in kernel log on screen). I assume kmscube + more complex
> workloads worked fine for you?

I was mostly using kmscube, but I can try running the CTS once I get
back to it, sorry for the delays.

-- 
With best wishes
Dmitry
