Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA79125FA05
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374571; cv=none; b=ouNlxVF6P7uMPEYYO1zyNSNNd5m6D05tKUd/1CovzMY5VPxkGg5LE/pQ4lgo/JkDfpZxa0aX7SvRBgC+llj1Sr5jN5TIc4XmDb8ei9ZByG5yvskKOoz3o0bUC2J9Szs32uBPNEhvirzri2L2z6Z8LlRUH+yG5J0ueMcODH+wpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374571; c=relaxed/simple;
	bh=L3M5pZdFxr53sGZKJZSRaIYyyv2nqJFyPP+MPdv5gCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cezNSmvm6ZqMsbiWSMD/Xu6EhTmI5TYwlzEYrXyhfvM79ZIYvjoUk77LFaZyImTS9qeb+o8S+n16PHarqDHiR7LiBBORs32GTR16HB7G5jEHb05v0NtOEHFdEN5xuhgsQ9qGTVQJWAt/VkUZ3opJWneEVBETp7mZY/+Ni3p7nL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=FMNz6QlT; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="FMNz6QlT"
Received: from 8bytes.org (p200300f6af1d96001ee0b275ea67cb0a.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:1ee0:b275:ea67:cb0a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AEA8F1A1BFC;
	Fri,  6 Feb 2026 11:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1770374569;
	bh=L3M5pZdFxr53sGZKJZSRaIYyyv2nqJFyPP+MPdv5gCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMNz6QlTIbqzANLFs2KmpJpoPwHKVTb1gaJR/OnvU/mgKlCwGUzKARvRC/0MzODX7
	 T17BTv5+wvNGMXE+nwJiBhVKCJyGkX34kwP+QH4GdQtnA79CaqcqWltYnxtkDL7Vwp
	 5mwmW/7akz1Zq8Fu1+EQXN4W2QkkCmTHtfuBQgmESXDETC/ii/q36sRNf9YPP8V01d
	 X3OnyebIeZStiuS4HzzAA/OzlQfWozfIsGw1TSuBYOqsTYdZU5xnSu17N6SevHYFyw
	 0BmuovwEY3NKB/NxTDriU1Vt8B1AJdKGnlCVxOhyFnZTFnB5+apUWP1NAT5Cw0FiIj
	 Cf0kl9aCnqxAw==
Date: Fri, 6 Feb 2026 11:42:48 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Magnus Kalland <magnus@dolphinics.com>, iommu@lists.linux.dev, 
	jonas@dolphinics.com, larsk@dolphinics.com, linux-kernel@vger.kernel.org, 
	suravee.suthikulpanit@amd.com, torel@simula.no
Subject: Re: [PATCH v2] iommu/amd: Invalidate IRT cache for DMA aliases
Message-ID: <xs5mh7kf7op5jh3dcpnne37bp6ve6cgiwxc5giqvljr7qgplgw@yqpirix5ptj3>
References: <fwtqfdk3m7qrazj4bfutl4grac46agtxztc3p2lqnejt2wyexu@lztyomxrm3pk>
 <20260205140059.11857-2-magnus@dolphinics.com>
 <blunl44eynudctpiqrlp4czdohmet7spwu4c7svc2pdmauaves@vfzpu55vtv25>
 <dbd9903e-a2fe-4090-aa68-1bb31fc846d3@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbd9903e-a2fe-4090-aa68-1bb31fc846d3@amd.com>

Hi Vasant,

On Fri, Feb 06, 2026 at 03:40:49PM +0530, Vasant Hegde wrote:
> On 2/6/2026 3:36 PM, Jörg Rödel wrote:
> > On Thu, Feb 05, 2026 at 03:01:00PM +0100, Magnus Kalland wrote:
> >>  drivers/iommu/amd/iommu.c | 32 +++++++++++++++++++++++++++-----
> >>  1 file changed, 27 insertions(+), 5 deletions(-)
> > 
> > This does not apply cleanly on the iommu/next branch or the iommu/amd/amd-vi
> > branch. Please rebase to the next -rc1 when it comes out and re-send.
> 
> Sorry. I had missed this one. Patch looks fine. Can you wait until Monday? We
> want to test it internally and make sure it looks fine.

You have at least two more weeks, this will not make it into my tree until
after the next merge window.

-Joerg
