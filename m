Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F133E3177
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172857; cv=none; b=ENImV9401cpw7Qck4rOtdEiMQTQaoWEkgnLPhMFRIijxmj/j0sEi6DmKkwdlQQKJm2XdPN9RlDXBtE0WPiM9nJF/WlpKAOEhYQq8vxDYeDFRtR9HUbnCnaQRoyPKpX7u9dZSHbEnXUMXeP1jdxfmd1rpfvlcPhm6Ol6j2eUgs2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172857; c=relaxed/simple;
	bh=km+lTVfCRl2ntV8aEXaF3ep+A713m1xBMbzdYvJNBFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHYmo1RdAlRwfOri25AfFCBh69Ls/0P29LRqdYsoBJweNuQjRScEQ9AjLtvQ8YuR2S+ne7qaiQ5HQyTqpTvozMRiaJ3YTeSXG3CDCbEt4XZNMDeZU6eeci82QKNoKryQbT3dyWvr4oJa+ENp2w6WQWaJUhAqvC4/qQWW+06c9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgVjgBhy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgVjgBhy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae3f822163so31215ad.0
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773172855; x=1773777655; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9uoDZoX5wcYSBPe17Yxmax+57dy5y/EA9jB+yCG4Lo=;
        b=wgVjgBhygda3FmybweMpqKo6qRgDjYgNlzYhraTm2WyBa6gNo92Vt7Y3+KvUiksTfK
         ohuSESE05ZIQ7WKxKr4pDUXvuBol/WjWXnd7+1lcXA3Mzb/j2yvsA2JoNszzFztBY24s
         NdaUYl5ulHMbFkEqUIGxfOb5rq7rPPYyW/b3cZEV3NFP7Gg7td1aOBF+zw+T8RmfhEfV
         M8RH9Gs1Bb7dVuvHpUZCPAwwHbTe51dPzhS9IlDOKTrSCkYxEINxBBesiDMYnPz0yLtr
         VU8dpvqv1Av+M2YKyms6p2uTAdxunw+QR/oxrT+nqBlqK3cfVURiGjBtTEx/C4APU2/r
         +7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773172855; x=1773777655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9uoDZoX5wcYSBPe17Yxmax+57dy5y/EA9jB+yCG4Lo=;
        b=VpcTmsvlk9Mn5q8wEtzXfAAsnR5Ss+Uz6Y8odH16u8efKoo6C7VgpPKlcWpMvh/wV7
         UpHtSLec4L2yksFN5ILycls6FqGPDoyonf6Nftf2Sa4B51z60Q4mpOkUMAqxwKqsHtlk
         rIAtG9ICrxIjIoLDt55n7tZffrs0YYfXAxRsPzqPm1d3hhrPvccBTBdQEFaZK2AdvXWD
         oK+LPx8Fb+GMdXD1pomeNH2tP+nOyLGsDtxOLrpv1PBbIgMy+ocDz45BPFeJcFQxUs5s
         LlwJo6JDYcUrdgWXmsZAviq8feSQpQQgZiYZg6bS25FfRxs8qAmPAWzA/wbesqqfUkHm
         5TbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR20y3KKDeXZ1ad2//NuCzSSCYD+bTSf+tBtNECTnuo5o/Kh72+EjC9632/amtwbTz0ik1Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzALNDQyF2iQthNj+H2fRWq7E0wWKDGjYitISDO+D7HytmMLGKQ
	0Q02Cxzgn84bjb/IUdQJgwy4ygDgjOQiNszlFB+km6JVxyrd+MY4ZckO+Rxj0or5aQ==
X-Gm-Gg: ATEYQzwH9r5y3MfLexUseuL7hcocP+V3LT8lvs32mOKPvwdyR06U3ZlaEU9c+Ma+0B2
	lrHRdPDgMwVbOftt/LNVD0e/svHC7uaUqqgTQgpozIMs+d30g0aWYtZyU+y5zdAkYJCSg0SNNF3
	Psp5WHiZqYS/QwAYAKNv3SmgONDVqx4I4lDtUbRch53Eg6Trjxv01ae4dU1N2X7P4LHx96Tvlq9
	ze7zXNCE+N8NbadKctkF0JF5ltYTl95xzrLBkKElB/mCfOljljvOpx7wemKlJ2F99cWy7DI6elx
	iI1O/3dSS/d/rLztwslSMTIJG0zu9Ve+ZplelGyt/UztcltYBOdC5G2w4EXpyYJ5nQurEGQWFfO
	mKX25u92tRsAdLuncPpF/b3XXquz8lBHKQBkuvbAnF+wyh2Frfz1zVYDNkBsw2Piv9zi9IrfJaR
	v9dNEj5vFpAoh6hjA1rvYEmlfKDg88lWKInU1icc5VGx87OqdrNoMFPDqlaQ==
X-Received: by 2002:a17:903:2ca:b0:2ae:5d57:c94f with SMTP id d9443c01a7336-2aead3e31a0mr779595ad.16.1773172854782;
        Tue, 10 Mar 2026 13:00:54 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6eebe95sm83922b3a.36.2026.03.10.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:00:54 -0700 (PDT)
Date: Tue, 10 Mar 2026 20:00:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	bhelgaas@google.com, jgg@nvidia.com, rafael@kernel.org,
	lenb@kernel.org, kees@kernel.org, baolu.lu@linux.intel.com,
	smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abB4cAjZjIvIzhkp@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <abBt8qj8QpkG-Fwh@google.com>
 <abB2V8VGfoh5yO45@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abB2V8VGfoh5yO45@Asurada-Nvidia>

On Tue, Mar 10, 2026 at 12:51:51PM -0700, Nicolin Chen wrote:
> On Tue, Mar 10, 2026 at 07:16:02PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Mar 04, 2026 at 09:21:42PM -0800, Nicolin Chen wrote:
> > > +	/*
> > > +	 * ATC timeout indicates the device has stopped responding to coherence
> > > +	 * protocol requests. The only safe recovery is a reset to flush stale
> > > +	 * cached translations. Note that pci_reset_function() internally calls
> > > +	 * pci_dev_reset_iommu_prepare/done() as well and ensures to block ATS
> > > +	 * if PCI-level reset fails.
> > > +	 */
> > > +	if (!pci_reset_function(pdev)) {
> > 
> > I'm a little uncomfortable with this, why is an IOMMU driver poking into
> > the PCI mechanics? I agree that a reset might be the right thing to do
> > here but we wouldn't want the IOMMU driver to trigger it.. Ideally, we'd
> > need a mechanism that bubbles up fatal IOMMU faults to the PCI core and
> > let it decide/perform the reset. Maybe this could mean adding another op
> > to struct pci_error_handlers or something like that?
> 
> Robin/Jason already had similar remarks (to most of your other
> comments as well). I have acked their comments, and am already
> reworking on these.
> 

Yea just saw those discussions as well, replied before seeing those.

> > > +		/*
> > > +		 * If reset succeeds, set BME back. Otherwise, fence the system
> > > +		 * from a faulty device, in which case user will have to replug
> > > +		 * the device to invoke pci_set_master().
> > > +		 */
> > > +		pci_dev_lock(pdev);
> > 
> > Why are we using spinlock_irqsave across the worker? Also, why does
> > atc_recovery.lock have to be a spinlock? The workers run in process
> > context, and I also don't see anyone else take the atc_recovery.lock?
> 
> I guess mutex would be okay here, since there is no other place
> access the linked list. Pairing a linked list with a spinlock is
> just a common practice..
> 

Ack agreed. No problem with the type of the lock, just questioning the
choice to use spinlock_irqsave et al since I don't believe this could be
in interrupt context.

> > Why does it need to be irq-safe? If this can somehow run in irq context,
> > we also seem to be using pci_dev_lock and streams_mutex across the
> > worker?
> 
> pci_dev_lock was to fence race on the PCI level. Yet, the entire
> BME call is probably not a good idea. So, dropping that means we
> won't need pci_dev_lock.
> 

Ack.

> > Mixing mutexes with spinlocks is brittle and invites 
> > "sleep-while-atomic" bugs in future refactors..
> 
> Either streams_mutex or atc_recovery.lock was scoped for only a
> few lines each section. Each was released before the other one
> was taken. Where is the "mixing" or "sleep-while-atomic" case?

The case doesn't exist yet, I meant it as a warning against future
re-factors, since I didn't see the need to use a spinlock here, I didn't
understand why couldn't all 3 be mutexes when the existing 2 already
were.

Praan
