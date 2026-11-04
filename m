Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817477;
	b=VkmRqy1gQ75xSfTxomCoKLZcZhKKGZSPBTkNLoPH+Q4QbONLi+wG7PIIoUDJxALwtMWW
	 J1d1J6re1ETI/Q1U+uZ0EGnAIU5KSVOh0Rbb4U+2UcdMOAWRtQeOX3g4k/Pbx4k523Wuw
	 IQqn7X+d6Sy2HgyArbBWzKEUpInzg005f/ELcjByATSyxar6uvH3XH0zkVOHGC+AuMEbm
	 BkYg3rebb/4U/vdFMRLhdlox9yjZtCVe5JigtdoekIKB/hqJYM7N2es2TF91uKLKG8Q9h
	 tZEDGvvTmJEbsoicmgdzl4pUmH4iIe+nzRCp+EDuPLLk26S/unPf6imk7ufScsFOflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zP0FWmOJm/guqpM9jttc05RQpe78thW+WHjsEUvp+/0=;
	b=zBBzJPy4dlsDB/M1SkVYmyfE9bHvSSPlgSnuzivY2rPgnLBfampeZlx8jaSM0YOgy+8q
	 VM57mF7/0vzJGaapVdAe0O/tsIC+sCAkQl6OipODicJX/QJevrD51fcNR8g2MT5LRe/nl
	 uEp+NXRT5JTpASEJQ1s1j8XTTgPEcJ53ERSAztLdzSz/xE/I91kyEc9g/br9dGHkNHarl
	 bwUDAGwg6G1pPOgTrGhGoSUPHRc0xXl1RiGsU8WEc3BxeVoZkX2pd0qw4jezNtDCZaec2
	 wyaHexLRBC0qG6zveloJLuPwDATYa6SYCNkJleZJmrOjpK9i/YptYARQYlrkXXIAQ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=id58xR3y;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495EF606A334
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 18:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495EF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=id58xR3y
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4b467581b98so7647365e9.0
        for <iommu@lists.linux.dev>; Wed, 04 Nov 2026 10:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817476; x=1794422276; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zP0FWmOJm/guqpM9jttc05RQpe78thW+WHjsEUvp+/0=;
        b=id58xR3yXof1mgYZ/P5jHRLMSpf9YnAWZ5l0v6P0qr032vgjfhX0MCmf9beKiq8SnG
         Fs/36SndlYpSdjfcQj90HTont983Bn33aZ9gBsgKQ5juK3a1aoZ7dVEZtmpHczoygnuF
         aGPjvAog3VDTA4DBZG7CIaH5vDMUAO3TeBFe/BuxgsIuSQ588lbzeWGRXubKKQ1DUDK0
         P2fkSmzV1MBa2wsQSisua0yV+9hozRsTtv69yGmpCFHtWDAkwIx3jlpeJ7uBtTzZUoh6
         z6bdAA4YVN0BjWSvAQPuVjO3xQd0QF8NQsQfZphGg3C0946jWq7/f030ZPcimSa2QNJM
         dpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817476; x=1794422276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zP0FWmOJm/guqpM9jttc05RQpe78thW+WHjsEUvp+/0=;
        b=VxAKg3yFGOzvKvKXCQvUS0urUTU4eCJCruJmJ2FHhvAJJ9r2eLcUdbgDHyLFtRcY9l
         mtIs2cIRrhzdDfbdLdZgta8J4+b6Jt8zd+YMCzQw459YdDoEnanKPENR9yv64OKgb4r+
         K3Dd1vBCaRsTThnOWLs2Uv+un7b/QeGVRvuOtUPAYMKonsLb4bSxJlFVFpE64huBVnAR
         1IKq9Mq31vWa7uuWxYsq1/WJrm3ZpDyRgA28vndjsdaStUPKjCxvtv1s2GlPpdYio34W
         8fOTAW4/FrikNx5cKSBW5dgOfY2G11VmQzztfhMOodEkKO196KjyPSO9lTXTl1XUDM2I
         Fx6w==
X-Forwarded-Encrypted: i=1; AKwUvBymSPqx42WmbhxHznsZwUVFd795rqcWDGfE4ZBqLoZvclqPIzhMOre6uTTVcOsgDjhkGvbTTA==@lists.linux.dev
X-Gm-Message-State: APuU4Z80Mv4ZtRKqEPknA9UiuOScUr8EObdOalXAPWDwPMrzgPUI+xha
	EbcF0+IzO7pdWcpv0KQ/Gzrj2oFe4KuF4mJ34Y9WRq1BctkwHpCPjS7R
X-Gm-Gg: AYBFou2FJ/0J5SuaEOX8LAotkkYhsjttacFdiRaj4zHjT5GVke/xyf+MKCy2uHfEakM
	SwyiDRInxSvm1KUnt0OwKhvNaQkCqrB5BW1tz4W0WGT2FHkKBqRC5xS5Ec73SefAZaPBR1JIp9k
	JddJkURWL2kjEUgNW2N7lamfoBfaRtWiX2z38Z8X07E5prTeYUHl7voQ2Yp3/dl3xyh+6x/kFhr
	Al9mKfSL3F7Ob7vbtysfP9WXNI6UGrApLaCjx4JCeqPgJoHQpEd0IzKkgJVLRSs8VgiMYx7gZJ4
	he1i0KmkHOL/OK5qnRn/zrseQOIPVRdFarCZWrlgL+G1Tgco4dVmrPcG2BUSgvbGIDWBAfnLDDa
	rkoXGjq6Y+qmr5J1iZyQ/4TJVL/Ibfrb18poZ6x5JluSIq7iWpTK8m89cG66PDik4mlyrGuOIpd
	FWb1EjfEqt5Rp5FPbDvXw3zeXwBQOKgV2vD0feOgFAs/XK5JnQWaZaM8xerRfGEKO7sG5Z4gLg+
	gFVWKDL994Vbgt3wVDlKTOV2K5ROClWe+EcsimSDPgjew2YRsTT1F2Vw3xHa1NYWiKhzyDazrSm
	000ne3s7AMDNqHhXq6lH7VrBfBTyHgKA0n1hnrIj/aaO+3BEbz3u0BLpPwcAVb+oMm8IhXdKI68
	Bqn0H0a89Jx9EMMbbLp1cFGlVV/02RLUJVFZNoam+ySqwKakkiw33FSFZopZiaw1CYg==
X-Received: by 2002:a05:600c:8b85:b0:4a1:cd83:b23e with SMTP id 5b1f17b1804b1-4ac122897a8mr438143715e9.0.1793817475572;
        Wed, 04 Nov 2026 10:37:55 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56fca22e1sm4198665e9.14.2026.11.04.10.37.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:37:54 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev
Cc: Ackerley Tng <ackerleytng@google.com>,
	Alex Williamson <alex@shazbot.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC PATCH v4 06/25] KVM: guest_memfd: Support device-backed PFN providers
Date: Wed,  4 Nov 2026 18:37:54 +0000
Message-ID: <20261104183754.10457-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104150322.3516320-7-aneesh.kumar@kernel.org>
References: <20261104150322.3516320-1-aneesh.kumar@kernel.org> <20261104150322.3516320-7-aneesh.kumar@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> Device resources such as PCI BARs supply PFNs directly and cannot use
> the folio allocation path. Store the mapping owner and device ID in the
> core context during attach(), and use them when preparing device
> memslots. Keep device memory separate from ordinary PFN-backed RAM.

The device rules you wrote down in api.rst and locking.rst helped a
lot. If I read v4 right, the device backing differs from the RAM PFN
backing in these places:

  1. PFN mode calls RAM arch hooks: kvm_arch_gmem_make_shared() at
     conversion, kvm_arch_gmem_make_private() at fault, and
     kvm_arch_gmem_reclaim() on revoke and release. The device path
     has to skip them.
  2. lookup_pfn_range() only feeds those hooks, so the device path
     does not need it.
  3. The host mmap and stage-2 need a device memory type.
  4. In PFN mode, a conversion to private only updates the attributes,
     and the guest fault maps the page later. CCA has to map device
     memory at conversion, because the guest validates the mapping
     before it touches it.
  5. The device provider needs lock()/unlock(), the private range
     summary and prepare_memory_region().
  6. The provider gets the VM and the vDEVICE binding at attach.

Would these changes to PFN mode be enough to drop the device table?

  1. The arch hooks take the frame attributes. For RAM the arch does
     the RMP work. For MMIO it skips it, or does the RMM work instead.
  2. lookup_pfn_range() stays required. For vfio-pci it is the BAR
     start plus the offset.
  3. get_pfn() and lookup_pfn_range() report a memory type (MMIO) in
     their attributes, next to read only. The core mmap and the KVM
     fault path use it.
  4. A conversion calls an arch hook in both directions, and the hook
     can fail. CCA maps the private device range there.
  5. lock()/unlock(), the private range summary and
     prepare_memory_region() become optional ops for any PFN provider.
     A provider that moves RAM between guests needs them too: it has
     to order its moves with conversions and leave private pages
     alone.

I'm less sure about 6. Could KVM ask the provider for the vDEVICE when
the memslot is created, passing the VM? The provider would then not
need to keep a VM pointer.

Is there something in the device path that this would not cover?

Thanks,
Fred
