Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24AE26AAAA
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962521; cv=none; b=UZm3rXaaQSWFzxDdK05kmT2ehypy2L1zLO9eQwsHj8RGoWQr6cgcKtA4fvHZvorFGYaRY7DS5e/TRDsNIPbCOiPr/t2NzMDafz6icP9tsrcAAbIaFFNv8NHnm5fO9cO+kqnJEM3M7d4clX3a34VLc6wIKLDHej5nIuySpKgdStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962521; c=relaxed/simple;
	bh=JFtp/04AN6971ALn40g4bC8CVWUHKgt3AbR5wojCJVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3LNrHe4+EcV4Qrsj1L7ijwAjZVFMqu3b4jdvJ7h2+DA0GAf/Ss5VT6oPrlLyZ4rJ/JLUjbgE24w0xydArRysWxyFcy/9KV6jDnOCcO9eJeaUbyALbsRqYtUOjnUcOvc4cQ88Xq6uHA7aLWGnq46nxKKHwkwJs1zRlNQHqViKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4AfRXEFl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4AfRXEFl"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240aad70f2so240395ad.0
        for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745962519; x=1746567319; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpYoUff4tpb7ZnYnv11tnvX2uEPBYr9ascXUqkCwOTE=;
        b=4AfRXEFlmjF4rs+0nBURTHheo/Y+qXkS99Xu93tztwDoC6TFF3f4nPY4+wMeIH+Vsh
         enTUCxhPlnv/ENz0yucRvLayJpDj7zPdTODe6+mgroBMNola8L7iwtJ15kn8BEnhJJAw
         TiDtnwEdKWwK6TsP6ema4MJbj/YGvUbQ7koMGOtidXoZdZDneC4tIE0BSocnZXv7NYPd
         rZ/G6BroCkVlHACWP5sPBBF7lj0nfmHjqUK+rCqTUpUfHtEzQ4h3dNGTAUmRdMB18sSC
         FHVVNmBBTrnaXE36NApIGCsAvbyWAACNYOwl9pG3pM/2MuCVqse/DU2k1uzWSLSl182I
         wv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745962519; x=1746567319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpYoUff4tpb7ZnYnv11tnvX2uEPBYr9ascXUqkCwOTE=;
        b=iw+L6iM/9V7fCNQBkuytPznvd+PLrFWrbui4OvQQqeIU9UNsEjoLHSnyuE3B6srp6m
         IbAcBHc9CPjnvv4C2lBR85CzWf2ucqsL6FIihHYFZS4mbI9aVnfrLUK9HoAn/NCITIhD
         95NdcXp7mezvLOwbCALP5F+jPna2jK4pO4Vimw01HH8i9gnc8gknllyHzfBfdZAzXqsJ
         zjafWasjR4BExoLHrvcKEu1cKOpbsCCsaWugvWPmL5B7LGlPa9HBwKMXmr7JCelobGMp
         W17/ib6D4HXTF78nj3/z0Z0RrAR21rY7WeYUJXParmuIQK0NVypJDcD7hbW0GlELCT1h
         wnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkx9wug7sONphl2S+2V4MivA1A5VJHH5vgAFBXBY26QTTsPwThsCq+AxOCP6+8XHPD9Rz/cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJjeZQX/m6o7jcVA6pqz4Eo9I2CdHJKtdvzGmr4EORXmstnJrT
	6H8nRe3hTwM5O7eGAoC5ZegH+D1CY/VHNhyoP0Usv53YtbQpuqsBFmzWkxMTyA==
X-Gm-Gg: ASbGncut8/+E2Dwl2DQ7woz521UgiM5ZW5mnKCgzl4zSpWNYw7WGaxVAo0Fm+tJIVOp
	CK786f+26IagqBiMcfNG0TnDio0dXEZ/Z/1B74pK1iB5vcToVnOhChsOr6hPVc0TV1Ct0romDGL
	T3+mg5MrRoRSQJTsmwc+merU/yfZdEEDWPcFNa+6389/x58wV80j/ehKuwg9W0OJSVB7zMGoEuc
	aZDfm58zGAmytn6bAcMCdoEGp1PN7I+AsBJhiXCL94PWLVX6ygR8A4xhbXbyF2T1p/BgdIz6ONq
	NQvqt8A9igb5z8DdFBFQeDyDNtYgw/7zNFKL/zOxep41phvJdJmPk84AtstYl5JJPARU8RT0
X-Google-Smtp-Source: AGHT+IEiAc8Ows6C4iR4kgPCFAlWxuerupIBpLK64UuYqayp18C/qOLe733Vqo0YiAcQG8JFaBI7KQ==
X-Received: by 2002:a17:902:f681:b0:200:97b5:dc2b with SMTP id d9443c01a7336-22df54469b2mr228275ad.15.1745962518918;
        Tue, 29 Apr 2025 14:35:18 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3480f08csm42489a91.39.2025.04.29.14.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 14:35:18 -0700 (PDT)
Date: Tue, 29 Apr 2025 21:35:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBFGCxcTh54pecsk@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBE/CD4Ilbydnmud@Asurada-Nvidia>

On Tue, Apr 29, 2025 at 02:05:12PM -0700, Nicolin Chen wrote:
> On Tue, Apr 29, 2025 at 08:55:47PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Apr 29, 2025 at 01:39:09PM -0700, Nicolin Chen wrote:
> > > On Tue, Apr 29, 2025 at 08:34:56PM +0000, Pranjal Shrivastava wrote:
> > > > On Tue, Apr 29, 2025 at 08:24:33PM +0000, Pranjal Shrivastava wrote:
> > > > > On Fri, Apr 25, 2025 at 10:58:08PM -0700, Nicolin Chen wrote:
> > > > > > +	struct iommufd_mmap *immap;
> > > > > > +	int rc;
> > > > > > +
> > > > > > +	if (WARN_ON_ONCE(!immap_id))
> > > > > > +		return -EINVAL;
> > > > > > +	if (base & ~PAGE_MASK)
> > > > > > +		return -EINVAL;
> > > > > > +	if (!size || size & ~PAGE_MASK)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> > > > > > +	if (!immap)
> > > > > > +		return -ENOMEM;
> > > > > > +	immap->pfn_start = base >> PAGE_SHIFT;
> > > > > > +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> > > > > > +
> > > > > > +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> > > > > 
> > > > > I believe this should be sizeof(*immap) ?
> > > > 
> > > > Ugh, Sorry, shouldn't this be size >> PAGE_SHIFT (num_indices to alloc) ?
> > > 
> > > mtree_load() returns a "struct iommufd_map *" pointer.
> > 
> > I'm not talking about mtree_load. I meant mtree_alloc_range takes in a
> > "size" parameter, which is being passed as sizeof(imap) in this patch.
> > IIUC, the mtree_alloc_range, via mas_empty_area, gets a range that is
> > sufficient for the given "size". 
> > 
> > Now in this case, "size" would be the no. of pfns which are mmap-able.
> > By passing sizeof(immap), we're simply reserving sizeof(ptr) i.e. 8 pfns
> > for a 64-bit machine. Whereas we really, just want to reserve a range
> > for size >> PAGE_SHIFT pfns.
> 
> But we are not storing pfns but the immap pointer..

Ohh... so we are storing the raw pointer in the mtree.. I got confused
with the `LONG_MAX >> PAGE_SHIFT`.. Sorry about the confusion!

> 
> Nicolin
