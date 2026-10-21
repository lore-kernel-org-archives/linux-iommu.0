Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625335;
	b=KYSCVUxfEovuWTxivRzA4LpYQboD5XChgMKkIr2uAN3uvj0Rzbk9GTLE6qfXGBlkKb0a
	 OISlJ5U4DkQycH1SOrHitDI2zME7nUairmqj9j6JEu6gFEDFTyxdvv+dQR3rF0cGSxQe+
	 GqvA5WQ5gp2XobeMDJZ3yjDG7/71qJLjZk8Nmj0DvGBKi+F2NI4H3QN7kNf+3iPosWRvR
	 OYVEDEBnWxDQiOjO2W2sFbRR9G8oMg+JeCZBDyipWqF4AR/wmQvmLOjCqEdJveauFOBOr
	 pV1MXOdSGnM/W46tYmTDLBYk+jVxs+c/JJ8y1vdtzDq99rnapVCeef7v28ZuwUzwA2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=j1gtu/2ECGchElAdjQsJmcTzWPpoWAuSh1B1l3W6hUU=;
	b=Cb+e8sLHVhRqNPwgdMxvuUZx91tSfznlo1TI6J4ItmZyCap50sxxKrxFhOmDeyjSm0r+
	 2XQiaTQhd9OxnXYOoFIPrl3dvbmS1wwUIVTI/eScDqxncn86FwqcI1iG+1Bd7wUEyPjuC
	 hHL9OnmpPNzmW7T+3RlTfhH/30G71A1hE45QuI6IIfY+dhdBfP5FMhzjz9xLa4k75RgaG
	 Fkm2+cAe5Hd7FPflRCFP955IbZpNCoWxyeocGMVoT2VlBlFp+PJsiJCZGry0fnj8L4AdA
	 2nH0scvFzgVLhwHLoHAevqLKKMigMKNcD43jyqU9bsRrHw3w9Ggoe8bXLZThDviIt0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YUCZi4LO;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC75606A31E
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 23:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC75606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YUCZi4LO
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so750459b3a.0
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792625334; x=1793230134; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1gtu/2ECGchElAdjQsJmcTzWPpoWAuSh1B1l3W6hUU=;
        b=YUCZi4LOA7RH/48y0hWgxZwp7PlxCi36ZdebY/Ku/CyAofuNZdMHO8xdSYudRDvDc5
         mgO2rK6IkQ5HmGIoKkDdSn9gggqIRzy8a3EkaHBRxTBvYqOg6hFBajoy8FP0N9MjDfEI
         WO5PN1HlXYsAAuvg+y9BzjzDbBHQH7F+oto4kNtsZuTET2ZmO4ImqaY6mhWkwrvQv3u1
         ZJH+sxTD+QsPgZoJHAYxBub0yFQ4OaqoS3cP6q2/YM18AHcMTGEPSm6Rp7rdsAOSFTZl
         b87FghollJ4S0V9OH8tOghaoP1bayw/qetUXnfQfvcr1XNZZ576rvV87Al9He0UERtvE
         vbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625334; x=1793230134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j1gtu/2ECGchElAdjQsJmcTzWPpoWAuSh1B1l3W6hUU=;
        b=kNJTn5vSqwroF6A/UDrFHfb8JkTdjFTPx/7zqpP2AGw2mwoGGATzF2F6qLKoSiSG87
         j0gAnhD0N0ynXZvnRq6ZtA5GquG6kANXrDFF5RFMMnCuncBdCSAcWdrLbA6WyE3UAna4
         QKQLeqp9ebDFChPIaNysM+lwUa4wMHsVGZg0WQaYIOpOH0/v16R5elcOV4+GRGjlgPAT
         7X0JE/c4g1VgiyoOZa8mYtmNgJ0tflx7VPkDx3omQCn6Gg4LUSHt2REybBp+pZFnbgMi
         gpgul20P8mdRVbvIleoo33McaeE4bKejbMz5qtL5vL38qqdFFgKsMeLuf8MR/QI0hfGt
         SNkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2sCGErIjnzQYb1Q/lmHRetsk5h+3fDgWZTmR6mANDsu24hgT5rK65gkAUv3Ir2gt4rgkS7g==@lists.linux.dev
X-Gm-Message-State: AFq9FYIJ+Cg/Ko/iSiQ2mN0ODFqZRlry3ERtCnUZpJcF5PQ6iUhr+Y3B
	qM3wq1QIUUGeVWXUczps96PAANonZmgBwWIrwqA+bHUhxy1byYYscy9MlIjoOTEzTA==
X-Gm-Gg: AYBFou0RuPZsY6PBuD29QHNedpbs2kL+SRfGQnA2eYIdFOLata6/izJCIlddqABas3P
	63nVD9TYbdBZMmGGYxbh9z4Czd03wpmXsaPvgA/VEKcjxhuobLUUZBmJaNFXDVhu6x0j3wvXCuS
	WbUBGfrDhSyGMaWbL2sPFGXObohBtkaSBNfSDd9RFcyMDabNosyyGXfoG33cTRMw1kUKc29GDdf
	Dr3NKXMUcnP4CUnNWzYCSwBhkNmkT+spfdk0WsCT1/f7EFck1JhSrByU3WogmPjjhgy4N48jYbs
	KkskOhKBqZGNj7OOzneOwlsgN1bsipk4ZKmhawWwn4kIYjQmZoS5IW4FKJGAybpMv98ZcwLgod2
	qxrTw+gyIAzcEQEsOx72tD/zhi4ybucRAbDQqD722+NOiw0Mvw7xEN5cnwY+qGTmddFl44z3x/g
	dER5/ffvfgoAWShMlCtyVviVhrkIAmVKfuSgb6qCr7lW19Bm+sq2sajaZQoUpJu/PPyleia0pKo
	jDpvMfZiBrennWPN5GoyOxM63aif9KwfF3N6e67q0Ppq3mDi9LnVbF9mVLkeKcHc/4wqSmu2BZd
	FH3SYGvYcZ+VpB6y
X-Received: by 2002:a05:6a00:448b:b0:88b:7278:ebf4 with SMTP id d2e1a72fcca58-8a089dc6e77mr2781314b3a.18.1792625333734;
        Wed, 21 Oct 2026 16:28:53 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08933aec9sm1368611b3a.2.2026.10.21.16.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:28:52 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:28:48 +0000
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
Message-ID: <atlKsD-aJB3mJr2j@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com>
 <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
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
In-Reply-To: <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>

On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 2:47 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On Wed, Oct 21, 2026 at 11:40 AM <tarunsahu@google.com> wrote:
> > >
> > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > >
> > > > On Wed, Oct 21, 2026 at 11:25 AM Tarun Sahu <tarunsahu@google.com> wrote:
> > > >>
> > > >> LUO and its file handlers validate handed-over state with monolithic
> > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> > > >> structure, even an optional additive one, must bump the string, which
> > > >> breaks live update between adjacent kernels. Replace the string in
> > > >> struct luo_ser with a feature header, so that the target kernel can
> > > >> accept or reject the source kernel state per feature.
> > > >>
> > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > > >
> > > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > > struct, we only need 8 bytes instead.
> > >
> > > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > > over-engineering.
> 
> 128-byte per serialized struct is not starter.
> 
> > >
> > > >
> > > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > > bits of the flags indicate whether an extended flags field is present.
> > > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > > that yet another extended flags field follows.
> > >
> > > If we will have dynamic extension of flags, Think about this.
> >
> > To support dynamic extensions in a backward compatible way you want
> > something like this:
> >
> > struct luo_feature_hdr {
> >    size
> >    flags
> 
> __u32 size
> __u32 flags
> 
> >    extensions  // offset of first luo_feature_extensions (or 0)
> 
> __u64 extensions[0]  --> but the size should be specificed in
> declaration macro that I showed in the next patch.

I think you may have misunderstood what I meant. In my proposal,
extensions is an offset to the first extension, not an array of
extensions that immediately follow the header.

If the extensions immediately follow the header, then the number of
extensions is baked into the struct layout. Every field after them sits
at an offset that depends on how many extensions there are. If we ever
need one more extension, all the fields shift and old and new kernels
can no longer read each other's struct. That is the problem Tarun
pointed out. So in practice the number of extensions is fixed forever
when the struct is first declared, and we have to guess up front how
many features a struct will ever need. That's the same as Tarun's
128-byte header, just with a smaller guess.

What I'm proposing is a linked list of extensions, where each link is
an offset from the start of the struct. A new extension is never
inserted into the middle of the struct. It is appended at the end along
with the new fields that need it, like any other new field, so existing
field offsets never change.

Something like this:

struct luo_ser_hdr {
	__u32 flags;
	__u32 next;    /* Offset of first struct luo_ser_ext, or 0 */
};

struct luo_ser_ext {
	__u32 flags;
	__u32 next;    /* Offset of next struct luo_ser_ext, or 0 */
};

That's the same 8 bytes as your proposal. And because "is there an
extension" is next != 0 instead of reserved flag bits, all of the flag
bits are available for features.

For example, a struct starts out like this:

struct foo_ser {
	struct luo_ser_hdr hdr;        /* hdr.next = 0 */
	__u64 a;
	__u64 b;
};

Over time we add features and fields until the header flags run out.
Then we add one more feature, FOO_FEAT_C, which needs a new field c:

struct foo_ser {
	struct luo_ser_hdr hdr;        /* hdr.next = offsetof(struct foo_ser, ext1) */
	__u64 a;
	__u64 b;
	/* ... fields added for features in hdr.flags ... */
	struct luo_ser_ext ext1;    /* ext1.next = 0 */
	__u64 c;
};

- a, b, and every other existing field stay at the same offsets. Both
kernels can keep casting the KHO memory directly to struct foo_ser.
No memcpy() or variable offset math.

- An old kernel that knows nothing about ext1 can still find it by
following hdr.next, because the chain describes itself. So the old
kernel can still reject the struct if ext1 has a required feature it
doesn't support, and ignore ext1 otherwise.

- A new kernel receiving the struct from an old kernel sees
hdr.next == 0. It treats every feature in ext1 as absent and never
touches c, so it never reads past the end of the old, smaller struct.

The only rule for subsystems is that a field can only be accessed after
checking its feature, which a LUO helper can do by walking the chain:

if (luo_ser_has_feature(&ser->hdr, FOO_FEAT_C))
    c = ser->c;

If we keep size in the header, this is where it would be useful: LUO
can check that every next offset is within size and strictly increasing
(so there are no loops) before walking the chain.

> 
> > }
> >
> > struct luo_feature_extentions {
> >     flags
> >     extensions // offset of next luo_feature_extensions (or 0)
> > }
> >
> > And then an example serialization struct would be:
> >
> > struct foo_ser {
> >     struct luo_feature_hdr header;
> >     ... fields ...
> >     struct luo_feature_extension extensions1;
> >     ... fields ...
> >     struct luo_feature_extension extensions2;
> > }
