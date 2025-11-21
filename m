Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D31B4244
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729332; cv=none; b=Q9lrqGqvv0rVROGUlgHC4gfa8XNH+UQvXaI/HvUcPPhmkue+6wcxDOFJTJYcw5TCLUPkqkLSu7R/i0MIHGTk/r0x5yQToJYHRXpj4flPgfyhqzqRLniXW/yWvEnyPXBUKe/Gc7pYO+RNhAj86Tqun4GH6PL3M0nnexC88iwiJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729332; c=relaxed/simple;
	bh=q3o0opFSCrE0Khcf/Y9cgsgPV5wSqYQ+2pJj1FNARHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8NNshkxa0oLsY7Tv+n0UyTBd7DXy4rYi9dPXwa7uPNxukAxRLIrclEXcllKWiKxVC3kM6ZIb0KuCw4ZePYMHejxzfi6fTO44lO1Lqs28YZ2RfXQKY2FuQRclFw0EJX16n25QTmWPQ/3N7WQLCulIDD9IIl2g06+VxCrhhkGU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=c9VxRYTj; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c9VxRYTj"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2da83f721so208210885a.1
        for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 04:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763729328; x=1764334128; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKxuawIRQDhnVKBZ9tPM6EWFkeA1aHb383I6blqc2uI=;
        b=c9VxRYTjNUJ0Gboit1Z0hyVwVqWhmXpdYmgKIYf+TVnPBvTdpg5+bELFtF+fSi11wO
         CbdpINaOubRl1i6PlqhP4sEa43Kxx1hUYZZlRxRnXeoEgLwc169iTOS2A5lczpWQCRMr
         JMo/nVlm5qBr+8Hgb572uaLjZYZmm+O8WgS0Sry/PUIXSActiu6lo+EBWbgMG3CGUBVo
         2eO2lL2E+NY4SbkBD+aNlm5VBM7HaWhYEwcl4O+n1AV61wj1haYNMVeldwIBU6Izfki9
         Yr4xfV//IiYmDuhPwtbB9VV01eD2M6Uhb7isXogx2jeaVFL/dYJB6jmMUPdoANddrDNs
         hJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729328; x=1764334128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKxuawIRQDhnVKBZ9tPM6EWFkeA1aHb383I6blqc2uI=;
        b=XqFr6ocKHek35mDofOG/TZOw22YdDUsaE+XssVFukKlsRH+jMTIuATEaZ/XqlH6/7F
         N7CGMvqw16JJ+lVCJ64hW2zIU/cq++/Kgof1C6KmTA91d7+cDBdKssC1arMf1ZUQspQg
         Ph50BkQgJbk/ILbdsHqnecAUW62B+gPpd0/ISAm3nA7uwS1DB7ZVU9Laa8u5MWUQRAL+
         Azln3VghvJzVWZwq+ZuzqJZS0Zki6Y7wg5FyMdGpuQ9PsGDwjDHrUgK2/RlhZtvKtbtD
         Tq4OQtZA0dGFy39EjoUPPBnNlglwZ4GLStf3xaMCCwrSn5Szkfqw0mo30UM64H3VbiYD
         txbg==
X-Gm-Message-State: AOJu0Yy8kxJnfpFg3lwkKax6d7W68AtziLzDOALZwRIHAnW91fgt5cwm
	bBfVJ0YEzdOwejJwgcvq28INMnYLZG7Ge6KhlnmQPdQvVlJl1B26+TKRb/iAvrbuMpI+6oK0Dte
	tqeMl
X-Gm-Gg: ASbGnctD6UkVmErK0zYOKk52tqLgBozyWHNj9aomKUtGi8OV8ohrqQPdceqEb7S08Ut
	kmxPB+DYJHDizjGSKFozCVU9fMz0fQVHdtHZJVampUhYUqohhdDG33h44jHaVD+R8OF2zz68xI6
	DuYxKqGnuLNlVSeBADho7ZMtmtd/Zq+ggLUN0MaO7qjeWT40nCzO5q0w7pyixskEcyJVQ0AEzFz
	ohUiEGo5lQtIAFeG/d496dDbU6DeeznFwQDJTc0CFa7tXtpB7uGV83EvEBqtYwMxHiWYnR7fSD7
	8bSVZ54Gbw1vuU9Xxw3Xo4jPACnsS8dPlpsHBCmqC4Ws8d5/KINoWgw6x9f0/5FSH+L4H574ZS9
	YXhrXjaR2UA2avdp0IGnzJE2TF+uB5cnBGYPLVinCLh9LC9yilaRKqkg/o1OChAKJTq9QzMQFNA
	EckzlYS61NQpTeFQFybjGh8c87GI5T1IRd7hjhbkRSGyTk4DlR8JzMqzbc
X-Google-Smtp-Source: AGHT+IF+iONji9WY+8SJQ46ZqcmaKHUlc0xIiMwV1PsElknOTLU8GlN0rAvgSPa6CSNNRRwnHtYrHA==
X-Received: by 2002:a05:620a:4149:b0:8b2:e9e1:4023 with SMTP id af79cd13be357-8b32ae1c485mr783569485a.27.1763729328209;
        Fri, 21 Nov 2025 04:48:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c1494sm364192385a.34.2025.11.21.04.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:48:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMQZC-00000001BbM-3f6g;
	Fri, 21 Nov 2025 08:48:46 -0400
Date: Fri, 21 Nov 2025 08:48:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: iommu@lists.linux.dev
Subject: Re: [bug report] iommupt: Add map_pages op
Message-ID: <20251121124846.GD233636@ziepe.ca>
References: <aSAvOn2fgvmF0WYD@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSAvOn2fgvmF0WYD@stanley.mountain>

On Fri, Nov 21, 2025 at 12:22:02PM +0300, Dan Carpenter wrote:
> Hello Jason Gunthorpe,
> 
> Commit dcd6a011a8d5 ("iommupt: Add map_pages op") from Nov 4, 2025
> (linux-next), leads to the following Smatch static checker warning:
> 
> 	drivers/iommu/generic_pt/fmt/../iommu_pt.h:701 increase_top()
> 	warn: missing unwind goto?
> 
> drivers/iommu/generic_pt/fmt/../iommu_pt.h
>     665 static int increase_top(struct pt_iommu *iommu_table, struct pt_range *range,
>     666                         struct pt_iommu_map_args *map)
>     667 {
>     668         struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
>     669         struct pt_common *common = common_from_iommu(iommu_table);
>     670         uintptr_t top_of_table = READ_ONCE(common->top_of_table);
>     671         uintptr_t new_top_of_table = top_of_table;
>     672         struct pt_table_p *table_mem;
>     673         unsigned int new_level;
>     674         spinlock_t *domain_lock;
>     675         unsigned long flags;
>     676         int ret;
>     677 
>     678         while (true) {
>     679                 struct pt_range top_range =
>     680                         _pt_top_range(common, new_top_of_table);
>     681                 struct pt_state pts = pt_init_top(&top_range);
>     682 
>     683                 top_range.va = range->va;
>     684                 top_range.last_va = range->last_va;
>     685 
>     686                 if (!pt_check_range(&top_range) && map->leaf_level <= pts.level)
>     687                         break;
>     688 
>     689                 pts.level++;
>     690                 if (pts.level > PT_MAX_TOP_LEVEL ||
>     691                     pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2) {
>     692                         ret = -ERANGE;
>     693                         goto err_free;
>     694                 }
>     695 
>     696                 new_level = pts.level;
>     697                 table_mem =
>     698                         table_alloc_top(common, _pt_top_set(NULL, pts.level),
>     699                                         map->attrs.gfp, ALLOC_DEFER_COHERENT_FLUSH);
>     700                 if (IS_ERR(table_mem))
> --> 701                         return PTR_ERR(table_mem);
> 
> goto err_free?

Yeah, I got this as well from your last email and already sent a patch.

> Although, why do we need to call
> iommu_pages_stop_incoherent_list() when that isn't started

True but also harmless.

Thanks,
Jason
