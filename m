Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794724654;
	b=wdVD5/Fuozt/jEjyDOraiw/KmJK5Ofyp3t/L7rGk2X+yyj0Ie8SZDw8Xz09fpfcOTmt0
	 6EXnFBefSpwnqWqHqPKp53ga+uDHAvTOhg+tbR5GhtA41AmVL5j88xH4tz7/NU7ZTkEHI
	 J7Q1gwB1ceGEC5B2dsdFSGk2XDWRsYKYSc7e5xVFv9lM1eRJKD5nxoH+pzSXYgJLC6ZnM
	 nQdG3o6dPjUhKAbWHwcSRgJ7aDE6H4DK6tIdTrQTf+vLl42TVhpSbSz/yeDb0VFLWR46b
	 yQcmxp1Cd33bVtzMNCfhK65LVVlV6wEPb4ZYX/e6+bX1bdEgF3fyIeBmfYr2B48Ro3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794724654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=aE92BuA/q+u7mWs8kchTDkcjs1m/i8lsv1ezZ7OruqU=;
	b=g2xvsGGaRf7z/r/0MesYjXyNRJ9bNynNxfSZgf2ej+RR6Cw3SJbYv82q9QU8rwzlBDh4
	 /0WHjt/wpdItSXtdJd2+Os2x3Kk8+DR1jf0VxbiScsohZsAFLx4I+5f6lZxG3NfMspf6c
	 61nVzSPitsShgaOHZcadfD3ot9Wd/ySNyuneSlt83LJkSluqidttTBBhXkUyktWs6kJcs
	 oTHsioYyEqGA5rCn/kVJ+tAzLu+bFdaYdL9HiMU2wIFYFpBKZxo1zTfCawtDJoumfpeXt
	 FittbhXLpsXU+TApXGToyD1nHNjNaJq6J7065i9oaFivtvmY4foI43dTT60I5bJJI/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="lfic/lB3";
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA3606A32F
	for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 06:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BEA3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lfic/lB3
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c42888c50c4so127613966b.0
        for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 22:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794724652; x=1795329452; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aE92BuA/q+u7mWs8kchTDkcjs1m/i8lsv1ezZ7OruqU=;
        b=lfic/lB32zga7USVCjmudfQwrO/kW9r41/zrmbRUMIvViMsr6q8bwchfXWZC4lDO0v
         +TwVWPFxZ9HdVjkLdQQvQqlWSJhFYM8PuNC4M0tTimvqosuEzEi15vfx6HkY7VUHGyr0
         Und6fsWrdW1W30H1uicsjXh2PBNw9xnPU7b0UbHv1miRizjX+BQ+IywKc3FVHnuo8NMK
         oaJBqibJJy2PuJUElgTteoCwKgfiFie4E3Zy9twe9jjlBzrnsqrOjXnkCHlONZfamqFC
         sjKUZq3DOQkFv/xnjMYIR0wP1At3FpT8LXSRK3vkAcFxFAj6VEhZG587SbKz2vcPL5qi
         jzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794724652; x=1795329452;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aE92BuA/q+u7mWs8kchTDkcjs1m/i8lsv1ezZ7OruqU=;
        b=muHhsDtKUNomPOaHO1jkdVbfJJllIdXpG8yidSnLMR5/Dl7CXibekSibBGXRGlK3cv
         QDlc8PHEvYrwGLvfzQxdgR1lE3CTplQjzKUMdWqufZlo+ZSLiQzFPaVW8ZxPKWXdBLbT
         MbTEfluIDoaWZxIcwGmKkdjetVywOxcQGeBoyIGnkNuiyIKKplmLZ535O7WRE2XSKy/n
         /IZ44psTlTolIT0MK0jOaBpE4J7RGUkViCj7pGIjnYb6r3mHuNlpaH6fFBTQoWMFJnzd
         GMzLOE61xZsgtgvqYHrGgPgqWyIHw1VShXpAZfek1bXLlZFjOX2rEHQ0jGQwHdw+5Mct
         xmzw==
X-Forwarded-Encrypted: i=1; AL+hErGq5v+fCuhWYqPO1TZz4vlKFiqVkZImKUJzO7PlCT2GXwVwcEB/qpM+QvnjTWJZ7V2EPrAqKw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Eq/kNfWjrPhg3EBR/Sr08zpHIeTw5xzZ7zNvJCaL+3XcmzkG8
	eFjj7zPF/wx6Qh1jRe/WNI6xqv/sdr/LBBDE+b6IhSOioJ4LoVxDqL3BUy7dXEwMFhaQLDMcjm7
	d+C7lLrYGxJABPAR7TA==
X-Received: from ejbge24.prod.google.com ([2002:a17:907:9098:b0:c46:7bd3:aa06])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:a714:b0:c42:5363:38dc with SMTP id a640c23a62f3a-c509637e20cmr533164966b.25.1794724652053;
 Sat, 14 Nov 2026 22:37:32 -0800 (PST)
Date: Sun, 15 Nov 2026 06:37:31 +0000
In-Reply-To: <DMROZB8DPEWD.W2BFC7JIBVZP@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-3-tarunsahu@google.com>
 <DMROZB8DPEWD.W2BFC7JIBVZP@google.com>
Message-ID: <9huzjymepplg.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block header
From: tarunsahu@google.com
To: David Matlack <dmatlack@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"David Matlack" <dmatlack@google.com> writes:

> On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
>> Add an entry_size field to struct kho_block_header_ser. On the outgoing
>> side, record bs->entry_size into every block header during allocation.
>> During restoration, derive the entry stride directly from the block
>> header instead of relying on caller-supplied dimensions. The
>> kho_block_set_init() interface remains unchanged. A zero entry size,
>
> Since the entry size now comes from the block headers, incoming block
> sets should not take an entry size at all. I pointed this out on the
> PCI patch (16/19) as well. As is, every incoming path still calls
> kho_block_set_init() with this kernel's (outgoing) entry size, which
> kho_block_set_restore() then silently overwrites. That makes the
> callers (e.g. pci_flb_retrieve() and the LUO session/file restore
> paths) read as if they iterate incoming entries with the outgoing entry
> size. kho_block_set_restore() should initialize the block set itself
> from the incoming block headers, and the incoming paths should drop the
> kho_block_set_init() call.
>
I agree, responded to the PCI 16/19 patch.

> Please also add an accessor for the entry size, e.g.
> kho_block_set_entry_size(). Users of the block set need it to check that
> incoming entries are large enough for the fields they read, and that
> the fields of a feature are within the entry.

Sure, Will update it.

> [...]
>
>> + * Each block header also records the size of its entries. A newer kernel may
>> + * append fields to an entry, so the kernel that writes a block and the kernel
>> + * that reads it can use different entry sizes. The reader steps through the
>> + * entries with the recorded size, so every entry is found, and it does not read
>> + * beyond the recorded size of an entry.
>
> KHO blocks can't guarantee the last part. The iterator returns a void *
> that the caller casts to its own struct, so it is up to the caller to
> not read fields beyond the entry size. Please document that callers must
> check the entry size before accessing fields that may not be present.

Yes, I meant the same thing. by having a check on entry_size reader must
prevent itself to read beyong the provded entry_size. I update the
correct the documentation.

Also, I realize tha, after checking the base fields using offsetofend,
for any following new feature fields, a entry_size should also be
compared against the readers offsetofend till this feature field for
required fields. Incase reader does not have that field and
kho_ser_validate passes, that means that field certainly is optional.

I can add this also part of the documentation.

~Tarun
