Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C4381DC
	for <iommu@lists.linux.dev>; Wed,  6 Dec 2023 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kpKD/vsb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tuFs+Cb+"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701880530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxl4ewGQ5elwJdi7+g6XuOrGzg25Va6gBGUGbfw8AQ8=;
	b=kpKD/vsbhY2jkK9vTmMS2f6vX1EGxc6Mc1nXP+MwkprHOfLoWPcGhXRJ19DaTzi7fWFB/Q
	VgqCIecn2yzXbiwO6pVm7tywvE/znv4OZmhLVYdQBs3kZE5B4IIcNLgJjTr4QuyFMGrwnY
	bk3ddiqqDdNVXDSA/de/NJniaryHlVqk7b/Mb+tAIA8PKvuowk2+klq1x1z3A/0FdXMV1F
	FmBTWMACDrrwREMGMNlvl9ylBdWXY8Q4/S6IPUK/XDkP7uT2Zlihh9i2zxHbvLYnP8H+MG
	1HOUw+JlpsZD7y5ftaxY1AgnMsymvRWkFxLSCS0BUld8FVCG7MSoEB9toJN6EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701880530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxl4ewGQ5elwJdi7+g6XuOrGzg25Va6gBGUGbfw8AQ8=;
	b=tuFs+Cb+eiebRES4zsj5+XbCj8Q/4q6gR8NbVMaFXLzGPGHrBK1f15KPSxd3o/bVyDClfr
	XDrgBygWJzm1YXBg==
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Joerg Roedel
 <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
 <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 maz@kernel.org, peterz@infradead.org, seanjc@google.com, Robin Murphy
 <robin.murphy@arm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH RFC 02/13] x86: Add a Kconfig option for posted MSI
In-Reply-To: <20231112041643.2868316-3-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-3-jacob.jun.pan@linux.intel.com>
Date: Wed, 06 Dec 2023 17:35:29 +0100
Message-ID: <87ttovuw4u.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> This option will be used to support delivering MSIs as posted
> interrupts. Interrupt remapping is required.

The last sentence does not make sense.

> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  arch/x86/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 66bfabae8814..f16882ddb390 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -463,6 +463,16 @@ config X86_X2APIC
>  
>  	  If you don't know what to do here, say N.
>  
> +config X86_POSTED_MSI
> +	bool "Enable MSI and MSI-x delivery by posted interrupts"
> +	depends on X86_X2APIC && X86_64 && IRQ_REMAP
> +	help
> +	  This enables MSIs that are under IRQ remapping to be delivered as posted

s/IRQ/interrupt/

This is text and not Xitter.


> +	  interrupts to the host kernel. IRQ throughput can potentially be improved
> +	  by coalescing CPU notifications during high frequency IRQ bursts.
> +
> +	  If you don't know what to do here, say N.
> +
>  config X86_MPPARSE
>  	bool "Enable MPS table" if ACPI
>  	default y
