Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC4230D35
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388060; cv=none; b=o2hbWifqx11qY3z337AY5qKDR5B7Dvmhqm6pRAqpnDP2OH0oY3sJxH1WmMZk+uQSjfztCXNwb0JdKumlb7dolXNBdND2suINVQeOyyS6pKV72JRjb5WeUv5Rvftc0Co+QJgCNbnPTOCP9wVmiq6ny+DulSHuFW0gr9aIknMqrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388060; c=relaxed/simple;
	bh=tYRyG8yGuVMjxpdn5RQJt9JNXWc4lvUyFER+lwm3rfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFwKBCNGBlBfm0SdEQCShBuAk9/1fbDA2WTC3MaRtcZcFd5xGByl8H3o48IBILbL3IipbLS1sX7osHcAix7Ulk934i7npev4mOtFN7KWljRTbUrTKX48zHQojwInvhATDDCoR0ORHECw7dzEzJ0rKg0+lGmqbPYh+uYzcWyN/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CaLNWRlL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WqzAm+G7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CaLNWRlL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WqzAm+G7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHB6Aia3320375
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G0N1uC0gRebFM3m/xAV8ULblmBy1UD2QyB1c+fLY+4A=; b=CaLNWRlLM2uKAZYN
	zumD9UYmsPf6oUOVgIDz1j75aOapZi2Zk3w6jEeuZ902Te9KZ3QoHgAavMpXGXWz
	mTd02hHbgfZkTTFjDcKhu2o5YASXC4Q/C+toi9qYmVOCK4f9u2wWooLVtukLDy4d
	MGXQxrrRs7k5FW2a1qAjNVQ2JWdphcxhmjwohGDR0Qd3txoliwcX81HHKJ2goDWL
	jtY075H4qCqC/6NBg0qRZiZoywBsPHJ1KVjg9w4kC8d2cLtTvZEv6YFw3DWZAilg
	Aq2rPi+fMQoHDf4THYnwBPW0FDV6GeIaVcHbAZ0atBz6YFIfvxvAbmKM/gXIfuck
	GTkqhA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejm5cxdb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:00:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee07f794fcso6464361cf.2
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 06:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763388057; x=1763992857; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0N1uC0gRebFM3m/xAV8ULblmBy1UD2QyB1c+fLY+4A=;
        b=WqzAm+G7rpz9bL/p2nlGaqHYPbCNrK5qqh/krH+kPm8RiMrimwsBYcip3ir7bnUMdS
         DH2EPaD4cquXKJy49oGqt+/jM9FfZ+5Q1MrxSWTHEqi2CwiyO++05V2mTR2hH3sd9V5Y
         aUlCvtCCXggpOlRdsbpdHcoMl4v1CwnwymaUTEtgHQ+modp9oHvybUlGJnsfw7IOdQdy
         WgBqUT7CgOqyXudDJimMOJrOJkIzFt7EfuutoBLOapE9ciJ2TWwHaaTQCTV+P8te6Dtj
         2bva1fDDGJD88ppGW/A0V1OOEpf5OuY67JTbqfDtsBrPSJd3lMvgOZuiufErbsdgrmdW
         T/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763388057; x=1763992857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0N1uC0gRebFM3m/xAV8ULblmBy1UD2QyB1c+fLY+4A=;
        b=gUu/wY+n6hxgJCkqWLxYiD0R8Oq5BucExW0Bao7ndwDv2HeiD2pDMr4/yN9qfP3QaI
         pHzzNuF8LKwS0LmRn/ndr0KvnX/iKKYA+PhI+C+YI2dsPA2bBuIfvU7MzNH+FUsIcNyt
         0bE+YTKfZgUib6vusNSSsJg21m8LUsmg6CgvysQLsGMC4USbAk4nYqVL8J5+SceOfUjt
         HuTBXMcJZi4D7jqUmcqJzPO93z3Zs+fpaWIFQU0NAtb1ZaBV71sNX3C8LKw9/zxSo5kn
         DBssQQ9gXa1nixTpPyocJrIl/4yv8OcRIVAo5DZF0fvYXMVB3jsRDAU6EiRNkCZQxXb+
         vaoA==
X-Forwarded-Encrypted: i=1; AJvYcCWy5Tcv81Psq5bi/Xpc4zfGvTLiuUZHs3ivmZgOpqTZo0aidKKh4vxLpDBXsCvSsl31liSfWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPYjUGcM73Xt1XFYKMi5NYWcyQVTNRc7JAGTM3nzwsgFJdNCwK
	oGmlw6HKrRgpwdrIsx/nAzmMjNHf4vj4tQXcngVgqECW6I9cMpPorTnDDlwulP98QKEocG2QZZ8
	qI249gxcbJxrYtte9MXjJqIK/C5jXPJ5Kmt+FONq0nYh+TTrCVD738UZXcA==
X-Gm-Gg: ASbGncvQyBiXwqjmfudpbAScX6vukbAdYNkkw5bPwqfrELFugZDiKMTCs/85bTrIZtz
	QMPOfjXSdylJOROHRcjdJWOVobmpsTYNjgB8EZSU1ccDqIocguMHnRsJmaexAPHYBOBwCuZmHnN
	n1+1h/treAjLKUG2evdt0NxC50zpMP64G7sp6OQGGPTV4MBT3/ZMep3Kyaphdc3fjraaFzdDpHA
	qi6OsNF78c9NXFtJ4nGmX3kUwTfjsA4JsVmSbe2ldI706M6Gvz4nXy+2Lk8qReeMbFhhEDU5eHG
	4wV7zn7SJN2m0D42zgoV/BlFGdBBXxzWK8ibUgGBGgm/nTRNvp26i85ESj/YSFTeItWmkB7EQti
	EUsjTIzPbwkENxZCamzxg24a3VNfqpDiZfqtjnA/HXp5/0DpZUDe2OBLw
X-Received: by 2002:a05:622a:1a20:b0:4ed:afb4:5e30 with SMTP id d75a77b69052e-4edf211b66bmr120920971cf.11.1763388056381;
        Mon, 17 Nov 2025 06:00:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj35tYdr0HD47+9f9g95x0CjScjhWZaLoteYTa+aiaYqadjZmKPlu5QoVkMf1uY20EKq8T9Q==
X-Received: by 2002:a05:622a:1a20:b0:4ed:afb4:5e30 with SMTP id d75a77b69052e-4edf211b66bmr120916341cf.11.1763388051601;
        Mon, 17 Nov 2025 06:00:51 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fedb91bsm1079743966b.70.2025.11.17.06.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 06:00:50 -0800 (PST)
Message-ID: <ff634b09-c28c-47d0-a57f-6203755cedb6@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 15:00:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] drm/msm/a6xx: Skip dumping SCRATCH registers
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
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
 <20251114-kaana-gpu-support-v3-3-92300c7ec8ff@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-3-92300c7ec8ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDExOSBTYWx0ZWRfX4WyAwyFUfFoU
 scucOGWnjsv6uOLZkQ6hYXiaiDsl35169w3yfyXjuvoVZgDwE+CO5qi2GhCJEpCXev54LIhwLzT
 BWwXWuIvzaoO69cLMQBHfIyGJ0djwkPnDcPnI+XsnjOnt/AxJMc6Ta0gLRGhZZHCpkFvdiRuyuY
 GWgy96hNbQ4PJWTjidGJDD8bjzgGty8oeprDg0/ej3/+05eSN8UxiyUs5vpOZUq2/zBzIKyJVUV
 azuzFCqvDHC/PvLVCtBixX8KCr9YMT/R+SE33h+6TgWnyvzbXUqRmtj2BItz9aWytqTGrrZo3H/
 RrnPIRASzUn5t1ay104+jGOD5gr9j8uIDBQ1Z3dCw6MSD4Sw1vfCoK+nKCub+zBfnTvSS9tpNNt
 +hAulOKvnyUXe4WXIzUYCRyHMzXMzg==
X-Proofpoint-GUID: aDaMPyx1p7UxiUjJVtO2Of6bsmKIGP6K
X-Proofpoint-ORIG-GUID: aDaMPyx1p7UxiUjJVtO2Of6bsmKIGP6K
X-Authority-Analysis: v=2.4 cv=Pb7yRyhd c=1 sm=1 tr=0 ts=691b2a99 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=RYDHkQwZWS8X-3Noaz4A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170119

On 11/14/25 12:29 AM, Akhil P Oommen wrote:
> Crashdec doesn't require SCRATCH registers anymore for a6xx and newer
> architectures. So skip dumping them during recovery.
> 
> Suggested-by: Rob Clark <rob.clark@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Looks like this changed in:

https://gitlab.freedesktop.org/mesa/mesa/-/commit/95104707f189b2e1b06c855b563c1203b33da354

and needs_seqno is never true now?

Konrad
