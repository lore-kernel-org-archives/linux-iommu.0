Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9052DE715
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075943; cv=none; b=JVbMHXnyqUCnA7BQiJ9Lgw/nuqKJiOSuGIwlvIA0PLWjdA+at3HdEdCNlVFjzvpNUDsmzN9oRuYeOSdoie61mLe0NwhlRn33LDKqFZ/ueUhVDolZYnAlfWyevmMlItXfP7K5CUhsoIR8XtPe6KlZf5aQKCwzHvjvLSjeeYNWTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075943; c=relaxed/simple;
	bh=NYIQ8k0J36Z+pqu7eLVLT+nA4jM07QuVSOcSQOhWSw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWwmYqz/hWs1ip2DQazvgg6r1pgAF7XbwAO8WcaxvsfJzi0+G6LjvEB/6aEzE20QZiVP3T2WYJ3wfzeE7rkm9xwbf98gusGRAkpKUEefmxjYeJl+q2fwk+sb8hJT/N7lpGvK4pcyNpU1JSY/ogGisaqii2ZDvzBVVVjNDAnUsWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j5PaAb0T; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j5PaAb0T"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89473f15ed8so45327986d6.2
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 15:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770075941; x=1770680741; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p2Lhp0szvkgF9ZK/gTcTHYbmH9trOSyqBk9Fq52/yQY=;
        b=j5PaAb0T9EYnE2xYgilF7lQcieWgBouwKftgFDw5I42iqmxxHPoUU2UgaXdifHr9oX
         JWxsyYbcF96MTj0yABJAKC+Nf44fn8dW755rQoPV7DvnmepSfj7829xj6P1hkMFerUwg
         ym1pCpipcNnFyenKKK7XYvVo01r1x6auKPSx+D7MdhBn5cfiUKqXk9I1JSwpeYTVGfmj
         ZmkcooLAqNq2/t0FgwTQEMlxJU/lb+IlYp/QCPfxRjpsE7JcKMOq/l+E+SXnRu000Ji3
         78qhpVjsJYnhbf0t/n1idENKELHgTgAX6Wvz6Ch5q8cY+5x5dxsd5YjxsnbIM4I9gHEh
         iKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770075941; x=1770680741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Lhp0szvkgF9ZK/gTcTHYbmH9trOSyqBk9Fq52/yQY=;
        b=VZA7jow40Mukie6P0XY/SSDDPYgDY2Aln33fbPP/RvVendroNK9yKdOvpGe3OU4DnX
         j1BUWQnbmA4yAkrOMnaWIj6ZMtddM5Om6fjWVQUT0GqU5+zoxpRxOKbSt4HDGlyLp31B
         MSftso0z3qN9jUPSWrzQbj3b/pHtXWeIGxLj8rfMoEkWmyaaQL2odlunemSAyxqsXxxK
         rqd3pVGmc5F/U0PZSnjKlNB+9et/igwdg+AnzNgmcAT4BolJ3NJBpT6g8PGbNYgOZzON
         RnfvZzSZMI3w/JqmQQEQlBrtFuqtFNB34AXa/VYAUix0PWYFfqJxnohVWC+mSdEg2ogh
         WRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi7OntTbkvNvFEp1HMJ+25tGKH6uCfStpyvCkVW+J/RhBNLuxzBtq+us2gnVHYMML8MpqC4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyshk3PCKMw5QFPXSZWg1QlEtTzatKJKbahNx+YCrSVw2wv8UEb
	wJP0ASYSSOcGTnPB0M4V1S9pLluC6IDUae0eTEqumYRVUiN5HAdjQMgCntmSbrnys5g=
X-Gm-Gg: AZuq6aKKMYjw/cCEeBdExNlXI2hkHV34V6I2tLh16cmLVNvP82RK9Tzo18StE2Zs9ls
	abgAesztpibi1cfmTL00Iv8tXSh9InFOtK3xPQXrfyuEpj/O/4w4yrRU1FlHzYctOPizjD6yyDa
	+z+f/SNNtq2dwRIsRVYf1AFkWQhInYpd2zJPQiX1KLIE6UWBjivKxVIsHwTObkXrIMsQilDM7OF
	bMIcRtxvf3d0JKcmDVS0JGr15W91lDfEBnneDjGE5OjjATCQK2BgXQFkQSwbgHadxCFDfRAufaB
	gdQ63cOBd6K60ENR+BSm3poTjAEBuJdgLKsvRGCgmo9Yi6GVzDpX84iEkqw2FM5BA/iZ0vQ00zv
	bbsILwmnuzbGyJVjW8M1T8i9/KwkdlRWO1ZynwTFWA6rD3bdODXKCxqQ6HSG6wQdFVRCe4s7447
	RWsauNsSZRjAsTbdwxqNAiYZ6tW5Hcs1pZ0cmTBecc7GQmYgRhTwUgsbZZV7wDoDCR7+8=
X-Received: by 2002:a05:6214:1244:b0:87c:2967:fd32 with SMTP id 6a1803df08f44-894e9f86526mr176075016d6.22.1770075940655;
        Mon, 02 Feb 2026 15:45:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c448esm124994316d6.14.2026.02.02.15.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 15:45:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vn3bv-0000000GNrK-37Et;
	Mon, 02 Feb 2026 19:45:39 -0400
Date: Mon, 2 Feb 2026 19:45:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Matlack <dmatlack@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH v2 00/32] Add live update state preservation
Message-ID: <20260202234539.GN2328995@ziepe.ca>
References: <20251202230303.1017519-1-skhawaja@google.com>
 <20260128195943.GY1641016@ziepe.ca>
 <CAAywjhRXwRD7rmZ2DjN2roDMvWCV2772KhM2hox5RE8Prt4nxw@mail.gmail.com>
 <aYEpHBYxlQxhXrwl@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYEpHBYxlQxhXrwl@google.com>

On Mon, Feb 02, 2026 at 10:45:48PM +0000, David Matlack wrote:
> On 2026-01-28 05:11 PM, Samiullah Khawaja wrote:
> > On Wed, Jan 28, 2026 at 11:59 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Tue, Dec 02, 2025 at 11:02:30PM +0000, Samiullah Khawaja wrote:
> 
> > > Start off by just making the successor kernel fail to accept any
> > > drivers at all because the iommu_domain was preserved. ie restore the
> > > domain and set it as the default_domain and then fail in
> > > iommu_device_use_default_domain() and related functions.
> > 
> > Right. In this model, the device would remain unusable after
> > liveupdate as you cannot do session finish. So the only way to recover
> > would be to do a proper reboot. But I think this is a great
> > intermediate step.
> 
> This will break the new selftest vfio_pci_liveupdate_kexec_test that is
> added in the vfio cdev series:
> 
>   https://lore.kernel.org/kvm/20260129212510.967611-19-dmatlack@google.com/
>   https://lore.kernel.org/kvm/20260129212510.967611-23-dmatlack@google.com/
> 
> And having to reboot a machine back to life after every Live Update will
> be a painful for everyone working on VFIO, PCI, and IOMMU Live Update
> support.

I expect it to be under a config protection and people will simply
turn it off.

Jason
