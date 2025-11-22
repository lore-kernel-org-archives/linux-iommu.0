Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3443147
	for <iommu@lists.linux.dev>; Sat, 22 Nov 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770797; cv=none; b=PArj4AZXPaej7pvtGkctpsftKfqYF7ZyBJNeavradxul6kKUjj27U1Z0exvOT1vfDwE2WDshzqjzFbCSIsWHdRArVe+uG7HA+nJCQTL37DMPij688NLsbxrZ7XqDQT+r2/IadCDHYE2Axal5PduaZ0kgpRVn0dqld+KD9eEzxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770797; c=relaxed/simple;
	bh=SOnigNwTuelk9HO0f5chnVu0V9GZRAWifL2ZgcZyS2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n11btA5ePdc7eq/d9uQuVfl8uJyLfEsP275lJ7aMOEYElxEfZBvbDk2tIwaz83l5KSFE4O3xx0jBLILsmdxoSRRWERCUXiQB1Pu13AWGWhcN2ssc7udMGgR+2CCuzxhBRlI3fb8SUxdfWE8vUl4xSDJEi0kCjDj7Mew2pzHl6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XNV2mXgy; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XNV2mXgy"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2d6df99c5so386470185a.1
        for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 16:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763770795; x=1764375595; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUkjWuJthuHV9sGeKnw6uEzeUHwvcS7Jj1D9mCH3vV4=;
        b=XNV2mXgyieC0EltbuoAlpbU0Duo7DwbuXfcE1Rn1vaPGqs3zDPo1RxhswGskwL+dv+
         dXJe56fksKtQBVhp+BIv9I06zvAY9GyCZpve1aWCEnOOpVmNUIga7aKJ6hDE5X39rNVi
         7hzrqekFZfSmX+KWS51TomJAc5dmpRxHSF8s+ggwIgsvWIqQFYz31sTa4zQR0wsXy19t
         JwSy673Epuf3n4rnLDboGFrBro5tW6uyntGuxUiyuLQaWAfCfzMeQENOa38m1sDngEYx
         vEoIbJsbwe4j+x5vMXrp/grUHpAzx9QJZiXKeiGsKOwtiwiDYRKwSozVz6GmS+/TnDtD
         ZBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763770795; x=1764375595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUkjWuJthuHV9sGeKnw6uEzeUHwvcS7Jj1D9mCH3vV4=;
        b=EvHqbZaE4R1QYomgGM+0twYxzqaPrpF2WubDkMmnKDELCd6iutBCbXqtOPeuPNkXcM
         IOrD6dPpV3HxQibfmKEKS9XEaJr7azedGG6uSnN6H1Q6YKNZL+avA2WcseFsXZ1erWwT
         Tjqe47KQrCek6Nd6Gc+qLbtHDgZ3uq3gs50szSzA9EYTV2AHAAIYDoFrhbjcYk8tNhj9
         DAs6b2QFvcRzSBQbk0pNgxAwe0KzSPYyZG/aX01P8V3mgs6dgu2dkChlsYvPBcQaIcl+
         /JX6J/M9aYJjZmpXNSHDFUTSkHcBFp8J4WW3GjRxTDIsjFfutdTW4o5DSUsWICStcC1/
         C0fA==
X-Gm-Message-State: AOJu0YwT6XPbCCMHK+/GSlea+hfdy2llCw4qlolK+hfVXBvoH/0WXSyg
	zlReUdayWFbnSkNKgDb3GGgQ+47vvIOdrY1pmuYayj2DnsuQF3TH8xh/8OovUUsGPrw=
X-Gm-Gg: ASbGnctBCOqgkGt8RF7vYnzVeF4Wpwuyy/xrpLyOxfNkDmgHHe1phKcHS6sA0ZWdcz0
	/ZMCRK0G+y9H2pNR/+kzBhVS8oIKzI+xqpmgd65+Pa9Irwey9+5YpZ9yYmc477E92W7waEz5J3b
	tC2aJD3XIahyVYZZFFmpWY8vfbo/ALgpUa0hcJbecUlwvrbIl5OSkNlE/EPRA7EzB6AecFLJzn3
	+FNpGBi6tBvgPbz45v07dbdcyzShoKc4fz2c4eWG23tnzulQHH2pOeHj4ys2jDAwY5ClsJhIWQT
	k9awWeLueGI9qR6MGWjbEZU3h3amL9EwHlgnx2XBGLEvjRBJmSZq2RUqj3Rf0GTbiS8MjZMqN9G
	C7P6n6EQuuNo5Mz8fG0gU05o2EpWFhsP0u6EET7IqCDEE2FneYQQuH0Afav2LNgcgKJI2Iof6AL
	znzN7Y+M3t/+5Rnl6NSt81hwMcd0T3sfQbTMdP6MY6TO5O3jn4A8/p6VS5
X-Google-Smtp-Source: AGHT+IHtordf+SNv21ZAyzjVU7kpqO+S0IRmcKoIKwB/ZmJDa7USUYQKOnCzxDKsy9dskW06sNSFkA==
X-Received: by 2002:a05:620a:4087:b0:8b2:e8c8:671e with SMTP id af79cd13be357-8b33bde8dcamr683716685a.29.1763770794650;
        Fri, 21 Nov 2025 16:19:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c2276sm459964485a.30.2025.11.21.16.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 16:19:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMbM1-00000001cTg-0z6Z;
	Fri, 21 Nov 2025 20:19:53 -0400
Date: Fri, 21 Nov 2025 20:19:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Landon Clipp <landon@lambdal.com>
Cc: iommu@lists.linux.dev
Subject: Re: Explanation of VM Boot Performance Gains with IOMMUFD
Message-ID: <20251122001953.GL233636@ziepe.ca>
References: <CAOxhPvUbB4T+Q4VvmQ1Ed2fFqiOBM2gmCaDB+k-tgWjRcABFyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOxhPvUbB4T+Q4VvmQ1Ed2fFqiOBM2gmCaDB+k-tgWjRcABFyw@mail.gmail.com>

On Mon, Nov 17, 2025 at 11:31:03AM -0600, Landon Clipp wrote:
> Hi folks,
> 
> I have a Kubernetes cluster whereby containers are spawned inside of
> VMs (Kata Containers). These VMs have 8 NVIDIA H100 GPUs (from a
> Supermicro HGX box) passed through with vfio-pci. Passing through the
> GPUs with the legacy VFIO cdev corresponded to boot times of around 30
> minutes, while passing through with the IOMMUFD API brought it down to
> around 3 minutes.

30 mins seems so unreasonable, are you sure you aren't hitting one of
those kernels that is faulting every GPU page? That was fixed at some
point. Though iommufd with the OOT patch would hit the same issue.

I fully expect that when qemu uses a memfd and uses dmabuf iommufd
will boot much, much faster that vfio ever could, it has so much less
overhead.

Jason
