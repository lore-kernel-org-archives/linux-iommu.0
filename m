Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637867;
	b=WsQy3QWWI9KYnH2QkNQ97bnEo8Pzxj/SBtaeDf9GiIeqWLxg7gIHGAAAo7z/lVAtXfy3
	 662dkSsHvD9W74VqspJCnywNQ9K+NM9MEIRqttn0AZFk7EgPjjHMkI1EyS+D4I1I7v9/H
	 QO6eZnfdNq+e7vBxUanukUX9nnMuGZHPtmmLraFngWeGZ9G/d+bYatLHE9vyINVfC0ufZ
	 K/cqL1ijWHVVoGMrnaDVAaiZXuMyEBwPMZWwmTAVy1AqEKVCLrwh6uFwvfe3GjqgmLz60
	 mirb5qRBsnEfkfmF5YRNZ74ob7QfSNcvke6iI/RuXT9/lax1drhZsX8jtMnINrHWbOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=9EhJunI31x30V5twb29p5JvXR/ZnOh8avGc16eTeBG0=;
	b=fXRNHUXBcng8cd5DW6+KNBFu2H9i2+2Fyqut3q0F6sx4FElUsIytp9WqmYyFK3cUcile
	 Chc5deJP6FHuyCk3y0Nko8diow3ECGrQbRQ3lhdn2da0mVAvt8bY6YV1vNrsiIXg8KGQU
	 g4fTbDUeNg1IFLLQRCNur6msVYyR8ZcWso0stvhdtTNw7B7vnUyTfZkTbTUtYYe/fmIHw
	 RWP62JtcWyN7tjR6CqrgPrTYRaONacNzVGLhVLzVbZGCG+yiN2xgLtLbCf+PB8azqffo+
	 I00n6PONYJePwFsCi0pe5z3CxxRUztS0uickFxsW/qlTfED2SKuDAQj+ayFrNeXn0cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hos3tnLO;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B7606A31A
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 02:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E2B7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hos3tnLO
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso567334a12.2
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 19:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792637866; x=1793242666; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9EhJunI31x30V5twb29p5JvXR/ZnOh8avGc16eTeBG0=;
        b=hos3tnLOFDTILPkqaLcWcGCkCVDk8LrxUIKOaQAu8pYx3b+hb9cDcwmLTDANMJw/gA
         nRdZQbOdM+LnZXSk9OxBAdo8uioy9aE0f3zSlmtmPa2itvIZEWe4IK64NaVUAExNBLXe
         qae7/BwEZAifiF2+Gi9WLqyisDE1y4MhbKUkVGBDHhExXplVHOFobDx4ubGsoUGlrOfy
         hdXncyIbC2lBqo9SKgArgUSWXDcPYGsLGIt6ZE7Wg8QkZcWbDeubxeXHM2XdSYVXfoXO
         7HBPQJmsFKp4gcj2JuB6YvtUoySQcggHJPuhv244MUlnnir/ZkPMAsdxHrG2JIxdEWl8
         apcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637866; x=1793242666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9EhJunI31x30V5twb29p5JvXR/ZnOh8avGc16eTeBG0=;
        b=PkNVq7wG6ySfS1KViHwFy+/MUkkm0oi/4GRxIs7WvDK78j2pJ5BVFTzpHI37WhuEqO
         HIDmHfRci89po3pKuXeEUXa90AxBiGk9KEVCx/5tokG4fF1/HBEUIxrJEDLpgw4UQ5fP
         RYe4UQXOqKe0Af2CESufthb55CyrDR+m2bUOkGZpPpUEIAxWTCSO+d5VZTlNpuXCO8Wa
         oXV/X5aItWV0+VguNl7kTPrUrsgQZ8CdtHXDtypNGjgHOhWn3lPf/+kXL5dOeb6FYb7I
         pQtVTFdj0kXLqsELzOlTvsn4/8zRSksafOZ+0ZmhW1TZDVl4j3ODPCzyddZTU3mn1Chv
         tPWA==
X-Forwarded-Encrypted: i=1; AKwUvBxxBlGlCZwAEUJgD2AgHFnTBMGVEPgbU4AyMAf6mpyNKrRPct0f1UfBnohr5XwVWKUZxoqaCQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ3RMY7OKNHJxyO2SKBrpD0qZHWIZolTvLHj7CSNx+iKv6R+vko
	6WXr9E6KdJXwc3bWHy/8em79FuaMQkjIRRTxObw1NulR4xR/e8E09rsWfSGrHPbKYg==
X-Gm-Gg: AYBFou0OgILzPx8v2EAN1/ATwqDe0s47ExdcFVXmK0FpHxTPMIuqAemlZEu0nRH7o6P
	AZoisae5FxRYb6EBGq0eqVn8KuXDrc5Y60j+zT7TUVVJNv5DRQkXkG2HgZFJ3PyrDS22QDDPLIg
	XqJuhlCjlO44b4GAtJTVHrfarZoaC0mOiGGjP65V2fx4yXA3HqXZTQklHfm0Kq/zP2yV2K+KWJn
	WkPt6XlUpwvycUU4uDHQnLekgBIRYFACSNfkD7ofa9l3brGZ5s7DcPQwpVB6jGnZRxnqTmw4hgF
	bSZJTTLn00jUTkJHzuPjzq+WIFzyZlLCCfMr+kQXK0nuufvUPfjSO683vRTn526H92mHoE+LM+k
	i+htrbxEP/14dGpsXSt25IMSvKiOgP32bTa2IDD26neM5XW0DxE5EH7YcVNSbote/EQCo/gQAYt
	dZitYxoVjjleqt+Ugdse0T8QXu2fHMCa0vJvuV33PKBXKuA13t6s/vKds35reSzDlTxkGC487fb
	GXBFHWC5OCvRDZRaC9N+4E/dG3Vv6HaDvNCF/bAUfQn2Z7sb1P0J1ZOgcZFTX3POrGPRhJo1h6K
	Lm0TdmalPXYtVgvc
X-Received: by 2002:a17:90b:3ec8:b0:3ac:adce:60ad with SMTP id 98e67ed59e1d1-3ad86e96c9emr2886416a91.22.1792637865925;
        Wed, 21 Oct 2026 19:57:45 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada495315dsm2092370a91.15.2026.10.21.19.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:57:45 -0700 (PDT)
Date: Thu, 22 Oct 2026 02:57:41 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <atl7peoVHdP5hz7z@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com>
 <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com>
 <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>

On 2026-10-21 09:26 PM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 7:28 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > > On Wed, Oct 21, 2026 at 2:47 PM David Matlack <dmatlack@google.com> wrote:
> > > >
> > > > On Wed, Oct 21, 2026 at 11:40 AM <tarunsahu@google.com> wrote:
> > > > >
> > > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > > >
> > > > > > On Wed, Oct 21, 2026 at 11:25 AM Tarun Sahu <tarunsahu@google.com> wrote:
> > > > > >>
> > > > > >> LUO and its file handlers validate handed-over state with monolithic
> > > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> > > > > >> structure, even an optional additive one, must bump the string, which
> > > > > >> breaks live update between adjacent kernels. Replace the string in
> > > > > >> struct luo_ser with a feature header, so that the target kernel can
> > > > > >> accept or reject the source kernel state per feature.
> > > > > >>
> > > > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > > > > >
> > > > > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > > > > struct, we only need 8 bytes instead.
> > > > >
> > > > > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > > > > over-engineering.
> > >
> > > 128-byte per serialized struct is not starter.
> > >
> > > > >
> > > > > >
> > > > > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > > > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > > > > bits of the flags indicate whether an extended flags field is present.
> > > > > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > > > > that yet another extended flags field follows.
> > > > >
> > > > > If we will have dynamic extension of flags, Think about this.
> > > >
> > > > To support dynamic extensions in a backward compatible way you want
> > > > something like this:
> > > >
> > > > struct luo_feature_hdr {
> > > >    size
> > > >    flags
> > >
> > > __u32 size
> > > __u32 flags
> > >
> > > >    extensions  // offset of first luo_feature_extensions (or 0)
> > >
> > > __u64 extensions[0]  --> but the size should be specificed in
> > > declaration macro that I showed in the next patch.
> >
> > I think you may have misunderstood what I meant. In my proposal,
> > extensions is an offset to the first extension, not an array of
> > extensions that immediately follow the header.
> >
> > If the extensions immediately follow the header, then the number of
> > extensions is baked into the struct layout. Every field after them sits
> > at an offset that depends on how many extensions there are. If we ever
> > need one more extension, all the fields shift and old and new kernels
> > can no longer read each other's struct. That is the problem Tarun
> 
> We can structure it cleanly by nesting the payload: something like
> struct { struct header {...}h; struct serialize_data { ... }p; };
> That way, the header can expand dynamically at the front, while all
> fields inside `serialize_data` stay at fixed offsets relative to the
> start
> of the payload.
> 
> Since the header size is self-describing via continuation bits (e.g.,
> the last two bits indicating whether another flag word follows), LUO
> can
> easily compute where the payload begins in the incoming blob. This
> keeps the implementation simple, avoids linked lists of offsets.

Oh interesting. I agree a dynamically sized header at the front can work
and is simpler than a linked list.

So the header and the payload need to be separate, and the payload is
located with pointer arithmetic on the header. For example:

struct luo_ser_hdr {
    u32 size;    /* Size of the payload in bytes */
    u32 flags;    /* Bits [31:30] indicate an extension word follows */
    /* u64 extension words follow while the continuation bits are set */
};

/* Size of the header, including any extension words. */
size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr);

static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
{
    return (void *)hdr + luo_ser_hdr_size(hdr);
}

On preserve:

    hdr = kho_alloc_preserve(luo_ser_hdr_size_for(nr_ext) + sizeof(*ser));
    luo_ser_hdr_init(hdr, sizeof(*ser), ...);
    ser = luo_ser_payload(hdr);
    ...
    args->serialized_data = virt_to_phys(hdr);

On retrieve:

    hdr = phys_to_virt(args->serialized_data);
    err = luo_ser_hdr_validate(hdr, ...);
    if (err)
        return err;

    ser = luo_ser_payload(hdr);

What would size mean in luo_ser_hdr? The size of the payload or the size
of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing so
maybe it's just the size of the payload?
