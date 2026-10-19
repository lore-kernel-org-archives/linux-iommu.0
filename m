Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC93E8C70
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397188; cv=none; b=s/yZkdGUoDRw9PbnfEaZI82wWs7SUMSIFrCiJ+LiqnZhbB6/0DtTiSKE5Y+zV4AOuNKGSCjoz0h05u1PZTZHNe4Ux70f38g/Td5QInh8dBaVmflZtq1grO3dP37Qn39UElnt7rrsLx2q4Qos93yjVAlVFn8NaJ5sCQohA96etmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397188; c=relaxed/simple;
	bh=FY0qcanD1yswML7l/dRsnVFaY2lJmQx9u8YM3zGuotM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epWbD9WkYkpwSfEm7xUV8BgS9alg5e0q5O/ASzLqm9/jPLGYH6qj9avKh40dHE/pwUiRCEtEPX6lu07eU6wuH8UM14z0+EgDADWwsDdOcBKPv1d+Ry17d+9j1CH2wNRNiXriRFwRHKFGI/gX8NxR0PEwQxoYMafcV5D619hKrV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/+VTvo6; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/+VTvo6"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-169be2dfbacso6608c88.0
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 01:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792397186; x=1793001986; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zKlllSkaDqzD1U/0lTr5RBP4KobTu9kcdCFVa+N+5rc=;
        b=u/+VTvo6y6EFrbd3IAahnAuYGIera+lV05GbE4Q93MBFwwQvqDFacX+F40hDn0w+I7
         +BUsZ9vfolmcL2/DajjaI06PR5Kk83g3T0AD7DV68wnJSzJKu8J+A3pSKSos+uRrFAj7
         wBJ6G9q33MFsjWMPYOYduPNXGNfpP/RuYe11+7v4Rf41u7mOUSwoDKoWIrnRnX8o1bY0
         /oHCXw8ZZJYygY3FinzI26ZHAtv8lypxsUuZmplJH1CXPip3xCe/Ahga7j2Vj6DJWq6c
         KpxlWIdrIA1Q0BrNE1w/fHn2pcmAtyoRfhetVFqLV8IKnfDHAGeIlHJpZYMLRy60eB33
         2UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792397186; x=1793001986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zKlllSkaDqzD1U/0lTr5RBP4KobTu9kcdCFVa+N+5rc=;
        b=dygQWIyI4uGvlmmBCCsiGiGZwkwOZ28O2z6LqFPoqo/UwcUtorldei14WcFSGTDa0f
         PruYDwu57Se51VitYfIFxAIweXsOuT6088Z6rEQIQWJ1X2nVuShmNeAtN39NjstxvpfI
         +CGrfVlI1+5tkn3E+VIJI5HyjxoFQzvoQUT5Wfo4Ko7ZjnaORcb3LCPwLBnn2zYkMJNX
         SIhgORqE9sa9rj801Tnk3XkV1a21PB8IoKSbS1BDMazeDxSFdgfw++dt3kgD/bQUK39+
         A35/d37uQ/XT4Fs4s6lnccBSjsdcvkp80YpQL/ahv/CRuLLQbVKOOq+w14EBC1sv7/lS
         Kn9Q==
X-Forwarded-Encrypted: i=1; AKwUvByhJFscJuUk01/FtiJvNmwUoBpRrFVVbickEQjdMA1r6qTrnx2KmLzAbO0TTwDNDLXU/NLcHA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJqTpnUFK+ok8Puo3YylMzXKzEQx3zazMJ4JyoU+tGWJ0KvUicl
	6RtBnpURgcugxykbcHmcL2AnKJWLSGp6Ek2LQh9T7aTXBaeNgc2nrDqT4TJZ5PUgZg==
X-Gm-Gg: AYBFou21uOo9G7ewrjVE9y+lTIfFGzXoeGj/9GZ118mYGrp4qgaEVWYLBMN977NJqU3
	qMS3eJGBEzWl+j+3u73PEQvNEFFxS1JjB4uYy0+/Y1Oa71LpXuD5SYfP3zUmA2pUxK8zBmuNNsA
	0K0KSbVBZ3njybLR6rXmgwsCgxqPicKrqTi+LeqgCrgdCEKgGmorDUnMUF82BHYeFwNg4ICdecO
	hWelXTeOKBqDBwoeWU3AV73zWzCCvtlmns5QIpajuqyTTyzerrlMBJr1Qz8GVywOG9gLJVT6goi
	Ue6+lIhbvObTdu7qydkIDfhNyHz0ubxW5RNo81cjhnQ89PqqsbtsfJJOwW9j5Lr2ejtECR82y5u
	Xv65UhCjl5Wq6UPrsukXHIAqcfsDmjPWCVUqMjRk3YMltsGQSmh07sV/IRb1zlg+GeUf7/Mzuk9
	1WfjFg5YcGCeWR7VkwPD7m6yo/Zoqe8+X2p0NBNK4D49FyL4IliooDfLN0Kdd77aA9FwlSZveNL
	NbVmyJMmTxCGwQ+/u34CEeCGOYrw0HmnmC3BAPjuYUXIyA=
X-Received: by 2002:a05:7023:d0c:b0:184:6afb:b26c with SMTP id a92af1059eb24-185b79b5548mr344812c88.18.1792397184354;
        Mon, 19 Oct 2026 01:06:24 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082e81a06sm28999611eec.26.2026.10.19.01.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:06:23 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:06:13 +0000
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
Message-ID: <atXPdbcX0XADEdh7@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
 <20261002164748.GD3481470@ziepe.ca>
 <asAeCz_rmpe5hbsh@google.com>
 <asUvUf4PZJ7JCLXp@nvidia.com>
 <20261017174912.GK14213@ziepe.ca>
 <atO7jTV+XNReShT+@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atO7jTV+XNReShT+@nvidia.com>

On Sat, Oct 17, 2026 at 11:16:45AM -0700, Nicolin Chen wrote:
> On Sat, Oct 17, 2026 at 02:49:12PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 06, 2026 at 10:26:41AM -0700, Nicolin Chen wrote:
> > > > pci_dev_reset_iommu_prepare/done() pair (with slight refactoring) in EP's
> > > > suspend/resume?
> > > 
> > > That sounds right to me, though a different API for suspend/resume
> > > will be required. And call them in pci_pm_runtime_suspend/resume()
> > > maybe.
> > > 
> > > Jason, how do you think about this?
> > 
> > Maybe lets just start by refusing power management when ATS is on? For
> > PCIe devices too?
> > 
> > It isn't just ARM that has this issue, every iommu is busted if you
> > suspend the PCI device while an ATS domain is still active..
> 
> So, should we put that refuse guard in pci_pm_runtime_suspend()?
> 
> I am thinking about splitting the iommu and pci patches out of my
> smmmuv3_atc_timeout series. They could be get merged alone.
> 
> Then, we add a new API for pci_pm_runtime_suspend/resume() with a
> new BLOCKED_SUSPEND reason in the list:

The guard doesn't sound too bad, but what if we refactor the reset APIs
instead and use them from the PCI core to disable ATS + flush the ATC
right before the EP suspends, as discussed earlier? That'd fix it for
every IOMMU without taking PM away from anyone.

FWIW, AFAICT VT-d and AMD-Vi already enable ATS for ATS-capable devices
attached to the default DMA domain, so a blanket refusal might end up
disabling RPM for some internal devices (e.g. dGPUs / NVMe) that rely on
it today.

On the PCI side, I could roughly:

  - Base on Nicolin's split out iommu/pci patches (blocked reason list)
  - Add a suspend flavour of pci_dev_reset_iommu_prepare/done() with a
    BLOCKED_SUSPEND reason, i.e. RID/PASIDs parked on the blocking
    domain, group->domain retained (so dma_map/unmap keep working),
    ATS-capable devices only
  - Call prepare() in pci_pm_runtime_suspend() after the driver's
    callback but before D3, and done() in pci_pm_runtime_resume() after
    D0 + pci_restore_state() but before the driver's callback. Same for
    the system sleep (noirq) paths
  - Keep the guard only as a fallback, i.e. -EBUSY the suspend if
    prepare() fails

That flushes the ATC while the EP can still respond and stops any new
ATC_INVs to it. On the SMMU side, we'd then never see a suspended ATS
master with ATS still enabled, so a WARN_ON_ONCE() at suspend would do.

WDYT?

Thanks,
Praan
