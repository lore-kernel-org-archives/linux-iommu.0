Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D5305968
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230579; cv=none; b=BX+JgYXEX2ErFvRPJmaP4zn+YseEIxTjL/NgYJSpTMBg/CiaWV18phtMy1uQ5qm7w0qbxmtbkd/XuF0KV2Pu7otuSRMLgGZNebk3R0vab4VtAgz6NWUZ/ZWsjWYQqNCXuqndkXTlbP7KfMQZ0gLXfP75FmOQXwAwDlW0B1+6igY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230579; c=relaxed/simple;
	bh=/UrQ1a5jEoyvccg5tsS/vfbkMBLFSzVTkQSDcxQ5qys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/+9Dz5SVtueUombA69aS4SMVsRI2DmYvezlLIpDvY4ieEwF7qETX6j00UTe69/Y1UYMOBAKr1TdvxYvO7JVNKfw8jJbn74KCAhBgRj+bixkK3+8B8ujmu3kaN9FUTrf4ya4eVv7S0b2fW/FlOP2Csrzliff5WUM45Sav5EIgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jwk1pkc+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SrVvO2Kf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwk1pkc+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SrVvO2Kf"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZD3v031271
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EDBaC1eXq5Juv4WWLDTwG9RBd5emtPKDg9brhkdKs00=; b=jwk1pkc+AGsWUUK9
	dieU2WZWUbpVICpERalDXpEDuZLM9VJPIyIbpY0nLZUanFazpPhCGmj8jpYYRVqe
	rlymjFByyNLcA+jtd4O991Z/3dPPGxCoZl7Hrk+Y4vkJ8y9CscF3LvftTPYNV+Mt
	vt0LP5FUzvxIF+mRMYf+na/pMtrI0u6rD31yka+ieA1WC5LK7OCaQxDExGdDdvnz
	wmjf3uG2m97NlpftWNbzJnAQxD2C5zFAOgW5K7RDs+gYd0GsJXt3NUIE4KKxSvos
	x0emNgfvhqQL1V0O8F858JhFm5y9SUmWvWAND4k7k5dh3xqZnv332eJEW+/FPUS+
	TeP0rQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe69pan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:02:57 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e937d38a5cso9370a34.2
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782230577; x=1782835377; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDBaC1eXq5Juv4WWLDTwG9RBd5emtPKDg9brhkdKs00=;
        b=SrVvO2KfZy/JgVWIvft6nt14mt8cDp9wHlUWdgvVKsutRPjvnMgsc56F1uX8jNFXSX
         4B52xpdODLkmRq6gCBZ/+og2dM+tbCGC6WyEPU1YWXLBgS51xSd74Guu3ApoejoYZCc4
         Ch2l73aejqYxlfQ1CWOFMAg+wG5aMrvl72qjSvBMVGee811MpxzWFVUKQwgGmTmiDRma
         8ui1G0s/rELLDbF+ifs1YlIiw4HNLu1VVbXUQ1aeh35S9B2cuf6WITAQuK2XSHAeT93A
         leP8dwSPSxj9BRpmB2MybmAP+SzTXglgPTvze5w4djt4FvxK9Qy0hmm/x9O+7b6DmRlH
         EWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230577; x=1782835377;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EDBaC1eXq5Juv4WWLDTwG9RBd5emtPKDg9brhkdKs00=;
        b=BJJFl1XdV1iZnim8in3gEVv5SrK3vjhgAFd3dLPY+JNr/os9blWzH7W4ZB5wqym18H
         G/aAuxP17smTGNj/NfbraSNJXVtd3jUy30CWkP7PB8Xub951EJNkXylqjJOupbbCdPz9
         zscgAsMbELXYkRIazweC+udG7oX4h4+03KFpNd5S0ezw504jTX+nsL+XlaLtJxRhxgyT
         C708DxGZaYdXDNyTaQKUft4PAU7hy60gZZsxIE4d3miPlz+qYcCHhaNgnJkTOFHSenwi
         H+UZxYEOpdgCr4cAMzXvUB82c0KcyL99ysfSgUFfUL7gmPJOKE8gazbXVwmY+YtCkLcP
         JeDA==
X-Forwarded-Encrypted: i=1; AFNElJ9TFin7EjRirJj0a/7VNthNw33Rnpjjz8d53TQ9c1LJg/h3ZWGXWi4gkvbwe9S0ZVmMjPrR+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKkDKGgk7P/oj4amBOcEpePyAtrAE1T9Nf7cYRr4hZQ8WzJPIT
	dvGrU5Ru+7YHov/u8tdJWxSc8B11iaOK8Pq/Z14CHrntnVJu8P4Bj+C3oSPEsxY9r2HCEnuWt0R
	9Qs5EhR/sWio/WzoFzLr+iOgMZkP6QN0AUiDC04MDnntARl8HtUgKHqfOwQ==
X-Gm-Gg: AfdE7ckVfkQgPXRos+qkOYp7TYPd/JKyU4SWTkDbKcuYHKRU1CK7lk+QxoXVKseQqGj
	EdHgG8vcgQtlSNb+SxuwbnWGDSZxR24ir0Jqrumi7N4JqSb8DUM8H/Ef+yI2mPY4mh2IJIIO+lv
	GKUqPNT94cbog13ofe13lZ/sul477I9gMmHy1epBQUztp5UFM2Jjp+ZoEJozAl5mH2Nz/UF1gy5
	abqUDG8qW/w4D5yAW9KAebNPhbZON+YN3+LsrbIqPKVF1U2CMaj3WHYe5c8ovrhTz+QjF26Ow5+
	XZFCJR2kxL279oyp8oyv/j1x3bOllqNIXrlWnvpxEp9cgWHjzC59aXUFYM8eb83H8TTbDqfIuu4
	R0mA5DIwEkccgVci3xY5KV/+kARl8X48xXN4=
X-Received: by 2002:a05:6830:82b4:b0:7e3:f809:7984 with SMTP id 46e09a7af769-7e93c26c950mr8027518a34.1.1782230576858;
        Tue, 23 Jun 2026 09:02:56 -0700 (PDT)
X-Received: by 2002:a05:6830:82b4:b0:7e3:f809:7984 with SMTP id 46e09a7af769-7e93c26c950mr8027473a34.1.1782230576359;
        Tue, 23 Jun 2026 09:02:56 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b86de31sm4777390a12.12.2026.06.23.09.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 09:02:55 -0700 (PDT)
Message-ID: <f636b144-807f-4a10-bf44-d06b169fce21@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:02:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] iommu/qcom: Check pm_runtime_resume_and_get() return
 in probe
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
 <20260623122034.1166295-4-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260623122034.1166295-4-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: giY8SqKypgQcPP8FwtnlZZLdRBu45Aij
X-Proofpoint-ORIG-GUID: giY8SqKypgQcPP8FwtnlZZLdRBu45Aij
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzMSBTYWx0ZWRfX+kgCbqoq19Gp
 4/ZUjF1OwYU7Ok/bHUafccl40jeefodr1cIxvslnwOY3Nt4kuIq4gxqcHhDXo6SFEYyBWo3BsDt
 Yx2QZHksmw6/snq05ElcvL1uuamfv44=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzMSBTYWx0ZWRfX73CrEaLpI751
 JeYVNLBGWUm0p2VgTvX3pL6uPyxhi8cgXf0z9roBJt1zoTW1ONUvlA9udybtELajYAv28vGb1ji
 FoB7snsgMJ34hFSO4F0g07ZNiXkqPdGXazdlpltw8Kr8EG4+6Ws162VVHB3/kZn0u0hA60X8ngS
 ujE2mM54izujwq0FQoMTKy0iO6K8WHn3mB2E3fhwlnyKP+kV+x7vEsuHH/Wxz3TWrmZXVm9G5z+
 fLk+GPAJcszy7JTcHTppDLfciRkFai57oULY5QirP7tam3Qp2ClH6L1CCe/Fxrxn8S3lVFIz+hq
 GPc1Lyb5vhItkuZvi1NLRbXQ1NLiGnRyW4lauprD2MfnBQ5qcKNkYYxkHroxtDMbdeQAh3IoJ4V
 2EYlP+nABBcRHjC8Ngbbuc74HeSAsloxSBu01Kz22bjnL+s3ZvgznqChzForpcBsC1wLJttpnkO
 7Qb7rOQIvOiE+Qdoxcg==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3aae31 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=v1Fw_KadxetzZ5l6LqkA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230131

On 6/23/26 2:20 PM, Mukesh Ojha wrote:
> The SMMU_INTR_SEL_NS register write in qcom_iommu_device_probe() uses
> pm_runtime_get_sync() without checking the return value. If runtime
> resume fails the subsequent writel_relaxed() would access hardware with
> clocks potentially disabled.
> 
> Switch to pm_runtime_resume_and_get() which handles the usage-count
> cleanup on failure, check the return value, and unwind the already
> registered iommu device on error.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
