Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862227;
	b=NRO+WrNZJuYeCxq5jhVEIXuB4bVuM4VW4tGsCk4PxYMTafh//2t9cWVuBEfCy1vAvRdo
	 +mk98cTwMRDKH1dmCwfIHo/QHGvVY3yBkcQqWKkfSxdpfrToqX+XURB5wyYs0d9VuaT26
	 JjlNlpA6bVsf75i5HQn9wFnFIIC8w5GqP1hBcBigjUJYcWz7KOPg+e0OfMZfmer4X6lAD
	 b+fjgJd1h5T5MNEu4C0KSc59+8osDvC+BZ8f2KSRNvRA0x5Nklc93bGy0dqx+bvCqS8yt
	 /pb1X+cjrqcYCqHY2qeReo4CVG3RckuyNcbAyXhMAfH/7abJpJ/MS+IHD73Wmq0BeMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=itpoRBF/1k6lXJt+7gBQZf0XsZd0eRgpwFhim4ck9gw=;
	b=diEFIolPyNSAIMWpVFcdsBjEOppt37tcJBobezONnDHoisBJq8hvYnyHbR5ZJEVGrlcL
	 TQaaDiLeOqT9DkJhR16+G+cNTAOsLy8OMte06mCHw6aoMVPjuPr9f8DfKG9QgbpDy3TSZ
	 rQi7LqnBAQY9WDo4u0SJrKWUoPhAUdaRPuAFRRRPD+Df230EbMPTUMMu4+g77yecCKyP/
	 kcmzRALbPs6ZELjOdO8p9EPCetymTtjPtzoAPGbY4tUTHNPnvEYnn//8QK+VQrL5yZ2EW
	 pys1HoLhWL2HL9RtNx0yurC7y+iFk5aS1XDUzuHl7mP7/8s6j9hu5TszlIfkF1WwPGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I1SAbXkh;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56646606A32A
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 20:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56646606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I1SAbXkh
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so2165891b3a.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794862226; x=1795467026; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=itpoRBF/1k6lXJt+7gBQZf0XsZd0eRgpwFhim4ck9gw=;
        b=I1SAbXkhpPS07sBmGG8r8a3UyPs5i1b/0e9pQSxsGFMfC3dJ0u1Y6fXpkQ61l8BBJx
         lHKXJUNR080lJYZnyEjKqFyFgJV07e3BIJi/AwLRSRfyyU1wQ+LIHOIwtCXlqurZcqod
         NAdeahwlv85a+/9Vz7Y1TMUYgdGj3wC9SG9yoy/1uW6+0x1qbXTb1qW5GFN5P9IL19aw
         3To6Pb1tUTYWocDWxX+A3V+3e41t1qeFRfaYnnqZCcHakTKWw11CNNho+ujMsW/nxUz0
         2hmKsuZuGExu8oGrnoLhp/Ol2VXpCVcyzc+mSsvoN1RYs771PDwnKxnaV5909Ig8b6QW
         hCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862226; x=1795467026;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itpoRBF/1k6lXJt+7gBQZf0XsZd0eRgpwFhim4ck9gw=;
        b=cz28KRrPy+BKg9QClazC988YriaDEMlCsBW1hybOel1UibuOH8Z/2L+kdU6URcL2a2
         CCCddA6CQGzDDvtiLKQX715b08fMT5bf0gXt06fpVfEe8wJpyIwZ/Foh0OAA9AOFf92v
         Uk4djKGzAgVeN0TZ/hxxUrfgGNZFKWhL7ETr+O39LxQM3+Kw1wg1AchPf3Gqb9v33rk0
         sfvqJT0p/6pMuuvN7FwKbad1Yk/gCu+i7jCHTE0H7jIC+8B8UIDUEH9cL0biOJ6Yy4Te
         LWMho5NcuOo9AGHmKc6J92E+XQGYsU5GSENFr6Bk37ONihIrZbVbzVRYS72sQoLR6Nut
         neCg==
X-Forwarded-Encrypted: i=1; AL+hErGdNgWVsFkGg0aG0qWBD1NrqSwJVwh0cJPEKzqvLP9H3Z3rJ771dAtKzX/rsqGqEYgMWB67uw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+sL/xW6t5qqHizaEBVE7htp0ZjtA9nXvzMW5XZXJIakJIyWTUG
	6MjqwxrzSXj3jLlnMEx9IruUZLMPq1LA1XsYlUhs6v9JhFBxdu9KjhWTZwFtnBXJmA==
X-Gm-Gg: AYBFou1C4LXhh/GAtu+IgYeVBEIdaEcptoQEGGI6vd9Psi0V4nPxGcQHB2NCmEQs87X
	QjfMZCXg4Tyng3B/FB2pRrfA8CiBmL+oadsqQBBfm1u+symg+DlfkFeAfIZMW/OTf1vCRvxqiqf
	tmZQ21kec4EU5yl/SXOh53PHsubv50QrLefDptHRSnIwzFduwNfXDB/HQwZCkkpcSl813WtrTik
	PnmBY0wO6+Joi2v1MYfgwBxVG3cBqz8t8BPJrXB4ewk4zz7ZWeui2MR6hx9zuJ7SeKusanycrWI
	3iDioJY1vDvSbawAYAJDKrN1FaAAt9DlNgBqLTd0sLkhPk7twkWxEhmiLtHnFTJU+gkyzltqvh2
	S8C2HmPC/rvUz8PgBaEjAUfbfRLRtDQ7EbHaTe2JLtJ3UFPOGyre+KvvOgeT3IDuigNdsullJ0M
	V1ZLMxeOzuReusBqQ7ThDkn5hWgllu2TYNGql4wTp8eW2TtoPva0ma6kV1mFWEGR24Zp+mQVL4h
	7trcu5eHn7j8bpKfDnhrtxhkeeo8V7vr+qXPyP/qk7oJV1tNR0HygpD7FwsdPVvCP63VrZwWaOW
	3zVcN2kUaAm5jgZ1yScrhBe8jvUiFecxTXgqLg2Oenz5f3rrnt9bFIyuIR65eMeB
X-Received: by 2002:a05:6a20:ef03:b0:3e2:4350:1528 with SMTP id adf61e73a8af0-3f7a51ba2ffmr9092719637.7.1794862225898;
        Mon, 16 Nov 2026 12:50:25 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18c847asm4527944a12.28.2026.11.16.12.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 12:50:25 -0800 (PST)
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
Date: Mon, 16 Nov 2026 12:50:24 -0800
Message-Id: <DMWXK2VTL3XP.MWW7ZG7Z6HUF@google.com>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Alex Mastro" <amastro@fb.com>,
 <dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>,
 <kvm@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Josh Hilke"
 <jrhilke@google.com>, "Kevin Tian" <kevin.tian@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Logan Gunthorpe" <logang@deltatee.com>,
 "Matt Evans" <mattev@meta.com>, "Matt Evans" <matt@ozlabs.org>, "Mina
 Almasry" <almasrymina@google.com>, "Shuah Khan" <shuah@kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, "Vipin Sharma" <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
From: "David Matlack" <dmatlack@google.com>
To: "Samiullah Khawaja" <skhawaja@google.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
 <20261115231946.GB1239159@nvidia.com>
 <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
 <avtI--OIZu5E5sma@google.com>
In-Reply-To: <avtI--OIZu5E5sma@google.com>

On Mon Nov 16, 2026 at 10:24 AM PST, Samiullah Khawaja wrote:
> On Mon, Nov 16, 2026 at 10:02:56AM -0800, David Matlack wrote:
>>Looks like GPUs and NVMe can do both as well.
>
> AFAIU the memory BARs for GPUs would need initialization. The internal
> VRAM needs to be exposed (mapped) to the BARs.
>
> Do you think we should have a P2P device "setup" step that can be
> implemented for various types of devices?

Yes, I think we need something like that.

I've been prototyping a new optional op in struct vfio_pci_driver_ops:

  /*
   * Set up a range of device memory, accessible through a BAR,
   * that other devices can target with P2P DMA and that the CPU
   * can access through mem_bar->vaddr.
   */
  int (*mem_bar_setup)(struct vfio_pci_device *device, u64 min_size,
                       struct vfio_pci_mem_bar *mem_bar);

vfio_pci_find_mem_bar() falls back to calling it when the device does
not match any entry in mem_bar_descs[], sanity checks the returned
range, and then runs the existing memory verification on it.
mem_bar_descs[] stays around for devices like pci-testdev that need no
setup.

For NVIDIA GPUs, I had an LLM work on it and the setup was simpler than
I expected, at least on Blackwell. BAR1 comes out of reset in physical
mode, where BAR1 offset N maps directly to VRAM physical address N
without going through the GPU MMU. The LLM confirmed this on by writing
VRAM through BAR1 and reading it back through the BAR0 PRAMIN window
(and vice versa) at offsets from 256MiB up to 178GiB.

The nv_falcon implementation only has to:

  - Wait for FSP to finish booting, which takes a few seconds after the
    reset VFIO does when the device is opened.
  - Make sure BAR1 is in physical mode.
  - Return the range of BAR1 that maps VRAM (the size comes from
    NV_USABLE_FB_SIZE_IN_MB), staying clear of firmware reservations at
    either end.

With that the P2P test passes with a ConnectX-7 (mlx5 driver) as the
initiator and B200 VRAM as the target.

A couple of open questions:

 1. The prototype allows .mem_bar_setup() to be called before .init().
    That is enough for GPUs, but as Jason described, mlx5 device memory
    has to be allocated from firmware, which needs the command interface
    and therefore init(). Supporting mlx5 as a target would mean running
    .mem_bar_setup() after .init().

 2. nv_falcon does not support Falcon DMA on Blackwell yet, so a B200
    can only be a target for now. That requires a driver to be able to
    probe a device that cannot do memcpy. I am not sure I want to go
    down that road.
