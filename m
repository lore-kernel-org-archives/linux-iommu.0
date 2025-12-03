Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5E31A81B;
	Wed,  3 Dec 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764782198; cv=none; b=TTxAJJDdl1WOSg4eUkaYvDxgzG8ECQ2neT3SdBLXScuWt6AymmlCmg+2gtR/15siFWi4Tu2fOqtLYy750hVe+l60mwKX78qUP2Sz5GVTQw9ssgSlgmuVnEwSDjOn4OYIzuq68o7JMGryR2Djc3qwwDqLc5aAkjJeMGcgu0Bvvu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764782198; c=relaxed/simple;
	bh=YDgKJB0lJDGrbtdLGmuk796myylCZiAR6VFE6JEulgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5S+RFVZX6liwbJK1JXyEhxTWbnvz8AtMWUlArTTvT2gC0W372jXtWBS8NBXGGz23gmK1PPHlJzQ8v9/apT3xafW3NAdithbnNETTQHE2+0jANr+pOmrS2tsRSA7bAPiuztW44PFEzrWEzDISRcLEnnmIihr28UjkpQcIvT0HW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rch4C08q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rch4C08q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD4DC4CEF5;
	Wed,  3 Dec 2025 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764782198;
	bh=YDgKJB0lJDGrbtdLGmuk796myylCZiAR6VFE6JEulgY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Rch4C08qUd0gsGw8cobNiWBy1aFGW4JvPms80RJsPbteRj0du1+XvdsiAjg37O2Wz
	 iYi3D5uFzeV3cmTdpBTu/GqNdINAEz2hGjYhV73Jn+uqS5u8+olBDp7NcR3HPVFR2S
	 no2XSQXXB0puwvEaMUaekRI+udAxK2zoMiNBCYF9DfchixvdLDbOrfT3Ph9NrpT+U8
	 8cspZ3d0qVQlVtgKRK3pXnmwBIp1EXP9PqbeGQDdWd+ckYS9/eZlFtWousdfXFmqY9
	 v774FysJqtaOyHGajm1pE0Oi8PiZ1dGQ7RKxMYrgbpk1hy+NDTJ2WkOJrCKBWDHlG9
	 6mbPFUWXexqgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 91F57CE0F85; Wed,  3 Dec 2025 09:16:37 -0800 (PST)
Date: Wed, 3 Dec 2025 09:16:37 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: amd iommu: rcu: INFO: rcu_preempt detected expedited stalls on
 CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
Message-ID: <cb2785d6-ee19-4277-9906-d287341c7698@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>
 <20251126152637.GDaSccLZVBEOs20n6T@fat_crate.local>
 <17147c98-9f0d-45d0-9593-3ede27ba6135@paulmck-laptop>
 <20251203124422.GBaTAwpmOzChS2MDhX@fat_crate.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203124422.GBaTAwpmOzChS2MDhX@fat_crate.local>

On Wed, Dec 03, 2025 at 01:44:22PM +0100, Borislav Petkov wrote:
> On Fri, Nov 28, 2025 at 12:28:34PM -0800, Paul E. McKenney wrote:
> > Sorry to be slow, USA Turkey Day and all that...
> 
> Nothing to be sorry for - email is asynchronous communication. :-P
> 
> > This one of course is a stall on CPU 0.  But you knew that already.
> > 
> > Also, it looks like you have CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20 or maybe
> > booted with rcupdate.rcu_exp_cpu_stall_timeout=20 on a system with HZ=250?
> > Or set rcu_exp_cpu_stall_timeout=20 via sysfs?
> 
> Not really - this is me simply doing "make olddefconfig" on a .config and then
> using it on the test box. I'm simply doing defaults and I can imagine they
> have changed over the years.
> 
> [boris@zn: ~/kernel/configs/brent> grep CONFIG_RCU_EXP_CPU_STALL_TIMEOUT config-6.18.0-rc7+ 
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
> 
> Yap, 20 it is.
> 
> > This is the beginning of the message.
> > 
> > > [    6.971581] Key type fscrypt-provisioning registered
> > > [    6.975191] PM: Image not found (code -6)
> > > [    6.975631]  } 8 jiffies s: 89 root: 0x0/.
> > 
> > And this is the end.  This looks like the stall ended just as the
> > stall-warning message started printing.
> 
> I suspected that... Judging by your explanation, I don't think we can stop
> printing empty stall messages - sounds like they're multiline and that comes
> from different places in the code.
> 
> To avoid confusion, I mean...

Actually, there are some things that can be done.  If you really meant
to test with 20 milliseconds instead of the normal server-class 21
seconds, please let me know and I can see about adjusting.  No promises
on schedule, though, LPC being next week and all.

> > It also looks like you have the expedited stall warning set to 20
> > milliseconds, which as far as I know is used only on constrained systems
> > such as smartphones. 
> 
> That "smartphone" can't possibly fit in my pocket! :-P :-P

Then do you *really* want to be setting the expedited RCU CPU stall
warning to 20 milliseconds?  That value was set up specifically for
constrained systems that don't scan huge memories or have huge piles of
running tasks, not for datacenter servers.

> > If you set this value on a typical large server, you will get very large
> > numbers of expedited RCU CPU stall warnings.
> 
> Should I reset it to its default 0?

Or to some value that works for you.  But if you are not looking to be
an expedited RCU CPU stall-warning pioneer, yes, setting it to zero is
a good approach.

If you would like to be a more sane pioneer, setting it to (say) 11000
(or 11 seconds) could be appropriate.  But what fun is sanity?  ;-)

> And for that other value I have there:
> 
> config RCU_CPU_STALL_TIMEOUT
>         int "RCU CPU stall timeout in seconds"
>         depends on RCU_STALL_COMMON
>         range 3 300
>         default 21 
> 
> which is weird. I guess I need to reset all those to something sensible for
> server...

No, not weird, see "seconds", not "milliseconds".

> > Oh, and if you are running with HZ=1000 and the expedited RCU CPU stall
> > warning set to 20 milliseconds (let alone 8!), then as far as I know,
> > you are a pioneer breaking new ground.  ;-)
> 
> I do things like that from tim to time...
> 
> But nah, it is 250:
> 
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250

OK, then all thoae "8 jiffies" in your console log make sense.  ;-)

						Thanx, Paul

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
