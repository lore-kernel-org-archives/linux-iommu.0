Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7D3AAF46
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561414; cv=none; b=TC2I6ZSGQcdus/LUectglYgnCCdFCJAKHAeF4b2b10zgk3mwsQCAsMej7MiFToW9fX0skVLJfoQTzwaFzdLPkHzkdJj6T8SVIqezwZ6vnhrTNxpG8mcuhKMJcIsq4Q6gwNOZSUbZ//I1LRcuSzm4fXv4sSuS7fhUT4Rhm306Tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561414; c=relaxed/simple;
	bh=rpVqepNBEX6CpoptUmiGy9FNwOcOQFeZdT3YTFExm+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIS/IdOLyhbi8+0gOnbe6GnT3wDoa31slvM2+otUmK6S4jThzineehnLnba51PjiJpGpi5wB2afICCRiREJdhFMG7p/f+8Jl96GV4y7FGwNXR+R9DXh7RyOD4EiGLENd/CNILQsxsEEzsD8fI/3IVDPSdtH4dfsrCjQnXjWZxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HbHc3tXR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kEl4a7p5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HbHc3tXR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kEl4a7p5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RC0D1477849
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 08:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+4gKgrnxjNoIWkSGUuG04M4x
	7jQgXnRYwDNE0RxA+Ps=; b=HbHc3tXRp3zjS579RDThqdJ88jgrktxjgLtUhnA2
	dPzVudGHnc7d7/zZsI37ijMeWBxWTV8XZBIY7FtCsLok+qHbdTclDxvyL6NUo2rh
	b/HA9T+u/WYnSWcWT9rrFTm7B0OyoWqCyrz0BVJ/blSTmFVpW33bqxEh95NHH0Sy
	K0vifXlm+uSW4Y5pWPFawyIHrBgiX397qo8fam67jyMSsX1YjfXHJuBHd02EI5id
	X6TvVZNHmEpGTosYzABKWqjCAsntRoB0f3j7rRZJPb9fOCsr+4wMirW8k3Qz2KsZ
	NqwT6seDNSZzmZJJi67nEEwtFQdQ9nQn1KU2ntRGydespg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g7528p2c3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 08:50:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52d33c89a29so42791741cf.1
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787561411; x=1788166211; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4gKgrnxjNoIWkSGUuG04M4x7jQgXnRYwDNE0RxA+Ps=;
        b=kEl4a7p5/IGsQh/v6ZiU0biTS3qE9XIBXlTjWZhrYF3TEiBStZMCrr36bFvMBdEuNc
         0357WAy3UAVZbP/6fbwUL8mq6IWmhXHJYSO8eRwI3cnh63bZAaylE6m67TYYsSfQSfgu
         RftjjGj9DWk631nJ/G5oxSJbJLvrmHRPEfPai9jfRU9SxHms6BDJxfNMO7avIR6JJZot
         lwkAp8VMgSQIyyBHDM6Ijk0eC+sah0mopDEFDcAO5HXdyxPs7Tbe8ZlOHSpyCgTcfOGF
         6dlcIPSJqLAePGl2xnxVMdSAL17GF4s4iAHTt0kuuJF40MJ+7dvSZZ7xeKl7w02Z74sa
         d7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561411; x=1788166211;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4gKgrnxjNoIWkSGUuG04M4x7jQgXnRYwDNE0RxA+Ps=;
        b=T+l7DzE3NRVx4jZ7XGOdDd0OvlmCOYh4jfsQhNNU1o/szyX0DgHmYWkljPIoRGeOgv
         f22618fqIDXNMymT/FfHhWB2pU5azY1n4YWr1LNwiPrO4oMRD/2aLy53hXJldqP6djDY
         ouJiqZHDp1LJyn0BwenLQDXYxmbvCGRGZk8o6dPaB0OzScK2PXOHqbP0hQG2rdyTRtT9
         SzPwpqcswLCRUBFPU4NikrlmmKyb+oabjDK1G61sPBmd7fxsXTIIzPU0JFM5rDqJbr/S
         VZBVq+dywefWLmaBgoQVHkD2BmFgasSzyrOOLAeItrmtPt+xmgyFVL+51sb50l4P6gQK
         Fssw==
X-Forwarded-Encrypted: i=1; AHgh+RqM11bgICxBProBTZXTtBsOeLN5s2MEOj4TWt8qIAMtD7FIoPE4rpmE6/k+aQjowhcqPXLXpA==@lists.linux.dev
X-Gm-Message-State: AFuF++klJKbzrmpq9cbwSkzgWV1KfBZpAzlLiVluUE9xZJq5jQFPFmA7
	Ur1EVBxIZ8WTVdRFm3+L26FhjU1BBAz04pPlwz+7Jz1JwlZKWOOfVP5hboSMhy8kMaqZp8syLZG
	jQOc9Nf7rcgbyQig+9J3rUXtRq3GHEwv9nmfj0gpGRDkBc9ntAyYNM/Lytg==
X-Gm-Gg: AR+sD10SRL3/S5y6FGcbZ5/ITlxGX3rdCdD3viZwOjc34SSDFrjUaFKQF0NMbk5DRgw
	0FTonUcPgjTcEef9qnhdjXEnDFvmRFE2KYyD7atwwl+kNRAUlu3vr4hzbh0T1fAkvbs0J4VSHRz
	M+VKFDrlOsiKIns+3uOyhMAZsapdrBnEfCu5mvZcrgdTIkx6W0OGFrlR347wysnhQ8aawVJJ9SS
	IxeXaf9WmRYG1gfTnSs043nYCUYQcfMOOgeDBPYtaKAasPLVSuJkUwv2C7KkpMFqIZd1Bbk/IcF
	CviQ4kRULHurOQp2lQUWmd+CMWSHB8+braIWs9ZCshhB9BdGsDu1N95F137BS/2w7XKyeerwqek
	f1cNQsy6KXJD0uiSdSNTxI1WMFWLZMG0BNXg=
X-Received: by 2002:a05:622a:4d8d:b0:527:7813:a439 with SMTP id d75a77b69052e-52df5a09808mr275658621cf.27.1787561411232;
        Mon, 24 Aug 2026 01:50:11 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8d:b0:527:7813:a439 with SMTP id d75a77b69052e-52df5a09808mr275658531cf.27.1787561410762;
        Mon, 24 Aug 2026 01:50:10 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499bf9efa89sm59322725e9.4.2026.08.24.01.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:50:09 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:50:07 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
References: <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
 <20260821140033.GH244917@nvidia.com>
 <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
 <20260821143155.GI244917@nvidia.com>
 <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
 <20260821161256.GK244917@nvidia.com>
 <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
 <20260821172015.GL244917@nvidia.com>
 <t2l77h22pz2jg5vsgoth6324u36szra3orgr2g2xo7olyuhzlb@53wnsyhz7aqr>
 <20260822140625.GM244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822140625.GM244917@nvidia.com>
X-Authority-Analysis: v=2.4 cv=DsJmPm/+ c=1 sm=1 tr=0 ts=6a8c05c4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=DL6v956EkLcqk1V5DJcA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: aI_GL08aoH8PHpkLonB-44i9o6i-OnMG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfXzgKRqKDJ55VY
 pzunTizNO/SCaK+WhSR90DlqAADrF1ZO0bHCvesFa0yBKi1lQZnWLcT2lOAR1H5OQeKU+wX8HiQ
 rLOpcb6+yYJ+SVxrYjuG+S9wcIDfqaNvlDaxadHvJ8JJCeBuzhAQO7MHIjnZy7hhyz9ayLwozt2
 iFItgJBmbM1nG8J9pMv/GrYKcFliZiDdtcCJ9eeTnjUbr+KJKAvWQtaL9D96erdhgBWsDg+H/bS
 LOkOYGTXu6QVzgAk8NtbFm4sRjcOSxd8Ytv6qXNPTcrDkmUuWIouPoaf7j4pbX7AMwvyEarecim
 Q1s7zvr/hng63LYP9CkRHilsNJc0J5Vqex8vrKvNNGHIl4KZ50f1gk9sn5++9jMon93BEmih6Rq
 PR26d3mFY0J7aXsoSOj60WKg6ReX9mHpfz7FEzzWGsEWxcprZ8s0Z0Dk2Y985CFxhwh9blqvfDW
 lknUcIlFzccEJBTitOQ==
X-Proofpoint-ORIG-GUID: aI_GL08aoH8PHpkLonB-44i9o6i-OnMG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfX8zEf/xEi9J8v
 vEvhN7HNxsLM34J8BQlrN79OvLj8CqQDTYrHWp6P26Kwm4MgKxgG7sH7S++y3Pp5e+nk0V9voqZ
 iboVWbi7+P0ifVLZro1i1Uql6mvf2RM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240077

On Sat, Aug 22, 2026 at 11:06:25AM -0300, Jason Gunthorpe wrote:
> On Sat, Aug 22, 2026 at 03:50:05PM +0200, Andrew Jones wrote:
> > With the RISC-V IOMMU MSI table and irqbypass support in KVM, we can
> > write the guest's MSI messages directly to the device without
> > interpreting the IOVAs. 
> 
> Every architecture can work this way. Nobody has impleented Linux
> support for it, and if we do, it must be arch generic.
> 
> Not being able to discover the vCPU from the MSI descriptor means you
> can't use any of the existing less-optimal Linux flows and are forced
> to implement this hard thing..

The RISC-V irqbypass work does not require a new framework, or even
callback. It uses the existing irqbypass framework and implements
irq_set_vcpu_affinity(). Since that callback programs the IOMMU MSI table,
it belongs in the IOMMU irqdomain.

> 
> > Guest changes to S1 or IRQ affinity therefore do not require MSI table
> > updates. And, when a vCPU moves to another pCPU, or switches between a
> > VS-file and an MRIF, the hypervisor only updates the MSI table entry for
> > that vIMSIC GPA. The device message and S1 mapping are unaffected.
> 
> I'm not sure how you will end up controlling the msi table..

Through irq_set_vcpu_affinity()

> 
> > As I understand it, Nicolin's series addresses the ARM split between
> > SMMU translation and ITS interrupt remapping. 
> 
> ARM is basically the same, the ITS page goes through the S1 and S2, so
> the goal is to get a valid ITS page into the S2, tell the guest to use
> it and create a S1 pointing at it then feed the MSI descriptor from
> the guest unmodified to the HW.

On ARM, the SMMU translates the MSI address, but the ITS performs the
interrupt remapping. KVM must therefore know which vITS the guest IOVA
selects so it can resolve that vITS's DeviceID/EventID mapping and program
the physical ITS with the corresponding vCPU-specific state.

RISC-V has no equivalent ITS state. An IMSIC at msi.addr simply receives
msi.data. If every vIMSIC GPA is mapped in the MSI table, the guest IOVA
can remain opaque. S1 selects the vIMSIC GPA and that GPA selects the
correct MSI PTE, without ever deriving a vCPU, or having ever derived a
vCPU or any other per-IRQ state, from the guest IOVA.

This ownership of remapping (for ARM in the ITS and for RISC-V in the
IOMMU) also justifies why ARM does not need an irqdomain in the IOMMU and
RISC-V does.

> 
> Exactly the same as what you want.
> 
> > The guest-selected IOVA must be preserved for S1 while ITS routing
> > is managed separately.  RISC-V performs MSI remapping in the IOMMU
> > after S1, so guest MSI target changes do not require corresponding
> > per-vector coordination with a separate interrupt controller.
> 
> In ARM you'd manage vCPU mapping in the GIC since it is already doing
> translation lookups, this happens without involving the iommu. It
> doesn't need to change the descriptor to do this.
> 
> But conceptually it is the same thing, there is a part along the MSI
> chain that maps from vCPU to pCPU. Either in the GIC HW tables or in
> the IOMMU MSI tables, doesn't matter much, IMHO.

ARM needs the VMM/KVM to track gIOVA-to-vITS mappings so it can program
the physical ITS correctly. RISC-V does not.

> 
> I think the two x86's also have a very similar thing where the iommu
> interrupt remapping tables can do the vCPU to pCPU translation.
> 
> Again nobody has built this and if we do it must somehow be able to
> work generically for all arches, so it will take a while to get it
> sorted out I think. Since riscv's HW design boxed themselves into
> doing all this work I guess you have no choice.
> 
> I strongly recommend you keep it seperate from this initial series
> (And remove the irq domains from this series) and come with a proposal
> that everyone can understand how an arch could hook into all of this
> machinery.

The irqbypass support is already separate from this series. This series
only introduces the IOMMU irqdomain, which owns the IOMMU-specific MSI
composition now and will provide the irq_set_vcpu_affinity() hook needed
later. Putting the compose code in the IMSIC irqdomain now, only to move
it into the IOMMU irqdomain with irqbypass later, would add unnecessary
churn.

The design itself is not especially complex. Most of the current
implementation complexity (locks, RCU, deferred MSI-domain attachment,
etc.) came from maintaining msi_iova[]. Dropping that cache in v5 removes
it.

Thanks,
drew
