Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5607A331A50
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170820; cv=none; b=fbFmpatJRwJfVxDRI5z0nejUFZxvfoYHZAlQWVf2zbr7dCVCumHI/kNLjEYzwo7kdQv4aAWGLnGEqPDsW60Kb1MDg8Vohvsk8NHEIs56MhhuWW8IDikeWJIH4UOBeC3zn2emveZpsJK0lcECaXDlmq4d6UK6Ld7xuy0NAQODWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170820; c=relaxed/simple;
	bh=NvfCCOd6Vg3KZyQ/z1dUZ7pufNv3fKQn2H3XA8YZEYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArYq+rPXiNf88n/y1oOSHoJK2iCf6QLHrbxjBRgrRwy5BI9rEVoZhjfi6ybYMiR1qmlYi2pD7zjSI5EHt6B8731ffrYz8oJ4Ny6nJxI3LfC/1pjycyI7CbI3KR60fUVI81BW+uPqjbLjQvK9w/IIs+mkxmPFAgcd65XGwIBXlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cXtG34LU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cXtG34LU"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 46D3840E016E;
	Wed, 26 Nov 2025 15:26:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i0bbLR8QVhRm; Wed, 26 Nov 2025 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764170811; bh=kceqKTbVi0A/NsBcp0Rz84aTTMUVbFPBL/W9JKwU12s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXtG34LUxiuMwoRIFhmzJE/DnaCwUqpuTWa7m6C9RoML7sA9yU9cFz2+ftsnJkzkg
	 NhY3ADaZrAxXbYaekP+fzvU3j7dnrAjbRPEs1hXNZrIR298pRvdr9aAC82sctSvVQM
	 4DG1WMVIoraSOiGR73SdUzpsLsd5HVuyVgP2pPWpAJ9yYSb7YWL7qSDGJLUQdgE+5S
	 YMFO7qj9tv2EytCqq8Axa7AcHyt3xMFcy/vE1RZ5hOSAq4B4pD7klmOLmTS4Mu8D9c
	 w4+VXGBnwlHCasHigmhUW5oU2Jyxh7SvaW70QoW2h7Jwc3MbWCzpS0Nhqy98VIz9Pk
	 i2LFIQyWI0W6c4UNjr/kyALb9XMqN5ApbDbosOYEwIVJ+4d/aANP1CSFm2zh6oSiPo
	 0CcItExmidKjCbscqK6TecNDLG+n8LVXmu0+Q48KNxlDfCJY+8RDc/Xv5jb96xY+TU
	 eGi9EmGoro9kneVU0j7CD3LEk7tFNAVOkyPzzwGuBeXJYlhcEXBUWo5CnSWO+nYEj6
	 k79F9tSqtBAAPYc6gNy9zQA/FOIYrwc2wnzBIqX+J4lpgSM2wvzzRMUykRSqJT/Jhl
	 EgCOneUuvzwknRqNnVlOcgMCv8VHVGJmvWXUrRMkmnyfo2YZuZtwv/GUS3eDXGVLi1
	 +XcVqttlX8i0cx1hrD/TidjY=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D5E7040E016C;
	Wed, 26 Nov 2025 15:26:43 +0000 (UTC)
Date: Wed, 26 Nov 2025 16:26:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: iommu@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: amd iommu: rcu: INFO: rcu_preempt detected expedited stalls on
 CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
Message-ID: <20251126152637.GDaSccLZVBEOs20n6T@fat_crate.local>
References: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>

On Wed, Nov 26, 2025 at 03:32:19PM +0100, Borislav Petkov wrote:
> Hi,
> 
> this is latest Linus + latest tip/master. Box is Zen3. CCing AMD IOMMU folks
> because the backtrace points to it.
> 
> Ideas?
> 
> [   12.946913] (journald)[506]: Found cgroup2 on /sys/fs/cgroup/, full unified hierarchy
> [   12.948083] (journald)[506]: Successfully forked off '(sd-mkuserns)' as PID 507.
> [   12.977579] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
> [   12.983638] rcu: blocking rcu_node structures (internal RCU debug): l=1:0-15:0x1/.

And as suspected, booting in it again, it doesn't trigger anymore. But there's
something new in dmesg which looks weird and makes me want to Cc Paul:

[    6.965526] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
[    6.971581] Key type fscrypt-provisioning registered
[    6.975191] PM: Image not found (code -6)
[    6.975631]  } 8 jiffies s: 89 root: 0x0/.


and

[   12.549532] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 2-.... } 8 jiffies s: 113 root: 0x1/.
[   12.550863] rcu: blocking rcu_node structures (internal RCU debug):

[   12.817601] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
[   12.819773] (sd-mkdcre[520]: Credential search path is: /etc/credstore:/run/credstore:/usr/local/lib/credstore:/usr/lib/credstore
[   12.827074]  } 8 jiffies s: 129 root: 0x0/.

[   12.881508] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
[   12.892854] (sd-mkdcr[522]: Credential search path is: /etc/credstore.encrypted:/run/credstore.encrypted:/usr/local/lib/credstore.encrypted:/usr/lib/credstore.encrypted
[   12.905244]  } 8 jiffies s: 133 root: 0x0/.

Paul, this looks weird.

Why is that issuing empty lists between the { }?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
