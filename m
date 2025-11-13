Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088013321D0
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031532; cv=none; b=jfqazZ/NVDhLPA9q3NvnX7LlAwGy2ryS+oXj7u4LtcELGB21rtpoppis1xM9aY3DVOLRtSa76kodLLxy49B1dzUuOcL35Euwn5qZVQ6y6fb/O7MYKL5Ypw6Cf5hysUftUlRlZyozwzMYuQPVX6eyERm1waEC5BAKZuj1cqdjzus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031532; c=relaxed/simple;
	bh=0SfTgwIzPX/BA/JPrecUkCRKouOa5PWWI5O6ZWAA/DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcEZ+rms2tLkuRJJLnrjTGpDjo0cbXn0d/ANV/wEXHcnLgD+3OlAtn8DNV+nknRfjYD7LDyIzTZGgIM0bfzl5LQjY056sl/NoOlHbgw6ltW7ctZdWsPO4Mey6d8NDS7NJnaBQm8PVYKxeUn38mLu/iJzVfXXnJkpXu4zkzlo4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OX9cuSGu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3JIN0ez; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OX9cuSGu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3JIN0ez"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8t7Dm2993654
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 10:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jgBPaO5vYeetCNzgFhvdCRkSv11ZkxPO6+3HoWQmMsc=; b=OX9cuSGue2w3yOTX
	RFu0kR0LgWyxuJjvGc9Ya8ZqJu/ZqNoTzEstbau0fpspsTIz7A2U4jGS61BnCtCN
	mEYsktpis3zl9MYBs77wYRrjIyaC6W/8QJD/51E2bNPgb9Iv+K1g1izUJi8I1Lpg
	HzZQaqYNNmysuiKoJAVqbDA8E7jho/Fi4LdG4c89xIA1kf0v7crDJl6pP0iO629q
	pCVL8VYZ0TBBAGpqHTB7GkTLgRmc0Cw1zBzr09i2kVJT8wlPD8Di08D6tanVIyft
	ejsV1xCAzPbKU9jkEpynvoDWKlIQTmNxWfm7ecuemCUk1P0cYWFz2BAx8zsxDbbs
	Ce82oA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad47jhxm7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 10:58:49 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88088964786so2169926d6.3
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763031529; x=1763636329; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgBPaO5vYeetCNzgFhvdCRkSv11ZkxPO6+3HoWQmMsc=;
        b=C3JIN0ezcUPVwNeeaTP/Edg/wD+fEfKCwd8iDd0C03ZhYw2Ece3Vjr9r09P+MP0g6o
         mJyCFuBrvKWmQqoPuBoPfGeeqCSCdPMIR2+KRuJvIpC08m+l2MCJYZI+Mlzs8504vJBa
         lIYil0ZosKaHPgwWI0vDBnPEd3Syr/hANWJjTxJEBzbx1vTWGBY1B/zTSLkItJroP3wb
         gX/jP4cBDQTIOeEACBKRYOeZQAtH/37qQTQ1Uyg06G/kUfgoFbSO1alwuJpbMpqIW9b+
         FJr85mnVQ5drETFxiknZgH/uL1LVhie1dsetttAoMzv1m4bXnh0UWflDiP0/jWMb/qKq
         b1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031529; x=1763636329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgBPaO5vYeetCNzgFhvdCRkSv11ZkxPO6+3HoWQmMsc=;
        b=W60/TlpoWI61xa+Kv12qT10t41iUlQ6iYSlTXGCuuSFbRHwEb1piaAr34fck1m9MCS
         Br/HJYPzEADiSRsnQXkpEWRYyQ/i1FIvQWjbYstCwEjhPeB9B6C2rzuia7sp4xKnx1Q4
         IIh2puH3Gp8wcPcdDzijg23sgHm7zJID3WcEKZeImrQq1ztfKTAnWC4Wdk0qaL5VXIeB
         QNJIxJW3DMkn4bt7AflinuMLmPxJGmDTLLxholwedaP6+lndf2bkGSYmhgKNcUG8BczZ
         IXItB0vnFqpF6xJMKfbq/GLVhmHJq/u98hHT0EZ69+JExKXRpTteavVzWDlL1t9N42X4
         3/Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVSHTJjW4Cx8UnusKHNCkF6z7n0HXsf+TLor5Ew7RdzfDua278Q5S0RGrVcYTdPF4xVIt1RZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcsRSteWwLavU4Nl9uQlAeY9aTDo89DqVoI16zPDCcxvMPOTaf
	sf2FbIE38n+7KemFE/vgaQeD4X/69gp25/+4bnY5W7OGARQxDZJIwBeF4F9PGYpURZ74DKTPuhs
	KqG9Sut8E5SrcDjs1pYVnpECl0Lg1C2V9HC6gaDhhv+6gRsadEG7EDZBv7Q==
X-Gm-Gg: ASbGncsuV9iVE2bIPYAkMp2nKlmrif9+VyqNwit9qXY7tEPYlq4flL19D8MVwfEOsgv
	ZsCUA/wprY05t7XmCgP6oVHGF5YHXtzA8SCPFLVU+Eu8NAlhYR1nTtkQ6IOkERIEBFiDYKdnKqs
	2xbtJp62KuOFeLK9r2MclegqT0Uy6jndoX4Bi2xNw5Bka8fajCoW2ZHQTOjlu/TgcqkYAfYs//7
	0KUAcmtxeF0qb6RgjpnUnSFM77bLb0ApF2PXJMxLobuWPUr1wDVke+LYzrE3NhnWadnQ++4Tjvx
	laSeQYOW2pOxePU7TzGxDtnCjYK+5uOZbo9tZbG6WJR87lMKCOWSYbi0s6sRgx+hWaQGPZO4V2D
	BWX/zgKcsegSyIR8rIZ6vNd/rsjKrE81Q2ismdBJVZerAi46ZkmGI24ml
X-Received: by 2002:ac8:7f4f:0:b0:4ed:2f2b:aadb with SMTP id d75a77b69052e-4ede794dd10mr20846391cf.12.1763031529011;
        Thu, 13 Nov 2025 02:58:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdQDsxtlP4V4oPmd1PqozO62xfFzJpWU31Y99QHzv5aGDzw9SGa8isg87xEOWg69/ZZScEyA==
X-Received: by 2002:ac8:7f4f:0:b0:4ed:2f2b:aadb with SMTP id d75a77b69052e-4ede794dd10mr20846131cf.12.1763031528471;
        Thu, 13 Nov 2025 02:58:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad3edasm140259166b.17.2025.11.13.02.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 02:58:47 -0800 (PST)
Message-ID: <8ebd7250-fa3e-4705-a5e6-f01878389df5@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 11:58:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/21] drm/msm/a8xx: Add support for Adreno 840 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-15-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-15-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4MSBTYWx0ZWRfX4zNWpGXmF6QI
 ZVwdVKh77mibIy7wuStPS1zs6wPryLkvYRXQ48Gg36L6hHC5Z7lTRSDd5bpKKIQ8q98qmZ3wZjj
 94wpC0vQshQtwOtSuq9nAlQQY13E2BbjucPaZRlrcZDpAbZqwoz8M5LabcvUY+CS8FHSsGoLnZ5
 eeAocUjHcnLLH82lPmc/ABMqNrl93uJ5mTZYD27o4pzjFpfS9jInFjsw+luaktT0tmh9UCD7DVh
 3jKEkuriGeGFTmMVT/NJeQnELlfDDvZtBUyqZjNi7BJPudm7gWil8NBsl4GMfF56KhWSBk9DfQt
 snaE1q9fTRoETPm8056TrjnnpZxxCuJ/7uKfNI2xY6XFU98ScRuESsr7tQpeBBWKSJSePPPlWtP
 MGEdv6aPBBM2sF1wi6CHg/vc1Io+OA==
X-Proofpoint-GUID: _ukT9_Sl3j3DjEdw-oL1q0z1G6xb_TVb
X-Authority-Analysis: v=2.4 cv=A5Fh/qWG c=1 sm=1 tr=0 ts=6915b9e9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1fD9zpMYXuRVFxAoecEA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: _ukT9_Sl3j3DjEdw-oL1q0z1G6xb_TVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130081

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It comes in 2 variants with either 2 or 3 Slices. This is
> in addition to the SKUs supported based on the GPU FMAX.
> 
> Add the necessary register configurations to the catalog and enable
> support for it.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
