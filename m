Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECBA3F20FF
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288706; cv=none; b=B61Mgd/i3gz5tqbkv8R1Yy/GIQCmdcy515+g52zKWEKoKf8ghzO0EDcssGD7xFxdWV83qs+bqd2n4sutMETu82lBHiTOkaZ8fnuXnAnnW6kb7q9W0Pudfi605Vr7cflrJfNfhGWg5hofwhJ2Lnh2ujpk1y7h8nahxPG7KvR1fak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288706; c=relaxed/simple;
	bh=FA4gZ0vHmdeVsJwZEdfiluV2UoJo+V0cIxjlbvjgR48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx3LRJeIuUtF16jhNQ95ZV39uCZLZJC4OZGSMNzEIWirCD3VNfzDWibq0OwlSCAt1JwnbJsZHARzPOXBXl+xlGlU/lMiHq+eEEyqCfYrL78lb03dBknIbtkYsGjDakCdpCg91j6n7FK/oMu4xJKwtRCle5YDAkwI7rqJpf5vt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I3IH8Oc3; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I3IH8Oc3"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-516389a9b70so54889641cf.3
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779288704; x=1779893504; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz1t1QkWZCmUP77wepzR0Q4pYzk5BCD7dYEJvWGE+AY=;
        b=I3IH8Oc3IVx5dzmjQ20EFmUTRwiihHczQIO/7qBHwlPJ/3lfFtseZXSqKpPQj0ODdy
         h4XZ5fTYrjutUgSNXmjILnElvTCMDy3wPfU82iO65tzjqDsQiowEi+S/wQU9PCQa9jT5
         FHmza7obWmIa9uw8SCc6PUeRrs1a1HrtD+44vSkc3Ydh7rzCIXAOTrcsOaDUmwmJ3sFa
         kPIs0Km7SqBp0leXr7ZsIXmrB34tXmuyesC6ooGOZ30eR4xmkZ3mG67SwW1Rh1YhOt7h
         vLvu8tL4N/CUW8/dtcszPOaGB+8GIusiNdBX7TdyGKM4PH8UcHOkzlQK0uTAL+umIOea
         hG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288704; x=1779893504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pz1t1QkWZCmUP77wepzR0Q4pYzk5BCD7dYEJvWGE+AY=;
        b=OAtMb6ObaXYewcH7XDMwLbG+bZjZE+nqSRVSe/kaQm5mQt2+d4FlvRndK7iSvp5xX5
         DomsK/Ounx0kCHqk+31NZqAqh7XEZn+6TfdTxxILWznF0lAJET1nyAosqQI3lDHwvv4N
         17k3V7dqamp2iZbaO/vpbRX7hS26aC/SwsRx9VlwAjfgxv7cA9KFHygnumCp4BGMMDwO
         zjdJb+ZC/TjicyH01t6wJtA8lhKaGar7KpbycJVRWizbOl9yz1P4p+4FuostsHBp1Pnr
         yPL/NevjmB918gMjIgYDkVYNupVofduSUxFioEWr5fmmEhiSHS7D15BMGiNISxXLEYuO
         CnWg==
X-Gm-Message-State: AOJu0YxaLgriRmYxKHoEyczgwVy7wIeYMRsw+vd6P6E0DSvlJX3ljWXN
	JWXnlWhHpgRe2yDNc4Nmyga/WI3SwCGY51V9gsoftDAG4Ksu7fKWlp+iAOUOW74y+v0=
X-Gm-Gg: Acq92OEuP68DpjYh/KQqIG6FZG43Zo/fIpZX+kvxu4qaDcdwdw0ygXKp4Ru+v1V+Lvd
	L8C+MURuX9a8ZS8pq461cXW2QNOjoF5ASs980+WcBs1YXLjS13OyIpBk4JWfBSGeeuHxH8t8mqy
	feBBCZCtwJBGaSU3WntjdqKHdFTqQb1kLrVDwV01vJaBhiEC2i/hKX1IpLcRpnTBE3Rner9pK1N
	KP83eQsnCA0SCJH2dtugR2aG6ioISBCQk11+pFRkLwRoXWXtQwmRBGwNUzklFZAb3u4BXu01DDb
	TWaQq4ODn7WPadUvgTvCjL0/xP5l+VZLM/jmEriv4spEyIVB+fdgEM2wXJtDBZdwkDGSNmL60MK
	U6jYnYIhD9dGfDWlM/G8sCvLT3bNupUxUcbU78pgg/STK5kwkeJpjVGnR16FyRuW23+DKw6HbfT
	xMQZWoVbzFUquhdRxgQUtx8VXwBHkOOxMR8iDERkHCqM137sgtL1t2JAN55oOzicYZUixiiQQJ7
	WZ32A==
X-Received: by 2002:a05:622a:4c85:b0:50d:66b6:1564 with SMTP id d75a77b69052e-51659fe9204mr326177381cf.14.1779288703679;
        Wed, 20 May 2026 07:51:43 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456b6856sm194612161cf.7.2026.05.20.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:51:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPiGs-0000000HIHG-0eTP;
	Wed, 20 May 2026 11:51:42 -0300
Date: Wed, 20 May 2026 11:51:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <20260520145142.GU7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3EL10WAIImL9XR@google.com>

On Wed, May 20, 2026 at 02:24:47PM +0000, Pranjal Shrivastava wrote:

> However, I'm thinking what's the right thing to do if pci_enable_ats() 
> fails in attach_commit():
> 
> 1. Fail to attach but unmerging the invs_array entry is complicated.

Is it? We should be able to keep the the original invs and not free
it, just put the pointer back?

> 2. Move the pci_enable_ats() to attach_prepare()

IIRC ATS cannot be enabled until the invs are loaded with ATS
invalidations, hence the issue.

So you'd put the new invs list, turn on ATS, if it fails restore the
invs list back to what it was and RCU free the new one(s).

Jason
