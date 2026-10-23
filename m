Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792786997;
	b=PjBpTLbLuC6UrO7v93zB0wMI7JLTu5RZ/YNsT8jT+oba33q1/QA4NYB5RbhYHmZDD/0g
	 CS+Wg3I3BjlVbtfZJ6YZxr6vfFNYhzWw96M62DQaMsN7GxvBMjsAdvlxuQd3ZUnP7fl65
	 aSf27N7yQV463lX/xxk3f0hrAFeCFZK7Dssq/5ueT48e+qVnOlTcL/ypcVjITa9mnUUgT
	 9lcFGbs+i5porbUZjaqnaLwMY+NE3uwOvZxxMRAWZgXmNqs96Dz3ud6B3yIMJXcXomUuf
	 IdSDzEOJLl9pDZGyMPqUjr1Ao4vyZ9BwBtV5jI7NU5eIlaSwyMFBasCzqGsXVNV+n/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eVhNp0GGNRD3+5V43/lt1UQnV2SdTxNQyX5GFb3QiFw=;
	b=EPD9ulDi8IKMcIJ79g7J3B+D8LOQrr91carrpOKFimDHuz2yEiZwklODvqv0OXEvX/nM
	 lfVIoEQuXEsuWkXNgzHABuADG6fXOdblt2Vgk/ARELmAPaMFvNRr3b+979Dxl/RpouAAk
	 WuYbRBoB5o0xfrqZMI9fS5KPMrYi9qIppSg7VcEtR+gytyuV7odfcu03KhN8MILp9fqLe
	 8H7x6zQ9H+miMawKkFLVSXPNGQhxj5FRo3vis5iOcDy8IbAm/XZZh+YjI9wJ41fOt4kr8
	 AnmviupsG2Yi1CkOVUVJ0l1+lPgkZ1tvLNm0zH7bitgPn7s7EKKWI81sT8YL/C1rS5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LK2oSsZV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F6606A31E
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 20:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 967F6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LK2oSsZV
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2db33db4de9so14535ad.0
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 13:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792786996; cv=none;
        d=google.com; s=arc-20260327;
        b=r/qDy1AIE3apnh28ETKZpxKpZ4/woWU/7t14eUkDtdIQAJ64Urt4ueQ/BntsUUThFM
         ZPmk7Mh+0DnI2Mu21biZSys+vcsoU/8ixQM740+AldPnF0UtRriOkCQuwVA3rni/9Xo+
         /aJNGsPC6zJMscRr9ifXlUS2XDSatp7wX0BKs7i+uyQ5QLor+0V1gmHfo7TZg/aEOlJ1
         rUu/3V/kMNZXWfOCgqqIgGotOjnRowh2Q7lAZspX7S0OoUKgXYZ+6gOEMJWkm9sHkpy/
         Bq2IX1paBDnkyPHWd5j/CNfwDQ3WKxmt5p/9KKMJwJEEHEr/8rHaIVxDxU0cKbrYVesY
         9bQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVhNp0GGNRD3+5V43/lt1UQnV2SdTxNQyX5GFb3QiFw=;
        fh=OaVhI8kBYbsGvAMI4ZOiSrouE+rZCZxR1lOyqH9vl1I=;
        b=AVLKCbk/n2iXdVdrAcRgQ1j70H5oA8WuWEpW4L4QkLiG5SrWBjJ7bhAR8sfJtcisg7
         yhfshHnRiQ2LtBnUsiQxqf9agi6SMaZLiYgAkq0kF4Wd3Ru+fH0bqUHXLP7Ij7ymDaZ0
         Z04dll/PJxaG1Kjdqre0wqDHdiaJ+QX2zvdcc7BjZX0taFw8i8fEnYCKA4p46t0jz7Hn
         ZGN/dUll3mB2ulSe+Rp5gQR2fM5rJwsocbgLbguHsNVBSu6yZVXUFhDij7shHEiC6vlx
         7bvKo6YXO5IsiykqDlughKhvO/QdADtxeAt+RKyGbMLd6Ucv1eqnxZoM94oRUX1B23p3
         7xMg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792786996; x=1793391796; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVhNp0GGNRD3+5V43/lt1UQnV2SdTxNQyX5GFb3QiFw=;
        b=LK2oSsZV27a8k1q7bbaS69Lx0+57B8QGtpuBD7WgbJ8Kri0hMoEg+Eq3sDokNOssvK
         9a+i8cYMU+2WXJ7ZIpvozB8LdCUr5AwAZCdEG00vztWPkzEUic+IQxcruHkzA/r5W5YB
         c+Gqu/K6A9inPMLv2L6gtKaZP7BcxWqsYNo+vdtECDbjZWSy6A5bIizv233oNe49jc4C
         DIMQdfIiGJmST1hhFmTnZ8OBzutvobd1yC6ZbWCTzXwIcHRExv/gnZrjuXyLjsmq+gy5
         KfoVC7F3v+cY0NdUYD4YPH/s60GnYU6j4IeHDI95EcGHULd0VGaF/lyVjHDQRn3+ggqe
         pxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792786996; x=1793391796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVhNp0GGNRD3+5V43/lt1UQnV2SdTxNQyX5GFb3QiFw=;
        b=ZkFvTyzzOX6MK4TFEiq337bqGd6aSpGJ8eoOZXIsOl1yn/TPgK7lGlVDM7+l0IQh2j
         ehOwyRYihes6yJKJv1Zhuf/xjoeCu7TKHv9t8N9WwZiIdNQMby1iXOJio1bIeJMjVa47
         xJxIuIIsVK055gYd5wlxh+bMTTxeT9tvnJovSOhVLNlZcN7Xlne5X9e5fUooNZhU+eQj
         KqKhzoD0mizToO9qj4mFGt6wJBLERGORanEuV9ZgQ+5ZaciYe92lwWdEcGEz12BV9+6O
         BLxLRnhbmy3BaxoiV4ix23VPRvcPqA4ybpFdIQAQiNtivMEyJVW3fdtxhbpNHm8r9t1u
         Wb2Q==
X-Forwarded-Encrypted: i=1; AKwUvBx0e91P4LGFqq17QP1mvG/JaYnf5t+u/LFPdosbbVdr7Mm46bCG2qlsC9lJhaJ8nGWt4Nfx8g==@lists.linux.dev
X-Gm-Message-State: AFq9FYIL95K1looSl9S6rGO6P9W0WSVA4fqrh3qP0f13DHiyJLcC1+TG
	ABK5sR+leXA3qzltTRDgE+gsWe0caW6rUFyB37XdxKPZC9JbkZvKUifmVxiFyva45ce92Ik5Hej
	/SoWWdT+i24g4cSE/75+zGU1PnpR+NOFBWhVUl/Ym
X-Gm-Gg: AYBFou1zko5GJ+h7XNnn92LEcXx7/kuaiR6QLaJB6np1HfFoIGy0/LQZBWaMJbM3iT+
	Ce0kcG4Qgmcv3+yFoS+suH8FgGy6kk9QkNBJDCayXUvrTqq3o3aITXD/3ETHlt+kpLO7KbmL9V+
	CQoRFj11fcVREV7GLbS3CHD4JbG7v3LtBiabtaQ2O4OVLub7bZh0xiXYsAo1zb1HDS6FK7g0Gyp
	Zdjqdji+5uK0nyCv1eggzLuYgHH9IoTE3sqj2kDWfUWZub3yFNG8ItzuO4nM1aq7/S/ttnBI/bW
	Yq/GsUNZLTxv9mlbwdFjnwaUArDllSLACN3q5xmoogRTMnbgW6dvhZoUnZP9EwEcZJrpFex2SgR
	9xyEmpqixcCC9it08gIBYqV05L7qmycWM5oj6fA==
X-Received: by 2002:a17:903:3c6f:b0:2e5:4604:c37a with SMTP id
 d9443c01a7336-2ea9c34d519mr322665ad.18.1792786995276; Fri, 23 Oct 2026
 13:23:15 -0700 (PDT)
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
 <20261023145023.GH3977851@ziepe.ca> <20261023102756.201315d7@kernel.org>
In-Reply-To: <20261023102756.201315d7@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 23 Oct 2026 22:22:38 +0200
X-Gm-Features: AclHuK8d6JZsEGtM0KlZDv9ie7EsPXi4sNCVttMkACFig7Laogxgi1nYEIBjAsw
Message-ID: <CAMOZA0KZi1EkJaAFKfwOm8jo1ydyGh=W1RE0iMfte-ZQkOx9AA@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
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

On Fri, Oct 23, 2026 at 7:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 23 Oct 2026 11:50:23 -0300 Jason Gunthorpe wrote:
> > > Anyways, reading your next comments, are you suggesting that all
> > > these functionalities should be implemented as pagepool extensions?
> > > (2MB mappings and iommu backing, proper allocator of fragments out of=
 larger
> > > pages, device-less pagepools, multi-domain mappings, pagepool
> > > as memory provider for skb heads, pagepool as memory provider for des=
criptor
> > > rings ?)
> >
> > netdev shouldn't be touching iommu, it can get a 2M page and map it
> > using the normal DMA API. AFAIK there is not such a big reason to need
> > any of these layering violations. They just make it easier on page
> > pool..
>
> FWIW we're entirely happy on the netdev side to add this to page pool.
> In fact the initial RFC I posted for "page pool memory providers"
> was addressing this exact use case. I didn't push it forward due
> to low time and suspicion that IOMMU folks would prefer a more generic
> solution. Since then memory providers were pushed forward and merged
> for dmabuf, and we have netlink APIs to configure things. So adding
> large mappings should be SMOC.

Maybe technicalities, maybe not...

Getting a 2MB contiguous and aligned page is only the first step, and
the easy one.

Next we need to split it into 4K fragments that can be recycled
without waiting for the entire 512 of them to be returned.
This is not rocket science, but requires much more state
that what fits in the struct page, so that's another layer that needs
to be added to quickly access the state from the pfn.
Essentially my dma_pmd_meta (because I could not/did not want to/ use
fields in struct page to access ).
Doing it in pagepool could reuse some fields in
struct page to point to the metadata and simplify the implementation,
but maybe leave people unhappy because now something may
require an extra indirection.

Then there is a question of resource management: when 512 fragments
come out of a much larger page, deciding which one to recycle matters a lot=
.
Without a strategy, there is a significant risk of stranding a
lot of lightly used 2M pages that cannot be returned because some
fragments are in use.
Again no rocket science but that takes some compromises (sorting
based on usage ? periodically drain old pages ? etc) between
effectiveness, code complexity and runtime cost.

And then of course adapting to zero or many devices...

cheers
luigi
