Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795782569;
	b=cMVQ1/E7E8LEtn1rFLABMCgrynuQ7kaDvWbrqkJe3yHYQGhC5k1wr9kP5cNbpUjS0+3l
	 dZ24VjdGdFxSjqJ61VM8BcoDtKFKxAiaKybyKQ6BVu8rQqB9Sshy3Hk9TWlaKj7oqeXBa
	 m0YKzDgCA28te1IL/VO4w5AlvgKjGpXS9ydxdbxLKkaHHKDDoOExwt5hcGOUdq3v78Vqg
	 bqDDl0WZ90ah41MC4w1nVr3UfN55SdbTaRhTQxmugoVS0JiihPhKB3zWnZY3cVfVJ33Th
	 QfeDNHgKC1Vi+CAjorlW0wnHevWned6xxIdZ9KNTWp5AoTOEGFqFMZL4AiUkCO3ShBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gXf5stEDIYuDZVQjUcNyW733hx6qDRKNZoyJXoBIROc=;
	b=1/5jxo8jCk7XQA4f3oOYkrnlVw/CwdcMJDPwONeN9uKSzsd/WSJiS6bn7+ZRXrGe8kNg
	 7+RA6C0rWKHxdGbRYUQPkWXLlb7WhJIUwYkafurKScuXUIUWNaJqm9Y2JSg6Pbi8VR1sG
	 fMLS23uf+pjCzpri39PJel4Kiut2SXstKlgfl0aMrl8CAmDZK/hxiQfZTAE48DYibXXmN
	 skeOYhZKcROh1y8jh+8y57EC/NpdlPnnzUrJCbid+mhgC8ZVv4asSVv0ka9uZGte2w9Q7
	 xgHK6hvHCpWsniqdNzQtHWgJMhGIF4XSBqgsthoo5J3mv6l06EvQhqptQBZI7DhCxkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="T/zdGZc9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2B606A324
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 12:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58A2B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T/zdGZc9
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-55be673e029so1832131cf.1
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 04:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795782568; cv=none;
        d=google.com; s=arc-20260327;
        b=p0kP7K3Vp56XB2pSFHn4xbcOQN9b0jATXHmStVVEu1mIvx9Ygt3Fy289Sodyt8+ICx
         f5+IFtd5pvndrVMhsCIDBlBCkPsOOlC6doqhn6jZUPJxS0kgHD6lQS3w4KIlcPNIKnmg
         wYkMkMWttoHQd2XR7vTEheLXQid00odobMqEzOA+gSv94502qY7NJ54gGqA1gtMOAyLB
         Ko/VEAQsy2Y7WXA5Gm8hhVMts4K626RgtC1Vf15bDA1s4xO40HdLyClYNwEKcS3Gxod3
         ZF1dcQXTi0ODgBpMwQF9zeU9Kl6L6qbTKX7qCU0lZ45u5iKdBhP2y3tIY74iYX/Yd/Rc
         kb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gXf5stEDIYuDZVQjUcNyW733hx6qDRKNZoyJXoBIROc=;
        fh=twq3ZdMwiQDs5WCPEWpV+Yz5KEM/4g92TMic4NFtLtU=;
        b=EP/1Fh+gfDMzA9erp42b2XkH9AUOi87NBhPurmSE0ztN20ExKVzKrWSREbZw1ek0fI
         4W+3VU8AqCHVKvgYiSgntbZvEx9FSyIZv2U2qmLKTtX9UzH8O/MD5hHc52CbwS1cspsb
         a9q7e66ndytw7DuR4cPY9nHDz2slNStz0uMFa/Ju4MJawfq2lqSJol9Yf1IDi6KzeCmf
         1NZh9iip2dj2D4O2k4i+veZL7MbAH45LKcFg7FVmf2v8opzBLIAk7FR/2O1H5i/MsotU
         iGcYPk3VYnnaYogHl6qZIKM8d0FaOWoQmBl/3cVENrd39CbGd0uoFKnkksxWcpKSx1zT
         0TeQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795782568; x=1796387368; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gXf5stEDIYuDZVQjUcNyW733hx6qDRKNZoyJXoBIROc=;
        b=T/zdGZc9aDnGY7kzcTkj0QT8OHgtKHeol0lhvlfLiLAoXJUXrSj8DIOBRsWOpO7Htz
         A86X0gzsTZXxq5xROKuw3YL08YGpJSeVS/uSYvEfaHQ7Co8wGpqwGPo/lm28Ha7hmifl
         hJubm7ZLAR5KtADQPuz0RstweYXGByzqmKqK4jk0h+JBINMVDMdyhfvX+VD6lhIt8Swj
         QWNe2u5rmXk0Sm53WE6WzXM3WZCR7pAkgHa2txkxbsLUpX52PpCJAbGwiqcXDW4vEGCy
         WBb+/yIDBS528nUmXZGbIbSD8SXQ0tAGXbZt98icKwAiDD3b1EUM0saFB7IUimljC1cI
         wm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782568; x=1796387368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gXf5stEDIYuDZVQjUcNyW733hx6qDRKNZoyJXoBIROc=;
        b=0iHER26cvoTZAqYWafnkSwyqIyfZd2gApkwV1Xs8VD/qf/erX6FbXMUaL7nICsCru7
         n/XKdNkCcU+3MOcGSGInwN15foCaWemtZ7mNC947x/ZEOIHYaS0Fgja9uzi5G4Zvb6i3
         6HCQ2iKig0MS8yx2GJy+To0q4LBKkYzFiduqjUGNbyq611VmKN8bS9DbD5EseBTS7wCd
         ax/Et5d/1MwAqvqSTHq4gXXWJpkdu4W6DZz6dZ7m1lNh1Ks3E0/wdg81FE55J74nY+U9
         E0ASTFA6e+tO/53QSBogZ6J0iEk1Pnk+ohntBGMCFLtGwXUq/mGE3GrlIyPGOpmTl6do
         Gmng==
X-Forwarded-Encrypted: i=1; AL+hErF5Z5TRERgPS2ewav3NQhgVh9QD3bQLWodv9r8f0Khh5b7/03axHjop3VyucPkqVbBpkbw/BA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+rEc8RCCmuDq6uNgrfTsuXef4uXwNHOal5mCq6//ImEiodvrB1
	ohW8C3eLCruHiX4C8TsqSfO8E4TS3QTt3RtXs3wpDVKBouWoKjtBPgBL4bJfFHQiig6JyJLSGXo
	Mgy4uRXjMADXCEoDVP2kghDjAsZkUyYSVKdaXGzgV
X-Gm-Gg: AZFdTZdlqO/WGPpCaPnG8PKaNBv1x08JiqGajvhnLCSeFD0ncrLAAKadIIbuw8X4fnQ
	GZPPhMsYuU+++pFdc82Py9d4hqLrMyLM4NSIopaNMhoM8GJ0FoGq9AjPD1fMLU893KggBq2Ejso
	XhKGORj10JM8Doh2Bh0gEihe45RTgpdeoMPtCVsHT5NxbKrfaO3oZEzbSsKaHbOHt3bVG6Av0Vl
	tD2iU9jxXm3AytwE/aZ4F8NQtS0Iyhl0jJp0lCexN9CQ86y2vh75YFgwJwE6IGVyyEsMxPoSwbr
	BsfRM/LkGQD+9MEWpUJkoaTteHFixlkkV2DzcUASz+JanmGQ9GxWvH1o6yBdVFJTKcZYYI1ygcA
	WBcbN8Xnmk0Qrp7TQQl1opEjiIv7xM9WBWN+Y1g==
X-Received: by 2002:a05:622a:a14:b0:536:6ae9:f55f with SMTP id
 d75a77b69052e-55d8900bdcfmr34062041cf.7.1795782567558; Fri, 27 Nov 2026
 04:29:27 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
 <20261120135013.GO3115493@ziepe.ca> <CAMOZA0LmZ9PFzxLcc1SuS8piFyZu6P=vX_qR2jy-3QRUoNCUKA@mail.gmail.com>
 <1f10002ea9ee16a17087bd06e4a1685a973fdf6e.camel@linux.ibm.com>
 <CAMP57yVZx=s-JXHfQfd_ouv2jV6MMsJXpxVLkQQHG=7qfFVJfA@mail.gmail.com> <d42bd9452d00a0b2a5b7d6652d556c9fc8d2c830.camel@linux.ibm.com>
In-Reply-To: <d42bd9452d00a0b2a5b7d6652d556c9fc8d2c830.camel@linux.ibm.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 27 Nov 2026 13:28:50 +0100
X-Gm-Features: Aa3M54o01jhZM9dCQYVFb8_-yMQWCkVYamRB04RwDLjyCo_Cf-5r3I24fRo_Jr4
Message-ID: <CAMOZA0JMZ8wUrV08YznFUH7AkmyqXcNdzfd26KsoTtzqt69SVA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Naman Gulati <namangulati@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Dragos Tatulea <dtatulea@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Catching up on a few comments:

On Thu, Nov 26, 2026 at 9:46=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> On Mon, 2026-11-23 at 09:50 -0800, Naman Gulati wrote:
> > On Mon, Nov 23, 2026 at 2:10=E2=80=AFAM Niklas Schnelle <schnelle@linux=
.ibm.com> wrote:
...
> > > I think that approach would also align with Jason's idea to keep thin=
gs
> > > within the network stack and to work with the tools we have until the=
ir
> > > limits become very clear.
> >
> > Hi Niklas,
> >
> > I have been working on this idea exactly - extending the network
> > page-pool with a memory provider that allocates large pages, splitting
> > them into N smaller pages that all share a single IOMMU entry. I
> > breifly shared my approach in the v1 PMD series [1]. I'm readying a
> > short RFC to share shortly, would appreciate your feedback.
> >
> >
> > [1] https://lore.kernel.org/netdev/CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69t=
rmw+BJRVYf3JB1g@mail.gmail.com/
> >
>
> Hi Naman,
>
> This does look more contained, but I'd say you should still go simpler
> and fewer steps per series. Some thoughts:
...
> - This is still a LOT of churn, my gut says much of the benefit should
> be possible with much less churn. It's really too much to follow but a
> cursory look makes me feel like there is duplication between rx and tx,
> which is weird since for the pre-mapping they should be quite similar.
> There also seems to be very little integration with the existing page
> pool, rather it seems to set up a parallel mechanism for the pre-mapped
> buffers. Really in a first step I think we "just" want to use a more
> efficient DMA mapping and contiguous memory chunks for the page pool
> and also keep the page pool API unchanged as much as possible.

The implementations seem large because they expose limitations
in the current kernel code (or our understanding of it;
but the proof is in the pudding). Networking for one, since you
mention it: the tx path allocates memory in many places without any
hint on how the memory will be used (loopback or device with IOMMU ?
cleartext or encrypted?).

If we limit to the easy parts (e.g. just network RX) we may avoid
some churn but we will not resolve the problems arising
from reasonably strict IOMMU deployments on large systems:
- IOTLB thrashing (network traffic uses separate PTEs for
  rx buffers, rx headers, tx_buffers, tx headers). Rx buffers
  are only 25..50% of the total. See [1] for some data.
- per-buffer VM exits on overcommitted VMs (same problem as above)
- IOMMU unmap serialization (with strict DMA, I measured over 10us under lo=
ad)
- swiotlb copy cost (on tx and a backlogged queue, most of the copies
  happen on the TX softirq handler).

Also we will not be able to see what is lacking in the current kernel
code to address all the above.

What I wanted to do with my series (Request-For-Comment, for a reason)
was to identify the components we presumably need (meaning: implement,
or figure out where they already exist and actually do what we need)
and get an idea of how intrusive the changes would be.

Then it is completely fair to say that the goal is not worth the effort
and should not be pursued, or to take the low-hanging fruits out of it.

cheers
luigi

[1] Here is an experiment with a system using bidirectional TCP
traffic on multiple NICs, where IOTLB thrashing becomes a bottleneck.
Below is how total throughput (TCP payload TX+RX across all NICs)
changes using 2MB mappings for different regions.
We really need to cover them all to recover the performance
of identity mode

Use of 2MB mappings         total TCP throughput Gbps
-----------------------------------------------------
none                                  440
rings                                 572
rx_buf rings                          577
rx_buf tx_hdr                         572
rx_buf tx_buf                         649
rx_buf rx_hdr                         674
rx_buf rx_hdr tx_buf                  716
rx_buf tx_buf tx_hdr                  734
rx_buf rx_hdr tx_buf tx_hdr rings     744
identity mode                         744
------------------------------------------------------
