Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437E487AB
	for <iommu@lists.linux.dev>; Wed,  6 Dec 2023 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aAvqveN+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Krj3CK7I"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701880409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mEaYjes49h5l2UrFqiq7e/jCeK/naAAzBiirxhQzhc8=;
	b=aAvqveN+yO3hoMfIlimEtuaxwhgvna0Ou/j29UGyQS7lm54ba0nXr0Tt1as+OBFPtwVpdK
	j49aitst25afRLI6yPRRZMOknvg8XN/djd9ir7We/GY7KWj3e6EvV3rujrCITZzozzJfzi
	NxAaygeYrNqoUGv0/h9XCNOPg2BrJ6ihwanGEV14zbyAxuJwM63Mni9IdC7E/CSFfZxLC4
	15tx/FMXHlfMwlmtkVdKKvWoaTLTFxAOn55L9lE+GwTpZsUcMeqTLwpWjWclL1ArJiz9kr
	2XuzMbwKjzLL5XGrNNo+arQ+Nt9PDsGcEQa4IRXZpyOk/nZgFwlE8O07w7U3fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701880409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mEaYjes49h5l2UrFqiq7e/jCeK/naAAzBiirxhQzhc8=;
	b=Krj3CK7I8oY4UPJ8ojb0Z+E5QF/2QTLdhVsRXSSUnhW6eWEJfzPDr+g8EsQhCtDQFN8q1y
	CZdmFnO8KDP6huCQ==
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Joerg Roedel
 <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
 <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 maz@kernel.org, peterz@infradead.org, seanjc@google.com, Robin Murphy
 <robin.murphy@arm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH RFC 01/13] x86: Move posted interrupt descriptor out of
 vmx code
In-Reply-To: <20231112041643.2868316-2-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-2-jacob.jun.pan@linux.intel.com>
Date: Wed, 06 Dec 2023 17:33:28 +0100
Message-ID: <87wmtruw87.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> +/* Posted-Interrupt Descriptor */
> +struct pi_desc {
> +	u32 pir[8];     /* Posted interrupt requested */
> +	union {
> +		struct {
> +				/* bit 256 - Outstanding Notification */
> +			u16	on	: 1,
> +				/* bit 257 - Suppress Notification */
> +				sn	: 1,
> +				/* bit 271:258 - Reserved */
> +				rsvd_1	: 14;
> +				/* bit 279:272 - Notification Vector */
> +			u8	nv;
> +				/* bit 287:280 - Reserved */
> +			u8	rsvd_2;
> +				/* bit 319:288 - Notification Destination */
> +			u32	ndst;

This mixture of bitfields and types is weird and really not intuitive:

/* Posted-Interrupt Descriptor */
struct pi_desc {
	/* Posted interrupt requested */
	u32			pir[8];

	union {
		struct {
				/* bit 256 - Outstanding Notification */
			u64	on	:  1,
				/* bit 257 - Suppress Notification */
				sn	:  1,
				/* bit 271:258 - Reserved */
					: 14,
				/* bit 279:272 - Notification Vector */
				nv	:  8,
				/* bit 287:280 - Reserved */
					:  8,
				/* bit 319:288 - Notification Destination */
				ndst	: 32;
		};
		u64		control;
	};
	u32			rsvd[6];
} __aligned(64);

Hmm?

> +static inline bool pi_test_and_set_on(struct pi_desc *pi_desc)
> +{
> +	return test_and_set_bit(POSTED_INTR_ON,
> +			(unsigned long *)&pi_desc->control);

Please get rid of those line breaks.

Thanks,

        tglx
