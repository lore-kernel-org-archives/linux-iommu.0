Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D543DA4B
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961610; cv=none; b=broQ2619jIr1y+ImZ/WoICfx1bgD10bRzJ59RdKZ0WS6YgJpQkcCS0DKO+IPwuhGSUTJ+nxzJ37HmAanHieUl83rUbbhcsj7nen2X1qiTfKzIFZZdOWFMy1ZFkXsG6QW2pBkt1PY61/fuzP6eE02Dd/vBHbyxU4KDPpBnL/XI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961610; c=relaxed/simple;
	bh=W8h/pOX2A68/AN9GGx/hlGAI45Btx/6RAqn1jjPBzJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WonYFSgQlesnQZjG5q/MXW2Q9WUuLRBxU22RmqWdC4WttVrDCWqyk7xVMX8Sb9h+/4ZVYn0gZ8OlSBxx+WShHgk7hbMSTvkNMwvIHq6gxbTWgrxm4oQ7QpAzzbB6g+jfXsc/qqUe3RycW5hi2hnE7/tVd8cXWlpcUL98DRnK3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=maAQifuG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="maAQifuG"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c2a76536bso32220121cf.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783961599; x=1784566399; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1wy5cjU8bpodUKB+73h1Dg8HOClHzWqmvSatqxWWARE=;
        b=maAQifuGUCGzpZ8RKtKwhvdga5V+cyXFDoPLQ69KztwQy1Ncc/Y9YzkdSvKNrPmHCo
         581COMPcNcnXyTKyBJhJU/h7/o9JiNJZ5IFZQOd2JBBZ5XH7ShsWX86OcHac+8mP9fDC
         QMLd6lucOqYb2EXNAvDNKK6JaXwaIOk0ACyPFejNMX7VNyyyihP8J5+k6ReGwOBlFFj3
         xaDNEI98zMUGlvg3xyzM4Qmd8zmH00gUgch7V1srMgXM5bHMNMKWTdj/4NNEpBwjZg45
         JzBVvvVQTBbpZCSbL0b+OszauDCyH/12ChmUON1tmab3ErfmaqyjGcistM0HsiOlbiXi
         OO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961599; x=1784566399;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wy5cjU8bpodUKB+73h1Dg8HOClHzWqmvSatqxWWARE=;
        b=DtUwqh6YmHVk4rRdecN3AONcxcwn5Xj6VjZnv337kADGZqH1SvFCvFprfE/koohTGX
         2V25CfUOQ6aIpT5qfl1MdBlyMhz1vx0yqyOWNcHs/dS6sHKmBlzJvqhs0yokDd7tkneH
         BwgnsRWWZLj8VHlT1tRM/gf1qa4tNHLiyVSzT+i7cLfcbpguiX/DFBUen9l+0/F7F4NY
         XidCwpnvlR7h0cxhdOvv8gzkJzH3GI5w/iZXgm6+CCemWF2nF13wnpmwMyeAN9qDpgJg
         MOl3V6KMJUJISar9Wg63F+ZqJ1+8ZIzTpk1B9Xf2Z5M5BBN7aQw0x5wlc4Z6zhq8XcPT
         6x+g==
X-Forwarded-Encrypted: i=1; AHgh+RpA4x3Pq1P1uLnOgy92VA+PglORRmvRRM81TKUoN6yAVCmPbq9butANe8/hVhOmOkJCGnqzfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVvdciuCHWKLq5TAhv+gZ63S3Cnowawg647BK6Ua1eJoSWPca9
	mZsLvqKTrahCDy316PDge3gjaO/v2GsWFOz55GlS1g40Klljrc5G5T57kWHs193pTQQ=
X-Gm-Gg: AfdE7cnwnsQC2dQ3xM7OnwfCjkAQ0TcMXGm8cR8oj7G/1PZ6LRhv1cftW5Tp+EVfu+i
	cUvy9qO6edNoD/CSgh95Wjqr4FXqwELS/zwCiLsO3bSlCtYeQOLqEAMIfQyCgeszfxLAj5iKf1c
	2rFlRsw6SIu8RL3KEHmVpIJDPVxshCNu4U226QFnLLwQH2KqRzl8D19+aERZl+XM5fZK3rVZ5i9
	I/HstxiRnu6pWj/gDRygvsVosvGB9coFAdEj7v8kz3SnyFeh33LukRkge1gTwl9C+ycFegsy7J5
	vVpYM+qDNgqLMch9PjHof7wz82LwRmVC5DTeX3Zg4aH9wKv+Sn3odSlRPmUi+qaV8S/O7Yd3T6H
	n+GI1tufXpDW0Lzl4B4oSt2Wsc+i4tsFVAo957iQ9Iv2ElOyEYZDYaIGU1CmL
X-Received: by 2002:ac8:6f12:0:b0:51a:8c9a:8fb7 with SMTP id d75a77b69052e-51cbf30ebd1mr99770401cf.72.1783961598776;
        Mon, 13 Jul 2026 09:53:18 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6e9f4sm88381971cf.2.2026.07.13.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:53:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjJu9-0000000Dd2s-2yX2;
	Mon, 13 Jul 2026 13:53:17 -0300
Date: Mon, 13 Jul 2026 13:53:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	nicolinc@nvidia.com
Subject: Re: [PATCH] iommufd: Fix wrong hwpt passed to
 iommufd_auto_response_faults on replace
Message-ID: <20260713165317.GE3133966@ziepe.ca>
References: <9D652384339C69D5+20260710122952.885325-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D652384339C69D5+20260710122952.885325-1-peiyang_he@smail.nju.edu.cn>

On Fri, Jul 10, 2026 at 08:29:52PM +0800, Peiyang He wrote:
> iommufd_hwpt_replace_device() calls:
> 
> 	iommufd_auto_response_faults(hwpt, old_handle);
> 
> passing the *new* hwpt together with the handle of
> the device's *old* domain. This should be a parameter mismatch:
> 
> 1. Semantically, iommufd_auto_response_faults(x, handle) scans
>    x->fault's deliver list and response xarray for groups matching
>    "handle". A group is queued under the hwpt that was attached at
>    fault-delivery time. old_handle is fetched *before* the domain switch,
>    so its group lives on old->fault, not on the new hwpt->fault.
> 
> 2. Historically, the first argument was "old". The routine was
>    introduced by commit b7d8833677ba ("iommufd: Fault-capable hwpt
>    attach/detach/replace") as __fault_domain_replace_dev() in
>    fault.c, correctly calling iommufd_auto_response_faults(old, curr).
>    Commit fb21b1568ada ("iommufd: Make attach_handle generic than
>    fault specific") moved this into iommufd_hwpt_replace_device() in
>    device.c and swapped it to "hwpt". This should be a refactor regression,
>    not an intentional change.
> 
> Fix this by passing "old" instead.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Fixes: fb21b1568ada ("iommufd: Make attach_handle generic than fault specific")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> ---
>  drivers/iommu/iommufd/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied

Thanks,
Jason
