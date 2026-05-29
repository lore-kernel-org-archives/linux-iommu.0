Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC82638F62F;
	Fri, 29 May 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076468; cv=none; b=lLQ7sZZiFu2kwRAjiKWC4V237xT+HJpQdywft12TPRj4ctnlba69hMtzVanmD0RlqaeMi3NqKSKPil1G8ZHu3KitmsZ7SYw4eLQnM8CJAHXLrNip6Me/HR1re10ZryTHLebHGRbljy8+aoViQOR2lKbYFBYWpMOhcDnj/EhllQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076468; c=relaxed/simple;
	bh=E7VW9hZwuvj77qhuAUAYhVfdwDVo7cAQLmVLMZXPkto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GuqhEz4zJxpR7BdNllZml+cuTpzl90h7l15RL+xnlWfWLndRL/qfYPeli/nuW6FOuWLnPMRTfiUX+YlWJ3hDb77bSm6vEeU0yBB5MIb95/d6MbDPVIUsKDiEDDjMbqCy0QWn5J/j1lYI9nbF2CNRNUTKyFTtjWGsHMc5mptX5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=Q1qzpcIl; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="Q1qzpcIl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=E7VW9hZwuvj77qhuAUAYhVfdwDVo7cAQLmVLMZXPkto=; b=Q1qzpcIl4Y1RibKdZwR+fwFOhU
	vcb/T9C1QhahJ6/064wbSupycxVrJQ2F/4I4gESl2TWu91m5b5tSjDY+XBVnyp4sx4g535haLfgFu
	mjc0IbRolCBdEhpBH/JQ/+i+nxMTBabpf/X9BEhCVyYSNeIcbNQYS45b1IMi7t9hl50Rl/q28K8A3
	j/2mWOALqftP5F/OA8sXWA/dRQgaHapqdUlmtk0kaQjvYAFzaekEpMTSTNeL1qVAEAFPtBJUn0H/6
	wXfhP5QCtPYLGg9jdUPdAmr+gDrwh9stpTRYEReW/8tRe7unDYVM8WeDOx9vOK2u5M/WETTH7b0A5
	l4hV0P0A==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wT1CS-000000007Js-2pa4;
	Fri, 29 May 2026 13:40:48 -0400
Message-ID: <ea3e3c47094253b392603615cd42df3329dd9865.camel@surriel.com>
Subject: Re: [PATCH 3/4] iova: limit_pfn-aware augmentation for log(n)
 32-bit alloc
From: Rik van Riel <riel@surriel.com>
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, jgg@ziepe.ca, 
	kyle@mcmartin.ca, kernel-team@meta.com, Rik van Riel <riel@meta.com>,
 Claude Opus	 <claude-opus-4-6@anthropic.com>
Date: Fri, 29 May 2026 13:40:48 -0400
In-Reply-To: <59e0476c-a2bf-42f3-8244-d8a4828da64a@arm.com>
References: <20260518180545.2286608-1-riel@surriel.com>
	 <20260518180545.2286608-4-riel@surriel.com>
	 <59e0476c-a2bf-42f3-8244-d8a4828da64a@arm.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2026-05-28 at 17:46 +0100, Robin Murphy wrote:
> Hi Rik,
>=20
> I'm certainly interested to see this series, as improving the
> allocator=20
> has been on my to-do list for a very long time now. It might take me
> a=20
> while to page all the details back in, but some higher-level things=20
> stand out already...
>=20
> On 2026-05-18 7:05 pm, Rik van Riel wrote:
> > From: Rik van Riel <riel@meta.com>
> >=20
> > The augmented-rbtree port made __iova_search_free_gap O(log n) when
> > limit_pfn doesn't bind any candidate gap, but degrades to O(n) when
> > limit_pfn is small relative to the gaps in the tree. The classic
> > case
> > is a 32-bit DMA allocation on a domain dominated by 64-bit
> > allocations:
> > the augmented invariant __subtree_max_gap is satisfied everywhere
> > (the
> > huge gap between the highest 64-bit allocation and the IOVA_ANCHOR
> > dominates), so pruning never fires, and every node above limit_pfn
> > must
> > be visited and rejected before falling through to the 32-bit
> > region.
>=20
> The main reason the anchor node exists is to ensure that cached_node
> can=20
> always be a valid place to start an allocation walk - if we're no
> longer=20
>=20
We kind of still need the anchor node, as the highest thing
in the rbtree, so we can use that as bookkeeping for the
largest gap.

Without it, we would not know there was an enormous 64 bit
gap if the first iova allocation is made with a 32 bit
mask.

We could add special casing, but the anchor node might be
simpler and smaller.


> > Add a second augmented field that bounds the search by 32-bit-
> > clamped
> > gap size:
>=20
> I would think that if we still need a special case for this then we=20
> don't really have the right allocation algorithm - I recall getting
> as=20
> far as concluding that it would be hard to do with the generic
> interval=20
> tree,=20

You are right, we do not need this. Walking the rbtree
from the root can bring us to the right address range
in O(log n) time, without any need for additional
augmented data.

> > For 64-bit allocations the behaviour is unchanged. For 32-bit
> > allocations on mixed-DMA-mask domains the search is now O(log n).
>=20
> And what about all the 33 to 56-bit DMA masks? They're not all that=20
> uncommon and deserve some love too. FWIW I'd imagine a general
> algorithm=20
> should be something like:
>=20
> - while pfn_lo > limit_pfn && left->max_gap >=3D size, go left
> - while pfn_hi + size <=3D limit_pfn && right->max_gap >=3D size, go
> right
> - if sufficient space to right, insert right and stop.
> - if left->max_gap > size, go left, else go up and left
> - repeat

I have this implemented here now.

I can send out v3 if you would like to see that version,
but you are right that the maple tree may be better!

>=20
> (If anything that then leans towards maintaining a dummy node down at
> start_pfn, such that we could avoid a special case for allocating off
> the leftmost end of the tree...)
>=20
> I guess another question to ask these days is perhaps whether rbtree
> is=20
> still even the best choice at all, or if something newer like maple
> tree=20
> might be able to be even better?
>=20

Doing this allows the struct iova to shrink from
40 bytes down to 16 bytes. However the iova slab
cache seems to specify SLAB_HWCACHE_ALIGN, resulting
in 64 bytes used per iova.

If we drop SLAB_HWCACHE_ALIGN and assume 70-90%
full maple tree nodes (I assume many iova requests
are of same/similar size - let me know if that's
wrong), we are looking at a reduction of memory
use per iova from 64 bytes allocated, to around
44-60 bytes per iova on average.

This is with allocation becoming O(log n).

Maple tree may be the way to go.

Let me go test this code, and I'd be happy
to post this as v3, instead of the latest
augmented rbtree code :)


--=20
All Rights Reversed.
