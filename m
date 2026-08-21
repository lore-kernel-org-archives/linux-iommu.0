Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EA731B80D
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320048; cv=none; b=o5MTKOR7vkrDtET9N8m11pTYaMczygtzL4+7KahMDnlcQ5Z3x+3p0UBBlFYbInG/vu5EuQqiKOVsR5wg3JhHQNlp4NWY1PmkajywTazfaq+Cy6giS6C3ELeJp7Oy5XahkvDm4lpaSkbQBn6WzeMEvFiY9ZyqsRAb6wvNHF1Vuvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320048; c=relaxed/simple;
	bh=ndbuLor0wEu/PTyMA31f2o2uVfMc7dfh21NE2qeM4lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAdsWu4umKumhBn89J64sQ/DSD61DCdylz4eNpaBuHAtWaipePM1v0rzmSdLgab9VcV0N9TyPWyQtz/raMy1mr9oRbRNm3vFTVNochkPSxtbQcbkCXfZQQKT1KxFz+y2E6v1AmQGTx/PVGRZbSS8d5laZzyLwtGHGPUpdLWd478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IsW6WxIB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JiioFiAo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IsW6WxIB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JiioFiAo"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCooUv2029791
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=a5VCLxEl7X8qI/cglZ1ZCGty
	oFxlx7SBGtiXQblkcbo=; b=IsW6WxIBflBqDT/f4XGRYWwPnrAzhmAR417dydO6
	tFXBIVbYz8lw9pPT5X3Apjce/ic1oxLZcA+dpbrq3ogznNPgXnAGJ61/N7elwDTW
	BcRzvpzuVCygQfC8f+B1+uYNz62KG2tsGr5uxU+GB1Ht5Qw2tHLJvCqEy6HmZIaf
	9/nxzd+qdOWf7VnMcEwz1xmOvOd1qaOf/3e6F5GvJAKxsQvo4ss0lvheaJ7pLaRj
	ZQGEdcCW7PrrMk1YjpuBlKqKt5sO4767nNouICWOKh8vMwuvpPASS2X4GkGTTgfE
	O5HBaP5lBMgXl7Yub2p+ZqT4IQYRrz8/f8s6Xlw82z1Hbg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fue1xmb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:47:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93494527488so163322885a.3
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787320040; x=1787924840; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a5VCLxEl7X8qI/cglZ1ZCGtyoFxlx7SBGtiXQblkcbo=;
        b=JiioFiAoJoZvP0Mu5MzyW8Vn3NAi/vhQnV+yf3UfSCeEK4V2yooHNyfEKpwe297c90
         srvyQrO5SCE/eAQlYJhhCsrXHxqP+qI7hNfpEO9KKBics98bxroZtZq/TAwrwASNfP8i
         2c3cT4OSnAVPSYKad2IdOcLBcOox3UkEH6a6lE2fg3JQICqBzYr/QodgclQbcVWyGTUf
         gj261dcRmawc7K5nPei/ox2cVnOLYLHYjHo3zyJE0cKzvzc5f9X4tGcpbe79Wk7urZMV
         xAheaFMmMdSd3KaQ9m8tTeeAUu+vuTQAa3SZ4CeRPF87yJBAdL3C9hVcdgd5zfItdvnS
         o35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320040; x=1787924840;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5VCLxEl7X8qI/cglZ1ZCGtyoFxlx7SBGtiXQblkcbo=;
        b=TZ+9upXbKGi0thpaTYNhcHLHZ8g0JH6RC3tEG+uLA6pxnDuuyEUlwqgVyAMsWGltSo
         809/VbNge2+24OLNtctCj/RkQ3pPr0Dq1j2xzIqtirA15k0J2FGTVlbe2xfsQlUyVMVs
         DilQ8vhXAIlE09bvNZBIaU7IeQbT4USDo8auMRZBrxD/aOfuCxK4XpLT0LGSLaw/laZx
         5ea4mMqs2s7k0bQmPfcaohCXlITbvMg7StHtO02IrNPVPh7b0J+nYMjUXuYE2z6AifNN
         7Hqljcbkip9uGMicFfxzV4R/crv71VoBlhtGjRMhmc7IWqmt5/6E/s1PitQsNIwHzb6s
         p73g==
X-Forwarded-Encrypted: i=1; AHgh+RoKmzbRwhovnOlEiQH5jqAs0It6btqxT06UiQzEeq9j0GnR/+6R95Opza/xfXeZnkHXUtO5UQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJliA7eGhEBoHpRkCTj/Ml8DJ53mlYrt77QJHextPnPWR9wnf8
	d4qVneYUhkY29GS1uwMl9vH+QiIADbIUNyf5k2O64FCkpMQEjBs5AUYKIVBgzpv1pjsqpj8YFsE
	EEG0KqUvSkJGO+fQBj7AB9SJmoibIgMlLXWIgGXd0r2K1XpTv+oloe9wSRA==
X-Gm-Gg: AR+sD11bwvjuZkOG3JLVb+/031MyVfx1w0Fhk8ASsImUWPgFf4cHZRyobMEYALmIamK
	qrQMKd4KREKiispCw24VSfxppN6qtKLkoXNYwXM9KU5+ByFUGHZX5LmmC4T+bQB5n25vV7bw47w
	+C8LL6B6T2wo1q/EZQzfryaHZC5yZw5tlJVKyGYefZiDWhRrK55KhvfJjjlrGXqUa8dSWtl2MvH
	8UrpQYJrBsK+h3y0LToWO2KFxdGdNpcOpZnf0h+M6lmY1YtzzEC+nMQK2SNS7t9Hpy+EvGKJ/b8
	1/EB956OdI+amoXUc35CUwRUogFd8r1z/XJOukwPQzXnetIXupwKgcaF/peZW0v2zWtVdS6Z+nh
	jGCHOcD2EZHYgAexUsa1MBfJy3LVJqomNDfk=
X-Received: by 2002:a05:620a:1196:b0:936:9f46:cec8 with SMTP id af79cd13be357-937394a8786mr405267285a.20.1787320040130;
        Fri, 21 Aug 2026 06:47:20 -0700 (PDT)
X-Received: by 2002:a05:620a:1196:b0:936:9f46:cec8 with SMTP id af79cd13be357-937394a8786mr405263185a.20.1787320039671;
        Fri, 21 Aug 2026 06:47:19 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b145153fsm17252542f8f.12.2026.08.21.06.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:47:18 -0700 (PDT)
Date: Fri, 21 Aug 2026 15:47:17 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
 <20260820220908.GE244917@nvidia.com>
 <gr2h3ktgacozyo7rdggkxsg5mbdtzcnimaawd24c37hnf2tun3@hqivsenaq5wd>
 <20260821120204.GF244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821120204.GF244917@nvidia.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwNiBTYWx0ZWRfXzPIzZlttSayv
 v0W2Ebl08SzMQwLV+FBcSTYe+ZimOAyaMi5cORDgKoN+R+Q8ZVywXRDpk9JuNnGMzCNho0Jmq8F
 Dt90sm4UTi6s08xI/wxPsColBvzhSu0=
X-Authority-Analysis: v=2.4 cv=U9+iy+ru c=1 sm=1 tr=0 ts=6a8856ed cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ev1Hn8_tcGTgjV4NdAUA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: xTgNx7OJt2Le_Q7AsKb67yd6AfpTjIaS
X-Proofpoint-ORIG-GUID: xTgNx7OJt2Le_Q7AsKb67yd6AfpTjIaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwNiBTYWx0ZWRfX6MlNyPO/BP6w
 KScAvydF9dKmukkc3E0Jaad6Y3tc/iLuBcFRTi2c3W59BjmmMcfQ3azlMdGaW/MT2LR3uDV6K4X
 lZmuL0IBFHUz707o9ffuBwXy5mF5rtXyMhHWt0i9NRLQbPZp/MCOnScXwl+Og32Ku6Rjxd9ZWxq
 lf6O8i7zUbLEhsVL1uB6IVlXlnjEkGX5+RdGjOUHyqAYfAH0UklVLPJpKG9QCo0By4K0xIAME2W
 kGX05STS9WJGOOkrd6oI4sqxlS7YASi4Qp4IpzCpQEA6AslBAR+7KY9LNbuZVj8qC5RurmP8Kr1
 a+q9kLMrPvN5cn8E9RcnpTA7algPpgq5SMAYYv69AXHSf4jRkyFhlVujt6W+u9LUsP1yPoOyu56
 I/MgoFh61wO/6b+Zr/M65PRz7vskw5frBAj9u9DrjKjpFcfyPArtdtZkzpBNoT4qM7PU1ukKe5j
 EKlmX3cRwiGSjWWV+tA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210106

On Fri, Aug 21, 2026 at 09:02:04AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 21, 2026 at 01:07:03PM +0200, Andrew Jones wrote:
> 
> > > What I rather expected was for riscv to have a PA window that is very
> > > big and not just one page, eg adjust iommu_dma_prepare_msi() so you
> > > can pass in the entire PA space that you need for the affinity
> > > changes. Maybe this is a list of phys_addr_t ?
> > 
> > That's more or less what this series does. 
> 
> But it does it in a completely different way, and I'm struggling to
> see any justification for this.
> 
> Again, just pass your list of PAs to iommu_dma_prepare_msi() from the
> irq domain seems like the easiest and most ARM aligned thing.
> 
> When you need a new IOVA for an affinity change the PA's are already
> mapped a simple offset calculation is that is needed.

Ah, I see what I missed. The proposed batched API would guarantee a
contiguous IOVA range, so the descriptor could cache the IOVA base and
then the riscv IR compose-msi-msg could simply compute its target off
that base. That would indeed eliminate msi_iova[] and all its complexity.

> 
> No weridness in domain allocation, no messing with irq stuff in a
> finalize function, no hackery to iommufd.
> 
> > There's no big PA window
> > because the IMSIC PAs aren't generally contiguous. iommu_dma_map_msi()
> > factors the mapping operation out of iommu_dma_prepare_msi() and returns
> > each IOVA directly. A batched list API would be possible, but it would
> > only move the loop.
> 
> But it keeps the entire flow consistent. Trying to pre-map MSIs and
> mangle all sorts of things in the riscv driver is undoing the
> generalization and what is expected to be be common code.
> 
> I don't want to see any mapping of msi in the rsicv iommu driver at
> all, that should be the most important design point.

ARM calls iommu_dma_prepare_msi() from ITS since there is no SMMU
irqdomain and ITS owns the MSI target. This series adds a RISC-V IOMMU IR
irqdomain to replace the IMSIC PA with the corresponding IOVA, so the IR
domain's alloc callback is the right place to create the mappings through
common DMA-IOMMU/iommufd code.

Thanks,
drew
