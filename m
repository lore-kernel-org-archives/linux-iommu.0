Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF03D96E
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Haa2w7Xj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sd2dsJt8707J4YuJefExGERUpgOFM0GyvziSEl19TJg=; b=Haa2w7XjcLw6Al7rcSZJ+RvpXT
	ib1et/H5dRlxPwZnLlh+YAQHvLMvvZQsiBOOB575wPOWOORecGB1FrxYMhVjcfwhKRdGmiLAYIm0V
	lgbAgJCGoy4YDUjTwfNMKxvFN17xSYaXpAeYYNnxu1cntGRt9LIKqpi6XM6T7ZMKC0lYztTe3wsIP
	iWtUXejxr2dcIYrlFRbzuSi8aP0hH3Rj1XnO+nItMUqcKhne2xpUB1lwIcOK7g6F/xLNqVVqwmj7Y
	QVzDQ7mVQlKi4nVOBXyKXajfKNr3sd6IzJ7vfARY6C/HkokTZmmvI5W9FoTRrIVttYHlXL5dQYJwv
	CSdrScIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r3MRf-004HxS-0z;
	Wed, 15 Nov 2023 20:25:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F130E300427; Wed, 15 Nov 2023 21:25:06 +0100 (CET)
Date: Wed, 15 Nov 2023 21:25:06 +0100
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
Message-ID: <20231115202506.GB19552@noisy.programming.kicks-ass.net>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
 <20231115125624.GF3818@noisy.programming.kicks-ass.net>
 <20231115120401.3e02d977@jacob-builder>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115120401.3e02d977@jacob-builder>

On Wed, Nov 15, 2023 at 12:04:01PM -0800, Jacob Pan wrote:

> we are interleaving cacheline read and xchg. So made it to

Hmm, I wasn't expecting that to be a problem, but sure.

> 	for (i = 0; i < 4; i++) {
> 		pir_copy[i] = pid->pir_l[i];
> 	}
> 
> 	for (i = 0; i < 4; i++) {
> 		if (pir_copy[i]) {
> 			pir_copy[i] = arch_xchg(&pid->pir_l[i], 0);
> 			handled = true;
> 		}
> 	}
> 
> With DSA MEMFILL test just one queue one MSI, we are saving 3 xchg per loop.
> Here is the performance comparison in IRQ rate:
> 
> Original RFC 9.29 m/sec, 
> Optimized in your email 8.82m/sec,
> Tweaked above: 9.54m/s
> 
> I need to test with more MSI vectors spreading out to all 4 u64. I suspect
> the benefit will decrease since we need to do both read and xchg for
> non-zero entries.

Ah, but performance was not the reason I suggested this. Code
compactness and clarity was.

Possibly using less xchg is just a bonus :-)
