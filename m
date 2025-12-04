Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD40271A71
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859872; cv=none; b=oa/iKJ8tdiMiHLOdYohFdgCcKlz3p12244b+ssM/bkpd2cY3YlQ6WaDq2x1dfNR8ocGUkCqjABEf1N6JSeTCdj6dYgXa7ysVe7YWc5UZR1N91E0W/a3x5hrTHPBHCo894pfiH/1ySIrINuuMx/98ZSGMifpwbnPKoQSEcA/bdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859872; c=relaxed/simple;
	bh=l8wUC/nZJMjQ3sxtatxAwV7Pqgh0hZVgyeAgCKKyY5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHwVuDUbvCsaul3k0MaSLosF99oFkcmFNx9hIE+IZU5bBRKEFQZ2ASoRCEI0Qu/mH6zBGESYBLweoZAPouLxKnhq4UHuDVzufNY5AXbASgu4LhHTJ8+MybE0y6MtbRuV7RHN/yRgmIenW3RTjb+yfrr8s73G6sAhO+KcgonkLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ev6KF3oT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ev6KF3oT"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CCE040E026C;
	Thu,  4 Dec 2025 14:45:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lE-gp5OrXyax; Thu,  4 Dec 2025 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764859518; bh=ESMFFQB/4P5C90flXNuqKDoiOo4KxHPdE4iFY7v2RZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ev6KF3oTu47FXgrXCVN1V6wc/TD5Sq8FeR0i37mUXn1nZCuL854pRvMB7QAcsCnRJ
	 u7GDqLu9D4FkBRt1QPnH0Pq2IB7x4Alxy+3fhjpKWQd6r2E+70RAz7QjrG8FEzMBcK
	 6QAd+ZFwMRLWCKZc44hdkDNvUb5Yd/QqZlQGQL16F1P7mJrgxCrv2biK/vUVvJt3no
	 hAUMSfC1+AQUxhPRXXHrtIjF0jstu2NBywMVYE0SfyrKKvPFux2LC7Kw7L6USQ42ZF
	 F3hEKT23QmmDuSEmVDydMUy2nfX5PFUsjhguT3jIymNHBFwErZo6LWO/a/XuDjrtiE
	 odRh0x558YdQKO7FUBFxOV6kdUz8788/a4+NIzhg6bDKgYQ59cR9PvLReKuLHiiQvE
	 oQ+UgF+6rZXIG93IAfeKHddRD5KP8ue6S0ZQIgR5E+1SyQTBTBZhxqSHtUHH4rx0qp
	 ALUB9AN6loPBXGkmdw3ba17cGyWBVKmLZT9BNW4oCGBVxap2bBzFJVYtzHwoH42i7S
	 4DMLVmc262EU1hjxgTrPs6hv+nQ4Oc3JtRKF7Y1EW92XjtL2CfAzVkwknfPAQHpAoa
	 NAHh7ZXB5E+1igWr5oplJnIww286MZA455N07qTClI3FtCZbr4oSrylJkfVARzr8zN
	 qs80AWOwLTZkHy1VdqIdzxtU=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8990140E00DE;
	Thu,  4 Dec 2025 14:45:11 +0000 (UTC)
Date: Thu, 4 Dec 2025 15:45:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: amd iommu: rcu: INFO: rcu_preempt detected expedited stalls on
 CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
Message-ID: <20251204144505.GCaTGecavu-E56OR8V@fat_crate.local>
References: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>
 <20251126152637.GDaSccLZVBEOs20n6T@fat_crate.local>
 <17147c98-9f0d-45d0-9593-3ede27ba6135@paulmck-laptop>
 <20251203124422.GBaTAwpmOzChS2MDhX@fat_crate.local>
 <cb2785d6-ee19-4277-9906-d287341c7698@paulmck-laptop>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb2785d6-ee19-4277-9906-d287341c7698@paulmck-laptop>

On Wed, Dec 03, 2025 at 09:16:37AM -0800, Paul E. McKenney wrote:
> Or to some value that works for you.  But if you are not looking to be
> an expedited RCU CPU stall-warning pioneer, yes, setting it to zero is
> a good approach.
> 
> If you would like to be a more sane pioneer, setting it to (say) 11000
> (or 11 seconds) could be appropriate.  But what fun is sanity?  ;-)

Oh, I have a lot of excitement even without RCU experiments. :-P

But if you need me to try things, lemme know.

For now I've simply reset the values as to what defconfig sets them to:

CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
