Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BD6404898
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107618; cv=none; b=uJr8P62I86EuaTrFMBB64r0LndPkjOnfJn0MMbJ/0UQAHduE61hSFIncb9YMtCqjAQ+HNo2Bm1XFXNry2b/1A5pJPZAzFusesV/2leYBRsmMAm5/CeuTdYcLa2fX50DJgFzJY9fvSF5Mbv50w+rumwY8xRoFB6YrgWiMjQk6x+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107618; c=relaxed/simple;
	bh=eteect+ff8liDAlqaZm03mOtwH8hF75AgpasHuA6duE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW0OQmJfWTxFUSFcSF7MqcdJ8x7lp+oAowWcAlhtHV1CywaHst+KS1hPEHRFoBxowUqmfDdRuTzLVaWEOOetM3/AG1Kqyuhuw/EMw6EDuOMAFJOJYa9LlJ5/ctqngdh3PswoMg2KzyxXR3NTGf7NQS+pbdE40GJDY08NJyZMFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xf+wEyj8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xf+wEyj8"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d864c23bdso5361cf.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779107616; x=1779712416; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEg290J1ykCPkYwv69V6a2ExyDDaRGL6kITmZSq7l38=;
        b=Xf+wEyj85JrhMvIx8E5w6HU+2HVkgWFscSZj5gYirSZnMCav37BqgpfW8XZRR0lKgP
         VvX2BqDy2UFwgWwulgjlL5rD7gRKJXQp6cUWcZp82g13JzncdDhX0VbVpf4fpGuV4Ufq
         r0kcj7vHucKNEogi3Cs/0XmTRlVHzg1CN+yg4Kf8SKZoM8WpLEUz+5UfNTiFiwrvMH6g
         bdSiBKYBXBrgs6hhi7w2K92OqxJhiECEPgOLmsGw2B46oAz0GsSjDxzp08E02x9epmxT
         e9rmGfOV8HQaUQzQRBU0jHeItMY/sFUOO6a/aEVjHo2/eKtbgD7wee6AVe2RwdZ5MwxB
         dnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107616; x=1779712416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEg290J1ykCPkYwv69V6a2ExyDDaRGL6kITmZSq7l38=;
        b=ZXj2n8fW+9dbDlddjRumlTAYdNj0tdDLerm9wtt7WVK6DLXeXLvABYay9j3yklvyfo
         REdidxNF19UHF5K3p2kX+gx7y+JgYO81DHxtM/XMDGLJ8oAeyVttpP02DWqH87I2Evj/
         EvPTcxwynmjns9JUPNSLJMIxKy9ulQc3kfUq/SizJnFe/xsFSsssga2BMfqB1OVsWI8v
         mBNWe9kHIpTDSe+cFnTii8Mv1+Tjm0b0mV89YWR3XxPS25eUn6Lz0RUCZ3J7oJOFlsUj
         76XpkgadZdHi/PE5xVtwGQBmZpPg+DSrb7+GC3loExdUDDFxNlpSoftgvk7GaEethwBq
         zy3w==
X-Forwarded-Encrypted: i=1; AFNElJ9SFGuvBfHqQq+A4druBAu+nDcPuXU9yXdvWwBj13XXSpErJ1HBLj1MEk/DnY7xb9QYY9YH1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1SqZ58X8Lt54qeAtgcIQ+K6bh5174xLvdpHJ/RMUN6MjbtJHg
	9jh408HUcv2wgebuWK7lruIutMXQrwd8cX2qGZ33l00N5M7Vp4LuGMgB7sN78Af5tw==
X-Gm-Gg: Acq92OE+QS5IDE1ksZlcVRJzc6iofh2vNzqv/UaRahrGX8cYH4hw8Z77FGvtbcJ7DYp
	cbgJu3LlzUstLuxxDwa/VApe+IVg1lYBFFnJvE9tmNmaiwDRW9eq5aw6e0BW3M3KbPefMy25oPI
	MBtxwSqMsQITkTN0SV8rmJC57JvLx7GQDPU8YPiBab+pP9ax1stY1sJktLNe+TlR/U0TtRcBTlY
	WkF5y3Bdo1emspW/Hq/laOKJCyrtqiSnsMFFzI0/GDUyXiajBccmD0so16UUKi2LOW0dneY2FsK
	xqP7OqikQ04Pcywd61vNW8ykIMBBeISE8vfd4MkNxUVdMa8k4GDsPmr/4G4psk4G9IAIRElnA6z
	fMHiMt6osF/CgTwHA0whejWzTymlvnPzvvlIpQEu++5nn0j9fxcfF+RzR441Y1Hw/sw9luhMRGd
	gT0nytF2UJHoWYqzOe51K5u3oJHF3NOnOlrGxII2cXG+i/1Ih3NJ6ezvRouuj5Ph1tMTXq
X-Received: by 2002:a05:622a:8c0e:b0:516:3b3c:1df2 with SMTP id d75a77b69052e-5167945fee9mr12767131cf.14.1779107615481;
        Mon, 18 May 2026 05:33:35 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c6cd4f5sm20692257b3.35.2026.05.18.05.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:33:35 -0700 (PDT)
Date: Mon, 18 May 2026 12:33:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <agsHFbI_FQEXiZAA@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afUe71D8JfgmA0BG@google.com>

On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
> On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
> > Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
> > alloc/free helper functions to allocate memory for the IOMMU Live update
> > FLB object and the serialization structs for device, domain and iommu.
> > 
> > During retrieve, walk through the preserved obj array headers and
> > restore each folio. Also recreate the FLB obj.
> > 
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> 
> > +static void *iommu_liveupdate_restore_array(u64 array_phys)
> > +{
> > +	struct iommu_array_hdr_ser *array_hdr;
> > +	void *vaddr = array_phys ? phys_to_virt(array_phys) : NULL;
> > +
> > +	while (array_phys) {
> > +		/*
> > +		 * Failure to restore preserved IOMMU state is considered fatal.
> > +		 *
> > +		 * This is because the IOMMU translations for preserved IOMMUs
> > +		 * were kept enabled in the previous kernel and the preserved
> > +		 * devices have their IOMMU domains still present. Not being
> > +		 * able to restore means that the memory mapped into preserved
> > +		 * domains might be already corrupted by the preserved devices.
> > +		 *
> > +		 * There is no way to confirm the integrity of the memory that
> > +		 * was mapped. BUG_ON is the safest option at this point.
> > +		 */
> > +		BUG_ON(!kho_restore_folio(array_phys));
> > +		array_hdr = phys_to_virt(array_phys);
> > +		array_phys = array_hdr->next_array_phys;
> > +	}
> > +
> > +	return vaddr;
> > +}
> 
> > +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
> > +{
> > +	struct iommu_flb_obj *obj;
> > +	struct iommu_flb_ser *ser;
> > +
> > +	obj = kzalloc_obj(*obj, GFP_KERNEL);
> > +	if (!obj)
> > +		return -ENOMEM;
> 
> Should this be considered fatal for the same reason
> iommu_liveupdate_restore_array() is considered fatal? If anything in
> iommu_liveupdate_flb_retrieve() fails then the risk of corruption as
> described in iommu_liveupdate_restore_array() is possible.
> 

Righ... Nice catch. I suppose we should BUG_ON() this because
luo_flb_file_finish_one [1] returns void. Thus, if we return -ENOMEM
here all we get is a WARN_ON without panic.

We can't statically allocate obj in liveupdate_flb_op_args because obj
is a void ptr. I believe we must add a BUG_ON() here.

> > +
> > +	/* Data must be present and valid from the previous kernel */
> > +	BUG_ON(!kho_restore_folio(argp->data));
> > +
> > +	mutex_init(&obj->lock);
> > +	ser = phys_to_virt(argp->data);
> > +	obj->ser = ser;
> > +
> > +	obj->curr_domain_array = iommu_liveupdate_restore_array(ser->iommu_domain_array_phys);
> > +	obj->curr_device_array = iommu_liveupdate_restore_array(ser->device_array_phys);
> > +	obj->curr_iommu_array = iommu_liveupdate_restore_array(ser->iommu_array_phys);
> > +	argp->obj = obj;
> > +	return 0;
> > +}

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc3/source/kernel/liveupdate/luo_flb.c#L208
