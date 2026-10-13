Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F92475E3
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895444; cv=none; b=q7tEQ8icI0fulXI11n9n7z8AHXu3sJh+S9x3r5WitaAh6Hxn1/9QmajJrWVMds0wrC+1YThkRK140rBeYrv8AwyXwUO/M7XoZCHXBSt7AWPGiI+/6c28KCrwEghSGpZsxl4of7qHFHlMjrTP37sXyydFqR4JxOtqewPhBQnvIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895444; c=relaxed/simple;
	bh=Ffj0rg1ejA7e68ABDtZ/JEnCcPZ/obpgDVy5o1iSi8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiPav3uPEeHqb5nu+fPY0eZeJ/6WHdTnydg83gQvGpW+EBq7yMQTCjARYp/fqnIzQ8eNfTeXCx29wKga4Ol/oeAdsnScnfvxZL0T3L6zAlltKBZpJYmUMSBkMwg1Z5066Ua8zd8V1CO8a7trz8SI2UEkkTQXtcgC6yw0aITSjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Kbp101ei; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Kbp101ei"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e63522076so218177085a.1
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1791895442; x=1792500242; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ffj0rg1ejA7e68ABDtZ/JEnCcPZ/obpgDVy5o1iSi8k=;
        b=Kbp101eim2OAp3VE0rj2zZZAgFZX+r47hIx/OMFwoC8OYZrene3lOSAU8Ctna/axO2
         HCRj0ivyKAtQUjQWaYrrafcW2jrQLmgA9UM5mg6GUF6UcblBMtD+84ymBH9wJNZxEr6u
         6MJmAOzZLcc2l5SlMAWdWE3R8uYWPytq9fNV0o9HicU2IomJ3I4LIxpF8snznfxGJH5v
         d10ulHwnSQIjNRnXiFlMgbGPk3bl7VkPmchh1Jg7GiW3HHwUEGHOfS+LpMJcUOcQ9JJi
         9VZSkBOQ8ezJ4i4zZ2i4CqrIMVXQmNgKhTtVLD+sMaeR8XDa8kKAHsECL35iVaC5mSTM
         +xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791895442; x=1792500242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ffj0rg1ejA7e68ABDtZ/JEnCcPZ/obpgDVy5o1iSi8k=;
        b=zWgvwjPGb9g8e/TOKAPGEd5q79Y0Ftrp/VrzCKnXYNFK6TH5fhy3kFVng8+di1u7bt
         EcKquV1ksDEksHNAzWNFKXmp/Cu80gUDb600TXct047FjuFjNRKk69YZ+eh1FhDFwA/2
         9FyBnwY/3D1KRslK33we8NcRqBo9o2Up/rtRcjoxKo8urWuYBShYSIOs1zW2X9vnEvt4
         +BIWoeudNLrjkmn7jZAncZFnSQhY2COwy6jTbwinUphKzdXByUzRQqgZwQh1Ohy1HU2o
         pmtd105j8wDisZTE1ra6R2zUGhL4hj053KPTkOngNZzTtjtXTBJINCIzDmgW/IirnJ73
         lb4A==
X-Forwarded-Encrypted: i=1; AKwUvByrl48iJC/MgpNlRVZpIRtjT8bK5RgywoBYzNXSAt+T0v2N15zyoi8ALC2Vau8exk9Z9/ZaJQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLmmOqPrBqAaPoXzKjeN8zKVdNjA+3HhfTeAhczKyVtq0KHDkad
	THPjtcYmZXkwxv0RE6yDgCqO85VRDBrkRnjlCT5g2AODig8We5jTAQX2fuvfbsjylAw=
X-Gm-Gg: AYBFou2l1DTYkrmPLJz64UGgmzaZoTWJ6poBtX7MTew6O+kTFKUcbSEowrd/AB0F8Hi
	XJFWODfSjGwy8QhV6MTZAe20i9zs5dnszUvpIT+DRHRPzTEvf0tl4T2i58yWOrG+K4H9mn3go/r
	ZF0AYL0la+sg7RFcED4HhnvsJxYyXPzLz2U9rs3bCytmnB5cJ9zlSGqjCsCZxRxpsXgsWvx0KmB
	tJnMGQVIqgWHd0t8ubZwqepTZATAp9xSXEUbw2FmfZadRAVSPQv1oJIuO2jPDNf/mFytg0oeRCZ
	73kogwZdxXP3Ga7/pdWocb1vPWj7iBlUyoh4eXvAxe9KBfT9oA6I+nv58VDtWiAjpQFT+uGSLz8
	FEvTIhvC6x9rvK+aaOjYb0L3PMT3FZzQ6ugyHsA070p8z8vH4XqMncl8bqX6DcXG5iyH9C2gNeJ
	6ZTuPnoIAk1OGKFNgs5zXNWazzmnuoSvnsA22D+tDmDSSzObKYsIekqppzdJTSQtmt3L+niX9bv
	/ebq/DXVd+BNQYT6emY/a23rHkisGh5mvEBmFig4kuW1JBFjR/5JX9P
X-Received: by 2002:a05:620a:6601:b0:93e:6ff1:b67c with SMTP id af79cd13be357-93ebd1e0149mr2182476585a.20.1791895442098;
        Tue, 13 Oct 2026 05:44:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5009ca3sm227528285a.7.2026.10.13.05.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:44:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xGbrM-00000009Wdr-3fVQ;
	Tue, 13 Oct 2026 09:44:00 -0300
Date: Tue, 13 Oct 2026 09:44:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Peng Fan <peng.fan@oss.nxp.com>,
	Will Deacon <will@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <20261013124400.GI14213@ziepe.ca>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
 <aszfVNP6DGzWYdK0@shlinux89>
 <as1zR1wc7ERxvR1F@nvidia.com>
 <e8c22eb2-ed1f-47c7-b2ac-c56ead1cba8b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8c22eb2-ed1f-47c7-b2ac-c56ead1cba8b@arm.com>

On Tue, Oct 13, 2026 at 12:22:06PM +0100, Robin Murphy wrote:
> If we're not going to support PASID for shared streams (which I suggest we
> don't...) than we shouldn't strictly need to worry about CD tables anyway.
> So rather than having to special-case CD table sharing for shared streams,
> perhaps it might make sense to generalise back to a "default" per-domain CD
> for non-PASID use, which can then get switched for the private per-stream
> cd_table if and when a device does enable PASID?

If we have stared STEs then the group becomes the per-STE data
structure not the master.. We don't have any way right now to do that,
but it would make some sense for the group to store the shared CD

Jason
