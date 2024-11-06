Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC9202F6F
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909725; cv=none; b=rI+Cdzj7GjkmKzBEBJBcRGa7WYuif2p1Sp61CrtLWovYHHLsH5lqgmU9yPj9/mTO8euY1m8ohVfCn6fZ0dH3k+iGOAoAghZybnCWr3CKLYAxSXhsr9q7SeQ4a5u+dvLcTTuHe2cv1NVtIEeDu6ZJuwSk0siMKj6rwuMM+5n6kF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909725; c=relaxed/simple;
	bh=4IEA5CT2OJ1TXjN8LNwKEd35uSTQ404HcVnPzFp9gEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0/qJA6+pNFDOwXd39wmzIaF3kqoS/DrIw6V+ln7Jna/936ZnuvOPkaQuknxTYU7tibQYMmbUjbPuEp3UxJ8uz61ryUZXfXVvPD+ixJXE0ONWWtKURBgGyPS6pfA30MAvsAlNQhoiWkAJN39yjpAleZ1qX7V8/qRELf2vB+9yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WOJ/Ruxu; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WOJ/Ruxu"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso44529016d6.0
        for <iommu@lists.linux.dev>; Wed, 06 Nov 2024 08:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730909722; x=1731514522; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6nSgGdK6NvqqFV9LyhiXVQ/e823UrG8JIi5eQbgWpwM=;
        b=WOJ/Ruxu7/79JBCLlkvxoLGm6fc35l1yTGONpPtuolqV54ZeLFyUSIEVu1LUDjuSzn
         cohxQXH/pe4hGW2BBvotTWfqVUVQZ5qdy4bZ/NP80E95bI+SSUfY35OAmisa1Ls8FPxT
         kHV2wmn8kvmH0H8I+xYpbZil3SILGq2whqtjAu0YvDT7oDrWS5imjlJ7NieqNvo736Wm
         GB2AId2ZfHEahHFghTu7atnAGVE2voWMMmbC13Sptn1XG6SJ2J8ueWz6zKZQvkj9bO56
         5oiVytt6lYfH/zp7CJ2CGz90wXbTZ9yawHuhd4xDHdgh6PT54T34+ueNmjte7myBh5DJ
         a03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909722; x=1731514522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nSgGdK6NvqqFV9LyhiXVQ/e823UrG8JIi5eQbgWpwM=;
        b=ThyjoKOnpOsA7OHPHp20WQYR6+6cLCax7Y64nbxrUTeNhFzW1aaLLpUj90JONi164y
         12ZjUsiNFbSMfhyKKnV/E+hR+PkSBgMozHpYkTdQqtMF1HoqFQKnSDgh9uW6R5NxdlYJ
         KeEwTgRWgOMPY/MGi1CiWi+/I3JdDasp/ln2X5Gz/MmXng2HF6xNfQF4mPgzCyUPblLe
         8Hk4CyVCT0qPjvq9etI2Fsbk94a2RGc3RPvc0KWz0c7PD9uwv5W+lyFU0Qt0YWwjqZrX
         W+nqWo+NIX/0+8iwiVkKC9zd0Eeb+jZB+T0sLc9/H6ystSq32zPSC8eSYzo7DUJKIkj8
         4UTA==
X-Gm-Message-State: AOJu0Yy2gk+WJO1uMKnFJ0P0qU2OXK4uSRaWPvYUkasK7k7aASzddQHI
	XbSzE9hHmwHyeLbQ4b6G4r/1zdVDaPdZpHQ5pUvDAAOputUCKwyQEMut0OWiFUaRkd84lRtcwhj
	s
X-Google-Smtp-Source: AGHT+IEwombH/Npcr6xgQKI4hUOBNWDndBBc7puCreP3V/CqgxTRomKyutXho3m/FUi9CO1Dgd2M5Q==
X-Received: by 2002:a05:6214:2c13:b0:6cb:f654:55ac with SMTP id 6a1803df08f44-6d185683569mr561328396d6.11.1730909722261;
        Wed, 06 Nov 2024 08:15:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39ebaadsm644777685a.2.2024.11.06.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 08:15:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t8igi-00000002BDj-3v7y;
	Wed, 06 Nov 2024 12:15:20 -0400
Date: Wed, 6 Nov 2024 12:15:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
	kernel-team@android.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org, Liviu Dudau <liviu.dudau@arm.com>,
	patches@lists.linux.dev, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3 0/3] Remove split on unmap behavior
Message-ID: <20241106161520.GJ35848@ziepe.ca>
References: <0-v3-b3a5b5937f56+7bb-arm_no_split_jgg@nvidia.com>
 <173090505900.4167208.10850898110820689849.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173090505900.4167208.10850898110820689849.b4-ty@kernel.org>

On Wed, Nov 06, 2024 at 03:53:23PM +0000, Will Deacon wrote:
> On Tue, 05 Nov 2024 14:14:23 -0400, Jason Gunthorpe wrote:
> > This is the result of the discussion on removing split. We agreed that
> > split is not required, and no application should ask for anything that
> > would not unmap a full large IOPTE.
> > 
> > Instead of split the two ARM drivers will now WARN_ON and return 0. This
> > is in contrast to what several other drivers do of removing the whole
> > IOPTE and returning 0.
> > 
> > [...]
> 
> Applied to iommu (arm/smmu), thanks!
> 
> [1/3] iommu/io-pgtable-arm: Remove split on unmap behavior
>       https://git.kernel.org/iommu/c/33729a5fc0ca
> [2/3] iommu/io-pgtable-arm-v7s: Remove split on unmap behavior
>       https://git.kernel.org/iommu/c/fd50651636fb
> [3/3] iommu: Add a kdoc to iommu_unmap()
>       https://git.kernel.org/iommu/c/6ac7dffe7cca

Thanks, can you add this hunk to fix the W=1 warning?

--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -820,7 +820,7 @@ static int __init arm_v7s_do_selftests(void)
                .pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M,
        };
        unsigned int iova, size;
-       unsigned int i, loopnr = 0;
+       unsigned int i;
        size_t mapped;
 
        selftest_running = true;
@@ -868,7 +868,6 @@ static int __init arm_v7s_do_selftests(void)
                        return __FAIL(ops);
 
                iova += SZ_16M;
-               loopnr++;
        }
 
        /* Full unmap */


Jason
