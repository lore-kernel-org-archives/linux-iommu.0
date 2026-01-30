Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69973074AE
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803136; cv=none; b=kU+qn79twR1BWPKi0jMZrrOamt3FwFhP5fogfT8e0HSZ4d6P39sT99f+BexphAFdEGkoFOzremQUclEzpATy74AeoI0Fng1w/mxQHC17SxfU6shdjJYI58qgCIFvC04Edsv5wH5hUrTTkl3nzzQbCPYWfS0d2puGP+xHYK18AuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803136; c=relaxed/simple;
	bh=gB0O4j84vF8hNO0v2sENLMngBBdi/h8BkpPBDY1dsPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErGzmWKxEySGUiqfb1SU2IgcdZUGv4NKCHvajI4suWCGAg+fOxYqZjiH9w01CaFBVna1xa6WL/Xenjn4punGsUjZ1EmCVPmcuUSZaK1ecvRVZxVjy16w6LZRhRwW1q45OFuq5080ZOFojjlgAUjrpT7G089C81t6MpRA32fT9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jQDmoqQb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ey6lVsv3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQDmoqQb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ey6lVsv3"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UI1Eid2675365
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 19:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gG+M+PPDwqTghnjTqDKDABOD
	qqkOeb2jHmdjVhPJUbk=; b=jQDmoqQb3g/IgRMXou0tPXzREhjuRFospemBY0KJ
	14GoOaLKfXCurZ9G7N+J/+PTMqEQ7TgndXyh51T972c7YINKKMGtgzKZHvlDTqZW
	g7Bye/5V/M2UU6FSwKBRPfUzCOGwpax1+LlkvPJWWxspdahnEw5ehjm1ZJwMAvK9
	k5Qz0A5WvrTKkIrdcFWtJy+/wYphqXuwOtTNZ6eV1QMav6VdS/wJIg+/y1GfaI68
	AdAgG+/SMEKhAgDoeKKfYGwK4ZPMFWof6LSteFgl1wiwnNlkop5LwPxKGXozA1qb
	QpFFUXvyEQ+mYty5x5e0yKnCyttzObQJaL0J69ZRZjjfrw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0t341wdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 19:58:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b708fa4093so14012061eec.0
        for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 11:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769803133; x=1770407933; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gG+M+PPDwqTghnjTqDKDABODqqkOeb2jHmdjVhPJUbk=;
        b=Ey6lVsv3yWMTVVFup1hPm+T7xOaukBeacwurrcBBs8Lpnx27SazdQXMWbvyzgKcKKH
         qmCnNu0ykfKS+8jLR5f+Zk6eG4zfpFHd4Mm/O4WFOgSVWD+2psC/Rwpb3UyNNfJKw5eT
         hp/8M8+wqRoL7zlPxLRYNI0YrKcDnSRpLiDjxpqGRMtXEUOaavVqq5YhuGkSWuF5hAUV
         I1MWK4WF/yfsx1we80/DShWbVf7JVTWtOunR5mEXvcX+tll0q4HqueHirfhGEag1xNAx
         ZPOJsfFElu9cvMZDJ/Df9/iXUL/dJwvE1ps7AmarqF2T3xsE7RqKbg60N2hTjge1JgAA
         sO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769803133; x=1770407933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG+M+PPDwqTghnjTqDKDABODqqkOeb2jHmdjVhPJUbk=;
        b=FgpGGAq/kcMKl9fe7p8Mr2Siyt1Eh96roB7kbqfK0RkCBYD/gw5JsklDsBsRSki2+R
         UCOiehoyD5PgTG1xpB+w8M/Qm7g6ORCJ5cMa8kpWY8JUCf+31YvGcpAXV4a3V9inlpOo
         9KpjFTUZm4ayFWgAOV9ME8r3n9W2KM+/nAti6atxzWBqcC5s1fSRFfq9/jDxZKKuqPPu
         6fYNdagH4B+is4T6YUyKJm/Drunuu1v9ua7ULAHIfq1U4fxkJDq4jeiaW6P327jy4u2D
         XGZCcVYa9ZVS38msUa1VLFFdCpfp5hm6qIxdd4Ym92RFvNzqAcsGQX0SuH1kbk6tVOFA
         TG8w==
X-Forwarded-Encrypted: i=1; AJvYcCVvuISD1d0rnkEHjjvEAFerIqAWcXunQv1NTkC/ycNslIvJPsoe50OrUstKWJSlCiCNr8JH8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgGXRq27XV7nrTWHgXuh+GBXimcoiJUd24/ZjveYLkMO+fphi2
	y+WzfG7V+3LiwYUiZe8wyJZmVyQqxa3Tke17tAcKJINXwiUuAa4b0LJa0BijAUFfzIK3wr2068B
	vTZAsRtj2Q5SYHHXgvSsuKGKpAZ7PvGUHqsBaFnqgaYAJ2Gclb8CKLKgx8Q==
X-Gm-Gg: AZuq6aI2vuJNoOcmwxJIciOxAf2gzFZQ7ip3daF2k081pUTZaHJM9XVMVebjFG9Xe2p
	Shz1Gdogcshj7d+0jeZhZ8u32na6WnE5IDUylOdwp9dSpSaPS+KCwwRSUjBAxEu46UkE+0GKnNH
	ZsbU56Ujk2wOcdG8WHErckR4p3PFRqkHEU7PTUmQlPw5eBUF3fwBWjRHatjaHV9s++MJ7/WngVN
	CXUVQUMSLVWsEz0N3p1WEoiNdZXT1kbh9LKkeLBvWOAiE6F2oWYCd9/DB6ligkOzmMx6g/lDLCn
	skqu8x2kBsio6YoJIf9anzZLpkzLq21zPMi/ROHkcvG96q3PY7+2J6LhkOoLXTNcXdMc7bGTALZ
	m+PmkHaO6nCBVol+rrm8=
X-Received: by 2002:a05:7301:2288:b0:2b7:23ba:af2e with SMTP id 5a478bee46e88-2b7c89658bbmr1882840eec.43.1769803133214;
        Fri, 30 Jan 2026 11:58:53 -0800 (PST)
X-Received: by 2002:a05:7301:2288:b0:2b7:23ba:af2e with SMTP id 5a478bee46e88-2b7c89658bbmr1882825eec.43.1769803132685;
        Fri, 30 Jan 2026 11:58:52 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abeb6asm13435031eec.19.2026.01.30.11.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:58:52 -0800 (PST)
Date: Fri, 30 Jan 2026 13:58:51 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>,
        lihangjing@bytedance.com, Xu Lu <luxu.kernel@bytedance.com>,
        patches@lists.linux.dev, xieyongji@bytedance.com
Subject: Re: [PATCH v2 5/5] iommu/riscv: Allow RISC_VIOMMU to COMPILE_TEST
Message-ID: <dn7bsft2qvjod3sm6omneq37pwr2jtdzgobapy6obpgccg7soc@ctvs3c2w4vob>
References: <0-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
 <5-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE2NCBTYWx0ZWRfX+pGAhx843NDC
 MZ73firGTyCcSd7H/Fd2SDT4AjAzHAV+ESLNa/witA2aF7wrWYfZY4XkPdKICNrxZNzAbrgoNa4
 g7ypXVmPG8PIfGa07w76Kme3owyIKFZYUrg6lJc+hSnSBdKPN2XzNus5cDXGO/ae9Yl872RR0A3
 ht3cpu9yaZwb0rEacZG+nzqIRZ/nAu8l1qaDyPSBg1rdyJR5Yoq+ZJ7s/GY/I2Q5kxRq/qGPRl7
 jh154zPwFOrI4OTxg3FbGgHFuyeoEMdHcMF7Har+3Pd4MSDw1l5smqgh1cU0e6fGskNUUwxz2HL
 Gm9Q6ieDEa9waXPHvCKeB2xNtck17gR9NBY0/BImkkhNpq/trDWkB7zt1NPCyG5ov7Mse+53Ftq
 FXhd9SWlYmxhDTtb76S8WMRkOvkYSpCrkF786xDyPQhEAhol8ZDWH2HVK4yuFSSy2CfvB6QLKLN
 NkYqA6AwqszbKhMp/2w==
X-Proofpoint-ORIG-GUID: 55STJi32Vq2VePniP-bE8C5cfHM8kmUt
X-Authority-Analysis: v=2.4 cv=QfFrf8bv c=1 sm=1 tr=0 ts=697d0d7d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=RJvRfVeWPKEwyB7QEjIA:9
 a=CjuIK1q_8ugA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 55STJi32Vq2VePniP-bE8C5cfHM8kmUt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300164

On Tue, Jan 06, 2026 at 11:06:49AM -0400, Jason Gunthorpe wrote:
> This driver used to use a lot of page table constants from the architecture
> code which prevented COMPILE_TEST on other architectures. Now that iommupt
> provides all of the constants internally there are only two small bumps
> preventing COMPILE_TEST.
> 
> - Use the generic functions for the riscv specific phys_to_pfn() and
>   pfn_to_phys()
> 
> - Use CONFIG_MMIOWB to block off the mmiowb() barrier
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/riscv/Kconfig      | 5 +++--
>  drivers/iommu/riscv/iommu-bits.h | 4 +++-
>  drivers/iommu/riscv/iommu.c      | 4 +++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> index a329ec634cf1c5..f681188d19a1bc 100644
> --- a/drivers/iommu/riscv/Kconfig
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -3,8 +3,9 @@
>  
>  config RISCV_IOMMU
>  	bool "RISC-V IOMMU Support"
> -	depends on RISCV && 64BIT
> -	default y
> +	default RISCV
> +	depends on (RISCV || COMPILE_TEST) && 64BIT
> +	depends on GENERIC_MSI_IRQ

This new depends isn't called out in the commit message. Maybe it should
even be its own patch with a fixes d5f88acdd6ff ("iommu/riscv: Add support
for platform msi") tag, but, either way, thanks for the fix.

>  	select IOMMU_API
>  	select GENERIC_PT
>  	select IOMMU_PT
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
> index 98daf0e1a30690..29a0040b1c32ea 100644
> --- a/drivers/iommu/riscv/iommu-bits.h
> +++ b/drivers/iommu/riscv/iommu-bits.h
> @@ -17,6 +17,7 @@
>  #include <linux/types.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <asm/page.h>
>  
>  /*
>   * Chapter 5: Memory Mapped register interface
> @@ -718,7 +719,8 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
>  static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
>  						  u64 addr)
>  {
> -	cmd->dword1 = FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_ADDR, phys_to_pfn(addr));
> +	cmd->dword1 =
> +		FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_ADDR, PHYS_PFN(addr));
>  	cmd->dword0 |= RISCV_IOMMU_CMD_IOTINVAL_AV;
>  }
>  
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 4e2e08114bbf15..7a63f1771295b1 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -160,7 +160,7 @@ static int riscv_iommu_queue_alloc(struct riscv_iommu_device *iommu,
>  	if (FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb)) {
>  		const size_t queue_size = entry_size << (logsz + 1);
>  
> -		queue->phys = pfn_to_phys(FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb));
> +		queue->phys = PFN_PHYS(FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb));
>  		queue->base = devm_ioremap(iommu->dev, queue->phys, queue_size);
>  	} else {
>  		do {
> @@ -436,7 +436,9 @@ static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
>  	 * 6. Make sure the doorbell write to the device has finished before updating
>  	 *    the shadow tail index in normal memory. 'fence o, w'
>  	 */
> +#ifdef CONFIG_MMIOWB
>  	mmiowb();
> +#endif

Taking inspiration from powerpc we'd put the #ifdef CONFIG_MMIOWB in
arch/riscv/include/asm/mmiowb.h

Thanks,
drew
