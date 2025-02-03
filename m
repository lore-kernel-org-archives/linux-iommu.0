Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B61D516A
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610030; cv=none; b=BFdAnuN/5qRbgSdmV29mdoUVUZOA5lIUyqnNRflAhst30uFhvKfKp2hbATT0beDMT/YMGJh4ZjKxokfjn6Crh05p8/oI6IKLUuJjM+I+FCPXqI+X24aufveMt4qu961XK9raa/7K460Uovc+uF7Q6mScq5YraI24GdnQXyYTFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610030; c=relaxed/simple;
	bh=8JWcxXoxbQ+/d4OLTmav8rntW6yu0LESXzb02dgf9Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXkr4AqOksNi9A8IXuj6LYIBrtuwYWcB6U1/xjttqBRPINLw5UqFVlhC+YcSTkn6z+RtuTxjaBI+V01U6Wjc3NuQ7eEsjoNi0QAxvS/5JWoalq2nP7Umjql7zLC/OF8hme8q/6veTm0OJee+fApuOFziwu/a8NcGeBjHas5+AJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VyR1eTo3; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VyR1eTo3"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be49f6b331so450336885a.1
        for <iommu@lists.linux.dev>; Mon, 03 Feb 2025 11:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738610027; x=1739214827; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8JWcxXoxbQ+/d4OLTmav8rntW6yu0LESXzb02dgf9Es=;
        b=VyR1eTo3ovPFfZCXbLCX35nrQcEqMZ7UQODYX4cQY9Sxa26L65uGidqvCaZA4j75mm
         6K68HWFOF7hg2cXhZT4Q+63ok1AOpbyvccXO/Y3q/OakPw1luwCc4/h2RtvbvFKLKanT
         BEBvBScu+oNzb6/bl2Xt3CDJ1P1RUzgaT2CMgIUMzEiY1MNN38DJFwhZWm008gMnEeDN
         kP4NXps8Xc0gPOAhcFw+guJdjhoHpqnUkianCAWc2pl169mg+lHNZ2MjOlLXY9EwQxYC
         ACt6uUg30+VA1HcRlJ6qs6/hiSIH0NfAWnj5nSYdgaf2Kp0R5Ploulu+l8CIlp//+MO1
         pZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738610027; x=1739214827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JWcxXoxbQ+/d4OLTmav8rntW6yu0LESXzb02dgf9Es=;
        b=fYPiIwlk0/WgmA5mGEykhLct1GGMdtrk1Xit7mNMD88OcZOtVPtV3Y72j58ayTCHCd
         SQGgGTG+PrA4BzGy71JBBXr1cEaAY+Z5coMnb7v1VGDQqfVM7lKIeSpIGOWRy9QOyv1T
         XdIJQVpSb7GcVsDwQlo2GxLJK/eI+8lZLPG2yuOhyE89qI2jEM0hy/OOdb99OSMt93Ba
         NrpRRO79gq+jVjZ1KtCHySDWisdMAnNGaL5XUsHsKNeR36QFrtKlqiJlFATfSzi4dFi8
         W5P+dQZQ2jDmBdjQD9Ro/HNU6Orb67ppvM9Wkdyn1++hq0pbAgazYwrqVX4ijff9t4qa
         DEIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjje4MDBQC0cud/OGQSORefWaqtv3ToC+MlS2n/PU4WBF7rpynwT1KZb3RcnRBIY/XkieYwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqZCUAybGvkeDs1xoZURVNL3eTHx0dQxuVlcF6WzY6hXzOmd93
	pavxqfmAvLj2bfGfwiZISor3LATuj5wal/7M1rfCb5qr3Vr7+51pPTrvlV74QaI=
X-Gm-Gg: ASbGncvecgnfRB4cwA+G9+rxXaxPImjpzFsG8QMhnJLl9cBgVcIZNH7SCMHV4obaEE1
	BswBS0GkvA0Oa21DEMCaffQOJyyNgOukJgVX4+jQHzEoyDZ4gafau4ZsF6gu/Vh9h+ovT7mDXNO
	wWJ2tORBrItus/xU9BTvwiBtmcv6787Mu5VmTihL3OnrDUL2INJWg8PmCzbNjbXFV98AVPl0fQN
	p6v/vlpio55aiq6gVJO6JWyU2tOERJrR/k9ykP9M/Nw3KN+ZQvESHHKs2og7VOAqTHxolYe8y/R
	5TUis2hHVKM1sLeLUsJzHl7F8T/Vz72PmHjrBX57WEybyn6Lv/BFE1j4154zJw8F
X-Google-Smtp-Source: AGHT+IH9lm7yxORMtUKnhgtCo398qO3xBrZWzG2Ji8hCZqnDx3AD/ekoAplJegHaKOf+kPYlEc3QqA==
X-Received: by 2002:a05:6214:1316:b0:6d8:7ccf:b692 with SMTP id 6a1803df08f44-6e243c19ebemr308346136d6.11.1738610027388;
        Mon, 03 Feb 2025 11:13:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2549225e8sm53233546d6.88.2025.02.03.11.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 11:13:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tf1tC-0000000BLdk-1MYP;
	Mon, 03 Feb 2025 15:13:46 -0400
Date: Mon, 3 Feb 2025 15:13:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, thierry.reding@gmail.com,
	vdumpa@nvidia.com, joro@8bytes.org, will@kernel.org,
	jonathanh@nvidia.com, baolu.lu@linux.intel.com, jsnitsel@redhat.com,
	jroedel@suse.de, regressions@lists.linux.dev,
	linux-tegra@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [REGRESSION] Invalid gather when using Tegra210 media engines
Message-ID: <20250203191346.GG2296753@ziepe.ca>
References: <c6a6f114-3acd-4d56-a13b-b88978e927dc@tecnico.ulisboa.pt>
 <20250203170617.GE2296753@ziepe.ca>
 <4ea1a48c-9020-4793-ac9b-b51fc289e442@tecnico.ulisboa.pt>
 <20250203174331.GF2296753@ziepe.ca>
 <a0f776ba-bfd2-41fd-8370-14818b86bfbe@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f776ba-bfd2-41fd-8370-14818b86bfbe@arm.com>

On Mon, Feb 03, 2025 at 06:49:07PM +0000, Robin Murphy wrote:
> I'd hope the historical reasons for not supporting IOMMU_DOMAIN_DMA in
> tegra-smmu no longer apply, given that all the default domain stuff has now
> been integrated into host1x for the newer arm-smmu based Tegras.

Indeed I do see appropriate looking calls to the normal DMA API, and
the other mapping path is conditionalized by !host->domain.

So, why didn't it work for Diogo? Even in identity mode the DMA API
will return correct DMA addresses and the !host->domain path will skip
mapping them.

Poking around I wonder if there is some assumption that if other parts
of the stack, maybe the DRM driver, are using the special domain than
everyone is? It seems to blindly pass around IOVA without really
checking who is consuming it.

Christian was telling me DMABUF had some drivers that made the
(incorrect!) assumption they were all sharing translation.

It does seem like a nice project for someone who has the hardware to
rip out all of this custom domain stuff and just have the iommu layer
setup a shared dma-iommu domain.

Jason
