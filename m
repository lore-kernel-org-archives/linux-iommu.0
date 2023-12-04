Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02842E40C
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C12wCKSA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d0b944650bso3322685ad.1
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 08:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701707899; x=1702312699; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDk8VCjkq3XxlHbdv1HgLMD6AIZzaNXkLSxsVVtlfDU=;
        b=C12wCKSAcQstmL7dYwU3oy1ReNeTAB0GI43f5BHpN5BlG9yKwFetD275MuqTUBtwn6
         0bHI5xcl0ZUWAYgs50+Izp9rGlsQ49z7XV7NUt/0Sp8j8sXv82CW97riMsT2p3S6rsaN
         N004E1V3bkjVLSxrsD05YLNHAS+Dph8J4msZVmwwUXqUbykDGldmsA//Jylp7w7bHu6c
         Pv8V56QpbUvqBdMqx6oZptv37wiVjV9bYYJRPebPgBPxM868gBGHACVqQebSDVkMY4aX
         hRkY1GkYw27MQLum4JvOHxL0y4oDoQ8p9gXXq+OOERVt1wa7LC1L1N9FaaG4va4C9dvN
         h43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707899; x=1702312699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDk8VCjkq3XxlHbdv1HgLMD6AIZzaNXkLSxsVVtlfDU=;
        b=Z1kqkEB8zl0qZeFnOdB+dl2u1Ce8vPq6PiX0ou6wpUi5Xskqd61UMBczkKtlyo/O3W
         zZ59B+T36l61Qh8i2qrL9jikKWuaUQBcSpn/0o92e2+lJDS+uTy5glX0X/FInKX1Dlej
         sc/kqOgO0QvZTOu6ztkTZF2xaEdfIoBbgf89L3moAJ4okJJJBSBRy7c3G4n1TDPOYa2d
         I3ijeNnsAB6lsB5NKmEedTs2+U3dO7s9N5eJDV2JSS09ofM/L9QSphipHSkV9q6A91Rr
         dK6x/nLhvJlOI2yIQUyyyXKj8ymavNTuErRfdio0wDcLn+P+2IKbAcFMW11fUddkQomw
         X1FA==
X-Gm-Message-State: AOJu0YyiP8CkaUVd4PT1fkM+y5UcEJDuEwOyhXY4Xop75EzE41JJxMJH
	jKvrIN65N/tbiec3Pq9AKvU04RAXhxY=
X-Google-Smtp-Source: AGHT+IH0KOf6e9SiOq5ykueCM2o/G5wmIdosmf1/SYoTYHBbgp+mKLWEKcRI/yzXpAEsOcbbgjKj2C8Ipoo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:8204:b0:1d0:71fc:b39c with SMTP id
 x4-20020a170902820400b001d071fcb39cmr163767pln.3.1701707898848; Mon, 04 Dec
 2023 08:38:18 -0800 (PST)
Date: Mon, 4 Dec 2023 08:38:17 -0800
In-Reply-To: <20231204150800.GD1493156@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231202091211.13376-1-yan.y.zhao@intel.com> <20231204150800.GD1493156@nvidia.com>
Message-ID: <ZW4AeZfCYgv6zcy4@google.com>
Subject: Re: [RFC PATCH 00/42] Sharing KVM TDP to IOMMU
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.williamson@redhat.com, pbonzini@redhat.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com, 
	baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 04, 2023, Jason Gunthorpe wrote:
> On Sat, Dec 02, 2023 at 05:12:11PM +0800, Yan Zhao wrote:
> > In this series, term "exported" is used in place of "shared" to avoid
> > confusion with terminology "shared EPT" in TDX.
> > 
> > The framework contains 3 main objects:
> > 
> > "KVM TDP FD" object - The interface of KVM to export TDP page tables.
> >                       With this object, KVM allows external components to
> >                       access a TDP page table exported by KVM.
> 
> I don't know much about the internals of kvm, but why have this extra
> user visible piece?

That I don't know, I haven't looked at the gory details of this RFC.

> Isn't there only one "TDP" per kvm fd?

No.  In steady state, with TDP (EPT) enabled and assuming homogeneous capabilities
across all vCPUs, KVM will have 3+ sets of TDP page tables *active* at any given time:

  1. "Normal"
  2. SMM
  3-N. Guest (for L2, i.e. nested, VMs)

The number of possible TDP page tables used for nested VMs is well bounded, but
since devices obviously can't be nested VMs, I won't bother trying to explain the
the various possibilities (nested NPT on AMD is downright ridiculous).

Nested virtualization aside, devices are obviously not capable of running in SMM
and so they all need to use the "normal" page tables.

I highlighted "active" above because if _any_ memslot is deleted, KVM will invalidate
*all* existing page tables and rebuild new page tables as needed.  So over the
lifetime of a VM, KVM could theoretically use an infinite number of page tables.
