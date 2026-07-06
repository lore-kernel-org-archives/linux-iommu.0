Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C53FF8AC
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327468; cv=none; b=et/T05Me7f8meVOzCiTISFuNvdbI0gTgrs1WrdhKWkXIpiboP0XTXnx3ivZkno7LYuqcB+2GMWH1ru5lhUvDJ0e0dmAgfhmLlILGhtUDo8dFQWve/vOXNcEZcIZxS35dec15XOzos9zUW3hGzwDyFi3aFfGTk3XO5lfqDkATd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327468; c=relaxed/simple;
	bh=oK0NQYPrvhisX4lCBFAC7QmI/WS2T6aMcGlWsYUvpP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tm0lgxQohwhH4zea6K4MywxVVJvI23Ujie5BJ/Bzyrb8ijRJVBuIgOqXE43J3sncEXznpst6a6Hrik9b7MCXjKXsNtW1Q6OrCMzmJAaY0/82c20idDCI3HIlH63V6DRE+7oeg/dCkekza1P80+7OwkMEAtdnaads+zkAxhSPxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WBg5WWbV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I1mdNDck; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBg5WWbV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I1mdNDck"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641Z3i3617472
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 08:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z7ewoKopFZWDSHXaKQpbm185Ui8l9dwnR4N9LGUyBmM=; b=WBg5WWbVCp2776Y0
	GL5MhGPOmGbuGB1bYx85IqFwSE/YFbWe0cwzCSx1i3UCsmY/uYq7VE5bvpvbuy2S
	cog0YFdB57IQ+RCJd5CjP54/2i2MDUtgcHLzY12hTt4iWBp5e7t54UzUxGucerVZ
	/OxxEHL/x2bp3DLwZLsCk4+HjNqFxcz7IPRV+cTW/6XjwnGkHpGyyCK0gAEnBlN/
	mDVZaZXzu6DT57CTUO77jc6AfsPXKofcXNOrlfdPrqpRTduzHt+66mSlxaaa9Baf
	AzjJR72lfUpiZHX1GVfYSkEUAavCp9yE/QHVdWMzPC6naR2UTdk5ArV0wpOixKxc
	ee/SAQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64nfht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 08:44:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c298a1b20so5811181cf.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783327458; x=1783932258; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7ewoKopFZWDSHXaKQpbm185Ui8l9dwnR4N9LGUyBmM=;
        b=I1mdNDckt2TsHlgPdVZP4+3El+Ujfavdo1BeBcfzKZ5P85CLasdvf4pHcEyOsuF87B
         uV+s+Vbiwebq53Igdgcsa9WdKN2Y69bTNsKoKkGpRTabQYrAmQRlaFkiDYwqfsrZqERw
         SfhMk/Xpf13yNCo5+3s2ybLSTfPHT0R6oFNjHyEuGhJsk06lq3Ap5L7mK38XZwQL8OR2
         QOlIUHhTmp7J2BbgI5Fa1bzCRiHNE/4M281WkX7vypxAaBXUjWXz/Nzh1YFlAqJXwr9m
         erl7nUL9/gJOU32M78io5FXdVbNM77hNJQD8+CcSafynP1OndHJ6qELbgDu7SqMRJMH0
         f7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327458; x=1783932258;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z7ewoKopFZWDSHXaKQpbm185Ui8l9dwnR4N9LGUyBmM=;
        b=kBbM75vOmgslH0uPOdPE3TrUhVE7hXfJ++05YY4YEJNK5/cCqxdndWZxlSo4ApqnmS
         zI044Z7PDIsWADpxpEpfvHo2p7eYpbLeG20tLNUzdAaOohDGy70Rr6qAYaVjDzD1P0Se
         jj1JU98NqM1xQIf2AGLOd7deNz7Vxlg7ckmeQkR3kLWpsXx2EVe22/UW8IyC9uKQNg2k
         gAlFIZcWWUhR6CtJLdQiNt9ultslzqtciHSltr9a2vFTOtJrv4vN0+701F/dnP4YFcV+
         WSnuSkHqv4F64dVSHz9K8KO5+sK2IONK1n2dkwZuo2IXRzbYIB6J0vQnMhpWcoBf7VvZ
         Fy8A==
X-Gm-Message-State: AOJu0YwSdCHa8oXeXMeY8v1h/YFMUxkCNDkbu2eoZCTcEwne/NqVmcei
	QTTBgzEtmHHvwoPjTFghIQ31CsHXgn4yr+DtqidyK3sXF5/q/up9FRgSP1EMiZhB0qdpi58C6Bq
	24VxjEcfGvnEENQ0Lh2MoC/jgZis2juFQVlSZRrrNFtco+CbVlJSlDlMWKA==
X-Gm-Gg: AfdE7ckbi442SPDHqQl/hiORnG3uI2yIJJF9dj2Utjf4fmArqB/00220DEUWIiIpxLw
	Ly7ZqROwMdmROgie1NejivpXxkpUvCwThlvWw7520p4hDrfkhU3vvdzB0eYOeR0UTnl6EzqVXMX
	avROhZYMrkymDuMZhCzDCwne8ry4PwGbx966uTsYFGuu2xmOcxoMfEmoWx2iVnISxJ+k7SoFCml
	mnHD0NZjBa9NVHdGgpc0vzpmpnLX5/4odF6QENMXTJDf0XPvzL/q/NrlLnlQuWdnbBtvEXKTbsE
	mLm9dJIVLIvYh1FRuA2D+ZjpY2jo6xlaJhJ27kktns/rcL2z1GJR/8ZCm3DH2k+qkHCuIx9af5V
	h92rwExbiV+/CxZzC4zhL/2s+3LTOoUIPi24=
X-Received: by 2002:a05:622a:349:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c4bf1e961mr84275701cf.10.1783327454076;
        Mon, 06 Jul 2026 01:44:14 -0700 (PDT)
X-Received: by 2002:a05:622a:349:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c4bf1e961mr84275551cf.10.1783327453661;
        Mon, 06 Jul 2026 01:44:13 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62fc72dsm702939866b.63.2026.07.06.01.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:44:12 -0700 (PDT)
Message-ID: <93b78299-866f-4a3c-9423-a990d9a7d4cd@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:44:10 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/13] drm/msm: initialize LPAC ring
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-10-01d50c3e0c99@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-10-01d50c3e0c99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX4NT6rB66W0rW
 bMHLh9wSGx/8IbjKLckwLlSdHbb+/yzWpHYDLYEl2ruAu7FFeLymtIlE2+mcz0VKGa+zGiBzPK/
 ZvhkyeHKabgnaWj81pUeAJN6P2EBa0lSMlpNlXTsoGymZk9EMdlpJjY//fK33YCe2vqOC8a2Jgo
 kuq1dtoSVHzcqidX8daEuQBzYC+X8yHFcVFRab/UFQJSP7bo5/cgLCioJX10USQjwdNnGVFBvPl
 eIhmp5QLKk4mjpj1llxW6PlD5Y5WtuGULUh71FV6sdf4I5YVTRjJuIz8Q+S6ZsJl2ntYa59R2s/
 nZwT98s5apKbtMEVoBdEZT4tppZFNLKU3UCzFlw3m9/0Dl2Awia1cfLWPEt7gdvsLhgqZFlGkJo
 H8Bg7CXRL8w5k7vZlQxRHeQlAOzTdr6HXLJJEeWa5VSqUhVJx4t3FTTx/9iThGWihIgor4+OcjC
 37dAwQwOt5ENEgR3wJg==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4b6ae2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=NiyOziKYwqrvXK6gfTIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: pvL6Us5KXgs-uFSzOn_VAnZSmBqHCbp1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfXyd/IO+0pfcps
 5DuEfkmtYFBawismStllo0dDCnJk1OD6CDg1eMSTDnTKyUMT7zPB7OrewNqSrDPwd920Ynm9cYV
 WLqhUmitgy0X+ua1cZ7jodp/BetGn3Q=
X-Proofpoint-GUID: pvL6Us5KXgs-uFSzOn_VAnZSmBqHCbp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060086

On 7/5/26 9:13 PM, Anna Maniscalco wrote:
> Program all the register needed to start up LPAC and send initialization
> sequence.
> 
> Additionally, now that the LPAC ring is live, make the code aware of it.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---

I believe some/all of these writes need to be guarded by if (has_lpac),
as many GPUs lack these registers and there may be side effects on
others


[...]

>  		a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
> -						      sizeof(u32) * gpu->nr_rings,
> +						      sizeof(u32) * (gpu->nr_rings + !!gpu->lpac_rb),

Should we rename nr_rings to something like nr_XXX_rings
where XXX is some uarch-generic (i.e. not SQE because we also
support pre-a6xx) name for the main number cruncher?

Konrad
