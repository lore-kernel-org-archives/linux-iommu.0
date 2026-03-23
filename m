Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C323387349
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308477; cv=none; b=ee6G7KNUuYpZw89tc0HVZiDVqPBfWLq6a/8vI387DxGGiGLbBWOFx6KwMJxlvpgIWGVDWN26kykQb9GmvAhyszTk0Kp443z/37hHQTyrjJF1+yKmag5QzDT2SUZsLKnTF7x85/4GsgDUBAcc9dl3J/ZnaGUxec+sdF1EVSHH4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308477; c=relaxed/simple;
	bh=xyTAlm/nDzLtoICM+Sme2HT8wUexULM0SnT44f8iKLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqrX3lL48ASkjqHHq84fMYUX6g7oK+G3bxlhEkC73KrH2qnOGaAiapIpcpdY/Dhm8c6hfGfG8eXn8AXM7DV28SAMgtfhb7wOU3QXWn38srtWh48d6/4sjavZOC29qvKX2Ne5Pwl0oroHqKl3wA+OM/0iKlh/vJHFQbO7r5AkRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=De0VlBle; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="De0VlBle"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b052ec7176so19105ad.1
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 16:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774308475; x=1774913275; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ooi+h3bcAW5zP8MJCZDzVnX7Ev9079/RsplLPW5OVU=;
        b=De0VlBleNhyBwuhgj/+iDNmGmZiwC9WasO2Y3TEy4aCpG7oetAsHwMaf/SAO5ArE2S
         /gCd3s40/QcogPOAzZOawHy2MLFhWQ0ovJik+1iah0RN7ly9BUurMIWO1DlgE7GnNT2G
         B00HLKwjVvBD+EkdxAWwJvqnQ5jjUKzmwoli/GbzqEawmGM06JHbkDZDh1TCgZqi9mQz
         Ng2x9L4ISw6BbYtLLlCTqxQ6ZDuaCuyI6ae4Odrfkyz0evqwzmE9LW2MyPhxNlyPNmBU
         1R2sHYL9551/RTgrpoFmHE1Eq250UWfgRjIW4v7+ep4vOkwQC7ZrhmipG2wB3Lp6BFXW
         brxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774308475; x=1774913275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ooi+h3bcAW5zP8MJCZDzVnX7Ev9079/RsplLPW5OVU=;
        b=Cvrm1E2UNC8uziIfDef7SQSnjKCm01K6oKsD5iTqnqx76Jqq7f/148Y0CCKoOT31bY
         93n1TjwLr7+YuTe0HqSAZjCoUU6COc7PRetzikXGn52YxMGbLWpKLZ0poWdCHsXAWdCc
         IoN88RmCBReD+pyKGTlkgvNknFiB7oSb/TGP6/BAyFfB0yx/CbmrA41tM8KMixxza5Pl
         FAnuFb2uUtAaTlx4+FDaByO/vVYz4sEHiL9u8KsEMxcaFGUkYNyaaMZXRfJIsunb00L+
         n/OJUrWrDpiT7cjOkZpHHwrDXloBZwKK3JIhUTwwd4BQpjyMtxbxffplu9isf3QwiDHb
         Rt1w==
X-Forwarded-Encrypted: i=1; AJvYcCXdrHt3S8vr18KLKfnzkVLcUdET9bYq+LPVpjPDXA+QQX184Q0wcXvPZrJoiYiU4jIHFONKJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpZj329dOkgcZL/SrDL5eSm5FvMCI/DeKKz75TWhFXuYEErTK2
	uVDJ1qTZg/hViyDtkxle3477R32W6CnPxEnwCa9WmNN0KlvRgNvbqAZZJ/s4NOIolg==
X-Gm-Gg: ATEYQzwQfqYcdemwpeAQXJ3P/+k5uvBtLd2RDNdLlAK6QU5+9bzcl5W2or3bIUxTh+A
	9RKosv3T6EobSbRcSZnCNtmeGDQIw4vYzYMU50YCeY2AlIkMdw0YADno16uiepNwJtRdaeD1zLa
	eCC8V885mqcAr4bO6LSArdjieuGQww7k04Xy+p800excxmoasnwL3NYKqa7jG6bSK/kgrw5dxdF
	c1NLqi0Z8qe9YXxteyaVDBZPdi25KIqDNkVhJeXYPYAmKV5dW+MhmY+5oKCrdmKjGVIBTWxq2Sh
	kNGdXa2Xk3RApWvINr7CTXX+pc9su2T4Jb3mwwW8c3nzxBo8WggQ+U2lmyDY6FNqXdVEs45CYMT
	PyIuy9nUzZax5rD4krm8B7znPV0+vhXGpYT3PbnNtoTG1keO1g6tJ7nUX8Y4esNBrBhH7cxNhcj
	J9rWYNU6o+zaKv2+sR4No4G2h0S3SvLKVjcbkl1Va8Dng5kG0C8jJyOWAeoQ==
X-Received: by 2002:a17:902:da89:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2b0a5404e00mr1421495ad.4.1774308473977;
        Mon, 23 Mar 2026 16:27:53 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516cb9sm125384965ad.2.2026.03.23.16.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 16:27:53 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:27:48 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <20260323223639.GD2571566.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
 <20260316165018.GA1768676.vipinsh@google.com>
 <abidn8EGmi88wpCr@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abidn8EGmi88wpCr@google.com>

On Tue, Mar 17, 2026 at 01:06:34AM +0000, Samiullah Khawaja wrote:
> On Mon, Mar 16, 2026 at 03:54:50PM -0700, Vipin Sharma wrote:
> > On Tue, Feb 03, 2026 at 10:09:35PM +0000, Samiullah Khawaja wrote:
> > > +config IOMMU_LIVEUPDATE
> > > +	bool "IOMMU live update state preservation support"
> > > +	depends on LIVEUPDATE && IOMMUFD
> > > +	help
> > > +	  Enable support for preserving IOMMU state across a kexec live update.
> > > +
> > > +	  This allows devices managed by iommufd to maintain their DMA mappings
> > > +	  during kexec base kernel update.
> > > +
> > > +	  If unsure, say N.
> > > +
> > 
> > Do we need a separate config? Can't we just use CONFIG_LIVEUPDATE?
> 
> We have a separate CONFIG here so that the phase 1/2 split for iommu
> preservation doesn't break the vfio preservation. See following
> discussion in the RFCv2:
> 
> https://lore.kernel.org/all/aYEpHBYxlQxhXrwl@google.com/

Sounds good. 

> > > +static void iommu_liveupdate_free_objs(u64 next, bool incoming)
> > > +{
> > > +	struct iommu_objs_ser *objs;
> > > +
> > > +	while (next) {
> > > +		objs = __va(next);
> > > +		next = objs->next_objs;
> > > +
> > > +		if (!incoming)
> > > +			kho_unpreserve_free(objs);
> > > +		else
> > > +			folio_put(virt_to_folio(objs));
> > > +	}
> > > +}
> > 
> > Instead of passing boolean, and calling with different arguments, I
> > think it will be simpler to just have two functions
> > 
> > - iommu_liveupdate_unpreserve()
> > - iommu_liveupdate_folio_put()
> 
> This is a helper function to free the serialized state without
> duplicating multiple checks for various type of state (iommu,
> iommu_domain and devices).
> 
> Do you think maybe I should add these two functions and make it call the
> helper?

Read the next response.

> > 
> > > +
> > > +static void iommu_liveupdate_flb_free(struct iommu_lu_flb_obj *obj)
> > > +{
> > > +	if (obj->iommu_domains)
> > > +		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, false);
> > > +
> > > +	if (obj->devices)
> > > +		iommu_liveupdate_free_objs(obj->ser->devices_phys, false);
> > > +
> > > +	if (obj->iommus)
> > > +		iommu_liveupdate_free_objs(obj->ser->iommus_phys, false);
> > > +
> > > +	kho_unpreserve_free(obj->ser);
> > > +	kfree(obj);
> > > +}
> > > +
> > > +static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
> > > +{
> > > +	struct iommu_lu_flb_obj *obj;
> > > +	struct iommu_lu_flb_ser *ser;
> > > +	void *mem;
> > > +
> > > +	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
> > > +	if (!obj)
> > > +		return -ENOMEM;
> > > +
> > > +	mutex_init(&obj->lock);
> > > +	mem = kho_alloc_preserve(sizeof(*ser));
> > > +	if (IS_ERR(mem))
> > > +		goto err_free;
> > > +
> > > +	ser = mem;
> > > +	obj->ser = ser;
> > > +
> > > +	mem = kho_alloc_preserve(PAGE_SIZE);
> > > +	if (IS_ERR(mem))
> > > +		goto err_free;
> > > +
> > > +	obj->iommu_domains = mem;
> > > +	ser->iommu_domains_phys = virt_to_phys(obj->iommu_domains);
> > > +
> > > +	mem = kho_alloc_preserve(PAGE_SIZE);
> > > +	if (IS_ERR(mem))
> > > +		goto err_free;
> > > +
> > > +	obj->devices = mem;
> > > +	ser->devices_phys = virt_to_phys(obj->devices);
> > > +
> > > +	mem = kho_alloc_preserve(PAGE_SIZE);
> > > +	if (IS_ERR(mem))
> > > +		goto err_free;
> > > +
> > > +	obj->iommus = mem;
> > > +	ser->iommus_phys = virt_to_phys(obj->iommus);
> > > +
> > > +	argp->obj = obj;
> > > +	argp->data = virt_to_phys(ser);
> > > +	return 0;
> > > +
> > > +err_free:
> > > +	iommu_liveupdate_flb_free(obj);
> > 
> > Generally, I have seen in the function goto will call corresponding
> > error tags, and free corresponding allocations and all the one which
> > happend before. It is easier to read code that way. I know you are
> > combining the free call from iommu_liveupdate_flb_unpreserve() also.
> > IMHO, code readability will be better this way.
> 
> I had that originally when I was writing this function, but it gets
> really cluttered :(. Instead it is more clean without code duplication
> using this one cleanup function here to free the state on error and also
> when doing unpreserve. Please consider this a "destroy" function of obj
> and it can be called from 2 places,
> 
> - Error during allocation of internal state.
> - During unpreserve.

It is removing code duplication in

 - iommu_liveupdate_flb_preserve()
 - iommu_liveupdate_flb_unpreserve()

However, there is still duplicate code in iommu_liveupdate_flb_finish().
Another thing is iommu_liveupdate_free_objs() is doing two different
things based on current liveupdate state (before or after kexec) passed by a
bool argument. IMO, it is cleaner if we explicitly write whether we are
doing unpreserve or just folio put.

I meant something like:

static void iommu_liveupdate_unpreserve_free(u64 next)
{
       while (next) {
               struct iommu_objs_ser *objs = __va(next);
               next = objs->next_objs;
               kho_unpreserve_free(objs);
       }
}

static void iommu_liveupdate_folio_put(u64 next)
{
       while (next) {
               struct iommu_objs_ser *objs = __va(next);
               next = objs->next_objs;
               folio_put(virt_to_folio(objs));
       }
}

static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
{

...

err_free_devices:
	iommu_liveupdate_unpreserve_free(obj->ser->devices_phys);
err_free_iommu_domains:
	iommu_liveupdate_unpreserve_free(obj->ser->iommu_domains_phys);
err_free_ser:
	kho_unpreserve_free(obj->ser);
err_free_obj:
	kfree(obj);
	return PTR_ERR(mem);
}

static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
{
	struct iommu_lu_flb_obj *obj = argp->obj;

	iommu_liveupdate_unpreserve_free(obj->ser->iommus_phys);
	iommu_liveupdate_unpreserve_free(obj->ser->devices_phys);
	iommu_liveupdate_unpreserve_free(obj->ser->iommu_domains_phys);
	kho_unpreserve_free(obj->ser);
	kfree(obj);
	argp->obj = NULL;
}

static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
{
	struct iommu_lu_flb_obj *obj = argp->obj;

	iommu_liveupdate_folio_put(obj->ser->iommus_phys);
	iommu_liveupdate_folio_put(obj->ser->devices_phys);
	iommu_liveupdate_folio_put(obj->ser->iommu_domains_phys);
	folio_put(virt_to_folio(obj->ser));
	kfree(obj);
	argp->obj = NULL
}

This way code is pretty explicit and clear what is happening. Let me
know if you meant something else by cluttered code.
> > 
> > > +	return PTR_ERR(mem);
> > > +}
> > > +
> > > +static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
> > > +{
> > > +	iommu_liveupdate_flb_free(argp->obj);
> > > +}
> > > +
> > > +static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
> > > +{
> > > +	struct iommu_lu_flb_obj *obj = argp->obj;
> > > +
> > > +	if (obj->iommu_domains)
> > > +		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, true);
> > 
> > Can there be the case where obj->iommu_domains is NULL but
> > obj->ser->iommu_domains_phys is not? If that is not possible, I will
> > just simplify the patch and unconditionally call
> > iommu_liveupdate_free_objs()?
> 
> Are you suggesting that on flb_finish() the obj->iommu_domains should be
> non-NULL as flb_retrieve() succeeded? If yes, then that is correct. I
> will update this to call the free_objs() without checking
> obj->iommu_domains. I will do same for other types.

Yes. 

