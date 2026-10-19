Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24A48987A
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396962; cv=none; b=LUg7W3oZD7f4j/3X5YBmbIj0/wL+9Ge1z115y/Lg47G2t0l1LjNYl4I7zjDOr8O7lCq6M29ZkGThcHSpLTXqIua3oTIhYiNwWrrsplr8cfMeTGC42I5+GGfJ+NMEp+iAtXdhdq68VCouAuFH83+UH9bIn7Ak85+DQoHdXpCEqwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396962; c=relaxed/simple;
	bh=6YV1jIyhie2HywPvxhBM7kASTJm/y5FD1q8Bn0YGL7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX20qoVIu1QDtmO/Jo9RnT/s6sdHV0bNtUz+YkvPJNazNUo1xurR0IkV75KZR4M28Nm6pBS2LVX8pMpjeaMJBnNvnLjSXEAnra1EJqAoCzn84LyNe+kSzHT32DckKVNDlKYkuC8d4xJeUJKuIt/ARrr5QFAO6+jwmsw2xS+Mb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YP/mMGt0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YP/mMGt0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8623790f8so66395ad.0
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792396961; x=1793001761; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U96zIc88mN0rNQvIVq2ht+DBQv4Z66PcnccoKG6Xats=;
        b=YP/mMGt0Tj1gHIH8U4ZkFo7p1sQscvOy99tbZJ7oYB7pP/ZHxrtEwCxrDm4NSxr6tN
         Ec9bKEZ9grxGew6DnvqfmnFJvrxJbu6RiwXuoynBjTVOKqV0tXVJOKK6mVrI7LgNEXFT
         Q+B0ZdyIfEV1xQIhSdZd387lQ6RI9MrzPnHg52G7x5N3B/9XECxvdIvfCNfMJwcOE0/0
         wlzMdF1oXkfCfNoK7cn0Ns3RBvv1xz2xodVy3v198h+MACFyDwwrDlxovblqm1zlvikF
         hoy8ZKDoAkP0IMnTrEF8sleqQgvLnNuwwWEE/O/nRSFqCB3N/3RIGzaMb7aqQ7U22I0t
         SCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792396961; x=1793001761;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U96zIc88mN0rNQvIVq2ht+DBQv4Z66PcnccoKG6Xats=;
        b=dnJIFRxthxeI3hE2gs2OsSXLzSEIWEIaVgnMbbPZPhDkADWf2yza1Ez5wVOb2ldzGQ
         LP0GSaBfyQDkb2bTH7IkDp+qDzUxEqisXpfAEH2nB/m3mHxyJY0vE8cvuP3UVe3UEA8u
         uMzELzZTP8/QFceiiILV0dKBNUxP0wgdhVxwHHDXwdelEmPoQQNY6dTMHHcMYI/ANvPD
         RZlxFyu7PW+L7nwuDmYdd2uwQak26iGYA0JR8AXJs7arcAX+aohMfEusmeNrgs4wMMeC
         ihtr9n6PzuSfCRhKrDBr3MDjJShBhtgnP/5rkBNKFY/q10854R29mB8A1rwRltAeHLoq
         cL/w==
X-Forwarded-Encrypted: i=1; AKwUvByW9mf5zETnJbXv6gH/MEiBcpHiR6YR80+F4Vp5bGPKcS8HYeN4Dq8iagJMnJE5SGQaSVGDRw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKl/9JJ+s5m/FXrVco1EOFUnuqpjr5ZqAGjef/TFM9AgXazyRjA
	y3S0qoBfQfGXdIFklp+vKcbnutkijtP1sT7/p9c38e2qyBIUp6SNxr/lTSIJa4cT4Q==
X-Gm-Gg: AYBFou0RsuVBmaXssWQqXhcnKPVu5i81OXBtBZQatFTZP27mebdjWV6cAH0eOeKeMRE
	asMxXumxpxHtJzxpCcSMrBiJQWtI4A9njzXPg6m62BUIi5I0ykjjRbhg6mDdP545BlS6+y7fFog
	MxGoCxu1yMcwR42dWnEV48bszJwD3BK10lLRI0OcOtnhX3wePq0jOzE6SEUIVzOzyKGAbnQ08Bo
	hHYQAJHQvaQR53vaNcvvY7wLvI19vO0oSB4tJeUI+I7TYXomCaCnNxwyD+HM9XQ2zvTSv1keE9j
	pRp3aHykpCKdTWQvKq2qyDgN7+BAOIgLDhfc0eOZ8fKMIMB4fZ8OxdO1PKDh78KD8SLdSLp9Rqp
	K2UH0n30NgbTb5q4X2y8ls+Jt9CtOWOvRy3zd1wOdiXutfXBOx4YZ2trjATDGEWgnvB5Tk05cb3
	2SntosHD01K4tJ0TC5o5fsA63rcAQ1mlDIw0L0ya6uzmVni2Pi9w+jo3CeXvUUgiB+SLbtVOswu
	vlAfqs7jtrRXaiRDFWlrNm+9KhtMPfJCEFOQg==
X-Received: by 2002:a17:903:388d:b0:2df:96ca:d7c7 with SMTP id d9443c01a7336-2e9b324cc9dmr6595855ad.10.1792396960066;
        Mon, 19 Oct 2026 01:02:40 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8353b1sm35762345ad.39.2026.10.19.01.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:02:39 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:02:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <atXOl-9C_HNvDT1E@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
 <20261002164748.GD3481470@ziepe.ca>
 <asAeCz_rmpe5hbsh@google.com>
 <asUvUf4PZJ7JCLXp@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asUvUf4PZJ7JCLXp@nvidia.com>

On Tue, Oct 06, 2026 at 10:26:41AM -0700, Nicolin Chen wrote:
> On Fri, Oct 02, 2026 at 09:11:39PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Oct 02, 2026 at 01:47:48PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Oct 01, 2026 at 11:03:15AM -0700, Nicolin Chen wrote:
> > > 
> > > > > So we can't issue ATC_INVs during suspend (the EP is already down), nor
> > > > > during resume (the SMMU resumes *before* the EP is made active). The EP
> > > > > can't use its ATC while suspended, and if it loses power/resets on the
> > > > > way back to D0 (from D3cold, or D3hot with No_Soft_Reset=0), it comes 
> > > > > back with an empty ATC.. same assumption the PCI reset path makes today
> > > > > (pci_dev_reset_iommu_prepare()).
> > > > 
> > > > In that case, would the STOP flag be too late? It's only set in
> > > > the middle of the SMMU suspend. So, an ATC command (via doamin
> > > > invalidation) might be issued prior to the Point of Commitment,
> > > > which will be timed out due to the unresponding EP?
> > > 
> > > How can you ever fix that?
> > 
> > The unfortunate reality is that this gap exists in the kernel even
> > today.. upstream SMMUv3 has no RPM, so it's always on, while the EPs can
> > runtime suspend independently. So an ATC_INV can already be issued to
> > an EP that has suspended. I'd argue RPM improves this slightly, since
> > once the STOP flag is set everything is elided, so the window closes at
> > SMMU suspend instead of never.
> 
> That doesn't sound very convincing though...
>

All I'm saying is that today, EPs can get suspended without the SMMU
ever knowing, making the SMMU aware of it helps with that.. although I
agree we need a policy here.

> > > How does power management really work, is it expected that the end
> > > device is already quieted by its driver?
> > > 
> > 
> > Yes, power management would topo-sort all dependencies and invoke
> > suspend callbacks accordingly, i.e. in our case the suspend callbacks of
> > all SMMU clients would be called before the SMMU's suspend callback.
> 
> If that's guaranteed, we should probably -EBUSY the suspend if one
> STE isn't aborted.
> 

That'd only work for (ATS-enabled) PCI devices.. for platform devices,
the STE stays as is across RPM by design (no ATC, and the TLB/CFG state
is covered by the invalidate-all on resume).

> > > Could the first step in power management install a blocked STE? Then
> > > we don't have to worry about ATC desync and that automatically stops
> > > generating new ATC invalidations if we go and detact the domains too
> > > 
> > 
> > Partially.. at SMMU suspend we set GBPA to abort and clear SMMUEN, so
> > nothing gets through while the SMMU is off. But that's global and only
> > happens after all EPs are down, it doesn't stop ATC_INVs in the window
> > Nicolin pointed out.
> > 
> > One way to ensure the ATC state is relying on the PCIe spec to lose ATC
> > content during D0 entry from D3cold, or D3hot with No_Soft_Reset=0). 
> > 
> > Another way to enforce this, is to *somehow* ask the endpoint drivers
> > disable ATS during *their* suspend, i.e. in the EP's driver's suspend
> > they could call pci_disable_ats or a better suited helper from pci core
> > and the in the pm_resume / rpm_resume they could call it's equivalent 
> > pci_enable_ats, counterpart ensuring a clean ATS state. Or maybe the
> 
> pci_enable/disable_ats is used by IOMMU drivers only.
> 

Can't the PCI core call it too? I agree the endpoint drivers may not be
aware of ATS, but there should be some way for us to flush + disable the
ATC after the EP driver's suspend & before the EP sleeps (and so before
the SMMU's suspend is called)?

> > pci_dev_reset_iommu_prepare/done() pair (with slight refactoring) in EP's
> > suspend/resume?
> 
> That sounds right to me, though a different API for suspend/resume
> will be required. And call them in pci_pm_runtime_suspend/resume()
> maybe.
> 

Ack.

Praan
