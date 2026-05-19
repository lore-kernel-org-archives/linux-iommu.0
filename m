Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5A31AA8F
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201943; cv=none; b=Ajxdhr99WA/1SAoh+6llGpIE6zWcaWuNPTSSHcYkf2Wsjqvt+ecZoDLf9uyZ53m55+SPobd9zbslWuAGEtg7NbPGdwsLZd+AXZbKKU2gHFCHLbsVQswzRfzUQOgw9F4Y+/Dm5zoGe4NlU3UQQxG/tp8G4untmSCURb2r3ypaXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201943; c=relaxed/simple;
	bh=cS793SwOviBnkbKXY6VDrZ6GHZeAkO5ji2zHNpUdkV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpBDiiguPt18K5IEODCsHJhnrYeZMa6kVi7yCEid/MLCTaNrv6u8/S+CcrY01T7jq5M5yuZhuA029yh4GGLKPMjXbNCJsNj98I403LId4i7MKNQVo8szBfAJDR8czUW7/z0wL66ZTUUo+fl/NiEq3SeC1WAfFON525/ma/lw/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/Hn76zC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/Hn76zC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so1865e9.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779201940; x=1779806740; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7Nz6XFDKFDcI1TVcowrB8v0PKJyf/qnRnOMl+2I2pU=;
        b=s/Hn76zCyIWdZ9gb3jCwPNTg3mmCHQSR9i/lbof7Ho5x7EkamFIXZcRXjJEvZ04tfC
         T9A9ygDyxepm2JXMaQ8n1j/ZJhHbBuo90EzTdadV62Zj4upGjwwQsG7Mh6Xs+Qxv/itO
         PXbG+WqZXPE1sOAxASv4FV5suyXcH70gl7ixV3lPmO2RuK4ynle21lZPLKS1Q8S3ydHz
         N+KKg5fSOJouULtBeRKyaRctxa2HpJzdrlGap8LTK8RUnnZFCEY0DIctbgIPCYEIjtNT
         /lSbl0MuKvSQhLRi6YoMVI7B9kTgFN/12IwG6MbXXtMHh+5YoRDYciV1zJb65eoSXD+W
         kOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201940; x=1779806740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7Nz6XFDKFDcI1TVcowrB8v0PKJyf/qnRnOMl+2I2pU=;
        b=BlVgjyx9dsq543xuXd970maYrN9zik2E3vOTbcpr3Cp2Ezacs0HH8fGh5xIYKRzORW
         lThmUIvHTfp6ch8vFnlTWN8E34/u7VYkJPObTy3YPsnQdy4qtN24Fi434Y8nBN74gEmL
         07K8sbLYUYeLV6TkugPdnaqvxefWmhtipP9CIdI/BwZK+Kd5IUC+AplszRqbqGn7ouO0
         Hui9ygL669sFob/IqYtJnzw0oEBtvYczMSyd5cdzywyASJ+Dfk3BXOEF4m2rb2sZO3QR
         xweXMXN5hjE/RnH6e95ZQ9hlGxmKJ3jbQurK4/wspATreLg3uRj20l81yTdL+Hy0PuaU
         bXSw==
X-Forwarded-Encrypted: i=1; AFNElJ/7zV7FL+Q+8vnBVkni7z2NxpwQ4/X8CI2tAdh19hZz7NI6ZZTvrp0zZK0whMZrT1pFwooFig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq+njXkZD+LJ7/9PkHJkdvvo7tPe/GBlm+dgrsNtBos6rc1na5
	IUdOyYfkY76KuWPraT2B1CCKXUJ8ys2pNcjZ4esKA3B2Dl7XKalLFpfZZz7oWyiXeQ==
X-Gm-Gg: Acq92OEBtRBc3mptFwNkaVxgDIDZCElfCa5GNlKYwCdZO4Db+KQ7/eclvKsH62wJkBb
	YcfqqnTEsBgkOC+l4iioEdCMWEam+NrJOg7BqT3AzuX/+nYES5ZFFKgeeEpiFG2yJZGtdls+tes
	orQZs7/n/mYof5pSaEFqY9hiuIAdDCDdLk1pC0vkUKh+aaGyD0SCwLe7M/RNM2VmmsLAkdXwW1d
	GzzTi9oLfTSNXdmeGkyqz2xIUAK9Fel/dCnzfaRkaOT/l3FWyIUhlMkd3ppO7jg9RQP+wPAri6w
	Ho3SFxczDlhGf8DyRairCNbKw+mKVhvWe/cKrUc3majtr39FWJC9xrcZxVWKMgZlsPewStZhia3
	CrIqygkb+oRw9E5tRYpf8Cz0kEunqmS9NOSCj8qU+wdVn8N5bhclRpyYT8iHmsLD1SLnaMBDW4x
	bcVxmVYhK9VbAP9jqvH+9AOsm1cY837wixOa5tr5KK/wm55UQywJ/BK9O10AQ27t9EpaMIP7eb0
	II=
X-Received: by 2002:a05:600d:6401:20b0:489:1f6a:4ac0 with SMTP id 5b1f17b1804b1-48ffa0627e7mr3099895e9.0.1779201939945;
        Tue, 19 May 2026 07:45:39 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm48721081f8f.18.2026.05.19.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:45:39 -0700 (PDT)
Date: Tue, 19 May 2026 14:45:35 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agx3j6Oc8QivZ3RG@google.com>
References: <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <20260519143529.GD7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519143529.GD7702@ziepe.ca>

On Tue, May 19, 2026 at 11:35:29AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 01:41:42PM +0000, Mostafa Saleh wrote:
> > On Tue, May 19, 2026 at 10:29:11AM -0300, Jason Gunthorpe wrote:
> > > On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> > > > On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > > > > >> 
> > > > > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > > > > >> that we can use it in the conditional above.
> > > > > >
> > > > > > I have this patch, with that I can boot with your series unmodified,
> > > > > > but I will need to do more testing.
> > > > > >
> > > > > 
> > > > > Thanks, I can add this to the series once you complete the required testing.
> > > > > 
> > > > 
> > > > I am still running more tests, but looking more into it. Setting
> > > > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> > > > guest shouldn’t try to decrypt arbitrary memory as it can include
> > > > sensitive information (for example in case of virtio sub-page
> > > > allocation) and should strictly rely on the restricted-dma-pool
> > > > for that.
> > > 
> > > ??
> > > 
> > > Where does force_dma_unencrypted() cause arbitary memory passed into
> > > the DMA API to be decrypted? That should never happen???
> > 
> > Sorry, maybe arbitrary is not the right expression again :)
> > I mean that, with emulated devices that use the DMA-API under pKVM,
> > they will map memory coming from other layers (VFS, net) through
> > vitrio-block, virtio-net... These can be smaller than a page, and
> > using force_dma_unencrypted() will share the whole page.
> 
> force_dma_unencrypted() should only trigger swiotlb and that never
> memcpy's more than necessary?
> 
> Where does it do otherwise? That sounds like a bug?

Agh, I got confused and thought that it can be triggered from dma_map()
too. I need to figure out why that made pKVM guests boot with broken
restricted-dma-pool then.

However, it should not alway use SWIOTLB? It can trigger decryption for
any memory returned from __dma_direct_alloc_pages() which can come
from alloc_pages_node().

Thanks,
Mostafa


> 
> Jason
