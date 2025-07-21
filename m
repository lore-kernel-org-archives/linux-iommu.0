Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AB2D3EF3
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101872; cv=none; b=iz+CfLLZSeHB6jNw843U38wX6U7dWpy4N2kcr3kfTDTAtkyiDfpZSGi6cnYuwoZ2LvW72NoGJXE4LSQo705VMqvUrpNE5lrLXiCP/r2UqzCFQgWHl8fghRMh6lq4aiZm2o66eWSWTN8B6WIrEM7sHlwoM3ZSDDLpn3FdapgTaMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101872; c=relaxed/simple;
	bh=OpIcgWD0xhc4uZmsSop2odaYZuIXzpyP2cO8jBI/Jjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbrCdO83YfbymkDGM8uuWBOH8vOCajTYRXKW2jFSjb17JjJzZaQsAYWhVvHZwT8TgCAtEkaFyZHdJ+2HoO4hz+hac+UnMzu/Wjdld/z/ZpD+LxFWjCrJZyLhqNjD3DZ0AVyImyWz6AuCIEoIASrEpE/8aww2oq3yoAEfoGAvsBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpvfbPTg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpvfbPTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61711C4CEED;
	Mon, 21 Jul 2025 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753101872;
	bh=OpIcgWD0xhc4uZmsSop2odaYZuIXzpyP2cO8jBI/Jjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpvfbPTgtcuhMYCbZ7JZYjMqxgkPTYjWIJTUitJaXKc4lSBrybO9UHuVxAzhZECG4
	 OYQs0bcm24hVyERUBkuBaIMd4xmaNfCkvM8UGQWa9LMzTu/99YWDuXIldGTMYyFymU
	 2ynlc92YDum80IWFZvk/cehgRrFuDoIJsp5hixAZ/8S7wBa9PAFmCNjw3GNqEplMbd
	 jSdG8C8Dzur67jr5mWiJfL210x2acJnNhiApbOi+XCzwdZXTZ01UvBkfXDtqn7AT1N
	 OuLbG+QdXzYEZJ48VKj2WvxBZE0ofBi1+Adg66obMeuGTwOooCN/3WTorh0yGnlXWp
	 isKdfypXaHl5g==
Date: Mon, 21 Jul 2025 13:44:27 +0100
From: Will Deacon <will@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Mentz <danielmentz@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce
 pm_runtime_get_if_not_suspended()
Message-ID: <aH42K_UjP-crebs5@willie-the-truck>
References: <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>
 <aG6P6F-MEvL4SfNz@google.com>
 <CAJZ5v0gGjt+pRbq2k7qL6E+TGhm8PYHm_VVrwg2ZEjSWk+5FRg@mail.gmail.com>
 <aG6hpoMx1QwwP195@google.com>
 <CAJZ5v0jyYpu=qA-_QKVoNhzRZRNKe5cFt718fo6pxR6iRkD2bw@mail.gmail.com>
 <aG-BC6B4R1ViEDM1@google.com>
 <CAJZ5v0id-sRxVxupWPKPGikSm5_QeO_WKgYdK2BUbY4m7dbndw@mail.gmail.com>
 <aHDlhyPmjCT7rz-i@google.com>
 <CAE2F3rAPB8rVz38ygAxatdAunS9oMNJ5WvMiB+M8Am71MEHVVQ@mail.gmail.com>
 <CAJZ5v0gO8jDeEF84hdqhhd2U9dT78YYikQR_RW3Re1R2DKTS0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gO8jDeEF84hdqhhd2U9dT78YYikQR_RW3Re1R2DKTS0g@mail.gmail.com>

On Wed, Jul 16, 2025 at 02:53:13PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 16, 2025 at 1:52 AM Daniel Mentz <danielmentz@google.com> wrote:
> > I propose a custom synchronization mechanism where we use a spinlock
> > protected variable that determines whether SMMU is enabled or
> > disabled. In the suspend/resume callbacks, we disable or enable SMMU
> > and update this variable while holding the spinlock. In the map/unmap
> > path we briefly grab the spinlock while examining this new variable.
> > Only if we find that SMMU is disabled, we elide TLBI commands.
> 
> That sounds reasonable to me in principle.
> 
> > My concern with this, though, is that the additional spinlock might
> > spoil the performance gains of the lockless command queue insertion
> > algorithm.
> 
> It might, but it is hard to say upfront.

I'm definitely not going to take a solution that unconditionally
serialises unmap().

Instead, I think that we can probably check whether or not the SMMU
is suspended in a few places:

  1. After zapping a PTE but before issuing TLBI

  2. When trying to allocate space in the cmdq

  3. Right before moving PROD in the cmdq

Only (1) is necessary for correctness, but (3) narrows the race window
and (2) is then required to avoid getting stuck trying to queue commands
while the SMMU is powered down.

There's still a small window for a race if the SMMU is powered down
immediately after we checked the flag in (3), but in that case we'll end
up serialising to power it back up. Adding additional states might
mitigate that somewhat (we could poll on the suspend operation if we
know it's in progress) but I'm not sure that it's worth it.

So I would start with (1) and the state tracking machinery, as that's
fiddly enough with the memory ordering and suspend/resume sequences.
Then (2) and (3) could come as an optimisation, after which we could
assess whether or not we need to go further.

Will
