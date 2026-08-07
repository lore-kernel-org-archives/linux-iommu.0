Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF677441636;
	Fri,  7 Aug 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134361; cv=none; b=LFV8S8JvIMrSQ9tP4Fx6iaUiY2Ocm5diY+nk6qNp9EwbyRHVCcQgzII7/ZJ9tGVBGGJWRJMzWY4CI7ePmebCmGn/wZGcRu8BAK9N38ndqCIlmxPSL4gY679tYz6L8Hdh03AeiK8zZ1i2rcUUdcP7vyFuZKrKg5u8xkqpPD9599c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134361; c=relaxed/simple;
	bh=Bc4gIRFzJfGmpp5me3HZhZ5+IwWmkc+ucXJ3MYUcjHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZxYDSFLPlFaRhQs8hvBhosQ9pUukFIWmseeM7FxOEA/kx64sKtihXi/VXq4gv/QkSxeioUHKyoDjFdsqCaZuM3ZxIY4LPQMCjRKB2XQq9+bit3fFW4t246+mnJkNxxouEZZPXFfTG+XZwzzmzwvFsdn9XEEFUOITH3o4py4rxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctNjDXhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctNjDXhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ED11F000E9;
	Fri,  7 Aug 2026 20:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786134360;
	bh=Bc4gIRFzJfGmpp5me3HZhZ5+IwWmkc+ucXJ3MYUcjHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ctNjDXhE+PL3F22dX2Qr14z3v3823iHcSK7w0xo1rrPnIaNsSoNjxhUfZoU1aZyFo
	 UzNnS3p2xRGmCasGq5x4q/v+7dS3OvBtHoNV19jk8Yum+VJs+i/aqtn9a1Ac36EvN0
	 ez1HL8Th4fj8K+4dg/7wU8qKcZp2pm91MFaNaqA/azKGA2kwWpeGz/ImPjNbbPt2SJ
	 ZTJRPPoqKen+CTSqLWJMQ7X/Yo3/RjMLHRJNNPyzNCmi+TQoyEfDz/ljYC8F6Wd/EX
	 1A501XVuDo9KRXT0btzxuaEY3v5JX4o43dUk5dQF8JCOOZZA2m+ItqwHVq8pik1IVV
	 o7uK48e1Mb8oA==
From: Thomas Gleixner <tglx@kernel.org>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v3 06/19] irqchip/riscv-imsic: Compose MSI updates
 through the hierarchy
In-Reply-To: <20260807181713.228535-7-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
 <20260807181713.228535-7-andrew.jones@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 22:25:57 +0200
Message-ID: <878q6hekyy.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 07 2026 at 20:17, Andrew Jones wrote:
> imsic_irq_set_affinity() wrote the new IMSIC target straight to the

Wrote? When was that?

You are describing the current state/context, so this wants to be
'write' no?

> device via imsic_msi_update_msg(), bypassing the irqdomain hierarchy.
> That skips any intermediate IOMMU irqdomain sitting between IMSIC and

Otherwise 'skips' makes no sense either.

> the device, so a remapped device would keep the pre-remap physical
> address after every affinity change.
