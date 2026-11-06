Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793991715;
	b=I2+f1ES/A6XiANfeFB2T98Q139A6aRGGMgS324ZzuavlZemB0QuRwE0aZno8z134VO7B
	 U3bVgxPxaQxB6b+vnrMwg829t4AAY1C5EV494/ejXdx++3IPbmElHVmAgHud2f3QkPk0V
	 x9hcazdLHyZ7tSXB4noelV4wpSBzXCDMIUpoWQCWcukrWWrxSawu4cjC4xdn8VEn16pBz
	 feOZTDWmg+RhKuGemOA0dnvjjmzVInjOxU7fePKYeimUllCHstdiXuZ54Jik45wvSXCph
	 LQ3pGFNNZyKf/U9qAag0qrdc+ByvdzyLBmeC4i3rWaT0q4RJZ0Pb+H5Xqcvt8kww1dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cnari2EfkfcqWLrylXnWPpbFbNnmk3zqvy2a0yZnams=;
	b=e5pCIhH//QBmtSwS8NnmBZalvOBW531tq9pjTwWeEvxYneuSnKLHzD1z7wKS5HvGtSK/
	 b0XUozMN2ssXE1FuEcNNfptrIvg07J++hgLHWW+Pxw4OHrIlDXCTtMnLiZSlVkt+P1zgq
	 3MnqCCYhk3ME7/ODiP38QY7W/bnFW6DUutg5PJFtljQKeP+iWyMizUD2g8UNE0XDYjzKg
	 SuPhJCkVFLoOclNQ9HxkHWMFlM8YMK83hrdi11C98IYArjIPKDCthZnYp1nHdGMmL9Y+4
	 eNtWopaoI7Sl2sn5jF4TWzaX3rMSAbqyVSBVwsSDtMr7eVmROCAFBd8nBZLhduaD6pA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="NyAnr/nb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB3606A326
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 19:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CCB3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NyAnr/nb
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-535f598d126so31861cf.1
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 11:01:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793991713; cv=none;
        d=google.com; s=arc-20260327;
        b=e3SxrYTjn+F2OHKSB+g5EvCvFdiTPXCW3CpCvav5sPQp+0lYnTCtIvQad3Q9iS98IA
         m0S7ZUkGLju142j3oACLM8YuOeprJnu5CwGwo1SOo6EZocQzl2DcDfnQOlTSzS6/xW4K
         0Sj+fD2MGlzRygR5fvjVpSo8ZN58IB0/3agvK3BrYqiVtSAU1jMV8e7ImBHGBfHCaidp
         aA2uNXq4roPhsI0uKbWToO8nX895ycufjnAMtThBE48wnYn52qr8HJVwbUqHb4ZIMBrc
         0FmKJvErrX/accP9atxPKNnEo2rWd6TbQAXHTu97olKZget1iqzE+W7K7zUen+GV7F1y
         WmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cnari2EfkfcqWLrylXnWPpbFbNnmk3zqvy2a0yZnams=;
        fh=nE0cRcpZ9zJkxRop+1dYnXYvO+o0WpsDcmcBdsVlUYk=;
        b=qokbQfYiqlQciBOIDBUVXEg4Mxo3KgNgHbusPib5OQMgCzYW9T8KYFr1dvIgzHeHY9
         zKDUvivDAMsMVR/IfS/CxUAqR42DOiHYcMK8d9oL52VeIiW/xUI77wT5t3oK8yju4UKR
         kFf6cjeLBBqhSA3DPyMt5qPaCVZTyjT1RKJP2bXfo3/UhM1rdPpG1/I4881NIvIdmx9M
         +Lh8/T+JVMqMus0XignV/VwJc6G6mGrBSDwbwxFT1D0OaOQIrUbb/D9sfUDP4w6/3IrI
         BSR3OH2HvB7cYCISRL5GOR84WX4mk0fJbZQgYeXsVdZjCbnQJBw2iDHFBm53/jjBN0Kj
         BF5A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793991713; x=1794596513; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cnari2EfkfcqWLrylXnWPpbFbNnmk3zqvy2a0yZnams=;
        b=NyAnr/nb0fvf0D5D3Lziv4Ql17A5QgBZDZFBxu07/ggEkpSJpITilQmcVBt4GYH/w1
         6KXJElTMREH/RbQ1/mqXfl2AbFlol4eoy3Nrv4rE9Q9NhJz1jkDw2q11Vj8jGPhH60fi
         /nUKW4v9ce2B3ehsJOfYHuIovdafuT3/6LDxpELzX07S9iXiHqZgzzTfxIWpqUlGAfrL
         BC1bn9qAWdI23+4skVen0NYoyyWJPjQYE1VeD5fK8oosQgA7s2Fd7favTiwW9XJiQmNH
         TZkB/nwLqU9jaIk25Ztt0Q8cWPUY4LurCC6z+OgNaJR9KINIb/vcD4lzAI1h6kr7+ybK
         qTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991713; x=1794596513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnari2EfkfcqWLrylXnWPpbFbNnmk3zqvy2a0yZnams=;
        b=OYnebQRe0urEr93B22Px3CgQ4ipuH163r7dLDJns3b1NqsklPbnjM4xlTNuKkgcS8g
         lei5uyF0Erq7217gOJdg3/zK8N0xms854qR5H1n0bejxkAALN3bf7NNx+0p/BUjPli1a
         xQWleQF8rR4P2KUO+JKFaQxJVmHHEDBaJYwvAA73ck7jJz9tQyGoeU4zdjTsTI3YBZ9/
         8AIWw/qBOPRHHPYh8I4JRvUvRPCTlk0j/s99XlJDCRQtGx+JoK0UNRuhuzrxk4UTJX+z
         9YmMVFSgxJtY5McA3RsinA5q2lvpXsjfsE2Iibb0I8fjhxw7/LH9yN9Zu0dAQFTHIYkJ
         DHhg==
X-Forwarded-Encrypted: i=1; AKwUvBw8CUKEXxHuaLNNZFh0p/0PKkWQ2BTczJwcbNw0hcTxKVLpvMnrJjK+TUP91a1nWg4Bddl54g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/EjVwtFwsbkXTl2HRyt61uibmE7z3RByI3LxoudejghFGCVrQy
	lIifmy1M5Y41TvSZrm7mn2z4hoxYRGF3ftzXAmcGBhp7j9eGQbqEfj/eG69aFXPiKmemVsRC6o8
	loHt+/igzSzvLQHV9kUBx1Fa4eCNtCkaBQS3dSPz8
X-Gm-Gg: AYBFou1YvX9XMgwb9YSYALJLwmoC5INMQhT90GsFL9g8PevJ5JJ5Dj8NwPxQIfCeAO3
	qBX4qD/S03dLlNKykZWgTAWUpqXbLF+ABWVF0hv1FBOAebkoK/8tDFyMKiSYec5jt3xpz+FU90s
	3xDTPxLBAmIyWdGvXsNQ1UB6AIQu42HySKyI76Y+OIZ6LcXi2a+lpQTyE150yqpWr7YJKhl8sEI
	wlX9wUtxLK+fgCBPvqrrYDNi/WrGt16fXHdqDLnnoaHdmqgWVuqAeengA1WGly1VQaO9UL8FDt2
	R8dd6oJpEaV4PS3aX2CZgm6Y7hOAQyqbvaeOloQX2Nu8njsQjzzdyrAF8g43gjFnw2JiO/OHM7T
	Z77V80L7AzOov8wF3Dzoa7vV7Cuyui/Bc4ZxlzQ==
X-Received: by 2002:a05:622a:90c:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-54f5c235197mr4277431cf.5.1793991712760; Fri, 06 Nov 2026
 11:01:52 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca> <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca> <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
 <20261106180714.GI663069@ziepe.ca> <CAMP57yW6Y4g-xM9YTB+MpgxPN7RFeEWhAPWvqrfOoMDEuL8HZA@mail.gmail.com>
 <20261106184346.GJ663069@ziepe.ca>
In-Reply-To: <20261106184346.GJ663069@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 6 Nov 2026 20:01:14 +0100
X-Gm-Features: AclHuK8RLl1nJ3Ebb-rbtl0GPWPY_LeKIqNGDlWDxF7jQ269eiN5kMKC-Dmlr_c
Message-ID: <CAMOZA0L3c0zWvvVF9btAxQSox_hQTZP6W1sK0vgYPQ2OMJtS8Q@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Naman Gulati <namangulati@google.com>, Christoph Hellwig <hch@lst.de>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
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

On Fri, Nov 6, 2026 at 7:43=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Nov 06, 2026 at 10:17:38AM -0800, Naman Gulati wrote:
...
> > This problem extends to generally reducing IOMMU overhead in
> > networking - taking the dma map/unmap cost out of the hot-path and
> > avoiding IOTLB thrashing.
>
> Sure, that makes sense, but just having a pool of entirely normal
> pre-dma-mapped memory is quite a different problem from what launched
> this thread...

Since I launched the thread, I guess I should comment...

I wanted to address multiple problems, in random order:
- IOTLB thrashing
- better security than DMA-FQ
- reduce dma map/unmap costs (both on the host and guest)
- reduce/avoid bounce buffer overhead in Confidential Computing and
overcommitted VMs
- not just for networking, also for disks and accelerators etc.

Now it turns out that one way to address all of them was to
- create a special memory allocator, which distributed ordinary  memory but
  with additional metadata that make it easier to implement large
iommu mappings,
  track lifetime etc.
- hook this allocator into relevant kernel subsystems so that consumers
  could use it with little or no changes.

As it happens, the first version I posted last month was not terribly clean=
,
and possibly not terribly well presented, and had some redundancy that
was unnecessary.

The next version (hopefully next week) is hopefully a lot cleaner,
and i think the best witness is how small is the change to pagepool,
basically "if the device has opted in, ask for that special memory"



diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index b775b6305fb78..e12ba47a20e43 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -16,6 +16,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <net/xdp.h>
+#include <linux/pisa.h>

 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -602,6 +603,8 @@ static noinline netmem_ref
__page_pool_alloc_netmems_slow(struct page_pool *pool
         */
        if ((gfp & GFP_ATOMIC) =3D=3D GFP_ATOMIC)
                gfp |=3D __GFP_NOWARN;
+       if (dma_map)
+               gfp |=3D pisa_rx_gfp(pool->p.dev);

        /* Don't support bulk alloc for high-order pages */
        if (unlikely(pp_order))

The network tx side is more complicated because, as discussed
earlier, we need to be sure that the leaf device is one that needs
those special dma-able buffers, and there isn't (or I have not found)
one central place to hook into for tcp, udp, zerocopy,
security things etc., leading to a plethora of small hooks


 net/core/skbuff.c                                            |   42 +++-
 net/core/sock.c                                              |   62 +++++-
 net/ipv4/esp4.c                                              |    4 +-
 net/ipv4/ip_output.c                                         |   19 +-
 net/ipv4/tcp.c                                               |   23 ++-
 net/ipv4/tcp_output.c                                        |   12 +-
 net/ipv6/esp6.c                                              |    4 +-
 net/ipv6/ip6_output.c                                        |   19 +-
 net/tls/tls_device.c                                         |    4 +-


cheers
luigi
