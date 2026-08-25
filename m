Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F873FD14F
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657553; cv=none; b=gAJr1oRao/g3LFVOuUPAEibcod0vWVLC2L9Vpgn/ykw0tcTUpeC1MJrmXHgn9g3rc5x6X/a5cPYM9WZ+LEke2Wmn1A6Y/awkT5ZygiamS0c9TmsByfi3TTDstLQeMZTQQtWhe2StcSVVHMebbiHTpmEKSWqe37K9H70TuSC5zd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657553; c=relaxed/simple;
	bh=77FV4gAwZHhe5VsNEn+/kHl0xzti0KlAzAXbsklLkdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhM9Am9CpYwP88bNZAvxcd02cgO0g01fapG4Gr7bH2MWyV1yNWlEQSgnK+cXLN6TmIDjBdWINZCZv36rX/HDo38AejZMtQle5vZcFaVa3CdxBlrj37bOeDGw4uxLDmRITzsJLGLa4rpihT89hcaMC/FOXJjuRlCk/O1mclvkURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QDhOfTGi; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QDhOfTGi"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efbafa1bacso26704666d6.1
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787657550; x=1788262350; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vVQT3N6kOOE5myTvrMMJJrC2le/iHw4etRZgWkc2XyQ=;
        b=QDhOfTGiKjhihZ8576HO3woVbv5KfVSoK7stwMDNKiPtQwSJNX13ZuRYAoqfOSwrww
         gLCpRpBmN6cxtc7UlsH6UB8I3VCmN/c9RA4OkwWWsIZIMiuvs7ZbmqtlruWD5aiiRj3O
         GUWJrLviv7fAFu0jV+Y0WNo9t2bIoJq2Aw97k3szoxpg576vp3eVFO2/LixzoQqf9K89
         66ZQlcQaFNNMz9dr9JSdWmzJHvaakeOMjCh8hnMtYtCOpaHsoufbLnD++IXT3+3SP//F
         l7HH3BfSvDReqRsyKqE9vLfNioV124Dq5RnLO0sIQ2zTVcUwwWbdWmpqZcnGjIsnOb3v
         ltOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787657550; x=1788262350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVQT3N6kOOE5myTvrMMJJrC2le/iHw4etRZgWkc2XyQ=;
        b=o+8eWq6eoemMTGeuBY56I3Bvk8XHi0R82Q4dE7QauwAUupmZOFvesi4YDgpe8S3cDQ
         Rl99UY8BOL6cPi/6EBhla6bZo1Z8UDmruwbQQL6eVcblJloL7mf72uoEJoCaK4bFGpDM
         mWD7jjUGC+u/bAMLskuxfw3CHe3IbRN1BORH7ws1+Br+H1OnWjpjpRObse2DwXqkz7dj
         XPoP5Z0Mwee9eiGn94U8i70ITGuHTMtC24i8XPjc30ER5LTMfY4KVRisIuipOFeumvq7
         6jzqiHh0AZwvVtnFenHxO8+CwsKsU/nYy5fRLIO9CSrUQRVZbWPGeqDYiiuDp+OcDw6P
         k4+w==
X-Gm-Message-State: AFuF++nirVt2A4bDSprdB25WYwb6BxY1O94HT1mh4xx/lNB4dBx7aQq7
	8o6GENbC07Wj3Ww2VAwETLfQ0lq0ZUCqBLk+yhaodBnDIxz9vksF/VmlXxEDe21qd/g=
X-Gm-Gg: AR+sD12Vi3F0gw7WXScVS8AkmujNQ58tsyuzxI1MQQUrptMz87DkVzB71IeI7csu+Ob
	oStfl8tm9mYroAvv+Clwtth+pO7uNdityT3LZ22zikiCDs6cs76zP5tIboS73ZqALfbo8MQ9gqw
	Dtb8/UQVmEQ02dJNZlp6TiCUGPzG/vTsuzhU4NAR9jUGDPsav+xvEFL+xRA+qGTmvXiQPvgzRDR
	k116KP8zITt8WFd6bX5kGySzEbWxwOARdBw0WFquAp7FvdHwGNhFY9gHtovvAdLSwFsNSBrQalZ
	dPU/BYhYzr1kLURT9zeWKK3Ax0z3P153ETNhzCKona5YC7NK1fP0NGna0aaIXTRMYddKtSZeQWA
	/1ZqrlbmvhW7QlI8O3ZX28rMT7qLZkY1qzwZyqi1ByIPVpkY+PcWRsvDEuiQqL9ezAHL/nJYLvR
	kFYlb73/2ii++sV1QsCSXKUxKFv3ZvCwgMDOvG5rhJV8EiRzi/4LJ9BCi3pIVrSSNBPs1jw/TgS
	yVFKre3xGNySZDbDALPiyhYrB3epU7L8I0qUFRHAAWzDQ==
X-Received: by 2002:a05:6214:5018:b0:8be:7779:d1b1 with SMTP id 6a1803df08f44-90c8fa906bbmr219810756d6.30.1787657550233;
        Tue, 25 Aug 2026 04:32:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cbbb90726sm12891346d6.2.2026.08.25.04.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 04:32:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wypOG-0000000DpSk-3lDg;
	Tue, 25 Aug 2026 08:32:28 -0300
Date: Tue, 25 Aug 2026 08:32:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH] iommu/vt-d: Fix page table level calculation in
 compute_vasz_lg2_ss()
Message-ID: <20260825113228.GD1449020@ziepe.ca>
References: <20260825080002.117412-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825080002.117412-1-zhenzhong.duan@intel.com>

On Tue, Aug 25, 2026 at 04:00:02PM +0800, Zhenzhong Duan wrote:
> compute_vasz_lg2_ss() finds the optimal Second-Stage page table level by
> intersecting the maximum guest address width (mgaw) with the hardware's
> SAGAW capability register.
> 
> The VT-d spec maps the SAGAW bit field positions as:
>   - Bit 1: 39-bit AGAW (3-level page table, top_level = 2)
>   - Bit 2: 48-bit AGAW (4-level page table, top_level = 3)
>   - Bit 3: 57-bit AGAW (5-level page table, top_level = 4)
> 
> The fallback paths use bit shifts that are one position too large,
> causing ffs() to select a deeper page table level than the mgaw window
> requires:
> 
>   - mgaw > 39: "3 + ffs(sagaw >> 3)" evaluates to top_level = 4 (5-level)
>     instead of top_level = 3 (4-level) when hardware supports both
>     48-bit (Bit 2) and 57-bit (Bit 3) AGAW.
>   - mgaw > 30: "2 + ffs(sagaw >> 2)" evaluates to top_level = 3 (4-level)
>     instead of top_level = 2 (3-level) when hardware supports both
>     39-bit (Bit 1) and 48-bit (Bit 2) AGAW.
> 
> In both cases the selected level is still one that the hardware advertises
> in its SAGAW capability, so IOVA translation remains functionally correct.
> However, an unnecessarily deep page table may be selected, adding an extra
> level of page walk overhead and reducing TLB and cache efficiency without
> providing any increase in addressable IOVA space beyond what the mgaw
> window already caps.
> 
> Fix by decreasing the shift offset by one in each fallback case, ensuring
> ffs() targets the correct SAGAW bit position and selects the smallest
> page table level that fully covers the mgaw range:
> 
>   - mgaw > 39: "2 + ffs(sagaw >> 2)" correctly yields top_level = 3
>   - mgaw > 30: "1 + ffs(sagaw >> 1)" correctly yields top_level = 2
> 
> Fixes: d856f9d27885 ("iommupt/vtd: Allow VT-d to have a larger table top than the vasz requires")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
