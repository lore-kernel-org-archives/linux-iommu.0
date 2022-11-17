Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8A48BE2
	for <iommu@lists.linux.dev>; Thu, 17 Nov 2022 17:00:31 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso5570357wme.5
        for <iommu@lists.linux.dev>; Thu, 17 Nov 2022 09:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fvc1vui8FhItk/x7dVzpPLEtk9PzyJtzG8SF5gpDffI=;
        b=8JhzdDOV8/Cj1I9cUhd+ootq5Qi52Yi4e6ygTcEwfaWW43egH9ZtVbhSHvys+jNyid
         Prb2cSdJ7/syDO4hwDaOv7D19FNp4BxKgWBg5VB4mTN6lTIs7XTPwxySZ1ShDXCRt9qi
         OKcDiXogpuyD1ypQE+OXnL8TCJb+4oId34vWLpETXIsqy9a2nuM7FBMe00VDFy1SwKZB
         hKNXlhmn9YqR8h102bNz4H/lW5+/IMKZkmpx88dcZ/gK0B7PvZDtg3IrIpi5D81u+2Uc
         0yTFfznjemh3NdJNSdmr+lwJ1jaHC34cEprJgOp4tcGItP7WtK0KWo/WwiT3JQ7+O1Kv
         OyLw==
X-Gm-Message-State: ANoB5pl4rTOWZSZN2miCSREFWL3WtG0xnJKimYvsUWM7rNdNLDvmlj8/
	CKBsA8Jv1mvcv32SxUHeSeY=
X-Google-Smtp-Source: AA0mqf4w9C1S1sB2BGqir78CRk3XkLTTZMCy6CDAwQK6aFc9zQBLMizrSKjohdREPe3RgMeUrWRtJg==
X-Received: by 2002:a1c:f003:0:b0:3cf:e87a:806a with SMTP id a3-20020a1cf003000000b003cfe87a806amr5835046wmb.58.1668704429531;
        Thu, 17 Nov 2022 09:00:29 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b003b476cabf1csm1769710wml.26.2022.11.17.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:00:28 -0800 (PST)
Date: Thu, 17 Nov 2022 17:00:21 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mikelley@microsoft.com>,
	hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, luto@kernel.org, peterz@infradead.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lpieralisi@kernel.org, robh@kernel.org,
	kw@linux.com, bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	thomas.lendacky@amd.com, brijesh.singh@amd.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	Tianyu.Lan@microsoft.com, kirill.shutemov@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
	isaku.yamahata@intel.com, dan.j.williams@intel.com,
	jane.chu@oracle.com, tony.luck@intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [Patch v3 13/14] PCI: hv: Add hypercalls to read/write MMIO space
Message-ID: <Y3Zopc8B5xQLil4d@liuwe-devbox-debian-v2>
References: <1668624097-14884-1-git-send-email-mikelley@microsoft.com>
 <1668624097-14884-14-git-send-email-mikelley@microsoft.com>
 <Y3ZQVpkS0Hr4LsI2@liuwe-devbox-debian-v2>
 <Y3ZiAE+t6+ZptUuo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ZiAE+t6+ZptUuo@google.com>

On Thu, Nov 17, 2022 at 04:32:00PM +0000, Sean Christopherson wrote:
> On Thu, Nov 17, 2022, Wei Liu wrote:
> > On Wed, Nov 16, 2022 at 10:41:36AM -0800, Michael Kelley wrote:
> > [...]
> > >  
> > > +static void hv_pci_read_mmio(struct device *dev, phys_addr_t gpa, int size, u32 *val)
> > > +{
> > > +	struct hv_mmio_read_input *in;
> > > +	struct hv_mmio_read_output *out;
> > > +	u64 ret;
> > > +
> > > +	/*
> > > +	 * Must be called with interrupts disabled so it is safe
> > > +	 * to use the per-cpu input argument page.  Use it for
> > > +	 * both input and output.
> > > +	 */
> 
> There's no need to require interrupts to be disabled to safely use a per-cpu
> variable, simply disabling preemption also provides the necessary protection.
> And this_cpu_ptr() will complain with CONFIG_DEBUG_PREEMPT=y if preemption isn't
> disabled.
> 
> IIUC, based on the existing code, what is really be guarded against is an IRQ arriving
> and initiating a different hypercall from IRQ context, and thus corrupting the page
> from this function's perspective.

Exactly. Michael's comment did not say this explicitly but that's what's
being guarded.

> 
> > Perhaps adding something along this line?
> > 
> > 	WARN_ON(!irqs_disabled());
> 
> Given that every use of hyperv_pcpu_input_arg except hv_common_cpu_init() disables
> IRQs, what about adding a helper to retrieve the pointer and assert that IRQs are
> disabled?  I.e. add the sanity for all usage, not just this one-off case.
> 

We can potentially introduce a pair of get/put functions for these pages,
but let's not feature-creep here...

> And since CPUHP_AP_ONLINE_DYN => hv_common_cpu_init() runs after scheduling is
> activated by CPUHP_AP_SCHED_WAIT_EMPTY, I believe that hv_common_cpu_init() is
> theoretically broken.  Maybe someone can look at that when fixing he KVM vs.
> Hyper-V issue?
> 
> https://lore.kernel.org/linux-hyperv/878rkqr7ku.fsf@ovpn-192-136.brq.redhat.com
> https://lore.kernel.org/all/87sfikmuop.fsf@redhat.com

I read the mails before have not looked into those since they are only
theoretical per those threads. Sorry.

The only scenario I can think of for CPU hotplug right now is the
(upcoming) Linux root kernel, I guess we will cross the bridge when we
get there.

Thanks,
Wei.
