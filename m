Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C816F27F
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788161; cv=none; b=e0VmReI15LsycMl3C53hjvNbxEBd5ZugrsVYro5tUF9sIQsZwCdjA/zIFwKGtH+iF21FEp1LxLRy68eZJ6ERrN37KDvkF30DS2q6EbTqO2pgbI7LmmifLUVLxbOOV18ZT3l76L+j3alSqSKIS7P+Fjfo91GkhaaVa4G+hsvgkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788161; c=relaxed/simple;
	bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1uuRHRyd1faMXR3uw5rjaWsyiNuJdUFQRXqQXCmlmEkH0E36of3gqDOa1Nt7L1VhxoxcCEwuPUIsSo45fimdEyqOPTMmHNxmoUD2UWWQMyptpJfr8o07fJWWmGC5AKLbPih6fNyRFxLIMUWzBqH6HR5CMkhn29RS3EmvYvlpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KuZSl410; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KuZSl410"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a05c755477so119006785a.2
        for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720788159; x=1721392959; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
        b=KuZSl410ieHQ2AzJSc1utVaCPrm10Ytgb5x569aAqAIdPKdOEOeWPTKer9uRaDR/Gv
         ViXQb5T4PEhYAtW6STsRZisCqRr4ZPNLUokf9vDaeRGmnA5Z4KgjQZcbOhbEdwc/cV/D
         RZb7nqnzsOsSacurQQMphtUnruRXY9jDkQ1cLfavrktmlnEEVWIIn4ES76Bmjki0pWyY
         n/ZMWDGunUbbGfcS5dsMtmE91ihLfsMZhD0G2fwkEA8cBgtnpK1x2aOHVQxhx5AllBbf
         L/d1makxkAucvq2I6Cg446zLK7gssyxK2PYXlnMkeoDjr2EkaAwG4iIaUHyI4m/tqfNv
         szlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720788159; x=1721392959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
        b=QJ0lBHXDwvEmzOLSjQ/f8rLcOnEOR6Q2CY2lJoJPbJTzebsCNBTUpFO1odoF7AtfOO
         rTM/WLNuqvv8hAZ0xZWg+eNG4/EpqgTv78yCnUgMEgt+CH5JxoEJbSBNqyuy0Zjv9Vfv
         ca2hABqKDOj+71RDhu7Znpf8C16MreKh7w6DtYBM8vwU/KpcPmMK1xxtYfUE7MHS8lti
         JPTDLdl4XzsWorhBQHm5p1h1o2KSGaI1cUkafkHhvzClXw0Fl6M+sU7uyD3r5uEx6696
         Z+ICpnwtvHFPDZ9hW7UO5TpyTd3r5c6Q8D8TUzGzAM+SvCnPWVjxmJaK0GPXbdkWV4Hg
         km7w==
X-Forwarded-Encrypted: i=1; AJvYcCXjAjKHvBs/TDWjWvHA6DZeMYrvfpIO0+lpQ3pLdu3wRkYC+eA8/Td+gmoaaRV7kjMpmYyyvjpROKEJg/Ef0G1PMT1q+8s=
X-Gm-Message-State: AOJu0YxJH1A5ZggFJQPCnmoMOoBRPLjYX2GhZ3uA4UpptzF7XR73fgLs
	0xBj5Vr37ZkATKFAR4nh4iBa+jyP0BZWza5rj3elABle0e/4lRGEis+aTvVEUbo=
X-Google-Smtp-Source: AGHT+IFNcSNXyjLCUq4DHk3R2ij71BFERvS9sNsM3zBakmLtTWzYOjs3C+yBv/o3LvcwnsHGWOmY4Q==
X-Received: by 2002:ae9:e315:0:b0:79f:1836:b143 with SMTP id af79cd13be357-79f19ae5454mr1218368285a.50.1720788159083;
        Fri, 12 Jul 2024 05:42:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902ac2esm394037485a.59.2024.07.12.05.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 05:42:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFbh-000FUg-Ne;
	Fri, 12 Jul 2024 09:42:37 -0300
Date: Fri, 12 Jul 2024 09:42:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240712124237.GX14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
 <20240708235721.GF14050@ziepe.ca>
 <20240709062015.GB16180@lst.de>
 <20240709190320.GN14050@ziepe.ca>
 <20240710062212.GA25895@lst.de>
 <20240711232917.GR14050@ziepe.ca>
 <20240712045422.GA4774@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712045422.GA4774@lst.de>

On Fri, Jul 12, 2024 at 06:54:22AM +0200, Christoph Hellwig wrote:

> This is all purely hypothetical, and I'm happy to just check for it
> and reject it for it now.

I do know a patch set is cooking to allow mixing ZONE_DEVICE P2P and
anon memory in the same VMA ala HMM with transparent migration of
ZONE_DEVICE to anon.

In this situation userspace will be generating IO with no idea about
any P2P/!P2P boundaries.

Jason
