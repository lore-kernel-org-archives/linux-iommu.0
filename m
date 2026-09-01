Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B21D5AC2
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270400; cv=none; b=bD48wAmnK+6v+WykLig6g3KH3eXyvFVaaoZKoXnNR2IrTITJqPk+/HmB5sCIS/GvFgP7p5h1+x+Qn66VP6ZBTamf5cjviirDS1H9lRENgys5OTcXidVL10BvlMqRt69D4VHSm+CO85OzMRzDfpi2KOr8Doy/isepFfxQ1BpPKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270400; c=relaxed/simple;
	bh=XhouFcGaXkX71w73O+gImeoNh9LkZ51129t0CpL4kJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSen7sViVZ8T5zjufu/z2m1DoP4GoGb+5TSQFLrHzni/vWS4mv1sAyOjZyKWv3QXbTouhU9DAnaW9Ud+XKY5esjDrgf9vqbUUyExg6RHEstrqZ1IzW4yrWYuKKsMKWNkMCu3gw1x5mq+/bZhZDVnQY39OyrtYUCdCTmqjQhFA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TpJPlRuE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YOYfaBhK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TpJPlRuE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YOYfaBhK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681DVjaB2064683
	for <iommu@lists.linux.dev>; Tue, 1 Sep 2026 13:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1fLyC2LJrsM
	PxrmgLgJESqyo9n3KdTEyY8OKdLzlv20=; b=TpJPlRuE09hUQt5ujRbsxtN4hHW
	aQJG3Pd3y80qZiMkth3qtVPLWthdPCJEamQkRVoBmz53Rw94Z3GXGa4u2v2c+ERz
	vtqkNV2whnUchFAb+0v8jVtTnVLg4hHR2eRtmL0Ahcg3JweOBNP8ii7Eb55/r5W/
	iLpOULYwGL0ht0M1hxlHiFV2i1phYsS1jWvgxMYn1Sf0J6JWZ2lz/o21MeDYqfB6
	kPRPRLniEtZ1izpEF0xQhIDNbAJ6LDKQA5C8DdYPQEoEor5/vNe9ydxpBmEDfp/5
	4r2foM+JY2b9PDpsSIiv+YifBlx8RD4uPpCmLtqAXgQMabMyq6qeEPw0CEw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdnk8tw6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 13:46:38 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b3962f71e7so6791791b6e.3
        for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788270397; x=1788875197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1fLyC2LJrsMPxrmgLgJESqyo9n3KdTEyY8OKdLzlv20=;
        b=YOYfaBhKoFMUOm9iCSB31X64W64RZ9uXCyUNuKnOZS5dILn1vwBVupwjMbC7LlmJsN
         bmaAGhajS6EtoFBMjF9QnO1KcBgHyN3v6dMEf+GJLqoeKMBjwEDHVP9QW2eloO5w6HtT
         39sYbWHl7xsmWQ9kJjy6xebyROzXkoL4uQeKO0UGJzaNYsZ2t+JTugD0pHk3GxvpHc0c
         AUtOkVKoEK0JrsUqumAe+a7TIClqpR+5ICV6he1rwv4T78ny+oDpXXXVcUnNWU+utIHh
         TU5ZLQiCO0I5zC1HADxPDbiwYd0+7tGb/sHEtGIUEOh2Yk5NTKOqDN5RJxnnPVCCneqn
         AX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270397; x=1788875197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1fLyC2LJrsMPxrmgLgJESqyo9n3KdTEyY8OKdLzlv20=;
        b=Oze9Mevy6zPREmkf+W2NJBklJGY2TIMFbPI/doS58oq4uvzaBarvxvTGvbQnSdyeAZ
         ekO9hmYPjj3CLs0rqVyGJcImOcUUDFIXMiHffU+Bi1hxqOqJDPAuwfDmmNjMM3Wyb3z3
         /unFA/2L+AijffMZPvQo6+xy69GiT3dwyMYYrvC1Z01rBZsOoVBEWGEOTwvHTlCe+FEV
         x57WjVLyBH+a19umf+s3gAooAQl6Ek9KD+G1j4AF48q7InqfLI1KHaha2nAOxydtAvtv
         Zf1cbGlKn6RGo0WKyduygtHVCAefX83B5mAdcXophd32RukHx8QwJpcNckWLGJqBs4eU
         qI7A==
X-Forwarded-Encrypted: i=1; AHgh+RpQNv6nkgAwdFsJmgPsk4Wv1+h2ZhzJnEI0O05rhx7ybEIMzwC+dYVhexVAw/QSSRF6fJBv3g==@lists.linux.dev
X-Gm-Message-State: AFuF++kTNtIu338eZUfYgN/GeyVPn+vRizDRqT8Aq+ysQUnnDJElCW+6
	qvnlWwNxAaUxUUzRjvrF//z4sjYhlSdc9r/nRn4/L3QG/BvmFTyn+OgRlwNNoFnbufS51nbXyMx
	Ttu1jFTx3y4q9f79X3UH5HcKFcTK5LITFkIM6wLk5fVby/xIaofcoI5JMQQoqbnl1nA==
X-Gm-Gg: AR+sD11rlTVxryzO8vUKsz69s6jZMvLqu1uWzEBWGWSnTbQb9MN8zbcrGsfY3dK6v32
	R/nyaicgADHWoxgvn9Wrj3U7Q42x83lhtApPSLLBbgO00tc3i1YXvx/zq4aNHN4gYWQnzo0IgIz
	PaD8myW/+e8OC/fqQpBRMlp8TWfnzZ+mSYTb0vH+xjG71VKnqLRMLhGxOYBT1Ng6kO3H7Hgj7W+
	7KIBjfFq5WTW7lmvVrHaDEodQAFD4keS6Pz6PGAPl3fpg/YwTti7DgPaG5DQZX02istKx0oxVrx
	+NUvTak4gstsVrWU6fyLQtW7GvGSxzW0vc6dKjX1IEsAyLw8BK/UEQH03uyLew2ePpnqvL9E5xz
	8pOjztqJmeq+CrQRedHwxlCNUQU9l9Hr+ah8=
X-Received: by 2002:a05:6808:251a:b0:4b3:7c33:456 with SMTP id 5614622812f47-4b5b81720ddmr10017174b6e.11.1788270397172;
        Tue, 01 Sep 2026 06:46:37 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:939:69a:4764 with SMTP id af79cd13be357-93948132492mr956841785a.39.1788269920915;
        Tue, 01 Sep 2026 06:38:40 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b2901sm582378466b.33.2026.09.01.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:38:40 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v5 11/17] irqchip/riscv-imsic: Add S-mode MSI address list
Date: Tue,  1 Sep 2026 15:38:34 +0200
Message-ID: <20260901133835.345001-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831145943.313726-12-andrew.jones@oss.qualcomm.com>
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com> <20260831145943.313726-12-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=f6p4wuyM c=1 sm=1 tr=0 ts=6a96d73e cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=rNTwnVtw_qv2rMTDxuYA:9
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyMiBTYWx0ZWRfXzmDOBOwEW2n7
 8QrL4c1zn+z46sp1JbQK34zZwtURA9tQyDyFo5PLzdkQogvPGdKpl/TCOvKfM4iKjnYuvWwJ3sj
 YfJOMnmHBcuGDkEKsDYHc0ir5mUOeOqteKykm96HGO2FXa3vFH58xTFnE0xuofmPR8WgFq6C0vy
 zL3rSFY1lugx5CZYUeQMebcKgziCqmwjBNdoaGVwF234i4F4yIDAL7Gos7axicwfdSiVci0B3vw
 J0mvpH5Ubpi3xFP2X5bEnZR660+ujzIlsyPjK0FEvDBT9f/44gZMVkShXqeWFYoy6+3rO3G9XiM
 NBk/S9f1bSn+1kBUDUxv4WaH2NGDZK9w3ZLoWDTwigqSo2AQSTei9Vg8xqPrEA9o4pK8hfutwVg
 HkYQ+Aie6qKkBO115EUAF7c5sqyjB4sbkEqQj5e9TOeIbo/2nqNtIA3R5t0kdKls26Ar+JBMfi7
 U2CpZ1DhCna/d6PnUmg==
X-Proofpoint-ORIG-GUID: CHtj69PCu6CGxp5EWYTmbhI_qLKhjuSW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyMiBTYWx0ZWRfX1gTpcrDKWpgc
 ETirjPC7NrvkhcnTEyyFSSpfhdkPyicQ0YUkxHmjcDjosfD5arZaild6ym/8TsvT1gJlhUiJQxk
 b4IuzWb4u2pte6Qni3hXoYsHH2rGiSA=
X-Proofpoint-GUID: CHtj69PCu6CGxp5EWYTmbhI_qLKhjuSW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010122

A Sashiko review raised the following questions:

> +		if (!local->msi_va) {
> +			kfree(smode_msi_pa);
> +			return -ENODEV;
>
> Does this strict requirement introduce a regression on systems with partial
> IMSIC coverage?
>
> By returning -ENODEV here if any possible CPU lacks an IMSIC mapping, the
> error bubbles up to imsic_setup_state() and fatally tears down the entire
> driver. Previously, imsic_setup_state() allowed partial coverage as long as
> at least one CPU handler was found.

Partial IMSIC coverage is not functionally supported. The IPI and MSI
paths can select any online CPU and unconditionally use that CPU's
local->msi_va or local->msi_pa, so every possible CPU must have an
initialized IMSIC page. Returning -ENODEV during setup therefore
validates this invariant earlier.

>
> +		smode_msi_pa[cpu] = local->msi_pa;
>
> Could this assignment cause an out-of-bounds write on systems where the CPU
> mask is sparse?
>
> The smode_msi_pa array is allocated using num_possible_cpus() (the count of
> possible CPUs) but is indexed here by the logical CPU ID. If the CPU mask has
> gaps (for example, if logical CPUs 0 and 2 are present), num_possible_cpus()
> would evaluate to 2, but this loop would attempt to write to index 2,
> overflowing the bounds of the array. Would allocating based on nr_cpu_ids
> prevent this issue?

For RISC-V, num_possible_cpus() == nr_cpu_ids because RISC-V assigns
logical CPU IDs sequentially during both DT and ACPI discovery and
populates the possible mask from those contiguous mappings.

Thanks,
drew
