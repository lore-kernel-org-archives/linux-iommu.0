Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331B3328E4
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460591; cv=none; b=V0K/BfmRZ/7vjfGeNkkgYe0nzaOLuK/E9btYRvnOI12gkC1sOdHiMhcLCp7b1NW7o32gGUU3IUY+JJlbCJTrt29tKhzlkTcgIvvrwgj9poxsqtJXCoVjPK1bDk3U4D/9DsLLNtUqgxEmH53mwz6yODYOhSqsHe+CcisnrUyycRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460591; c=relaxed/simple;
	bh=OqUORvbTuc3X0J/VSCAu/hr2s9Hhv+URzk8dOXhc72o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjdZit2H/xnsPLV5q4/sJ2jLP1p24aAXf0lO/oYncJ0b4ZY78CJfluZMfuPm97m9RiEed34i6xsY8PnBQpOhvdl0PUyvU8wZWLPzOzmATLzfYu+VQcbfdrSsoYMhP7VBX7IWotrfZt48Z9mbHy4SgSqaurrXmaWLwv7W5lPYuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GzmP8zWb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OoRl3DNv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GzmP8zWb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OoRl3DNv"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI5vdmH4107460
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 10:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TpA86malWsoC8khMUULp/bosX8u9eRqCjiBugIRYxnY=; b=GzmP8zWb6LZ+TQYq
	2YlKVJKFLi6qZA9tSJfMbgKW3CE5waFIrbAsCTuu6eIScK00r33Pv233EF/Fk8Ay
	w3qTpZ+PkhXLgVtpU6kaRSZbgRJs/kylg8B5HejSwP6W2hBmhk7Hc1vKrJGZQ0Id
	7yXn2grV5te3qPGf2XFw9jSu4XSAZzgAM83S8WeMQj2U7KeJf7+wgnD3oNKmVfcc
	dlWxyJR64rI+CPrnwT4JtkHTrGClgLj2RxUo8dRBvqeXYHnaXTJDBWAhx8ePvJMd
	nJEwc3QXWs+JFonu7sDhJCo8sQHNr2bDRmiugJV9b8Qziw0tETjFFGNfXcx3lzch
	5d+unw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2hpbp13-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 10:09:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed5ff5e770so13332701cf.3
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 02:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763460583; x=1764065383; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpA86malWsoC8khMUULp/bosX8u9eRqCjiBugIRYxnY=;
        b=OoRl3DNvtm+n2eh4XoSSuNI38cHRIdINY+NPw2yxBnGBXW3ivOKDKX++7xxGMUwEY1
         //5PDP7vEwkqMYGqJsIrWgoOjzSbeUkygltoL3DKZyCUxjY9kfqpvvSSktrK/YrmQMy/
         H+9kDtZOd18xMjEt6k5RTCgP7SBr9pZ1QpiK+OlJxnYtqK9HQfp5cu6sgg6bVMbCCxuQ
         BpmvPS0routg0imX1ykMyup+nfK0TNr3wqxvQ9YeYrjTRUhNM+PoObAU0XYYhyjUSqtO
         5fW8nhcT89pibhzEPMSuovvCXNvjdjj7fXyx0ozyuPC3FNNq+1Z4eeENmJc09OsPmHnT
         jAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460583; x=1764065383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpA86malWsoC8khMUULp/bosX8u9eRqCjiBugIRYxnY=;
        b=hoRq/K4GydxCmWUgXc3XGq13EQ6ZKf9tf62I+YjV4aoDP09cnyLIPwFAzhqBHTuNKb
         3UVePDMN8azHXhUa2j2RiiKqozuOdOrBwnGRQ6A2zoypiVxoeUrXir66/mtGzMc2REol
         mAoPKXgjAi+HiUEJo/l0A6sUO8qEbVD62ikV8kbW4I/bhfVmxMNfFntNPWj03RmOCJo5
         HckNGXN26URYiTpZQgf8F+eve4rIUUwl1H6UPIiqUR21Od86M3CNnjNre2sjsUdIpp5G
         93EL3MKsRqnWVZgGaP9uBlCjMIr0nQNHvcAl1n1zO0V/wMaXl2fBarvTXWYXKVYQzmm2
         d5WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdVM1G6koMbyNvakKRSaZsD978yZZgTehz7l2ALdMBlTrJ65ilC8NsEfLR0OH8FEZGHNl+8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyznLycGCICL2jIRWwHVOSdcFXCr0cSxquOXS7pSIKagpM/vo/b
	v/cCA+Knyi9TgzYE3aMHJKPclfCL9I6lIoj9AY7MLH2jEB6dcd2CcR9i5QmkifYXtricOi5OrGR
	GAGLlX98jKWPI5Y+Svrq1tSsW52YNtAzdGU2FEvn//OXxxroOeZkUljlaSw==
X-Gm-Gg: ASbGncvHtd/M/7lv9ZwUPcSJj3PFnfCttIq4IVI4ScqL8lkyVGAClNtQD5zgPIP/JXT
	ytXzIM7v2I/+szMZwuyHYZNXUjTdplnRHrA1sTGgOkxBOiZt6R2bky3DAtFVylxTNUCl3wPELL2
	mPwuQqljCDYyykuaOfu7aoZO+113BFJG5dD+lyzDlJ5n8Jmu8Jb0/8j8LjLTm+IYXx0ap5YqZ1W
	tWpNzoGIqx3tXbBxajCJR+RSB2Cp2VUTm7sHfqlDjp6tKZSqQTsQHMwu+3Om65PhGBX9KPM+Qsx
	unlvmONxJd+tZ4gz14ebpnYkZn3X87mx/NKvrPHWm1xgM5EmeFmVcvGG9XX/nGNnMUKXW23ggA1
	dVJedosDfO4Sh+IbZo0FlN/y71oXsrn8GqZjuGuB+ChGGNxXIltrdo+uZhj3v5Wco2N4=
X-Received: by 2002:a05:622a:10a:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4edf2087991mr148537571cf.7.1763460582700;
        Tue, 18 Nov 2025 02:09:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN59Q61Eb2CNlYDxQpBWVtF5VFujGxsR5/ckcEtaIq+KMFxkfUpWv8DK6msTFYM50HKOrU6g==
X-Received: by 2002:a05:622a:10a:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4edf2087991mr148537121cf.7.1763460582152;
        Tue, 18 Nov 2025 02:09:42 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fb11d94sm1306025766b.30.2025.11.18.02.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:09:41 -0800 (PST)
Message-ID: <0167a373-79e2-49f7-a765-d3a770ff2395@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 11:09:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/22] drm/msm/a6xx: Fix out of bound IO access in
 a6xx_get_gmu_registers
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
        devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
 <20251118-kaana-gpu-support-v4-1-86eeb8e93fb6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-1-86eeb8e93fb6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VGd5YPPALtANQZX5adiADfeP1JpYEz8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA4MCBTYWx0ZWRfX4lLqa6Yct5ll
 6D6Rbo1zTLKrPq6OygMK3o1C+LTn/qjw5zrxk63T8fh3soDMdZlQ2AYcveiTvYLuamZDxOgRygr
 PpcGeuh7qeAv6iB+UhV0pX0jb/PvzV4rObo/Calpr3x10GCcu2gIeF08RGMr0TvAuvMkInTEHY+
 hcie8MboHEwEobXj1w2nFbztwv4em1/jfDRvlPWVVXiQGiWrdS1xw/q53IUWitWV8xL7aqCe1Jk
 lOiK/veSkxECs+Il6BcjbIVSgZeNTA3qQsVBd9fxwiMU3f8cnxcSuMM2CIb4FcGktWYZ30JMZIh
 aerQgkDCksg7+3maccoFjALD0ZqweRT94KGDx3R5pHic59Hgovr6bR56sa338lVbopm70vLXk6t
 5EVIigUMRTrgUGsTRoCjCYWjSU0+WA==
X-Proofpoint-ORIG-GUID: VGd5YPPALtANQZX5adiADfeP1JpYEz8d
X-Authority-Analysis: v=2.4 cv=Y5L1cxeN c=1 sm=1 tr=0 ts=691c45e7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=MwKg9OkWFYoYUW3DDnkA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180080

On 11/18/25 9:50 AM, Akhil P Oommen wrote:
> REG_A6XX_GMU_AO_AHB_FENCE_CTRL register falls under GMU's register
> range. So, use gmu_write() routines to write to this register.
> 
> Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
