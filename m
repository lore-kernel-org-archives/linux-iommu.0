Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBDC1A4F2F
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511676; cv=none; b=UY0OfDkf4jh9JuHwyCOJ5dxSdkYW1sTkKXxM1OKP/jNEr0gfts5tT81fL/vno5j5VdLIm6u7pR7gjFzw20fLe2exbAdnDIF6zRtaXrafovgvYhVCkaTsGnF5STD+Ax8FC6vbRpIQGcV7LyVCcdKyxEs0jIAaRL7/pPJ0hX8qCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511676; c=relaxed/simple;
	bh=H9RcXIwiWUq0JGOm1ZTKIwPAmScmxjyBR0Kh6TUjioM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZuoqesSPMSRvlEfxvFsKIiktfApCdFaM5O2DduVmZkwhKA0+RgKPfdzjU3Jyvq7VpOXwl2ilMAM4Kvaj5bgWsIz0qM3chkxlvY9Xf6pLYNuJqYHeHqHWtDwdUntbyhJhevT2M0y26J3mmv6dBSfivBbhXoDqKIi1jj1hjNYxXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=00SmjGQe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGSmQ3dH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O+0Zf1Ke; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5uKPv/xx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="00SmjGQe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGSmQ3dH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O+0Zf1Ke";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5uKPv/xx"
Received: from hawking.suse.de (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id 7C99475B27;
	Mon, 15 Jun 2026 08:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781511673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEMFmt8TpTChnVBW1oINDFeDbvwK5qg/ts+tVGLgFE4=;
	b=00SmjGQekfRMI2a4nPcidhWzQO4m7IPrhZVXXZ0pHvCBq6N+LYKe+xTzr6SqlGjjBSxsKY
	piMJRE7l+TfaiHmiLnJzWeNmoQ01935RbFgf1Dxiwf89ZGkVNdHrPuG33qPFgDl/rzIpHT
	t5PLj79/U0jmo9OBm7kkSZvzf0sWzZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781511673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEMFmt8TpTChnVBW1oINDFeDbvwK5qg/ts+tVGLgFE4=;
	b=IGSmQ3dHMCSQ8Bt17qqsNwVWBKpei51aqPvK5cvI2gH0E69XOCIL7uqt+waacWYJ+Pwlmo
	zGOao01C0axraCBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781511672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEMFmt8TpTChnVBW1oINDFeDbvwK5qg/ts+tVGLgFE4=;
	b=O+0Zf1Kede23tZObEsMJ500IJAklAJhZ+rH6jDgDQ4dByMfbiL+1pzWP+jhl5Jku6rSNct
	9FCDpgX/Ke/Q7KDHXQ1aD4L+BjHTC76BOzI6nXd7vXQyBfVcXvka7uuApKclSKfaw9RZ44
	tjjo9EssNNiP+RJ10KsRg6z6VpVOe8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781511672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEMFmt8TpTChnVBW1oINDFeDbvwK5qg/ts+tVGLgFE4=;
	b=5uKPv/xxuYQO7zwWyAaQ6rr3x7B1IywxUSWbY2LfgbvIx9vVzIzJMmYGh7Swr7O/3sIpOv
	Np6H4wb7ewmD24Cw==
Received: by hawking.suse.de (Postfix, from userid 17005)
	id 6B1124A056F; Mon, 15 Jun 2026 10:21:12 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>,  Joerg Roedel <joro@8bytes.org>,
  Will Deacon <will@kernel.org>,  Robin Murphy <robin.murphy@arm.com>,
  Paul Walmsley <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,
  iommu@lists.linux.dev,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Xu Lu <luxu.kernel@bytedance.com>,
  cuiyunhui@bytedance.com,  yuanzhu@bytedance.com
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
In-Reply-To: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
	(Zhanpeng Zhang's message of "Mon, 15 Jun 2026 14:48:55 +0800")
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
Date: Mon, 15 Jun 2026 10:21:12 +0200
Message-ID: <mvmik7kz01z.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.18 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.910];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLajr16mudzow8bnf6sy)];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,hawking.suse.de:helo]
X-Spam-Level: 
X-Spam-Score: -4.18

On Jun 15 2026, Zhanpeng Zhang wrote:

> +config RISCV_IOMMU_32BIT_ACCESS
> +	bool "Use 32-bit accesses for RISC-V IOMMU registers"
> +	depends on RISCV_IOMMU
> +	help
> +	  Say Y when the RISC-V IOMMU MMIO window cannot be accessed
> +	  using naturally aligned 64-bit loads and stores.
> +
> +	  When enabled, 64-bit IOMMU registers are accessed as paired
> +	  32-bit MMIO operations. This option does not describe an RV32
> +	  kernel or a 32-bit IOMMU architecture.

What is the expected setting in a generic kernel?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
