Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97292DC79B
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852489; cv=none; b=PVhRLT0Aq9MhlAvT4AIUtyYHHivrTZyv4G/yMbiDuC74JXPf0Qrm6akMIxq5y1zjg+ZaYWEC0nbDInzMi54M89ZhNRxuQVGM//NXbESFAYR4DfDh+yxItfbO7yatB+g+Mh6iB2zNHmWnMsHbieeh6xNOdldlHLGADULHZYCEsSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852489; c=relaxed/simple;
	bh=EgdbrvHnoBh/zDpp9ewcIGQxrvWxBBXiNgVYU0RjdCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv+xdsIxg9TrZCTR6SXjKmjFaCva0l3MvNXPoRtjHBVYzfwi6yuXOJF8WyIPylccsXV154IXvqUGVdMKkgpN7KQtDkDqczjzsTbXYFrK7FwP6z7eYPN5QWXs8wFnbBJM2vfiSJcY6b6RVydO+tDwebRHSMqAB7EuGTwRksU/PcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Jql7siU7; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Jql7siU7"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c52c1d2a7bso624125385a.0
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768852487; x=1769457287; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zwZ9o3ha19w1BUlcGeJzNZvsy/mlKSz+FRMjn04+Z/c=;
        b=Jql7siU7T8SrrFxwgL7D9N+WTkMzGGs+iG6gvPay9LI2pvvaVfqW06kcfcSkbbR3jD
         bO4XMm/OaAiLfdx8fhwxKmjL/W0UOkLIGm/Cmw+P5/WbB3hm9O5yY7Ibq7Y59uOIJD53
         aD9Wz/Wjye6+HL13ZBT4FTDzf3RIkLZq7gbPBenA1Uqlw/6978nu2sbVUemD7iw3QTXD
         SWoGV+tmqh8Ps5OZ5Xdoq/h5l6pOlpeAAgwStPrQs7AUoA7Hv9wFWw0w25LdcRALjOSM
         EElVIdIZzJ9S3FQfxF+RBNbNmtCM0nh6UOZytVabwsXnRI1ESVghlUy0WkeoUWtgt4qT
         SsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852487; x=1769457287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwZ9o3ha19w1BUlcGeJzNZvsy/mlKSz+FRMjn04+Z/c=;
        b=qC/EqPQvr5Zi54MFWSHgS0RKNR55QT504UcPHApl0C4wTdwZ4sEIDmVMtbLVTqHNWs
         6V6Zzg9Izsaa5pGEJ0iQG+QRI+fev604fk4ejcqiV8km9VG4GOBZujWU7AfPkixgq3ZO
         1fZBgH0shyQfE6C9GQ9b/iPio2gxMoWPiZP+DCysCBnRSl+KlDVVzW7SW9GDDf0iLvfS
         hwjOPm6+5KMKgCGg3wR5DFFFPWEW5CuxTTyhkJPKLnd/HN7mqz9PQsY7xLgGioPq45EX
         us7gQNoe84yIWiQ16Lk/YSQUPlMOSV9NfcbE4LQxlUXmtorOCjlst/t++k/WVfOlrINB
         Ks3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWu7urwNvH+CiDNfGMjU0qwvrICq1VvFTSbBEAIwiHjmgUPCwsQNckp9j57IXHl+NiyCNeiog==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyxx+cVmCLgGC3S2WCeU0jd3bW+qI1EwGV0/hg6XNdOsaYTnYE4
	O7hpKrTslHDe97Xa0Am6f7+Yb61NdB7VUBbwe0NgmKUnNX67X0Gz4+4bnH1RTbSPAsw=
X-Gm-Gg: AY/fxX4FmVx44A0UDZ62wwCPcvc9hn5n8Pt9hAW+oS/7TK/4BV6UDu/w+G+NgmEEyA8
	b6UkdwlmdTj5WZkgSfrOkKPZaBw2Z5cOdi4lJidQg50w2Y0N5tJabT38JbGtejPLMVWY1lHXx0i
	aaGC+3tEnsry1+GJeVrzRLuMvotVxb3RuNpb4BgNxlmUa1vmSb0IrDkxC2f07rTGsIGfnKlqTay
	1FrrwLmtgEFXjOqWWxG8JJHY2H4rSZgSAwCwBnn/IKint/l85mWoeLM+adIU68CT0QOZCERrBbK
	DaRA+tvpfB7li3suPwhE4Jbf3XiQZT3cT3NtyfiF76zOZYGCXKa9eFWKVAHjLb3BciMnx7uWLnN
	igFCYQvcZh2BumyAiwvMDeNMpi3hmAk78UGCJFTGyk4pWfAKmsErBvp9FN2uUER4v0tWwdLtjmY
	UsCNZksIsthFU1v0gqFxpA6bgICOOBeMQrbw8JG1PHjeIWEn4fmFflhMPkEMeihxaBp6U=
X-Received: by 2002:a05:620a:4606:b0:8a3:a42e:6e14 with SMTP id af79cd13be357-8c589b9706emr2117693085a.10.1768852486747;
        Mon, 19 Jan 2026 11:54:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad75asm86947906d6.31.2026.01.19.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:54:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhvKm-00000005JRT-0mKA;
	Mon, 19 Jan 2026 15:54:44 -0400
Date: Mon, 19 Jan 2026 15:54:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iommufd: Require DMABUF revoke semantics
Message-ID: <20260119195444.GL961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>
 <20260119165951.GI961572@ziepe.ca>
 <20260119182300.GO13201@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119182300.GO13201@unreal>

On Mon, Jan 19, 2026 at 08:23:00PM +0200, Leon Romanovsky wrote:
> On Mon, Jan 19, 2026 at 12:59:51PM -0400, Jason Gunthorpe wrote:
> > On Sun, Jan 18, 2026 at 02:08:47PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > IOMMUFD does not support page fault handling, and after a call to
> > > .invalidate_mappings() all mappings become invalid. Ensure that
> > > the IOMMUFD DMABUF importer is bound to a revoke‑aware DMABUF exporter
> > > (for example, VFIO).
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/iommu/iommufd/pages.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> > > index 76f900fa1687..a5eb2bc4ef48 100644
> > > --- a/drivers/iommu/iommufd/pages.c
> > > +++ b/drivers/iommu/iommufd/pages.c
> > > @@ -1501,16 +1501,22 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
> > >  		mutex_unlock(&pages->mutex);
> > >  	}
> > >  
> > > -	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> > > +	rc = dma_buf_pin(attach);
> > >  	if (rc)
> > >  		goto err_detach;
> > >  
> > > +	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> > > +	if (rc)
> > > +		goto err_unpin;
> > > +
> > >  	dma_resv_unlock(dmabuf->resv);
> > >  
> > >  	/* On success iopt_release_pages() will detach and put the dmabuf. */
> > >  	pages->dmabuf.attach = attach;
> > >  	return 0;
> > 
> > Don't we need an explicit unpin after unmapping?
> 
> Yes, but this patch is going to be dropped in v3 because of this
> suggestion.
> https://lore.kernel.org/all/a397ff1e-615f-4873-98a9-940f9c16f85c@amd.com

That's not right, that suggestion is about changing VFIO. iommufd must
still act as a pinning importer!

Jason
