Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67E2D3725
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240373; cv=none; b=rVYGR6u7RWQ6qOd0itrY0IHSFxb+i59qFWYmy+ry0xq3qxdDEKB22EQObahq80g2DomcHgUc6vOg4SgQQuMb2Pbow/wOB46c+kqQVzcrWDZ5bX8FInrF2BqmfGxtC3QrittAFG9d9MNndkTtNbJIMMjzyqjHowz90eKRRpdYAN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240373; c=relaxed/simple;
	bh=/F/ks41z9nZTtma9p86o1h0OmQ9w274etVH339V26rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dh9515SAfLBZy7vkf3Y6is9lXeJpmXWaIni/NH9nypVOsnXzNGC5wZ655SYJm4mBun6rEcYj2YPCeg4XKHCuVl8fzYoLRGnlsWbrV6vQhvaOvY2QhbA1ONkjaYwfD0g0oHUngIcmHVybCcaBQxk/DLKoMTkDEg61QsYOCeoKPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V1QdnfhA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V1QdnfhA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB7IFw023904
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 13:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hVS97d7MJNsARObM2+ftRjP75nOmFiQEKsv7hh3XWUw=; b=V1QdnfhA44Cnyk8Y
	oiW9MnIiYE5juU9bHra1u9W53iKnCh1n/4bVHvCl4GFB1d6c19FpkesKKXWSi3Rq
	6YuToKYwvn4dR2WceBhbyEO5gu4N+zl8Mudgs8iSIKLub4J3amFDwi9rULNz9ALB
	RupkJ7Ux3KDJ+WDbmfua93FxJTxYiZCmNImjTvlgLflwN9H6ocuB2xtY1VKclnAE
	djIGakjV55DDrrKbg4WpzxrUEQXi7OZSQiqOpeVtPOpxBPavJELY7CESzOINZfsx
	Y9igsqQ/Ba3+KTgRgzbLYFrnrtEkGMj8Ypo6BaFgguVmdCAUrBcuK8eO2uk4P0r+
	29QkwA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap8pqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 13:26:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7dfeacb6dbdso6644085a.2
        for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 06:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240370; x=1752845170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVS97d7MJNsARObM2+ftRjP75nOmFiQEKsv7hh3XWUw=;
        b=vTlGmK/1WLzl1b+i84xf5tKQ4X3mw12W3AJVBC5KJds7OhvK3xra7bUY2BvKcqlwjC
         f093sYTwlx4KLYwYkc4roPQXQmer6gRx79Tcg+v1Sg177twhzg1R5cdhco3T74FBskAQ
         uOoi5rVDWPPI9zR/fiEeOvUG8vkfw8BioDn0aByjj9CFJR4MojQ5GGwDuqglJmk2IPpu
         cgTv6+IPmBcWtWBvWeX3+pi/oJ2iSBjF5r57ouk2+RmH/jv7YHbVGfiH0z40ZI41Mo/h
         OOD+X9shnGfPMQHXER4jRH++TBbBJcix0Mh0G9SQKmN1lweDnHlzyNJwztra1+nmtn+2
         6+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWEpdINPOKskzCMX12rVEv/ofyvPCuDL3KvtvlDVzZp7kA7ufHHibSi3sHXmGEwryTBPv3kRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzDdht16JAiJxF72Qt6VoDcLDPkBlVVIWEFNQSDFbM0eEMy23q
	zKuhu3ScVbXIYh0rvROF/SUGvIoX55mI0gr3vWNaBDGpfMVJOQnSHagP4ed/yB9tDqC++5Uq/PL
	n251Hup2Y4CCxCLPKRbuDHnvqUCyNeUReCeQfgYj6L31FYYlWtrp0PD1aOA==
X-Gm-Gg: ASbGnctENIyBK39nw1yh66rO73O0S/XhHIUZyjr7xZqr2s0vJb3UabzmaW3ZmBfOVAx
	c12ePoP7Nt6ZGQon7Lobwr7hqtp0a1PDtyqhFBfXJ4wctMYpiY9BNc3EceLbfA25VMucAWz+YjY
	ZAkXr4Am6JTpQgvdcizzQbf8nlE69d17TeSkGVxtWxpVnmRzHc8JvmqAfMCOpeMQ4Z+KKqRqGhe
	RbbdcJlwuFsuK9DScoPoAFFeX7ZVdOt82Kz44qWRNwpezUPdboUh5wOS93CblTJXEF/qve3X0pE
	CiBapf8NBA+d4017a85zE7BQD+KhvAxHZHSFg52Pw/NbNrD88tF0m2JZbjmodiEKgHYP5T3LigE
	IxLQRMdNaABKoR3HVCCln
X-Received: by 2002:a05:620a:458c:b0:7d4:5d37:4169 with SMTP id af79cd13be357-7ddec64be74mr189854685a.15.1752240369627;
        Fri, 11 Jul 2025 06:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrnu8dcEhZSYwibX0MN3BjvYt7cX3AvTEFAod/2sdxyQmMhviAkK4/cJknuEH/hjlqf6Oc7w==
X-Received: by 2002:a05:620a:458c:b0:7d4:5d37:4169 with SMTP id af79cd13be357-7ddec64be74mr189852285a.15.1752240369024;
        Fri, 11 Jul 2025 06:26:09 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826462bsm299427066b.104.2025.07.11.06.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:26:08 -0700 (PDT)
Message-ID: <6cc5bb7a-344c-45fa-a8cc-cea34493c759@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 15:26:05 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/qcom: Fix pgsize_bitmap
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev
References: <0-v1-65a7964d2545+195-qcom_pgsize_jgg@nvidia.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0-v1-65a7964d2545+195-qcom_pgsize_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=687110f2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=bnN0queyXqPnPK5F75AA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GP3lXuecktQs2Uenhk2seZInvxM6yXbc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5NSBTYWx0ZWRfX7ry02CWamR5x
 4LEjTgH+wSyZ6RaeWwL+QcXEZXP2nKNBJwPFQFXy4s+aF2EDMhyCI0u2TG0i4lfP0BcH64VgDIz
 PPLtXn033Ev7PyBunhMSAJwnq99m2aafQP9wyfGeJpwodJnPXCCIQJyf5q4iT0xk6KA9fahJDIY
 hGxZ7BrbHjXufVRBNrGFAHD6Xq8P2/PsWCZ9dHS/LkCA8qUp+Z/xJgOxO8s6ciedhgmbpVbfjMg
 Twe52CBUa+wuhPxGxEofblqgW8uU9QokvSY580HvNlGswPcWbId3jePszm9Gz508AFYx1q9UGs3
 4tgPFqHpukdMeiaZQYExICXA9p0WpWQzqKSivVvTFxCf27PyLl3AlWbQVdbBR3086E0A9h5aRTd
 Qb32l2H/YBdG6X9TJYy8q5sXMTfttLL55F1ChcQbccR/zlMeWVrswZPZS7hNee8pOiAguQ6R
X-Proofpoint-GUID: GP3lXuecktQs2Uenhk2seZInvxM6yXbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=992 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110095

On 7/11/25 3:16 PM, Jason Gunthorpe wrote:
> qcom uses the ARM_32_LPAE_S1 format which uses the ARM long descriptor
> page table. Eventually arm_32_lpae_alloc_pgtable_s1() will adjust
> the pgsize_bitmap with:
> 
> 	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
> 
> So the current declaration is nonsensical. Fix it to be just SZ_4K which
> is what it has actually been using so far. Most likely the qcom driver
> copy and pasted the pgsize_bitmap from something using the ARM_V7S format.
> 
> Fixes: db64591de4b2 ("iommu/qcom: Remove iommu_ops pgsize_bitmap")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYvif6kDDFar5ZK4Dff3XThSrhaZaJundjQYujaJW978yg@mail.gmail.com/
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

The downstream driver from >10y ago for this era of hardware
suggests (at least some?) users of this driver can issue a magic
TZ call to switch to (IIUC) ARM_64_LPAE_S1, but there's no
implementation upstream, so:

(adding a couple folks interested in the hardware museum to CC to
bring this to their attention, nothing to act on though)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
