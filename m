Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7F82D9A
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716504480; cv=none; b=qNu3r+Ro9yaSnu0htJuwxa/f4jgKK+e4Schhz5vO8UCseBCMa22lafXQTXTYytN0SkPoeGFvOJLJ8i8fhLCBSCTTC/nCTrWhk8TXKyG5rjf5su6m720ofQasdDjvZuf1SdZ2AJ6Ha7trB3kUriY4+hfOkK+w1q3sHAEnyaDhqGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716504480; c=relaxed/simple;
	bh=HnF8AtU9RwwjN5OY93RQVfOy46JVeOd8hfjNpCw419U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHUhKYOy0oIjPiASe3fR7YELPGojJMPXxd/sjsNAGwMHSDvcyYB/+BJiWSSQjSrv25NaKKePoJz5lUPEaFJulAX12o3ZLWW/KIkrvFeeZ1lax0qGb8YDE+GcR+RnNnuvpgs+4d6UfimsbVBjdWriFmoSs+82H1KxxLVVWZJACVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHvfFZPS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHvfFZPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716504478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbTJpo/tHaM6pFlC2j0n0rj03NY8O+M9Z61btdQH21o=;
	b=hHvfFZPSFkX637FAAiEQWRFPdm3vjlPoCs4/FPzM45Pgz3Kd+yhP8pZaFztUyE9A93vwPy
	PYWjAgC9LHAGwRXuA86oV7Cg2X+B4PjDLMC8IaGgTsw+jOiiOzryYmxoLhdUXT549W/22V
	KrzB/2V1d78IXSJtlxduk2l7fCnQ3wY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-F5o7BwfxNw28iA_qNZkrnQ-1; Thu, 23 May 2024 18:47:57 -0400
X-MC-Unique: F5o7BwfxNw28iA_qNZkrnQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1b65780b7so226465139f.2
        for <iommu@lists.linux.dev>; Thu, 23 May 2024 15:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716504476; x=1717109276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbTJpo/tHaM6pFlC2j0n0rj03NY8O+M9Z61btdQH21o=;
        b=tbMoktjSzErRwW7YgTfR1imy93yrn2B6Clk0t9omJ5+B921EC5vmi9Z6VhmNjFnJDb
         KH+2AjdSkSqJ/i+L2rXNYYSurdnb5A7BQ6Cqzf0F0dG6BukQ2jjDhJ8eX6+ahB5BfyAD
         pjHxgmR2CoBo+YRIPNejTvU9RI0CRAMRBgSSgbP6gBmKi+nAO7G/nKbkJw+c3QXSb304
         3nbA/+AmeVk5AqCHq6mkNiLTv/ZFX5wCakA4HlK1OcuVEsm1HlU42+SRu1OdjAOYuw2H
         Gox9dP9zbXXecgU931uj86D1Zzd+p8/zChV3PuFdcl2SDwGPit3IFIjB/RjvxytK0mop
         0W9g==
X-Forwarded-Encrypted: i=1; AJvYcCWGsD/bemVnFNrBUpK5fRu411mpbo3N1FFxiA99X7yVM+PUqvHFEqkd/d65bwKQne9aJFVDkfCsIFhscyHiawPYT4LYCgc=
X-Gm-Message-State: AOJu0YxjAMvn1v2UaqLnFNydGNjsc/DIi1gsvbpEF0ZfhX/DGZHkIz4j
	L1yFR57cBpO+CJQs3O6w4axYn8hy/vveGBU3pqK9lElrUCAzZ09pmPUeOH6y4hNlmV9G2GD9ntM
	9xHILT2WlfBMDzJcB+2q9GKHU9ZShCbXQFHb/uT3i6mGJTRa/qLqcDZqSrS04
X-Received: by 2002:a05:6602:22cc:b0:7e1:b4b2:d708 with SMTP id ca18e2360f4ac-7e8c471228dmr98231939f.4.1716504475914;
        Thu, 23 May 2024 15:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGwOK95xB7bE1bMah1YI57apwlkaazKWEAAxnRnR+UWpM8aA9o2MVc76pMUij1m7seUhPXVw==
X-Received: by 2002:a05:6602:22cc:b0:7e1:b4b2:d708 with SMTP id ca18e2360f4ac-7e8c471228dmr98228939f.4.1716504475433;
        Thu, 23 May 2024 15:47:55 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03e8298a3sm94292173.18.2024.05.23.15.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 15:47:54 -0700 (PDT)
Date: Thu, 23 May 2024 16:47:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Vetter, Daniel"
 <daniel.vetter@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "hpa@zytor.com" <hpa@zytor.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 4/5] vfio/type1: Flush CPU caches on DMA pages in
 non-coherent domains
Message-ID: <20240523164753.32e714d5.alex.williamson@redhat.com>
In-Reply-To: <20240523145848.GN20229@nvidia.com>
References: <20240521160714.GJ20229@nvidia.com>
	<20240521102123.7baaf85a.alex.williamson@redhat.com>
	<20240521163400.GK20229@nvidia.com>
	<20240521121945.7f144230.alex.williamson@redhat.com>
	<20240521183745.GP20229@nvidia.com>
	<BN9PR11MB52769E209C5B978C7094A5C08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240522122939.GT20229@nvidia.com>
	<BN9PR11MB527604CDF2E7FA49176200028CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240522233213.GI20229@nvidia.com>
	<BN9PR11MB5276C2DD3F924ED2EB6AD3988CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240523145848.GN20229@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 11:58:48 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 22, 2024 at 11:40:58PM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, May 23, 2024 7:32 AM
> > > 
> > > On Wed, May 22, 2024 at 11:26:21PM +0000, Tian, Kevin wrote:  
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Wednesday, May 22, 2024 8:30 PM
> > > > >
> > > > > On Wed, May 22, 2024 at 06:24:14AM +0000, Tian, Kevin wrote:  
> > > > > > I'm fine to do a special check in the attach path to enable the flush
> > > > > > only for Intel GPU.  
> > > > >
> > > > > We already effectively do this already by checking the domain
> > > > > capabilities. Only the Intel GPU will have a non-coherent domain.
> > > > >  
> > > >
> > > > I'm confused. In earlier discussions you wanted to find a way to not
> > > > publish others due to the check of non-coherent domain, e.g. some
> > > > ARM SMMU cannot force snoop.
> > > >
> > > > Then you and Alex discussed the possibility of reducing pessimistic
> > > > flushes by virtualizing the PCI NOSNOOP bit.
> > > >
> > > > With that in mind I was thinking whether we explicitly enable this
> > > > flush only for Intel GPU instead of checking non-coherent domain
> > > > in the attach path, since it's the only device with such requirement.  
> > > 
> > > I am suggesting to do both checks:
> > >  - If the iommu domain indicates it has force coherency then leave PCI
> > >    no-snoop alone and no flush
> > >  - If the PCI NOSNOOP bit is or can be 0 then no flush
> > >  - Otherwise flush  
> > 
> > How to judge whether PCI NOSNOOP can be 0? If following PCI spec
> > it can always be set to 0 but then we break the requirement for Intel
> > GPU. If we explicitly exempt Intel GPU in 2nd check  then what'd be
> > the value of doing that generic check?  
> 
> Non-PCI environments still have this problem, and the first check does
> help them since we don't have PCI config space there.
> 
> PCI can supply more information (no snoop impossible) and variant
> drivers can add in too (want no snoop)

I'm not sure I follow either.  Since i915 doesn't set or test no-snoop
enable, I think we need to assume drivers expect the reset value, so a
device that supports no-snoop expects to use it, ie. we can't trap on
no-snoop enable being set, the device is more likely to just operate
with reduced performance if we surreptitiously clear the bit.

The current proposal is to enable flushing based only on the domain
enforcement of coherency.  I think the augmentation is therefore that
if the device is PCI and the no-snoop enable bit is zero after reset
(indicating hardwired to zero), we also don't need to flush.

I'm not sure the polarity of the variant drive statement above is
correct.  If the no-snoop enable bit is set after reset, we'd assume
no-snoop is possible, so the variant driver would only need a way to
indicate the device doesn't actually use no-snoop.  For that it might
just virtualize the no-snoop enable setting to vfio-pci-core.  Thanks,

Alex

