Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288912108
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 13:03:51 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so1222757wmq.4
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 06:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7wkCq3JYYjQNWqmOzs/TGkUKvgq+3hRmudTaSmEqPs=;
        b=sfwdM++2PNG+Qz2r0p69XX4LtLNrUk8xnU98whhwj5i1OBFpI42ZI0TjdnrmSsQl7B
         MB/tDuw9h/ATgJQlIIRSljB+/C7YcVa6Be18iQpCUDY3fomEid2FTMBRthLxuM1275C0
         KxjA4mGppPgmLPFwchK8rTnoD4jSHYvX6k232NOJgUShEu74mqVXQ7zNp9bUenEWF0ps
         WU2PZUc/c1UKlFvywE5UJl1T6wYQRh6RnUuueG6XPt9L119vQzge4/hFDkz6RYxY74jf
         hHVM26LS+3eS30X+7ZQISI7IGZsqLMrKHMKHet16eGf1LzitMWeM+LX0zHqNH9UJqdae
         4jvg==
X-Gm-Message-State: ACrzQf2aaE0BVdobNLaA4BLWZwj5Ubvjop5PSHV6eHoTurkXzo8pr2Nb
	Z+4nw7+3se4rOuv4Dk2O8lU=
X-Google-Smtp-Source: AMsMyM5urS48hBL/wzVvS7zFzNQklaqqSmOGIMX6FChyURbZf69XiCWLf0csz6XJ5vyEJ9FlJC3Q7A==
X-Received: by 2002:a1c:4b0f:0:b0:3cf:7bdd:e00b with SMTP id y15-20020a1c4b0f000000b003cf7bdde00bmr7064625wma.110.1667394229311;
        Wed, 02 Nov 2022 06:03:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q9-20020adfdfc9000000b002366d1cc198sm13262890wrn.41.2022.11.02.06.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 06:03:48 -0700 (PDT)
Date: Wed, 2 Nov 2022 13:03:42 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
	sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	luto@kernel.org, peterz@infradead.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
	bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	thomas.lendacky@amd.com, brijesh.singh@amd.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	Tianyu.Lan@microsoft.com, kirill.shutemov@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
	isaku.yamahata@intel.com, dan.j.williams@intel.com,
	jane.chu@oracle.com, seanjc@google.com, tony.luck@intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 02/12] x86/ioapic: Gate decrypted mapping on
 cc_platform_has() attribute
Message-ID: <Y2Jqrr54LfKqHu1n@liuwe-devbox-debian-v2>
References: <1666288635-72591-1-git-send-email-mikelley@microsoft.com>
 <1666288635-72591-3-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666288635-72591-3-git-send-email-mikelley@microsoft.com>

On Thu, Oct 20, 2022 at 10:57:05AM -0700, Michael Kelley wrote:
> Current code always maps the IOAPIC as shared (decrypted) in a
> confidential VM. But Hyper-V guest VMs on AMD SEV-SNP with vTOM
> enabled use a paravisor running in VMPL0 to emulate the IOAPIC.
> In such a case, the IOAPIC must be accessed as private (encrypted).
> 
> Fix this by gating the IOAPIC decrypted mapping on a new
> cc_platform_has() attribute that a subsequent patch in the series
> will set only for Hyper-V guests. The new attribute is named
> somewhat generically because similar paravisor emulation cases
> may arise in the future.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

> ---
>  arch/x86/kernel/apic/io_apic.c |  3 ++-
>  include/linux/cc_platform.h    | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index a868b76..d2c1bf7 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2686,7 +2686,8 @@ static void io_apic_set_fixmap(enum fixed_addresses idx, phys_addr_t phys)
>  	 * Ensure fixmaps for IOAPIC MMIO respect memory encryption pgprot
>  	 * bits, just like normal ioremap():
>  	 */
> -	flags = pgprot_decrypted(flags);
> +	if (!cc_platform_has(CC_ATTR_HAS_PARAVISOR))
> +		flags = pgprot_decrypted(flags);
>  
>  	__set_fixmap(idx, phys, flags);
>  }
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index cb0d6cd..b6c4a79 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -90,6 +90,19 @@ enum cc_attr {
>  	 * Examples include TDX Guest.
>  	 */
>  	CC_ATTR_HOTPLUG_DISABLED,
> +
> +	/**
> +	 * @CC_ATTR_HAS_PARAVISOR: Guest VM is running with a paravisor
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine with
> +	 * a paravisor in VMPL0. Having a paravisor affects things
> +	 * like whether the I/O APIC is emulated and operates in the
> +	 * encrypted or decrypted portion of the guest physical address
> +	 * space.
> +	 *
> +	 * Examples include Hyper-V SEV-SNP guests using vTOM.
> +	 */
> +	CC_ATTR_HAS_PARAVISOR,
>  };
>  
>  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> -- 
> 1.8.3.1
> 
