Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327836;
	b=uZLib02T2XaXOnVbYqXuG44RdFcUbk7QIKSKKXD1mh6+e4kHiyI2pqSRI0sFtOhU6/Rx
	 kzdnqB6R1mu0iy3bWTNj88/pX2cF1Nf4WchMLOaK8aMdW61pf30dJbVjY+1OsBcskNrK6
	 IpeLNGeeMFcFJW2P0J/Eu3yGK8OidWPpj6eqb/byFV89l+7N6UNKph9SqWSBhtyFolUzL
	 bOdYXRh7hCUJjBlJdu6ODuVc4Qy8C8QcutUSs2VW+SzBkNGDxU5LncN2V1SajHp0itxme
	 pLc08V8nGrkVjblWSgwG5WncO1Fd6AyVE5WeASL8qZU8cpo3S/0l6k0JkHvYkv0IpWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=Mw9iOCkEBWkvxdLSgoJVCB6jT3T4ThA8jIPRTFH0lnY=;
	b=M8d7t45HMg+ByItHtXlBuyLjJIGDMEpdPa9lRkLTIYIEPYNOz30qVa8GemW790kyeqNG
	 41VcVcjktcYpp6oNXRZQWkHBN15K10VYdHzlTw4Q4rZrc0LTJUz2oYXfuWSb0MH2wFTNs
	 ByPixd5UMdFVYusI/+Qu8knSIl+hhOblA0SVU3UFOeVBmnomITWlN+kmbi4oLVPXDdXK8
	 0j4Q1nyjaNILQ0nGmBXjBysI6gNmiengV26KRWcT0bcHnikLYLGFy39GA/oX7vUKBLC3t
	 9YX/umTaF/CyZl9psRPABk+3WyOz9MeC1UH3pJevhoznAu2GbxHuNNuDjFTyvMFHC0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T5mPOv87;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF4606A32A
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 16:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDF4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T5mPOv87
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e987a2ba0cso13295025ad.3
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 08:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794327835; x=1794932635; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mw9iOCkEBWkvxdLSgoJVCB6jT3T4ThA8jIPRTFH0lnY=;
        b=T5mPOv87I6h0RugoK3vSt7F7RIcB/cfjC4uloafIe5R7qyvGlDMd/wsHLvKcplxKKp
         H0lsh4s6g+k8dzCSQQIV/LYlvPAi7jAa1sckAm9bLXrNMyFgnGoak8+rAziWHeuk+6ys
         QIkj0YDEqUfpP5orTpJYpaulGt9FsllTS7UmJv36RH45udKsprIgbDLgC2rU8tt+lSNA
         jmhLXRJhfUS5+askxjsOLD5vQZm0NqyqsEp9WpXeLKeNp+Lox+72KAMjDetWJUqVtZ47
         8oW7W5i3kOVGphbRULrUW7kwl3iPHFLXlemWY28HlRu0KmftK+rf23pc8dzOoirgmcu5
         xQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327835; x=1794932635;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mw9iOCkEBWkvxdLSgoJVCB6jT3T4ThA8jIPRTFH0lnY=;
        b=duU4MAPQNuw4dUuhK+exmtpU5YdMg0yggrCY6Qj/kveikktz7ALuyP9Fs1iWmPV4a5
         3IvR2gA7Ed1wLG8nG3Qwmx8vHOnKhxjsMYiUWeW2gWxvuO/fTFnaVI2jL1yTUkDUhlmO
         my7zOegURk1VhYhRN+xESXYoP9bwbG9vTpWl093VavpaKSAZPcn0ddsjxy+9kCnvGGf2
         MsBZRPcexXrbXFa3SSrz49QZkunbf+gQovqcty6cJ8VU6Kkwgi0D8hq9Ibq7iSD0r2MJ
         nkKcPcVToWhGaiAmq5x7x+SqVFYyypL+Nlo5vdNsLetRr35d6eQSLQGulBFg4T1U2Jun
         4Gzg==
X-Forwarded-Encrypted: i=1; AL+hErHqaeKLOcvSDkC0Y9MSQGyWpfsr/RrY5YqknSDtKajJytqivv8vivo6rdp4xINBdIn2guzEOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+pFdsiUMZzQBPhuHUCLWOb3AoYAvnPU6oO4zCBB6clrCXBZJcV
	nC9LdgT6xLvvnKpBoVc8EnIZW5sMfi2voBdVsJHW3LTTKtlRlOaz5gwKcYjZUBOUcg==
X-Gm-Gg: AYBFou3Oq7ZNCw6E6IuYLki/GO36Av6AqWZTTv3hj7w4/EefiUnttrIuYZgbKYkCgK3
	Urbume5ukUAPDk5d8R41wjJrwnciPc2Ptcj7ZwShm5bze9QDM6mIkNTS7SRsG82xJCOE1eBSNvf
	84Ue0GYbkIaWOKl/k3K47TU8m+MtrdKRF6CWqeutiqJbu1LJfTolzH6zerEVhRQt8/CS9t43zLP
	JsfsqVuTriu+gom9hMh2DZHiHgDQGNART1GrFswSevGxMmUBh/ySU9ef47rt8FKed2gNRrVO/h2
	mbv79JUrNiRNgKDjrSFrUknpJ/wk7v80YmxWtwKJxrOE17wNAbdQuV/QTK9p9HFI7RqfWrPi+wc
	RZK7fQDD+5erKtwRSRxHz41/ajfA+M35rLgUedxL6scbqG2VTSRb6v7UcZKD4YR93Ueu3AnLGdL
	tV1nd2CJB1zxUaFf/7PmcnFx2FJe251yc5KNTOsBrG0Mivb/DE4LgmxSReA/V5i7R/29kzNhmSy
	3Ik9glS7O+/gUU+seQiYvViMpQVYXg5y7IAneXuo+WI7fV3ucBguRsuFPoFpTPd7rnUBUXk4r+J
	MXh1/MyaQII2tHid7fWezDAV7a2AoeZs4ueuzPfOb1ZmNuo/TPbGu+5LfAnB8NG/
X-Received: by 2002:a17:902:d4cc:b0:2e8:18ca:5f46 with SMTP id d9443c01a7336-2edb9146ba8mr28990585ad.14.1794327834955;
        Tue, 10 Nov 2026 08:23:54 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7d964sm11306915ad.32.2026.11.10.08.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:23:54 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 16:23:53 +0000
Message-Id: <DMRO4QXXB8H4.127C1CPT3RZ18@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 16/19] PCI: liveupdate: Add feature header to struct
 pci_dev_ser
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-17-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-17-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Precede each serialized PCI device entry in the PCI Live Update KHO block
> set with struct kho_ser_hdr via DECLARE_KHO_SER so future per-device PCI
> Live Update features can append fields to struct pci_dev_ser without
> breaking compatibility between adjacent kernels.

Elements of a collection should not have their own feature headers. This
applies to patches 10, 12, 14, 16 and 18. I raised this during the v2
discussion [1][2], but I don't think it was addressed.

All entries in a KHO block set are written by the same kernel using the
same struct, and the block set has a single entry_size, so every entry
header is necessarily identical. They don't convey anything that the
header of the struct that owns the collection can't. In this case,
struct pci_ser's header can define features that describe fields in
struct pci_dev_ser, and the PCI core checks them once before iterating.
If a feature only applies to some devices, the field's value in each
entry says whether that device uses it.

Per-entry headers also cost a lot for small entries. struct pci_dev_ser
goes from 8 to 16 bytes, and to 24 bytes once the first feature is
added. Patch 18 does the same for every preserved memfd folio, which for
a large guest backed by 4K pages adds gigabytes of preserved metadata.

They also add new ways to read out of bounds. kho_ser_payload() trusts
nr_required/nr_optional in each entry, and nothing checks that the entry
header plus payload fit within entry_size. In patches 14 and 18 the walk
uses each entry's fhdr->size to find the next entry, so one bad header
throws off every entry after it.

Instead I would keep struct pci_dev_ser as a plain struct, take the
entry size from the KHO block header (patch 2), and in pci_flb_retrieve()
check once that the entry size covers the base fields, plus the fields
of any features set in struct pci_ser's header, e.g.:

	entry_size =3D kho_block_set_entry_size(&incoming->block_set);
	if (entry_size < offsetofend(struct pci_dev_ser, refcount))
		panic(...);

That also restores the minimum entry size check that the v10 PCI series
had with PCI_DEV_SER_MIN_SIZE, which this version drops.

[...]

> -	kho_block_set_init(&incoming->block_set, sizeof(struct pci_dev_ser));
> +	kho_block_set_init(&incoming->block_set, kho_ser_size(pci_dev_ser));

This size is never used. kho_block_set_restore() overwrites it with the
entry size recorded by the previous kernel. Passing this kernel's size
here is misleading: pci_flb_retrieve() (and the LUO session/file restore
paths) read as if they iterate incoming entries with the outgoing entry
size, which would be a bug.

Incoming block sets should not take an entry size at all.
kho_block_set_restore() should initialize the block set itself from the
incoming block headers, and the incoming paths should drop the
kho_block_set_init() call.

[1] https://lore.kernel.org/kexec/atl6K2Juy6Bh29lh@google.com/
[2] https://lore.kernel.org/kexec/at-8vkVpN2SF3XgB@google.com/

