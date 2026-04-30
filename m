Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606E3A6B6B
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581758; cv=none; b=OSy2p/aSXmXT3LaFPNbtCO3MtEtcLBjrq/iknwyGnKu5tANNd8t/USfgWwZFFovAvAZgjPHq4SIKf0bpFAcqqtsUTfunle+9lxSQhuX5fgbpiAyfmkTW2miT4rRWE0tT9K05p8GxO0WM3O0fCNHyDkH11DzGwbkqBCADwNu2trY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581758; c=relaxed/simple;
	bh=4FBRaYnJRq/un4FnbGeS++Q533k2ady0orYZ5cPNJho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqqTaHbRjR0p9hWWc1bfl9pk3K15GNvjzPrTEJHkko6wvvc1YLAhLYks/KVDVoauNPQd1pE+XwYKC/pQKXnQA49f6e+0YeiMp0T52NmG9KVaih0QNqApee4dFMvqZcfsDHdwZkKVZ9DTBYK0HBGYR1ajW2FKGQCJIvzjtUPvvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QaEjCGGg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QaEjCGGg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso9875ad.1
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777581756; x=1778186556; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3vbJaL0qvtGk1NC0ztOfHKQqU3avaZZm4uoH47YILVE=;
        b=QaEjCGGgYdzyuMGCI0fZkMEJcU3gfJEGTgnHRa7f9en1MD0TQEoqhUH64CrQzAh+BJ
         G1OQmgonHYQBS2HL0KMpoaxDVMBEkrdMvhC8bWxew4LLH5HtjttgeO//3oKjUG/dIyK0
         Ju3M9MmOJlnQFNMoVPJNPmzURFXt72Z4fkV2+XaGsvkVDFqN3P3ez5w53RHhYyf14UPR
         LqPB2N+T3X+y2HPkYVkSrNII7Hhr4/YCgRLkHY7phZ9zeAsfPavJa4iePF0ZK6L+tdrJ
         e8f2x9PY4Au50hzdXLmhZn2TSwnWK3yF6BpnLj/YQjQzrexbnBUreiP+nYJZ28fNwIys
         aY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581756; x=1778186556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vbJaL0qvtGk1NC0ztOfHKQqU3avaZZm4uoH47YILVE=;
        b=Uiz2zh9gY7WXJcSBgvZQe6JZXLCH5m4de207QShmLCaTeYHuzf8bcFGVWx6INpEWLY
         K+KbAvoXPXIh6gQ9AtLxaT8yreiFXvHJ8Oh2dxoCDkRceo0FJ7xEL4f2mUtlM+RlnTTQ
         lZWmT0Kpvx7oWxHUB+l/gCk0xp3rYUsqW+MiK7WBL9MB1sRAP7dMPJPej3lRM6dICauf
         c9Y8mbllS1n94mgl0wJk/X4Raudhpw/EiYc6mmLknepVxSTT9XltqcD6HWZdC8sW3t7b
         ZHwl1JYanajDwGdNStpLITAgZT4GT0XmIxjV0o3Cf8aIb4+yOAm22gOHOP4JhDsuun4/
         yd4w==
X-Gm-Message-State: AOJu0Yypyphu0CDZBGLa+btCgWuPXFKmx+d4Z91fsVmfUAjWYWr9mI2R
	DzCmI9UhrbpakRfC4ghliUy4XAl0Zn64ulsV6vyMbgospc5z3O6FDQoeX+TYRE72iQ==
X-Gm-Gg: AeBDiet8aNqV6tFzVbywlnyyqhu+wStaM0lTKm7jwhpUbAMPvRzHhVidKSI67ZqH3mW
	DwsNOKKR5oD+q1pLzWNq8cfgjpxSLqPBn8CXfnGVEfHPhMOIgbm91a+RV0EzSkYuqNDMhQSZl9c
	OQYvnVosA0ac1/jJGjkLLn0OJzz/HUyu3Z7G8lCK+Cx7LjSA+jh7YbT38rb4AkRFLM5civyEZVa
	5bXwHIcZpDkAZIOJM5tJh6NcAYqwd9Xbj4KQrQAvw5OlLllzRy5XyKItmybgCNSvfKwj+Bx7PMm
	P6PfGWVkGkmu9OUr5nBqJbQ8nGzjE8nhUO6Utdn5uWXRedvVdXziHxfieBIXX9CGHXvSAubK5uy
	oOlBhhRbAnKWZ1Ac/mQDG4xzIFe+F4kiOOFL7DmAkudK4axdljDLrzIXGRP5W1PHxXmGwIRJzyD
	+KQk5w2Tr1p58flj4f3aEqpXA62LVEGS6g+8oC63YRPN7R1w4XOq/xxw4U96xKBELv4b+R9rBld
	J1F/Dpvrw==
X-Received: by 2002:a17:902:efd3:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2b9cde4ae98mr575255ad.20.1777581755636;
        Thu, 30 Apr 2026 13:42:35 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae55612sm4897165ad.73.2026.04.30.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:42:35 -0700 (PDT)
Date: Thu, 30 Apr 2026 13:42:31 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260430204009.GB22297.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
 <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
 <20260430175916.GA13902.vipinsh@google.com>
 <afO9VOckgyiiokw8@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afO9VOckgyiiokw8@google.com>

On Thu, Apr 30, 2026 at 08:36:36PM +0000, David Matlack wrote:
> On 2026-04-30 11:25 AM, Vipin Sharma wrote:
> > On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> > > On Tue, Apr 28, 2026 at 1:20 PM Vipin Sharma <vipinsh@google.com> wrote:
> > > >
> > > > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > > > +{
> 
> > > > > +     if (ser->nr_devices == ser->max_nr_devices)
> > > > > +             return -ENOSPC;
> > > > > +
> > > > > +     for (i = 0; i < ser->max_nr_devices; i++) {
> > > > > +             /*
> > > > > +              * Start searching at index ser->nr_devices. This should result
> > > > > +              * in a constant time search under expected conditions (devices
> > > > > +              * are not getting unpreserved).
> > > > > +              */
> > > > > +             int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > > > > +             struct pci_dev_ser *dev_ser = &ser->devices[index];
> > > > > +
> > > > > +             if (dev_ser->refcount)
> > > > > +                     continue;
> > > > > +
> > > > > +             pci_info(dev, "Device will be preserved across next Live Update\n");
> > > > > +             ser->nr_devices++;
> > > > > +
> > > > > +             dev_ser->domain = pci_domain_nr(dev->bus);
> > > > > +             dev_ser->bdf = pci_dev_id(dev);
> > > > > +             dev_ser->refcount = 1;
> > > > > +
> > > > > +             dev->liveupdate_outgoing = dev_ser;
> > > > > +             return 0;
> > > > > +     }
> > > > > +
> > > > > +     return -ENOSPC;
> > > >
> > > > Since it is executing under a mutex, and we already failed
> > > > 'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
> > > > here and return -ENOSPC?
> > > 
> > > Yeah I wouldn't expect to ever reach here.
> > 
> > Will you be removing it or want to keep it just in case scenario?
> 
> I'm not sure how I would remove it. The code doesn't not compile without
> a return.

Oh, I meant, inside loop a break and outside just return 0, that way it
won't be a dead code.
