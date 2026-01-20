Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B444A72F
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947989; cv=none; b=MdvaOyQZ6HenLdxbzE9siRtI8mtu7qzArp5J1C8xcN2GTjedcec9FSrlB8p3AGAeaunW+uOGamNwyUl6meDXcZgBR9tvSmSDw5QAzA83oEVAxplvAoZ89xCy1TLAiVj0GLpxhKjei7AKMjhg63Duhfcw2ssgXn0jn0ziB3M8AF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947989; c=relaxed/simple;
	bh=+AjOHVFzafAxyNv7kFoLLoEDJ5x3Ho1X9GPgsA5PtZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiM3La5P/7FR8QLR0u0gZdUz0MtlkNISFVOSM4iWhRGFfju445JkDEYC2NnTzAyb5Dlvzc3bOQrJZYy010Q7MM48AinVdqDuy9hM4t1SXP/zHNAnLjXZecLL0pxl9x2yekA3uhfMcuRY5hH0lCwNCt4OqyxM2lUcOvSK39tD/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uq1aKteu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZYlzgcFF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uq1aKteu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZYlzgcFF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KK06tY797938
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 22:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=12m2xvgJzDqiJreuY7EetpiV
	ScySOxRmwMPypQhBiRc=; b=Uq1aKteu47PUQzhdxfFj7EO6snCXAim50cVpMhE4
	lw2IzTFCoAZcdYOJQQ7+u2shTUiCSxqeBRvsxCO7RZLFDh8eYm9mxgiCiuglsdNB
	q/yvkrlBCzTvLuO5lTbYPQZ2EyNcyKzR76+GLFRsNWOVISDHS1wGppYKy2FCD/B0
	ksdH+i7yWwMV4Cujf1h58voGin2EU2PNMMTR5CURy3/hSqtsF6X3ZJ93qfFjUGCN
	1IF9uxVj6JJprDlEVPjPoFeIehkdDHphW7UeoRsX9gsQ3K9idKZFkqsVEPle/0w+
	wuYCYnKKZVjSq5gRdxaFT12r0u0HYlewIgBOfZqBoooj1w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bta6q1v0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 22:26:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6a289856eso142203485a.0
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768947982; x=1769552782; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=12m2xvgJzDqiJreuY7EetpiVScySOxRmwMPypQhBiRc=;
        b=ZYlzgcFFv5pglKZ7XH6VgE3NMGVlsLHcurQJjyYUJSPhi43AuARlG0iJoMJCSlpryh
         ryIX6sPGRG8rTmGbxFkjDMC84OykB5Jid/NImz/U1xjg71vSaPHGHmRfGCBQsL3liMJn
         Z0fzJpVaQCiIzX09FhtTIaPajola000MHBqp6Sc3R1hfAR+L6NMb+EAF6OY0cwc1/rlz
         pvIG8raKl2PZDG4u7VxsKbipCSw9MrUqfbdApStsmrbTTg/vTKslhmb6MWnBLWUAizSa
         +5aahZeJp1JXNsInb8RtIlyt7jMupbJjQbGt78Pv+vbCiWxwCrRxlWvnsTSwHLjqjZqN
         t2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768947982; x=1769552782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12m2xvgJzDqiJreuY7EetpiVScySOxRmwMPypQhBiRc=;
        b=WLE6/X1FfY0xI6Cd0+W4EQLUBH4LBKuEtWBe7N38nq3KM3apyTHQ1CaE5csTD91oUb
         grsUTLrhf1Xe2Bw1WQ0LWFIOyWlXifAtf5SvTSnFiXlWaVg2KRg4Cr9uduXO9bjrZzmQ
         EYVVTargYcjrMdrK32ldFvd/YOcNAezyx3MYhzIuWDP3cCiqtgeRAui5IEd1YXiZv1W3
         3FExfNKVnMpa0QIRm8SBP6+TLISZxZ7JsmN99tCXTi1XsrBtHpmIBVEXG1t8GkryplDX
         no+Se0+ii/O8a3EGy4ElAvvfnLWSbFMr9MunG2m8yjMWXWf4tVfIXhbLB71TRSnPDEhB
         1+QA==
X-Forwarded-Encrypted: i=1; AJvYcCUCyuoicgtKqhQ83i5Cl+1jEM8svhEo8Z5Y+VYOMNQSr1agGN1ECtFjlYSYMnECAsKScD8Kow==@lists.linux.dev
X-Gm-Message-State: AOJu0YyD5uj/JQL00XgkD7xKo17xTWeJ1NYugJe61Cyr34eg0iNmBHX+
	3YHo/GkXbR0QsuaSTI0zM20LmE3H2vAKzDOmXPIfsIcABKkWc7PiJ3WKcVh1I3Gl9svYiCRvGYu
	/HZRlFmd+pf0RTdx1X0tElt8nG3FvFA9W/7ACm+gVwXgfINytCxxGgxMaQw==
X-Gm-Gg: AY/fxX7rr3oOPV8c7ftiYKcgRJvJ83m2eK2PRlfAiC2BuyjbTt4QqKNg3PaJWyNb17p
	DH73WsqPKfw8MvK5cyZlup0dzky+Ry1gGEC3Frz+YvaEj8CiEunZrmst+VbY2Jgylbho8RNfcBG
	V/vtQf5fWyIUjLc8g3pQV2g3beMjDMddnQEHmoGZPi8vjC3ZmxKrFYYnTBsXtf30Mf7IZT5uHD0
	PCE2cGPc7REEbnWeOzfxpx4+8itbK4OunckcdpJAxr6akVIbwv/+h9/Kt3JWzMdx8ycLoPLgH5Q
	gNB0s3yPedHOanOTUPtK0NSWBwFnhIhr/oz1AGxPk77reRJQo0QbPFdOEwwREFZYZ+9Qq1SQm3U
	WNo0jnItazhpRTcbv4FYGz1MA35Gl31I5+QBkWHaT+9Q9gyDCa/bJ1Le5cCdqv7UekDl3zjGYsk
	+wzFpNviN7UEwrU0kJS03jOaA=
X-Received: by 2002:a05:620a:4114:b0:8c6:a64e:f66a with SMTP id af79cd13be357-8c6a64f04camr2155763685a.21.1768947981604;
        Tue, 20 Jan 2026 14:26:21 -0800 (PST)
X-Received: by 2002:a05:620a:4114:b0:8c6:a64e:f66a with SMTP id af79cd13be357-8c6a64f04camr2155759285a.21.1768947981130;
        Tue, 20 Jan 2026 14:26:21 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf34d572sm4303193e87.24.2026.01.20.14.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:26:20 -0800 (PST)
Date: Wed, 21 Jan 2026 00:26:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: bibek.patro@oss.qualcomm.com
Cc: will@kernel.org, catalin.marinas@arm.com, charan.kalla@oss.qualcomm.com,
        iommu@lists.linux.dev, joro@8bytes.org, kernel-team@android.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robin.clark@oss.qualcomm.com, robin.murphy@arm.com
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Restore ACTLR settings for MDSS on
 sa8775p
Message-ID: <ctdfmzictrjcwugv66hmk5pouj56qviy5umdo3yrmhvfexqoni@kmtozbt53sdv>
References: <20260120151105.614792-1-bibek.patro@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120151105.614792-1-bibek.patro@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=QohTHFyd c=1 sm=1 tr=0 ts=6970010e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=kvr8ZGpsiUTQIvHu6H8A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE4NiBTYWx0ZWRfXy+smgbKWAetS
 liPkuJk0nvrWDhfVCMck20I7relqutjPcBSHoE35JLcdHCdl3C0xHTaxATk135K4/2uvVDhPLYs
 12akYtW8+nH1LhcqNyvtUSo9VwupoxLp+5qCj1hGPHGeTTBIbX/ZFKe1GHZwqvdDLZo+CZhJaVW
 xzIRFWRUti/+2XzLlO2UPFkj3IegDvLZmnC8BZTyoHkhBTRD291T1bPPWYMlyazSaAvEh93sWpZ
 Oy6RS5hPpYfWzZ005gw8RW0GY5s/V++2cUIPCVm5vY7N1+4qwNgttT9XvSpH9kzIeet6v7J0ZWh
 HwV+WdwpgTflndT5qcgLjW55xPEhCqUvQhc3AAKx37ADOMJ+e+yVhWMghEPbadq27O1yQsG3Ou7
 cp3j+Kb1d8fkOq4Q77bqAN1qwQcJmdMguPciMEHdZYWAnpMVYnAzeyqghiFsjymJy2GQc+Cns5O
 fD3P/pbJ3LbEAM/Gx5A==
X-Proofpoint-GUID: n89yvSRITRh4rcLpYdIo8Pn1OBYgEmc5
X-Proofpoint-ORIG-GUID: n89yvSRITRh4rcLpYdIo8Pn1OBYgEmc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200186

On Tue, Jan 20, 2026 at 08:41:05PM +0530, bibek.patro@oss.qualcomm.com wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> The ACTLR configuration for the sa8775p MDSS client was inadvertently
> dropped while reworking the commit f91879fdf70b ("iommu/arm-smmu-qcom:
> Add actlr settings for mdss on Qualcomm platforms"). Without this
> entry, the sa8775p MDSS block does not receive the intended default
> ACTLR configuration.
> 
> Restore the missing compatible entry so that the platform receives the
> expected behavior.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Missing Fixes tag. Otherwise LGTM

-- 
With best wishes
Dmitry
