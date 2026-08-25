Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2B423E96
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664257; cv=none; b=ppcmu31RikjtV0vszbu7CyJUUNyrP030A85/KBxG/bY0k4cpH/GJxmJ29TEL/6SBBmusvtPCFw3f+yOHQfHisD3pZBoiimo82uqEVzdvr9fMdm6Gd+51clJFtRc5tkoGYJKoPYMvtxgCHh9lqOI05n63KDzv6vPOUIrwWkCTRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664257; c=relaxed/simple;
	bh=LVgqNzPNTLI4Z4C7TKav75YoOfVYyV3F9QQGA2eJgeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSTI+TIiXMCsp8dAl7aCLavOEazSzdS0BHDHc7A1YRzLc8ikjzOogKZXcDAPRayB264F/hFaKif+tDMMwTyHbdCRfkB3MS2ae/M679afwDNK/ShICD5JwY9KzRsFUHj9NvQh5JCvvPL4awn486Pje4vYvGlYd3YC/6uhH2sOMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3YsHFXF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RM7WZUfb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3YsHFXF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RM7WZUfb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAv0ZP1258422
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 13:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LC1OvcR1kST+YRmHVQ0IkWyZ
	cirgHHTZlqqw5HLd9QU=; b=M3YsHFXFw1WaNeSwN+bWd71uBsAwu/uhH3u16X1T
	mt4GwIlJsX6z40t42SaJOrxUVxmGnCGYMspTlQv+nkDHcgcg6lW2IC6E47OdxlyX
	URB3xfM3lbnDAwHbYaC/cBCk/xVO9AQKQ+NDzmgJYCgXzkOw3uj/0OocT63RERy3
	hpXEYxWMIXmxT+8Y/I2u5a3ijrHOnl7v7bbGBdoOBhFGbEfvJ5OuZ1aHH553PCo9
	fDIPht3kbW75Nsc92S6O0PCfccbdVXo+b3Mx0MaSf0l1ITW0PPnUj4PylmAoHeMj
	6im9PkRIJtSTFRL5EeUXQZQO5bz/mHx9GmN48tY4wIjTkw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g98hp0v7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 13:24:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5276aa86d00so54282601cf.2
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787664243; x=1788269043; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LC1OvcR1kST+YRmHVQ0IkWyZcirgHHTZlqqw5HLd9QU=;
        b=RM7WZUfbNjdW7nSmpEWVnSmUQK4TMGzFKc5FkflwSj4lpEM+PxMwRtzdVq3G08d5qG
         1u7RAq+Qes3JCR/esMTKK5I+Vln9hRkhcMp3hGUK8jxyeQZhkld7GrJUzIo4USbZZpwL
         gH1g9RDPFqieIBxbvHfc2Ah8KYrzRBQcrCxi3VKIqOtHDosgRBOGI5mwvpmAZpKLk1F2
         Gv4OsB0trweYkSwgfKU6vjVxGQ1zXFmeq15WoRFTC+5dJnQY4WAIfVuhHEk8S3vuGPcV
         kUlFO+VTVUWNAid8XokLuQAqxGnRPWpRlbWv8SlP2fxrua7V8xo3VY4AF3DXkz63N1G1
         TNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787664243; x=1788269043;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LC1OvcR1kST+YRmHVQ0IkWyZcirgHHTZlqqw5HLd9QU=;
        b=OAKTBqKbZ3w3bES6lsFf17ZAxjZWRoxHa9lT08R+/aj5WZPF4hDCXkHhnIJUAFBkOE
         JUSjArghH6UH9MEIrjJNQkScdZWmyFPAXQ3Brsmjp7hIMzYalp1kk35G0pXYqvvr2K2J
         G+u7UJa7vcvzrU45C8zG21Vc7MgfP4ENyHWPDax2emKL2GxCbCoKYyih36hrOT4Qb84d
         d53f9ZDxBNU2j/rc2T28A6UBrCWaf6+jR/LVoHmoaMJNTk0oIa9DG6Wp9kesnmA8br9C
         GJ4v3lGro8IcVTg51aE/Bajl0PMYYwEKxUWap2rGc3rpOBohNshcBs1CWwHvI3PdN3Mx
         f22w==
X-Forwarded-Encrypted: i=1; AHgh+RpRnt+ro0QGdE2lfRLllES1MDv9IJPl8Vk0bEZoKSBTilv+hAb/XnSR+iSdQkH1E91NniEzYQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lUBy+/5qXYur+KHJo5YFv+abKoZswO6Q112mT7w6jHSm4dPVOM
	ROkOJC2jvybw/D+tUPmYMDb7Et3jJJuRWLQFaWE1LqWmeCvTVVmyiMYpRELZABG+WyB7/KAKdLR
	wNydsV1liZ44BoMShFm4Kg/0RxQjZ7nbpSDYUG0Poq2QeHSvlVzqIzHZ9ng==
X-Gm-Gg: AR+sD11+g0Oj/qHzWWsEjq7gyp75NMjg1Ld454AjL6IMIrOGxwVxSRRlvzBNU/TNOKC
	wLe/ozUnYV1RWG9+M+/oPRadwURN+Uqtcy/jTDdyjqx3V6Dzt3celou7gXRamGWZsG6ip4eZ58A
	bJ7VMOY5AqqnTzR94LJOtL6byHZhK+0u1q7oOkCr4mEM8d3gMHZvpSigHMZLAdrSRK9kQ3L++xZ
	4sU3x8VwRWoyM27iH+fI7wf8gzVGM1aXNUg1HFIs6vHkhNlXNLD+INkqUC/2KojAEduIayPTOzJ
	ZpUWUU7I6j/WFXU+spVjwyeQAjW24evIFD7alF6bIprYlx0hDC0rsYx3CWgS6LsI6FAfdG8WW2+
	Ouoxu6FktC76KwmdfAlqCW9PnJRwuAzkM2tM=
X-Received: by 2002:ac8:5fc1:0:b0:52d:8257:666d with SMTP id d75a77b69052e-52e2f0881ffmr69685871cf.11.1787664243222;
        Tue, 25 Aug 2026 06:24:03 -0700 (PDT)
X-Received: by 2002:ac8:5fc1:0:b0:52d:8257:666d with SMTP id d75a77b69052e-52e2f0881ffmr69685321cf.11.1787664242729;
        Tue, 25 Aug 2026 06:24:02 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496295632sm2014052266b.18.2026.08.25.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 06:24:02 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:24:01 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
References: <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
 <20260821161256.GK244917@nvidia.com>
 <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
 <20260821172015.GL244917@nvidia.com>
 <t2l77h22pz2jg5vsgoth6324u36szra3orgr2g2xo7olyuhzlb@53wnsyhz7aqr>
 <20260822140625.GM244917@nvidia.com>
 <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
 <20260824125204.GP244917@nvidia.com>
 <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
 <20260824170417.GR244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824170417.GR244917@nvidia.com>
X-Proofpoint-ORIG-GUID: GU4PddpSy9BpGKg7XhPPoO3kHoxTn7ET
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExMyBTYWx0ZWRfX2ZYpCtIXiIWR
 hiS2jquFIkEz5hih6PBky/tsqM0qtCe4rzrCVsg3FojWV+M7w+fGz16EDTkMab3+s/eA3UoBq7+
 hbueXfH+7uX937M7ruXUXjOc/k83YlI/ZM+SYxphDWS/kNn3kSFXdXAeIqxgeroL4p7iWHfhq3F
 Z5/V+rOf4u8tqF/dq5+CsnfjPYdNaFhINHo1fxPaR0MvXFviPmQR+y4bSmEQhXu0kYutJjdXK3z
 Vo//gWKhicAAmDpKOlFRXdNDMOiHBI1y2zcoa12H4Rom0dIKFBSjJvsx4xdrQYKzGZv8HRqp1cD
 EuJwMNILpJfuZeCR7f5gk5lLmtFlDr7D1F0q6k2IHBe8EvJuq82RSa+BOjTzHFdioKEGastcvET
 pFZatqsdCQ3uzC80jkhdQ8FJJAqrp6YJyvnz9y4gFUW45JpF372R5aJlKkfEt13Rs1WUUfqj1wf
 sdSZtE+9YlPetU9pNhQ==
X-Authority-Analysis: v=2.4 cv=B7CJFutM c=1 sm=1 tr=0 ts=6a8d9774 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=md2Dys26qybDbSo3kC4A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: GU4PddpSy9BpGKg7XhPPoO3kHoxTn7ET
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExMyBTYWx0ZWRfXw5SLVhGPxTnd
 UnnBBzd6ITb4vA9hJo8K+364wPfENmr8Yp0CvyAQMzXJNlLCch3vrVpJfWPTbGTLoDCeCaAwOEd
 Be4tA3eAQXIbT+AUMC0DfOo/c7h0HRI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250113

On Mon, Aug 24, 2026 at 02:04:17PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 24, 2026 at 05:43:19PM +0200, Andrew Jones wrote:
> 
> > VFIO cannot silently switch back to host delivery. We need plumbing
> > to establish a guest-owned MSI mode, preserve and mask the guest
> > descriptor across the VFIO vector lifecycle, and stop or reject the
> > configuration if that mode cannot be maintained.
> 
> Yeah
> 
> > The guest descriptor itself is already available in
> > kvm_arch_update_irqfd_routing(), so RISC-V still does not need to
> > interpret or track the guest IOVA. The IOVA can be written directly to the
> > device (since the IOMMU MSI table is pre-populated with all vIMSIC GPAs).
> 
> Yeah, and now you are getting in "fun" land about how should
> information KVM has get shared with the IRQ subsystem and irqdomains
> (?)  that need to use it to make decisions.

The interface we have is irq_set_vcpu_affinity(), which is a bit messy
to use for everything. ARM uses it as a command interface
(enum its_vcpu_info_cmd_type), and the RISC-V irqbypass prototype is
currently following that example.

> 
> > Indeed, irq_set_vcpu_affinity() alone will be insufficient for two-stage
> > guests due to the VFIO vector lifecycle concerns with guest-owned MSI
> > descriptors.
> > 
> > RISC-V does not need S2 page-table mappings for MSIs, though. The VM's
> > IMSIC topology identifies the vIMSIC GPAs used to populate the MSI table,
> > and an MSI-table match bypasses the normal S2 page table.
> 
> Okay, so that's an odd twist, you won't need to get the physical into
> the S2 then, but the VMM does need to reserve off a hole in the S2 for
> the MSI table to land and manipulate the physical through a parallel
> translation mechanism.

I don't think we even need a hole. If, after S1, a GPA matches the MSI
address pattern, then the MSI table completes the translation. If the
GPA does not match the pattern then it goes to S2. The VMM already
reserves the vIMSIC GPA range as MMIO, but it doesn't need S2 mappings.

> 
> Then that means if an irqdomain wraps this translation it is actually
> a *per VM* domain with a *per VM* translation, sitting on top of a
> bunch of iommufd viommus, somehow. That's feeling pretty weird now.

The irqdomains remain per-device. The MSI table belongs to the
corresponding S2 IOMMU domain and its configuration is bound to one VM's
IMSIC topology. The current prototype rejects irqbypass from another VM
once the table has an owner. The irqdomain does not sit on top of the
vIOMMUs. A vIOMMU links guest-controlled S1 domains to their S2 parent,
while the per-device irqdomain is the IRQ-side entry point for updating
that parent's MSI table.

For the host remapping implemented by this series, each irqdomain is
per-device because it is inserted into the device's IRQ hierarchy and
provides MSI remapping through irq_compose_msi_msg().

> 
> > I agree there is some new terrain to travel here. It'd be great to discuss
> > this at Plumber's.
> 
> I would still try to get basic baseline support landed for a 'bare'
> translation using a RMR (?). That doesn't require any new inventions
> at least.

Working on it :-)

> 
> Then the question of how to support a S1, guest controlled descriptor,
> and per-vm vCPU to pCPU remapping table can be clearly articulated..
> 

Thanks,
drew
