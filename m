Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691482;
	b=FqJ1+6G9z3ca/NbPZRo+Kfq428XGEHh/li4YTuns/I/IyF0ZnrZdKHxbNKo4akHgvoP6
	 JtVde2g3Iw98tb/S+in1vlsirNYpxtDuevNOJINrsiR0CTXQYkjlXg35INUGb5oE1j/cP
	 bRh5Y+PFG1q+0MxCY3IyQCKxAh6RKnGb0pjeBIMmnYlGu6bu4R35AC80a1az9mdNYx+nu
	 Sge0OhKDwieAmequ+1vQBR/JLawwEN5Ap7gAAb6I8QRPWErvLpOPV8G+hoi0vXUkpulcK
	 rSKfNRk4yuRW4N37WP9bdQv16C9LFMP5C8pQTTE2mRsF4l5tB50m2oKxXopByXfNs+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=VXuE27163XQs95Y17MHXQoRtZevE9c0I3KUjJaU7M5M=;
	b=WJ5fQfM+k8YpoKs0MAc4oxQ6CdrRTQu47S0R4PeftRsJXIEsfdVP/f40zMvOaq+ZckyQ
	 CWRoGe93TMqot2fT2QQp2XvW5Ucl4HvCLZpeNzGa7yFsxw0YllHuiz/q73zuT1QgQxF8d
	 LRTFW1B+jABwTlCCGT+OqzgFK79jTvv5hLhKz7pYE0GSqTtVD6nR71QCueXjZkw3+fEIM
	 YoCI4IYH9t/gh2ZG0CT31U4aJEu9E1Yu/x/44BQk7sJrJWsKYu0kwHGzdO3J4fymQhdYN
	 J7yVkbMlGj+7lte7LODnrynJY4yErZKOCg+forVciUFJPiYKE3pnoKng8SLixuc0m5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rhOaAi2c;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A858606A31D
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 17:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A858606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rhOaAi2c
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e95bd1c14cso14715ad.2
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792691481; x=1793296281; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VXuE27163XQs95Y17MHXQoRtZevE9c0I3KUjJaU7M5M=;
        b=rhOaAi2cGCAjHoc6KXmahWbKa7F3QQ+QJR8WC1bdWHlGozPi8DPra0ZKH9CYgsZRVD
         6O/5e3Fo3dePdi2XPISLDobwfggC+FYlUUHTWRIP2E5/NAOdVFXLytBHjOgBGRGaExeL
         Hls20/HxZyCFK/zFWe1WE2F4cT8X0qKNeNWLnIhTcN1m0ZoyKqmrng+wLgm+U5ZebzPA
         6HzB03P0zUI2LSpYIvSgiWL9tJ9vhiABavkDIimU3Vf2oKqqESmgc9RNnIGuJe/zI1dn
         +ValRDJkWofgwPRcNxPEEOyur62We7ImYLpmXZovZVf0qwK9fi0vocoD7kRmhh33Uhh+
         PwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691481; x=1793296281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VXuE27163XQs95Y17MHXQoRtZevE9c0I3KUjJaU7M5M=;
        b=d/hU3Bb7BFcPc8VG6FaAK/INiAJP/ln585kOqEF9dsdyGtJFS1ZqTzF5lWNyv3XHE2
         danhjthYEl/E4TxCu+uCQmwT72OQFVejT+sLWgWqCY3nIlU0SelD4dPazZZkAKOvTrOP
         ZHr3smjBobz5yIBQd7gJvJXQ7osTnvnTBcQ3gnU270Tq3Tq7y47vZmKhm1D6Mj8UbQWQ
         hrz9NXq0Rr74mpSaAhtYQbW/nR6i1TVP/ufMUa4RlQ7doVtJyk/chqMxPAaQ+ehLuhHy
         TDaIWOEF9dvQ7XfyXLh3CXo0Gt8sJW6evwRiL+JovFw0QnpI1isVDJDQQI35Nl43TPfg
         1FCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpb1YF/z2S4QVJD45OzkV6fKxvn940Tjy/b+KTeyyZGNUNuOSXxW3xAiweNcJlT2dvPAqmWQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKEt8N7YIYL4qCIW7o3dR89IyRw5ppVKF9Y9+XGHeUhgAWoaf+e
	2uxVl8yXDdwPRulzS4whqVQBkwfhfR15JKHDOz6bTakXqBQnHtPO+A7x12mDra/NLw==
X-Gm-Gg: AYBFou3hz1dwQROKtJh3tt869E9Kg6JNg29jk/jAx87YnoGWGbB7xOtWgoQvgane41h
	Q1+1qVD5vOBp99DcVmYE2n21ByKgMIVWmMJoHGaryZ8qLCQYfvoIqefsx3Ondtt6wsD5Tevx6Ci
	btqmQqonLV/6Ou6Vop1mX9mdG+mekb0NoaCv4LntoZa5X+B2NhyFZQpZTO7RkkZYA5vlq5TclM0
	T9zt5hGo56p/RhYGlrfHfktHfwEDlxYgKUGphW3HcKzjDFHpVUFVFN73cAh6OEKwU6/kkq87rPw
	sf+1ae3AME9Te9p5aCNlaDyV+3ZK8uOH+ndAshhzO9//2avSXCzptH01QGkzV8K1/BoC56hQGv+
	lB1Vi1LYWR6BUGd0OvM0FpJ02J1rZ9wFawr9qYzL+lZjdmac8RnPbGlTcQKPA6QE3zWAAwyUizT
	2koh0BFbeYDD2/V/3GeAYuCFOy/J65NHU1bcwM9yO9D6g4LdPTYhHqCfLrpSjjBwArMHCXIS/An
	jtLa4CKuYHOb8aJSxAjDTYJ/deGEF+XP7FmSoW2k4ZzrApaYTVJ09h2HXU2ZyUGDONffwkizSRe
	LadKtlNOEokGF8lN
X-Received: by 2002:a17:902:e547:b0:2e9:502a:ddbb with SMTP id d9443c01a7336-2ea43c9f6bcmr53298445ad.45.1792691480085;
        Thu, 22 Oct 2026 10:51:20 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b346c43sm1644745ad.13.2026.10.22.10.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:51:19 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:51:16 +0000
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
Message-ID: <atpNFEFIlqAoYIwH@google.com>
References: <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com>
 <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com>
 <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
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
In-Reply-To: <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>

On 2026-10-22 12:11 AM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 11:53 PM David Matlack <dmatlack@google.com> wrote:

> > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count, payload_type) \
> > >     struct name {                                                           \
> > >         __u32 size;                                                         \
> > >         __u32 flags;                                                        \
> > >         __u64 ext_flags[ext_flags_count];                                   \
> > >         payload_type payload;                                               \
> > >     };                                                                      \
> > >     static_assert(sizeof(struct name) == (expected_size),                   \
> > >                   "LUO struct " #name " size mismatch!")
> > >
> > > For example:
> > >
> > > struct luo_memfd_payload {
> > >     __u64 pos;
> > >     __u64 size;
> > > };
> > >
> > > DECLARE_LUO_SER(luo_memfd_ser, 24, 0, struct luo_memfd_payload);
> >
> > This looks pretty reasonable but I would name the payload
> > luo_memfd_ser. The combined struct that DECLARE_LUO_SER() creates
> > should never be used directly since the offset of the payload in that
> > struct is only valid in the current kernel. So I would give that
> > struct a special name that makes it obvious you shouldn't be using it.
> 
> Lets drop the fourth macro argument and generate the combined struct name:
> 
> #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)              \
>     struct name##_hdr {                                                    \
>         __u32 size;                                                        \
>         __u32 flags;                                                       \
>         __u64 ext_flags[ext_flags_count];                                  \
>         struct name payload;                                               \
>     };                                                                     \
>     static_assert(sizeof(struct name##_hdr) == (expected_size),            \
>                   "LUO struct " #name " size mismatch!")
> 
> For example:
> 
> struct luo_memfd_ser {
>     __u64 pos;
>     __u64 size;
> };
> 
> DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);

I think we are getting close, bu I have two remaining concerns:

 * Reserving bits in each flags word for continuation leaves gaps
   in the flag space that users have to know to skip.

 * struct name##_hdr only matches structs written by the current kernel
   (in terms of length of array and offset of payload).

How about this instead:

struct luo_ser_hdr {
    __u32 size;        /* Size of header + payload in bytes */
    __u32 nr_flags;    /* Number of features encoded in flags[] */
    __u64 flags[];
};

Each feature occupies 2 bits of flags[], so feature N is always bits
[2N+1:2N] of flags[N / 32], with no gaps:

  00: Feature not present
  01: Feature present, safe to ignore if not supported
  11: Feature present, must be supported by the next kernel
  10: Invalid

The length of flags[] and the header size are computed directly rather
than by walking continuation bits:

static inline u32 luo_ser_nr_flag_words(const struct luo_ser_hdr *hdr)
{
    return DIV_ROUND_UP(hdr->nr_flags, 32);
}

static inline size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr)
{
    return struct_size(hdr, flags, luo_ser_nr_flag_words(hdr));
}

static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
{
    return (void *)hdr + luo_ser_hdr_size(hdr);
}

and bounds checking is just luo_ser_hdr_size(hdr) <= hdr->size. The
payload is always 8-byte aligned.

Payload structs are then declared on their own, with no header:

struct luo_memfd_ser {
    __u64 pos;
    __u64 size;
};
LUO_SER_ASSERT_SIZE(luo_memfd_ser, 16);

The static_assert covers the payload to catch embedded structs changing
size.  Asserting the header doesn't add anything since its size varies
by kernel. And because flags[] is a flexible array, the header can't be
embedded in front of a payload in a combined struct; it can only be
reached through luo_ser_payload().

I think the only downside is that the header increases to 16-bytes when
there is at least 1 flag. But I don't think we need to be so concerned
about an 8 byte difference...
