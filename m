Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795033692;
	b=cbMJfoBiEDaoe7F85efSzzIDpzghIeppS5bTE5tW+v0dMA+urz/w5OfpdPxDuVq1h4S+
	 TZxOzGxVJyOPR/1wQ+gap9G3H1vSBK8vw2gdP8nSGIf/yCZ5vxMQsFI/HVoHD32M4ckLb
	 TxeRZEh49vdkD/D82gO28HHVLxrt0nDD994HBAkUTpAbabSWj5WnwRa64uTMkq8Wapyph
	 7Bz4GH4laNwt8zxoWrXroOQL0awSRqKqKAEMXdu7u0gRIVhLNerJteBbYmVQdTh8c1Emn
	 ppr8liR1rZl0ABhymCPmahbsHEnesU/aZ/OGWrrD5VU5RX8Zow9gieWzHxl6gwUZLrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=z+AogC8EDUSE3HLZ3UU4rCjeQfZxM4jvNiwuUF4qq2o=;
	b=DjMpPpGhOTBqwLC7N8Ia/ap6lDtoLtjjc9W6JQhYLtikaRQ18Ywx2nEzf8wbhkBU5HNx
	 +5ZlijY2eaCTDoQKqdDzQP2g2waJoZ92CuQFQ6RYX34/ZrFGAZ3j7W5wKC/J7DA0GAB3H
	 noe8pSkj2GD0h+gNnxX2keoh3w34uTT2D/8XBdTJtsh0bT3AizGQPZU2Hopkvpl86IBWE
	 MRmLDyfZpPnxvTBqewfZ+PtPJt7BHAmmrA/XCx3pQ8XYxx9W4BTogSt/oovmcSaGhHYjv
	 YP7SG5d4BtHq5LZ5bRC8z7oSTrQQ7qjuqR44SzAnXHWXbY86Kk91iGLvS+w19oDMyow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LsYEIm4w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB6606A332
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 20:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAAB6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LsYEIm4w
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55c7445cf85so2621cf.1
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 12:28:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795033691; cv=none;
        d=google.com; s=arc-20260327;
        b=SyXAgTrEdTIiw6Go1HdDsPtUvAbNCKRabBTSMIqxOCVF18KwtjUX6o1J9IEgqcmoPA
         +A9+JKBHj/jR4DB01au6rh12aNJ5TWn2l6RiH+AwdPzOwiGgiQYDK5XENHbffU7qLqeE
         9qWLE5vB0KVdUh21WP+AEOC41vgkjuPv9UIFfXrrl6FKcv7k292vd3jLRn7RS/t+ta6f
         WbOEaRENmyqNjyZ9XXAnKmdonUwa1Z0GD0waWlql/CX8JQdCXrYrZweal25In9olxQvT
         UL/ydCzoejKTfvjobN5HDOylEQ86xDY2mPJIotC01WQlBbhY35Ovf51HJ9fX3W4nc87L
         XPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z+AogC8EDUSE3HLZ3UU4rCjeQfZxM4jvNiwuUF4qq2o=;
        fh=2nYczGkclDJzS8x+qu3PApO5E6TL36zQd9eGGXdqY+8=;
        b=rrJeUl9DBAN50a9DU4uO5YYOXKyZAXI6KR9x7DOIGO079yFBOB9kVBUcMN8BG7lllR
         7ofIYzGq8C+hrsxyL0RvAxN8HlEN3lZYIh6JxX/Ol+olXlvJZ9hqdVS+zaDauC7Fz1S2
         o8lqUSCXCLHXLG0iAT0OwnPxsKIX1eaSkWYpNYPwXhUr+C6rOI9uUPt9hbRjwIuSRAbQ
         jk8jFz8LIXIiB/GHauiqhg/MgYMJQz8N+xrFfYC4p/JKL4/j5+OEA7imdKJKCKoDD5fH
         8SREw9uu/EN2NNDocy7RpY9dy/0KQl+z1UCVnEKw/fvS+w+XKl7474Iy82k68eGGNrh3
         BuJw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795033691; x=1795638491; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z+AogC8EDUSE3HLZ3UU4rCjeQfZxM4jvNiwuUF4qq2o=;
        b=LsYEIm4wY4arYDoc39SPpJG3ioPsnFySsA4SpfDl15XFSg2DYNu/1POtSbGapk6433
         Eq21spNoFWGOdkwYJzafkxncH4NKi2gYDh63ii9g5RtRBaH+UVjHsw1erE96pMbB6PjG
         DBdfXaxJ2t19Lt7JKZS6Y5a9vTEn9ATVk2LIfBS9nsaonwAjxkKwAVz/iTemJxnQUodu
         9l8s+drbed80a79dUs3OjAmybH59sez1NIiAVt5Uu0uSKQ70dTYsaUSqOImsJqgNPdPj
         VYtHirAKahwRxfWy0z2KPA1IZzZdhzi+vAG/wHBQmiuy9YyERC1AZ4ZSqHOkr65H+kHh
         0Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795033691; x=1795638491;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+AogC8EDUSE3HLZ3UU4rCjeQfZxM4jvNiwuUF4qq2o=;
        b=2geDnQRDqJXaJTcEOjtRwEPlyQoUqido8QzgLrgwPo/QCZXMAbNX7NsNxcnfNhbN6Z
         Q4j9ghbyA5WJXEBTYDFHbf8vv3quSoerf3supwIp1YHDEpVIfPFJG/t+KFgdl+cd2aE/
         sqvUsSy09TFu6ENZwevHKgspTao36E0Okoe9oIF+xQQrH9BK4Gs3tpo1QEzer08vHR78
         Ef5QP++a6yPltcS1LV4TwbXTWHp8IaQ830w5Q2BPTfB3IYj20SrK1H/hNQt/1vzq2anC
         Sn++mqyfnbDqOpJRy4A6HNdHW7CkKHZQj10647F0MteKQIaiKr7jX1yx+tirOauaqdAf
         sN+g==
X-Gm-Message-State: APuU4Z/2P0NqC8CfgyKbKq7KxCAIP+BvyLNo9YCU4+8cUKLNW1Mi26UP
	eQGHUZmTahPiT0m28obaijQiqNj1WTzhk5OYq5CnTSBh7V6ZMDCp4vw1frXPA5cthK+bNFLx5D2
	uO8S3+51gUdV6dTKP3Cn2C4yy6xP5nCuNAJTaEbw4
X-Gm-Gg: AYBFou1G78N0G0hL2qbvuFa3Klpxw5rHhcTHq7g/4baR2eP4E2KL5V6HK8IE7sVcquN
	4Te6aMKXiOqRu1ROqc606Cs9HyyCrjCg9Yl1FBrMB3C3nVzGvdeHR8/1HUJjfFZl8zDDpF64+9z
	EvlfWPvnF7boW7/7dWCyjaywlxshujGAkCn0LNjglwBfdwTPy/ORa+nFCZDG6A14irTKMrx+MPI
	kQuEOvpgI/XWlGFK75y64XfXyV3aGf7/qdw3JjzooUKA9UfOOR+sAC/OL+rmghTj3jQKdaX+RM2
	t25ItEPG0+22jVr6tFxLZg/zI2qtDB3nyyBeJF/EXj3adDLPjtgZH0wJQZywJhzcwuoO7Gr+Cjw
	0W68vc5tPOzOdh/zZZ4fyINWjhZAeQxkzVemupgEAPpsBO7nkw8jwVk8=
X-Received: by 2002:a05:622a:4110:b0:55d:3243:574a with SMTP id
 d75a77b69052e-55d6962de96mr3088621cf.3.1795033689803; Wed, 18 Nov 2026
 12:28:09 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com> <20260929034510.2023173-12-praan@google.com>
 <asZSQRSYBjbUaaH0@willie-the-truck> <atXTtaxz0z-U-XSJ@google.com>
In-Reply-To: <atXTtaxz0z-U-XSJ@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 18 Nov 2026 12:27:58 -0800
X-Gm-Features: AclHuK_palFTYhnGqFKwt0cs6iRNA8xAzy9LxCS_GSW4lMdE4jAyePa6AgRLHZY
Message-ID: <CAE2F3rDd23TcWELEu0hNZiw+At==HZjZ=4KWGc-KPoZ4YiFxSg@mail.gmail.com>
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
To: Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	rafael@kernel.org, Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 1:24=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Oct 07, 2026 at 03:08:01PM +0100, Will Deacon wrote:
> > On Tue, Sep 29, 2026 at 03:45:05AM +0000, Pranjal Shrivastava wrote:
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/io=
mmu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > index deefb17e31eb..794b258550dd 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > @@ -394,6 +394,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx=
(unsigned int ssid)
> > >  #define CMDQ_ERR_CERROR_ATC_INV_IDX        3
> > >
> > >  #define CMDQ_PROD_OWNED_FLAG               Q_OVERFLOW_FLAG
> > > +#define CMDQ_PROD_STOP_FLAG                (1U << 30)
> >
> > I'm unsure about this. Bit 30 of the cmdq prod register is RES0, so it'=
s
> > plausible that the architecture allocates that bit for something in fut=
ure.
> > For example, if the index field was extended, then I think that would
> > cause problems for the driver.

Let's cross that bridge when we come to it. I think that for the
driver's internal llq.prod, we can deviate from the layout that the
architecture defines for SMMU_CMDQ_PROD, and as Pranjal pointed out,
we are already doing that. If the architecture eventually consumes the
current RES0 bits, we could save them in a separate variable and only
overlay them when writing to SMMU_CMDQ_PROD. If the index field is
extended, we could artificially limit the index width in this driver
or transition to a 64-bit type for llq.prod. Also, it appears unlikely
for the index field to be extended beyond 24 bits, because
SMMU_CMDQ_CONS allocates bits [30:24] for SMMU_CMDQ_CONS.ERR

> >
> > Do we have to put the stop flag in the producer value, or can it just b=
e
> > a flag elsewhere in memory?
> >
>
> Fair point, but the flag is SW-only, i.e. it's always stripped via
> CMDQ_PROD_IDX_MASK before anything reaches the HW and only ever tested
> via Q_STOP(). It's the same deal as CMDQ_PROD_OWNED_FLAG, which already
> uses bit 31 (also RES0 in SMMU_CMDQ_PROD, IHI0070 section 6.3.27) as a
> SW-only marker in llq.prod.
>
> Keeping it in prod is what makes the check + slot reservation atomic in
> the cmpxchg.. with a separate flag, a CPU could check it, then suspend
> sets it and samples the target, and the CPU would still reserve slots
> beyond that target.

I think that the suspend thread needs to ensure that potential users
of the command queue either (a) observe the stop flag (or some variant
of it) or (b) are accounted for such that the suspend thread can wait
for them to conclude their command queue operations. For this type of
synchronization, I believe we do need some variable that both the
suspend thread and the command queue users access with cmpxchg or a
similar operation. I guess that in some alternative design, we could
use a combination of refcount_inc_not_zero in the command queue user
threads and refcount_dec_if_one in the suspend thread, and I believe
one of Pranjal's earlier patches used a similar method. The beauty of
the current proposal is that we re-use existing synchronization
primitives and don't introduce any new variables that we need to
access using cmpxchg.
