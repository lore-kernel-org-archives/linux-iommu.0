Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4D34CFAF
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518340; cv=none; b=EZtHkulxWtVO8NxcpljcTxFaDt+SqgfL959CNKAiNl69HSVFuj0P7DEBv+mMupZOlT26qLf37N6qQPjjOvjTA+yo7g07xqhJT3UrgtSgbLijibsDLd12rRPrBkUmJhjkaySXmF26Qd55iqFB1mlIVqM5+pXkKz+G/X65vqO5jGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518340; c=relaxed/simple;
	bh=ne5lGuOUXvClLvLqjxO8ixhn65c+c0RN0P+7qSgqwwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StembPdBVazH0Rcdc3KecjeKWCogqG8yXCuG7F7N1Y5KuWU17HxQh+w6uEUmAmr69Xc5ABYRG4AxNu8Sw+x30I21R2mjTiuL2TZCii4OMKyT8f0Fzwatls1qlBJgTKE/MFt/1twkXBnN0VU5gVG1zTM0gtEDlzsJ1ij+PB7xo3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WCrpUSk0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BUfhYEe1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WCrpUSk0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BUfhYEe1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAOokc171359
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 12:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UZmsUZzOar+YS2D9w22Y1U9KyUG6BCOh6hWMj2EvhdY=; b=WCrpUSk0Nh9wdcbh
	Fo+ten/wdGiQOiLHT0QyBFfckfZqc322d55xRVMEuU6g9EijEwIXYb8H51/vA2xf
	0edmpNWQEzfpjvPiCic3HxswW09BjH7bU9X+3Zw5fxmK2nc5a6N3BbSHVoKJ0Ztn
	+HSl2F8O1sX0y18apoVW9+Nh1PsWZRqhzTQhJ1/pbdvlJ0CSGce7fHmsr8EmknkP
	vdy4PLdcvYHZGqGwMVnaxlSqWpQbNlHyfssC2mDNKqptrTJgtB++IVG/7Qj4hUJu
	auqjIsXl19ZieAECUNN1OTY0auD65XyZc8eEqVDIkEfl9ApVUPNhqjuLTAFQ68ct
	/mpayQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a2ukb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 12:52:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34e5a9de94bso11020384a91.0
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 04:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769518338; x=1770123138; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZmsUZzOar+YS2D9w22Y1U9KyUG6BCOh6hWMj2EvhdY=;
        b=BUfhYEe1lrCaS9xIKFlUbr5az3N03ztX8tnoj65OxZ2DDtdG24Rc1taNIhoosImwUp
         8B/gsSVZ/AD4VRBiWZpx6styFHYNOkTTydDBerziceTITAXopsDo4o9WHajEhgXLd60x
         lDuknT8EzU96GVSzeeM3FMCN1oHadmUHz8fRdv6N+xdkynsAQakrUMlqKZ/YUT2ML2Sg
         5I2XTFAXrpgIl7CWXPSVRQbGkZz44o7FBHwqSqwYFS/CBX4J7LV9ZKy7Ed9TMtg/fyaO
         DFroPDGT8wt9b0CDaLBhAYbB0J4DFJMEkYbFKdXbvZQYpiM7NLiOs00WAbrmR1vY/TP9
         5cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769518338; x=1770123138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZmsUZzOar+YS2D9w22Y1U9KyUG6BCOh6hWMj2EvhdY=;
        b=K3KjoAQrNMQYWFH1B3CwbDTz8w21b+DD4+u6kBij4xoD6ZrF1gGhfJ2qXvkeMhrBgV
         7ya+2VXdNUNuuBPvzxIUF/MiNcrvWjvI1TKYHqjC+iWiLCSbDqGEC07KtxUwC8CTu0JM
         xBmieBgrsgrLcYXhuPWU/WFOl+unSJM3dj5QQLLyXQSjN6/KuFDuvYv6QtT0CjAyjKyT
         KQiCycff5h7GEULGexEjS3SHmQZjLrbU6i5PGDvxwGWylxmVLrzksoGLkgJEgzMxZwjE
         H7Pf6GzHfM10FniMCV0Xiic4S9E+qWRG8qzNFQgW+Qcqnp25phnLhtW6R7G2SPTmqNcz
         p+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5dU39XF1B8dGT3p4bf5Bxe3lifVe/kRs3MXJmzLWUT+AjUg+4jjcM1SoqA+3bKw2S7JHXHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQSMarznLJGRjj6+t+zhZNJGQp5EuXK5UQPOqcEKgk5WGk/IAU
	jZwy9k7L5FFB+Urls3hAbiGLcMUX19qKbGn9fQSFr1kvIArOdCdsIUC4gWqgSs5VAPW5JNJzuvq
	jSdqx8nr+lKVGmExZL3zh77aQFszdr6yWHKgWg3VEmqZjfMQLpZJmhB+9IQ==
X-Gm-Gg: AZuq6aIRKAGMzz/UCTOB088PZ+96kfipSpevmsP3n8/dUSp2inAVwof+husGutRCmIa
	9+nPb9JltlsS3AvZluN3BuK8j/qyQvnI73A+t5NGBnCHrP5AVRQrJX99AKHscCQY43qM+57mJm4
	aB/L0L2TbIg1LhVwic40+w/jmWkUjYhAv8grv5Y9K4mlPF+rFHJ8DG4hXY2lZwWQfneybFj0et6
	ju4eBQ+s9JzzPAYM3JUxurHDKOY+nAgXQG9X7j255wGNP+RdwE0tSZ2vd002iOJ085Neu4cGUxp
	YIMmffUKiyexHvuPf3s4KBi2rdrPg/l4zYD63uAKRudCsGv4wtHqYBZ1kgFtiVSM9XVJ3THmovh
	H4cp3J34/MjrITtb1Keo/HpBf/jNYMQw+
X-Received: by 2002:a17:90b:4a88:b0:353:2e1:9605 with SMTP id 98e67ed59e1d1-353fecba4efmr1642194a91.6.1769518337660;
        Tue, 27 Jan 2026 04:52:17 -0800 (PST)
X-Received: by 2002:a17:90b:4a88:b0:353:2e1:9605 with SMTP id 98e67ed59e1d1-353fecba4efmr1642162a91.6.1769518337184;
        Tue, 27 Jan 2026 04:52:17 -0800 (PST)
Received: from [10.206.103.12] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536aeddff9sm5409630a91.0.2026.01.27.04.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 04:52:16 -0800 (PST)
Message-ID: <9d3c78e9-db4f-4ffd-9097-f48e73d62c8d@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 18:22:10 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Use pm_runtime in fault handlers
To: Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
References: <20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwNSBTYWx0ZWRfX6ydNH8fZg1YR
 nZMrWY6QvSMgA6VyROdzMLUA5sk//OwxNVnnXHWeaXEzX5Kr4TD9k9i2Wj7//qsJczNX/9QGWDZ
 nmHBPE5G4t4311CFEaARq+lOIBVXN9vMMo8DN4DVuoq1E9/ZB8DerxSCYUaN55wd9Bq85J6uzQF
 Kj+WhKcAxnZ87Fgj+jwERJO1CF+Wwb7zXI4huL830FHof9V11Eua2WU83ncWcQMMvv29pTCRrFi
 GxhgDVIfqDrDFuVLjg403gLflnkZ3gYlgLQ3IK0uVH0gqbwiIuy0oRBywT0dntcjQKQ0xhjmAqF
 NGuM/WNI/36dwXO2M9qMxfJTraASfJHV4TL3A2Vcj7+qP2e1DUsytvf1S8oefDWWHe7MBKu7GRD
 Pz9nUbURNosvu+dBQWQy9rr9/RW43BEfrtKOfeqDI793qdzgkP3eDbJDsAHxxSYpD4sI7SHgIzI
 /+j9zjGfrEa4qgUiL4A==
X-Proofpoint-ORIG-GUID: rjlFAytR_Gjg_bSvp6pU-Qzwg9XwyZrr
X-Proofpoint-GUID: rjlFAytR_Gjg_bSvp6pU-Qzwg9XwyZrr
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=6978b502 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=hxDPLbPtHj1mDd5Mi3AA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270105

On 1/27/2026 5:41 PM, Prakash Gupta wrote:
> Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
> enabled pm_runtime for the arm-smmu device. On systems where the SMMU
> sits in a power domain, all register accesses must be done while the
> device is runtime-resumed to avoid unclocked register reads and
> potential NoC errors.
> 
> So far, this has not been an issue for most SMMU clients because
> stall-on-fault is enabled by default. While a translation fault is
> being handled, the SMMU stalls further translations for that context
> bank, so the fault handler would not race with a powered-down
> SMMU.
> 
> Adreno SMMU now disables stall-on-fault in the presence of fault
> storms to avoid saturating SMMU resources and hanging the GMU. With
> stall-on-fault disabled, the SMMU can generate faults while its power
> domain may no longer be enabled, which makes unclocked accesses to
> fault-status registers in the SMMU fault handlers possible.
> 
> Guard the context and global fault handlers with arm_smmu_rpm_get() /
> arm_smmu_rpm_put() so that all SMMU fault register accesses are done
> with the SMMU powered.
> 
> Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault after a page fault")
> Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>

Acked-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil
