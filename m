Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829C45FFAA
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310429; cv=none; b=aYYkHtmtHJ5F+7fDB3JOb++LrcCG8w5V0vdcYVus9T6UR2gPLwZSqAVJmh5hRDv2IOOndoYAuZpBRTw/j7SVZ8OWv8ZM+WNltyDv1yQMJYx71qGoYa3sdmDC/vp9qTRV2+uzuwl6ChCaMi2QZJYFQfTbmFqGjye9GpPzj749dwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310429; c=relaxed/simple;
	bh=yg2yhx4yheIUtEwjQEfJSyPtd7Vo27izGvm3NYCqjxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB9NE1Jp7wQ6nuUIqk8i/Q82SMJWrOAXGJfLEkV3peplHyNCNV55quYzk9ITZuWbBoc7q4E+BLpgYjEi1rPoRINpTyLl7DRqMD0GqTLGC0OkIa9P1CfDsym0rZL4uOEBAdx4oeY8sn3QsGlw0ewtpSqOaGxhI2oh3Vf74eRkzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oLKC5uXm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=huVfOnR4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oLKC5uXm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="huVfOnR4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9Lwp51550418
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WCXwjdZu+PJCSyd21HPUi/ll
	3y7SJUQce3V2hZyDk1E=; b=oLKC5uXmzu5gaTuxOxwsx39YRklU9Xw0bnHXEvsL
	KPodcXn28i40xoPRlPC2HQDym1udGbkVONlnUWUYLW7oSwXjc1Vennkz7RuWpTgA
	A93al6xIdpDym8Lhi4JbMUfW+pCpYVxcxq7xTWDlKanFXfG3sIdn4fuWD045V/W3
	2htTNYpmQIWk7C+AMd5AZ4kPVZILA0PcDEjyfRCZZY8EKQbefpNyenNY+O0+7r9q
	b9Y5uHDhk6dBx7oadbon0+DYvlVL/dGb7qrzymTkn3gsw96Tjlkdwi9LhnvL3+S3
	XVhGPK0t0vNQstpy410bU8IwC8V54zngE7fql0nljj1vrg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6d069vs6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:07:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936aa34873bso72865685a.3
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787310426; x=1787915226; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WCXwjdZu+PJCSyd21HPUi/ll3y7SJUQce3V2hZyDk1E=;
        b=huVfOnR45hnEwWmbXswqkWxTP88G2AfXes+y65lztijAOg0+PuuNW+NCvfFMFOi3/D
         n++18vLnb7avWtSq3vK3iu6sIq1WwxmjlTknmTslcBRlcf8R/qFnioftnPS6u0vTVikc
         iY5ZgpuInVDCeixRW6MyJDxT1BW3s2NR12Q76ajQzkGL7xGWAFhPXnib96RRubqfHP2m
         zOYiQ7bPzgNLgccQcJQ3dvp8dfz0fm8qJaD1B2fxWM0QUm3k2QfNEjVq3v4AEe15y6fN
         +Km28cdVavkCOtMONrckf4JiCh4jHlgXZffYhzThkr25tzUHUJP1KDuCipHLE+BEQ31/
         5i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787310426; x=1787915226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WCXwjdZu+PJCSyd21HPUi/ll3y7SJUQce3V2hZyDk1E=;
        b=VMG2o3OpXBljqkIGtoROR5HFl3pggGvIaWRxXP9uo5GXe6AFBbbPzYL+OKfP5glcfi
         dp6RBmyI+0JdgHAzk6/s5B+VL2/qsKkcVzGwFGsUAn3x7SB1pNJ50L+UxtaDVvRL88ex
         9f3L8rytcA1WDbDX/CymTjOFS5sdaK2v5iXK87cSsApF20d7lPz4IjaT8ky8knqH9COG
         nNVspqGhU+PnFHMuMcPGjstkW9dLR6lEIuQW0xy8NWTg+znvXA83kTrQhDtikivTM+jf
         Od31W1OSH0L3IZPa7hB0hqj4ZSP6luS0xlBb5nw214eYFoQjNY6dlZRAwJNVgjs6lo6z
         Sg/g==
X-Forwarded-Encrypted: i=1; AHgh+RqY/MDsv3u8/OXMCM94UKMAhvHjEMDXmU+0I0+d1zaV4esY2+vus7ZlFrLGi0HdejYRNlJ9lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyngctxtTP/dWIDwU/gmUKRhdjy3b+Sn3ZeG79FC4M44iTP/Sm8
	xhUKbiY6YA3XY864itE+Ac/d24wi5ljDyordcerdpSv+ErE5IUt1A67Bib4BtC72yjhCGIirJ+2
	vbPZIFZ1VS7BP69eBpY5GlJ/bhHzOeEnit1E+zkrECQEF1u/O0wJTyZuHbA==
X-Gm-Gg: AR+sD11iz7dpf8JlYgRt5SmMkRKkCXBvHgI9cAqQyp5i5ApRt1W5y5MC4yo/2jO1x8o
	Ww1lKn5V/jL7HItgusEq79Oh1fcXVukQCO8yDFtCXvmvA5Ghf6upzIAR5UOC54GvRGAq7N643Br
	jjkJARS9FgMjl7HLB+qmywmxwH1lmRn+v9nxtXBXlJ6Dpe9aUHC4HwRsaJhYynrQC7Lr+Vzklee
	BBMXf6uMGRbSkG+Yutkz9zp2m3WEeM5fKZsulH1kWoH1l58PoUg5GqBS+mes4wSnY+n0nXM8vh8
	a/lNJ+qtd6GyxCwjkjsso9+Qw9RWHBBrCn82M30I3Iv3BhmNSr5DPP8gjMBuEbn2M00gcmdby8b
	TUmuVL84hTMLLJKJ13rx2v2MuiSaauSWUZ2I=
X-Received: by 2002:a05:620a:72a8:b0:914:bb06:288 with SMTP id af79cd13be357-9373960c63bmr382586585a.22.1787310426260;
        Fri, 21 Aug 2026 04:07:06 -0700 (PDT)
X-Received: by 2002:a05:620a:72a8:b0:914:bb06:288 with SMTP id af79cd13be357-9373960c63bmr382576885a.22.1787310425757;
        Fri, 21 Aug 2026 04:07:05 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9a949f4sm11983695e9.0.2026.08.21.04.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:07:04 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:07:03 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <gr2h3ktgacozyo7rdggkxsg5mbdtzcnimaawd24c37hnf2tun3@hqivsenaq5wd>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
 <20260820220908.GE244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820220908.GE244917@nvidia.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX1RtZRBpDAZZK
 1na82vbD7YVrBz/7BEU0mkpjc4UGCuOvQwb5JIm9j1exKAB4aUbCCem31LqNHFCH32QcrvB7l2y
 4E3S5Ur4Of98jwqPSnr2ZGtDMV/trCmS0AlzYxk+FEAfZE0ww94TNAzngy/35g5C714zWjvh1o6
 cAHlDwc0XfZ4HJo3zCxd6HKwlkjzDXQNNrbpskOASMek+j0+1R7dSe54ZDv2Wg7ajbgVT2mw/ul
 CzwPyjPN7nRicsmtU5TilX4vnPjXZkxtUtiAQ7EGR38Q2QQ+JPzg5Vsn24z30GK+92UJ3lgEl7k
 V3eFGZOT7mira2VdDYg8CyMZnDuxskZ9/EXd1lJq0VGf0nioVsMu8EWnf/4jBQGuYbTa9ig8x3T
 vXVoIZ1QfAprfd5BYHRYuiyoY3VZYElmPz1depSyIG4RS55sdDD8B1kUQPMFLkYYJH7ICme/Ndd
 HZheR8jm9NyBLDlEBmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX/UfyGmIvQK8l
 MtacVUO+I5gP1EVDwSZO4ATqU+igW8u7fMemuGS1zF+u+K/coiBZskzXiWioYzJ1ug/oNYvjSrA
 tDRU+rhLeMN+I6o63hJlgRUudHNk3bY=
X-Authority-Analysis: v=2.4 cv=DdQnbPtW c=1 sm=1 tr=0 ts=6a88315b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=w2L93CZGMa0q8yLUHy0A:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: dqYHcHlyjOpjJEp1Z3sJmjTe6VkdEeJI
X-Proofpoint-GUID: dqYHcHlyjOpjJEp1Z3sJmjTe6VkdEeJI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210084

Hi Jason,

On Thu, Aug 20, 2026 at 07:09:08PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 20, 2026 at 11:41:31PM +0200, Andrew Jones wrote:
> > Add a descriptor-free counterpart to iommufd_sw_msi(). The existing
> > function is tied to a struct msi_desc and stores the result in the
> > descriptor. This variant returns the IOVA directly so callers can
> > pre-map MSI targets before any descriptor has been allocated.
> 
> I haven't grasped why it is like this?
> 
> The cover letter says:
> 
>   ARM can map a fixed doorbell PA per ITS and cache its IOVA on the
>   descriptor because affinity changes only hardware routing, not the
>   composed address. An IMSIC target PA changes with affinity, and MSI
>   composition may run in atomic context, so mapping the selected target on
>   demand is not an option. This series pre-maps the supervisor IMSIC page
>   for every possible CPU into a domain-local PA-to-IOVA table when remapped
>   IRQs are first allocated, allowing composition to select the target with
>   an O(1) lookup. If iommufd replaces a paging domain while IRQs remain
>   allocated, the incoming domain's table is rebuilt before it is attached.
> 
> There are a few confusiong things with this statement:
>  1) Okay the IMSIC PA changes dynamically but since it can be
>     premapped the PAs required is fixed and known. ARM doesn't change
>     the PA dynamically?

ARM's PA is fixed. On affinity change it uses MOVI to instruct the ITS to
change the routing.

>  2) Why do you say mapping on demand is not possible? ARM's
>     iommu_dma_prepare_msi() is not called in an atomic context and
>     does do the iommu mapping.

By "on demand" I mean after IRQ allocation, when selecting a new MSI
target may occur in atomic context. Mapping then is not possible. Like ARM,
this riscv implementation performs all mappings at alloc-irqs time.

> 
> What I rather expected was for riscv to have a PA window that is very
> big and not just one page, eg adjust iommu_dma_prepare_msi() so you
> can pass in the entire PA space that you need for the affinity
> changes. Maybe this is a list of phys_addr_t ?

That's more or less what this series does. There's no big PA window
because the IMSIC PAs aren't generally contiguous. iommu_dma_map_msi()
factors the mapping operation out of iommu_dma_prepare_msi() and returns
each IOVA directly. A batched list API would be possible, but it would
only move the loop.

> 
> Then keep with the ARM flow where everything happens at the same
> times as today. Instead of just mapping one page you map the entire
> list.

The goal of this approach was to match ARM's flow as much as possible
despite the quite different architecture. Here's a table showing how
they match up now.

.------------------------------------------------------------------------------.
| IRQ lifecycle phase | ARM IR / ITS              | RISC-V IR / IMSIC          |
|---------------------|---------------------------|----------------------------|
| IRQ allocation      | ITS allocates an event/   | IMSIC allocates a vector   |
|                     | LPI. The MSI target PA is | on a CPU. The MSI target   |
|                     | the fixed GITS_TRANSLATER | PA is that CPU's IMSIC     |
|                     | address.                  | page.                      |
|                     |                           |                            |
|                     | iommu_dma_prepare_msi()   | iommu_dma_map_msi()        |
|                     | is called from the IR     | is called from the IR      |
|                     | irqdomain .alloc          | irqdomain .alloc           |
|                     | callback. It calls        | callback. It's called once |
|                     | iommu_dma_map_msi() once  | for each possible IMSIC    |
|                     | for the fixed ITS PA.     | PA.                        |
|---------------------|---------------------------|----------------------------|
| MSI mapping setup   | iommu_dma_map_msi()       | iommu_dma_map_msi()        |
|                     | dispatches to             | dispatches to              |
|                     | iommu_dma_sw_map_msi()    | iommu_dma_sw_map_msi()     |
|                     | or iommufd_sw_map_msi().  | or iommufd_sw_map_msi().   |
|                     | One IOVA is cached in the | One IOVA per IMSIC PA is   |
|                     | MSI descriptor.           | cached in the IOMMU domain |
|                     |                           | table.                     |
|---------------------|---------------------------|----------------------------|
| Initial composition | Compose the fixed target  | Compose the selected CPU's |
|                     | IOVA plus the event ID.   | IMSIC PA and local ID,     |
|                     |                           | then substitute its IOVA.  |
|---------------------|---------------------------|----------------------------|
| Affinity change     | Send MOVI to change ITS-  | Allocate a vector on the   |
|                     | internal routing. The     | new CPU. The device's MSI  |
|                     | device MSI address does   | address changes to the new |
|                     | not change.               | CPU's IMSIC IOVA.          |
|                     |                           |                            |
|                     |                           | The parent IMSIC irqdomain |
|                     |                           | irq_set_affinity() selects |
|                     |                           | the new vector and         |
|                     |                           | recomposes from the top of |
|                     |                           | the hierarchy. The IR      |
|                     |                           | irqdomain's                |
|                     |                           | irq_compose_msi_msg()      |
|                     |                           | translates the new IMSIC   |
|                     |                           | PA to its IOVA.            |
|---------------------|---------------------------|----------------------------|
| Message update      | No new device MSI message | Recompose and rewrite the  |
|                     | is required.              | device MSI message through |
|                     |                           | the IRQ hierarchy.         |
|---------------------|---------------------------|----------------------------|
| Composition context | No IOMMU mapping or       | Composition may occur in   |
|                     | lookup is required during | atomic context, so all     |
|                     | an affinity change.       | IMSIC PAs must already be  |
|                     |                           | mapped and lookup cannot   |
|                     |                           | sleep.                     |
|---------------------|---------------------------|----------------------------|
| Domain replacement  | iommufd_group_setup_msi() | iommufd_group_setup_msi()  |
|                     | installs the one required | installs all required MSI  |
|                     | MSI mapping before attach.| mappings before attach.    |
|                     | The descriptor's cached   | riscv_iommu_ir_attach_     |
|                     | IOVA stays valid.         | paging_domain() builds the |
|                     |                           | new domain's PA-to-IOVA    |
|                     |                           | lookup table.              |
|---------------------|---------------------------|----------------------------|
| Domain destruction  | The ITS MSI mapping is    | The IMSIC mappings and     |
|                     | released with the domain. | PA-to-IOVA table are       |
|                     |                           | released with the domain.  |
.------------------------------------------------------------------------------.

Hopefully that helps describe the design better.

Thanks,
drew
