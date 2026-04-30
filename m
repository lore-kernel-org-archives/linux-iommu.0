Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C332379982
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581403; cv=none; b=PFXSqvqFcKbC0BeJ32EgH3nb2jQ+Ky5poMkUh/Bn3H/uGBEqsRAo9BWw2VpmoXfhrlUy4Z2KsYgRjgIe8Atm5WrbuUQF9vGY8HlRleFZH3gQuS231et+cu3MmNU1+PkpoT/9+rOKloWrD6cgpc6w/B0cqXPCtE1FJhJgyoREfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581403; c=relaxed/simple;
	bh=EwPsMmwDlEf4Sg12GI+V/on0UHI6jKuUp1UpMdnjbrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TciNKX+l8ezrhSgbxurthtxM27DmfDH3ZRKBJbBerVevX0V2v4WftiyclHJEa2cC7xgRenfsaR6ebDQ/Tkl+PH71DZmh+m8NqdLVpX09ll5diAi5cGq5dWRyaxNcPuX9Xi+FywJ3GXnkDN0onpiJFE17t/wVaS0EHgNSzQbQp4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uA4rpg5Z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uA4rpg5Z"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b941cd869cso8630465ad.1
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777581402; x=1778186202; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7XgKHoPXsQn1bRJuoPg0uZx0GmeDlDmcffd2v4MAfo=;
        b=uA4rpg5Zk3wj4D0RZXyD9GYMNF/AOWPNE0eExmhU1VtceqPvhRipQhvX+scgRw13Yy
         jYQyNkCewtijEMiRZl2tyKGY3P6P3m087Y8X0PSpyOo+5ky+7j0jzFm40ixSLNTIK0bv
         llpyr3oGaLXEfBxwmbH/9D5AKKc+WHfe3OgO0sz3AsREw0ZS+ajVP/b0DeDUFUPzguXX
         bTVdZwJgPMHuoDv+PZwc5IiUUHtpSCgdBmK3ApjWfMJoQHhUWh5gMfurmGMnLUhEnzV7
         9RNYYhswSNy2226dlGqC+I4ymAofJaXCwRNLE8Ffn1xEDvzyR749lM0+hjbTUFOlaH/k
         fZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581402; x=1778186202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7XgKHoPXsQn1bRJuoPg0uZx0GmeDlDmcffd2v4MAfo=;
        b=A/ml2blpos4Ij5F1kdZzo3KHKcFdclZbzrcFRC6IEXmjHF2ImOuWOrv7nzmxlY5QQh
         y06SQrzoW6zJfuumgd7QExcy4myGCAyGpVe6d/j5IHaQ6QoFW/hlMjJI4xjdY6FjRrR4
         hEx9uSFSfVXFk3eGwKE4bmCdTnK2Kcr/25mf6FLnzC2Z2u/Ku/hCT+giqQw4+kwjcEd8
         axq8GA9i3yyVFTnA8elgruaPBYvqvC3TSWM6AwTkw17crzajkJjqwM5KRC1hrHD/J/Wb
         nnFeQijBOBTrclYNU/d28Nq7CgwO5US1rlKmugm2CHE18wqym+QwbXro527q9LRFmbtO
         +1NA==
X-Gm-Message-State: AOJu0Yyx8h/WW0RPazBvSRE6LPPwzplrZz23G51H+f7HFqi38xCLRzmE
	cLAgXizw3+fTEZrQwEve7bIAK08s0mjKAlKO1+VhBnhGoLWPqVhkf21ZAatMWFnnvQ==
X-Gm-Gg: AeBDievi+qQPy1Grc4AfWECGVVzr7EU6eaVbk/yT+tnAm7rHpwOw/i+FFTioCFuXlDr
	NL7yobtvKBXheJSymarMSr7mco1tKG/BjjQadFPHUgQldl/0d8nhoKnU34tezyXYMASXmyJY+yM
	SqI8dAml1+Rxwr8a7KqFDnVICxHVxFUn6bLAkyTQ/tLpUlrOUuNA3Z6ETFSE1AutNFQ5+MEObL1
	u5y+W8joe0TmxSnVFN1EX6ucus1GvJhod+sdPysT3HL7PlVVslKbYTQE795bBjNDRDGwdNSRcdi
	Hk9kHMXzBcIHMU9zrBG6FfKKUbHIWM955JXI6U4Jz2bypow0aLdWn1Rt64CeYyiy60QJregFDzW
	F++n2hbbj1n1NZedmb9gaUxZQ2Ifvn2tEer1oue2UEk/L8mRWeC1n+l8HjcekTw7bMmGb9VFXfD
	OQS6P6Q4JQ/mKDfJdnpV9Xvmq7mt7dxDqXWcCvvwJ9Tc8MRpS0376JodqWtnFqR5FDI7ksNlwmy
	9lJkA==
X-Received: by 2002:a17:902:bcc4:b0:2b2:490c:410e with SMTP id d9443c01a7336-2b9a23195femr34674875ad.7.1777581401489;
        Thu, 30 Apr 2026 13:36:41 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae4a127sm5909845ad.67.2026.04.30.13.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:36:40 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:36:36 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
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
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afO9VOckgyiiokw8@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
 <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
 <20260430175916.GA13902.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430175916.GA13902.vipinsh@google.com>

On 2026-04-30 11:25 AM, Vipin Sharma wrote:
> On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> > On Tue, Apr 28, 2026 at 1:20 PM Vipin Sharma <vipinsh@google.com> wrote:
> > >
> > > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > > +{

> > > > +     if (ser->nr_devices == ser->max_nr_devices)
> > > > +             return -ENOSPC;
> > > > +
> > > > +     for (i = 0; i < ser->max_nr_devices; i++) {
> > > > +             /*
> > > > +              * Start searching at index ser->nr_devices. This should result
> > > > +              * in a constant time search under expected conditions (devices
> > > > +              * are not getting unpreserved).
> > > > +              */
> > > > +             int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > > > +             struct pci_dev_ser *dev_ser = &ser->devices[index];
> > > > +
> > > > +             if (dev_ser->refcount)
> > > > +                     continue;
> > > > +
> > > > +             pci_info(dev, "Device will be preserved across next Live Update\n");
> > > > +             ser->nr_devices++;
> > > > +
> > > > +             dev_ser->domain = pci_domain_nr(dev->bus);
> > > > +             dev_ser->bdf = pci_dev_id(dev);
> > > > +             dev_ser->refcount = 1;
> > > > +
> > > > +             dev->liveupdate_outgoing = dev_ser;
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     return -ENOSPC;
> > >
> > > Since it is executing under a mutex, and we already failed
> > > 'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
> > > here and return -ENOSPC?
> > 
> > Yeah I wouldn't expect to ever reach here.
> 
> Will you be removing it or want to keep it just in case scenario?

I'm not sure how I would remove it. The code doesn't not compile without
a return.
