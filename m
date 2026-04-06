Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB3539DBD2
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775513867; cv=none; b=qq4MSoKaKhTG91S5N0tBpa6Rwh28hqnygxXIwznL9s7Lknm1GKU23nB/OaKFVVr8UcQfy6U97VaSUQ2d326M/W6wM65Of06whEM9aLzX6cnIl16cD77XMOEf2YtxYAt6F0o9bpzuV+kfI2+iJesRx+UhDDhOHZG7ughO/JbQf/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775513867; c=relaxed/simple;
	bh=IrkSAajzxzj+cznXEX1SlF25o+WZMkFvFr/eXU7uev4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE4JuSsPMJss28SdfvQkmb8p0Lg4r0/iIKgEGv2UTHKxZh/UbZK8JcmZn1ktw3lIjgUtRjuyDcxrkWYONXgUyGhLJ8t+J6GbLEhpW6GXrb5QMZhiNoC9m/i4Ydh/0c2zObZKaKra1Zwb/T4GvMnU22BAr2K6ysx7t1KMtzToLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G+ndm07F; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G+ndm07F"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfd44fa075so573558985a.0
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 15:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775513865; x=1776118665; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qX7VE6datnkTCa6fo3UBv/A39y5LOoYpU+f0cCPRo80=;
        b=G+ndm07F+Jqzo7kBvAO+Bh4cLi2Gadi/IWOotxWT74XMJuyb8fXO/Bskux/EXMN+8k
         2DDh56teVDmIknd7VO8mjVdFH7d87zZ7ihl4bWjpC4isXX19Ynd6DUanbonci00IVVSQ
         FgbLaR/c8wuhYfT1wShuPZup8spbsit6rZdnqiDKTxU45lCb+AhPHntb7oKd945lvOgq
         WXQ/owBlv3i6L7ZOAxCdeJ3vptwuX1sEVVcpbAXyoe3eHAy6jYZLAxQ/xUogklqMyfbq
         A+c2HGAQf5dlW+NoUjkyN9vE/Ke1Nq6BnZQqjB4OUe3XBcupIvmPEuMK7OrCGVQWgpD4
         c//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775513865; x=1776118665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qX7VE6datnkTCa6fo3UBv/A39y5LOoYpU+f0cCPRo80=;
        b=QqjvxxYaxEvYLgHanjACQ79NVB6ODE7Y0gVxZP71YcYlagoHOG1io+svUVJRdPvqnD
         umJMSoA2R5007xyWI0V5HBUi9VLzyDqptZH+lvmFjgd6p/xBE1ZE5GAJe8aHhCsO8oaM
         aZpLF7FBDyfQSjGVXD20BrN4nyg+RHBY2G6UCpIDfWJmiYHKditbv2OCmP2QH+/AtEiF
         ML99xYqELLCClhUqvldLuWr18Bfkhj1xg/VJHabglXZ3eUyuyRTBV6LjDAZiXXiQe2rK
         Qbkh2n5ruCU62H8J+TU7+laPmRwEDNGHJa0oCRi0K08a2W4OF8wTr0tV5EKtQU0/3ZFE
         G4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzPhu1sGKLFDf73oTTimXpUVrzZ6sjZI55+6s78P0bl7Hfml236XV3qrv7IYMmYWe4DYDTfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXXgWsJ4A7KkX4Jmk/GIz66FlERu5dtqVtBVzYuzng/xDqS56Q
	jgV2yxXNqxaUnX6VkoUc2zu36afsJUVh2wCkY+btcTPG5VC2tGFMqjH7SHKHLcSOY0w=
X-Gm-Gg: AeBDietfgqrbWGmiPDmU4T2yueEhbBAbq3gk38WvH/RsqfcWeuSEhlUn+VMGuHdd25U
	QwCmDXNkp+STMQWRAjQf+lTCJd/v5whcHL0hgH3x4NrBq0MBwHlF660kn2ALYQ1csgnGktpIg7u
	I2PACOg4iAKtfFmr7KmzSpJyerzrnjfv1VVFKff8cJJgVS6UPCe4GrYTRNERb6b1eeNUupQ16+4
	03xdTtG7ZJ1lU9sxPOYrw6q02I/cuEtI1IzTZZVsnuJw363rWf/sBLNUW/1kG//xqANGzJfo6vp
	VBEU4TDXnYXmN5ZSFxQTr3UVb5jTDZJ/Wc2vW7XYA1sBfQb3zXhfgu2xe+8E+oneBVCiql3QGCj
	sscZp5EBqZFtZnaHE/oKLZoTmWzEFttymb/6ljFlv/RMrc57dKPj+aM+OE81CcVmHz/BrAlkmeX
	AOBSKcFGYarubEUWAPNHolvPGkZvu+53kcdwFeLCccvIt68EQCObN/43mXuNd3AtBV4grdTA==
X-Received: by 2002:a05:620a:1a11:b0:8cf:d565:fca4 with SMTP id af79cd13be357-8d41b8df4ecmr2084176985a.3.1775513865190;
        Mon, 06 Apr 2026 15:17:45 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8648c17sm1169709885a.33.2026.04.06.15.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:17:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9sGN-0000000E50y-3Hgv;
	Mon, 06 Apr 2026 19:17:43 -0300
Date: Mon, 6 Apr 2026 19:17:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sina Hassani <sina@openai.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aaron Wisner <awiz@openai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] Fixes a race in iopt_unmap_iova_range
Message-ID: <20260406221743.GI2551565@ziepe.ca>
References: <CAAJpGJTzJZ0OgEU8NhyJ3dR1Y1V5x6CwbBjLW_kYLu+FTt9woQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJpGJTzJZ0OgEU8NhyJ3dR1Y1V5x6CwbBjLW_kYLu+FTt9woQ@mail.gmail.com>

On Mon, Apr 06, 2026 at 03:00:36PM -0700, Sina Hassani wrote:
> Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the loop
> body when getting to the more expensive unmap operations. This is fine on
> its own except the loop condition is based on the first area that matches
> the unmap address range. If a concurrent call to map picks an area that was
> unmapped in the previous iterations, this loop will try to mistakenly unmap
> them.

Does this mean you are also using the automatic IOVA allocator?

It is certainly an error for userspace to be mapping to IOVA that is
under concurrent unmap.

> io_pagetable *iopt, unsigned long start,
>                 iopt_put_pages(pages);
> 
>                 unmapped_bytes += area_last - area_first + 1;
> +               start = area_last + 1;

This seems like a reasonable solution, but area_last + 1 can overflow
and that needs to be delt with too.

/* Do not reconsider things already unmapped in case of concurrent allocation */
if (area_last != last)
   start = area_last + 1;

?

Jason
