Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795147224;
	b=VLGp8FxD/kH9WI0wMDM/ylsWWWpo/mangc38L+/zd04Wr//erabAVYwkQWQpC4Lf2DRA
	 DgWSZOprKODXFQOMi4YajBHEqMiZit1Jh3U6gGl4q1m/X10Am1RgsHBzHsjNsVkc6OKbn
	 m5mNWF6h0bDzadDNYF9a0reGMv9LRv3KNMwkBrVvG/GIuEwUw4WhYRMIb55evDJjln5O9
	 fJDnI5LOitPzL6XsfwVoYRZM6gBuInteXUXaIPPSSvDRcsHEm6tUGp7b8yPjZnoriOA3X
	 X9KN90D9BpcUptsaqVe9JmZ9kkRjqJB0mLIT9XUzCGtuz0Rj+jOy5Jkqw6pAHE4jq+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795147224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
	b=5HcjZw5F6/ejodIBEym+eUPTF9tYPEgNPtM1ARawb2JNisxc9q5xf+O/s+g6QHa1ADpk
	 rWY7gi7zI9hnlH5H7YInRmplSURwLHViUGYkaS16T9WIphA+YTpzRiZ6PIXxbj2/40els
	 x6tP36Nx9pINiZRcPTeFf+llqM+rFMZ5xt7+caygAXedMXjEieOk1VMeRsyYX7b9xCiOi
	 FLEnkNUP7p9koav+0mj8QoHYh1GwE280VC1JogDvpwKB+QJliVqrkjGLeFMQ8sCfTqvJP
	 yIytS48yGjxSj76h9Ek+eICrhjceeakW8HJb8chh0XL/VIEIPBSKoYIJ9zZzuD1m4KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Zxf/yV9a";
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122A606A332
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 04:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9122A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zxf/yV9a
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b582b355eeso398064a12.3
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 20:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795147223; x=1795752023; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
        b=Zxf/yV9aaHa2VV29USdqQ5n9t9Guir4IrounD0aY1RI7xjEo8exCh6WyN2v2S7oYX4
         dEVSUxvMnO+XtBgUETzkInEiRpMOM2ytqqIwIy6PLC+5WaqAk9P19AqSd7VCzjGqqabe
         2i4TbuC32GrkrMcT2u7ZdzmgWebIr7If7okkxbCFnBAuPlJyMM0laFntEs/sbAvyInkw
         8uVHtlMKNR6w5lD3g2pzhMR3G2ARnfXXB8a0/7u2Ip327GOmujUUd9GsAghdmyXNakvR
         uM7ioTrUIXIm9RcLzGwNgstIz757Mt0owRz4eMU0PdTkv/DDfs3BNM7WyQd6HmmUUTDu
         CJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147223; x=1795752023;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
        b=bi3LkNiQIkVHp+P3n/HXUizf+8zeTQa4FwqCQodvCJTZMQ54Vu4Bfmh/6YNcWLeIBj
         SzU9G8+FwH5UvSbsDCVq9QR5y51M9t76dk0E8YRgpyDCA3lEICjwKELJaMdswua6dBjn
         DzYVCXBT5+k/KP4JI2dkYTscccx8jMXcJAaEfXI+cuGSh1tZfsgFEJU12jGJL64XFp0R
         jmemi0SNSwEvyg/VlSDvkmvGrY8OwmY52djgLel6lRIkI16fKbQLDLbQXzDk5Wcb1l26
         fP8H/BmYRQb4OqaRZrT51YzqqbVFWWyOoC0TG97Ie4JTpu0hySLdVBw+7IzYZuGF5TGP
         grWg==
X-Forwarded-Encrypted: i=1; AL+hErHYHD7GBD+gYwXsYKAtyRafhzYG4AnU+sk9kyjjl0lzncsMG5GavXnMDBggwkGZu91kG360iw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9MKg9MgaupdChO8lwtkmxWeBheTUoOUbc4c+zqRZhiOhJMEpJm
	ABmcLTJCZgD8R9UwW71ZkeVRTuJE7pDXoEg+xTw0l9Kk08i6qKAaUzeqsYxhhGERiXXCjca+ajB
	cUk1e/oiRq7FbDTDNbA==
X-Received: from edeg3.prod.google.com ([2002:a05:6402:5643:b0:6b8:a08a:8bad])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:501c:b0:6b8:afbd:64e6 with SMTP id 4fb4d7f45d1cf-6ba37edaf1cmr1021371a12.42.1795147222675;
 Thu, 19 Nov 2026 20:00:22 -0800 (PST)
Date: Fri, 20 Nov 2026 04:00:21 +0000
In-Reply-To: <20261115203421.38c206b35f5b12e6@chrisdown.name>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-6-tarunsahu@google.com>
 <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com> <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
 <20261115203421.38c206b35f5b12e6@chrisdown.name>
Message-ID: <9huzmrr4f8yy.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI compatibility
From: tarunsahu@google.com
To: Chris Down <chris@chrisdown.name>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org, 
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Chris Down <chris@chrisdown.name> writes:

> Hi Tarun,
>
> tarunsahu@google.com writes:
>>Techinically this is just for readability.
>>
>>WDYT?
>
> It doesn't help readability in the generated docs, though. kernel-doc
> splits the parameter list on the comma inside the macro, so
> kho_preserve_vmalloc() comes out as
>
>      int kho_preserve_vmalloc (void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc# *fhdr))
>
> and the struct memfd_luo_ser and struct luo_session_ser definitions in the
> ABI docs end up with a member like
>
>      DECLARE_KHO_SER_HDR(kho_vmalloc folios_fhdr;
>
> I'd go with Pasha's suggestion and use struct kho_ser_hdr directly. The
> pointer can then say which payload follows it with a comment.

Okay that works. Thanks Chris, I will update it.

~Tarun

>
> Chris
