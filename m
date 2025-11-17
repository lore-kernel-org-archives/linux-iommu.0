Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1823A9AD
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388402; cv=none; b=NR9T00MwMeUaZ6MKYXnFNcTiee+u/RtdLuqJXkgtvv8NxcdU4CfYE+wqCZKYyw4EtuII7eOQHfRTRckW8Mur/k508C0GPckZm/MtkIVd/SgEo452z6aA06u1fusStL8wswpiVHWekh9/k9cP7HLsZrITWgfocTeUrwa4NiGRyJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388402; c=relaxed/simple;
	bh=tRJbOSrz4ei3IyLmuvn5RLHdF9Mi5x9i84yq0agPmEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ci/qLnqnp07ub3TSW9lve9JPHoRWumuR4fQTw6wceG0w3pKbQVwXBAShfPgJnUsATNQsB7MaGPJtApPAyKg4OepK+RCrb/K5y6ESGIc9bga7C7jo6evQ/gKOTVWRGLKrtNbGQb4uhsX0cdEnSltNhHWEGcf3KZqau9hf3ixr85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MS1vdrOy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VszdmRig; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MS1vdrOy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VszdmRig"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHAC2Wh3571481
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDq+mw+HRp2398SoTeGOlaLqDC78hVLUFcq/9QZ+fWM=; b=MS1vdrOy+Oy8cfz+
	4ZwEhGqMOTwdrAe5cxWzUtNCsTNKX1riWifIs6ssyofVIuMJo4Jt1EnM6NynNi0P
	ZPgH10fRFhFnzTVvml57WpBIOix/bYcQLPTqPjBt5AU+LsrabkfDORwaEtARWzEe
	kpA6rNV8Uyp7aNewdnthP/Yi659y5buh7LTpdSZJ20j7XkHtNcw2J2528/3QVLfx
	RnyeSXp4pu/weMDF9CpkXpelZqyXR/Cu2c5cqFOLGggAgqtshtWZXo9IcJPXANFE
	2nYLuhPHak5VbJ3KWxcKtaRuchxf+4KX0AZwXJbkuO4A2cMXuZ3Ly/up/cvxpGcl
	cRvowQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag1rbrmfb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:06:40 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5dbcf8b5a0dso645379137.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 06:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763388399; x=1763993199; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDq+mw+HRp2398SoTeGOlaLqDC78hVLUFcq/9QZ+fWM=;
        b=VszdmRig9A45rEqOgL9cwER0FQmfqAR8K47TN+VHKNzNQsDjIjgCn5SQJi1XlzNIqj
         cyWQs7KscUNreDcftRmvMGYgpplAYry723rj4xP2VzUi9o0YE7QKVjvq04XxV/Dp4sZl
         u6o6EUfrYB3Occdstvwpt1V7zTEokpr0SdObq5li+CYsHPAfN6G6BwqNUj230wJd/Vhh
         EWwY5tPWJpBI2PQngckyKhHbDp0psoaz9MAOP6BJ7qTUlBCkRKS+PW/KsoczZUJQZsF7
         +l7xvPbHYSrwMHxJOeShHJBHhmpr377WnGdFI0ziaz5nDG0Cb6i3aeyFho4KvsakhQqV
         PkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763388399; x=1763993199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDq+mw+HRp2398SoTeGOlaLqDC78hVLUFcq/9QZ+fWM=;
        b=owekI8q91Qu2HrROSCn8TnavzBIcHpFJWhoY0l0IK2no5PfKzcB6BTUwy7TmrLwyAE
         mRvKRxATqdGOihqpfRYMByWMmxB8kSm/3FFN+qq3xzAO5gm83wzTkuFLH3eg5sqPWBA3
         zFoUESIVGNkWICWecNFD22LtarGTYyWefNQ9gC4CCtU3D/aekRuoPh5y4DLYQx091DdK
         0CqkHRWSJa4hd2BVhKpOC4OxDK517refqJmdWFiF0ahFU4cORpQXDX+uQAofSVr6JKN9
         82ufK4NBj/Pwd83jxt2Dp+ezMoFJy3V/zmvS39VJawbRzipsO7H4evMGRz1dRx0zdfvX
         klxw==
X-Forwarded-Encrypted: i=1; AJvYcCWNq2k8RIiF4WDjc6rkjK5h1viKCL+eapOw0kCXU699Yw2i4aknl01N7gDGV/c+rPE2KEh+LA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBld9mQ9znmXAKwLuSBYTcZWgkDgICqa+/XwPEZx84bMY/+icv
	W3MuiNsy+Z4t/V76oWdXxInKJfqAvaZOLKoi1STajT7QnZzGJgUmaVOvimj43ntXkpryiLOKiEX
	vu4Qb5tYjxP3xMiK5vkDAypAKHMmwIUH6NJXKvud0vcRHDqmTDD4ND8MQGA==
X-Gm-Gg: ASbGncv6kpAhnFmMmD9AR47GJQF8dpRLTIF4nAnV60+EdK4M1DzXNXRx/YEEPPLPZVe
	7Ei53+y1TkQfTxky6A191B3BVV1QdyakSWGkG8hyZ4QONTCoit0WXbwjssjrGwghJ2FlzPJFjDq
	rzGQyeVp6uHg7WyY6mZdD5gSht7eIZs6zrN421VS7euffjVYtEohIdc/duUvZNRLyqMNd/Ue4uR
	UfUUgtfyj1oW1SuxgdInitWoOSGZcW1wD0twQ+xnPs0GY5Zg7tlYGHgejOKuveEWDs8TlDSpaXy
	5XfBbSBA43MLY1wWGve/eMb3R2aqRK8bAFX1eFtVqu8OAO7SCp+Wn5gi0pKzO0nrke1rBHsmb7Z
	OKt+nHwAGN40x2PzWMp4ihAmP6Ze2ZkpOrkM6ZdHi5fZ3Y4/7PUdWSyTa
X-Received: by 2002:a05:6102:5107:b0:5df:b081:4a2c with SMTP id ada2fe7eead31-5dfc85e072emr1619601137.7.1763388399364;
        Mon, 17 Nov 2025 06:06:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKNiYRBfXeh/2aXn0HQPLKudUqGsF5V2HxhMggV6/QVJT/a/O/XTnuPbHT42rAwrh0e9Rc+w==
X-Received: by 2002:a05:6102:5107:b0:5df:b081:4a2c with SMTP id ada2fe7eead31-5dfc85e072emr1619547137.7.1763388398836;
        Mon, 17 Nov 2025 06:06:38 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa81172sm1079373866b.15.2025.11.17.06.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 06:06:38 -0800 (PST)
Message-ID: <60fb9b8c-86ac-4c4d-aebc-2c9c2f558fcb@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 15:06:35 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/20] drm/msm/a8xx: Add support for Adreno X2-85 GPU
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
        devicetree@vger.kernel.org
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
 <20251114-kaana-gpu-support-v3-17-92300c7ec8ff@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-17-92300c7ec8ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jcuINuVIkdkKT_SprF-3n68r0PW2YVYx
X-Proofpoint-ORIG-GUID: jcuINuVIkdkKT_SprF-3n68r0PW2YVYx
X-Authority-Analysis: v=2.4 cv=FPAWBuos c=1 sm=1 tr=0 ts=691b2bf0 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KNdfcIBsQoTh3yukQZwA:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEyMCBTYWx0ZWRfX4HyWNyQJT2mp
 akSdYO7+6wXWR9KEeJVVT2OHNj/HKOOs0NGvUJjhIXk5s/A51SxvkPa2gn73L7PR0603FqrtT+b
 /nRm12PFkvMXEeESN9se/Di5CTyWcgwQGWT4fyXLtj3YPZ9j272kvHK2cC1GEcZVSzUV/Hhbafk
 X9fahCTD3u2FlzA/rmuDYtZAPp3e4ytPT9O5qfLvKXwdWJnZyYRIIbq2pkox9IZu0E5cG5Be8YC
 thX0PfChckkgFe2XaimMLqN7KhOmNGyEzBqMg0XtosUzv9FYFlf8enEZJV1eduVjUAN0CC/D5aI
 scWcV01IHDueJXJdUS64bBZDurSNqN0uMx3J5zeVlJbuMEM9tjQjtKx9sxmvwHCcVYSHfKVG60b
 MaZnildtp/LO4XVv8Wdwo5ZIk7fdcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511170120

On 11/14/25 12:29 AM, Akhil P Oommen wrote:
> Adreno X2-85 GPU is found in the next generation of Qualcomm's compute
> series chipset called Snapdragon X2 Elite (a.k.a Glymur). It is based
> on the new A8x slice architecture and features up to 4 slices. Due to
> the wider 12 channel DDR support, there is higher DDR bandwidth available
> than previous generation to improve performance.
> 
> Add a new entry in the catalog along with the necessary register
> configurations to enable support for it.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
