Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7B368282
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322465; cv=none; b=dSDr0bCgGa/303J1UGu6Mh/or94SQpGH6psWhth+O2QT+qPAv6OchW9c23O05AGnq+XffNQE8bP41Hpw9ynjVrotBxJK6AqiGj5f8Hx7bRXb7Sl8/kWgSNZLIckX6XzDkX0il7CtASMnvPsMVb/trhfOYpMhUH+7eoRsG1y75uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322465; c=relaxed/simple;
	bh=VtybxAi8wqTRTXeCEm16Hr4v3bL40QteE/s5Hrb0gmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1RdriQV72deDw3nphXpbzLCq8/hDrMAbYVf/cqYCEEB5dGn3yPtb6zVpLaWWb7DhvyMP5jQOi2Gonda6JbsLNJvI9wg+NicFgkgrklrhTlybKbYujCzQ7jutLFzPdIl9f7nkaswvhr460cB6b+hXNsh30ryd5o2HFqTkappCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9Ry350C; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9Ry350C"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so5018994a91.2
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777322463; x=1777927263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wM+QOtZ9yfNrPXhT14ztNpzNE+UB64YzKseERpnZeo=;
        b=I9Ry350C0K5Vvrx0FQowAEZ0BMnzQvR3IYi+7OuoICvly8B36hD4666mSE92qNniFj
         THv6TfaLlCSH9rTykH8EQIdedlx+Hwdq1V4Qq2pWCiF4BCxn0w7MbEH8fDppS/4XqBUM
         F8w28NZD/IDc2Y4g5hvZvjMdx29Y+rzXlaq9LWbQnG5jsD6Nux2CDs9IhM6NVbaX4TAt
         QJ5X1u9IaNGqURG7b1BdvT0CFcvWHzdVzrtCA4SN6OMmsOBTQWOnNyOsUKURtAueujsm
         9V5COHuMkf/pAD9jqzrgggeqOrJDFbnpbK+zf6PSmXFVSMkM5PIcR0Cga+nws9NFrpO+
         4FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777322463; x=1777927263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wM+QOtZ9yfNrPXhT14ztNpzNE+UB64YzKseERpnZeo=;
        b=nBlSnSYrmzJ7Ma4KcS2X2t6zMRmjsqfdnwnMGY7ZZDedNkb10a5FCSd6eKJvMVGcPj
         iZvongmMzqRtmxyTyDyQZVGxrbi8Wo58PCmmMu3tBFmqpxpvSujVjmq/BZh+7TOVEQLS
         x8w4FCTDQozPSMvGQgi+GbVVFzlmbJsjbHwAIcCqY52GcrECe1eeqjgR+AhaQXS94MSy
         FtK1Q2FFovbfPnyiEM1TsLMRXNfu8f04G1TsJ3NOKPPMVkPId1xCCAI/vinlrR1L2avn
         nfIE8xdmQOyYNA7ZHc622VRLwzWAli18kl5E7PpaLv9KFeGD3Ukj9/LzXgEuaMMQJdeB
         aqNg==
X-Gm-Message-State: AOJu0YxwPiWo2ocSAAfQ4j3aSvQK6Del99Pd+2KyUprR+55As4KR+5It
	d6ZV7nJa5yNm9b8atBwHYdL/GUiZV2ANYxCTDDTJvbyPabvTLg6SMC63UX6llqiW7A==
X-Gm-Gg: AeBDievrDni8FcumbJ78+S6Bc5FPRLKntXuGjR054W8UnTB8/JF3ISBBb7gDRfJAhdI
	H4pGz72Aokedd8dRQILt3wKJBABgy6ylZtyU/Vw1nHy+NMCbPZSvrkK8/wYMzJ15gysagIz5m1q
	WNORaNxNRpI72fTlNAJnlCOX8bFj1uezYgavi10NjAyBmt9csmuXhB7gnf3PYJa+Pu4zkzaW1w8
	R0yV+o8VILSjgLBD7HGOLt2i1OaUee1PmlfLmXhSBNEgVLPocfexcVPHk1K7GXR5lKNqcVcS0GL
	jm0e9CXknKSiac4Ze1PwdSkiefuy+ZxzA8Abl+IrNJlAVqHhGBxU0K2JphkFiMtNyh8iV16bDZq
	S+COvzvdbkx+d3+JkEpfH443iBysHQS4BbI8Rr4qhGhqxS8gcQspN30Hh+2pz0avdvnzu/QvkpY
	CZvs2Xhof099FX0gdyHvvXe2babe2FLh6uZYixVePdKWeTgf5a5Zl1aDTR9OnWLTnNE+14GgMGJ
	DiS9ERkvDlrAM6e
X-Received: by 2002:a17:902:c412:b0:2ae:57e6:616c with SMTP id d9443c01a7336-2b97c3cba0cmr1478985ad.3.1777322462621;
        Mon, 27 Apr 2026 13:41:02 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97ac784c5sm3813795ad.45.2026.04.27.13.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:41:01 -0700 (PDT)
Date: Mon, 27 Apr 2026 20:40:58 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 05/11] PCI: liveupdate: Inherit bus numbers during
 Live Update
Message-ID: <ae_J2pRWFf5qjZXb@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-6-dmatlack@google.com>
 <20260427114745.00000656@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427114745.00000656@linux.microsoft.com>

On 2026-04-27 11:47 AM, Jacob Pan wrote:
> On Thu, 23 Apr 2026 21:23:09 +0000
> David Matlack <dmatlack@google.com> wrote:

> > To keep things simple, inherit the secondary and subordinate bus
> > numbers on all bridges if any PCI devices were preserved (i.e. even
> > bridges without any downstream endpoints that were preserved). This
> > avoids accidentally assigning a bridge a new window that overlaps
> > with a preserved device that is downstream of a different bridge.
> > 
> > If a bridge is enumerated with a broken topology or has no bus numbers
> > set during a Live Update, refuse to assign it new bus numbers and
> > refuse to enumerate devices below it. This is a safety measure to
> > prevent topology conflicts.
> > 
> > Require that CONFIG_CARDBUS is not enabled to enable
> > CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
> > bridges requires additional work but is not a priority at the moment.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>

> > +	/*
> > +	 * During a Live Update, preserved devices are allowed to
> > continue
> > +	 * performing memory transactions. The kernel must not
> > change the fabric
> > +	 * topology, including bus numbers, since that would require
> > disabling
> > +	 * and flushing any memory transactions first.
> > +	 *
> > +	 * To keep things simple, inherit the secondary and
> > subordinate bus
> > +	 * numbers on _all_ bridges if _any_ PCI devices were
> > preserved (i.e.
> > +	 * even bridges without any downstream endpoints that were
> > preserved).
> > +	 * This avoids accidentally assigning a bridge a new window
> > that
> > +	 * overlaps with a preserved device that is downstream of a
> > different
> > +	 * bridge.
> > +	 */
> > +	dev->liveupdate_inherit_buses = true;
> > +
> This flag never gets cleared after the incoming kernel boot up, what if
> the user does a manual rescan via sysfs? i.e.
> # echo 1 > /sys/bus/pci/rescan
> pcibios_assign_all_busses() will never gets called for this device, and
> may hit this
> 	if (dev->liveupdate_inherit_buses) {
> 		pci_err(dev, "Cannot reconfigure bridge during
> 		Live Update!\n");
> 
> So, maybe clear it in pci_liveupdate_finish()?

I think we can allo wa rescan to assign new bus numbers once all devices
go through pci_liveupdate_finish() by clearing
dev->liveupdate_inherit_buses on all devices in pci_flb_finish(). We
would need to hold pci_rescan_remove_lock to avoid this racing with such
a rescan.

Now that you bring up /sys/bus/pci/rescan... I think we also need to
set dev->liveupdate_inherit_buses in the outgoing kernel, to avoid bus
numbers changing on outgoing preserved devices. pci_flb_preserve()
should take pci_rescan_remove_lock and set dev->liveupdate_inherit_buses
on all devices, and pci_flb_unpreserve() should do the opposite.

If we did all then then /sys/bus/pci/rescan can work like normal as long
as no devices are preserved (incoming or outgoing). If any devices are
preserved then dev->liveupdate_inherit_buses gets set to prevent bus
numbers from changing during a possible rescan.
