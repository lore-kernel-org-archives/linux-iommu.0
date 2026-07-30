Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF8417BE9
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416760; cv=none; b=kcAf9YSpMom/qmpkWzV6gXlLgeQjtRBGK2Gu5X1b9Bv6LKjTnx4odQ1/ah2FJ3R6UsFxP3bSYzXE7jLX6u67VhgZi19MJtMkD0z9cesIoCMo9Xxm+wJdbRzFJbozU92Vr5Bak/KOOpsnFDKD6zKf6yYZb/RwDBuHyLXKnOSjfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416760; c=relaxed/simple;
	bh=U7QJUEgXiajnoMTwk9jtq6acwMeKeuYsCKPUbURB+eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eyq4PwefbbhLpaTOdxgyfPIt7JmCIpRq1rSC6J0+5spvVrkh+F2e7irADKcrAl6LwkuTuaSMs4MqRY6ST8VWo3WIRbOrjOkC0yt4KxhoHLRPZiTy7kRInU1v75EbufCJ5atxw0Nb2SuEINeZeGCVeyE2o/205t0TMJQZsRooom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZREqpcrQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PS8vuvYw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZREqpcrQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PS8vuvYw"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2d3I735377
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NICqcAYvnXDPIDCBr1xsnUKW
	pknOwaDQB2vFtiBvz0w=; b=ZREqpcrQ0s2EIInl3rCfi5kPp3bmNzWfnUcreBDV
	pfEF83YkU7qLYVQZNJkYs/zynL+88iF+YtdaQgZtHoyCgknGcQXo/Ff1V2tpiYQj
	H13Danx6CyAADaSHqRc8ObHZyuUr97CwPeE/jpu0LxTplnUgTvH6RkJZYj9KtIWH
	7LFgGrplkFJl4Vh5PXJUsi177Uyqne9e+sMsbaqfJ9kO4PKnr1sXF/PELpqVcBqQ
	AnXkazXvqExk8AYI+BppQdO5VZHCH8sr3rLzLjQcAt7TtqAbdw9RWESzX0LMQPfu
	g5XqfEJkYVZz3D6e2MTCLzrY1PHlHfCmhPkTIw+rXsV4ww==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr4a2gt8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:05:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c20762d21so26167731cf.0
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785416756; x=1786021556; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NICqcAYvnXDPIDCBr1xsnUKWpknOwaDQB2vFtiBvz0w=;
        b=PS8vuvYwhgloZiHZM7Sz9P4d4Jplx+MGISeJ/HtOjKPx3CUr2Qu1dATLUpezmfKtKG
         l7ELNXBr3f0lNeihfIlbiNaXYfCmcdfxxbBOUvDei69Wf47Xu0Jp+UOjWxfEk58LvnAU
         Tc/hjNcmVCfwbzIO3adBZqnaH+N2GBR/HTEWhHuBE/g5pJRTwj0MlIh4kbeNwtZa+SWN
         U7kfSno90axCQSZ/tPk/9ivVgm9RkoSXtClegCQ/f0DZiHrsJbzvy+ZATb3aCsVm0BEV
         yfea9oKApiel2qybzGPDFblyiqqyfEE9ONyjMH5wrUnEi2GVt+yDL10UdKyjBmw30bss
         RuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785416756; x=1786021556;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NICqcAYvnXDPIDCBr1xsnUKWpknOwaDQB2vFtiBvz0w=;
        b=GM6DGoZd45xNhZj4L9VbDUw2r8hgTldF6z1phH+Djx90z7QK5qVQENaNrNtCKSx/bW
         Kk0OHmxAA+y5QrmKkpG7rQ23p83hzSVWa66j+UDuiTyovdwkpVjQ+AD++pclNpQzir0A
         lmuVKhcu8MWMb9qWclD6kz2WH+O9//AQdJLH1Q9qAYuvjAk32xDP4Q2VTl8RqKvun5Fb
         szCv6YHuXZnJiouBqqUopPO86woRg7iE5NyJDsE4358ls5Ypi2vURRlwzfXgVM3S23A5
         Dn6cmJcaDk0KIqnaSHcqJWM3O7ic9TokitaSgxDLxvk1Xch/qR/OcwE7LyLfJDvMZXcp
         7eSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTq6pRNrR5v9fcjft8IUHZPY7X/vAf30L2n+IdAoJDLOEsQiiHHrwRy33ILSoJMEx2wUOeDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEjhIevgJSg8N+QR715otd0eTHSU1sTUnz8eaKiQxtw+BKuLqi
	JX+g6SZrlGJzmcNdHDfUM0I09VvjqfPIA8aWMJ5qeqF5phadZ++CbBDJ4H3CBNvxz0x5RG/WOGB
	raU1rX0IMRlp5VsLF2e5zB5q9sUeUPTOOf4KwDeUxFjCviSuVyF4d6l+kLw==
X-Gm-Gg: AR+sD13NSwLbcZFratj2l3+DmM6EIcpzKbwB11ElCYb3AQzkiE7EfvGnWD70CwX+vSy
	nZqVriFEoY94MjgEMhqrvzxPSSnuTdJCuMbi95xQTPBai054E6ezkN+y12vOpB7ndMFYFVqDkG+
	5cLyORZ2XGo2PLAe05R6iQpkIxqQY+RUEMx6L9ps9/7F3V6sr96b4osWQM75QZqcpQUhBKupsaj
	prZxOGuEP8ngSFNdZJkNP1bKt/0hT1kftG288x0YKCiSyNC9w6n+jGWMAffSiDVUj5z2IpSTTuV
	YgCM75Q3fKQh4uJgVCdnP1km6inN2fxAvYB6hnIl/04Nx5Dq6hBd9XKw1G5sc6QZHzIlFWKWNCY
	TMkq4tU9zhcuW3mRAbM6oXDk2Utly8i6gLWek8tI=
X-Received: by 2002:a05:622a:5a12:b0:51c:844f:28df with SMTP id d75a77b69052e-52b386ba398mr26868391cf.75.1785416756148;
        Thu, 30 Jul 2026 06:05:56 -0700 (PDT)
X-Received: by 2002:a05:622a:5a12:b0:51c:844f:28df with SMTP id d75a77b69052e-52b386ba398mr26867661cf.75.1785416755588;
        Thu, 30 Jul 2026 06:05:55 -0700 (PDT)
Received: from localhost (cst-prg-94-50.cust.vodafone.cz. [46.135.94.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a07cb79672sm655629a12.13.2026.07.30.06.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:05:54 -0700 (PDT)
Date: Thu, 30 Jul 2026 15:05:52 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v2 00/14] iommu/riscv: Enable MSI remapping and IOMMU_DMA
Message-ID: <fcshuujn27rutywntqixbmyvvxcsbz3yg7kk6ngnphxql6byyb@pvo6vaishsdz>
References: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
X-Proofpoint-GUID: FnMAThoQE9TfmhvfHuUoTS0p5lJGE_bS
X-Proofpoint-ORIG-GUID: FnMAThoQE9TfmhvfHuUoTS0p5lJGE_bS
X-Authority-Analysis: v=2.4 cv=IoIutr/g c=1 sm=1 tr=0 ts=6a6b4c34 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=K44ovq/QSKyRiRxWKRAbdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=vdDDTV-ePma1-M1uuSoA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5OCBTYWx0ZWRfXxAV/plc5tGye
 dLFerFsZGK1HUfh7l4NVQV4a+5ciZ6vHF23YhrbWr39IF2NorfNIif3kQ5KkgLjtkdWowlviF7C
 JeVjHKL1LJG6hPrhBsbREdbKM4w8ZkaQOvK6qJll7NZCEmPl/lW6ZeCGo6wyHsgYgAsA49+UWFY
 V5vCHb8eb27UoRjUl/BAJboUpw4aE2u7bmQLQmnGZbsIeyM6Cyrb0QAwqaMfpLcf9l2o3i0ZVQp
 EWwQIfqOhUBeTq8Ohq/DXAf6ee0XIG+zHclB+IkXCJwDiK4j4qAKcOx7ZgG+uT6xdpR3KHqnRv1
 SCzopgOcdjY6H7VkZhHfA9CakapD/f0M0jBw5tP57gHVLGgGVXUZstQOe0FA2ZRne4l2IUCisfH
 h23mMksDPQncQJYSMEJY1xfXoBxhFUUhZw1tiuGapr9eokmGSZq+BefUrvcxI8yNp/a0UGhQ8dY
 stR+348f2mksVbCs2aQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5OCBTYWx0ZWRfX4w/+SHRNMz0C
 SGBI7VhVBKzsLQWo9f1WTllgIFgIIxHADLC6tD2uMBQYoS2KyX/qwECwayML4RNmFfxksUkZi+0
 bkk4IclbJh7knmwsi52PgPT+6W8KOC4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300098

On Fri, Jul 24, 2026 at 05:12:04PM +0200, Andrew Jones wrote:
> This series adds MSI remapping for IMSIC so a device's MSI target gets
> translated the same way its DMA does, allowing RISC-V to enable IOMMU_DMA
> and paging domains by default.
> 
> v1[1] used get_resv_regions() with IOMMU_RESV_DIRECT_RELAXABLE to identity
> map IMSIC pages, but that was rejected as only a workaround, and the
> proposal for v2 was to follow ARM's approach. ARM calls
> iommu_dma_prepare_msi() once at IRQ-alloc time, caches the IOVA on the
> msi_desc, and lets compose replay it via msi_msg_set_addr(). This series
> follows that structure by introducing an IRQ domain and a new
> iommu_dma_map_msi(). Like iommu_dma_prepare_msi(), it dispatches on the
> same domain cookie types. Unlike iommu_dma_prepare_msi(), it returns the
> IOVA to the caller instead of caching it on a descriptor. That allows the
> caller to collect all IOVAs needed (since IMSIC needs one IOVA per host
> IMSIC page). Like ARM, msi_msg_set_addr() is used at compose time to
> direct MSIs to the appropriate IOVAs.
> 
> The divergence from ARM is required due to where the target address
> actually lives. ARM's doorbell PA is fixed per ITS instance (affinity
> changes only retarget hardware routing, never the composed address) so
> one IOVA cached at alloc time stays valid for the descriptor's lifetime.
> IMSIC doesn't have a fixed target, the MSI address itself changes on
> irq_set_affinity(), and that runs in atomic context, so mapping a fresh
> IOVA isn't an option. This series pre-maps every IMSIC page into a
> domain-wide PA-to-IOVA table at first IRQ-alloc time, and compose does an
> O(1) lookup to pick the right one.
> 
> LLM-based coding assistants were used during development for code
> exploration ("super grep" as one of my colleagues calls it), patch review,
> test execution, and commit-message iteration, but all resulting code and
> commit messages were selected, reviewed, and finalized by me. Per-patch
> Assisted-by tags are omitted in light of the ongoing discussion about
> simplifying coding-assistant attribution[2].
>

I'm addressing sashiko's comments[1], making a few other changes, and
adding a couple patches that I think belong in this series more than
in the next series I'll be submitting (guest interrupt file support, a.k.a
irqbypass) which is getting built on this series. So a v3 is coming soon,
likely tomorrow.

[1] https://sashiko.dev/#/patchset/20260724151218.965929-1-andrew.jones@oss.qualcomm.com

Thanks,
drew
