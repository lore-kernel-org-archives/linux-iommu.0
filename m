Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0C374E42
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082852; cv=none; b=Nt8Pz3tmZ/n5d2U7tD4xo57BCgr1o/s4rkr/FL7E8hz9cUdat2KO9EjQd7oMD/PZ53TcN2clJQgeEDqjjRRHEbh84WNLQkFg9Hq/SzlPzf/xFgz7LKTCGGCAM1CrJ+eLJ7NPqQ2sn7PM0JXlXOhSO/f0b5sG+D4n9fxrInE8ufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082852; c=relaxed/simple;
	bh=weMclR0JbsCcCqPg/uiyIcYyJq2ObcwTZTr15YLIsZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPiQ5yL06YsEQmqawzuQRbd5xF73f/tu8GQt0Im4knLx41SnHpNg+JL7UMuTb628OUrRgvYBMfFojzYyyhpq8drPhEaPAyocktFiPQFh6usIWOrtG3stagAEqx2gWiDtcggzyrNp9+cU2sj4P6gsHOnDbAgJRNT5js3pLOH1Jhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cpl7T3TR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cpl7T3TR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf27856f9cso24448025ad.2
        for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785082850; x=1785687650; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xYJV2WaFKQ0XZvcTBC+xPmoK69d/4/DPGZNWJ9OK0BA=;
        b=cpl7T3TRkh4LUt0OxthsFe41Ju51w6Z6WIifTWhQ2IrmD7e1AdMkJnTEP+KmeOvtfq
         ptIRTxIMyj8tuBKPy9Q+exfibavPRGFZE2IoZ+YoYq+doPBGx4Xna4gP7ZkjilmgPUAq
         OIa36OxHxmDHOc/d0V2d35CX3CX0fcgE0QE94XUt1nEjdvI7enbY2dLU8+x6+/FJmtdb
         1hXqEIUSVkXQkyS2W2wwcJhTD0kbvg30tNiHhis8xsUN5+L0ffQf5gix/W+TdHnSpnKf
         OywbliT32FzKtYmIABnoQQ5+RgQGt/PJEMVEGwJjkyXpPKryaLSOR00gqRiW5LCa+kn7
         NWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785082850; x=1785687650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYJV2WaFKQ0XZvcTBC+xPmoK69d/4/DPGZNWJ9OK0BA=;
        b=oJegKGixn4vrdH7M0Iqn3VXuazLMfCSiEYeI4RfWIzG4L4Te9xX0wefJPTnwpudV5Q
         dtoTArPr5aWpVRDUDz7Ym9lRTmzDodB04u74/cin8Ux+D9V5TmW6PvL3ZnfPZMvkFfqe
         DxJo33oVFbkFCtkg1TqvlKF40vZ/CGexRoWxwb7b/QdFQ7j7womdUbW1EJhN58XVjg4C
         ltKKOHAqIq7REFZx3l572nIi2OjlnHDLyCKGOAt9Fl0kArpo4v7XkQH20ibR5lmTEf5N
         eB88+vKFfOBddq4zywM21QLLBSCGrw9qT2vNL/WNVKPVCpPcs9Vy4V16HV3G2u3gOwok
         IPcw==
X-Forwarded-Encrypted: i=1; AHgh+RpDKhLWh6sb2emQzUZiwQ/FF9gc/v2trtn0EgmvDC5VLvk7TjysKx7ynvqWzeCuHalQiVD/cw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw99kxnDlZof1hf7OwS9g5yK6mWngH/XnNgGEBhp+XeGE7WFGSv
	79J6ZjhZ3gQlaHrQH28lBYt5VKnf6v/aeNryHozRddwpbYdv3Up93RGEvwgKtEvLQu0=
X-Gm-Gg: AR+sD11AQDAWDx7FU49hx7WnUgJZsaphFDQfuef4AJnI6HFd5PulS4/vbRBoQbpTxUG
	TvdfMgmGeX+1hJTtzH/hpiT9fDYgJs4grILdXIS+cOXGqCdSDzRgQ2anQqnk+VvfBoBiULxJESH
	vW8ZVY1FJs6p2RvoiHbl3qm9zralntalb7bZ0+dzfY182s5SsCq1cdLJQaq+KrCnULOBSnTkEqF
	IeXXhWiglPCFwizGd5vxVMidPnnUfSlwCCBonVu6wNI7QDQw83P8H/dJIhCWl1Y2C5GLT6nZYD6
	U/9eFe47tjHUJtkiETG/gOEbnJJz2YVf8DktZvJDchalxACfkF3LX2HaM4xtTlCnj9Cnpv1eS2/
	X4g6whh+ei6/ZtLLPsf+NIPDeaMABSlQJvhf0zhuureWpbc41TLI=
X-Received: by 2002:a17:903:98f:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2cfde68785bmr51728885ad.5.1785082850240;
        Sun, 26 Jul 2026 09:20:50 -0700 (PDT)
Received: from ziepe.ca ([64.114.68.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81cd27sm22021795ad.79.2026.07.26.09.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 09:20:49 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wo1ar-0001SV-DZ;
	Sun, 26 Jul 2026 13:20:49 -0300
Date: Sun, 26 Jul 2026 13:20:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: joro@8bytes.org, will@kernel.org, kevin.tian@intel.com,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iommu/iommufd: Fix IOPF group ownership UAF
Message-ID: <amYz4X2N8bD0eZj1@ziepe.ca>
References: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
 <20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
 <3CFD314D0FE4D7EC+20260720085017.3998878-2-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CFD314D0FE4D7EC+20260720085017.3998878-2-peiyang_he@smail.nju.edu.cn>

On Mon, Jul 20, 2026 at 04:50:16PM +0800, Peiyang He wrote:
> iopf_group_alloc() links each last-page IOPF group into the generic IOPF
> pending list before invoking the domain fault handler.
> iommufd_fault_iopf_handler() also queued an accepted group in the
> IOMMUFD deliver list without removing it from the generic pending list.
> 
> When detach or HWPT replacement drops the device's IOPF reference count
> to zero, an IOMMU driver may call iopf_queue_remove_device(). That
> function responds to and frees groups through the generic pending list
> without removing the same groups from IOMMUFD's deliver list or response
> xarray. A later read, response, or cleanup can then access the freed
> group and cause a UAF.
> 
> Fix this by dequeuing an accepted group from the generic pending list
> before IOMMUFD queues it for userspace response.
> Make iopf_group_response() send a response regardless of pending-list
> membership, so the dequeued group can still be completed by IOMMUFD.
> 
> Closes: https://lore.kernel.org/all/B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn/
> Fixes: 34765cbc679c ("iommufd: Associate fault object with iommufd_hw_pgtable")
> Cc: stable@vger.kernel.org
> Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> ---
>  drivers/iommu/io-pgfault.c     | 24 +++++++++++++++++++-----
>  drivers/iommu/iommufd/eventq.c |  2 ++
>  include/linux/iommu.h          |  5 +++++
>  3 files changed, 26 insertions(+), 5 deletions(-)

Applied to for-rc

Thanks,
Jason
