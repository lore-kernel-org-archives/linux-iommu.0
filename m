Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE221BDEE
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676401; cv=none; b=sKbTm4m/bjLR7tQG1CDZ0P5U6gNOTUbzhAieiC9QqOvyAXEEIca4Eh5oz1ZBwXOUxTFU7i2w2x7mhKaD9gQybluwsmx41mA0w7LGgGuS6IISaIEJO2RJmnVQnA89aYCAnfthYuwGGryA1JvOSU86GbKNaUN7wRYWTM+uewvE6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676401; c=relaxed/simple;
	bh=TUNny1HvUeftZKLUoDkacQhlF4J6gUc6wrtk141dWvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khKLc+gH+99GvON0vvH2ztaEfRCIDtGMHgX5K6R3yrCINgc0BHt/S5sSCqD34pPkcOxVIHxlOBca5awE60/5GlEqkXQL1Yv0p9YHjsF+yZ9NVhk7Kl+u0P6/zb/aqgJlo49e6wIuQTP9lgTrt3+xZCDXIQ8tv8BlMOBMzV1UQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pezUnT/t; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pezUnT/t"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d09cf00214so8849231fa.0
        for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 00:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708676397; x=1709281197; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuXtCNYwsGpKXgRbUJ3unXSyq/4b1iF/r5Hh+ijkmfI=;
        b=pezUnT/t/Mf8JJaZXQcRjaCAj8SJ9J7Q7kqUygykF6gSnfAo7kDG0+jLCyHiR6aslC
         WYAyvL6CtokCysBhVGRRFat6TnehOpRpS1x1qnqJt3IbOZ93t7vFYBHOwoWLV5zGWKni
         eopnCxPga8VtmvNZet4UIadszVOl+bBgpYgGmU4dxiGikQlXaDtc1JmZ1ptlXgAwCbfU
         7WA6L2ewRuH5ZhiZaukfujMRueTHnz1QSYBUpgUbsMw6UZBmk8LQNoJ3HS2bxUOcnpIn
         i40F7z9lak7hD/8mRi0QI9HvNn6MblRL8cLEA7E0chYbY10OCX+MHYTYDJ/UfpIefYL5
         HIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676397; x=1709281197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuXtCNYwsGpKXgRbUJ3unXSyq/4b1iF/r5Hh+ijkmfI=;
        b=hwmiQrltPoIrTboLQ2VC4dmGU/tUzpnXnbfw3ZIRttA6RFotLGCX/3LDcYAmgR2Co9
         2/kaCn6WHCjpgcT2wosiM/fvINvkHRqaPv7DRxttITihsWqy7DHK8rTmHB6xLYP27YJF
         VQyq3o64jayPX2DbRcPpq53gsSjKfW5Chwmd0WuCBDqg5G9fKuhb2ZRiUvnixK3pFV7k
         t8T9/uLlSaPdI8D9n19B30jZrjIDbo78iT8C0Bjx/fEOYIFEI6eZhISRhH6/KRFpnT4r
         4Zb5+R7kozQ3wriy+JnhzBInZyLG8Li10PB3WDv0z7A/Uz+nqDazT81YJU7I/YBEH5Ty
         YN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPRqQFQVNfPqtAKqIZyq640W1G15Vg44kA3z0u3FGq+lUmVIyq7dtOsMXmyvrDNqlusr3Gpe19pBKMMILVgmWWJc6GRB4=
X-Gm-Message-State: AOJu0Yy5Hn21DN8WwerMjBUkR9RGAllh/+voVR46y0+nZlKGNpu5WyO7
	Pu896vs62ETU8E87rlqgXvKD0uEQr7mtGGhT1+UYxhunv8fE09svTa0zTRUSsUE=
X-Google-Smtp-Source: AGHT+IG3BQ8JqlqrAtOJFM04gbsnYyOURpj+vfRT2z52l3Z/d44ORUjRCHQO4AUweAm1jwyo0GRCjA==
X-Received: by 2002:a05:651c:1061:b0:2d2:313c:3c0 with SMTP id y1-20020a05651c106100b002d2313c03c0mr738681ljm.27.1708676396701;
        Fri, 23 Feb 2024 00:19:56 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d50d0000000b0033d449f5f65sm1890058wrt.4.2024.02.23.00.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:19:56 -0800 (PST)
Date: Fri, 23 Feb 2024 11:19:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org,
	will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target
 device isn't valid
Message-ID: <f779be97-66c2-4520-91f2-a9a54e84017c@moroto.mountain>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>
 <c655cd15-c883-483b-b698-b1b7ae360388@moroto.mountain>
 <2d1788da-521c-4531-a159-81d2fb801d6c@linux.intel.com>
 <039a19e5-d1ff-47ae-aa35-3347c08acc13@moroto.mountain>
 <31ee6660-ad4a-40b8-8503-ebc3ed06dd16@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ee6660-ad4a-40b8-8503-ebc3ed06dd16@linux.intel.com>

On Fri, Feb 23, 2024 at 03:32:52PM +0800, Ethan Zhao wrote:
> On 2/23/2024 2:08 PM, Dan Carpenter wrote:
> > On Fri, Feb 23, 2024 at 10:29:28AM +0800, Ethan Zhao wrote:
> > > > > @@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
> > > > >    			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
> > > > >    		} while (head != tail);
> > > > > +		/*
> > > > > +		 * If got ITE, we need to check if the sid of ITE is one of the
> > > > > +		 * current valid ATS invalidation target devices, if no, or the
> > > > > +		 * target device isn't presnet, don't try this request anymore.
> > > > > +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
> > > > > +		 */
> > > > This comment is kind of confusing.
> > > Really confusing ? this is typo there, resnet-> "present"
> > > 
> > Reading this comment again, the part about zero ite_sid values is
> > actually useful, but what does "old" mean in "old VT-d device".  How old
> > is it?  One year old?
> 
> I recite the description from Intel VT-d spec here
> 
> "A value of 0 in this field indicates that this is an older version of DMA
> remapping hardware which does not provide additional details about
> the Invalidation Time-out Error"
> 

This is good.  Put that in the comment.  Otherwise it's not clear.  I
assumed "old" meant released or something.


> At least, the Intel VT-d spec 4.0 released 2022 June says the same thing.
> as to how old, I didn't find docs older than that, really out of my radar.
> 
> > 
> > > > /*
> > > >    * If we have an ITE, then we need to check whether the sid of the ITE
> > > >    * is in the rbtree (meaning it is probed and not released), and that
> > > >    * the PCI device is present.
> > > >    */
> > > > 
> > > > My comment is slightly shorter but I think it has the necessary
> > > > information.
> > > > 
> > > > > +		if (ite_sid) {
> > > > > +			dev = device_rbtree_find(iommu, ite_sid);
> > > > > +			if (!dev || !dev_is_pci(dev))
> > > > > +				return -ETIMEDOUT;
> > > > -ETIMEDOUT is weird.  The callers don't care which error code we return.
> > > > Change this to -ENODEV or something
> > > -ETIMEDOUT means prior ATS invalidation request hit timeout fault, and the
> > > caller really cares about the returned value.
> > > 
> > I don't really care about the return value and if you say it should be
> > -ETIMEDOUT, then you're the expert.  However, I don't see anything in
> > linux-next which cares about the return values except -EAGAIN.
> > This function is only called from qi_submit_sync() which checks for
> > -EAGAIN.  Then I did a git grep.
> > 
> > $ git grep qi_submit_sync
> > drivers/iommu/intel/dmar.c:int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/iommu.h:int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
> > drivers/iommu/intel/iommu.h: * Options used in qi_submit_sync:
> > drivers/iommu/intel/irq_remapping.c:    return qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/pasid.c:    qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/svm.c:      qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
> > drivers/iommu/intel/svm.c:      qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/svm.c:              qi_submit_sync(iommu, &desc, 1, 0);
> > 
> > Only qi_flush_iec() in irq_remapping.c cares about the return.  Then I
> > traced those callers back and nothing cares about -ETIMEOUT.
> > 
> > Are you refering to patches that haven't ben merged yet?
> 
> Yes, patches under working, not the code running on your boxes.
> 
> -ETIMEOUT & -ENODEV, they both describe the error that is happenning, someone
> prefers -ETIMEOUT, they would like to know the request was timeout, and someone
> perfers -ENODEV, they know the target device is gone, ever existed.

Okay.  I obviously can't comment on patches that I haven't seen but,
sure, it sounds reasonable.

> 
> > > > > +			pdev = to_pci_dev(dev);
> > > > > +			if (!pci_device_is_present(pdev) &&
> > > > > +				ite_sid == pci_dev_id(pci_physfn(pdev)))
> > > > The && confused me, but then I realized that probably "ite_sid ==
> > > > pci_dev_id(pci_physfn(pdev))" is always true.  Can we delete that part?
> > > Here is the fault handling, just double confirm nothing else goes wrong --
> > > beyond the assumption.
> > > 
> > Basically for that to ever be != it would need some kind of memory
> > corruption?  I feel like in that situation, the more conservative thing
> > is to give up.  If the PCI device is not present then just give up.
> 
> memory corruption, buggy BIOS tables, faked request ...something out
> of imagination, after confirmed the device is what it claimed to be, if
> not present, then give up to retry the request.

This is not correct.  We looked up the device based on the ite_sid so
we know what the device id is, unless we experience catastrophic memory
corruption.

+                       dev = device_rbtree_find(iommu, ite_sid);
                                                        ^^^^^^^
We looked it up here.

+                       if (!dev || !dev_is_pci(dev))
+                               return -ETIMEDOUT;
+                       pdev = to_pci_dev(dev);
+                       if (!pci_device_is_present(pdev) &&
+                               ite_sid == pci_dev_id(pci_physfn(pdev)))
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unless the device_rbtree_find() is returning garbage then these things
must be true.

+                               return -ETIMEDOUT;

I tried to double check how we were storing devices into the rbtree,
but then I discovered that the device_rbtree_find() doesn't exist in
linux-next and this patch breaks the build.

This is very frustrating thing.  But let's say a buggy BIOS could mess
up the rbtree.  In that situation, we would still want to change the &&
to an ||.  If the divice is not present and^W or the rbtree is corrupted
then return an error.  But don't do this.  If the memory is corrupted we
are already screwed and there is no way the system can really recover
in any reasonable way.

regards,
dan carpenter

