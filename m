Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE146D56B
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540694; cv=none; b=hHQGmpPx8WKQN8vb7Xj3edWD1uxDD1xlMW8WmBHHN+0xIgi6+ZKSbHBqfRaGx7b8AdY2TpbfTlTRNDQ8RtQ3IcpD3kOD7aK+a5BY2n8yWWZualdHToTzZe/FHXwgP7sljl7idOMIQ70Lnp9wB6ChEna+83rPOBCSHQN0QkF8PaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540694; c=relaxed/simple;
	bh=PJiCTK+xZkgf4C9ajys4XEZDwBELG3C+cWgGLnRSAMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXbNhBopux6Q9r/GZjNTLng3C+SR16J+Odr8l81o5jvtQZAShAxhB2K2WpAHbUrNggVylJOLnOEfzUTy2FgcSw648JFLKzji5Zbx4dApCKTtXDU7PHbzC5vF2Y/DJ4EvurJ+Qmm4o0pRWtKw92phsS8XkKD4bEbfbeh7EtSdoV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B0Es9AhR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=URM1eWBX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B0Es9AhR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URM1eWBX"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KJIe404416
	for <iommu@lists.linux.dev>; Fri, 9 Oct 2026 10:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9hWw6ijG79i9KKO/GsUNkSlod/iFx3QaGdrECeuKXoE=; b=B0Es9AhRU0OYIAlk
	2jrbzCTxp6K0FjJNYQif3bdLi3/+BMe/Plku3+XP1/VCNoEFxdZMLIUDK5BqBu1h
	N8OJd9XcXIiD5s3jifoP5H7gtBCHDfrE3waSj9uJ75COUzY+wJOy6w0d+Ji4e5bK
	efGGqeu01JuV4zwRNbFGRNXnXkKhcPtp4dZ3UQ9pQuXx8ur/BMRSLJJvQEOqYJ/v
	8zRTvbvdsu7lCX6N1+8rVq8glc7zeCWqMUnZQ39LqYBOsXMJ7LHvrSTmYQZ4PGUJ
	qf/zeCWMgD7LkRrSOO1pkPdghqxpNi4FkHOGwflHQEw8n3ed71QowJs0xypoqVT8
	qMcx2w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk32vt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 10:11:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39deda201bcso9570918a91.2
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 03:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791540691; x=1792145491; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9hWw6ijG79i9KKO/GsUNkSlod/iFx3QaGdrECeuKXoE=;
        b=URM1eWBXtz2gQ+oOSGFNLq9jcYwKbi50ml+PJYvBCrTu2rzBhrDpGIIXGMFny0q8RP
         jNP+sDVK0Ao4DeDsCA1aUcIJcLafIC5NgNGpaglcCsD4ZjuyrSk8Q141poh6w6TWgnqy
         nB0LtBbpQmsNSrZrE0h2ObPzMAjGuZ3rNKmghuuC2CP8CfTEr1uCmy0XdADtr6FjdbzH
         0nmLK/+9JZLhmdwFnrMQgdRRW/sdo0OD9oFzX2t4h2Y2Ee6aeZvC9NDSr+XjG6ko7fhO
         rl7UtBUd+1Qpxa4YCdcQXDnHDBebF0+41/rIyggNxV+AmsZI/5Qod+6fxd5Tntfy8/zl
         2EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791540691; x=1792145491;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9hWw6ijG79i9KKO/GsUNkSlod/iFx3QaGdrECeuKXoE=;
        b=qi6R9fWFVLyq7fvU2nIe/w9SbTUQaP6NFqHfmYxyORKjv05UeQEO5B8f8gBcNf/Jbd
         aNQc62aQyCt2qoFB1Rjsx3K6Kntb1h4BmYO8FhDCX2cKOebtTbCH9TNk3UKQe2vIGuW7
         bWjqQwWr3qmvAvq89pWeXu1hzUlZ1OiNCT2JJ1/RsInMsyMcsaLrwiO23RozU94j/POs
         SRKX4EI4Ki2HHQDSLn6FeXbW4ACl7e7+1EWU8d9nbvIA3RJRnhKeq8ZVYbWhLCO+uz4+
         LPDfA7pfZOWwfqmrdbwB5sqYsI5oZnArqfVnDg1e9DRIPlmB5Krm74nR/rpHT+yu3yzm
         FrYg==
X-Forwarded-Encrypted: i=1; AKwUvBwsuzr3mqOKoqeEoenzr5DTAYDsImJOCwuPEJGItwUjUWEoVbEXV/38Y+9CWwK0rimYKCqHGg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJFF9sQU7/TbSI/qzX4PG33kIUdOu/S2DssOIALw6r94Yx0pmwM
	eRsXb3dil2DymLyUSS25KlnBmOsB00w0ARds6rly2yXpyDkOjCznFxwhQtfoFJ+O4/aDqKPOr3i
	uqu59dW4Fa70qm/yMMgUjV93YW0Mv1lUWJSfkjcZ08FCSklL33QVN2/5LveRRQUBs2A==
X-Gm-Gg: AYBFou2tk6O3nBdZrt24HwKVysxlmSyi18IWrijQ6H+0zZ/088D/GUR1UABgI7gAKl3
	sdESs4XZutIQDhEwznNQgAsCiVWUqSS7asb1BPJDs6BSQDqnEMWEuInS7MoCC0mrVgrIJJN6Mov
	nnLCLk/xcO0xkZCHd3G7YPJAqXqKSd+6t/FAewqEtRobWXAe+J0pmdvY6JZAQxRNG5gyqo4D388
	sFE5+OszSqt2MyXfNDedx5dI9vf63bqNeENgHLndhrExKGb5DV4qaRTA/e4Ap/nWfEBB8yO4UVR
	tbOOeFKQd8lq0d/q1F8hJ/9a8z/dHPBZvOQOrQwH8hw70s0kCm+s0yi9imqZaZNfipJUAlSA8Za
	8Hy8EL1rInmjqCD7PmU4e/A7EjnqZInLh
X-Received: by 2002:a17:90b:5887:b0:3a4:a383:f9cf with SMTP id 98e67ed59e1d1-3ab3a9a78f8mr1583036a91.38.1791540690330;
        Fri, 09 Oct 2026 03:11:30 -0700 (PDT)
X-Received: by 2002:a17:90b:5887:b0:3a4:a383:f9cf with SMTP id 98e67ed59e1d1-3ab3a9a78f8mr1583010a91.38.1791540689904;
        Fri, 09 Oct 2026 03:11:29 -0700 (PDT)
Received: from [10.218.39.50] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38fc9e52sm2744168a91.13.2026.10.09.03.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 03:11:29 -0700 (PDT)
Message-ID: <40fc4ba7-c016-4b91-afdd-5443869a4b4b@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 15:41:23 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
To: Jason Gunthorpe <jgg@ziepe.ca>, Daniel Mentz <danielmentz@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>
 <CAE2F3rAMAnV9+WNLZtGQX6cHPsZ6wbfRJ1Z3d5mF1+8WHL-uMA@mail.gmail.com>
 <20260924225534.GD16465@ziepe.ca>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260924225534.GD16465@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fKesTpae c=1 sm=1 tr=0 ts=6ac8bdd3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=_TL2m7dhMTXhWvRYaIYA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: HRX4T7D8IiLOq_AoyVFV3EA6odIEcSpj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MCBTYWx0ZWRfX37VeFseRGAdp
 USsMYv3ZQEmyK3CxQzxIDprSQXoOx1Jbo1fLgZpLbea8EkorL6nYf/ngxbKeGl3xSmPSdxVUl6g
 h6zkiN6zfZvPy38xiiOpN9n+SwPjMMo=
X-Proofpoint-ORIG-GUID: HRX4T7D8IiLOq_AoyVFV3EA6odIEcSpj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MCBTYWx0ZWRfX0z2nidKLfg7U
 N8FzgnPlo59TVMyeYSBzRvKYHhiOxzNAb035wishwQVN21aCZD/tnd6xgh/0qt49EFNVQWeCoxM
 L8+7549M+ohoZAD9ogkVWdQYZEOUmYXKpcY25Qj94DwI+kqHht/VCASVCFd3YAw5Hf2UDFzI7kk
 ozekIe91RNRtT+4UDhP5uZIbPJcolFoKNQeXRzT4tP2HWYxTDrjpzD4ge0/cQLOkgd0Mn7n7+0R
 mqxpYk2sNseHvHs15BwBl7n8wDGgN+eUNBzLBFYbGEQ43fI4YP+9QTu0XlH745gUGWCkB9qOUVg
 SPfEdnpki770GoJfdhOqhWPHXpCfN1nUdTjmSF4LqPlCS05Ad281RtpEgo5cpOA9gENEAC8xqJI
 SvtY6YJ6TWDfrTTE17WP17rbB1oITyjWdmoml3WPZghJ4NZ8leO2o8AXdMPP89LrUaPIKaFZu6+
 KulR9r7Wy/bplWB7FtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090040



On 9/25/2026 4:25 AM, Jason Gunthorpe wrote:
> On Thu, Sep 24, 2026 at 01:36:12PM -0700, Daniel Mentz wrote:
> 
>> Interaction with Hardware Dirty Tracking (IO_PGTABLE_QUIRK_ARM_HD)
>>
>> When Hardware Dirty Tracking (ARM_LPAE_PTE_DBM) is enabled on Stage-1 tables:
>>  * In visit_dirty() / arm_lpae_read_and_clear_dirty(), dirty bits are
>> queried and cleared on a page-by-page granularity
>> (iopte_set_writeable_clean(ptep)).
>>  * If a single 4KB page within a 64KB CONT group is marked clean while
>> neighboring pages remain marked dirty/writeable, the descriptors in
>> that group will differ in access permissions (AP[2]).
>>  * According to Arm ARM D8.3.1, all descriptors in a contiguous block
>> must share identical permissions and attributes. If dirty tracking is
>> active on a domain, consider whether IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT
>> should be set or whether CONT sizes should be suppressed when
>> IO_PGTABLE_QUIRK_ARM_HD is active.
> 
> This is right, handling dirty and CONT together is a PITA. You should
> probably make them exclusive for this simplified implementation.
> 
> SMMUv3 is the only user of dirty and it will switch to iommupt which
> does all this right.
> 
> Jason

Sure, I'll set IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT when IO_PGTABLE_QUIRK_ARM_HD is supported.
