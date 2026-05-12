Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617639E9DE
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602971; cv=none; b=ByMh9fBTsE0Ti6DpO2i6tH21QIba7f2nNFdI9sQBqk59OLvjcq5xiwfZsCJKH6ugFTer4PjOIFzx6wa4N/0ycIFb/xmzafN8kl8WEApWJdsgmaD9ac1UuMefftCc3PVMhE5gpIkUYQgPlXSSMMP5k8979QjdyheyIBp0ivWKxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602971; c=relaxed/simple;
	bh=nQcryJjc0dUdDzGZvTIwIFX6N7+1kkXOpHIYLmZHE0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeNVhNlfCX/21RQdzle7yJ+GO0nRvfJule3w6bgig6jfnvjHTAPStqHozxJ5/8SBMT1+XIM4v6AL4BcxAix0Q9aiRFGRvc1NINCkyEAA1K5mX4H2CO4HJ/RpLLTCnTld3NeenV4zKNlCVj/xvMEikA+0QnxIgUGhpq4L7pECR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fcTXazxA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jqyTKAh1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcTXazxA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jqyTKAh1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CEJ7x0423741
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 16:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qRwPFmafq8aDitqqdeTEYsYa
	CrD01rZu4CmP4WMZOns=; b=fcTXazxA9Q0AqDAPozRchcdRbAoxg2fXRLgSTcLX
	A0pBdC6/4sHYz7KzqKVPjnhtC04FUr8MDphD2wye/GfUmhgNwKOdowAsgLyViX0Q
	T7TfTDbE/bxssWZjUDTjDAq5ERyhTTRnm/C3Uf+pw1Uh0SXOKa4xQC0R1FZMOFID
	vbU0YQN6ZZDTcK8Cv84CfXTSJBi7kUJifUHQp5atyBrdEqe3j1uA4CJzZgempPy1
	IUKdfYrj1HH5Ye6CbacD56RKn40VNMSRq6JpkMoWw+TkZLL6JxfNuq5eJynARtmS
	+UHTThjiHL3ayRSFPTWm9tGsdIX+2WQQLwvxBQ/uNQWgjw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45v58gv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 16:22:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f525565b33so6924035eec.0
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778602969; x=1779207769; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRwPFmafq8aDitqqdeTEYsYaCrD01rZu4CmP4WMZOns=;
        b=jqyTKAh119U5kXGPC3ApHIQtml5HFUpOjz1Znpusx1ZJy7TJyYtg/JHPG2sbvjAB2P
         BZl0BfZo2XXZtWPu4zf/mGQC6FNodor5yV6RxZ2zTd+/ZmYSIw45J5BAvfYaXHb7Lg/X
         rE4/NquYBf1s8J12TsF837kRNv3TERA4M0o/wGAXClnGKhjWvlcIxCUzYCfSI/zrYH2b
         06QP/BrD1BT5SF86AM+CowPpdXubM2878rV0HpHo2fWeVIPyi4oM2iVQqDMYyqNDXTUt
         e+xZ0bWfukAgpyODPkq2hNC5feEr2UxFLNRcxwVquwW756sRMJ4aK3slai4y81bMrKR1
         N2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778602969; x=1779207769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRwPFmafq8aDitqqdeTEYsYaCrD01rZu4CmP4WMZOns=;
        b=ZV2VFx/PTR/QLLJ70YkokLMk167bb/5VQ/aLjRMrtGJ8pPqp8bCZDwz4deKz4K/m++
         Cpap4nnoZiyjlD0e8bbIdT2rjpodRJA6/f5iQ9pIIbXm5S+4Uaw6rCcazf7gOcnBvomS
         tAMdvsRQRtueuIZrg6PMAIRTwrSwCIGRLhFRSUX8wrwlpPV7byuhUgb9amIYYTrignxH
         Aoh3AoSOYO+Z7sKsw9ZEnKHeThagLwvHN+NsdtzFNrwV5DlejfSZ6vV46uXgqCxXnLmU
         LyNQmxSyWcS0yHMmdzL+uV6nXDBrWk4lsa4ODIQSrGvBGF1+c3Gc/69FJUqSuapX6cQN
         1eRg==
X-Forwarded-Encrypted: i=1; AFNElJ9GuY5Hn6TbOL3qrenLgXD9szN4dVKg60U05B8jmre4lwpSqzMCP+5AMR1lo83U3G/7iLF4fA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzW9gIUexIb4BZp7/Q4B3Nw5jmI0BMDPgvUw6mbB0P4uPIV/g+B
	DuJdjWS2OeHvX+Tfvj2NeC/nN2atgKizjhx0/EOmdl7HI3B+OykmlVZLo95aMwJuU3NFFxOCgKf
	V3a/hXLNCXTNI2H7I9klvT8m6QPsf0E+uPXmLc2mCK+ZdjSSc2UDJyq/BrxxFKI9k1g==
X-Gm-Gg: Acq92OEcjPqmB8rM04IvvZOt4kBIw8908uURuxY9dPlx/a8wzwSBvw6JS1kMBHDj/IQ
	bDSJF54Ws1tZpBsbTa5vQPgJPVm5uXAsziK08bpXdYqhO3/dCaMDiercENnCDSGFzW5J0tTLOql
	cnbJq0Eav1Shi4+0b5dOozip114J52OJwtYQWZgNyw+tt7A1Pq101UD+S+uQUiTYtwtVOKI6zrv
	zW2l4iFA+bEZvJasTyRquBJ1Mn5n2eaJkWeK0BXMgnNlR6CJO6rrtf8JINDUAHqTIawFDKT25Sp
	hUvpV5WpvjzltFFxsHy4RxiK5cO9/heTk9uuo7i0MKviNsPZKL/NzL+L7opLvMzw0cyiij7Mycm
	i7H0uisiqNc7wTmRY8Im1NHixQKeHiw==
X-Received: by 2002:a05:7300:6ca8:b0:2d2:96e8:1bf5 with SMTP id 5a478bee46e88-2f54d696b08mr15324437eec.3.1778602969027;
        Tue, 12 May 2026 09:22:49 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca8:b0:2d2:96e8:1bf5 with SMTP id 5a478bee46e88-2f54d696b08mr15324396eec.3.1778602968356;
        Tue, 12 May 2026 09:22:48 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e3e285sm21663793eec.27.2026.05.12.09.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:22:48 -0700 (PDT)
Date: Tue, 12 May 2026 11:22:46 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tjeznach@rivosinc.com, joro@8bytes.org,
        will@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org
Subject: Re: [PATCH 1/2] iommu/riscv: Map IMSIC addresses for paging domains
Message-ID: <eiikdvzbjffmsnejcsmpv34ljo5afurz2m7g4do6jxrrpkhnes@dsfruyaccvkh>
References: <20260508212339.381933-1-andrew.jones@oss.qualcomm.com>
 <20260508212339.381933-2-andrew.jones@oss.qualcomm.com>
 <20260512133854.GA9129@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512133854.GA9129@nvidia.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3MCBTYWx0ZWRfX4OMySwi1IzZ3
 GvSAdIDGrrubR5BX4cY124LxCPItCLpF2lXWFthBWw/NcF2lXv99ieHKd5dwxpByx3UKv2Omg9A
 9dxljQz03yBJ+z3eo5DxJ1DlwdJuPVeLGBlIjrQvGxZG5+tBqVrig/T+Q1q2g7+ShXxJiggoYql
 4M7lE5gtzjzdydL341LmCqeq6V1aQiqw/3x4GoMeFttzwT4Lmd3JTju+F2BLZ7QsjRFiT4SlpPK
 VJH4GBkvREo4eiup8AheZc/i51XpLd90LU2hJuVGEVhh2uJ3Zqre8VmIkw1KYZ6CqhxY042XXQa
 L2XjxaCZ3eXlpHtdjPRwy+FgXrLqP4UgbGyaaQOxfmGg9ZBHCYBbxyr8GRox6G8hCjq32NGPCs7
 pJ9ljTwHKxKkLZ+j7kvSEPtsYVJ3VIpvb/dIG0idK1/RZecObsXeRTt922i5et0KTjkMTmnyLlm
 nY2M1OHkgBtMkv1GsQA==
X-Authority-Analysis: v=2.4 cv=GZ8nWwXL c=1 sm=1 tr=0 ts=6a0353d9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=yzZ8afvO4vg2XN0Uw84A:9 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: jYUYGqBbTRM2qLy1E-b916aqouVumfpc
X-Proofpoint-ORIG-GUID: jYUYGqBbTRM2qLy1E-b916aqouVumfpc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120170

On Tue, May 12, 2026 at 10:38:54AM -0300, Jason Gunthorpe wrote:
> On Fri, May 08, 2026 at 04:23:38PM -0500, Andrew Jones wrote:
> > +static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
> > +{
> > +	const struct imsic_global_config *imsic_global;
> > +	unsigned int cpu;
> > +
> > +	if (!imsic_enabled())
> > +		return;
> > +
> > +	imsic_global = imsic_get_global_config();
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		const struct imsic_local_config *local;
> > +		struct iommu_resv_region *reg;
> > +
> > +		local = per_cpu_ptr(imsic_global->local, cpu);
> > +		if (!local->msi_va)
> > +			continue;
> > +
> > +		/*
> > +		 * The device always writes to the host physical IMSIC address, so install
> > +		 * identity mappings directly. Use IOMMU_RESV_DIRECT_RELAXABLE instead of
> > +		 * IOMMU_RESV_DIRECT since these 1:1 mappings are not required for assigned
> > +		 * devices.
> 
> Oh? Why not?

Hi Jason,

I should change the comment above to be stronger. 'not required' sounds
like a choice is being made, but guest devices must not have mappings to
host IMSICs - that would break their isolation.

RISC-V AIA has the concept of guest interrupt files. Assigned devices must
write the addresses of those interrupt files to deliver MSIs to guest
IMSICs (virtual IMSICs). Also, the VMM can map the virtual IMSICs where it
likes, which will not necessarily be the same addresses the host IMSICs
use. We need the irqbypass series I'm working on for guests, not these
direct mappings.

Also, I actually discovered IOMMU_RESV_DIRECT_RELAXABLE after first trying
IOMMU_RESV_DIRECT which resulted in "Firmware has requested this device
have a 1:1 IOMMU mapping, rejecting..." failures when running the vfio
kselftests.

> 
> > +		reg = iommu_alloc_resv_region(local->msi_pa, IMSIC_MMIO_PAGE_SZ,
> > +					      IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO,
> > +					      IOMMU_RESV_DIRECT_RELAXABLE, GFP_KERNEL);
> > +		if (reg)
> > +			list_add_tail(&reg->list, head);
> 
> This seems like quite a hack, the ARM was seems much better, the
> interrupt controller should be using the iommu_dma_prepare_msi() path
> to obtain an appropriately translated MSI address for the aperture.

The difference between ARM and RISC-V is that on RISC-V each CPU has an
IMSIC and the device will target any one of them, depending on its current
affinity (i.e. the MSI target changes with irq-set-affinity). ARM has a
single doorbell address which has a single IOVA->PA mapping created for
it that never changes. The ITS manages everything, including affinity
changes. Even when I get an IR irqdomain posted that implements
irq-set-affinity to help further isolate devices on the host, we'll still
want get_resv to pre-create these direct mappings since we can't
create/alloc them at irq-set-affinity time which runs in atomic context.

Thanks,
drew
