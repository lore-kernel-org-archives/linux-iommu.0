Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1936922D
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863014; cv=none; b=ohF3zg5Zzsz0EDN5Z6TZ+rLxOoFRAj1P+uwh0HSou+ji98m3FS1D6MhXmStYVsgUENOGxZNBA1y4kORRJdza0HAXG42uXmEidIRsbCFcdeGk5cDCcfOcWBuXMnmx6A0pdTGyC1+WE//A4fReQUqkEuzJpngo+YlRAvI6viIhGDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863014; c=relaxed/simple;
	bh=uuKi1X0TZzBYQCH/+D+igtqxtVeYjyboC6Wv2+XouX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alrPBkYdxg1S2QwIozJuYxSxKv5GqakgmYMMD5nyk8XyNx1OlWiXIJu3ryrBoMJakJk6vSHFc13wTwfDqrYLJUMA/p6mXyFAuroFiSJJYSGGdmTo0tje/UzvlZOxi9Hbq3OofDpPeEPh6/abltwrarjQka/jKPix3EvKYCBKEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l+ztVPU3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l+ztVPU3"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d424af6282so286526585a.0
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775863012; x=1776467812; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cd4+5YI3Ts2enNXoZMTCszEKCVLBE3ELOgKW1U5A4o=;
        b=l+ztVPU3i1knGAHfWSRnH58DoOfrKvb6Ka8kL9jBKv3xjaD00nXjnxOCfEDd7vhB2M
         HX9OI9jgYGqIeURMg4uEiiAay7Zmw9af9YKNjbpAdEjjyHfbrkQyilYweMVoxC5NckfO
         fb/1JRdXcIJwCdqlWvOtNZngZ1c/oGx6vlKJg8iT7AUWZfK62OmCvkugHlqqyUcne1b+
         r0NX0u14iqY2OcnIb5x67bWiQMxXxuyIpyLXv/0rY6iU1wptsaHQ1pglQPNLBfoubR36
         OCApUfi8SSdGnM4ijpndwl4MBAsFurv6MG0e+UxxOCQ2puyXuKwPn8rZDBT+5J4QwsUg
         HZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863012; x=1776467812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cd4+5YI3Ts2enNXoZMTCszEKCVLBE3ELOgKW1U5A4o=;
        b=Gjw5zi25sx8m3qOd6h95gFeHqC5t+zQjxwvtpvTsBbVxT2pcuPm0Wv2AdPy+0OwILP
         Sp6HUPyHBQ/EHoJ26da4puC6jD24S/MCCLPKN7F+OEJV+/xDdud8qrEhO1Msm7vyaLW2
         mUJd+QQZdZls/bPNQ8PrM6WjXbugO6JYPbuPvOW1GffWffTrzrt0apl6D0UYQJ+yWoWH
         SvAAHk8eLxd+G+PCzrCOCtIFyWRgSF1Q3fqr6TP/Sbh4BXY+S/0+ZouZ0mFFIbsqhqVJ
         rufq/yq9Hhrgl0dPnJYeAZQm4iV99EI3i/X97iykdAMSTlp+xk/fDBHjJfsOOAe5oHh1
         Oc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8gEBqoFXRAwcu8X6rO2xpyq2aXfxN1YH+qnk+ss5tD7btOT5Mt3+6lQmEgvb6J0aJ6gHxVA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywda2/RnbLPmTYbKkWSFsSgBBSxF0HSp6hcf4+RZlfxWXS76pRE
	IxNgsNqdx3AjqunSEE6msY6MwjYh1SLlpcuBe+9bD08BpheW+ax6GjlzJRRddTxhkkU=
X-Gm-Gg: AeBDiesg9K6C2Axs/8sowENS5kdkcDsDKdPnAdmKDzCteI0Qa7Zvlur6GPCZwXtq8il
	CbKs+tiBSMkxcxv7NuxEPmhfzCeP1d2Ig6/YFzk+waRiCbpfIO94n9/x8OAr6amut2qp3zDypc5
	zCgVcWJrMcyelETdHGPWkQW1nK5XmDbOt6ZSlCnDI6Frk5AL48eTv62ZhgbRpeoJeDKtQn6qQ+n
	Q+3Z/Owq6MF78BIxQbozHmXfX2gsuJPk5fStNBJqRVFeOPV+0uq52l9TK7MGOW5z5pv11CkZhyw
	6Xdg6P5pUrzZo8YIy+2cGiF4d2s0TfoiYZ7unATCTyPl/mkOQKPlvvB5S2P9MjQzCTABWfW/Mtu
	meC43Cz870VWRQaJFL3YqKtTEZiSPl0YuQ+DyYgEznxPoeGoQ7b4ybtEw+V+FEOa/2PKVKlrlds
	jffEXBdVe1+ZZCpJo+n/QJtCtuO4cnDIx+E+fOj6jWV6pbQ3X1XKixgSC5cpVkKdRR/b9mvg==
X-Received: by 2002:a05:620a:1a24:b0:8cd:b626:cdf1 with SMTP id af79cd13be357-8ddcfcb2c39mr749957785a.46.1775863011618;
        Fri, 10 Apr 2026 16:16:51 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb934dcd3sm342518785a.34.2026.04.10.16.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:16:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBL5m-0000000Gks1-1hx8;
	Fri, 10 Apr 2026 20:16:50 -0300
Date: Fri, 10 Apr 2026 20:16:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <20260410231650.GD3694781@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
 <adl2QX6gra99bkOV@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adl2QX6gra99bkOV@google.com>

On Fri, Apr 10, 2026 at 11:02:52PM +0000, Samiullah Khawaja wrote:
> On Fri, Apr 10, 2026 at 11:16:52AM -0300, Jason Gunthorpe wrote:
> > On Fri, Mar 20, 2026 at 09:57:08PM +0000, Pranjal Shrivastava wrote:
> > > > +static int __restore_tables(struct pt_range *range, void *arg,
> > > > +			    unsigned int level, struct pt_table_p *table)
> > > > +{
> > > > +	struct pt_state pts = pt_init(range, level, table);
> > > > +	int ret;
> > > > +
> > > > +	for_each_pt_level_entry(&pts) {
> > > > +		if (pts.type == PT_ENTRY_TABLE) {
> > > > +			iommu_restore_page(virt_to_phys(pts.table_lower));
> > > > +			ret = pt_descend(&pts, arg, __restore_tables);
> > > > +			if (ret)
> > > > +				return ret;
> > > 
> > > If pt_descend() returns an error, we immediately return ret. However, we
> > > have already successfully called iommu_restore_page() on pts.table_lower
> > > and potentially many other tables earlier in the loop or higher up in
> > > the tree..
> > 
> > It doesn't return an error, it just propogates errors from the
> > callbacks which this one never errors. So this is just dead code.
> > 
> > > > +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> > > > +{
> > > > +	struct pt_iommu *iommu_table =
> > > > +		container_of(domain, struct pt_iommu, domain);
> > > > +	struct pt_common *common = common_from_iommu(iommu_table);
> > > > +	struct pt_range range = pt_all_range(common);
> > > > +
> > > > +	iommu_restore_page(ser->top_table);
> > > > +
> > > > +	/* Free new table */
> > > > +	iommu_free_pages(range.top_table);
> > > > +
> > > > +	/* Set the restored top table */
> > > > +	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
> > > > +
> > > > +	/* Restore all pages*/
> > > > +	range = pt_all_range(common);
> > > > +	return pt_walk_range(&range, __restore_tables, NULL);
> > 
> > This should probably be doing something with the FEAT flags and
> > ias/oas too or do you imagine the calling driver has to deal with
> > that?
> 
> During boot the iommu_domain is recreated in driver and it sets up the
> FEAT flags and ias/oas properly. Then this generic callback is used to
> restore the page tables.
> 
> Currently the FEAT flags of a domain are not explicitly preserved, I
> will preserve them and error out here if there is a mismatch.

Hrm, that expands the ABI a bit though

If the only operation on the restored table is free then I suppose it
can be simplified quite a bit, you just need the minimal things that
the collect walker in free touches.

Is that the intention, free only?

If so then the restored iommu_domain should be some special free only
domain too.

Jason
