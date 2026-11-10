Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328775;
	b=pi9zU0a7BGp4hk3bwOQlUV6aH0uNKej4i91vbUBk3g2NXVNYz6ice957NAWSRZzQoxrq
	 fvdHaENdwsPZMU0kzTgIKsrf6oSN9zOMls/YP+f1WMtMI/I2P3FuTuwhr6FP7Ixhl7IoM
	 PJZl8IDGWujvy9PcH94X76wwf21QX88RpKd8rlI+hikycG+e7+zva1jCJ0Xx1ifdTYIOI
	 lBLHjDs1AeemhY0fsTbZ1rZf0okczm862IHCh0ecrKGZG/FLFOQpT1xFXVBcwT2Ype06M
	 F6DRej8Mto/LpUds6YIfTTBJIfdkHe2DAlfKdyf+7YquTn+Cq7LmEX4rXKzrbJjFJ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
	b=o8c+ZTcGCo0eyvJylfgMdzPujHai54wYq/GxTsrnVfLMvFB+rEqDB4dhMOXRfu69yI7b
	 i+l9TD+qiALPhrVKGaRYjJdZ1yQGJu+kLmXLhwikwGYHdBgrkZfpYW9NADKWagW0WkKjN
	 3SadDdmg7DopNDodm80Z/BqoB1rSX3rS07VbZPKN0mkEGC7JKBlhHtLN8g4DtPmA0AijK
	 TuP+x04Y1jWHj+L8QVTGBjy1KHr9Ped14nXzciBp5lH8LxiJNUeEN4YxoN7QTelGSXC8N
	 yOECwkvr/Hy9a+5H/TpmEij2xBb2Q27XdaPUV+caV+lRSRNQeM5lHaLFUTwdxDkoxrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="DwMnh/7f";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBD60A263C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 16:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FCBD60A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DwMnh/7f
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so1424824a91.0
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 08:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794328774; x=1794933574; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
        b=DwMnh/7fvo2aKeuK7+E7zP5py2qlGXJhBDucZGjSafiZq1HXurD3YzgE7kV7SZ3Ply
         3CwO/jPf8TXQz7UC/uDIjRBARW0nc4R90OqSDOM7mRl6lbdKH9HVfrTLqHGQ0869Xifn
         j2G5XcOHkqVBe4m4Z/6T/fIjRUvhSjVPX/btuz9jJA331broIJTaD2BgXz9n5QJN/5t2
         zZpGsiA5s3CpxmRwAj0MnwkckL1cZWko35wqzFpriAUbXFmnS7GjedGtvrRsAA+ALOij
         RaLhm3/rvMFha0U2gWhK+7c8oJHVuXtqbYZI/8ybiPEXEhhXYUihMcuj2oIBznsjwh2A
         Hd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328774; x=1794933574;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
        b=j5XcN7b7L0AKvyG1ht0+l7aXkNJEwunkj3t0t5DfTtUKCPQ2st5fCmI707cTCDEKzn
         pFT85hC+nN/5uKxonDtQypIjv1bEVt8bwjYrTx5KvixAk96hT4GYR/qLyivVSMsHrcMe
         0+zuSZSqHyyFySfW4B93y3thHiNLRPpscwwjwwvbQkupU9OqAH5AN4stl1puSCxO94cH
         w+f+qEItflYYxa6Pd3KA00iNVstoX7+kdGZeNUQF1GsSs8dn2/1azJrGwWcGsWL5vh/l
         fxL52AjlgDoKsEtlrfhNq54haqChnxCICLJUpu5KQdCA2hkv3dGoccTXDri1CnYM8R8F
         J3EA==
X-Forwarded-Encrypted: i=1; AL+hErHDwbP74pIhTtPcNKcKgjcxBXdBZ7hrmJ6SYbJrvAv2KKNFCR0hGOINgr6ZGLLykVsK+dqTaQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+z1Avl8vuWdSeLClLHYOTegLSp5+OZymnmRltUYGDr5WIp4Sqr
	Bipkrj+QND+WUB35rqJUo+Ykm3pi0OrPZCn/tZKups8vb1WdiZiHMf5Yvh2eBp+ovQ==
X-Gm-Gg: AYBFou2no4XPKSigQ1Rm3Sk9H03VJrMIOQMN5Q9ju86RfCPZZSURWU9bpa+kvF435Di
	kdzN4gjIRNxb7EF4JP/6osidCsKrDMrTGp396fun/lKVLjMzYMKe7x6hdKSN6Wh/DZ0KfCB0mGj
	h3M4xCTbOyrGgUByTdCEes8AzQcKWKFllVWSdK5X9N88EjCUgxNcH7gi775+Af91MWUipnQJ6SP
	FoOBc8L9YEfQ9Ot9kHVfSS4EqpqBGKst5f9sqqqjY+ejhBq3Q0uX6acGyj67GuzgsDzIQIUbZJx
	a8NBpwHdxV+gg8NIifBfIETt4xyvccIS5dix5Pa2jopZP/FA0PZFxQyKF9GNxPugjMF3NcT2TGN
	k3wqGsu+2yhpAY3p3MTsuclTq7EkHRiOJORo6SUI7k6lWDjNfA3s7i6nE1FivorUOODGMZgjHL2
	201dEvQT2BQGKHHERGEUsGIrQHrLXV4Kaov5/8jvxUhJPIfibwwJUk/zXh55TEvCzAvq3nFSQoF
	aUPZwdv5KXBY7ptwJXK/OKZxSUusiCqJhibVyVNs0ZIy+dN2FYG9rYJyhWE9xFzn7nZ6u8NOnwq
	65jhrJtafSBbKQ/mjkPmUNt/d+hrAACs8OzY1X8ReNHX4ajbC4myFqIeJopggcET
X-Received: by 2002:a17:90a:d444:b0:3ac:9d83:8861 with SMTP id 98e67ed59e1d1-3b166e3c924mr3152630a91.67.1794328773194;
        Tue, 10 Nov 2026 08:39:33 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168a8de09sm2418499a91.0.2026.11.10.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:39:31 -0800 (PST)
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
Date: Tue, 10 Nov 2026 16:39:31 +0000
Message-Id: <DMROGPTP93G4.13PA42UFKZJNJ@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 15/19] PCI: liveupdate: Add feature header to struct
 pci_ser
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
 <20261110050202.529473-16-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-16-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> PCI_SER_REQUIRED_FLAGS_SUPPORTED. Remove dev_ser_size and
> PCI_DEV_SER_MIN_SIZE so restoration derives the struct pci_dev_ser stride
> from the KHO block header entry_size. Drop __packed from struct pci_ser

Taking the stride from the block header is good, but dropping
PCI_DEV_SER_MIN_SIZE removes the only check that incoming entries are
large enough to hold the fields this kernel reads.
kho_block_set_restore() only rejects an entry_size of 0, so
pci_flb_retrieve() will now read past the end of entries smaller than
offsetofend(struct pci_dev_ser, refcount) instead of panicking. Please
keep an equivalent check against the incoming entry size.

> from the KHO block header entry_size. Drop __packed from struct pci_ser
> and struct pci_dev_ser, adding an explicit u32 reserved field to struct
> pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to

Please move this to patch 1, which drops __packed from the other ABI
structs.

> pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to
> pci-v2.

The PCI Live Update ABI hasn't been in a release yet, so maybe we don't
need a version bump?

[...]

> - *  * The size of each struct pci_dev_ser is recorded in
> - *    ``pci_ser.dev_ser_size`` and is never smaller than
> - *    ``PCI_DEV_SER_MIN_SIZE``. The next kernel ignores any fields beyon=
d the
> - *    ones it knows about, and must handle entries that are smaller than=
 its
> - *    own struct pci_dev_ser.
> + * Preserved devices are serialized as struct pci_dev_ser entries stored=
 in
> + * a KHO block set. The block header records the entry size, allowing th=
e
> + * next kernel to step through entries using the source kernel's stride
> + * even if fields are added in later versions.

Please keep the rules for extending struct pci_dev_ser. I'd say
something like: fields appended to struct pci_dev_ser must be gated by
a feature in struct pci_ser's header, entries are never smaller than
PCI_DEV_SER_MIN_SIZE, and the next kernel must not read fields beyond
the incoming entry size.

[...]

>  struct pci_flb_outgoing {
> -	struct pci_ser *ser;
> +	DECLARE_KHO_SER_HDR(pci_ser, *fhdr);
>  	struct kho_block_set block_set;
>  };

I'd keep the ser pointer here (and in struct pci_flb_incoming) and add
the header pointer alongside it. The header is only needed to free the
allocation and for args->data, and keeping ser avoids sprinkling
kho_ser_payload(outgoing->fhdr, pci_ser)-> throughout the file.

Also, please call it header rather than fhdr, here and throughout the
series. fhdr isn't obvious to someone reading this code for the first
time, whereas header is very obvious and clear.

[...]

> + * @reserved: Reserved for alignment.

Please document that this must be zero, so it can be used by a future
feature.
