Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC52D3EF3
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751030303; cv=none; b=G/i3ndjgMOGJfsQW5cT6P9MD3CPyryaabqLzadT9nNvYvrJPoLSRHLVQ3NDcrWGlHUeDGED/u8UV/ovoxLeyztbOdqqALCJUFIZqcOcq+p0pRqgX1nSrsq/Hopt5y3iNFnWYlb4PS/8e1Ho8FRU9309fQvBd0QNwIXIxJXtfCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751030303; c=relaxed/simple;
	bh=DASYvfhNb+2DE4FVIzEICu3iK7wNmHwBQ/TclEhRxEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFfHvi6ijfdrRC1lk6VXW6cECmyNHdICY1kvFNXa3DjeBUla3+tw9ae4eMzzF0l0FTOGyvTIuqV4JEAiKNfNuMMOEEb99C+6ZEkwirsZ0oZMHeAJ3IXjIJbdB4Rqy3ZUbi9Y5STW0Ew5+hbfTE6CBrJL3rRcxYdzJO99BCHe36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H/TZJRlv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H/TZJRlv"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCIoqp028698
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 13:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B3DKye6fgw14zQoKRPlEfu7aezVTsZmbUNecwjwCMbU=; b=H/TZJRlvPlkKe58P
	mYf0/uRMYn4I00zjGoKaOV/SEIvqHaBa1iw3jehG1TbF9XoKxf/ykbVTnQHLzfdJ
	7SZFgonKBD9YcyfwqAui1NR6k0MWoJ3Xs6ceB0dIvZZN+X6xnZCLhCKwA7g4kjrM
	DyfoGHDTYN0DuXFVgfTu/VHeUzyoelae67zJC27ElCKtzhJTvLqN7XP+WelnmRgK
	1e+GmEuWYgIzN1Rwt0W7GJq7apZ4m3G/vDOdlAq59cmo0ndUzYgxc4ezH3nxkKLI
	CKqyjdhTXNf9pxV4/UZKccO7tu9jneBf1zTAQjQ8/l7HiUqeGC7V7vZ8N8RKk/SP
	J3OnUQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa50803-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 13:18:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6facde431b2so3561226d6.1
        for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 06:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751030300; x=1751635100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3DKye6fgw14zQoKRPlEfu7aezVTsZmbUNecwjwCMbU=;
        b=uPLoSDj3V0WTL4J6+h4a+Y+heaKofQh9d9BOoLoN1t4Lf+gShSS16t6VbsQu7IDhrR
         KdobnqbQuxXVO4jDQWUCYwVZ/FmYHEtmxGQ2bBKkhsE4eYZAozzAGm20xkmnuLMXwUO3
         6gQL/0Nw6aoEd6QOzG43QVo7gJ9+a+eo4qKW84S4Os4eYj+hRX8+GIRchb39Kf7dPCgo
         q3LJCWt9PY9s9aGgSiDQJMCl0paqcTSbvYyndn95LwIHhNm+I89e9irgo3Ffv9aSqROI
         nQasiuXqdNtrnoo6wbxCkpAavswA+6Txn3h/JGTlnOtgK9OM14rBIjZ8a8xxyiqnalt+
         91PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAdXbamlAkalloh34mdQ0PyX+SrwKhd1GK6zsT51KdibTRf9gmVnYpP+ozbNCVc3bTLsAe1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfLo74dL2LwhojD2EvjYk4tNhNuq7vR/du9nCtZOTEO5CjLuiS
	byDKKffvhiAi54Ad8dqrXsqcxlwkM8XhXJ3ZYR2+97h8ca96AqiodRoeeb3E+CuefKGoFA1oH/v
	72XSEF7ablvYpkkP6LCxG5jfgjrURp49SyDYZQXQScbuBPA1tAYxdTBCZfg==
X-Gm-Gg: ASbGncu+PUSnzbGPm2XzL3ONWZ3JWrGZChU/t3U3voUbC6FVQ4h9CU5ZMBGaVkQUO7t
	e95QrnL2fZFjAyq/c9bWyd1KWK7ZonC5AtQn7QCYDVQPUcJIBkc5YP2YKGnET/OrpFfDhWsYxir
	u6MWlFmgCpEEulKx2MqtSduejFbbaVW6RlJbpJE+53m02T5dT349mCTP9w+TojDJlv/XwLZvaVR
	V1yo42wkTOncietJ3JiaawkIp4E6lsU3XeyEFSjqTIf7Y+2qFu6k4aJGH3XgxqWKEgdt8UlPJBy
	VaOT9W15l5EY+GgXHXCaf82VZV58RN6jYx91weiF/g0ARzJHGd3haAzit/jjNZfF/q9ylL9pGGG
	uh60=
X-Received: by 2002:a05:620a:45ac:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7d4439b767amr166877585a.11.1751030300381;
        Fri, 27 Jun 2025 06:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUjyId3keHx2+y/xDg8fhhpls0ND2oa3mIvMxjZRcmTvKRosNCivFewSfNCRcPy9zLXcv5QQ==
X-Received: by 2002:a05:620a:45ac:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7d4439b767amr166875985a.11.1751030299816;
        Fri, 27 Jun 2025 06:18:19 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659f7dsm121431966b.45.2025.06.27.06.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 06:18:19 -0700 (PDT)
Message-ID: <6aa7ce8e-b963-4b93-981b-771726349b73@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 15:18:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/msm: Remove ops->pgsize_bitmap
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: patches@lists.linux.dev
References: <0-v1-662aad101e51+45-iommu_rm_ops_pgsize_msm_jgg@nvidia.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0-v1-662aad101e51+45-iommu_rm_ops_pgsize_msm_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685e9a1d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8
 a=KFRqgpUkTpDQm5BOWHkA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 7ns1qxRtgbXYQ5gRhVxnNwXs_pPznD25
X-Proofpoint-ORIG-GUID: 7ns1qxRtgbXYQ5gRhVxnNwXs_pPznD25
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDExMCBTYWx0ZWRfX1pofzf9KlPeG
 bKbnkPOaWg3Qg/o9lsVBQAAGg1zrOhPoUUA7xXaFNTYs3FtW4phZx1bTQIqoMDLorYJecjzg9HR
 4njWJJ3myqc0+Dgp7MjNPf23fptleaKbAo//qtby+guYmbh8HlEbcsk/vVq4o+69TOLMXc67Kwc
 7L9VidyIOUnJy6dMOaGRDGCP1awNeNxNlNklxL9y7XYBlBinAt6geSxWIye/hArXUZlfL5U1H99
 OnIC4DO7qjlK32Wh9dFZsUCgHQlrVCTO9oYJ7nWPH+MCXRhxaGKXB8vDOlmTg3wsJ8IrJO9JnL7
 JAaITk8hC5vxlPVAXdWnjJjr+z87z9aJpbzReBfRhXO7qMLvQcvdrpW9BHWiIXBMs0DWarCTO7g
 W3EbsB5R+0n5EzZpFDrr626upSrncNFPJYKNa+7luCcTAJl93Vd1EJCDA5mfAvIfMPfD/a6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=994
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270110

On 6/27/25 3:02 PM, Jason Gunthorpe wrote:
> This driver just uses a constant, put it in domain_alloc_paging and use
> the domain's value instead of ops during finalise.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/msm_iommu.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> This is the missed patch for the ARM32 build, nothing is remarkable here.

This driver is a computer museum candidate and I have no way to
validate things, but the changes look trivial, so:

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
