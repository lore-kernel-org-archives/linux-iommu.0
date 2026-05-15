Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAC30C166
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869406; cv=none; b=nGjOgfTr0WaNZnBa4nE208ng7+8grphLEczq/x30Fa5Bf0Ked56ZCqxaNmiLTfBUtkouvPlD6qu3PiNTWJ2p9mrRGvA8V2xayK+Xf4UgM41wG7e9TB+wiJye1xmwAM+wktHPMqqHVdm8roNlYBD43U0npy+1MJhc0Agki1wVkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869406; c=relaxed/simple;
	bh=gMaEvicj1lkTTKjknQzylRPd7tw3CbzIlWyBBZkqlhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLvhb847Z7VWF22ZA8KBDo8/mWiP0gfJvxDEdfCqdsitXMDurLNtGcceslgAjlSGbC1FCNyU+/DNlDoFbpAToJU//HRWcu/NWguhXAOdW97Si/zeWzCxqlp2tvp3VK09ukwNWoDRDsSaFNh6fY2VvZpi3gs5R82b4RDfg3VbAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jK+Gib21; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jK+Gib21"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50fb4a7d704so1739781cf.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778869403; x=1779474203; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQNJjeOCe7S+U51t5FVhB76I4sx7yhCYVtg8gepAxec=;
        b=jK+Gib21bIUBHXfdTmfV0l1jq962U3m3R5LR9inbfgxM7o+gVcb1VQ+opTKbe3f+TX
         nnsm5K8ZgYvlq3HqEP3zQj67zmCzzwvj146q0EIN7IyJrP9P6fWH8pZkln2zYuW1wDs+
         wl2je/ynLQmHwqN2EaZwI29/9Ygyhnx06btdGMVXkv81VYmPfShhHteQMiB6Aou5s1S9
         YlNE5fJwLeLlbc3ho7UmuzFJkZ+YdXCMQSeIa7huERHTWyWDK+cegDoERnJJRGtHLeP4
         Vzz2hAql/Zs835Y0ob7uiVGsazDF+QcCKftzUHYTTXhGk6NINKNCtWChDsi7mze4zpN0
         zzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778869403; x=1779474203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQNJjeOCe7S+U51t5FVhB76I4sx7yhCYVtg8gepAxec=;
        b=F5QQ7b/ZdeRFJYbjgpkdQ9OYcqXcnk+WW0waHn+SoU8PvREf6BdAgf9Ey8/DsAAE+H
         RO/LRx+2bGE6q3wlNwxYWduk4xi1BZxR9hR5ZWliasYLhLD4gE1x0EnomI7G7MCNDEkD
         8X8Oyoe0CAqg1FiXi5xszcI8sUjImH6vAX6qMflC7mnyelspfv38cjMoxnizhVIRNHBx
         5saeW5x2S8BHwSZjG+loowSDnoqS/OeVaodHvVVUO4KRyD6lu7xzI3Bw3VmcuNhoikwA
         33L9MzSiMJ2kGmJAL5oaYxVwnBbCkmI08QdRJwlJfF1KVVy1ZLeOkwzV/pkLsi4OjtYm
         qidw==
X-Forwarded-Encrypted: i=1; AFNElJ++xl2zOQoPekNYhrxWyGoITwtcfQegsbIEW2RuS39Igz5bpQrJpyNyNtk0UjHz1KA7pNZZVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxs+mfU5aMCmHmmsL80tW+KWioC7hzeQmA8dgzrnID82pWGF/uL
	W7XyDpYGcwY0wXoHw7BsXjAlBNHIz5Dof7xNp+LLE9rhoQEuZn6pgk7FIxmmZd5Ki2M=
X-Gm-Gg: Acq92OGxskA6XvrTubgS0/BOTxbsDCRaDYLUEcHsPicub5jaJ9ewNcMxjnGQX+QuZVE
	nnP2vF0rLE26ePe0M3WImvVYoNNq2DPOHZ1r+abEkxJFOXvejGEbsb3dwTxECeZip66KbG07nbc
	Lc5hpYLeAC280YcWxhwGAgI4qZxtfHh6LnEVHCtDRGb/nsptORdZ/ahePP8tnpJzRseExYeGXng
	vj+l2jlqvUmf1pwAwsmWVrMaKIa6SC1Kh4J7enKEkFC6Dbrx6Z7GZt4mTGdSyffZhXvG1kquQE7
	UiT6GaolS+rAL8bDCn9NRfrNW0KujpQGxOma6lfztn5YgGMKFm5WhPXe4iGMmhudUOow7DHxl4Q
	9h45i0O6CIa9nDg/SLAzU1tR/gjH9vMMR/J2xvlWcXxa7xcT6y60OACTQbgk5ANZi4grJH9D2PG
	hlYcntsteoLKD3qZyeaNtmPjsjqmYHROnhSAssX+yQzbRFCdffagDvgIkJtQicyYo2bTliRAhUs
	HZi0g==
X-Received: by 2002:ac8:5742:0:b0:509:2858:3c63 with SMTP id d75a77b69052e-5165a0703c1mr72758491cf.23.1778869403362;
        Fri, 15 May 2026 11:23:23 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645801211sm50772901cf.20.2026.05.15.11.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:23:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNxBy-00000007tTG-1fso;
	Fri, 15 May 2026 15:23:22 -0300
Date: Fri, 15 May 2026 15:23:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V3 09/11] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260515182322.GI7702@ziepe.ca>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-10-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512020259.1678627-10-mrathor@linux.microsoft.com>

On Mon, May 11, 2026 at 07:02:57PM -0700, Mukesh R wrote:
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	struct hv_domain *hvdom;
> +	int rc;
> +
> +	if (hv_l1vh_partition() && !hv_curr_thread_is_vmm()) {
> +		pr_err("Hyper-V: l1vh iommu does not support host devices\n");
> +		return NULL;
> +	}
> +
> +	hvdom = kzalloc(sizeof(struct hv_domain), GFP_KERNEL);
> +	if (hvdom == NULL)
> +		return NULL;
> +
> +	spin_lock_init(&hvdom->mappings_lock);
> +	hvdom->mappings_tree = RB_ROOT_CACHED;
> +
> +	/* Called under iommu group mutex, so single threaded */
> +	if (++unique_id == HV_DEVICE_DOMAIN_ID_S2_NULL)   /* ie, UINTMAX */
> +		goto out_err;
> +
> +	hvdom->domid_num = unique_id;
> +	hvdom->partid = hv_get_current_partid();
> +	hvdom->iommu_dom.geometry = default_geometry;
> +	hvdom->iommu_dom.pgsize_bitmap = HV_IOMMU_PGSIZES;
> +
> +	/* For guests, by default we do direct attaches, so no domain in hyp */
> +	if (hv_dom_owner_is_vmm(hvdom) && !hv_no_attdev)
> +		hvdom->attached_dom = true;

What are you thinking sending something like this?!?!?

The function is called *alloc domain PAGING*, it does not, and can not
allocate weird "special" domains that are not PAGING domains. I just
spent a long time removing all this kind of crazyness from drivers.

There is alot of other things I don't like in this patch, but this is
too much.

You have to drop this "direct attach" idea from the first iteration,
Linux can't do it without alot more work, you should start with the
basic paging domain mode.

Jason
