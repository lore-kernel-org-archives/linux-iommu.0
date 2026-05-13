Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD8423A8E
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677796; cv=none; b=CuzlF85ECddKp+iKxU3ZAjFCUlmTi0HJEx4RI/Lj2svWig+K8Dxh9iUto6EVigJWf6RuzH1eBxTQrwTERis3rfZSwilCS4H0OcdFeFWSZbgyPN93hcfekIFAfuIMBtrxieLeEKifDuho5zNgRe0WzVY+xHBKuryURHInVOoOceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677796; c=relaxed/simple;
	bh=pPhZN7nfhtHHRw6dhJOnhfHiyh5eQfG5r3IROqjHaUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC2WyQO07FIBqjGxb4DtWnapdRuqUMICf9736gSlVimaOy0hlhvP3EZw4K80EJ1wmyPuslpE+iFo+MEIl/Ex9M35YuG2pWYwYkYh9Y8X7d9UEKeWFyfGSvTTbRjBlAC38qXkKwXP94iDH2goFZMlHsoaFgNaEhgpdCBQ7WRcY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lIHXbmdr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SkfaW7VC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lIHXbmdr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SkfaW7VC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DBXYAC3324683
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B5SnseXY8gWAqnQpvJungSJKJ2vcNA0bRZgJ6p/nT8Q=; b=lIHXbmdryhAAdCL/
	HfbH5KgK0BohO3ARBAdjZHiUBA0hBdx/x3+IXo7NGxGPRtUrdxEWhE8jX7tSqslj
	FKkwMUezvxpmTSKUuUldw9iF4Vg4hk98A0M5RwAowegqejjQGylUj1sv1xbNHCn+
	2uWWbvJiJBYX8XiPRCtVQ6O9jnCCErdIseRLb5xrhO74OpCHxlNqpQy83AlUhbDI
	J4mueiqhd9sqtDcsAkezYjTVX4n84BkTvvJYwzkQp6mmqjldFo2/lDJ7uKLiK7kp
	94eQXYVtJaV3aOuvrj0uVvRvzjbVQ6/oJGwuTedS/LrfUGedIomGFaP5jIVO7DVC
	akOk5A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvd9hw4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:09:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bc763c7256so94704115ad.3
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778677793; x=1779282593; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5SnseXY8gWAqnQpvJungSJKJ2vcNA0bRZgJ6p/nT8Q=;
        b=SkfaW7VC94rmYWe9Xo/C6nU0RcIWqwX+MffZSbsTnJ74nO9unT1uZJ7ZC/0dJ8uvkK
         eFDhxPkNv0L7nrVuYH2RKQVyOVR3fhR3o6NobSHKf/Y25WleMAyNdUktWqS86MnN3FRP
         SP4CEn1z82ep7SmAP3QWpn8P+BDpAq/5su57hKCMTscpU0S7mGKE/oEHqXYkL0cXqNEf
         f3/OGpARi08njGmbE3wKC7aOjTzKUjsNBgzjB+lnqDCHBW2TZb5Tn4Y4J+URCuWOjNwz
         fFZpFhrIV1mMQZsuVSQSbgWLzqywDglFKUZZAFVv5CfqpKHy5IkVC3hBLz7q1ezxeScz
         NKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677793; x=1779282593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5SnseXY8gWAqnQpvJungSJKJ2vcNA0bRZgJ6p/nT8Q=;
        b=D9A++wx8/fnef43kmltZXI108tW4GyjB2lOp92LcaXYkk45cXs8Q7S/YNH//YeBePu
         bNP5m+Sh+MDD6GL5r72pCZRHXnY++IM4jjsfHixvk915y7udnBVXbgCrUGXunR/HKKMq
         mxyGx7rXPiG67jxhmqQq8v0byGBQm37nHmqdRj5lVkwvxWXR60I6EUhl8+sVp8sVbHVI
         M4bm+LWNKPFvmBmynrG//ZloRKAANT3dPYpmzKbn32iselR6XqJcu1ZyGsjPqnNDD5V9
         UQaAy0nLPWUWsUXDVQMONFj/Demw6Ir5gXg9OA9AaRkuVzmAx4Y438B6/Xn+idV41fdA
         VtqA==
X-Forwarded-Encrypted: i=1; AFNElJ+a3RAzUS2VPh7eC2yqU0HM89uI75J1ArT5Iad0mS0y/gtr4JpDpRwN5FniPLq9+ukHywApKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YypaQ14h7/qtYQlnYKWCJ5Yn1nEmCyn3brbYlgzMqW4sePyn9Ww
	mfBumHb2K1VibRF7HxEkF4p7CrTT3de1+iJD4NdZkuUaF/RgfbksA8JES3g42AAS35eu7/Ouoaz
	Me8fxVzgzreo79t40U1FkjBFiBZBRhomOyStFOdh8R6osGS0TMPodHi0tHw==
X-Gm-Gg: Acq92OED0wYj5KMSaEC/QLNgSjUGnv9bpSe56d/Zwyhk6fJMecNiY4ZK6HJETwMQcW+
	KSKNqRPxNBma4MBeUbtVoTrBb/hus+usyYk/A+je/bvpydKsaDJyer9yIv6Pq1kQZSTHwTwt+J7
	LCWjp8I0EjuGeU8OpPodOw5DAsohJ2tO8sEW6+l2Ip+oe1Wp6444QdWpya6qzXiafwpk/gFhZI8
	StkycbCFsf2HTxXbPDDSXRl+pFZGdw5980azTR8+baKKczwGkDBm5dCMu2igtAL6a8IUPclo1Px
	0s7FIIOEV5jGiqppdxV34quMCuABaHHwbwJ34aDDACpezG944D7ZudjOLICku1dP4iTJ/YO3d17
	7mZ0MzY0Z5qjh2GNi0gvR7SSURIcEzrYzru1DJ7oKUriWnq3120gtvWg=
X-Received: by 2002:a17:903:f8e:b0:2b9:ff02:a14d with SMTP id d9443c01a7336-2bd275b9de9mr38165155ad.18.1778677792719;
        Wed, 13 May 2026 06:09:52 -0700 (PDT)
X-Received: by 2002:a17:903:f8e:b0:2b9:ff02:a14d with SMTP id d9443c01a7336-2bd275b9de9mr38164675ad.18.1778677792287;
        Wed, 13 May 2026 06:09:52 -0700 (PDT)
Received: from [10.204.101.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d52f27sm207675385ad.36.2026.05.13.06.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 06:09:51 -0700 (PDT)
Message-ID: <a1a38bf2-84b6-4e51-817b-b85ab6c65f08@oss.qualcomm.com>
Date: Wed, 13 May 2026 18:39:43 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/14] iommu: Add iris-vpu-bus to iommu_buses
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-2-7fbb340c5dbd@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-2-7fbb340c5dbd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _exby3qm9Aye7SYiadMIulsN4DtU1_Kw
X-Proofpoint-ORIG-GUID: _exby3qm9Aye7SYiadMIulsN4DtU1_Kw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEzNSBTYWx0ZWRfX1Z+imTylWZM/
 X+rWSqgOf/PHWheuREbERfrBHuBVkWKzhdMuz+Q02aImsJh0nNFd55zwo70QLnJlbK3UtKiRqou
 N6MkqHS38iACZ7REq5TDwgmf04oIbglkjz3i9cZRqx1HiOhNG6v5AWEJ3biCME256W+y0IDQvPV
 1NdWB70ZQ7N1GFqJL6E2mnQzryK7dFN4VuPuZjgpo8CgH9M6R2qdaYQR/pwI4o5NIzE4MVnd2Ke
 fr3CEWNK2NrN7pPB2eeKEr/0LMw9zjPtxoC2WnRaabTm2Q3m2Yw//cBevJkbi23uKPxyKHBKQ8E
 b4htv6Rr+8FIfOiTDgp95luCry0zCrKY/+VKYcUJ8rAMVJQY/xF8pvYkR2WPKI0OydE8+rUW/LS
 6zk+NJ3jLNl7npg86nMXfJWTZBjDx8Y3GLZPkp4QQ3QnA+7Vh938jucPe34WylxI50LTaWdhbM0
 HiZtPVd/xxuwQdzeIpQ==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a047821 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=j9WNCELPX4ZUnkJ91WYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130135

Hi Rob, Robin,

On 5/9/2026 12:29 AM, Vishnu Reddy wrote:
> From: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> 
> Add iris-vpu-bus to iommu_buses[] to register the bus notifier callbacks
> for device add and removal events. This ensures that when a device is
> registered on iris-vpu-bus, the notifier triggers dma_configure(),
> which sets up the IOMMU context for that device.
> 
> Reviewed-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/iommu/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)

We have added vpu platform bus as suggested by you earlier. Patches #1 
and #2 in this series adds the same. Please review and suggest if you 
have any comments.

Please provide an immutable tag by applying patch #1 and #2, we can then 
have that in media tree and apply remaining patches in this series.

If you have any other suggestion to land these patches, please suggest.

Regards,
Vikash
