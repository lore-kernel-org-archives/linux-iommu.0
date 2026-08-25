Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DA40242D
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679539; cv=none; b=iLqQUuR/A04TmnAH8eagPCeFQp0Hf7LsbopLjlF9630D3UWYIbLp/CBHvfXiH3KKrceR9uJoA39FczXkZ8EGvG3R/Hli57lu62S/vc2ohZfI7VCslFqeBY3w+CncrBTIBq2nzZl72BpJWGemrhxgtEa91HB41haYonRJyS0sWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679539; c=relaxed/simple;
	bh=01S5JMVe1apagBIw8J8IQ7bRtoOAe31SSTDzt5NVX0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNK8Hc+6Ed+EdrUyomMriamZCVbIkUVVCxMZSJtTFJhbw+29FUP1mWVgeUEB2L29sgcGCHhMik8CCRaW3t1HFWeec0MPe6SYDhN+M+Y/QVXNLil26YA8bmVHozMVQ9tGWSkjuxNkvijmSyr5UNudLiW7JMrijDslq57lp96UgTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkWlouPI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hJKR/7Sd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkWlouPI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hJKR/7Sd"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PHZPIZ2637959
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 17:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Cc2qLo0Tp/EMyoBVnm3JR30X
	IdL8CsTsQTOfYO8+Ce8=; b=RkWlouPIHM5xuQgSTdyCQXIuhY8avRGlKGVG2rdz
	5+dJ6WGCrZcBoHaiNcsPlae1uF1pxOiaO3i+1nd7vzpYC4OSNacnUQnRMizmNA9d
	FgHVl2Rdk78C5Qt5vLnWHwEyl0VDwsKRcDh1azz+cE6dM7ty+N+l+1mU+VVoBB06
	zaUjo4V/inQRtaBgwlkJNqZ5es+OYME4gwfIeR+apk5nB2A57LgdqSVT+vwnWZG5
	I+vkaYoPIKmOPcvUxlJS6DfdtmCSWcRxspp3Q4YakRZax6jDe3RCc8320UjqwCay
	U2Qs12LSubZQICmbMMGzLH4javh/r3bqx4FMTIlyQzXkwg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bku98q5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 17:38:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c07f25de2so406811cf.3
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787679533; x=1788284333; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cc2qLo0Tp/EMyoBVnm3JR30XIdL8CsTsQTOfYO8+Ce8=;
        b=hJKR/7Sd4k0auaIUkY5J2QFJsETxZlFMlqxOpGrJ564Xov7V2nTyEvXXEbS3NsCuK2
         O6u9ixML/SA/jFp0XN9LxMIO7AaFUeDfqcX3C79HmP7ucU1SFsUpACueyMKDYo1UXwOU
         peuGKjJy4dmA1mZjPNN74YAxjMywkyDMl7VMIPyYPGcNvyaVoOlio2y3P9+dZ8cbuthg
         M21HSrdyBVMUJbw+4qNqrNWDOIMGLJ7gCM4+3RuuLzconpFjawbIRB+2D5JyX8seMu+E
         feUTVsyxOhXuO7bY0L//7hi+Z6nSw+YwZFnsT+7pqHHXns1OiPcpkmPYREz59cHSBFcJ
         eluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787679533; x=1788284333;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cc2qLo0Tp/EMyoBVnm3JR30XIdL8CsTsQTOfYO8+Ce8=;
        b=HKmrJ3ELAANqD1ZEXI8ICNCjHNn8SbhXCiL1nCC7785pGTLI18ZYfd24jpuRQpNFbs
         UB5XgnipzzuM+YYyZfSWVJPklQLW+zFe9wXqGH5aHDh00S2h/6Qa0gIYnaBTeGcP98sT
         oaQ9HhgNjc/D7MiCXBE0wWHZNmYcVT/IJw/etkN0K6+Hn8jYgyj2n1UQx4ls+wiVJW32
         m/7jpkFVuBQyGJ+Y0z25xineovfRzEF9IKW7XqsN5GCmMQg3RQ7LAE5uNwnDqrNFbtGK
         TAKGu7rdrVK7hxjc9HwB8kYpMqI1Fy9hUi8zuKoZ7vQPsHJyh67WwTqKExd2veqZ1wNa
         p/iw==
X-Forwarded-Encrypted: i=1; AHgh+RqS2a7aFHQBtdARM0s7wGRqpoySV+xnYVmeCF/UWkml1uLZS03gTd6DzDBLF7/TjGPl4B+hBA==@lists.linux.dev
X-Gm-Message-State: AFuF++mrUkbwA2M0MKkqSRa5j9aNJS/+qHq/3/Gjsq1CTpQdizXvGdP4
	OLllaf1K7nLIirB9ZCpwYNKtXz/1YTotW3OfWAATC1n4ycs+I0rqhyYJr4u3V4rw+KN2h5fdzn4
	oXWcg9PpIDyv3MyyR1k60LN6HADIK2ttzJ7idenFwiLyUYaDOlREDMiyitTf7lPEY7A==
X-Gm-Gg: AR+sD11QlErdNdakCo3M18R0+pWG0ZEq8pvNiZbhe+H5BjaEg2atRFWScQiHpo22lLt
	+rVHaHOOFQMvlL3QV8hPw4baDE0A52wYeKqXhCZGeEGvgyrvam6VTjgJDmNDHRriu4mM/DpQ1l8
	+YcfRE8xCIoOKd/CqR4lE0QZ8ccRTI1frxBladeIE492gUXSsoFOMz96T99t9YhsG61YnfaMBwD
	4j9ASo3fVtETk7ZmFfwhSYokd1K4XCLHbMiqaJVOh31CuB+DZb0iyapvzcC+Yt+sQQotrL+VAfb
	pGrd4RtEgQcuyt4+zvG6f6SFtrsTJ/0AUPQg/LZm9vUH939gY8tKCqVsmvStYFgeLtuJLDxbD9G
	e3RpnaELbMnwABt9s4IyPONMWwq7oOoNgGGU=
X-Received: by 2002:ac8:5cd0:0:b0:52d:9c11:8938 with SMTP id d75a77b69052e-52e4239d940mr5792721cf.29.1787679533030;
        Tue, 25 Aug 2026 10:38:53 -0700 (PDT)
X-Received: by 2002:ac8:5cd0:0:b0:52d:9c11:8938 with SMTP id d75a77b69052e-52e4239d940mr5791811cf.29.1787679532405;
        Tue, 25 Aug 2026 10:38:52 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d5d64ffdsm28297715e9.2.2026.08.25.10.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:38:51 -0700 (PDT)
Date: Tue, 25 Aug 2026 19:38:50 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <iltwtfmgnmofsroo7eqrvjx6yhqbptwutywq65mgm7adudz7pq@2mdg3dhvtoud>
References: <t2l77h22pz2jg5vsgoth6324u36szra3orgr2g2xo7olyuhzlb@53wnsyhz7aqr>
 <20260822140625.GM244917@nvidia.com>
 <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
 <20260824125204.GP244917@nvidia.com>
 <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
 <20260824170417.GR244917@nvidia.com>
 <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
 <20260825140334.GA3325090@nvidia.com>
 <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
 <20260825165209.GB3325090@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825165209.GB3325090@nvidia.com>
X-Proofpoint-ORIG-GUID: OEgMG0H6bI-4FFqehgirhCIiiyT5IVAq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0OCBTYWx0ZWRfXxvUUsOOoXr67
 61Gu3tLirn5GbsLgO02mKreRrefJA0Esrq81ZtdKGV0pHZ2jMu5wqQQi3ey92eXJ8KA1J/IEnQd
 IyFMGV6FSTdWQYbn6OrYuYSDLCxz6m8=
X-Authority-Analysis: v=2.4 cv=TZGmcxQh c=1 sm=1 tr=0 ts=6a8dd32e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=-nfrO0Lp-Z-X3alJsSMA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: OEgMG0H6bI-4FFqehgirhCIiiyT5IVAq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0OCBTYWx0ZWRfX/XCfIMHnZCqn
 kTs9pdOBROPR01N0nk6CAYxEdAsLVLm2f9uhfIROuqccHQhCYfujFEjdjU8821BL/h8JpobUsFU
 gCpn7JhiVfnrwhKwdSd3D/qPonEEoqQ0YZkM3NtpvRRGRRqkRE0SRzwO75Dhewh270FJj7svJbi
 TBqvav6u5vktoejOk4GQAPCwaEjJ3PZTIifpp0Djhs5ptC3YONrALXrjpXaIncvMGtcEOU4saKp
 BLlkiPi22H9VGB7nAjdahvSUz3iYkMnTAdKNg9T/3jl21OK0VHSOd7d7RxR/P0VWarCwc11g7GG
 f8Pma+CGdUXMb9gBboxTbkErVRLN5ZjCzuKustSGZLhUVv4ueF+8Pf3Mh6jOsYcuvDfag7PGFos
 8wIt0W9LbmdU7LhzRbCf9eyROQYi5NQTqTY6TghvGLjdEecrPeQySrLXyFzE7eTrgyiQja77fS/
 MJ85dv0NWYN/+rJztoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250148

On Tue, Aug 25, 2026 at 01:52:09PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2026 at 06:14:55PM +0200, Andrew Jones wrote:
> > On Tue, Aug 25, 2026 at 11:03:34AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 25, 2026 at 03:24:01PM +0200, Andrew Jones wrote:
> > > 
> > > > The irqdomains remain per-device. The MSI table belongs to the
> > > > corresponding S2 IOMMU domain and its configuration is bound to one VM's
> > > > IMSIC topology. The current prototype rejects irqbypass from another VM
> > > > once the table has an owner. The irqdomain does not sit on top of the
> > > > vIOMMUs. A vIOMMU links guest-controlled S1 domains to their S2 parent,
> > > > while the per-device irqdomain is the IRQ-side entry point for updating
> > > > that parent's MSI table.
> > > 
> > > Doesn't sound like the right design to me. Pretending it is not bound
> > > to the S2 just to make it global then blocking multi-VM is not a good
> > > place to start from.
> > 
> > The MSI table fields are part of the IOMMU device context, and the
> > device's irqdomain is how IRQ operations reach the IOMMU driver. The
> > table storage is owned by the S2 domain so all devices attached to that
> > domain use the same mappings. Sharing an S2 domain between VMs would
> > also share their DMA address space, so rejecting a different owner for
> > the MSI table is only a sanity check, not an expected limitation.
> 
> That's not what I'm saying, having one irqdomain controlling two
> msitables based on how the iommu happens to be configured, and what
> device the IRQ is is using does not seem like a great arrangement in
> general.

The IRQ domain is per-device because it is part of the device's IRQ
hierarchy. It does not own the MSI table. It reaches the device's attached
IOMMU domain, which owns the mappings and MSI-table state. If a device is
behind parallel IOMMUs, the IOMMU domain implementation must program the
same mappings into all of them, just as it does for ordinary DMA.

> 
> We have enough problems keeping the iommu and irq layers in sync, now
> this is making them even more split. It makes more sense to me if the
> irqdomain has a singular msitable and the iommu progams that into the
> device context, not the other way around. This of course implies that
> each vm gets its own irqdomain plus table and all its VFIO devices are
> joined to it.
> 
> This seems broadly similar to the other arches where you do want to
> have some kind of per-vm control point that the VFIO devices are
> bundled into that programs the remapping HW for that slice of the
> system.

The per-VM control point for irqbypass is the shared S2 IOMMU domain and
its MSI table. The per-device IRQ domains are only the entry points from
each device's IRQ hierarchy into that shared state.

> 
> IDK what Thomas thinks..
> 
> > > And this is an entirely different thing, you don't need a domain just
> > > to call irq_compose_msi_msg()..
> > 
> > The IOMMU irqdomain does not merely call irq_compose_msi_msg(). It
> > implements that callback to perform host MSI remapping. Without this
> > layer, that remapping logic would have to be put in the IMSIC driver,
> > where it does not belong.
> 
> You've lost me there, the host does not use the msi table so what
> remapping logic is there?

Right, the host does not use the MSI table. Host remapping replaces the
physical IMSIC address composed by the irqchip with an IOVA that the
device's ordinary paging domain maps back to that address.

Thanks,
drew
