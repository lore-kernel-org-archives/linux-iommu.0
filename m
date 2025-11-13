Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4FB34F481
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036582; cv=none; b=WqGr7x7iS4OVND+937bkU3y1S9uzu4ZdAUyiitgG3TSVCSu8sjudfdt1mluyZ0ifZTUHqHdD7+jRsTcfVBTO0sqRR6RZ6PPyOtP8SbQw5E9IIWmL0uXm8Pegmd5pSfBDamTgowbrmnpCAQmaYporbxCKzoLFw4zHl7oq8WslkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036582; c=relaxed/simple;
	bh=qN/E6+YlVkEM+xSihEjX8Nat6/Mt4w97aH7S4tAGH1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEmsm1KhRW/+7MNetR9v3v6GhxCTHpGX4Hyxb/Fe2559+/PDyISkDwmmCPWkYgg8Lj8STOPn4qeuQRp1xsOg3689SSh/5QJfyVyoZnZ5gIjQ00+fnKvqknatgpu+DDSEeobF2LE0u+mGCGmkGJ0PxbH6D9sDSecNmuw7d6xxP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EjxO0CH9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EXX2YJ5P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EjxO0CH9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EXX2YJ5P"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8vJLo3113231
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 12:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+GplvHX5yxJ933q0AmGSwv5z
	wUzQHMR7HZka/BgtTp8=; b=EjxO0CH97Q5YXz86h/exEubfja23O0cpfbonUSFO
	/EcgGBaDegu0X6DGJ0COHg4/Cv9Whk1CLhs50au+g/U68OYvdjxcYC7LRDJ10C7Y
	f/4gtfgZN7C92XuqmFmkUcBwU9m2tAFrbdOOV1rXoz4mAE44i7oGgN6ulNcyb7Mt
	q66lH2BpsdMtxD7wn1BvJKKjaKHlpW9IlRPOV/mfcG9X6d6ayeZNAUG/ZyFFnqiP
	UdsICNQuFKz/CIksK0/8U4hHosXzUZxZKMw3QchC3x+3QITrrMf08zLIsSgcQCtU
	MNNLvmSf631noRe0hvxaCyRjP+8cXcDnfCQpru0hatbOCQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuw4brwm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 12:23:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edb6a94873so15646351cf.0
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 04:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763036579; x=1763641379; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+GplvHX5yxJ933q0AmGSwv5zwUzQHMR7HZka/BgtTp8=;
        b=EXX2YJ5PUoFkroe1bk5UeHNYltLospmj7ocKrY0Ll1KZovgPNIG3Fozp9uLi4fzF6Q
         uusBBl+y+mYv9YnCaQVpbq6H5+AQGiFeHtKEaZ0Z4ThQxCoa/zjYdEdtS80/j4IcQZ7j
         5IH5InvZNnv6Tt6YnT1xliuKKup5jnaGwSKTwacc9tu9sS3ZpdzLOxwE0TZ+/XgPYzFv
         JebcOuC2unwjyKN0sIhFe5fS8HY/ymt7mh1J9pkCHwt/RQdrhWNeY1GvPPrS5/3UWLFw
         gVSBae9YWtQIdW/+kQ4jUq2BhnwFqRpnDq1qgQBVtHW5sXx7Udeq42dxjuVdd+EKnsDD
         FFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763036579; x=1763641379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GplvHX5yxJ933q0AmGSwv5zwUzQHMR7HZka/BgtTp8=;
        b=R4b/KtVdsPinVlSnAt1GhgTxqJJ29CEb2AQgS1Bs1RgIqYeevwlN8k/GAITW1GcCoS
         bGpLTLEPedSdxoKdKy7Fs6pdeugrii7VsvRf1/eedMWMAV0Ux/p8f3JsCzAQdLaI9Arp
         VK52j7+m2Au+t+7Suj9N9cEhJDvzdNDLivWgyKlZwZi/KBD3Uskv7RXnVMwTz6LoheJK
         rEfPPatqtCZ1+oHI4Ie+DIMrWJ3hOnPnNsJnW/jlgl3KT4ThqectPt3aVAaO8FJ0w45O
         IpfqVG6UwFxH0Ms2MgC4+ZJr7uI8MnYETMHYrHC6sXFYdjSi138oF6HTRkA9IYL7/oUt
         uKjg==
X-Forwarded-Encrypted: i=1; AJvYcCU3uaEXyNuusNCa+ZLqrZg5fLSEjO9Urz0kZp4W7ojMjakxjrYiUqFaiamwWh9q3zU+B3v9PA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz56/N7D7HNsZiKLhOlsUJAjEliKwv3dEHfGp3kSDZoNCsYoQHh
	aIJ8PlwHgDYfv+XTvdBe8tqr5okt1NiSwe/cWj2+3E+drNYgGemjABKqoAaOqDuDw7emsQ42X0Q
	bhOATQNM60mTCWFTld/17xSFuc4uKhK0jjWhTJZpa7WJERiI3CUECO0jsYw==
X-Gm-Gg: ASbGncvB+v4mvcEdwfLWnr+LyMYiOeelPAzafJxPnQadsCv0e8FXa8/FyVmcBoY6JJp
	FbrwMsCCePeizOArrHd9dKf9IsmooeRzCBdrNwoEV7GTq5bTcRlir57xOc+iuQ8A0j6e+Tffevk
	93Qmi4yzXgKug48RLtKzO09pl2p4Yz26QUpFD43gcBNa+1LJGYVxkfCSFGu8OE5ODoTfmOTBlRw
	KXaI9sf6y1CDljVdwwA5BGD6HYuXrpocZp+SLA/Fyv/p4B0atVBfkQea6VqCbQdripC91OxSAid
	kne2i+RTMsC6vktoW4ufkmYPYmsdd75bHuB4yYO+gqwIgiUF9b2q4PxBvU5F/EZ+LLcVnt67yTb
	W5NMgfb8E5fLrF7AiEljMiro2dbEXERBaGOXxfSfblLbXmz2kfqjV574C/j22NzpG/L1Kt7y75e
	bU6C80Mt6goB67
X-Received: by 2002:a05:622a:24a:b0:4ec:f5cd:8721 with SMTP id d75a77b69052e-4eddba97f18mr79916861cf.0.1763036579316;
        Thu, 13 Nov 2025 04:22:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYSlJ7Mqnq9Dyf5Mj+nWkiUVIb7DVf2qG0ZIWMq78bytd3X9FzuruWsSqOGP5mq4NeoWsUsw==
X-Received: by 2002:a05:622a:24a:b0:4ec:f5cd:8721 with SMTP id d75a77b69052e-4eddba97f18mr79916231cf.0.1763036578763;
        Thu, 13 Nov 2025 04:22:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803b4d70sm363916e87.39.2025.11.13.04.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:22:57 -0800 (PST)
Date: Thu, 13 Nov 2025 14:22:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
Message-ID: <kwf62e5l5n4pwfmetvhicupj7r6ow46dnlkkluyhl7s5wuazpw@q7vbdi7d6ul3>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
 <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
 <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
 <os7rpbynyoeolwvbrocx3yrrxzhextx3srywal2i54jj6dw3mw@n6fbt3pzjvj6>
 <d87bea02-1a89-4854-b760-617c3655b287@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d87bea02-1a89-4854-b760-617c3655b287@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: qVqkVCJUzOLcC9nWJlL9i-Ded2q75VAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA5MyBTYWx0ZWRfX4PF4l8F9cmw0
 XKEC02JfNEB4QrgYJ1j/YKTtDu+5JhZyJIBex6QpjzJFoGcwvf2p4NEVNDe8yg17YlZ0CJQlqex
 VD3i//qZtObY8kK19e8a00wIJE2PhmHJgapdkXaIAYO2OBJc2H7GafL7GGnXPT/gzAMLruvRDN7
 sZ20pAIHB3Gjalo5lsPmib2G0IZGsiWB2BjisVAeITQsIZoSenYMkXYkMQwYJric1IhrdxBy8VJ
 O21+kLm9XEX9wvOyzNpaz/GLsnzKoQjMNehl2EWbf9fbCr4dS3yyNNWIygv7Wqu94o+PFrUFAKy
 FLt7+yL9YPUIwQUKGG6BBLnAn7B3h04BV+AKuxVJ5LJwPi7p1KC7+k4fqHQew+fBWErjOF9c8CR
 TtmslvIcdKE8kICz9/5I55O3Qlg2rA==
X-Authority-Analysis: v=2.4 cv=F+Bat6hN c=1 sm=1 tr=0 ts=6915cda4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=LPoitUEaq9Ymm4AzyX8A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: qVqkVCJUzOLcC9nWJlL9i-Ded2q75VAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130093

On Thu, Nov 13, 2025 at 10:27:09AM +0100, Konrad Dybcio wrote:
> On 11/13/25 4:38 AM, Dmitry Baryshkov wrote:
> > On Thu, Nov 13, 2025 at 03:32:51AM +0530, Akhil P Oommen wrote:
> >> On 11/12/2025 3:52 PM, Konrad Dybcio wrote:
> >>> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> >>>> In A6x family (which is a pretty big one), there are separate
> >>>> adreno_func definitions for each sub-generations. To streamline the
> >>>> identification of the correct struct for a gpu, move it to the
> >>>> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
> >>>>
> >>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >>>> ---
> >>>
> >>> [...]
> >>>
> >>>
> >>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >>>> index 44df6410bce1..9007a0e82a59 100644
> >>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >>>> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {
> >>>
> >>> Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs
> >>
> >> Could you point me to the holi's devicetree? Currently I see only a610
> >> (sm6115) and a702 (qcm2290) uses gmu_wrapper.
> > 
> > I don't think upstream was ported to SM4350. SM6375 should need the same
> > hook, but I don't know why Konrad didn't enable GPU on that platform.
> 
> I'll try to fire up -next and confirm it hasn't bitrotten.

Maybe then a patch to enable it too?

-- 
With best wishes
Dmitry
