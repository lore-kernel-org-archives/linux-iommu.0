Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731023;
	b=r+lWWtBV3fc/nQB76jclb5FoDz+YwAtZ0eD++5+pz64vFBOWb0HXD0+TJhUc1qYiUiUn
	 EEKukIYg5265lvUveU6DDvnKDGIxSSW8navXFdid28iom2AySI5rLMSqYFjJP817e1kwu
	 9hP5IU7sQLkP0D9ohmMp3QQIFnOg2SFtq/yd+C3KxmS/1smpnkJ1dnOqK1UoaQBHXJYE6
	 Qe84F0dRnME3oELiie5Me+Awr12pwa2kqMPygxhezIqqHPz6dHbQquSSPateARo2R9n+f
	 aeZEst1Wnxa5SaGnFIAkpSAAmTpa4/cesExV7TbwSfgbr98wP+WxQ51ekgsPFWvk4zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MtYqIPmCoO6r7ieWdDjT3mJHSPCz3ZeRLZvBXwBPxaI=;
	b=XvtOejsvcsH8Nbv0+beE2S4MwoCUHFYOpD8dzhvqxD/5++F7Yc4DUbWwt0/JCUR2MXH6
	 23TRpXyBPkQqUVqkuJ4ROlZlEWa5y2xLT+nqRJV2ooE/yicOcpW70RaCB+iZ6riiTRZc+
	 cq9q6kvS51TsMRV53BmxkZ3VtmWrdNtJR3fzz63MGZZtJDGKGoJCc89Wy56g7ccApqPNI
	 jCOjzPWF9I02XlgHgq6sBJ6pMBXEwuBH2YjIqWc6NYyU8pssQ6oxUOWuns1NPoRe/utLg
	 G/t2twz3SR4wd7jNwhIvh1HkqUIe4pBcST5Tr3Rhj1xEXg1//B7x6hUbA2wYw3+Of3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=otCiMlty;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583C606A31B
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 18:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A583C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=otCiMlty
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b042c0759so2480353f8f.2
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793731021; x=1794335821; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MtYqIPmCoO6r7ieWdDjT3mJHSPCz3ZeRLZvBXwBPxaI=;
        b=otCiMlty4cQJqNIUbrLyItvDj08/Gw4KeYPqne/UyeKRDY+g5SDKadzQ7uhTHDyxj9
         guQdKMfSsoeiGVFUgg24JJYfQ9ec43Ca/FEAH9zfNso1bUK/f3Cv+FTYx/ZkwkREa/Bm
         XkPn9ZIj446bqIPa25WDQya97CbHcCB1OjnYAH4vfnvem8AkXAymgQneAYaEGniZTKue
         AwGIRieIOz3il1WWbwAU52cqX/e5m2oOLgYtNIoiQrWIFooBdHfspaeg/F/dfOBKgC4P
         dJgqJm0ISSlTnAKrPrt/Zex0XDrHndCRGScMV+L4ifKwwkt8T9lVV/yYFY01Uf4cAm3e
         Phyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731021; x=1794335821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MtYqIPmCoO6r7ieWdDjT3mJHSPCz3ZeRLZvBXwBPxaI=;
        b=cGwaYxN7Ni4LR06K3YwMKzyl+1dueM2yZpCjxBKRhCnTIcr8nkTK/zUrbDcwJ6Egsf
         ya9m+LDHpea1s+HNDzzEWFCm0uYuFHAvWT2Lk2bgG/qG94uo4okyEG6EXOmN/FXaym2h
         bCl5qswAJEEzONcuHo0lbP1BO8MLityA1qrc4S5YAAbG+51noEV304SdIqfiVX60PDUb
         RBhTqr84EmEvONSol2O0ZR8uRQJhZS/Rz42gpJcsmaSw0QOJro8Ys/o8YdpUl7LHQRKA
         aIxde0M38vXyfsRd2h/vtnppLmWi3dljM6Dku58jCXg62qTD/3vvLpA5T0BNcjaNBBmR
         Dzxg==
X-Forwarded-Encrypted: i=1; AKwUvByekfvMCmhmlBcO/Z7zTv+coRo9PI6lQLqM8e726O9qIOzicPIapKvppbdP3gYKCaoa4LXmzQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8X84TX/iuTosx4owzx6x8QN1hUzTKpP0JJR4rwIahISbndR74v
	/3e5tUA4kRzmUncT0VRcD1XGG5DC1K4llhJndDauhxgzx6bVGGZCk895
X-Gm-Gg: AYBFou2bF4rLCLOX/VjJpDeUOvwNAdRvVT1TLlXYLEH9t0/TdROrHk/n0XrDcvtV4ZT
	kzoTewCl8ULYcupfCRkqTr79o84IUs0C3LGMUXhfMryUkHu6bojJkb7hVkLDaeGg2jqpe5Lc3Xy
	yRQTFvqBq/PpimIwYa04YVGzYdQ4zGVngnc00OGp0fPolhgoOSMmKqXwNvlyOP9alk1gBHs0Uii
	codl+jGgW0e6fhicjGat2mUfdAREEajQD6caJolFZHTHILH2LP/DqMtaIKlLuriThCgAyE3DgE1
	H0ST/s/63TzouWwLX34iNeO2ldP6DHeWiV4wRwfnD6v2jh1uUgBOB5N7rvvhrsy0qSU2psqjpiz
	ogjWpWJWEk2VU4Zlrv9cjecGdAZc+6MkLUwppONFFt5A5t9gEBaOuW9INj2ZAbkbtDH73I1Q9EG
	VPrZQcJhM9HwJjADsznXy9JF7D1CtyvZOSBCPe8Pbq4x13EG1+Ke5dDGY5bdPEpIy7BH4N/ocu2
	F0fc5Dy6oyCrDknUNy3cBTcavedPizcp2w6DvpXFRqKXSkoUBYg8UV773uKgTwaQ3AZ9vIZu1Jl
	qNsOi1ZzJkgcrMod133Ypg8nFbcWLZSu3JR5HUgc7Ha3+Pg88uDFKeTym14+hTLXMjMfB4vWgLA
	uwOcaFf/sNIsSqhMmxJW25H7t4gHe4CODpsK99N0/7+tQiBAVxwmqNVQb5p6bndEGoYjHP/fyoL
	Gr7uQQYVW7Tq0=
X-Received: by 2002:a05:600c:470d:b0:4a2:191f:7cb8 with SMTP id 5b1f17b1804b1-4ac1899378bmr308379315e9.17.1793731020767;
        Tue, 03 Nov 2026 10:37:00 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a1dsm25588404f8f.24.2026.11.03.10.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:37:00 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev
Cc: Ackerley Tng <ackerleytng@google.com>,
	Alex Williamson <alex@shazbot.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Will Deacon <will@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC PATCH v3 00/13] KVM: guest_memfd: Add a common framework for device memory providers
Date: Tue,  3 Nov 2026 18:36:59 +0000
Message-ID: <20261103183659.82433-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101071928.2462549-1-aneesh.kumar@kernel.org>
References: <20261101071928.2462549-1-aneesh.kumar@kernel.org>
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

> This series adds the common guest_memfd support needed by device memory
> providers. It builds on the resource-provider API [1] and the existing
> folio and RAM PFN backing support.

Hi Aneesh,

We both build on Ackerley's PFN mode [1], so here is where my export
series [2] stands and what I think it would take for the two to fit.

The export lets iommufd map a guest_memfd file without pinning it:
iommufd looks up the frame behind each shared page, and guest_memfd
calls back on every change, so the IOMMU mapping follows conversions,
punch holes and provider revokes. In the next version, the lookup
only uses lookup_pfn_range(), since it runs outside the invalidate
lock, and frames carry attributes (read only for now), which Ackerley
has offered to take into his PFN mode series.

Your patches 01-05 fit well with this: the backing ops table is the
internal provider table Ackerley's base left as a TODO, and the export
hooks stay in the common paths you keep. I tried my series on top of
yours and the conflicts are mechanical.

For device memory, I see three things to align:

1) lookup_pfn_range(). 06/13 makes it optional for device providers,
   but it is the only lookup that works outside KVM's fault path. The
   export needs it, and 07/13 would benefit too, instead of calling
   get_pfn() page by page to find contiguous runs. For vfio-pci it is
   the same BAR start plus offset as get_pfn(). Could it stay
   mandatory for all PFN mode providers?

2) The memory type. The IOMMU needs to know a frame is MMIO, and a
   prefetchable BAR may want write combining, which the fixed
   noncached mapping does not allow. A frame attribute, next to read
   only, would carry it to KVM, the VMM mapping and the export.

3) vfio-pci for ordinary VMs. Today a device provider needs a realm
   (kvm_arch_gmem_device_supported()) and gets the VM and an RMM
   binding at attach. vfio-pci is probably what will make the case for
   PFN mode upstream, and that is easier if it first works as a plain
   provider for any VM, x86 included, shared pages only, with the
   realm parts (private conversion, binding, lock()/unlock()) on top.
   It would also bring back P2P: vfio-pci refuses to attach while a
   dma-buf of the device exists, and with the export iommufd can map
   the shared BAR pages through guest_memfd instead.

I'd be glad to see v4 posted, or I can wait for 7.4-rc1. I'll reply
to a couple of patches separately.

Thanks,
Fred

[1] https://lore.kernel.org/all/20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com/
[2] https://lore.kernel.org/all/20261027154649.91571-1-griffoul@gmail.com/
