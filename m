Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22686329C74
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468166; cv=none; b=jDrZKZiLhM3QPGvKgf9/18QoSTCTxwpMq0pagj/jbosiuGTQyChVca0JWlHlT4MaqfPeS4881lSSKhv7HTTyuYpjyNYfrbWm7kvBfg7BQMpKu73kPD31O5KExHQPjbNQQjygo/tp6y89L+defHKzMwVhNPafstin1KqHKK46PBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468166; c=relaxed/simple;
	bh=kP+Urr/WIu+EN8H5qQbftSeZQbMZW45LUypXJK0yNdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkh4EGZeSlv8TUzNfXYtmBzUxCBZKFnCdWf5KVja58/cXlZzsk4O0YMhXHSe1PfIeFVUmnI6jC9ElbL72aWkic5yXraLDopspN8ev2AnGhGSlHEXBAp6uVplmWeOCtL9xnuvxbQ1/L8h9/qgJkoInhQb0U92Dy+Dp1lMj00sY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dy3q72Rk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bv4HyaxU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dy3q72Rk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bv4HyaxU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6dDbh623877
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 12:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	54AlXktT9apxczmnoBTDmz8mEG7d5mGc9KLiJxsdO+g=; b=dy3q72Rk9f3oYRbr
	zNi3J61/WYUKzpHetZyKDQTWBG/fHB3Kzqpo48ZXTHNbpKaIu6XDg4hESvAZJz9h
	/xjRFqzI6CpzTkcGgf6UT0sg96emUiP2Z0IqQw3UdFtXigz1Nk71p0Ioz62Xa0+l
	Fdj4R9ckr/GmEf9lxI+jmsE0J3Si7+ZwsJc+YxykQWdsvpXQRmGbUjeurgEb2euS
	+wzmI/o9bIHmluzJoGs4LUpSn60fZHIFJe5Y39nghMenEsdVwgAczC5BZYVgWiLy
	Hw3d5YOFnAt2kijNAlyb6JNRXb7z43TuYvTBc9fXO26eKIc04S84sKoYvtNdL7VV
	+IyjVQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agahfacpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 12:16:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee00f2b7d7so12680631cf.0
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 04:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763468163; x=1764072963; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54AlXktT9apxczmnoBTDmz8mEG7d5mGc9KLiJxsdO+g=;
        b=Bv4HyaxUj2iBaReJK4pn/xEdLZ0cVpoYPKTlLw76l1Th8vjuRcicie45782X9jFmE+
         itoP1oA5aAmLJnbRlMMp2zxLoyMt109Dy2zSiXURAjcFGvq7zpH1HKMxWsEiYIE1PS6e
         QZ4TtOsycrWZ8P5GYx83uIYxJp7PoI9/430kvIdTthcLaOFy8qgS00uE+XAylHpXRBp7
         XkDtM7fX2YTZXonh8GtZeK5EHo1IUexgvX+4N9T8qV/KQ35mHU0q/ueGLtoO4n1dDh08
         fvmzVVil5SqryttY0LJlaYPVCp72XtwsBbpT2SQkSnwv30HpJoODz5Ho6wrpyLRCYBs9
         RAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763468163; x=1764072963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54AlXktT9apxczmnoBTDmz8mEG7d5mGc9KLiJxsdO+g=;
        b=ffdNtF3NTI5WyW+jA3gRP5avKveLwIWem3fCL4lX9kHlNLN2b9O4aN17b5Qm2inIfh
         hGYuJD3KhYnmG4sdhCrkMV6kIqbXME0COwB9O60RXckjRI0nhxG8E+Po1pFVifvzK62E
         F8JE79mS4D3G6KGEBvoKijUQsmyj18QcbV5FqAFAsTVOfzAyD1bcMvR0+M0Wq+cpuFhG
         kZ1yIxGkGmVH44E0S8oqDsZCshej0zuIjzGTa04tiJkHm3cr5VKonF7B8EdmMQhMLyne
         q6J14lqN5CcHtYbrws14k/eMvF4pK1DUkVm2Orkfx+yeh7H7OkGonskCli479wxOB6Er
         rhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXrBA5wV+5ib635Wi5jn5PxMcbWO3f8i/cnwsUZM8NUUqW3uj0iL8y/AENWBZVCezGtxs4aQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhY5dwNSSPvdqDcDbDoheZRyWJXT/Rh9jv/kpxR0gDqQ1qrE4U
	gq52/B8p0prUz05H9zj7vJHiJ6REDSXiZYNEWh2nr/HeBX7Qkt2xu4zLYx4phCs2qcCb8UpbsZy
	j0R/4fADYuBW1utxhNy6tC28wbxx6wikXYE8RZb1uETnz2gbCUwbbb+HqoQ==
X-Gm-Gg: ASbGncv+NKqRUckLyH5dvxydDDPOP/tsHxrULr7tJccEW2yCeGBozzs/GhAQiJufn+j
	pZBryAXlgOZDtE3k3TR4Sme+61J7ezKYNggrufgA7ORE17LSrTXbhH0rGll69fm+bkzKE+yFbn9
	4FPnuEU3jWfHideirgXsRtbWrOJdr2bxwQtG7f/BOiXFI2taAg6qiQITl59I/sMWSDdQFs7Zx4c
	1/FOvAJtfbHPKdI3YVq8TDgYlj1crjrX5c9wX4XeG6SBNWEl3GK2NfrmXP1ssVz+3/7J2CB131K
	4it5gDNuVXPxfmtdcI9y0mRmKgA0hfP2AHHVatW0OSuCUX4+nTKAMWHrJR+NIOIKARkba3UZmCd
	hQK7ozJvaCN6oxToZVo3u6VSMSAVuSyz48EM/0VwPstCcZ78Ep8/AwReMYndtfFHfqE8=
X-Received: by 2002:a05:622a:24a:b0:4e8:a001:226d with SMTP id d75a77b69052e-4ee317b3acemr23701991cf.7.1763468163282;
        Tue, 18 Nov 2025 04:16:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6pID+a9PTJziO6Al+fjeQboZCd5oeZ2xL2RTvSo+ugWKwkruWzV8d/WajOx6TuvAeTk05dw==
X-Received: by 2002:a05:622a:24a:b0:4e8:a001:226d with SMTP id d75a77b69052e-4ee317b3acemr23701731cf.7.1763468162759;
        Tue, 18 Nov 2025 04:16:02 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad44b4sm1355453766b.28.2025.11.18.04.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:16:02 -0800 (PST)
Message-ID: <74b5d4f4-ed36-4691-a82d-37e76c52974b@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 13:15:59 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/22] drm/msm/a6xx: Skip dumping SCRATCH registers
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
        devicetree@vger.kernel.org, Rob Clark <rob.clark@oss.qualcomm.com>
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
 <20251118-kaana-gpu-support-v4-4-86eeb8e93fb6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-4-86eeb8e93fb6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA5OCBTYWx0ZWRfX2lY+LzeXjwFD
 M6soKaw22thTCZptN79jEb4l9FqqWfiflhx1rhYNbIP/9RAULlU+6aiV9zLq9FkLiJVdRDPqEdn
 xe/MwxHeZR0fhwJz9RfVngA5hgLchgt39JfPXbT7q/xlT5rxRtwYypKAP14DKx4cJv3WvovE6ZW
 SvBbqTCanUjBdGA/455HVXRg9ZmVIi2+w7geCESRiT3w3FzWBVdgCKsUmexwx4844WsG/6x+W4y
 RhH0Dl1SlhNCE83HAbNzb3jtzVqE84vxkM9ILNRCr9P87PDP9hhqcUAbU+suBdzUnt5mOpCo+t8
 Uc9XLV63DxmetpkRpmKrZZiQbVeXi8y/NGfnFcnIgerOONmUA4dy5lT0RUeC66qjTBN5UNGj2sR
 vUHLyJN+3onoJ9AQYjz10crKwC2wWw==
X-Authority-Analysis: v=2.4 cv=RpTI7SmK c=1 sm=1 tr=0 ts=691c6384 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=oEwtcOY8yq9sNqF-amQA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: X-6RwpV6XqqJennnVAeQUvrcwAjRU0py
X-Proofpoint-GUID: X-6RwpV6XqqJennnVAeQUvrcwAjRU0py
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180098

On 11/18/25 9:50 AM, Akhil P Oommen wrote:
> Crashdec doesn't require SCRATCH registers anymore for a6xx and newer
> architectures. So skip dumping them during recovery.
> 
> Suggested-by: Rob Clark <rob.clark@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
