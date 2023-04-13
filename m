Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37691361
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 01:05:31 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso9093659wmb.1
        for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 18:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681347929; x=1683939929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UkmFhtjxWacnMCiO0oQv3pNqPctVfrO7QeMfZUAp/o=;
        b=h053+8+gaqrmustSs75Lkl4ufz9p0xLI279tuLc243b8TPHxP3BnuCxYZ43o4jxqjn
         s96o+hAV52mllfyoA3aqCUasTGSag1Kzey7KdwM4tc+c+vCPuzqEOr5Wrj/aLzeg/1cN
         8wl+oxt99ajRYYOdyHEOx58Ipx98Rq9ef+pG0kduFzS1A++aCOnFL14/S8n6HVU0yA+S
         68dL/bnqT84sDEBPBqW2f03AwgKBtPiz/oR7xLSpJAes48w4BepSB3cgjIaqjImx8zFP
         mamu8KvtnU1DMineUMxOE/CHPIB4bX2t3B6qhkz8ByPKSCNprYiOEu+Wj//+0DoSNMz+
         gfmA==
X-Gm-Message-State: AAQBX9ekN3YGmwhy3n1+yF43uEk+xYt3ES9CFkICm2oRXii6sl2R2j9M
	8JJvPsIuAHBQw4hzTdUuYUA=
X-Google-Smtp-Source: AKy350bDDKhpd8MexEw/4tmaBStYzgn6bVDTaN7FSwiN/JqKxJOEBlxdeUeD/HykCmrarjBMVB1+fw==
X-Received: by 2002:a1c:7701:0:b0:3f0:80cf:f2d5 with SMTP id t1-20020a1c7701000000b003f080cff2d5mr48283wmi.11.1681347929308;
        Wed, 12 Apr 2023 18:05:29 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c468800b003f09563445asm4128817wmo.0.2023.04.12.18.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:05:28 -0700 (PDT)
Date: Thu, 13 Apr 2023 01:05:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, luto@kernel.org,
	peterz@infradead.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lpieralisi@kernel.org,
	robh@kernel.org, kw@linux.com, bhelgaas@google.com, arnd@arndb.de,
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
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
Subject: Re: [PATCH v7 00/12] Add PCI pass-thru support to Hyper-V
 Confidential VMs
Message-ID: <ZDdVVJ2P+sJaUgtV@liuwe-devbox-debian-v2>
References: <1679838727-87310-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679838727-87310-1-git-send-email-mikelley@microsoft.com>

On Sun, Mar 26, 2023 at 06:51:55AM -0700, Michael Kelley wrote:
[...]
> 
> Michael Kelley (12):
>   x86/ioremap: Add hypervisor callback for private MMIO mapping in coco VM
>   x86/hyperv: Reorder code to facilitate future work
>   Drivers: hv: Explicitly request decrypted in vmap_pfn() calls
>   x86/mm: Handle decryption/re-encryption of bss_decrypted consistently
>   init: Call mem_encrypt_init() after Hyper-V hypercall init is done
>   x86/hyperv: Change vTOM handling to use standard coco mechanisms
>   swiotlb: Remove bounce buffer remapping for Hyper-V
>   Drivers: hv: vmbus: Remove second mapping of VMBus monitor pages
>   Drivers: hv: vmbus: Remove second way of mapping ring buffers
>   hv_netvsc: Remove second mapping of send and recv buffers
>   Drivers: hv: Don't remap addresses that are above shared_gpa_boundary
>   PCI: hv: Enable PCI pass-thru devices in Confidential VMs

I merged the first 6 from tip/x86/sev and then the rest directly to
hyperv-next.

The hv_netvsc patch did not apply cleanly, but that was easy to fix.

Please check hyperv-next is what you expected.

Thanks,
Wei.
