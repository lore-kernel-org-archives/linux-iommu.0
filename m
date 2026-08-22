Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4B2F3C18
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406617; cv=none; b=LVPqNX/yiw127CxRPBnCz+CO+xsqObKH/pujaxXZ6EyYNuOwbRWR/4OjD0sERSvXWHZytxzPUIZyWTRXRNoXA66QCEfeSA6WjPPUHBZa9XRw++umXHJXJfK3QQfyjS+DjTLR4atP+8iVJqNSsJGJ+DmoEGD/fmQeeAzXZCKEdao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406617; c=relaxed/simple;
	bh=BLIXsYpYA/p3zykEgVqz+rKbGbL/73EILlMQO98+h3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw4RFNtaTXh4b4hy/oRc2kBXkvHh0PgeOFBBkMVcrZpj+s6nauKNpBIyFEwfe/mw4xFNwja8famx4hg3WM004RYDjHItcnTt/RhRW3M+kgMn1W7niJpecddY1Ac6zLKU3F3la3nK3G2I/eFqBwlBlAF5S2sQE0XAWERtvSWv5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZsIaUaB+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K4oCMZ1X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZsIaUaB+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K4oCMZ1X"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67MB6i1k1063488
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 13:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MQZd3mlyLKLZ4bkYPOlYGln5
	yVbgJtgSpLBt9iGtXzY=; b=ZsIaUaB+fXg9v4plSBsAehTTAjOLzxDReSqFQ/wJ
	1u8QUda5o0Muo3+xu67YwXzexif52zZdJhDbN/EjQEjKrcCIc4sXe4ODo1xM+Hxw
	v1Q+0hXfZ1oeMlnRJqgPtxF0SFu6VSDMjkaAm6r4+zapbX1nH4JYIlbAJiWIak9P
	0Ze7ArWCT50dkAQt7aw208yaH7U0+rLXkiv4on60fRR6Tr+wVId+2UEDjbLvCQDm
	EO9M+dmfz0RldBS4Oxcd370Lr+JTBKmSsdoGvG6PlpVNNCyJDNfRq8zXPub97rqL
	fhzcpbM2GQjW26/qU7GC9Y5ok+IUmdH+bEOPb5VLeWSVpg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74399a4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 13:50:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d9cef8d15so34648611cf.0
        for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787406608; x=1788011408; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MQZd3mlyLKLZ4bkYPOlYGln5yVbgJtgSpLBt9iGtXzY=;
        b=K4oCMZ1XSAt+5ppAN02Xw64KxzzhSBr9mSpJeFLXEDndDHvNxjZOsf2cwDMM59huvF
         EIh8PnYIyAwwFO6Hf72J0hKn4EVlldwnS11kzZPzSE09nZzOVgQak8zi91vZ6QFzcyhC
         3KAd2A40LnP1s5NQM+flRjlwz3sWfNznHF+jKwjIJMvX0F4NArzsa3FoebCMWsZqQCXB
         j7H4enoNlOJS/Z/BMda08VncxKD12nII8XL92PXNvs1afBnb4qXcylnY/zXunU5KRSGL
         6xZml+1/CK3ze4U1pMbVfppGt72umyIy8ttHrQrZd/84eBfE4J2ocHT+8kfSJ4Ey+nes
         0Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406608; x=1788011408;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQZd3mlyLKLZ4bkYPOlYGln5yVbgJtgSpLBt9iGtXzY=;
        b=BOLydqf2KQ5MM9EflvpX0DlpMFGCfWEjS1KnzeLhk9+Ri72qjMBnkR1EGX227qOCIP
         tBKhP6IkQYz+i2oqK951WMWRYnV0cD5EWjx6eaSjbWBLE1eQhdBapuY36wuyH0DAOIdM
         Ht6xWprBUEEE9YoPyGrPi7TbDj3WHkZ5/4cGnlwK9gHgcyp11k+m3nphMgstiI+mVnFt
         pwyNiZnAxmwIsIlvxrZmEhm9XW1ywcC/orXCSBnIVTadqA7r5tE4UlPIXETDaK31kIca
         OlyPJxbUsadVoPauTRf7B1zYOojgP7KcbEXmATgBQ90yQZ/CllW8TBXkfkifUCTw9vys
         zTnw==
X-Forwarded-Encrypted: i=1; AHgh+RrVq9QCWBFK9T8DUAd/H2yg9wktn5Meb82FL9kO2lm5Img5p1sFTMo5PXQQ9YOiQbIITZ0EvA==@lists.linux.dev
X-Gm-Message-State: AFuF++mJQusNQhGDrizg5ukK1Lgn8TyOECwZHSr25RsdPFQ/xUnLhT9h
	bSk0AV8e0EMwPg6Q1O24KoNKpdgRTAEybPZN0Db6U9AXDhBA25SvTQHHfQhWjbfX8Nu9uZHA1pR
	BBsteTm+uwOLs2vVoX2WLFu3i30sKo6rrlo0NNkmbPEwiebD/ljS2dXcE5A==
X-Gm-Gg: AR+sD11aa/u0j4yYwm6FhX1XXIhcA4luaCKwrgo78KDXx70EoTxertxNP3QimL8bHQd
	0yUheDyqvLElQIjoEAEkIFvWUc4lFBmzw46drWN8wH1dcqZXhSkYXrpqco7zTHddIw0FKkTqf+q
	kf4uaBPzmHgqur9BEV8FS8jJQqK7/YNkfgCiuIoV7I3+HKzEwEY3CJgKB91OZdhrJvAqrV/SC5X
	hY+YYD+oGOWWNJO0wBBXkQK92sA1ZtQijswu8DR9K/tuPsFf8TDXguUHEaSJRJAX88YcOoA6aWl
	v1GwxyF/jiL++0JNwmNv29fqQuVHAWxiArlzshSHaa6ysw06GjhV579KKAa92nBwW9uOEWCkqtc
	x63cLESjSdN7rSW+nMJq7lzyD6cHJ6dupdTk=
X-Received: by 2002:a05:622a:481a:b0:52d:f484:eefe with SMTP id d75a77b69052e-52e09cf363amr54379831cf.35.1787406607973;
        Sat, 22 Aug 2026 06:50:07 -0700 (PDT)
X-Received: by 2002:a05:622a:481a:b0:52d:f484:eefe with SMTP id d75a77b69052e-52e09cf363amr54379411cf.35.1787406607607;
        Sat, 22 Aug 2026 06:50:07 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9a95fe9sm39482445e9.0.2026.08.22.06.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 06:50:06 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:50:05 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <t2l77h22pz2jg5vsgoth6324u36szra3orgr2g2xo7olyuhzlb@53wnsyhz7aqr>
References: <gr2h3ktgacozyo7rdggkxsg5mbdtzcnimaawd24c37hnf2tun3@hqivsenaq5wd>
 <20260821120204.GF244917@nvidia.com>
 <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
 <20260821140033.GH244917@nvidia.com>
 <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
 <20260821143155.GI244917@nvidia.com>
 <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
 <20260821161256.GK244917@nvidia.com>
 <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
 <20260821172015.GL244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821172015.GL244917@nvidia.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDExNCBTYWx0ZWRfXwwBOJSl8WBQz
 duwbgTqreQ/IT9UHadDnLPs+7Z/sm0eaLhTFHjEC7tz9oyE/esDsLkrV8n3vXbXc6uo602Oz/fa
 LDDNz087VYqwZsgcX1QmZWTC5pvrYRVLHrFxVZLSn3f69OPRIsPG4VPapRzvG/M/N9ElymuhL35
 5+VL9uHB/EKp167AYIIopEc3ux5PMRFo49QwaZPby0mtK+jWasAkXSThKleT5tLVKUtdFq0o+Q3
 uYadM8+Ez1smnxkEBR+BK/g7pmq4Bh2G1VbkEGC3il7x21odLYfK5xUGvH6kd5eEu5HgIBCohX8
 cZ5qx+TF9gDBcuDedUBNkEFVmExDi5riqeuYQhYWmRmWPdP72ethbuB15eOQc49qsWub9ohCG05
 3g7ADdFERVVkOa4W0FrRl/aR/Pd++/eXj/OXs5SVe4kixpVRHfGFbuLw/r+G0WR893kvFQDm9Bf
 3lIKK+Q71ObWZRbSLQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDExNCBTYWx0ZWRfX3RhBVZOp8AX8
 i0egt/Aml0yqVRwzl4LFcbv6kaGKiwKV89Dexo8L6oHZUdMZIEk2AuwEr4I+xXmuD0GIB4dlZ2X
 JjEPN8ZzGqt4Clyq6lbVWwORQAxDHdw=
X-Proofpoint-GUID: HBFlZBNsEp_x8sI7H4_FFeggUHAfoBz9
X-Proofpoint-ORIG-GUID: HBFlZBNsEp_x8sI7H4_FFeggUHAfoBz9
X-Authority-Analysis: v=2.4 cv=e402j6p/ c=1 sm=1 tr=0 ts=6a89a911 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Q-Dk72any4QruATLw1wA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608220114

On Fri, Aug 21, 2026 at 02:20:15PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 21, 2026 at 07:12:15PM +0200, Andrew Jones wrote:
> > > Does riscv absolutely require this? I suppose you have a new problem
> > > where you don't know what affinity the guest is selecting when it
> > > provides a MSI-X addr as you don't know what physical IMSIC page is
> > > under its S1 IOVA?
> > 
> > The IOMMU MSI table operates after S1, so it matches the resulting IMSIC
> > GPA. With a vIOMMU, the guest may use any MSI IOVA that its S1 maps to
> > that GPA. With S1 Bare, the device uses the GPA directly. In either case
> > the hypervisor provides the guest IMSIC topology and the guest interrupt
> > file or MRIF target needed to program the MSI table (through the IRQ
> > domain).
> 
> I suspect you should have an IRQ domain for the msiptp functionality,
> but IDK what it should do... Is this basically to remap vCPUs to
> pCPUs?

Yes, basically, it controls the mappings of the vIMSIC GPAs (which are
per-vCPU) to the guest interrupt files and MRIFs. Guest interrupt files
are pCPU resources that the hypervisor manages and MRIFs (memory resident
interrupt files) are just RAM that the hypervisor manages.

> 
> The viommu can set the msi_addr_pattern

msi_addr_pattern should be under the control of the hypervisor since
it, and its companion msi_addr_mask, represent a block of GPAs. It
will necessarily have to match the vIMSIC topology described by the
VMM to work anyway.

> 
> The existing msi stuff can place the physical ICMC at the right spot
> in the S1 to give to the viommu (Nicolin's series may be needed for
> this too, I forget)
> 
> Not sure how you provide the guest MSI descriptor and have the irq
> layer program it directly..
> 
> It is unfortunate you can't learn the vCPU the MSI is targetting from
> the MSI descriptor, in terms of linux that's a pretty difficult choice
> to implement.
>

With the RISC-V IOMMU MSI table and irqbypass support in KVM, we can
write the guest's MSI messages directly to the device without
interpreting the IOVAs. If all vIMSIC GPAs are pre-mapped in the MSI
table, S1 can map any guest-selected IOVA to any vIMSIC GPA:

  Guest IOVA -> S1 -> vIMSIC GPA -> MSI table -> VS-file or MRIF

Guest changes to S1 or IRQ affinity therefore do not require MSI table
updates. And, when a vCPU moves to another pCPU, or switches between a
VS-file and an MRIF, the hypervisor only updates the MSI table entry for
that vIMSIC GPA. The device message and S1 mapping are unaffected.

As I understand it, Nicolin's series addresses the ARM split between
SMMU translation and ITS interrupt remapping. The guest-selected IOVA
must be preserved for S1 while ITS routing is managed separately.
RISC-V performs MSI remapping in the IOMMU after S1, so guest MSI target
changes do not require corresponding per-vector coordination with a
separate interrupt controller.

Thanks,
drew
