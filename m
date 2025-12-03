Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F929D287
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764765883; cv=none; b=NT9o8fPeVN6gc88gaRz+dbkyBsiIx4nInI1Atu4IPtovtpZChyN1Y0So217o/en0tIFPOCqLX+SQA0zSGt1djG2Qm2AtPjkRcW1+w8y21UyWB6881q8gCKqE6IWuwJcpivp2hBd/2BTJJzrfRXEJCwNjNQMMybK6geNPLQ/h3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764765883; c=relaxed/simple;
	bh=mivZfBdPfHfxN3uB0HExdoPMxfqxnVqu3f7lE05ZXxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze/NZxGhJnDJYfhYqt2R+AGvL04ETnZng2PFOS8Sozhtrgq7Jyeejj4gdAri5tGB7jwCpsZt6lM1AFGGXIbPKCIPihBlvrQx+fSHU2146+ugcy+BBouBKz+hnwvRgx9aJKbosSGGg+Fba23j8X+Zu9poKQpVtM0RRW7knoq2VUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FnrM1hLD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FnrM1hLD"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D1E8840E0173;
	Wed,  3 Dec 2025 12:44:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LCH-Lmp5XWAs; Wed,  3 Dec 2025 12:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764765875; bh=JQxqNxvusVz4yosbSi4f9UldEUNyNBROQXT3RlPCzKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnrM1hLDlRhu7IxQ0LQpj7l3cIBF5zm56XAJXVGcamzakN3uaOiNwIhPkgmQAS2wj
	 UbyvM7vYC/UtGETySXmpLbO7Y0A086d0TxWx0MSDNn3erKHhHe60O4xFyAIYoT8qN/
	 rygy2nVQrCNNERA8whUucGDy/4SBvdCLIs3LRV3dXafY7Fnp2sIwQuIYAoP6ougQ8G
	 s4B7cGcUIuZsfdZ2nA3NvSg2SI0v7epQ+Hau8+oA+PrfRnKckrIZqBMgzMN6GoQ/NY
	 cIQUphVKX53mHnWyk/L33hurT0SlcepWUjros8AE4NTvOzfZC2QuYCpba3S0lDSqlm
	 6WGTG0kkuQZZWgt6GoBFtwNADLZvTgHjMEq9E88YTPhJig9L7Bhcj6uWRC7BKAx8Uu
	 5rMNU4vPg/KznRAywndgRdLOsFfg1e2aUXgg4+NR5AcpZgTaMpvxsZazIqLWU2HT7W
	 8tDTJALAeZV+MxrxILd4qyDsuGUzvxC85BFv+iiQVm/rXvkrMX1kHyysmiFqXGfLVN
	 F/fO6umTp6hJx41y7C3ekhQyQLY8IY6WHAgivJTshK2sTl9qPu/Xp0R1VgPMZZcArP
	 7Nbqo3PZgrD6TTBrZONHzOQzHYc4c4MtKTWO8FvHy+GT9plNMh5LBfkDXLWu1x8qJh
	 kwnIGh6DdyMXM22HRu9y0KIU=
Received: from zn.tnic (pd953063a.dip0.t-ipconnect.de [217.83.6.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B19C740E01A5;
	Wed,  3 Dec 2025 12:44:28 +0000 (UTC)
Date: Wed, 3 Dec 2025 13:44:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: amd iommu: rcu: INFO: rcu_preempt detected expedited stalls on
 CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
Message-ID: <20251203124422.GBaTAwpmOzChS2MDhX@fat_crate.local>
References: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>
 <20251126152637.GDaSccLZVBEOs20n6T@fat_crate.local>
 <17147c98-9f0d-45d0-9593-3ede27ba6135@paulmck-laptop>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17147c98-9f0d-45d0-9593-3ede27ba6135@paulmck-laptop>

On Fri, Nov 28, 2025 at 12:28:34PM -0800, Paul E. McKenney wrote:
> Sorry to be slow, USA Turkey Day and all that...

Nothing to be sorry for - email is asynchronous communication. :-P

> This one of course is a stall on CPU 0.  But you knew that already.
> 
> Also, it looks like you have CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20 or maybe
> booted with rcupdate.rcu_exp_cpu_stall_timeout=20 on a system with HZ=250?
> Or set rcu_exp_cpu_stall_timeout=20 via sysfs?

Not really - this is me simply doing "make olddefconfig" on a .config and then
using it on the test box. I'm simply doing defaults and I can imagine they
have changed over the years.

[boris@zn: ~/kernel/configs/brent> grep CONFIG_RCU_EXP_CPU_STALL_TIMEOUT config-6.18.0-rc7+ 
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20

Yap, 20 it is.

> This is the beginning of the message.
> 
> > [    6.971581] Key type fscrypt-provisioning registered
> > [    6.975191] PM: Image not found (code -6)
> > [    6.975631]  } 8 jiffies s: 89 root: 0x0/.
> 
> And this is the end.  This looks like the stall ended just as the
> stall-warning message started printing.

I suspected that... Judging by your explanation, I don't think we can stop
printing empty stall messages - sounds like they're multiline and that comes
from different places in the code.

To avoid confusion, I mean...

> It also looks like you have the expedited stall warning set to 20
> milliseconds, which as far as I know is used only on constrained systems
> such as smartphones. 

That "smartphone" can't possibly fit in my pocket! :-P :-P

> If you set this value on a typical large server, you will get very large
> numbers of expedited RCU CPU stall warnings.

Should I reset it to its default 0?

And for that other value I have there:

config RCU_CPU_STALL_TIMEOUT
        int "RCU CPU stall timeout in seconds"
        depends on RCU_STALL_COMMON
        range 3 300
        default 21 

which is weird. I guess I need to reset all those to something sensible for
server...

> Oh, and if you are running with HZ=1000 and the expedited RCU CPU stall
> warning set to 20 milliseconds (let alone 8!), then as far as I know,
> you are a pioneer breaking new ground.  ;-)

I do things like that from tim to time...

But nah, it is 250:

# CONFIG_HZ_PERIODIC is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
