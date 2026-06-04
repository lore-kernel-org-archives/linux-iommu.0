Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3273E008B
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582384; cv=none; b=ZG6urlV+7UNiQAyQ6smmBiZq6B2lyp+R2RpCzLRJMRpF+j8qwVK0bx2su3jbNNK8gEejj6iMoTZxuq6VtyVwBfHqhXteqeiPHjCXKySwia1W64/+zAqA6TaHWcoNSC5uw0RmJhqdGbK2LuxtZkgNym3WQI0PUQ+LDxIDWz7zumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582384; c=relaxed/simple;
	bh=gpdnwV2DnbeS2Luujuh3pWY+HT/ULmOQY1sUF7OfAQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My849IitQT7ik2Xdvc2SC/hKqidEYFF+JjjOrS5/9Z7Wb3SiNZklvJCL2R21ROP9J/fLARI9TWdhaTSxa3pFY029xI6Stgaj8VBUSQ4u6/NN31b0ulamLRGkkXVDZ5guzxEx875W3JNhZoWO/2LqHxKIW8NI0Jdf83J4/s7b+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M2pykKMO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M2pykKMO"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51776b4de37so6075291cf.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780582381; x=1781187181; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6SN06MWYgnamNhN1ZWgRIcR80dI4EtU2wUgYpm//Klo=;
        b=M2pykKMOPXB8W2mvPMwnuJH5meeWn5Lvj99p/PewnM7ZcYk75CoykBZo/gOWnzYmpS
         Dsc1XMJoT6P9tQDecsrGRwZCFvRyWpFvOah+efGE25JXsi6TMGmSgwyWtQ1+ZwxhnTme
         aUfQ22wGbo0QSCK4HdICEgXvlmYFTYve8aBKZpNyNm0gIwTyCqLefep9tTxNhbNf8PNO
         ahDDoqymjElw4tPLOYgojA2e5y+LWOuKfhhFQ48lU8wgm5XcC5OUAxd/WpgaApDvqxJ5
         VZxzuFN7Nsx2I/BBLmNWmO6Q8rXAaafRrectp//I8A2j4dVhMkFgqIA9hr8jPPb5rhpR
         dvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582381; x=1781187181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SN06MWYgnamNhN1ZWgRIcR80dI4EtU2wUgYpm//Klo=;
        b=NSolttiV+9sKfioq/AMxS+Kmr7WFqgTkEP35GPCbkqUBilLQntJNbZX0XHGiJ0aQ8w
         VwtTmomMgDBEmGAOY6EhnQex7k8CdXM4pUF5iQpYxPh2hI7hYIbf/I/VhceBSajMYOw6
         k/QYORblF+7Qc+v5I/4d0CsqfzNHyEkyi0XpdlhwONrvimh+X2jQgRpgpJAUvV7wJ7fN
         oh0pnA7V/sxzwRuUNE/U0XTItimk6K4TkBh+CuNqmnCe9txBt3vtMcLnIokwnA6vsFZ7
         lCXLZerPy3npAb7dg1wWf/YVmtiHUd3PYd+/xGwDgBrrldxzR9MixGqoswFEFjD4P6rE
         Uo2w==
X-Forwarded-Encrypted: i=1; AFNElJ/eFtUIiXJ67CQppzjtxX3JKhwATkjBnTxLPeWxL9AOD80F0L8p3k65USWzuikwAz5Bt8ZnSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxORSguO2wCpvpYazE06M/lNSfDLO6CHsE7H17DlZhwqO6TPjXA
	y4SrvaGFbCtV2tFDBWYZrIwywnoTyf2+srUmq+G8gKveQ2iFYSBX0eu6UWi/MHk49yU=
X-Gm-Gg: Acq92OHXQHd3B1fawIv6dWkimMdBSysCTIUiPR/XXVHP3uD9fB2gplSSPGKeLFhzNG7
	VCppkaiDxwIpnqnTj9Eg7YpWmdFTLS9gjeU0bQt25INrP7EN+cDJRW706nIA7fmzrarJz0UKIZy
	17lVWE5WAAy/O9sWTgJEVk5Ks7uSvOpUqSd+hovz8RPBqGfKPUpzFViNxrAdkkvr2GRReul2d4y
	CU13xiApLczBUmn65I5tJ0o2/0iNTqMh5kovNIYjTi/BRFXuDCfw301X486Fm7JkD5aMDndTJ5u
	5b6sLVZHELTYyVexPd+9I0ZWr8JbgG5BPi8tISNRxPDVxv1wyAjiggWNzSzbwV6s85aXbr0zr6p
	F/hQZ7kskoQr2I1YnVQOhZ4ZPrIJM8z4UGXHmxAom/3ruHRDrgya+412d1Y29uii+3Qkc+tstjt
	Ay82x1eVPD5wtqFuVfQ9awRAH1iiuwJIHTc+0XN9hNLLXViuGEZUuoNIjZ0SB8APw0c/1jPUv4u
	5agF1I/B8bd6cKxWe5Hr9BlH88=
X-Received: by 2002:a05:622a:598c:b0:517:1465:9167 with SMTP id d75a77b69052e-51778696c8emr120221011cf.28.1780582380950;
        Thu, 04 Jun 2026 07:13:00 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775df4dd6sm52447511cf.27.2026.06.04.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:13:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV8od-00000008HC1-3PHn;
	Thu, 04 Jun 2026 11:12:59 -0300
Date: Thu, 4 Jun 2026 11:12:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	alikernel-developer@linux.alibaba.com,
	boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 05/32] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260604141259.GW2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-6-guanghuifeng@linux.alibaba.com>
 <c179b999-8c7f-4338-8aad-b61fd09f1329@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c179b999-8c7f-4338-8aad-b61fd09f1329@linux.intel.com>

On Thu, Jun 04, 2026 at 11:30:37AM +0800, Baolu Lu wrote:
> > -static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
> > -					     unsigned int level,
> > -					     struct pt_table_p *table,
> > -					     pt_level_fn_t descend_fn)
> > +struct iova_to_phys_length_data {
> > +	pt_oaddr_t phys;
> > +	size_t length;
> > +};
> > +
> > +static __always_inline int __do_iova_to_phys_length(struct pt_range *range,
> > +					       void *arg, unsigned int level,
> > +					       struct pt_table_p *table,
> > +					       pt_level_fn_t descend_fn)
> >   {
> >   	struct pt_state pts = pt_init(range, level, table);
> > -	pt_oaddr_t *res = arg;
> > +	struct iova_to_phys_length_data *data = arg;
> > +	unsigned int entry_lg2sz;
> > +	size_t entry_sz;
> > +	pt_oaddr_t expected_oa;
> >   	switch (pt_load_single_entry(&pts)) {
> >   	case PT_ENTRY_EMPTY:
> > @@ -159,45 +167,77 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
> >   	case PT_ENTRY_TABLE:
> >   		return pt_descend(&pts, arg, descend_fn);
> >   	case PT_ENTRY_OA:
> > -		*res = pt_entry_oa_exact(&pts);
> > -		return 0;
> > +		break;
> >   	}
> > -	return -ENOENT;
> > +
> > +	data->phys = pt_entry_oa_exact(&pts);
> > +	entry_lg2sz = pt_entry_oa_lg2sz(&pts);
> > +	entry_sz = log2_to_int(entry_lg2sz);
> > +
> > +	/* Start with the full mapping size of the first entry */
> > +	data->length = entry_sz;
> 
> data->length doesn't account for iova offset. Is this by design? We
> should document this clearly somewhere.

That's defintaely a mistake, the phys has to be offset by the iova in all cases,
it is part of the API.

Also add kunits tests to the iommupt selftest to cover various
scenarios please.

Also this doesn't look quite right, the walk should look more like
unmap where we just walk and stop walking when we hit a physical
address discontiguity. The stop point defines the result length.

Jason
