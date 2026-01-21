Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8432861B
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014811; cv=none; b=OhWhMaoMHa2z6q+IBe9todLkPenm3NRDieluOxbA1AEddglID7SzKN8qlME/NazexwbLivKXGP/n8hSmc6nc6YOXhCSJ/AwJe43xJ95fws17bQhyALEB/Jl03Qxvx/X2X+Y0JLhCQKspHNJeLMJ2zPt0NjpK1CzFZGJ3SinGRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014811; c=relaxed/simple;
	bh=Rq19kCLiLbjgLUascNi3uFHr/okLMD+Mut214LcoebU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5/9bksagBTEiQf4ifZZS3WpIy+QBQjaBOnJLs1UVZIL25pIqbPOsV4Pfzol427Ji5PguRaKwssszaWcAO7pt4ZS/Og1yeoBDBwX+mlHvqjUdaP85zSHbW2XE3Wte28hJbkW7igYuIHe721pYmD+cVCM4RbJcbWiD3Ko651WtJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RxIJUbuN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=knrcAIvU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RxIJUbuN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="knrcAIvU"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L9iW673481473
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 17:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ib7kzlkMpIuGdkzj3jtoMhVY/pgx3vVg09JVTXE93K8=; b=RxIJUbuN5E5tMSZX
	qv64isG/bBFQzWvAci2JxYT0lrGHH4+8mRte9Tmlx97SLRJk4xCKhkRhJrc/4MLZ
	2VQT4rMqYubJL2zuDbX3u9Ksjbe/SA8pZcwuu9s2HvbSrJ824zWUgKfvGgxt176a
	1ezZk3ozn0GEIsVuQCEO/+ktUZ5ozA0V/53Fc2Gi3tXV24tY2397KoOf+T1MuNaC
	i2NqtPq3vFzAvT4KmtEDVakw5ZrKQx2TFLI7+3yc6ItVbt+8B0DfkymY/42xDpgl
	/7Vs9CBP8kD5/lwCETrEMWoBUuFrr/bbfpKfdGBdN7Za4YwEd0/ScWChFsqgtot4
	UlyvKA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btvef1fpw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 17:00:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c69fd0a87bso2283485a.3
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 09:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769014808; x=1769619608; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ib7kzlkMpIuGdkzj3jtoMhVY/pgx3vVg09JVTXE93K8=;
        b=knrcAIvUs+yR2X/VmTl9OfvqhWP8nSN+A08NdDqhPVowvCZ8ylXXByrJ+8uVvCeZNg
         zzZ7S/wCcVlUAZb04D8bhpc5pmulhsRVLD/K0oZo7hVliGU0BUW6rDBzdcNt/+rUvP8c
         drAwK+JhzAxJwAtsuhwCs2pLClv5Biq1NAvtw3wVTOpOTO9A5UePYPj/dxSkoN+ZxOBj
         C1z5XKU9GtXuSvLPpOLHP5x2lSV5Ab3bsgKYfbBjLb+FfM6WlgBQ3R20ZOCKs4bv9+5i
         Q5vv9fo0kHn5JBt1SCunuXTwEQvfYvBfC2H4gq5Td9yoBrN587BVb7noOj7q2wEuFki3
         o+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014808; x=1769619608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ib7kzlkMpIuGdkzj3jtoMhVY/pgx3vVg09JVTXE93K8=;
        b=n3isn/Hxek3uhb8frXHaWjTCJCMPhpiQrJVh8AWZ0qnrQ5dB/j8GoxXMRp+U0+Dbj3
         YW+RAlZoRqje8z49tBOzE87DTbKqNx+5j8QOXBR6VxOvbyXKpdHgxTOozDO17wq6Gu74
         bUYS7uoXR8rfgcPYzUiHtGQbS8jjUNuRv67NWFh7uTodcFtBM3CXxP4J+u1ppOcPCqgd
         SSp0/Xq5yC9T0LaHQ5q71diUBoK8EbFhvhKurAxgrowc4c5a2Qxhqp4ISVYXHf7lXdzl
         claJPb/GDTvvBj07z4VkHlkM8FsyB6FCb3Pl6ROztmikGhyf2j2MLlaDnFMskeyBEaVC
         Q4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdq/VdaBn1ZhWQOKYNPQxdECXGXc6MmQ3ngIc+qTvd9ELMBkHxHe5iNFOprZOriN2MK1OD4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVuQkb12qkuSi0HVA7w8ZwsbAGWWEkBf8ykhpiqBy2vgcE/HRW
	Nm50nHLyMeFbu7DuJujuPB82cujDXfztOB9cNCRkjDNMdVy0d2wVnqQ5AZrvOFI4rIDG+efP1TQ
	qASnFlSnKRSgivLA+OxVbkp8gww8zNdzXAhA1BTsroGU8myxJepBDomKJCw==
X-Gm-Gg: AZuq6aIJOfhYka4zMPf1ts1hJSTcEEmwIgWRUkomxfvgYhWMYn9tOeM3I1qVmRcrbv6
	MidEXKlum1vfoqnYT58GzIClxnsMzdN+wxsm6xhs+EHMet9J3jxpCcuw5zhCJOSX7SnT9Jtd2Xo
	Iiqs9Q8dc8MtaejR03CVK3W7XTqNIKj4XM/vuqDP7ikGtz2XhcQzaGsL1znbJpthy6vME64PE3i
	5oc4nEvShhP/5ADFTmzSz8GVdKwyjoiB7mtb0fJex+n5MtHA5WCGcuqgyHhxOHvIwI5c0zlEfpb
	e49EiCe7uDhIRxdNsYn9z59K61k9EGvRBkwEDm1GCj9nT5EMIZWvjEhefGTxk9cDmTUjBo6oSlA
	IeniAR4jRUPPBtsifFvn7MbqaqycdT0kR2snXZjd23+SSKsbmHynpVIQigU3ToBb/jXk=
X-Received: by 2002:a05:620a:1995:b0:8be:7dd7:f041 with SMTP id af79cd13be357-8c6a6799061mr1771910585a.7.1769014806049;
        Wed, 21 Jan 2026 09:00:06 -0800 (PST)
X-Received: by 2002:a05:620a:1995:b0:8be:7dd7:f041 with SMTP id af79cd13be357-8c6a6799061mr1771905485a.7.1769014805404;
        Wed, 21 Jan 2026 09:00:05 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a192b6sm1582377366b.59.2026.01.21.09.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 09:00:04 -0800 (PST)
Message-ID: <be5d67d3-1909-4a05-a4b4-c9efae4ba911@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 18:00:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/msm/a8xx: Add UBWC v6 support
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
References: <20260121-kaana-gpu-support-v5-1-984848af12e4@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260121-kaana-gpu-support-v5-1-984848af12e4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lJPoljy6dHondU3Hj0sdApHZZ7so7Tl2
X-Proofpoint-ORIG-GUID: lJPoljy6dHondU3Hj0sdApHZZ7so7Tl2
X-Authority-Analysis: v=2.4 cv=CYgFJbrl c=1 sm=1 tr=0 ts=69710618 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=I3w_ynYpeOqJdckr6GkA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE0MyBTYWx0ZWRfX7RJJn1BeKGEP
 cw/XUxvv7wrii0kzVuSGAu1IywcXh62ZVI86Ko2L1uZhYqNwXZu/YyZHG1FaZwyU4Vo/uQl0dMd
 p20ppzivcV6mNRdPLImzU/4R0WGcRbVIkcKCuom7Wg2pEEob+HZq8xVbNUDVfa2OuHvCKC7V35c
 BDIRX5TDLIqmHcAJkctsRnriqqqCB2+NBzDbSHIn+tkEoJ6rW6SXVnFxENouoPxoc5aezXwHlU+
 oT7QhzOaOqBwXmAlZr6YOx3/ShSzKGAJUaFiSa15Aaf0JP+aph/Sn78SJmiXT4YJF8SU81IW4kg
 iWYqG4+YPmgvyzPAcFN80LV+QxJdGkTPDYT3Ji5LSiq4v/yRJOkLkvkEPlD7lIPY6LVKqW1X9g1
 qc/EAuDYbEfR/F2gd+cjeHpTuFZo7x6G5vmGWiFEOnZBDn/AFe56WHAYSEjkKqYn7Vf3yHdVmsO
 ufTAGUujAMU3IHPK9JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210143

On 1/21/26 5:01 PM, Akhil P Oommen wrote:
> Adreno 840 GPU supports UBWC v6. Add support for this.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
> << Trimmed the cover letter since b4 folds it into the single patch >>
> 
> This series adds the A8xx HWL along with Adreno 840 GPU support to the
> drm-msm driver. A8x is the next generation in the Adreno family,
> featuring a significant hardware design change. A major update to the
> design is the introduction of 'Slice' architecture. Slices are sort of
> mini-GPUs within the GPU which are more independent in processing Graphics
> and compute workloads. Also, in addition to the BV and BR pipe we saw in
> A7x, CP has more concurrency with additional pipes.
> 
> The single pending patch in this series in now ready to pick up into
> the msm-next.
> ---
> Changes in v5:
> - Dropped merged patches
> - Rebased on top of msm-next tip
> - Link to v4: https://lore.kernel.org/r/20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com
> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 30de078e9dfd..5a320f5bde41 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -276,6 +276,10 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  	u8 uavflagprd_inv = 2;
>  
>  	switch (ubwc_version) {
> +	case UBWC_6_0:
> +		yuvnotcomptofc = true;
> +		mode = 5;

Downstream agrees (and they do a better job of using field_xyz than
us this time around, I'm impressed)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

