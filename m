Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117208;
	b=lpp6lvWQilJJps7HChIw7VeaTUICu2J8xT+hUSulW6VK1n/sWKAmXEkAM04cZAiJ+7Ch
	 gCDPywOPIHwHl7k9Ib746AF4BrfVqVhk14r5Jap/ex10zup8UQgNTXaeTxfTqp8ep2dAn
	 NLP502LHRB6Cx7MRa6hH2GENA+oQXOBFtjcKRnnv379KjAm8ObndxjytlbYNfQzQVt9BO
	 tdRph9UNMnwhr4csWSka3nJwm+R0A+1TgVN6vlij2QHj/2t2wadUBlAyH3T9ihvu4Fwc9
	 S84593ZO2Mhen56a64F1Xcm3cP4ulZVvnVwENPOzIbRJ4NOACWiMxIb/ZTwMW4ohMDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117208;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KNEVjBhfTHDsZCQ7qnL/mlUBzN1xy9MkobZSRlmWQJg=;
	b=wUiI5aXyuSdCbw3Op9MBi9aSRMzSSXqU88ZsxWetxC8HQSaoPFmx/VC68tmS5VBD+IOz
	 L6TsZpvRzD3PqNb7eCwZVQJWfLLmm1jAIlYfbuyqFDrlUXRR+Bd1m7oyvv55zfq07pIXe
	 cD7gXN+kGPC2+1QVPwEMgRvcESw20JhTgHJDfEnEj5nfYDQ09cK3OT96mmY4wjW94rGt0
	 w0vFuzAeIajuiFJQkSUhrVNxHfBjhzHyYb7YILIQkDI/x5SYDErzw6OiZmzKrCZCPT36c
	 ILHR5wwEtjN2FfWfAJvPRrp9SS5VX+Nnu1ZHGG3nb9L9j/4qTMikTi1v8tdZzVXw9Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsmaVZvf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF9606A31A;
	Tue, 27 Oct 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsmaVZvf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDBE1F031E1;
	Tue, 27 Oct 2026 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117207;
	bh=KNEVjBhfTHDsZCQ7qnL/mlUBzN1xy9MkobZSRlmWQJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZsmaVZvfr7J7TBgWFxSPQ9veQigACtPQGB35EOT1ct2y9xwurgSDAkwA6XpQkZ1/G
	 DHE2vd7PCv+1aHZYQSu2VOfcu0O7UIZCnLQU12gTd7tzySfO5sEUd2u+XrdwDZCjkt
	 NXYoexcTbx52YJHdFJL3kkNazlxOZlTk7yqxAoMGMi4Ki8MifENmMTvsn4Fu7on/AD
	 3Px1CIvyGUpJy93v0QlFDneEtPsU+YAzzZav46K7sK6lcXVWmEsEJHIng9A2z73Xdg
	 T77y+4RjFV/PZoJbgoGRXJiSaFcObm0OjarMB9L7Sq4nXLddr+NN0OOMLA7ZC7hBoX
	 24rXjqVFMv2og==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, tglx@kernel.org,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
 iommu@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [RFC 07/11] eth: ixgbe: use dma_alloc_coherent_node()
In-Reply-To: <20261027085133.2832f2f5@kernel.org>
References: <20261027022528.633359-1-kuba@kernel.org>
 <20261027022528.633359-8-kuba@kernel.org>
 <87ecdb5x8k.fsf@all.your.base.are.belong.to.us>
 <20261027085133.2832f2f5@kernel.org>
Date: Tue, 27 Oct 2026 17:06:44 +0100
Message-ID: <87wlr33z6z.fsf@all.your.base.are.belong.to.us>
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
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Oct 2026 10:06:03 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
>> > -	set_dev_node(dev, orig_node);
>> > +	tx_ring->desc =3D dma_alloc_coherent_node(dev, tx_ring->size,
>> > +						&tx_ring->dma, GFP_KERNEL,
>> > +						ring_node);
>> >  	if (!tx_ring->desc)
>> >  		tx_ring->desc =3D dma_alloc_coherent(dev, tx_ring->size,
>> >  						   &tx_ring->dma, GFP_KERNEL);=20=20
>>=20
>> Not really this series, but the fallback here is odd, no? I thought the
>> allocator already did cross-zone fallback?
>
> Fair, I was too lazy to check. I'll remove the fallbacks in the same
> patch. Seems obvious enough. LMK if you prefer separate.

Hmm. Seems like dma_alloc_contiguous() doesn't spill over to other
nodes. It only tries the per-NUMA CMA... so keeping it is bit more
robust. (Then again, I dunno...)

I'd say keep it.


Bj=C3=B6rn
