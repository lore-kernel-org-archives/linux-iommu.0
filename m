Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C506D1B
	for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 18:41:58 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id u9so7394281plf.3
        for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 10:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok45EUB5a0lrC1G1VBEVIJghKeOSx8dIT5YrcpXaZ2U=;
        b=GgjbQSZy1IdPTox+nR5ZLWTTXO7nzY/UMimwyDKci+qHnDHiXVnPsr/YKUeoxdwuCF
         zRyXiMSJLLFbPedh2Ek6TS5A4Tp5q9b4CKjWwJ8AWSfUOkzWDDf0i4Wsuvxw7WcBNMwX
         yBPsHXrxMECfexaRc6rBcBK8ib7PFOK5jxBmM3Bj/mLNrFrkHfQPotqyXTQ83lRqcGpH
         Wgb8FDbkydZZgOKI95IsGhjydWszVFbReaoR+JgIwemL3x7hLv25HLQ9iA3PxJqAsswF
         7gMIiQi7gtC8Zf/qPhn88buWnIrBU+9LuQqHhogX1qcG2uorcOYPD9koLiIuNrvumYBx
         wNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok45EUB5a0lrC1G1VBEVIJghKeOSx8dIT5YrcpXaZ2U=;
        b=1kHuJgdFknfubvI/sK7391rOApsNY6nb6y6p/+vq1v5Zh/blRs0Se7fbdSlj91XYLB
         B9QTKafmUs1fLJrXVppLawYYPEUfOGnZ1+uzW9Xo/44aoNUs+NaLFt7BEbDAJx0oUoPv
         Se+Wk6nrr4KhCO0UI8e8KKH7NWI3I0LPlqCexlBayi/pErA3vBD15lkAupvqWPHcKXKA
         qU5zt+A1iNgG/q6rrcWlWfVXoWqKvbvKPKNacHFhb6RYlqlUa/sPNOGQc3H/Hnr0vXEA
         VsfDDaEMtuSoOE74002QuAUIYr95s2sfG3JGFxy9+6qZSR9ao2dNLb60+r7B+s+bHUdS
         NJNw==
X-Gm-Message-State: AO0yUKWpgCPYmFdvWXkapLW9SdY1SpAFojO1DXRklRq0rKlLT6HxNztJ
	ohJPnL17kY6vLtEB8KmsqnnK3Q==
X-Google-Smtp-Source: AK7set93DJYG63ys9SOctBQRI7ddeFJlbzAb9UdgGVNbO8ool9VJU4UwhLQF6yN0q5ReGJyClZ0xtg==
X-Received: by 2002:a17:902:e551:b0:19a:6cd2:a658 with SMTP id n17-20020a170902e55100b0019a6cd2a658mr234114plf.7.1676054518244;
        Fri, 10 Feb 2023 10:41:58 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b00199190b00efsm3701641pld.97.2023.02.10.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:41:57 -0800 (PST)
Date: Fri, 10 Feb 2023 18:41:54 +0000
From: Sean Christopherson <seanjc@google.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	"hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"brijesh.singh@amd.com" <brijesh.singh@amd.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jane.chu@oracle.com" <jane.chu@oracle.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v5 06/14] x86/ioremap: Support hypervisor specified range
 to map as encrypted
Message-ID: <Y+aP8rHr6H3LIf/c@google.com>
References: <1673559753-94403-1-git-send-email-mikelley@microsoft.com>
 <1673559753-94403-7-git-send-email-mikelley@microsoft.com>
 <Y8r2TjW/R3jymmqT@zn.tnic>
 <BYAPR21MB168897DBA98E91B72B4087E1D7CA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y9FC7Dpzr5Uge/Mi@zn.tnic>
 <BYAPR21MB16883BB6178DDEEA10FD1F1CD7D69@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+JG9+zdSwZlz6FU@zn.tnic>
 <4216dea6-d899-aecb-2207-caa2ae7db0e3@intel.com>
 <BYAPR21MB16886D92828BA2CA8D47FEA4D7D99@BYAPR21MB1688.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16886D92828BA2CA8D47FEA4D7D99@BYAPR21MB1688.namprd21.prod.outlook.com>

Wearing my KVM hat and not my Google hat...

On Thu, Feb 09, 2023, Michael Kelley (LINUX) wrote:
> From: Dave Hansen <dave.hansen@intel.com> Sent: Wednesday, February 8, 2023 9:24 AM
> > 
> > On 2/7/23 04:41, Borislav Petkov wrote:
> > > Or are there no similar TDX solutions planned where the guest runs
> > > unmodified and under a paravisor?
> > 
> > I actually don't think paravisors make *ANY* sense for Linux.

I 100% agree, but Intel made what I think almost entirely irrelevant by refusing
to allow third party code to run in SEAM.

> > If you have to modify the guest, then just modify it to talk to the
> > hypervisor directly.  This code is... modifying the guest.  What does
> > putting a paravisor in the middle do for you?
> 
> One of the original goals of the paravisor was to make fewer
> modifications to the guest, especially in areas that aren't directly related
> to the hypervisor.  It's arguable as to whether that goal played out in
> reality.
> 
> But another significant goal is to be able to move some device emulation
> from the hypervisor/VMM to the guest context.  In a CoCo VM, this move
> is from outside the TCB to inside the TCB.  A great example is a virtual
> TPM.  Per the CoCo VM threat model, a guest can't rely on a vTPM
> provided by the host.

I vehemently disagree with this assertion.  It's kinda sorta true, but only
because Intel and AMD have gone down the road of not providing the mechanisms and
ability for the hypervisor to run and attest to the integrity, functionality, etc.
of (a subset of) the hypervisor's own code.

Taking SEAM/TDX as an example, if the code running in SEAM were an extension of
KVM instead of a hypervisor-agnostic nanny, then there would be no need for a
"paravisor" to provide a vTPM.  It would be very feasible to teach the SEAM-protected
bits of KVM to forward vTPM accesses to a host-provided, signed, attested, and open
source software running in a helper TD.

I fully realize you meant "untrusted host", but statements like "the host can't
be trusted" subconciously reinforce the, IMO, flawed model of hardware vendors
and _only_ hardware vendors providing the trusted bits.

The idea that firmware/software written by hardware vendors is somehow more
trustworthy than fully open source software is simultaneously laughable and
infuriating.  

Anyways, tying things back to the actual code being discussed, I vote against
CC_ATTR_PARAVISOR.  Being able to trust device emulation is not unique to a
paravisor.  A single flag also makes too many assumptions about what is trusted
and thus should be accessed encrypted.
