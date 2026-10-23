Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782053;
	b=viHavGEN6Q4lmBEarhLX4tMg12+XcmmphKvNE2vlXRp4EF9emuERdowp1nX3zlpXb/9x
	 dVqaAfLXq6iJy/VG1uFbD0rmJURZBH8Spkjb3mKhiM3tA8JKxz1vhec02AZTpYNKCIz88
	 NIlk73yb+mRHx0mgpFluoa/CZsnANxkgLqGaGmqW8rzpVitPuCEW37/cSXXVIhYfoltzk
	 1/CG5VHvQEhW0Fm1SZ8V+LnmCG5yQYWUQT8qfY2U1zBbWmrK2fcjti3nmOQsiw/53G+KI
	 JXZgzxUqaR/Yg2/yVpV6II8Dj+OYuACJYHolHdySVBe1febARupXV1jl7dHrRCNPB4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
	b=pPKHPtOQ3ZgnMliKGdfyJjtkMyu9UL+EH5IZLyn5DYcf3/abOqDCyZ/tcTHzGFUbU6a3
	 UwDswHa1Vv7yFyljdPlHkGgVcv/1NNpF5tx/vxLuq+SyC57ZNe0CMdc0fNW2mgNRI7vwE
	 b+DVpzmkqtXICUkwB/as/aWqTED9UTUY9KLmMwkjMpteGVJuuvoNoiy0pZAwsVAIpcCjb
	 9t+v61WNSuZcyEVRW8Fl+UNGJAJMvDjcyBItI+b2Nq5EnMDmTkSx/CKq+IEW1JDdLRLaY
	 DdnWXffYXWk9S/PcsEZ9LGx5rbOazx+GdOYAczyEqDDBZKtOpjhalVMCfhk5as/3SRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pTkv9Tl4;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CAA606A323
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 19:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6CAA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pTkv9Tl4
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53669f7b518so11399681cf.2
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792782039; x=1793386839; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
        b=pTkv9Tl46YZ+UP0pia8RZc57y6f3o/VPJ9zCwTCzz46JczbEFgupN9ZHWbSkElpYAo
         sAQkVMzUxqO5dtvbRxer7j9XWDejzVAPRBGZEb04u2gSA5Cl39sX+X6zZl7j6Z9Ku7Fg
         DXxmp5P7KE8J7703QoSaN6KNYbGlJQTJNOUyMneN5Gaidb13QuZUwgfw5XfdUukBtxB3
         bBInztrAk4oTBvIAsxBN2mpZWQ7qWTcWLorXPgxWoNH+OGddbEthe88yW0n+9rioPFs3
         N6uF97/MXnRDoXCny6tLUT//WFNiYHPeFlmKJrfLDAbX+YG394NEa1Cq8B7+nfs33Mi3
         L+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782039; x=1793386839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
        b=CI8K4dhD+Eja6YYHdo4Bmr67zro5A9Za8J5LO5qOFYi5rRhibLIiCYyO+9k6xt134w
         78zJkEUl6JhNScj0AqktCxljUcSgH2KW5yQJAFr/YM/Xdb2K/HrBut+VcUPCQcpb/cQ0
         wNs1OlVdOyclbQ9z8Cgj0dS0vK7YjSbRCf2SRC/ztjUbvo2B92m6/zG2ukqva9uwL1o8
         ae72n6b+SwG744u/GDhQ8IpfCqwIL5I1CivqYXRWS44iFLrkszmYsmoHCbafnPBxcQG3
         l6fEWjeZpPJf25iwjSrTZm9I8oTr/mHrwMdvQt/Xy6yVz8vyd9B6B1lto5Olx03stIMu
         358Q==
X-Forwarded-Encrypted: i=1; AKwUvByokk2chpBUsLxQazprsl8xGs7AGuiIYjIL2YArKnILDExjKIONx1kBhl+usEssNBO6C9y70g==@lists.linux.dev
X-Gm-Message-State: AFq9FYI6tNq6tVmww0SJmBALa5Pa6JrVzgP18OwzZ8WPpYiUxjq3iwcy
	1d7TwCqA+pc0uX9/Ns2jSGGS5zRZPdueAB0+4DH0iQNtPp4+tlSEqeUx+1FUrfvzubk=
X-Gm-Gg: AYBFou2r4gZWpbiUNYfP2C6YUyB5EU3wtIvIpeeRqhhN65cJ/cFDe78QR3BM/xMqoZ3
	TARwy95MEivCQ7E14jc14q993PcyAyRuLMa2zRQu0XaehhRNepkkVToXYjRt4c4N5pXu6QbB8c8
	q4trdGUeDVjVMIyOCImzz1MlstZ4KB+7KOm/BKicCwzYvvVGdKwEX1qEaPUkwKCQfRsBFz4ATj1
	Voq/DsOdWgc03BJkup0eJ+ZsK5UT7VMZXEGFlRPX7A140laYmO/S/977K2SZgWK7C75vdm48+X3
	xDHzJsCZ4JO2f8hvNQMkgK65p/sRP63VbDZM4IP+yuSS9b6CvibrGkX4TCWadx757Ibp/xEWKIs
	CVmrs/xQwHfXgy/D8nj5ha/tteS8YQqEAu095KsJJIn/QVcM8GW1KMc0t+JtFpSizJhCPrjnm/o
	9WGtsWQBJpTkL5ksPRQxBBrzC6I1pGfUqJLXBA5c42rJGXSz3vz3IyRm/43EQYqkXlBpzLyI8RJ
	M16py3b/nDK9lRP4NSs3sdzWkMfvSJV1igxHwljtP0XYNQrWdT7X4Us5qYs7qTg39WkTnpbKec/
	0MR3yMW23MwETpmpnrmvvkOUQOw7jmNCwhhZLw==
X-Received: by 2002:ac8:5d8e:0:b0:535:a5f9:7520 with SMTP id d75a77b69052e-536c26e2168mr47897061cf.63.1792782038589;
        Fri, 23 Oct 2026 12:00:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53839709ed6sm1185741cf.16.2026.10.23.12.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:00:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKKVI-0000000GxzN-4BG5;
	Fri, 23 Oct 2026 16:00:36 -0300
Date: Fri, 23 Oct 2026 16:00:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261023190036.GL3977851@ziepe.ca>
References: <20261023155914.GK3977851@ziepe.ca>
 <20261023182715.GA2798722@bhelgaas>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023182715.GA2798722@bhelgaas>

On Fri, Oct 23, 2026 at 01:27:15PM -0500, Bjorn Helgaas wrote:

> > Yes, the ACS combination is selected to avoid ordering issues
> 
> Does a user have any way to know whether the configuration is safe?

No, unfortunately in PCIe so much is really difficult when it comes to
deployment :(

> I'm wondering whether users might use "pci=config_acs=" to configure
> ACS so things appear to work as they prefer but may not provide the
> ordering guarantees drivers depend on.

I imagine that could happen, but on most practical systems the root
complex will blow up if you do asymmetric routing so there is an early
indication.

I know this because I've help debug such configurations at
customers. Some servers helpfully MCE if you do this. Lovely.

> If that's a possibility, do we have any notes in dmesg that we are
> depending on fabric behavior that the OS can't discover and verify?

Maybe, it could be interesting if the P2P logic found asymetric paths
it refuses to permit it.

Jason
