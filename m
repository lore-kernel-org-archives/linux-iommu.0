Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793697274;
	b=d69f9jbCyxmzlinK65cPscgLzGR0uOwFFo8PLfTGfqQDKmDz5fiZZnRdp8QnwMIQHNgZ
	 nern+UypFRvWf2eqwZYTP2qTpjH71zsy7/8XptDrl7h8hGzVgH5XKf5yP8NVJx0oLlqVZ
	 DjoJrUs6u7uNwFXkm+CtdrUdeNiyA04qEBGLdRpHfDp4CwjDWkk4q8pDAHVeC7MfK39k2
	 kQrXFZaaABvR48Qke5//CRrZubY33/WAcwlo+YaupQa8jLHd1zFJWhlPyH+cUBU1eq/LO
	 5Bnyd1J9VzYY6qXiWboy+EpazpxL6R6voHp3L8VfePVKlqvdXgrx8tYm6vwfa3+DVvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i14dmH5BR+9SimyzQMrEk5iidp8zGrGHl7mp1tLTg74=;
	b=Hns5YjB+veOvht1qsTgJBaOZnRUR0vcvboLnaJArOYO8VARjZNcSicWOY5jZRTZU4iUf
	 FhRWAdviZgguYR4fwZGi6RPGHB8FU72GxN1ww7FpwhMbHR3cQeb6Y3IaU82BUNtwlTmax
	 +L9rlIB6mDLpGFjoZCBohI717hps8zgwYBhkDeQOR22mUSaPdzyv3Mo9EonibOgU7P435
	 Am5I4RnJhez+cGnMUTfOZ+M30ZGlo+jYtm6dmfSRRaOHs2v4FfVLwx9kxsDZ/L32l8pvb
	 sEvTNV81PO606o4usdCSCcUNGmFClsjbVvhFzXL+T4Y9q5G+LiQNA3sKiTBGLBJikJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UWtsNxlF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E79D606A336
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 09:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E79D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UWtsNxlF
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-54492d8a988so203961cf.0
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 01:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793697273; cv=none;
        d=google.com; s=arc-20260327;
        b=SKR62f2G1JNYFHLjXbmCyWarjvXpgzT6Vdyh+/Stzzbttd/OKZFDeePq+F51gHiRHF
         sZCaOK23xesriyP3Yz0ERxMFd+RT38bCGYWdP5KhwztU7gmm9oaEHdzlhHWDa3EoegOy
         FLjHPYCAJKkPkiRtb7SJuBsSW7lcVl7wNywH2GTLf7WLheBX0QlQ3VL1Ck0jTxQ5em3z
         rCXDFTNz8I+Qv/jeriAMIaP5uwqSFg6MwZf+ELOO1N+5v3MZbme6/kEN2dhilValu7+Y
         YNPIWMDopEoa0NxbEDUoFlRcXc/9ZBINWcYHAZBQB7yOs9Rw6cC25JuBVoyqRLCpuTcc
         pebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i14dmH5BR+9SimyzQMrEk5iidp8zGrGHl7mp1tLTg74=;
        fh=8Mb9hToxFUou3bOIG0COYbeKFXstf7oU3oOTq7B/zbE=;
        b=DovCrCM4weh141uIF4CV/YXVtpxcoIQ5fwoYI54ql4UeueCd8RFAl/bOP2BGcAfG7p
         JQyNLmMmrSDrVZT4VMqKR0QUfXo0slB4hV8e4PkVnf1pdKItJt0FYfD52mYAI6J2TjfU
         QTT/lMQMSJ+LzDgRGnzkbh6Jt6UJZdD1EHGQ1H9X30fm6RDNs4t7uh9MXo2I8DRJBJXh
         JGFjcfl4rmU8iPDKnj2t16lZV4EutlsThxbcNfJmM19ozu8w2LTweEA4WaUEw91wKdSI
         7MzmohM5BaTGz2Xga2epNCtgqzYniNHyYwdF6GnxvAzEJMMryyoJGQo+nQSNJqD6iaHY
         1Ylw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793697273; x=1794302073; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i14dmH5BR+9SimyzQMrEk5iidp8zGrGHl7mp1tLTg74=;
        b=UWtsNxlFdsDVZeJNt4xNwoT8N1zA9gB6+AXCml4JSJpObFQD6ThzDrh+WYT8f/HuWr
         va1jROxT7dXmwUnZDuWkyJERPa3SCwjznkpxGtYmNR6ZH1LBlZuqiazhtqPx2qZyUFZw
         CAWU1dhaWbie8DomaKgAEasTdtXnMIqEba1b0sZytBD4okBaSY6SSyFXuTdFt4GhgBbO
         XXop+UBewOCmHvxSVga3FSzquANdKltiodZq3Tn7j/lcLQYhXiorpO4LLI4KFLajrkNn
         bk4vzrROX6bM6yhc5lf8n3mK59si3fLYKws81xA59X+uveqhGoSYKOO4tpuYnLTk9nj7
         gTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697273; x=1794302073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i14dmH5BR+9SimyzQMrEk5iidp8zGrGHl7mp1tLTg74=;
        b=DoqD3xJvt58F+Nd5MggEgghUn3mLBw4C/Y4jJ9Zeu+ZH/5DMVv5ClfrvHWSjpvXhnr
         0FcSkwI15Z171iWJSS93OOjZmpIms701brTBnzXHvXUlkkQJM8duppeaTf15lZOQzLWq
         b/j7wpQw3LCQaGSkUVoZfyuCNv2mhRAadBCS2ARDnLNQrjk6hdaGOyT0+REhxAvTnEcM
         NLqNcdus50YRpONyNjFtTZCzMoyE3fszo4VzkU89w4uIo0QDR7SYUbZW7fukK1g4HQZs
         YMYqp6ToL8sdix9Hh0CHE1q0EBQxyuQR1L0TNk8WQNRJonYvjKECJmL/2IscYvePfO9Q
         F/2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzXriKNA4G71iaY2H7GentCtc4HtCE43Lh26JPaBOeH7saQya6WOcYstnJX7WcfgDkUprNTlg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+HYhL20A8Xd+3poEPOs6w1J2z4mYkgmKEideno7DOB6qLv6K/v
	XBWDjW2J2vBUrjGz+SKAsFuw8C84mOTGkDmVLGR2Pe9xzdsPHt0DVhXS4uzetlx3ShCoeizow9a
	zsbzFeZMkmBUOIuEldnHzZIKv8u3VOMRfpZs7QsZ9
X-Gm-Gg: AYBFou0oXRuypNQrwQ3FKBjFiPspyQ8oIx5QbTgWTizPHDyCqT3ye3L8HoY+UylhUPt
	/H3PHmcUapH9UMcELWHMXmwNfbn+JwNG9LgiKomundCtyZKjJ2zpuig0wmLp63nb3aPhdusjLs1
	cdI3bV8NKfUcA5RbZFCNirnbnGJPZWRZoqfwt0K9h2Y3tg13D+BAUyScE1in+7aiMqu/OfROHYC
	q92G1xRJNTiXeJdCsjRyToE2z3wsqvcTuwjfoPQcJOnzbDYbK1xzIOhqDpMl1f5oXM5WY0W1hNV
	o5UOzii4IQaMThEyTLuW50Pf8yw035WKvz6R/3QcXsg3pLLgrlQ1E5sO0aCBKFnH6d0l8cUduUN
	cvbuko4bgU8tWQ9IhDpwNhP60uh6SQhDWBiiS7P5dEaa8EaNIduQHzX9PKKA=
X-Received: by 2002:a05:622a:598b:b0:535:84ef:2e26 with SMTP id
 d75a77b69052e-549dfce05fdmr11810771cf.7.1793697272817; Tue, 03 Nov 2026
 01:14:32 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de>
In-Reply-To: <20261103080933.GA4213@lst.de>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 3 Nov 2026 10:13:56 +0100
X-Gm-Features: AclHuK_l2TEIEs7qqznKn-9_c2yONWQ9t4tXrp8CyyoGHrPwnIyHLaBfgdlxlp4
Message-ID: <CAMOZA0+Fhq0_Pm02xGWpex06vb2y5pVzuFxOk=URZB7aq0xJ5A@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:09=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Fri, Oct 23, 2026 at 11:50:23AM -0300, Jason Gunthorpe wrote:
> > > Disk I/O is still potentially affected by the same problems
> > > (cost if io mapping/unmapping, iotlb thrashing, bounce buffers
> > > in confidential computing...)
> >
> > The disk folks already have a proposal to address all of this using
> > io_uring and preallocated buffers. I really doubt yet another version
> > is going to be interesting there.
>
> Huh?  If you mean the dma-buf I/O it doesn't really have anything
> to do with disks, except that this is the first user.  The dma-buf
> iovec can work for every ->read_iter/->write_iter consumer, and
> should be adopted more broadly.  Including by networking instead of
> their own totally weird different world.

Christoph, is this the dma-buf series you are referring to ?
https://lore.kernel.org/all/cover.1791975048.git.asml.silence@gmail.com/

I am not claiming that my proposal is a good fit for disk or accelerator I/=
O,
but every subsystem has different constraints, so it is not unreasonable
that a proposal for (N)etwork and a proposal for (D)isk focus on the
different bottlenecks (still there can be learning from looking at the
other solution).

As an example, in networking we have to deal with the following:
- typically at least two buffers per packet (header+payload)
- often, very small fragments (1400-ish MTU plus crumbles from
  data in different buffers
- extremely high I/O rate with almost no spatial locality, which is an IOTL=
B
  killer and the main reason behind my proposal and some of its complexity.
- on tx no good way for the application to pre-reserve buffers
  (buffers are sliced from a 32K per-task block,
  going to possibly different destinations)

cheers
luigi
