Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CBF481DB
	for <iommu@lists.linux.dev>; Sat, 24 Feb 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708794457; cv=none; b=kKb32Ox0s99/MpLKBDXsGAch+8HFRA07v4urhMs2HyWG8TJ8Fe8JzcJBr/9Z+dx/4ZXkfg85BvRdoBgwNtFPRnVd/1tn2wcVzfV4g26r7SQ2HHiJk5HC/O8jB7kn7xhISqY6c3cvJURCe052tBkEHFfErBzShDGDOgvHyZBJgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708794457; c=relaxed/simple;
	bh=ozIDoFedItkmER/Orkt229o6FySIYQ15J2Qcqcu6KnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iESOQ1X4QoPhCsDaX+BeyE6T8JPuHTl+DB6XKJGKmpRqITIzs72TlyGeRIR9NCVGGPvQnTp3vHTfmZpS8MlNDUEUiSTj4CeXFE0fdS27pFkkpgsdHbtfv0PfVM8m2jNB1fNRL/vF5pQ0AObfMjL6TApHmpTYKBPDJrL0zIhmRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qGkaMR2; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qGkaMR2"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68ff93c5a15so581226d6.1
        for <iommu@lists.linux.dev>; Sat, 24 Feb 2024 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708794454; x=1709399254; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkEL+dazk0pG/rsK4xpDTlcJ2SMxur3lfWU/aiLk45M=;
        b=1qGkaMR2wpyRD7e6xnEgqT/BCx16x1QefPgpNSTckeJsCJaF1LYknKf00g14QM4NIX
         YBErHR82LwcyBsDHHQHGolYTWRGpkFbrgr37/FlNf0czKWoxfOA7TOs7GoxC2a0C3Y0v
         rypa32Jk1mzmWSuBtPMAKK5VI4h8iBbk7v09f9sE8SshHrbcKWYPl3rdtmFZFD1+aj2h
         qNLR8us9wzrSGzgtC6EtEc+gynzoUA/J8bTkD5b+6q48B7DafzoZARoPDhbgyLMuTtPm
         B6NZkR2R7ihzq6NQlfLgYQrri/aB0Yh5gMIJV3b28OGdMQ0Sei5ezb115oy3Nuft2JOF
         VaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708794454; x=1709399254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkEL+dazk0pG/rsK4xpDTlcJ2SMxur3lfWU/aiLk45M=;
        b=U+mcj2LfpM1ehNb5MtVLurIFG+O0J9HqQchBWIINpRRkIl3hVpB9zbNtWr4qyOxspj
         hs4YLNLMwjMlHggOWQuuDXWebtiMNK1m7E1+SqlA3tt+w8IhwXvKQgpnA0P+Idvwg5xI
         KocB2oBVk90qpGhVdVlBkS8xKSstQHNj1Lrii/ALmM7rpkZTlr/RR+QgPalAZk+xGzkf
         COsD3aXWTFc+yMlLCaM3gP0G3Ya58C4VTTrb78hYZZdjX4yHMA9jJObdz7bjWNrY/Omy
         Lg/3851uvIjvchKHjvSV/U+cxHHDtcx5GBjgBoaFMMUdYIxVFMIQhaXxoVDpHD+lm6yc
         M2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVmYFu1TukRc+i1GYvaR5q+o5ifDGYd6fRzxP+N+KB9QRsapPRJWHox+EDi8O1UY83yAXNtmm77c2xn8u+NxvPrmZE261Y=
X-Gm-Message-State: AOJu0YxdaXsZ5iHsH9ksj2Fj8AfNl2T4D6vzhOsAWhw0jlxVOkTpFPH3
	gBEZRL3Bx1f4V5F+fD8zqQ+p6qWuy4tbI5G4tazLmv0wL1nKPG6HzHLqX6LIBfm3aesTe0R8SI7
	mZW3xRM417Mbz54HptY7s8/fY1jVq6ZetyVXH
X-Google-Smtp-Source: AGHT+IHmL4S1gR28xyNUSOfmm8J8cJvNswhZL87sTfb3FCUn/n4pp1DLBBQWWOfsN4nRQ0T4o6hB3IQAzHQ1UwdL1D8=
X-Received: by 2002:a05:6214:27ca:b0:68f:e43d:a253 with SMTP id
 ge10-20020a05621427ca00b0068fe43da253mr3689819qvb.2.1708794454214; Sat, 24
 Feb 2024 09:07:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-2-vannapurve@google.com>
 <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
 <CAGtprH-95FEUzpc-yxQMo87gpqgMxyz9W8tiWtu_ZHhMW-jjuA@mail.gmail.com>
 <8a6dabdf-dc11-4989-b6b4-b49871ff9ca6@amazon.com> <SN6PR02MB41575CFBC54C46701110703CD44D2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41575CFBC54C46701110703CD44D2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sat, 24 Feb 2024 22:37:19 +0530
Message-ID: <CAGtprH-7SYCBjrck2k7vTtHrWbkdhkOicuM9Yz900xuKHMh1vA@mail.gmail.com>
Subject: Re: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
To: Michael Kelley <mhklinux@outlook.com>
Cc: Alexander Graf <graf@amazon.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"rientjes@google.com" <rientjes@google.com>, "seanjc@google.com" <seanjc@google.com>, 
	"erdemaktas@google.com" <erdemaktas@google.com>, "ackerleytng@google.com" <ackerleytng@google.com>, 
	"jxgao@google.com" <jxgao@google.com>, "sagis@google.com" <sagis@google.com>, 
	"oupton@google.com" <oupton@google.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"pgonda@google.com" <pgonda@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"andrew.jones@linux.dev" <andrew.jones@linux.dev>, "corbet@lwn.net" <corbet@lwn.net>, "hch@lst.de" <hch@lst.de>, 
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 1:56=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Alexander Graf <graf@amazon.com> Sent: Thursday, February 15, 2024 =
1:44 AM
> >
> > On 15.02.24 04:33, Vishal Annapurve wrote:
> > > On Wed, Feb 14, 2024 at 8:20=E2=80=AFPM Kirill A. Shutemov
> > <kirill@shutemov.name> wrote:
> > >> On Fri, Jan 12, 2024 at 05:52:47AM +0000, Vishal Annapurve wrote:
> > >>> Modify SWIOTLB framework to allocate DMA memory always from SWIOTLB=
.
> > >>>
> > >>> CVMs use SWIOTLB buffers for bouncing memory when using dma_map_* A=
PIs
> > >>> to setup memory for IO operations. SWIOTLB buffers are marked as sh=
ared
> > >>> once during early boot.
> > >>>
> > >>> Buffers allocated using dma_alloc_* APIs are allocated from kernel =
memory
> > >>> and then converted to shared during each API invocation. This patch=
 ensures
> > >>> that such buffers are also allocated from already shared SWIOTLB
> > >>> regions. This allows enforcing alignment requirements on regions ma=
rked
> > >>> as shared.
> > >> But does it work in practice?
> > >>
> > >> Some devices (like GPUs) require a lot of DMA memory. So with this a=
pproach
> > >> we would need to have huge SWIOTLB buffer that is unused in most VMs=
.
> > >>
> > > Current implementation limits the size of statically allocated SWIOTL=
B
> > > memory pool to 1G. I was proposing to enable dynamic SWIOTLB for CVMs
> > > in addition to aligning the memory allocations to hugepage sizes, so
> > > that the SWIOTLB pool can be scaled up on demand.
> > >
>
> Vishal --
>
> When the dynamic swiotlb mechanism tries to grow swiotlb space
> by adding another pool, it gets the additional memory as a single
> physically contiguous chunk using alloc_pages().   It starts by trying
> to allocate a chunk the size of the original swiotlb size, and if that
> fails, halves the size until it gets a size where the allocation succeeds=
.
> The minimum size is 1 Mbyte, and if that fails, the "grow" fails.
>

Thanks for pointing this out.

> So it seems like dynamic swiotlb is subject to the almost the same
> memory fragmentation limitations as trying to allocate huge pages.
> swiotlb needs a minimum of 1 Mbyte contiguous in order to grow,
> while huge pages need 2 Mbytes, but either is likely to be
> problematic in a VM that has been running a while.  With that
> in mind, I'm not clear on the benefit of enabling dynamic swiotlb.
> It seems like it just moves around the problem of needing high order
> contiguous memory allocations.  Or am I missing something?
>

Currently the SWIOTLB pool is limited to 1GB in size.  Kirill has
pointed out that devices like GPUs could need a significant amount of
memory to be allocated from the SWIOTLB pool. Without dynamic SWIOTLB,
such devices run the risk of memory exhaustion without any hope of
recovery.

In addition, I am proposing to have dma_alloc_* APIs to use the
SWIOTLB area as well, adding to the memory pressure. If there was a
way to calculate the maximum amount of memory needed for all dma
allocations for all possible devices used by CoCo VMs then one can use
that number to preallocate SWIOTLB pool. I am arguing that calculating
the maximum bound would be difficult and instead of trying to
calculate it, allowing SWIOTLB to scale dynamically would be better
since it provides better .

So if the above argument for enabling dynamic SWIOTLB makes sense then
it should be relatively easy to append hugepage alignment restrictions
for SWIOTLB pool increments (inline with the fact that 2MB vs 1MB size
allocations are nearly equally prone to failure due to memory
fragmentation).

> Michael
>
> > > The issue with aligning the pool areas to hugepages is that hugepage
> > > allocation at runtime is not guaranteed. Guaranteeing the hugepage
> > > allocation might need calculating the upper bound in advance, which
> > > defeats the purpose of enabling dynamic SWIOTLB. I am open to
> > > suggestions here.
> >
> >
> > You could allocate a max bound at boot using CMA and then only fill int=
o
> > the CMA area when SWIOTLB size requirements increase? The CMA region
> > will allow movable allocations as long as you don't require the CMA spa=
ce.
> >
> >
> > Alex
>
