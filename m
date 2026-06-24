Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E7378D8D
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328701; cv=none; b=dDprkH385roeqftoVymGLDWWGHc1/W8YmWV/AjZ2v+AUPjW+fQlf8eoyxqGFufzjO7TP6EKFRpKZcqn7EfVNjjyCqMy4eC2DufmsdSlN5Lq/fSpjP9oM87OGzdJ8vC84IEhgDvr/nsUPOIhLqaAt1RA/zLQAGoihVx8KbSv1094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328701; c=relaxed/simple;
	bh=bKGyagwGNYczgH+kSDgfBX8Erf7GoVV3fEN3v0ydR4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGwmIfmxkTC6bVZ2HwNMsO18idNAoe4IE8lyqxlmKjnjJHM9WOaImm2Uuw0YFe35pPoYIjWsXuPbSBX6NXh1P2Z7K2g2pxLhNBkyhwrLVU14grTRKQHDexLjbncRrhEVGYAmVKOT4srTcy+XdLQNMYja3dt3j6cpbtejhXnUvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PfZ9dcVJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IF3XWIIP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PfZ9dcVJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IF3XWIIP"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OHiwrg977583
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 19:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=udgVp90SDPGbIOBxVnWXY1WC
	LuwoS5DPJrSoPLrCVAk=; b=PfZ9dcVJORqePQBzW6lwOsScDqmLHXoFBPAABrVB
	bl8NOEwNJVPz9F9RRiSwOTATqeOzi3U4tl/NWmovo8tLZARr71QzD3Nvj247z/7B
	wUxopQM6lI441zU39Kh5/IbvZ4nbvjK89ycUV8zk43XBo/rCedhW2l/hJlpRX8kC
	xoJWddo8113178eb8tBHy/cRjseMUDJWkS5OrCgxO17s3qsMTuEVCXyHCOeUUOli
	CF+poZdKWpZHRdfL5Cm4weW22j9M0XkyMKZIThomhDyx7d4d/8nrSCQNyLt+Vlw9
	+cF+GD5Umoj/xlmvilnzAt8KiEMf9FoQSjzIYt83hKPyKA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0aqpav9c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 19:18:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8969083f23so909619a12.1
        for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782328696; x=1782933496; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=udgVp90SDPGbIOBxVnWXY1WCLuwoS5DPJrSoPLrCVAk=;
        b=IF3XWIIPzRpLZ9oCqjdl39GGqarQ+qvL/xDe6uSvjNnWlQh0Pc2H9NxN+oV190DBcn
         oKhdpQb096c7hxMdbTjQjl0rnvQNDJJPW5pTXMRMiwT9CJgbu/I9HGY+Qf1f5m5qxMb1
         9TlwCOT9IHyE1bp1H/3AfBO++p6uAOOONyDn/o65fwHNyzpQEnOgQd1Pdpwc1tBn7in0
         AOHwUPS3MnC5Ad42ayTqpNOEHvTZln7CktpC9HpBkDdOPBtgOe3cMt6rr+YwKJ2ns6gC
         th8v0mXf235BeTUHMK2DXR7TAdtlQeSD1Ri8rynanz2DugJ8V3kmNqgfdh7OR6DcwHMV
         QPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328696; x=1782933496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udgVp90SDPGbIOBxVnWXY1WCLuwoS5DPJrSoPLrCVAk=;
        b=RhX7EBLtKuNr9uRRwnRlt2I5TO/w66I+7OyfQlYpoYO/bRlWoDmxaFmvIieq6bivLs
         OR3kNRSGBDvjAps5ehVH5XpMKIjCEy33UpMzYBUUo1b0mY4pWQU1tLvZqJT3mehgAWzY
         LpRWZJGi2Z5aX8f3vcQMFeIy4vHiOdjTmhvvIZP6e5WMLTrEimTdNYqGhw4J7s28/0zL
         Ccwec4MlurzY4gAHAkNYXupAd4oabOoKiwr6nfJUGMq20K1/WPtua7NcIg/N3VQ973Ps
         AhkQC8loTNNk7okKFW+DvONkwM4r7Vi331IGqJnPLr41Kr2HmP+nQ81KENGNeRZgidFJ
         Ruzw==
X-Forwarded-Encrypted: i=1; AHgh+Rro6x7mqE1urLhmlvkth82WZKrpEHhor0Ol/Rp7jbzMKgs7LyRrmy+HIYHzwetBTXFZKNr3Ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDOOa7G36YJS0XhLeVnWaQ8osvH2GHxlyOySUHmCi48TzToFcn
	w40n07NKvTA/OwUrSBBm+6Kgmcxcep02stOpGgVeCdyvAbGL+mLfljdkj5Rca1wnbMazJ+XMg+c
	UKyWxlZdnQUOsT0/Ju7ZAEqK+GFucBgoogqKrn1BweyuFyx/02gX00BegaQ==
X-Gm-Gg: AfdE7cl8ITNMcbqdvJLPX/XQiwb+4ew+kzF1zkVdWU0NjM38ZDMegYmG2oS+Ms6szSU
	yrIc4mFknS13gXm3RyghVJNXRae/y/2GAtTHEZ9KkMBMffmwBszlEBLuJ/f0++KmQ8qb2r8L989
	thJt+u5ZK0T2k8zESHxWxXvW5CWyvHUMMi8emnqjqUKumfOJwfLt2yU4cx4Zr3s7loyBYAyrS3k
	C57pyuhJySwBh7ofPvvxrt+8jigQw73vweifEkWc2uGg2piE3a39bhbQyAGf2mSeL6ajMi8+fml
	yVT7MyW59JzGbRDxrbGtP7GDelWPOpKHQS3oAIpq4pLz3ZvB8igoiJp7wLo+3ui0a7xmVNyrSXd
	mKQqTPUD2p9SyzADE5Ho2ZsSnNKY7w0eHJbAq8w==
X-Received: by 2002:a05:6a00:b52:b0:835:405a:7e6d with SMTP id d2e1a72fcca58-845a2793df0mr5859860b3a.21.1782328695829;
        Wed, 24 Jun 2026 12:18:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:b52:b0:835:405a:7e6d with SMTP id d2e1a72fcca58-845a2793df0mr5859828b3a.21.1782328695233;
        Wed, 24 Jun 2026 12:18:15 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d272asm2893385b3a.34.2026.06.24.12.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:18:14 -0700 (PDT)
Date: Thu, 25 Jun 2026 00:48:09 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] iommu/qcom: Add NULL ctx check in TLB invalidation
 paths
Message-ID: <20260624191809.pkpppasztzrbnfhf@hu-mojha-hyd.qualcomm.com>
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
 <20260623122034.1166295-7-mukesh.ojha@oss.qualcomm.com>
 <3463e5cf-05d3-4e4b-ac22-699e5f95589b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3463e5cf-05d3-4e4b-ac22-699e5f95589b@arm.com>
X-Proofpoint-ORIG-GUID: oX4YTFGMTrT0Q0lrHiVwbU4hCuGb8kBm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2MSBTYWx0ZWRfX7vUg2m/Urq5o
 yIJjc8CnYZFytcwVa07LKrY50wlipS8JVlIBkvqxSQf+ifJ0vd3uYFrr1qESzD9wDpaKM9i0XN1
 sMYbVi2g5+YOC1afpjYCN5n6KNK09hgcOhLUjse9GmiShFBJL8KMHwlBRvnMHKXjTYQJy0Ljgul
 /4dJo041pDRQD4ePQf2hLbezUSn2HzSQAoxg3bM3eqccUGaqp6g1Ku28PFTW+tsFiSgr2M4YYTt
 dpx2F6I9Nx0Am+2oLcMoHEaR95wXYsBwp1pAuPoJoZ9D/zjE1mHqW4O3uM9CEchEjTk3fvA+xIb
 5lBxMtTzQuZa9NzQGVTm3cNmQ/5LL6M8DZbNxstTfoQ5ftVqAQfSfFM/4F7xJdlwLrU9o999uA5
 irfLMb2xRJUVwfmOC/fCxcRxN9CpMw==
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=6a3c2d78 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=dwmHPF28QfX-zPQw6RQA:9 a=CjuIK1q_8ugA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2MSBTYWx0ZWRfX8B2hM9KD/Fzk
 IuOiE7j42VYS77cIm/BCVlq8IJuKCoFwt1MStERvUwhvybMIw+o9FAHJKTi8mjrHBBd7j/yxrlu
 meUGcqwPtMCYjqxVgowymqhqqZJpIDk=
X-Proofpoint-GUID: oX4YTFGMTrT0Q0lrHiVwbU4hCuGb8kBm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240161

On Tue, Jun 23, 2026 at 06:08:08PM +0100, Robin Murphy wrote:
> On 23/06/2026 1:20 pm, Mukesh Ojha wrote:
> > to_ctx() returns qcom_iommu->ctxs[asid], which can be NULL if the
> > corresponding context bank failed to probe or was already removed.
> > qcom_iommu_tlb_sync(), qcom_iommu_tlb_inv_context(), and
> > qcom_iommu_tlb_inv_range_nosync() all dereference the returned pointer
> > directly, risking a NULL pointer dereference.
> 
> But if there's no context bank, then how has a domain been allocated in
> order to permit io-pgtable operations that would eventually call into
> qcom_flush_ops at all? Can you please clarify whether you've actually
> observed a real-world issue here, and if so how?

You're right, I haven't observed a real crash here.
qcom_iommu_of_xlate already rejects any ASID whose ctxs[] slot is
NULL, so a domain can never be attached  and therefore
qcom_flush_ops can never be reached  with a NULL ctx.
I'll drop it.

-- 
-Mukesh Ojha
