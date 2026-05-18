Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890D39A050
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140184; cv=none; b=Z+G7b6hKh26rpxf+PkeinXD68WZDkMBVywi00tKWoXELg4ag+BklAi1PbIsXtoLqGvLCCR/X8OxWwrPmE9pfgdgNb1t6ptqK5g0nVMvPUeL4wY0cg4yILOxVfh/exfNwbdx3Jj/C6/L8El/p46aDDjsni5M3pFRK5+vk37qqoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140184; c=relaxed/simple;
	bh=H7Xi63DWkfe1BGbqWjPfOELabonYMm/OP+GwrSijp68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI/LWUOEhZcmnpgV6WEW9e7Dd0Rlu9F8DxuJTJtdglubB1WGQfjor1eBxJfEtOJYzxvwEqu1icRM4iesOgIlDivftv7oqkX1BOXhWj4C4NdcWZTk5I3xEJHsRoLMasgzEbVXM3kO0VJignTIXHGpgdKWdL4LsQ5uLgCg6pTueoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFAxmS3T; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFAxmS3T"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so895ad.0
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779140182; x=1779744982; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdhq85Gg3A+NvWbGs+q4HdNVWYpVSS2dUxoGdw9nwVc=;
        b=mFAxmS3T//VFM046rlca4pl5qPIhms+I/80UNUceVTTGIJCIsdmSoXq+lAKakibnbN
         3EAqMNCS4CYQzJPonvz6ir3OENDcqU/lIDuD9PFyrj08QdkdkchQLJH0XVJAv9DKYvu7
         mevZsSmt12aSTdaU5s1wxVoXfyekbeMxXFDcrvau46oCO2wuu2Tyg2G6UvBaGh3IsvKl
         HPwgQs8MdZ1SvGizDKTYFlj3HyAdkBBxh7winhN6trZiIrZWwHb8lt5qla17rRgjwDMa
         tjaAxWc38TpLJ/ETHc932olj9l2E8PsgTGwC7Z30rI73DIuwnSyBfMbQCRRYrk666gFD
         wisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779140182; x=1779744982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdhq85Gg3A+NvWbGs+q4HdNVWYpVSS2dUxoGdw9nwVc=;
        b=CkUYbi15AoUvF2efUuULg0201RUIx3Nzv9pCLVSIpGUBODqK0T+yX6HtpYlLHrrE2G
         egPPWGTzyOoR3rA+nSFBydr37Bj97IG07ySkNt6gzzl+Q5pHcUHJumKLWEXYmjYzBLLP
         DAO+LCCMNUiJeRABX5nQeDrAx8tbtpruwEIZU5JRi5pAVx7AqoNoe99CxSOll8qppTVc
         uGCLB3Pl6+a83tbgMH7cwXi4f3JjJbBBdyuu01e/KRzQaAHTyahUnehG4U2r3Ql4ZJv/
         ZIr2Iwn918X1P4AnnlrhfVdotzASWRdmi5kJi2K2IQHbLoDlvcOdiC30QSRp0qhsnVNR
         Awtw==
X-Forwarded-Encrypted: i=1; AFNElJ+KTJInRS229JRTsHoY0iGspT+MOBp7OzyWBlUHlY/qiJWEv2HKCMDN7stf5zg6STvHHVxLFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGnbVX3zMB+lMR/vP8in7iGHkBnaeUX9WuA1uwYkqmYeIYwaW4
	4s/4pMM10gT+KfGfgAruxjLGd10ZD4IfC6315D/RfTGxqoXQ/sgC2UumotpiCQjsmg==
X-Gm-Gg: Acq92OGIg2hdl3ZncdpHWHF4hF1cX6uv6ych/WJg5nq7jbrH8vGwxMgZsAzP7Cyp3j1
	ZnaWiFIkUk3a5sYLKtfo9pjsxYTNUA5GlbLhuOWII2CjMitUf4CfqdrjIwUKka7t9pi4Zy5j9TH
	QFP8tcbVYawizsOhSYZhnRWKXwYjjXIJrXi0+QkHIaXtiG8Hl4+P6Sa0SUFC3LRKKCQcg4KdbHK
	jIQb9fnRT7Zj+Fxo+cVLwaxhTgU9SThiMcqDqo/6s73rHFGWTfHtdzHatTU8Sbcvw1f0MPwYIFc
	mrSdFdJUiIqmGfPkdBVNa1YZNIZIhFEpOOpnLSAREb+RQnXwoytMk13UGaKdgRAlT4HiHhqsjF6
	T8qdv0eBYeCAcuQnECkLELC0sVqfBgGehqVMGZtSFu86driYw0CrVU9Ze8fpn1ZvTukht9o2RR+
	qIHP74AeKPeLAP8k6GkTI+9Kl+wQvUqPWxGKvjdlS2YFcfHNdTO4SkviKSWH2QAG7WxXOk
X-Received: by 2002:a17:902:ebc2:b0:2ba:73c3:49b0 with SMTP id d9443c01a7336-2bdb03acb3dmr4353865ad.14.1779140181119;
        Mon, 18 May 2026 14:36:21 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369514aecaesm12378424a91.17.2026.05.18.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:36:20 -0700 (PDT)
Date: Mon, 18 May 2026 21:36:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 03/16] iommu: Implement IOMMU domain preservation
Message-ID: <aguGR98563NEUwdS@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-4-skhawaja@google.com>
 <agsQE1lFGdo-b_IF@google.com>
 <agtenWUBOVosDCTU@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtenWUBOVosDCTU@google.com>

On Mon, May 18, 2026 at 06:55:50PM +0000, Samiullah Khawaja wrote:
> On Mon, May 18, 2026 at 01:13:49PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Apr 27, 2026 at 05:56:20PM +0000, Samiullah Khawaja wrote:
> > > Add IOMMU domain ops that can be implemented by the IOMMU drivers if
[snip]
> > > +	ret = domain->ops->preserve(domain, domain_ser);
> > > +	if (ret) {
> > > +		domain_ser->hdr.deleted = true;
> > 
> > Nit: This will become domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> > once we convert the bitfields in PATCH 2 to flags.
> 
> Agreed. I think it is being discussed that bitfields are fine in the
> other thread, but I will switch it to flags for readibility anyway.

Ack. Thanks!

> > 
> > > +		return ret;
> > > +	}
> > > +
> > > +	domain->preserved_state = domain_ser;
> > > +	*ser = domain_ser;
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_domain_preserve);
> > > +
> > 
> > [...]
> > 
> > >  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> > > @@ -752,6 +757,11 @@ struct iommu_ops {
> > >   *                           specific mechanisms.
> > >   * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
> > >   * @free: Release the domain after use.
> > > + * @preserve: Preserve the iommu domain for liveupdate.
> > > + *            Returns 0 on success, a negative errno on failure.
> > > + * @unpreserve: Unpreserve the iommu domain that was preserved earlier.
> > > + * @restore: Restore the iommu domain after liveupdate.
> > > + *           Returns 0 on success, a negative errno on failure.
> > >   */
> > >  struct iommu_domain_ops {
> > >  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
> > > @@ -782,6 +792,9 @@ struct iommu_domain_ops {
> > >  				  unsigned long quirks);
> > > 
> > >  	void (*free)(struct iommu_domain *domain);
> > > +	int (*preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
> > > +	void (*unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
> > > +	int (*restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
> > 
> > Nit: Should we add restore in the patch we implement it?
> 
> The ops are implemented in iommupt (separate scope) and it is done after
> the iommu pages patch as that is also required for it.

I missed the restore implementation in Patch 6, I thought that'll be
covered in a diff series. Mb. Please ignore this comment.

> > 
> > >  };
> > 
> > With the above nits,
> > 
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Thanks Pranjal.
> > 
> > Thanks,
> > Praan
> 
> Sami

Thanks.
Praan
