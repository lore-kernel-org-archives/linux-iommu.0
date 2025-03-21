Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63C1D7E57
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589822; cv=none; b=dplk5aWegOtdlZU9A0MdBIB5kpJttZ5kKAb1it6U5OlaQEM3f7uXrvWbd0tkehgz6QligFhGFjHPay3CAyNOenaA+ZKue9HXvgnaQXO93TFjHGy3Chc9hvZFNeypozioxIvOjNxLgYFgqjaH997yxVboLxzgeMusHIcua2iPpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589822; c=relaxed/simple;
	bh=3+EdBNK/VKnFWTreKV0D3zQNtyMo78ipi11iaiOBgN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b0/5PVO9wTCNXmhj2iudQ85z7nHsGJfq03TR+BA/SkJ5adAoTbHynhBqDTljFwe4M4FL1CR5W7Pye6bxngI3bPnIKFRYBfT2loHgBAKCUuhF1hwoOdsNWPvAOMF61nATu/t6F9egHkX6VdKagvlZWWRw5jOPn/XLdQq9mDpcq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2kAJ1qhD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0qlZx47f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2kAJ1qhD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0qlZx47f"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742589819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cmk8p+Jhhkira6XquVJasIEjBawMRdgLjqNrGkBIoeY=;
	b=2kAJ1qhDXeF1c6YxzD3g1uuyRC7dqikOvdg8q4vmxdwV5Ys16/x46YloC4xPHKj1u8evSe
	MdoS6+fSf9a3nihJtw5BerHtGGQL6K+z1WkO3t3w6Htvs88Vqo/1LVOe/dycrFHea5tplw
	AZi5o7U2KfrQ7b74XP7lYHvXYwtNixxxp3UyEfF1RizGZ8mZI4jCzAp79jYrpXaffrg75r
	NSsF7ijYUU3oqwHcZ3Jkhz8De6s/3SW1iIpYkM4Fu8XzLCwUZ9Ndc+jIF2KQQHetcX5n1w
	TCxE74azlSei/YjF4+ev4btBimPDlHtiw53egzm1RaIcM2eOo4ENHiNbcgy/0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742589819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cmk8p+Jhhkira6XquVJasIEjBawMRdgLjqNrGkBIoeY=;
	b=0qlZx47fvr4vPaNePqehJfGveQ+BEjujZQDZH0mehLX91LDI5CVPd29SDJVkw9ZIVQTBfn
	UNFblHHmj0eDYVBg==
To: Sean Christopherson <seanjc@google.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Robert Lippert
 <rlippert@google.com>, Wentao Yang <wentaoyang@google.com>, Sean
 Christopherson <seanjc@google.com>
Subject: Re: [PATCH] iommu/vt-d: Wire up irq_ack() to irq_move_irq() for
 posted MSIs
In-Reply-To: <20250321194249.1217961-1-seanjc@google.com>
References: <20250321194249.1217961-1-seanjc@google.com>
Date: Fri, 21 Mar 2025 21:43:38 +0100
Message-ID: <87ldsy15dx.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 21 2025 at 12:42, Sean Christopherson wrote:
> Set the posted MSI irq_chip's irq_ack() hook to irq_move_irq() instead of
> a dummy/empty callback so that posted MSIs process pending changes to the
> IRQ's SMP affinity.  Failure to honor a pending set-affinity results in
> userspace being unable to change the effective affinity of the IRQ, as
> IRQD_SETAFFINITY_PENDING is never cleared and so irq_set_affinity_locked()
> always defers moving the IRQ.
>
> The issue is most easily reproducible by setting /proc/irq/xx/smp_affinity
> multiple times in quick succession, as only the first update is likely to
> be handled in process context.
>
> Fixes: ed1e48ea4370 ("iommu/vt-d: Enable posted mode for device MSIs")
> Cc: Robert Lippert <rlippert@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Wentao Yang <wentaoyang@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
