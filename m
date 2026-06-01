Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F639A7FE
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310486; cv=none; b=EFxvgYZu8IB2AYQX+lG/imQyAsoDLp/A8fsh6YV66AOb15sxTeaznNCLvbCS7LxLSc0f4hGICVTRwX/kHdhxYUKfzV9fb/MzFXolkqK3+e5E8a7CMoXPjGfJtho9knk58buQxng0oKaRQJaL34MGPbe7KaEZ2xO1S6uGDdyJEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310486; c=relaxed/simple;
	bh=SCXw0X4yCKiS+ZvYlUJutOAXYF6cwTtdfJyDOlKRbHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7ifyf21KGgFsun+srLm/LQ1AZq+QrfBrastH+B1kTWmiqdIe8AsRa0BnQb8RDa+aF5iTL0LjMcrTMkQ6fdXM//5TkU7FIJ7UcIxhIuNwPaCyKR3pCLXW04FfkZVLeARfLdmx17ELvb8WuuqDXBioJ6TwlRdCRhAbFhAiOlMPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=heEAZkn7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="heEAZkn7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2911f93cso1005ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780310483; x=1780915283; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sldHCJrVX7HHPNnZ6TyMOXSdYqXeIyil59tqXzT91Q=;
        b=heEAZkn7s7EabiWMAt4EJplP60Ed/8bac7FlW4LbkX1u/escfqFnkoWosTQPj4WXA1
         ELvT0CRnfbQuBkG8GO6Bq2jTjvS08LAVBntPztmWiKyAVeMSzZzMYqpy3KRVdo1qKjMf
         U03ZiLBuRb7WgS4yN3Igx3zjGSo3m2s/DfG+ZYpZ4PznKRbHwkFJ5RlIHCPyWlx4Fxx2
         E1jr4sN8BnyBickTK9Law9ILKy7VICxE15T4Wc4PRAtIkhEJ/Pd/yjncGLimhz2itymE
         k4e6OB+420tc50cTz8kjI+4uqObhrrTjOyFioBMZyIc8J9DdjyTdBVgFRQGgr8MOFLBC
         u6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780310483; x=1780915283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sldHCJrVX7HHPNnZ6TyMOXSdYqXeIyil59tqXzT91Q=;
        b=LGi2bzIph4nl/zaXFAfL0BPR5KnaI8Rk7ps3ubXyRel9z6DmO05LmVFS6f4lGJYSwr
         CpTXl5eWEgyAKsBLj7F1Lmx19gs4aLwMwbdyW8d/hbvPc8FHqq/PTV8nRTFqJL0mx8hD
         HBBfJeeWTfzm1mwkIuqgwcDLv0JeTRCa6a2+9dEJM/7j/aoXmoCuZOz4GiPKNt3i4g6N
         oAolGftt29virrtJMpU715dJNHJSY/SfIq57Pj2FUZ97ZA9lxbui0P/UTbNYebslkFeY
         aGpZrlJTzrZavQCvhZGvawXR/oZNdOWm8KA1jiq2SXzpVON9AZ+cb5RzS/5jbcmboiFJ
         aRhA==
X-Forwarded-Encrypted: i=1; AFNElJ8dBU+zrqXi6CsIgi0ecoDpAOXfqLUYhQ9qAWWqe/JR8E0MZ3Pzt2govqfrpHlb5Qf4i5iu7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9AEnG4rVQ7Vw7JYwm1Y0uvIQpvDDtQoNj1lD8EHHHX/B/QlZ9
	S5nEG86s0dWmxXvcQfwFLB3YH3VYCJ4XUtFFqWY79buJIaHGTzl+LlzrvLcXkZeXrpT4kxXNisT
	2LI/lcQ==
X-Gm-Gg: Acq92OEjMee8JLy0QTYzCbej9KKWYoCPB8IYJ7UdmE5+R53uw6v2OODFyWtmJsmaari
	0Szso7Ei5253GEw80U3gCeAebIkcz5DiGMZfNoKbCDr8i/RwG3ZUdWseI1JJ+dkvCmGtkaa5ztk
	JrAyodK3NjTHQtfH41D1MuIEktpFKoaCBIPu5Di7KHpKGt1Z/PDy4CRXEXqqCBJWdw0v7pXrTOH
	v1qt9flCXwc+yuOJ/8owHYN4bpGyp68P2DKjoo4tuHHFki9PuUJrVE1ggAY5bvbrnX8W5SvUFW5
	8Z7gfR9c+biQigQRmsWM5RtzCS4GmsVbFR++essl39kqGfkd+UBCY44r4xI6jmZKpJQ04An7E80
	qX6+y5CwtmoAIQ85vX+ukfUEr7M/u3raYKmWvUV5xZii10u8phslGD2p8PTmbdLZiAPdIrT+e2o
	CGl29DB74Fnpv3iQ8q6+Yg3w5uzbI9mSL6FlMSuVZcKh4x7Wz5CHyLyu9gpypi61QNBmoO1EQ=
X-Received: by 2002:a17:902:da81:b0:2c0:c14c:bf37 with SMTP id d9443c01a7336-2c0c14cc181mr2103265ad.16.1780310482513;
        Mon, 01 Jun 2026 03:41:22 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84246844780sm4225556b3a.30.2026.06.01.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:41:21 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:41:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 6/6] iommu/amd: Fail probe on ATS configuration failure
Message-ID: <ah1hyp0oB5iJenQt@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-7-praan@google.com>
 <unqzyef2n26wdf6tmc6vvwvpsgv244uvz7cxji4scymqmoofyb@trkzr7ix5bog>
 <ah0kyi5asHpnrpgC@google.com>
 <6086ebd5-4538-4b85-bbd3-84df9c6198d2@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6086ebd5-4538-4b85-bbd3-84df9c6198d2@amd.com>

On Mon, Jun 01, 2026 at 02:58:11PM +0530, Vasant Hegde wrote:
> Hi Pranjal,
> 
> On 6/1/2026 11:50 AM, Pranjal Shrivastava wrote:
> > On Mon, Jun 01, 2026 at 06:00:15AM +0000, Ankit Soni wrote:
> > 
[...]
> > Hi Ankit,
> > 
> > Ack. Sashiko made me realize that this regresses IRQ mapping for AMD,
> > and I agree that the call to iommu_ignore_device() is a bit too 
> > aggressive as it  wipes the rlookup_table entry required for IRQ 
> > remapping, particularly in PD_MODE_NONE.
> > 
> > I was thinkig to address this in the next version as follows:
> > 
> > 1. Split the probe error paths:
> >    - Proper init failures (like iommu_init_device) will continue to call
> >      iommu_ignore_device(). I will fix the double invocation here.
> > 
> >    - Config failures (like ATS mismatch or PD_MODE_NONE) will return an
> >      an error but skip caling  iommu_ignore_device(), preserving the
> >      rlookup_table entry for IRQ remapping.
> 
> I was reviewing v5 last Friday and decided to fix probe() code as its been long
> time I wanted to cleanup this code.  I have a patch series which pretty much
> does this.
> 
> I haven't fixed iommu_ignore_device() code, but should be simple to fix it.
> we can use amd_iommu_make_clear_dte / amd_iommu_update_dte. It will set the
> dte.tv=0 and essentially blocks all DMAs.
> 
> If you already have the patches then please go ahead, else I can post the series
> this week.

Hi Vasant,

I have drafted the fixes (including the alias clearing order and the 
atomic DTE updates for iommu_ignore_device), 

I'll go ahead and post them as a separate preparatory series soon.
I'm also happy to incorporate any of your existing patches if you'd
like?

> 
> 
> > 
> > 2. Resolve the Use-After-Free (UAF):
> >    To prevent the UAF on the "DMA-only" failure path, I will ensure that
> >    the hardware Device Table Entry (DTE) is set to a safe state (like
> >    blocked or bypass) and the dev_data->dev pointer is cleared, as the
> >    IOMMU core does not invoke release_device() after a probe failure.
> > 
> > 3. Fix iommu_ignore_device() infrastructure:
> >    I will address the pre-existing bugs identified by Sashiko:
> >    - Fix clearing order (calling setup_aliases before clearing the
> >      rlookup_table).
> >    - Replace the non-atomic memset() on the hardware dev_table with an
> >      atomic DTE update.
> > 
> > That said, I'm investigating the safest way to revert the MSI domain
> > assignment on probe failure to avoid the dangling domain issue pointed
> > out by Sashiko. Maybe we can add an amd_iommu_restore_msi_domain() helper
> > to revert the assignment made in amd_iommu_set_pci_msi_domain() on probe
> > failure?
> > 
> > Please, let me know if that sounds okay?
> > 
> > Also, I'm wondering if I should send this as a separate series specific 
> > to AMD which is unrelated to this one? Or maybe handle AMD IOMMU in a
> > separate series altogether. Let me know if you (and Vasanth / Suravee) 
> > would prefer that?
> 
> Lets separate out AMD fixes part as its not related to this series.
> 
> If you want to keep this patch then just the "iommu_ignore_device" part that
> should be OK -OR- if you want to drop entirely and pick it up with AMD specific
> series that's also works for me.

Ack. I guess a separate series to handle AMD IOMMU sounds better. I'll
post one soon.

Thanks,
Praan
