Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82A3FBEB8
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253544; cv=none; b=KlZkbfSertM21Eup6F3ErsFPErcsTtq99Ces8n63pV6VfH2LJ7VnLSsAurya9GP1bL2qNgCV+8+8LJRZ66rrkQ12lp1cA7IpViMxOrfzMbgq8pv2NWB/EsNLXsmSJLBKB1UqaxWuzWWywKj5NEKivI23RpdB5WVdOgQRUOR0Ff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253544; c=relaxed/simple;
	bh=LON1iquaiFHI7bg0xydIs2bUhPqLAJ5Vqe7yyQhb+/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6OGpxArFD7RChOd5456HVHH0P39gEAxxHbT6JBftKZaic6FPrRPKzxAgOUyk1O4KQkjdtyhKW9d+XTIlcdcj8QI8RSBB5z3Nua4KcJvsxRn46HwzLm33rB3mwopSY9OFD5FAAL5yseEa/yYlikmpJbIpVkYHEhvv7L5CaIRfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VZXU07zg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VZXU07zg"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ef45a6d9dfso227507685a.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778253539; x=1778858339; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTG/PpueXCgEiXRYtBi+EBDI0e9SJXMCHTk8qLEhxGk=;
        b=VZXU07zgwayLEGEizE/pSXrC7ViNTqJxwT8sicLBE/EeooZPennEiWxC38aikbmnGD
         8qWn7D/1eBnjo/Dlszco69O2aNkz/5fHg6xdOMQr+3AVg3ONEp8mppg8xVWri6uVFYwt
         MEvIMXLS4vq2mXn+m26xcJz4GVFWf+pS80rznSQ8xydOeMPSbM3HvU3h98r3Adt+CE2z
         LsFLXtmEUmsgv9UjKhHu9iXc51hfP/lrIFYi/Vn/Ups4hDST/7ClRukBr62OVUR0pSnE
         FDeltcjakMEIpRfpiriFWY0CckKofHSqvWSOl4Me16xrgt/VK0AzzBUgW7YeCaysMRau
         CfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778253539; x=1778858339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTG/PpueXCgEiXRYtBi+EBDI0e9SJXMCHTk8qLEhxGk=;
        b=UEPMEX7wakeaMq2fUoj6kx4X4LKOuGI0zw4Arh24hbpkXO7322fv6tTUkeRcchTboq
         QzSHqLO6mNZ3Y/2TfFNM4wcFGx02KOhYwfR64Yef2jL6Ez+ztVuyyW2eFmfRdEn/rS5Z
         J+5xC7oNMhx7GQ7Av5E0zwatyUCUmAtoA9J2xSGMjXtSLKN4t1jWqDktfskSBvzS7T7H
         o1eCwY881O57fMCf13XvGumlZWkFPmM04SKkmNk9VNMJJoxi1xvzMN08Kwj7y5MZL2gp
         rKdeHQsAzDWtoz37GcoBEM4ygYX/VrLpg+8HSjw4MbyrVukfl07bLZVF4X1rNnsN8uL6
         tqNw==
X-Forwarded-Encrypted: i=1; AFNElJ+4WlsrajAwCdDw10cSM0brhmxmwkr07jw1qqwvVbqcuO0O19aN6gA1fdKifN/rSpfOPrraMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxabAghjQPszX+VsrMCBJphLI/WBb3zJXpszd0jYNQ3KRKpYFEh
	gRJSTJDAjYD1PPA4N86gj4Czzk6+F/yZY+TGOzCokBo8Oqvg8QH69mtzL6SqwmYynU8=
X-Gm-Gg: AeBDiev1QuszRquRFBx4D6JaJND8lbciFkVF/zZ/OEtwLKf128wMhcX/bIbt+aSQHTV
	I35snMIFqa7W2fKP4YsQzqeSZ8q0nL8qxbTx4mpkwFLB0t8SMjpgGWwihTLJ9xnRseg79iRRPkn
	6lJFSB3elSYPrg0JM9gOu2fpj0DCfzd/Dpg6kD6UP5wlwZo1DnLepPqkK8osYrnlTLQ/HHu89nr
	rbEpeFDm79XptBVEGrAg94Ru+kui/7xF62l/vo8aMyJ6dTmy7Bicn0zf5YKJnEmg1ipoboFUzvU
	qfa20MwTQP4dCUMmzNSm4jJnkWgl0an1Gk+xWCylP5Fb2NiBOwrMy1E/ZDuTgy8vOIgKnpem0gl
	DOqH9swKRRw3oItnRJz2aDtgf+emJTl2qR64kwLJA6P4Yq2WDAKLIAtgCfxb0jW1dukIh2OSFuQ
	utAdKsAy4xJGAS+FhXDWk0WAk7S6eH/jhNdMoEOZFmiX4EpTEZRCCyNl4nExAZwvrIgsF5qhuRw
	Hh2Aw==
X-Received: by 2002:a05:620a:7017:b0:8cf:d6f8:599f with SMTP id af79cd13be357-904d6fcd75bmr1893999785a.57.1778253539091;
        Fri, 08 May 2026 08:18:59 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91dd48sm2251446985a.38.2026.05.08.08.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:18:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLMyf-00000000Afi-40Nx;
	Fri, 08 May 2026 12:18:57 -0300
Date: Fri, 8 May 2026 12:18:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jianpeng Chang <jianpeng.chang.cn@windriver.com>,
	m.szyprowski@samsung.com, leon@kernel.org, kbusch@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
Message-ID: <20260508151857.GB9285@ziepe.ca>
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
 <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
 <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
 <20260508113100.GA9285@ziepe.ca>
 <662fdf07-6475-4807-94b0-54b3b439ae1c@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662fdf07-6475-4807-94b0-54b3b439ae1c@arm.com>

On Fri, May 08, 2026 at 01:16:25PM +0100, Robin Murphy wrote:
> On 2026-05-08 12:31 pm, Jason Gunthorpe wrote:
> > On Fri, May 08, 2026 at 06:01:01PM +0800, Jianpeng Chang wrote:
> > > > As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page())
> > > > would be enough for what we want here, although now it's strictly under
> > > > CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory()
> > > > might be less of an issue. Either way though, now that it's all
> > > > channelled through the single dma_map_phys() path, it would probably
> > > > make sense to consolidate any MMIO sanity-checking into
> > > > dma_debug_map_phys() anyway :/
> > 
> > > Thanks for the suggestion. Move the check into debug_dma_map_phys() is
> > > indeed better, and I will replace pfn_valid() with pfn_valid() &&
> > > !PageReserved() as you suggested.
> > 
> > I'm not sure that is right. IIRC pfn_valid() is true for ZONE_DEVICE
> > P2P pages that are used with map_phys but never with map_resource.
> > 
> > PageReserved isn't enough to fix it.
> 
> It fixes the false-positive on non-reserved pages, which is the important
> thing. Yes, we'll get false-negatives on reserved ZONE_DEVICE pages and
> similar, but that's still an improvement over getting false-negatives on
> _everything_ by not checking at all. Realistically, dma-debug can never be
> exhaustive and 100% accurate, but there's still value in catching as much
> obvious misuse as is straightforward to do.

I'm saying I think the new expression still has a false positive for
the common case of map_phys with ZONE_DEVICE P2P, and I don't want to
see debugging logging for normal as-designed scenarios in map_phys.

So we either need to narrow the expression further somehow, or leave
it in map_resource which has fewer users and doesn't accept
ZONE_DEVICE anyhow.

Jason
