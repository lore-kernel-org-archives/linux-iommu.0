Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFD27F18B;
	Fri, 28 Nov 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764361715; cv=none; b=CH2aIjKOUEc796mKpA/w0LasbOFphCo7uqHBRay0OpD4f11SuXziqDiKyATAq8SgLzVJ8qxAKf5eRBkBa+n6RUQx7LL464kllGSsQHrQzsw5lv4dMvcugWtcyyefkoBiyX/4jsqyw2FE+OgREv7ZOMkNhF1b7wIrVEL4j/qR1s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764361715; c=relaxed/simple;
	bh=Ec6Ru+ibCJqELuZNYW5RHW7NnYSrbG4/PL8CejcvskM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAi5mqBKNBBNDuPVgso5xm+DE7574PqbLQm/PqU5Gryn5QYjvzpzw1bwMcV/x/SxMyoM4mxbbmrJ03c8y2dy69OTltYHMygS52PEwoQQy6QJRn77j0p2YaaZRTk7Ynu9otujyPqgMHXe0ckMc32EQNWLXPkGqGfZWJrAcP3xPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6DWruu+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6DWruu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4943C4CEF1;
	Fri, 28 Nov 2025 20:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764361714;
	bh=Ec6Ru+ibCJqELuZNYW5RHW7NnYSrbG4/PL8CejcvskM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=C6DWruu+CeqFqXWaBoMXuohgJFdlD3X5z9TL9aQceKpvMGjWYj8gBn3nlmymZld4V
	 pVr0fLGFbhwOSNey3VVeUSZSM6B8PxKgQ3geaYzH/0nhWtWMkNpJHf/ob2jZ0znSIH
	 yTGmRS/inUXqlhJzxWSfQWSXkEptxmBR7iPFzAlUWoYiCeeiNAuHSUMNPouhlh23tJ
	 GCpKw2G8jh++fLKGa2xs1377V3qL4ovB1krqXoXWk69Hq9z4FUztIKMf9WDT6COahV
	 cfetzvKW4W9Px0U9ZhwbKIIAtDEAfUFpXjNJyBo8UOVUQ53YV/3HYwRyShroLfY611
	 NVmMf58rFIftg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 51546CE0B1F; Fri, 28 Nov 2025 12:28:34 -0800 (PST)
Date: Fri, 28 Nov 2025 12:28:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: amd iommu: rcu: INFO: rcu_preempt detected expedited stalls on
 CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
Message-ID: <17147c98-9f0d-45d0-9593-3ede27ba6135@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>
 <20251126152637.GDaSccLZVBEOs20n6T@fat_crate.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126152637.GDaSccLZVBEOs20n6T@fat_crate.local>

Sorry to be slow, USA Turkey Day and all that...

On Wed, Nov 26, 2025 at 04:26:37PM +0100, Borislav Petkov wrote:
> On Wed, Nov 26, 2025 at 03:32:19PM +0100, Borislav Petkov wrote:
> > Hi,
> > 
> > this is latest Linus + latest tip/master. Box is Zen3. CCing AMD IOMMU folks
> > because the backtrace points to it.
> > 
> > Ideas?
> > 
> > [   12.946913] (journald)[506]: Found cgroup2 on /sys/fs/cgroup/, full unified hierarchy
> > [   12.948083] (journald)[506]: Successfully forked off '(sd-mkuserns)' as PID 507.
> > [   12.977579] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
> > [   12.983638] rcu: blocking rcu_node structures (internal RCU debug): l=1:0-15:0x1/.

This one of course is a stall on CPU 0.  But you knew that already.

Also, it looks like you have CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20 or maybe
booted with rcupdate.rcu_exp_cpu_stall_timeout=20 on a system with HZ=250?
Or set rcu_exp_cpu_stall_timeout=20 via sysfs?

> And as suspected, booting in it again, it doesn't trigger anymore. But there's
> something new in dmesg which looks weird and makes me want to Cc Paul:
> 
> [    6.965526] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {

This is the beginning of the message.

> [    6.971581] Key type fscrypt-provisioning registered
> [    6.975191] PM: Image not found (code -6)
> [    6.975631]  } 8 jiffies s: 89 root: 0x0/.

And this is the end.  This looks like the stall ended just as the
stall-warning message started printing.

> and
> 
> [   12.549532] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 2-.... } 8 jiffies s: 113 root: 0x1/.
> [   12.550863] rcu: blocking rcu_node structures (internal RCU debug):

This is a stall on CPU 2.

> 
> [   12.817601] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
> [   12.819773] (sd-mkdcre[520]: Credential search path is: /etc/credstore:/run/credstore:/usr/local/lib/credstore:/usr/lib/credstore
> [   12.827074]  } 8 jiffies s: 129 root: 0x0/.
> 
> [   12.881508] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
> [   12.892854] (sd-mkdcr[522]: Credential search path is: /etc/credstore.encrypted:/run/credstore.encrypted:/usr/local/lib/credstore.encrypted:/usr/lib/credstore.encrypted
> [   12.905244]  } 8 jiffies s: 133 root: 0x0/.
> 
> Paul, this looks weird.
> 
> Why is that issuing empty lists between the { }?

Again, my guess is that the stall is ending just as the print starts.

It also looks like you have the expedited stall warning set to 20
milliseconds, which as far as I know is used only on constrained systems
such as smartphones.  If you set this value on a typical large server,
you will get very large numbers of expedited RCU CPU stall warnings.

Oh, and if you are running with HZ=1000 and the expedited RCU CPU stall
warning set to 20 milliseconds (let alone 8!), then as far as I know,
you are a pioneer breaking new ground.  ;-)

							Thanx, Paul

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
