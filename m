Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D0A953
	for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 22:54:50 +0000 (UTC)
Received: by mail-pf1-f202.google.com with SMTP id d8-20020a62f808000000b005d8047f3bc0so1113114pfh.6
        for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1rUxcsEzgzkuc81EHAiSJThwOfOiPUl0WEkc2IML/M=;
        b=p4sXIDbjE4Nc/nRU1X8iV1XYE4jomrb+UJhtC7J+xEm7INBfiDn27gs/eoHnGlzmRT
         92NbvCgseDZ0JsQv3XF/gwcMtKevWDZckWffhhm1iVJQBk+R5lUHI6CKSOloHvmr5SXD
         BvdY7F8b50dcNqhHzIYk3cub1ZEBEA8+kXj+nWZ5dvUznAb22X/ufd/HOqJW5U4x5C4B
         JQ1TG20xtnMqed4yXHC4Ock+whPxUyHQMHZjkt/JIt8uxh8Qe/UOObrTwEnXqaCLC3js
         c4oFz5cV9DaUM/VtN6S58luTPLE4WRjwkm5QlSNnfO16B01aCPeJv7rypyvXDzgyxkMp
         sLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1rUxcsEzgzkuc81EHAiSJThwOfOiPUl0WEkc2IML/M=;
        b=adGFZxNR6nGmvna6/AQeld/3PL59xLWCeF4MwPLH6Qpn1Y+BJBZYsOtfQTWaMQBP1T
         rY7F0w8/Spua9hl6BxBE5ckAWLEzW109/QcAuHXoeLEdcT/tMbPGWBdRnR+3qT6oH4yT
         xs9fwGTVcvTaniNrXuf5uboP9y/s7I0HVjZg510SM87YNZw8yvqBUFjp+COhJomBLPHy
         Yxocws4XCQFe7ACkitoGi3ohf7LUhQ1AhtcRDEYY71lu/+uM87u46Znej9YC1KyqgmRe
         CubwhG7xhQ88X1Nlg7EoW3YGhYkcW4fCHssBaaNXURAivrdlpRussqgdEOq2JB64pmtm
         jU+A==
X-Gm-Message-State: AO0yUKXyTpugtwaGdzHyEKIyDoyVA+4gdLzuAJ38xIPsgNwvNd14/nFe
	x+ajM7UIOs88898gNrwuKiQWxreuc1U=
X-Google-Smtp-Source: AK7set/sQOffs0k3s7KounKG129lsIZ65HRvR+ia/A/0i253S1K0NbH2/JiaGq46cARK3kvQ+iKylGsp5hE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:864e:0:b0:5d6:4f73:9ad with SMTP id
 x75-20020a62864e000000b005d64f7309admr454083pfd.2.1677106489373; Wed, 22 Feb
 2023 14:54:49 -0800 (PST)
Date: Wed, 22 Feb 2023 14:54:47 -0800
In-Reply-To: <Y/aYQlQzRSEH5II/@zn.tnic>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <Y+av0SVUHBLCVdWE@google.com> <BYAPR21MB168864EF662ABC67B19654CCD7DE9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+bXjxUtSf71E5SS@google.com> <Y+4wiyepKU8IEr48@zn.tnic> <BYAPR21MB168853FD0676CCACF7C249B0D7A09@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+5immKTXCsjSysx@zn.tnic> <BYAPR21MB16880EC9C85EC9343F9AF178D7A19@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y++VSZNAX9Cstbqo@zn.tnic> <Y/aTmL5Y8DtOJu9w@google.com> <Y/aYQlQzRSEH5II/@zn.tnic>
Message-ID: <Y/adN3GQJTdDPmS8@google.com>
Subject: Re: [PATCH v5 06/14] x86/ioremap: Support hypervisor specified range
 to map as encrypted
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Michael Kelley (LINUX)" <mikelley@microsoft.com>, Dave Hansen <dave.hansen@intel.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>, 
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "brijesh.singh@amd.com" <brijesh.singh@amd.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"ak@linux.intel.com" <ak@linux.intel.com>, "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>, 
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jane.chu@oracle.com" <jane.chu@oracle.com>, 
	"tony.luck@intel.com" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 22, 2023, Borislav Petkov wrote:
> On Wed, Feb 22, 2023 at 02:13:44PM -0800, Sean Christopherson wrote:
> > Because vTOM is a hardware feature, whereas the IO-APIC and vTPM being accessible
> > via private memory are software features.  It's very possible to emulate the
> > IO-APIC in trusted code without vTOM.
> 
> I know, but their use case is dictated by the fact that they're using
> a SNP guest *with* vTOM as a SEV feature. And so their guest does
> IO-APIC and vTPM *with* the vTOM SEV feature. That's what I'm trying to
> model.

Why?  I genuinely don't understand the motivation for bundling all of this stuff
under a single "feature".  To me, that's like saying Haswell or Zen2 is a "feature",
but outside of a very few cases where the exact uarch truly matters, nothing pivots
on FMS because the CPU type is not a single feature.
