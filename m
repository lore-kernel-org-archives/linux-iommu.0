Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B0525F
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dQZrzXJa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+r8ivjIfgLZ88YUedyxhSyz2DStbFMG0ACvLMyfn4T8=; b=dQZrzXJarcPyscofRf+ECdjQh3
	s2ZanwodO9ept5SfgdHuqz+W3dpJJaRsGTClg1RCPbdW4uwkneSurlUMt6KsqbZ/eF6FB8TlgPlJ6
	m1PPue2AYsmhzXh1mR5lgXggeZl4dGJ7Ka1275y6fMwAF0zeAMlb3uxXd367bWr5AuXHrC4bnFSVf
	0jWyCxQm1IRy3oE/Mz+/H/t6I48ZPo1b9uLaeEXDNyJoAcPThLzw6OO/gxC4H0URpdJppHV+WuzzJ
	496rAqlN0u8oycYWDFB9hetPDb225KM9vZnsqzjOnh31C8x4B4Tq+xHgT4I1ivsjg4wxvG7BmFMl1
	CpjaXSDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r3FDq-00EEE7-0q; Wed, 15 Nov 2023 12:42:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ABAE4300427; Wed, 15 Nov 2023 13:42:21 +0100 (CET)
Date: Wed, 15 Nov 2023 13:42:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
	iommu@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
	Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
	seanjc@google.com, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RFC 09/13] x86/irq: Install posted MSI notification
 handler
Message-ID: <20231115124221.GE3818@noisy.programming.kicks-ass.net>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>

On Sat, Nov 11, 2023 at 08:16:39PM -0800, Jacob Pan wrote:

> +static __always_inline inline void handle_pending_pir(struct pi_desc *pid, struct pt_regs *regs)
> +{
> +	int i, vec = FIRST_EXTERNAL_VECTOR;
> +	u64 pir_copy[4];
> +
> +	/*
> +	 * Make a copy of PIR which contains IRQ pending bits for vectors,
> +	 * then invoke IRQ handlers for each pending vector.
> +	 * If any new interrupts were posted while we are processing, will
> +	 * do again before allowing new notifications. The idea is to
> +	 * minimize the number of the expensive notifications if IRQs come
> +	 * in a high frequency burst.
> +	 */
> +	for (i = 0; i < 4; i++)
> +		pir_copy[i] = raw_atomic64_xchg((atomic64_t *)&pid->pir_l[i], 0);

Might as well use arch_xchg() and save the atomic64_t casting.

> +
> +	/*
> +	 * Ideally, we should start from the high order bits set in the PIR
> +	 * since each bit represents a vector. Higher order bit position means
> +	 * the vector has higher priority. But external vectors are allocated
> +	 * based on availability not priority.
> +	 *
> +	 * EOI is included in the IRQ handlers call to apic_ack_irq, which
> +	 * allows higher priority system interrupt to get in between.
> +	 */
> +	for_each_set_bit_from(vec, (unsigned long *)&pir_copy[0], 256)
> +		call_irq_handler(vec, regs);
> +
> +}
