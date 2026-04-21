Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402642417D9
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779863; cv=none; b=WQ7AU2GL42OXZ7zraN0r/1jnyVN80YKg5msT5fxdhZnZBhDAdEPZmSRMEJEAoTNRhdm81v5iBy+4CJBIE8NMNHSjd41bJ0oyK6Gr3QFX4fn6Ce7mM39HvUM1PRNfulQxZyc6Gz9U65qoyyYwK4vJHwoKEbNF1srPWR59GUFSCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779863; c=relaxed/simple;
	bh=KWyu8W/AF/2QHsLoVTQLid1d0phRuiMbOZXo2GaltoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmYDHNhZhkcZDQTXQnb4wweH2qSy1mAqqzxP+IhSl0Ys8fTjnuVy+HK98DMRwnNdh82t6FwdEHU7D+R96j+xceu3cY0xDJURTFhhC7Sc0U5iNNzObooWCectV63kiu1PhUn04eZscQKSfjtYAdlov7NVhCrphAXpmxkb7Nyb8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bgDGeAyF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bgDGeAyF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e5b55062fso19562801cf.2
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 06:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776779861; x=1777384661; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rcyKryWSxcxtXxubRhxdSk38Nrwzl+k8BQ+7s4VBFAw=;
        b=bgDGeAyFFkQoengPe9o9IKdbKzZSMFSt4IargD7FO5Ux6n8ijEqHN7LryBFMx0N6mG
         6kbU65dNADableQllitsgml7NwZ+Z1fB9QSOgdheDz3zlEne6bBs1ZSyxBALwnvHOZkI
         h+ErDAoJ20hTqqxLwpdHHnJklwSpwxC1p7D3mjzVgsfk9Zi3mnBsmzHR5M5aYvN7upIt
         RPqUpM1X2EjxfFNStgVDn34j5IT5L4KnvMZe+f77SqpCrzYO1DWXxuYIk0GvTadkojy/
         pvFOeUcoE25Toom1eBQMdqj5H/p1J2XdhXJTfjlHSlH7TnZB2e/gJzRAxpkZBRUANwxz
         D9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779861; x=1777384661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcyKryWSxcxtXxubRhxdSk38Nrwzl+k8BQ+7s4VBFAw=;
        b=jV8TUgQGs1ugqnBd0rCVyPaaQw3F50A2t0ALNW4C2eAuS3wIgW1HtbRptIOFNrlp6v
         A7zYqf2rxX5bF9Mh90irIdLMwQ45JlA2c1vH2FIuSIgwN1dad/uoC6HhgJEQRoWuBVZI
         WUxrbQtErHWI5xfUUC1ygxVu74SMCxjWZrEmAWRGX9IGfb3V8bdUQ1qErsexzoGX6/FM
         s/W7hE7N2qgZzwErxt36Vewx6K2YKKZ9FUdOoYvSiVtjveLMVlhJzEwUfWrtAyG8gKyx
         aIWEJhHdajSB9VOt3PqCcPh7NFPpg+pj90UP96qsB+ls28Tufw8Awd+HnUo/F9RfaOs0
         Ks6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8x2GKgXsJMkb6Y4ZOpkfum9okl3CgE8mFAItHfYdE0cU2cteBR29Yy+T040Krtu+O9TONGjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDqtdX5awAv7x/8S4Va3Cu31xPPzbIU048XRnVjoectcRLq2tf
	oMnjkzgq1H2wOdev3U3AJIB7NnCl4TawTd4l6/BOplhSXPMWUHXqh8D0HQ0KhwBSaPM=
X-Gm-Gg: AeBDietXigPkRz8ENnI0sxA4WwV4Mz2/ViPfT1/kEVhK2GHOlLCnv4b8R+0KLtjvjun
	n41cyIi6QHHO/gQ4UDZ3iaUOrdWk1R/VF0rQaXPfpnRVDtL6K87AyBasTIUTijB6x2S2/EhoQ4L
	maWU2P5z7+m5J6PQYx0iu29jT4CYiA0U6h1/Wa72duGk01gs2Yma5Br1Gm43gA5OlRoPN7PgtWs
	8o2E909Q9gaJAG9yJFH2pE2GnrTNOI1UygZF1QwNqCpCDSz7FiT7o5o+yz6TbXjgj2GJ8zwxMW4
	nDAYCo2vD5C4RR8RgHqHibFF/EFmdAJbjT7TorZidoVTpsHAfq1QrDbY9a1rYmdVKvIu2Sh44oQ
	XBUuH3qXJz4GyHndT87afB82RemhEwQUdJ1Z1SgTC0W/K+uVG6v1mP8NIDzj4B2n7MpeoeRrmQF
	nwEUTMtQWkhKwRQno1UtNFJ+8NrCsiop3vYVz304qGLDaYih5LUDlWtiVY54DLJ5VVJEjYzKmvW
	YGN3Scl6z+clnV5uJL2P55ZsNs=
X-Received: by 2002:ac8:7e8f:0:b0:50f:817c:5d45 with SMTP id d75a77b69052e-50f817c676cmr84046341cf.23.1776779861245;
        Tue, 21 Apr 2026 06:57:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac4513asm100113276d6.1.2026.04.21.06.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:57:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFBbg-00000001itC-11jD;
	Tue, 21 Apr 2026 10:57:40 -0300
Date: Tue, 21 Apr 2026 10:57:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: l1za0.sec@gmail.com
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: fix slab-use-after-free read in
 iommufd_ioas_unmap
Message-ID: <20260421135740.GI3611611@ziepe.ca>
References: <20260421134719.33801-1-l1za0.sec@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421134719.33801-1-l1za0.sec@gmail.com>

On Tue, Apr 21, 2026 at 09:47:05PM +0800, l1za0.sec@gmail.com wrote:
> From: Haocheng Yu <l1za0.sec@gmail.com>
> 
> A KASAN: slab-use-after-free read in iommufd_ioas_unmap is reported
> by a modified Syzkaller-based kernel fuzzing tool we developed.

Please don't submit bug reports without validating them on the latest
kernel.  This was fixed 2 years ago:

commit 6f9c4d8c468c189d6dc470324bd52955f8aa0a10
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Sun Nov 12 15:44:08 2023 -0400

    iommufd: Do not UAF during iommufd_put_object()
    
    The mixture of kernel and user space lifecycle objects continues to be
    complicated inside iommufd. The obj->destroy_rwsem is used to bring order
    to the kernel driver destruction sequence but it cannot be sequenced right
    with the other refcounts so we end up possibly UAF'ing:
    
      BUG: KASAN: slab-use-after-free in __up_read+0x627/0x750 kernel/locking/rwsem.c:1342
      Read of size 8 at addr ffff888073cde868 by task syz-executor934/6535
    
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa

This is v6.6. Nobody wants patches and bug reports from v6.6

Jason
