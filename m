Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204044CADF
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586212; cv=none; b=IxzT8bn4ZSV3DQEXmEkuhiNGf1Iqys5H67xxUvjwhC2KJornWAb4EUrYFddLvZyFNGFAJ0y1Pmnoa+Dmef3/71nWiorbqOsfD0cBZ/iVX5ImSZglQtE2Mzngq1bK0YKiKRbCQZ9KPIYOx4LEnag3fnRtpRAYVns/L5NmCxQTG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586212; c=relaxed/simple;
	bh=BVuKVb3GjJxqNm9TcHoOWqlzIkLcGpeVo7X50mQO9+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghVddZXXHAhpoFqkR9i4NAAXFcnWZzGhAl71ROcYcWFmPMehkO0rwxpE6Oi2y3zMpD2UlBBblGMlKHgAI4AngFQ1e1VDjSHk0NnHeycmHQtalDKDeYbqFalcZ8LR0PBncQkIysQYdCKzHeH2QQzQpJYHha4Ddii9XfZq84T660M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDRhggI6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=huCC9xFu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDRhggI6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="huCC9xFu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCv0nE3402540
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 15:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JPxriDT4TyeXl7GuZnjO5GqL
	1w1hXm6wKfggUrOH0U0=; b=KDRhggI6LKxKcKQgK9ndPr6U6+/NJqGXK7N+RyfL
	9qUzhJL27TgxEDX67o8I41GWz1ZTwjt+v+bMcFuR2sc0rXhvdZMg7MQ7J65jtL+H
	9To7j/sqTuTAe/fnXcT91Y7xSyuLxqYMqStsaA14k2lbW/xfRYfF3TSQt+q6e12P
	ICgImxgvQ+DkxkhYDz66QH4aBmIysxp+e4V8xZZI8U+DytaUXYmTSuy8XIr9FZ3k
	LI/hgPYv9XpRvlkd7OJIgK5n8/nWc6VR2zEaoH0mnE2pZWJzn0liFaaNaimy9LCS
	Quz+R6z9t4D6ifoLlZ9bn6EPh9YOrCLFO+9dzHuASm+uiQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hjgt30e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 15:43:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0408254aso378721cf.0
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787586202; x=1788191002; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPxriDT4TyeXl7GuZnjO5GqL1w1hXm6wKfggUrOH0U0=;
        b=huCC9xFuR3KETL0+Jdz59yP+MjWGLVysuHxSNoN/4B6pn/pT1y0d95x2kBwezp//Rf
         pI4X8OaYG3n5l7d1NaFzTMq7MT4u8uHsJAQS0EXipIrG7G68Tk2TZvaZmCnEdtgg6RcB
         EhbcYDNuB9fQ112I0yBiKj4vbp1QKOObXvCZxDgvz3vs+3dO6q8qWx0TvGe52tCeWEdE
         FfIgqphcT8ub3j3blA9NhqIApyeupM+p7856oNTn2xFLxwextsoVgLSmt/Zps6oKnPdT
         UXvj/2LFxQXFvJU7UdFt7csUyi+07kua6ZxPPi71cxmcOZcpagFMNhhfg+JF2ejdyPpR
         6IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586202; x=1788191002;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPxriDT4TyeXl7GuZnjO5GqL1w1hXm6wKfggUrOH0U0=;
        b=SxRU5RvXgNdk+x5vrXk99OWIz3raxX5eTKNDm0jUNmGUnN38/vgJqskmI7Jn7zBemq
         7D60gVh9eWBKm1kPHsjf1DeOxBVC6BTdJQQvSc4KrR81+WCdlMDkhILFzVCMS/5ejC7F
         SdmAhnajpcpoMe6xYISHpnEOjijqUQ30k+gx+nbfCKTGVRhGr+O6nZJlqQmFlL3WBkiq
         ZWDPHTJgchWSK1JiJ7ZFVyLPDB3BQxDppjSa+FuZ1fNxdb/IzxYZiIW0SPbYmM8Nzlo/
         1i4xAYpi4bb1X3rQUeytTA+tgAyy34QYvDw6dxb9bRBnwT9J6Wujk8u8M1NZC6Pkd87r
         1nyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rri2YQfME8ZTpe3hC/kYKiRniMhhYuSoFpenJZeOOy3cI8bHclcUxxWqQbdLSgB0yCDMpcL1Q==@lists.linux.dev
X-Gm-Message-State: AFuF++lWVEVAqBql9LaRtOklBejq8Et2voFs6Y1liv5IrJe5K4CNhk+c
	bIdOXVtp7UPY5WgGHw4dbhGBjxRg2g71Di3KRtLzXe8ly7PEHXSxjzWRmb00mxvKAZg3SQarrYn
	h3AK3SEuG75IhVejnk36/i+IRSfmDpU5FJ38cVNIypYj2clvriFs69wg4SQ==
X-Gm-Gg: AR+sD137JE0Pyyg0ryz9KaowiMJyazfLGfAAuJM48rPI47PObj0tEiOc/hpVJBOwxIJ
	NsgFHIizre9GGgOTlhT+2tY5oSmK6c60VlHx0I43uut9JdU8WAowfUcVSbfSIXhDu1OFAO2p3Or
	yeenMzGhFanNSLH8qRBRn7gxavBZmGcFIxrVlG1O0J/C0tFk7uBFl9Ihv6dt6MVVYTV6EKPFkqr
	sn0oZIyOMjx/ZcDOquIAAVYCbiGKknWx+zKyicnsd4lIRe6FQkp2oGa+86wCJ3nK87FdkPf0l/Z
	QUfxc2xdiRI3SYUfj+4mqspImB+aYqBpNGjU2+U23mib2aea8K/VBXW9NBAMhywt5eCt3milGzE
	dT282zYSZ3atMJamsFXv7HOm6cW0ULQkFQJE=
X-Received: by 2002:ac8:5e0d:0:b0:52d:3483:ed0a with SMTP id d75a77b69052e-52e2ed154bbmr422591cf.18.1787586201968;
        Mon, 24 Aug 2026 08:43:21 -0700 (PDT)
X-Received: by 2002:ac8:5e0d:0:b0:52d:3483:ed0a with SMTP id d75a77b69052e-52e2ed154bbmr421881cf.18.1787586201366;
        Mon, 24 Aug 2026 08:43:21 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9bfcc31sm8488912f8f.17.2026.08.24.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:43:20 -0700 (PDT)
Date: Mon, 24 Aug 2026 17:43:19 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
References: <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
 <20260821143155.GI244917@nvidia.com>
 <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
 <20260821161256.GK244917@nvidia.com>
 <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
 <20260821172015.GL244917@nvidia.com>
 <t2l77h22pz2jg5vsgoth6324u36szra3orgr2g2xo7olyuhzlb@53wnsyhz7aqr>
 <20260822140625.GM244917@nvidia.com>
 <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
 <20260824125204.GP244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824125204.GP244917@nvidia.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzMiBTYWx0ZWRfX4X/Ge/cqPjuo
 YddvIdnbGf2LXRCOXh9vsRm2mgGi1y4Uqjp4f6X5MDSAzFZm2n5FO5j4TLXf503TQfWzET/y1DQ
 fHGxSoZVicT7SB6H4qLJktor+1NCc+k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzMiBTYWx0ZWRfX/ZSKQDV4vEkh
 LZQHe1LwEa5+L9DTCRacVKk0SPMElWYux2W+wf92pRrl7tjaslIEs6Xto0YlRG7kHYB728N+OEl
 NKeF6S54obWdz2wjff3JiixKQh4WdwTO0Z1+4UBKZnhKDpfKmRRVEyROwCBnSnC/VpU8PuPhQxm
 T6e1t9YaUerA+v5QxNhRHJiBc7kZZqsvpC+Lf6prwqYR6l4EiksDhZ9wpvxqFK3s+OLoojanC0u
 anqp2rkvhmGp5gYGnLYq5Lmce6w75As3txzP8VGBHkv5SdglODk9lG71BQcZlA97cx+WIjh+M3Y
 zIeLKm+B7hKIT9uc5QPHKXg4p6KvTF2UH/Gwz7TqKwXwU/Or798R30K15VpbLwNc+cqJiwWHWyH
 o1liznbpqvUDKAi3rv3bjx0VCvj3eHhG3NdIz1j/ZrzV/BztogTuFJrOvpNhBxnesot8QrEePD6
 D6uqXlfRlXVYiq9G5UA==
X-Proofpoint-ORIG-GUID: 8QfkgVr5UTuy-abC6yKqDP19K3on7amy
X-Authority-Analysis: v=2.4 cv=CoCPtH4D c=1 sm=1 tr=0 ts=6a8c669a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=79VhuxMTkY9i6mNDBz4A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 8QfkgVr5UTuy-abC6yKqDP19K3on7amy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240132

On Mon, Aug 24, 2026 at 09:52:04AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 24, 2026 at 10:50:07AM +0200, Andrew Jones wrote:
> > On Sat, Aug 22, 2026 at 11:06:25AM -0300, Jason Gunthorpe wrote:
> > > On Sat, Aug 22, 2026 at 03:50:05PM +0200, Andrew Jones wrote:
> > > > With the RISC-V IOMMU MSI table and irqbypass support in KVM, we can
> > > > write the guest's MSI messages directly to the device without
> > > > interpreting the IOVAs. 
> > > 
> > > Every architecture can work this way. Nobody has impleented Linux
> > > support for it, and if we do, it must be arch generic.
> > > 
> > > Not being able to discover the vCPU from the MSI descriptor means you
> > > can't use any of the existing less-optimal Linux flows and are forced
> > > to implement this hard thing..
> > 
> > The RISC-V irqbypass work does not require a new framework, or even
> > callback. It uses the existing irqbypass framework and implements
> > irq_set_vcpu_affinity(). Since that callback programs the IOMMU MSI table,
> > it belongs in the IOMMU irqdomain.
> 
> My point is you can't use the normal flow which relies on Linux fully
> programming the MSI-X on the host side and only uses the guest
> descriptor as input to that flow.
> 
> The iommu msi table doesn't actually help unless you can also directly
> use the guest's descriptor. Right?

I see a gap in VFIO's vector management for two-stage device assignment,
but I don't think it's as broad for RISC-V as it is for ARM. More below.

> 
> > > ARM is basically the same, the ITS page goes through the S1 and S2, so
> > > the goal is to get a valid ITS page into the S2, tell the guest to use
> > > it and create a S1 pointing at it then feed the MSI descriptor from
> > > the guest unmodified to the HW.
> > 
> > On ARM, the SMMU translates the MSI address, but the ITS performs the
> > interrupt remapping. KVM must therefore know which vITS the guest IOVA
> > selects so it can resolve that vITS's DeviceID/EventID mapping and program
> > the physical ITS with the corresponding vCPU-specific state.
> 
> Not quite..
> 
> IIRC the MSI entry itself tells which pITS page has to be used since
> they are 1:1. That tells KVM which vGIC has the vITS table so it can
> read that and get the vCPU. Now the IRQ layer has the pGIC, IRQ #, MSI
> # and vCPU. It then creates an entirely new MSI descriptor and
> programs the pITS and pMSI entry. The guest MSI descriptor is thrown
> away.
> 
> It is like this because this is how x86 does things so it is easy to
> implement.
> 
> However in idyllic ARM land it could work like RISC-V. The GIC could
> mirror the vITS table into th pITS table and apply the vCPU to pCPU
> mapping through an irq domain. Then the guest MSI descriptor would be
> used unmodified. These days x86 can be similar, if the guest has the
> iommu remapping HW it could be similarly mirrored into the physical
> remapping HW instead of reconstructing the MSI descriptors.
> 
> This has never been implemented because there are alot of missing
> generic pieces to use an unmodified guest MSI descriptor.
> 
> Now, risc-v doesn't need to mirrow TIS/remapping tables from guest to
> host, because it doesn't have such tables, but it still will need the
> rest of the generic machinery to use unmodified guest MSI descriptors.

With S1 Bare, irqbypass can fall back by restoring the host MSI message.
With guest-controlled S1, VFIO cannot silently switch back to host
delivery. We need plumbing to establish a guest-owned MSI mode, preserve
and mask the guest descriptor across the VFIO vector lifecycle, and stop
or reject the configuration if that mode cannot be maintained.

The guest descriptor itself is already available in
kvm_arch_update_irqfd_routing(), so RISC-V still does not need to
interpret or track the guest IOVA. The IOVA can be written directly to the
device (since the IOMMU MSI table is pre-populated with all vIMSIC GPAs).

> 
> > This ownership of remapping (for ARM in the ITS and for RISC-V in the
> > IOMMU) also justifies why ARM does not need an irqdomain in the IOMMU and
> > RISC-V does.
> 
> Yes, that's right, as I said earlier the irqdomain for the msi
> remapping table seems appropriate.
> 
> > The irqbypass support is already separate from this series. This series
> > only introduces the IOMMU irqdomain, which owns the IOMMU-specific MSI
> > composition now and will provide the irq_set_vcpu_affinity() hook needed
> > later. Putting the compose code in the IMSIC irqdomain now, only to move
> > it into the IOMMU irqdomain with irqbypass later, would add unnecessary
> > churn.
> 
> I'm sure you need more than irq_set_vcpu_affinity() - it still has to
> use the guest descriptor unchanged, and it still has to get the
> correct pages into the S2 at match them to the ACPI/DT description. We
> don't have any common APIs to do that, and every arch can use this
> stuff.

Indeed, irq_set_vcpu_affinity() alone will be insufficient for two-stage
guests due to the VFIO vector lifecycle concerns with guest-owned MSI
descriptors.

RISC-V does not need S2 page-table mappings for MSIs, though. The VM's
IMSIC topology identifies the vIMSIC GPAs used to populate the MSI table,
and an MSI-table match bypasses the normal S2 page table.

> 
> Without seeing the whole thing it is hard to be sure exactly what
> arrangement people are going to want to see. I'm also not sure how to
> combine the iommu MSI handling, unmodified guest MSI descriptor and
> this msiremapping all together. A guest centric flow and an normal
> host flow are very differnt in this model. This is all new.

I agree there is some new terrain to travel here. It'd be great to discuss
this at Plumber's.

Thanks,
drew
