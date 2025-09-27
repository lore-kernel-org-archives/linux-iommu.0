Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D122F74D
	for <iommu@lists.linux.dev>; Sat, 27 Sep 2025 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759000830; cv=none; b=iHXVTNke54Z/bdUJcAUxKVMYj1Usae6Nuj68X6EyHr46g7PD1uyhrFcPSahIUzCQkvEGRdB8YGcR+VGiDT+Nvzgdt/kai4sFWVmodhtC06auariKPGjjIKSJC/fA5Oe3zxBaeIPccWY/X9lktoLF12no/vfd1yvfMwwgaanVS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759000830; c=relaxed/simple;
	bh=yoeBWfsz0Rxzfbgk6BToAOC/vOnboIpPuqC1fyVrHZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWtWuK690bAWFh8DOIVPUcK8Gqs7Ysdv/Onm+ufl2QAVy+UkFGnQzSgqqWkwkfQ8DNbTxefKHjiShfkMxDmYkMsM3/xuxDM40kA5T+XqfMtt5XOjen0wDsxl2FyaamJb0hUPpDGdiPPtwosZ1SuJGMhFo9ADk+16aF0REhe7WOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9nLzb8u; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9nLzb8u"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63486ff378cso6468614a12.0
        for <iommu@lists.linux.dev>; Sat, 27 Sep 2025 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759000827; x=1759605627; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpNpqT8E7PV/s4bEDWlZ98/qvJvoxkZccIvsTmWeJBY=;
        b=k9nLzb8uBtd2WTBCT8JVDS6nuyfeFR6a3C3WmkkxceeCLNvDgiRGvdLsXVHWfrLOOD
         NPTMQayHZtsMe4c1IjLNRfXQH3OFUxWsEYxsMu14jAyXhbjHeSoPyEuEM2WiHxc3gU2q
         8KxmwUnRV+LKsza4t2kIoqVHHqTqS3bR64a+tuqq0kwjYMdgQ9CQGjdYdEu3TjMYaqKY
         204w7d7U+dpEnirUeKpLO+3so+xPfYhik3bIU70/9j1k6jwOP8e7g8IVMQG414i4VKcj
         TVkdBds7GKbJl1SxUKDgN7sf5yqY2BXzX5b64N+Wc5W90aT8fgHbNkdLJcggalK7Np+c
         a8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759000827; x=1759605627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpNpqT8E7PV/s4bEDWlZ98/qvJvoxkZccIvsTmWeJBY=;
        b=b9Ib830ePTuKQcfOx/6abLk9zbXkNYSkhspjkf03foX3pVTNWiKdkcipsWmpGoEgEv
         GBtGBFNDGphPynWilEFDOlKPceguqQYxOu6ssdj+xZz3RBPRi+XYP7kivNkjGNVglw+1
         mjjR87+nib2Q44b0FikQYrNqlM492shigmdvAyWdIYrIdG62Eph2Z+Nd9AB/jVYWYft1
         JWZdxjfgjrvjVRR9q+KzQG0Z3J/I2GNaJGyUTtC3PKCy4+yoRQ5KJe6JOTcKzRYZUvFN
         lL8uNpEYZTp5bTktVqEWVquS4xQvU9eNOuwMz3562c27JyPqnrGD0xpRHvvpKpeMr0ig
         jesg==
X-Forwarded-Encrypted: i=1; AJvYcCXTEYMqMGzP6DhgHY5Z3g+2hYKRxSh0zSMjhyrY9XvwmbAUwzJOe0xR6b9rzQgM5iGHrM//HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzh5fXkh+CI887C/NjW2mO6UwBE+9ceQlm767vVpXb6EhMjdWs4
	VpVRop0KxslUClyu4eXGjwuv6HoB/epdpQsZ6lRmnRZ6OLZ4HsiD6Rj5g2h8daijxm7tGPTkGXc
	ZoVoWdGRcNmnc2Oaj13daOtfl4G4GIlc=
X-Gm-Gg: ASbGncsqC5SP1/Xv/+EgToSrUpDMTNKYMAYUv36gs0ZFyCgyVPNXlfJgKnBw/PsWTdN
	cLHC1mPGaezk/xuXMu8lCt+o1PYv0eHmW8jQy2fPyTw4HPgsi6xLINeC4lWkO7pBYk/SIkCgsFF
	KPb61/We8JdvcLfx4l6VGRsE3sQ3iMJ3kzPDiqkOOnAcj5m0aR85rpWWlI8KjbET+dKeMqabaTc
	/iqiic3nl4HY7nAjyo=
X-Google-Smtp-Source: AGHT+IE6MMpG/TRiFXxnrxz1Vvo3fuH5ytNgtdVEgpXL0NxXawEVfUDFtb+tMcdRPN344hi95Su67MTI32H6Ub9xTJM=
X-Received: by 2002:a17:907:7b8b:b0:b3c:5f99:dac7 with SMTP id
 a640c23a62f3a-b3c5fa9674amr74488566b.21.1759000826450; Sat, 27 Sep 2025
 12:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
 <20250923171819.GM10800@unreal> <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
 <20250923235318.GD2617119@nvidia.com> <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
In-Reply-To: <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 27 Sep 2025 21:20:15 +0200
X-Gm-Features: AS18NWCUkmopfgQP7FxvlAuimXjc1tmQlQb-89CTajXeb-5Nlye2dR2BnBQqzEg
Message-ID: <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

> > Suggest testing the same branch with the alpha patch reverted just to
> > rule out any issue in the core code. If it reproduces suggest to
> > bisect Leon's branch.

Hi again, I've booted up the ES40 again with the kernel build from Leons
branch, it boots up but message log is full off messages like
"EXT4-fs error (device sda4): ext4_find_extent:939: inode
#16257327: comm init: pblk 65114257 bad header/extent:
invalid magic"

The filesystem is broken after just booting with the kernel.
This time fsck did not fix it, I needed to re-install gentoo stage3.
So it's for sure reproducible as well as destructive.  It's not possible to
revert all the commits individually, since this will leave the source tree
in a state where the kernel doesn't build. I've started off by reverting
the following commits:

e78a9d72517a88faa6f16dab4d1c6f966ed378ae
(dma-mapping: remove unused map_page callback)

d459e3b80ad1c81bf596d63d2e3347cf8c7bb0d9
(alpha: Convert mapping routine to rely on physical address)

3cd47242d513050d7a81ac6e7020fd3ef5462ad4
(block-dma: properly take MMIO path)

7950995bef32aa7e5f74699c7d0fdac41d2dad14
 (block-dma: migrate to dma_map_phys instead of map_page)


After reverting the above commits, I'm able to build a working kernel,
that is, no filesystem corruption occurs. I'll take a closer look at this
after the weekend.

Regards

Magnus
