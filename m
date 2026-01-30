Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C1388846
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769800892; cv=none; b=sB+xMfPpTXx9D/KiWJRR2MQf5QFsq3UJ1AD/AFX5oM8qdQSVlSzzFpBifW6XIIWB3k1rDbRHn+lU7GYs/hESPROKdQvjzsSzY+r652Ztt+ickKj7scHTwEPJ/YYqv7swK8spwjXWdqlm+mW3vQJnsvI02ERxRopAwmTdfdTtPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769800892; c=relaxed/simple;
	bh=sMRVweWWKDbgePPCd5fy+chhvOQHUIgUpifKLGvW1YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK+aqMPRvY+SzNajjMTN9o9X/WtcLiSTNqE7T05AHVbHelI+181nphpl5FgCBHY1NxNTqiyGnLNj4n1+wXHlZLCCxa6+tFIjJweCmFNeDW5IJ/FfCfM47fJ6UB2N9vt2MGkqYrFHXblAUDgG88xsDTkNaJ5bTr/TfYXsp0vkNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZqsK2qK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ULlm0r/Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZqsK2qK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ULlm0r/Z"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UHbl2U2675381
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 19:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bXe9Lrt7dSp+Dy1ApjFhZbK3
	Rd1JE1rBVyTVQSittNQ=; b=SZqsK2qKpHHoSsFrI+E5IyhBJgdCVpnxw9YwrGUW
	Sg/dTSZPenHA0gQ8UIMth55J22wj3SO4FrypsAMXbijrAAVb+41nHk2S8d3pBUTN
	rantylkNrSmjP5LZlCQVrdhfYlWmzQNgw4t0X3ebLmrFuxVLDIm/Y2mV4LYyou4P
	as4TzZE6q3IBbB4KwPqk14T4XaAQsYktMn4tkcrhb2HtIQaxpeZqyqD08igDzmX1
	3m3T+iEKF3GWi+5t1MGkpYCTFdh36TZURMM/yh4tmgomdEGRgiARd4/v2zDlJXNF
	bOhmHDHuho/EkY3WUjd8eeS41voGj554cYpRuATjifZ+qw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0t341tay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 19:21:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b6f0b345e3so17313323eec.0
        for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 11:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769800889; x=1770405689; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXe9Lrt7dSp+Dy1ApjFhZbK3Rd1JE1rBVyTVQSittNQ=;
        b=ULlm0r/ZUAQbXvPgYOL/FdQINKs8Vrc0aiK3wMpkixIwkE48NITd2splQHXCI1ot3N
         ul+ye6n6Zfuf7easstruP8tWRZbGRd3wWARX9pyRSgsjgX+h//MNY3xk98nye7Tr/OCE
         sGhkdgV7f6RqtuD2+ySXArCCoHL58tD4EiTCdeA6fUxDdeVkikmS+Eld+PkGi5++IXUo
         H+Fc8hZxrjXY1Ohjiq/RHcMIWYT5qnYYJYZw2XW+3CtE6WbLteD00vo2Ig+RDG5lnXjE
         Lqwny/34FNBy4s4JNK+dLsqgXoVR6Paoiw+klC7QAXFYKAuvQnjMgtlmCehDe67ZkuDz
         SN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769800889; x=1770405689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXe9Lrt7dSp+Dy1ApjFhZbK3Rd1JE1rBVyTVQSittNQ=;
        b=RTlYxLluYZvXOrwZJi/kNawOoeKPBOnZ80XwC5jTNtbCb/+x23fcccQRIHrjURA5Jr
         EHjBcI18Opy5hrQPTtiUjzvFH2JoWq5Ai4MHSeNxhQ+9qNJnCq/A2qEbUtfPU+NUwyT0
         mC0l1GKFu3+cLZW34uLixINaMMUaYh1jwkxWVVDbtGGk5tzemJhzDw7VBkIHWlcxvpaj
         y7y1tNMp2BDle5l8A3+64kI/MvUAidoiwRUL1zrM8osdHvvbl7PhZaTFFIA7YLTEwXMj
         LDWdp2RXaBkUFMxvO07q99Rw1Y+wxf0ti+MJ/iUprM74hDvkDS7qHbSu+UIItrxX7UGD
         BcFg==
X-Forwarded-Encrypted: i=1; AJvYcCUY2VSkeCcl71K+jwOlZt5JtJyKOLjOTt+SRSpyUopvQ94+vlYhDdaYtwAlotSOh+as4mttQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ+rrN4zFkZ2Q4wbUJ84KHyJU1RS+QXviyLwfhmDHElNEIwNF7
	eXX39xgoP2+kFfoCpphYCUyEG+AI/5bfAwJQHL6WCe5pxpSIZAcmWu+ZMs7p141gEIWwreOzCBB
	LZqve4518eeZTrTngUms3aPzsylf7CtxYI0m7bpgLWUNGr8H2U57qO6lrDQ==
X-Gm-Gg: AZuq6aJ96h3Veqmm+8e+4L+l9jSz7gGaPR/mASdX0ecU+xlNrI5grYuMm3djVUzxTYl
	Xw0alGjNQsEO4R5kOEG4CK0rw0ZbAc+xCnmOrcKisvVN6TtEzVx9KxAtL88ANEEefZFEMP4dCZu
	xYBFpXI68QugFjMbaqps6XKfI1iupwfDZuHG6BkixSZoMbOtCdV/rst90V+AjtMZolXINvgEG85
	Kp1Uk2AsbKxJb0rG5/hpteyP+mTVA1qsvUi1pPXbF/X6envewWJ2x9cEOdEZwShmz4Tj7ootIEJ
	hKmnpoXcu6/A8tMKNyIC+rYYSaMjbeifyI6+R7zC57mqROmx7WSxStVfCLe/foAAf0p6sXB8Odr
	JBbHjV5fVktOj6GiLX5E=
X-Received: by 2002:a05:7300:a944:b0:2b7:2813:6a61 with SMTP id 5a478bee46e88-2b7c8634cd2mr2270948eec.6.1769800889391;
        Fri, 30 Jan 2026 11:21:29 -0800 (PST)
X-Received: by 2002:a05:7300:a944:b0:2b7:2813:6a61 with SMTP id 5a478bee46e88-2b7c8634cd2mr2270939eec.6.1769800888834;
        Fri, 30 Jan 2026 11:21:28 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfaa8sm12015146eec.4.2026.01.30.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:21:28 -0800 (PST)
Date: Fri, 30 Jan 2026 13:21:27 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>,
        lihangjing@bytedance.com, Xu Lu <luxu.kernel@bytedance.com>,
        patches@lists.linux.dev, xieyongji@bytedance.com
Subject: Re: [PATCH v2 1/5] iommupt: Add the RISC-V page table format
Message-ID: <hay56yg2plriyehsvy6zbyaptf6xvnj65zzvurllvpar6gyklr@i4cb6zenwap6>
References: <0-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
 <1-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE1OCBTYWx0ZWRfX2dSn9VseNYz1
 d5tCPW34K1p3TDTVJ7Bl/usl7tMfI/EPNupLvsnuZcZ8dJFlHomQLA4yJoByJfIgNvPKS0yfXBT
 ndaCN+TN1PjD5xhbtE2qzk78750StyQLpRiBaPN91DWd6KwQslcCA6h3oaPhGV+dj6+8byCCd7j
 QsAnQ7Fh/xMp7bvm4ImsWWDLwCe2/i5Uv4KYSswD8+Yx5NlkxplWMAy9RP4YxLeqvIVkw9ySMJC
 /Dd1hPFAjQqxobkTDdGrPT8fVlrtbCxXiP+6gFbB3UbKWo0EATvkeG5TbDDPix77wN+rvoqgD9t
 dyr6HnU8n0b8kBIqxJd7/SmeSxq2BJ084pvDsTNcgRk8XF/8itP31DKM287fZUWHV7O1+ikNo9M
 9RZCikt7E4K+KAt1VgPy6j7Y9gM44rpbkrfMgRBTgSOFiilxFwB4cdrInRxWkedqJWdhTVUsAQ/
 blh2bbGXZ5qV4/VWfFQ==
X-Proofpoint-ORIG-GUID: 0jgi6weXE1XJDLjbPPe4bGayoRj08Y-i
X-Authority-Analysis: v=2.4 cv=QfFrf8bv c=1 sm=1 tr=0 ts=697d04ba cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=MAu47OgHUst8qGL3NBsA:9
 a=CjuIK1q_8ugA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 0jgi6weXE1XJDLjbPPe4bGayoRj08Y-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300158

On Tue, Jan 06, 2026 at 11:06:45AM -0400, Jason Gunthorpe wrote:
> The RISC-V format is a fairly simple 5 level page table not unlike the x86
> one. It has optional support for a single contiguous page size of 64k (16
> x 4k).
> 
> The specification describes a 32-bit format, the general code can support
> it via a #define but the iommu side implementation has been left off until
> a user comes.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/.kunitconfig        |   1 +
>  drivers/iommu/generic_pt/Kconfig             |   9 +
>  drivers/iommu/generic_pt/fmt/Makefile        |   2 +
>  drivers/iommu/generic_pt/fmt/defs_riscv.h    |  29 ++
>  drivers/iommu/generic_pt/fmt/iommu_riscv64.c |  11 +
>  drivers/iommu/generic_pt/fmt/riscv.h         | 313 +++++++++++++++++++
>  include/linux/generic_pt/common.h            |  16 +
>  include/linux/generic_pt/iommu.h             |  11 +
>  8 files changed, 392 insertions(+)
>  create mode 100644 drivers/iommu/generic_pt/fmt/defs_riscv.h
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_riscv64.c
>  create mode 100644 drivers/iommu/generic_pt/fmt/riscv.h
> 
> diff --git a/drivers/iommu/generic_pt/.kunitconfig b/drivers/iommu/generic_pt/.kunitconfig
> index 52ac9e661ffd2b..db0a5b2b3c7867 100644
> --- a/drivers/iommu/generic_pt/.kunitconfig
> +++ b/drivers/iommu/generic_pt/.kunitconfig
> @@ -4,6 +4,7 @@ CONFIG_DEBUG_GENERIC_PT=y
>  CONFIG_IOMMU_PT=y
>  CONFIG_IOMMU_PT_AMDV1=y
>  CONFIG_IOMMU_PT_VTDSS=y
> +CONFIG_IOMMU_PT_RISCV64=y
>  CONFIG_IOMMU_PT_X86_64=y
>  CONFIG_IOMMU_PT_KUNIT_TEST=y
>  
> diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
> index ce4fb478691457..df0fef423584d5 100644
> --- a/drivers/iommu/generic_pt/Kconfig
> +++ b/drivers/iommu/generic_pt/Kconfig
> @@ -50,6 +50,14 @@ config IOMMU_PT_VTDSS
>  	  level Second Stage page table. It is similar to the X86_64 format with
>  	  4K/2M/1G page sizes.
>  
> +config IOMMU_PT_RISCV64
> +       tristate "IOMMU page table for RISC-V 64 bit Sv57/Sv48/Sv39"
> +	depends on !GENERIC_ATOMIC64 # for cmpxchg64
> +	help
> +	  iommu_domain implementation for RISC-V 64 bit 3/4/5 level page table.
> +	  It supports 4K/2M/1G/512G/256T page sizes and can decode a sign
> +	  extended portion of the 64 bit IOVA space.
> +
>  	  Selected automatically by an IOMMU driver that uses this format.

I assume we want to keep this 'Selected automatically...' line in the help
text of IOMMU_PT_VTDSS too, so it should be duplicated here.

>  
>  config IOMMU_PT_X86_64
> @@ -66,6 +74,7 @@ config IOMMU_PT_KUNIT_TEST
>  	tristate "IOMMU Page Table KUnit Test" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
>  	depends on IOMMU_PT_AMDV1 || !IOMMU_PT_AMDV1
> +	depends on IOMMU_PT_RISCV64 || !IOMMU_PT_RISCV64
>  	depends on IOMMU_PT_X86_64 || !IOMMU_PT_X86_64
>  	depends on IOMMU_PT_VTDSS || !IOMMU_PT_VTDSS
>  	default KUNIT_ALL_TESTS

Thanks,
drew
