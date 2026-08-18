Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA043636A
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051151; cv=none; b=M3JQEOkyASGnbjKOuy/PuKap4TwE5J7ZNt1oQRhcIkIdIu6+5euXhYOhsmhVHqmHBlXYu7c9Ga5DOuMrMnaz4ETiR1seG/LRXF4kJUVLjNNwuUQjabU+R7lALtKQdmHCwvj3iBRI8U9sbKS5R17alJfB9+PZj7ahLeas9SOCs28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051151; c=relaxed/simple;
	bh=WD21yXFVM+n9pplisTec1nEMwf75K4Ayj03WH1COswY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beIvZrN8ww4aj2Fw/9OZd1MPUsq+t3ldAPp9bxv4TBQ85ZeDQhttcgOPu/T7Qjzb/Wi7WNyAJY3g0Ok5RylZu0Lr/79I4PvNCbV68hsJpDZUTRkkxs2BUVWoPk1EnR81zKjpxXq8B3Z4VJWLZfXO34Nu+y8N1TzgvYg1p4WiITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fuVFn2HY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iw67uKc1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fuVFn2HY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iw67uKc1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABQgo995783
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 11:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iYqV4IQW3pyNtGAkKKYZInsR
	EnU2tfnaz0FUufmmAqY=; b=fuVFn2HYd5cvh6McPla5E0KEh6NytzbOskTlJmKJ
	cQFPK1mnHrPH3aD6GpkTdObfr/C4Iu4uvHNkCR33iV+h8ut2OphptvfV2A3jYZJp
	keyH0rkdZ1yaLDo3iOlOOVgAW5JkgsQ+YTlx0j+wTeZ5aNopFFoYq9TXtxZo8Vm2
	DaZmQd3zOCbGuJ+Y8+DJhaPB4OruvAjBn78VtaSpOoi6bMMsfYr0LWIW3w4H1Gtc
	NPZtC4wk0HfInj7Q9z+qnUY0Ggba5jgTpG2aB9cP5df90phRcVSChQ0xs/etrlna
	LolEpM096LHuRu7tFZJoOJ8GEIzscp54F8qSFvQ0qIOqvA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615m22t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 11:05:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93494cce712so520971585a.3
        for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 04:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787051148; x=1787655948; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iYqV4IQW3pyNtGAkKKYZInsREnU2tfnaz0FUufmmAqY=;
        b=Iw67uKc1Z2vYSYMOhPo4s8z3AtO334abcj2d7osb45CYRkONUM5ypJnfAicLNI4Z6a
         8zDXHrKOmcgb13CaU8MjwUW2NDK8ZwNylm0tpLPphECbNeA1loA2rUEa7/RYFiexgtgZ
         iSKXTsxCCIpz+UaaaEDi32C9cj3+bjo2NtMXpLCjcewt1FJORx6u5aayht6GLjF3/lv/
         6z386aA2GRathxtUBELmeBc9Lo6LDpCpWVb5Ho0TyEzyqUde0nb0nq/+hraZEdFTSMmk
         IknU78VKsxlx0iSJmvJXllyl7vCuL/tAWXfAYWCG1/0dEzbVwTN/hFcfMcodEYQzVIK5
         CS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051148; x=1787655948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iYqV4IQW3pyNtGAkKKYZInsREnU2tfnaz0FUufmmAqY=;
        b=UCemRnZRz24R1AGn6tdc+2qZjD+cZEuYffv8BLAKgiG6jFAsbfyRHDNoBOwhtg63Ck
         slvqW1GkXhHPgf2Jv+QwB3CkYe5+oBWPXwfRd5kuw3a3c0wF6JlTF0sORpa/kaydN/kj
         CaupBQsK4El8fztfRYla6RRGoj2WnQBWmes2Ylb/yP5Jy6UPGbeU9lwHDONONEt6xpL/
         Nwedoklh+am3PxbwSsSfqbd7YLgFHhSSycaVyePsB+Eax+yiRa2n8oqkfFx6hETepveK
         YX+5JVTmVbJX7nMrS5uyVt8G+mF0s8JwZVadaNnHg/J7C5pTbFsi+MXVNAnbOnGU7tKo
         yDJQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHajAV9Aeke1GsFLyU5H0xr2hZabyXRGBEQJsszjuB3T8be15KYc3OCeSYkPVNOZzAVI6dvw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3QOtPHZ6NEtZJrkEDegvaB9FgVq3jHkQ1xZuP0KQPfgZNWe03
	W2fUpeWc8tZBIr7ZTN9VuwTLsxtu+O8REW9XN4BbOO91WV5BSDF9y6vEtqZbG04gJyLjsu6JtsW
	gosA1bPnz0CdQOnkUSy0EwgenPdRU1n4Tj2cDiftxTnxqnWjEajVLEmp1vQ==
X-Gm-Gg: AR+sD11J1ivwSIylpru9blx9hZ5fsPYGxkwt4b+sY4t8jJNVDKX5+F5AfXcbweC3jaS
	iBA4cs9T/8xGyo2MLnYB4fvd30m5c+sZoFh3GCEOnLPV136QMzfW5llR9bmtqDBOykgzSc2cvlZ
	yzqhxmajEUlqJVP4cJMc42seBetQXCsbsvFIsBIIMiHPUg/67+nTTVj7E6kZisEtbupkWUqSySE
	SlHG7AIjvFkSORgXVyzjfkD2635ynJFKFCRn+020W/sFyffm11hEoiyrbbYRrFZFlQ4vOqyHaGV
	98VbyZKZ00eiimgiJdbSoW4uZi9fIyo4kmANJSmItmEwqY4/1U044E2T6mTgiYL5F8efy68EM4L
	Qd5L+tDd46BEO5NK3SQdkF0+MpdBhAEdb9X0=
X-Received: by 2002:a05:620a:319a:b0:92e:f41d:4730 with SMTP id af79cd13be357-93704acbe5cmr619384885a.5.1787051148469;
        Tue, 18 Aug 2026 04:05:48 -0700 (PDT)
X-Received: by 2002:a05:620a:319a:b0:92e:f41d:4730 with SMTP id af79cd13be357-93704acbe5cmr619378185a.5.1787051148018;
        Tue, 18 Aug 2026 04:05:48 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b816f7sm10484724f8f.34.2026.08.18.04.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:05:46 -0700 (PDT)
Date: Tue, 18 Aug 2026 13:05:45 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        tjeznach@rivosinc.com, jgg@ziepe.ca, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
        atish.patra@linux.dev, skhawaja@google.com, jgg@nvidia.com,
        guoren@kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/10] iommu/riscv: Add domain_alloc_paging_flags
 for second-stage domain
Message-ID: <rzvdgmjkk5rzn4qehsoajmbak7jpssqancyn3mfvpnzf6wyvsc@alyg5a4c2scx>
References: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
 <20260507113706.11400-8-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507113706.11400-8-fangyu.yu@linux.alibaba.com>
X-Proofpoint-GUID: zvqdOx89G7Kj-fw9Y9zjT6IcrNeq5ssQ
X-Proofpoint-ORIG-GUID: zvqdOx89G7Kj-fw9Y9zjT6IcrNeq5ssQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4MSBTYWx0ZWRfX0zMseQIId8nG
 t1dncljl8gSxyYQlQwkQktWXmHZg1XX52WlVV2U6YkF/7KfyExcvtqF0q+2viNSwUf3TmbVXIT0
 V307ivYH5lPDRBw70Sv/JU6I/gR5dJ1DllZmlMbR5I9rkU8BpIxlvQg+Cd1fxRLgE4hCn2ulu/p
 7d58dyBVAdOZzf5ZQHcmOAv5UJKO0+nqcG1kcSbqeZDbrF7kRELejlkst9DDn8rrYkWR5VMZYrd
 uZeh7Sj2+qTeqgGKSo0a9lZ2o21j3QbWiUOVepzOvIOpwfkUGnQGe2/Kte3X8w6HfQOLUBirolz
 7PbmdIto3c9UGtoxFc61l0VwwYmke+YWlrwTd3xUVVVZejtWAaBVAwDmyuXvhe86Km5lnsmRLK5
 v0NEB6rKu7Hs+5kOZ1dSLZceyT3/wowvhwCmF43Q1EJz1+OXtHnHD6YWW3p6DriK1BwiBr2JTZ+
 JwExkQmlg8ISxDNvV2g==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a843c8d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=SRrdq9N9AAAA:8 a=GzsiVtujlViO_AMaDHUA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4MSBTYWx0ZWRfX5l6dBGLGoZHA
 GQT6fuIwNC9PumQMkJ7ErocTMnnc9Wsj6sof58fT9oU9xynTR7TWCQGNCDliwkeXLRESgaevo9+
 kA/SX/YydtwalC5m/fBs+z/H5TUyJ+4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180081

On Thu, May 07, 2026 at 07:37:03PM +0800, fangyu.yu@linux.alibaba.com wrote:
...
> +	case IOMMU_HWPT_ALLOC_NEST_PARENT:
> +	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
> +	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
> +		/*
> +		 * Second-stage (iohgatp) page table for KVM VFIO device
> +		 * pass-through and dirty tracking. The GPA space is 2 bits
> +		 * wider than the corresponding first-stage VA space (x4 root
> +		 * page table), so hw_max_vasz_lg2 values are 41/50/59.
> +		 */
> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4) {
> +			cfg.common.hw_max_vasz_lg2 = 59;
> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4) {
> +			cfg.common.hw_max_vasz_lg2 = 50;
> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4) {
> +			cfg.common.hw_max_vasz_lg2 = 41;
> +		} else {
> +			ret = -ENODEV;
> +			goto err_free;
> +		}
> +		domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
> +						RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
> +		if (domain->gscid < 0) {
> +			ret = -ENOMEM;
> +			goto err_free;
> +		}
> +		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);

cfg.common.features currently has PT_FEAT_SIGN_EXTEND which isn't correct
for the second stage. So it needs to removed and then added back in for
the first stage. riscv_64_kunit_fmt_cfgs[] in the kunit test will then
need to also be updated.

Thanks,
drew
