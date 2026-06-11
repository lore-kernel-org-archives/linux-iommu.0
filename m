Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDFC3A3822
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178780; cv=none; b=lPMylAI8qL9qHqP38VR3u/+DUVAahsS6ZEcC2m5CIJnvGtlDEi+jCyEpkwa8a5wDXYLq73HHFQsTL4GlD1CdOjR6EoKOB/Jh6o1f7Bynw5XgNe6eVUZUQ1T85X7KtErWEDcmDFSdoJixdNtJaOkActQIaGo/NRLy+Bl4zAeEjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178780; c=relaxed/simple;
	bh=WUyQGEg3IhjjI903PicK5vtKZGQFTCTKRuYYQ7A3Gfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DefBYl59XVTZpS8zy1ZGvViysL+vwx+/Fn8+55itutc+CwcupvUEekHrL/Jr6DDiUNUcUxRlTtcoEkvy10dsKZvrcGnDHyzKLdWSgr3UfHaBmbXIGb41Rg1QmjzgccPXiQq+VjYFY00tQGozR3dNePrTryG+kf+8Xlq7Whya61U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NGbZp9PZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NGbZp9PZ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9156b74006aso566857885a.0
        for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 04:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781178779; x=1781783579; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LaGF/LBsgX/NMMW/EFlhJVd5spivYjK32XED/7Qltow=;
        b=NGbZp9PZgQFFc3Cx3W+P5Wev/arTMNvlJCtbMjz5WtKN3NiORHiBMv4hsPP0gItZXK
         rjnUj+6zgIMMB+8ZZOk09BLkQtA4Cg9fe5gTZO4cIAuLj9w1VKU+ixYHVt5gzeTNtGre
         R75LpTpyhMMdvKWY/RoI9cMHAdIz9fQcGDc+zxvIZkJ86xknC89jykkWODxvWtFw3XTY
         PRzbfa66PoBtz0MqniBlOtHQfXQjde958UqwVkiuBa5PmVwuQ6sSlS8rpZtbyL6OkagH
         Cg9ueb1kr/5SI9tdRg0vAsy13LSn9oie0VcKWAyoexD44Fp+4yJe0qU5fYALCmJAGqV2
         yhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781178779; x=1781783579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaGF/LBsgX/NMMW/EFlhJVd5spivYjK32XED/7Qltow=;
        b=Nd3n1j2+FDC0fYrY4O3KCt1zg2yg91ppCE8BmLHXuf8Q7kxWab8ZSDMArUPKx+sDXq
         E0KE8We5jnvyxcwGiIzTtFDcPBIYrkVmfaDjDLDcz2KX4fkzTz3oVzJ+6y+qvpSFz5aP
         5QdyV0GXr9vwXualBBUiMvojPwxuk29EsHBYTZF4snyhjlf/ZPTRMZZV5UaFlXx48qD/
         gPT8N8Ckpjl7JdwL9nyjwtrWeBRAQz7RTixzjKdBDFZSqWZgFT04B1V5uARFTEfXy5hg
         /BZTnkD3i6g2YHYBPHpLPymgWVnGRVaILTKZtLUuuaW7lhyACxm8B/9vp0lIDTmPF3wC
         6dIw==
X-Forwarded-Encrypted: i=1; AFNElJ84yPRZFtzf7E2val/evasfuYHRY1AY/7JKkq139YGjF/26UqKBrBXNlldNwovJQ3EjDc+8zA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJRs1uZTX8AR6n0GVUIua48h/wpGrpb05WFoJU8aGJP550b3rS
	/OAjTVhEUzJZretMUxAmBT9Z0pjhU0W/sJBVqeHwUBpe8eZncuOYaOWnVVvjpF8sfSo=
X-Gm-Gg: Acq92OEKYnwxFkxdvSEyOveMPqEhZiwEuxWl2P9f/0qOjEYNGks+6Hx14wqwkbG3f41
	AxX2C7VaOLyd4B7nk0ZErmtCBupu5v552kjzENS3X8C8p35mdwtr3avSedX7GEcyYe9douJzC74
	y2XvGlTbo0soHe/sX209Cjus5q9d0LLUCiOkcIlaBbt9XxPpQePJsYzRGuyPvhHNww7jrTZk8ia
	VIhagJpgVTpAkLk3DrHOqWaix0xwsoPQyyA58j5zncTFG7l2pqICmXOP2bem9wq6NwYbJvb/bsQ
	WPXVlNNWZwezhxhw4ZNmk2nYPEuLgOTYpFLlpAX4cnWn1ILyGmzT5IZFgAW/+9+umezaFkvpFiX
	qMud8Q7iAEeNT9m+hceP22x3avnFUH8mAd80KwxjfvhBw/3yKXM5pFezWAsOi6NtGZJWIagCp//
	t4NSexgVd/JVaUIvyiMgB3+oa7eeKWVS1WljyJwMWNovmG/wWNKU/w062c26OsoCcB+boUACHKk
	BLDJMmPJvddYSIg
X-Received: by 2002:a05:620a:27d4:b0:915:fad5:90a5 with SMTP id af79cd13be357-9160ad933fdmr349598985a.54.1781178778581;
        Thu, 11 Jun 2026 04:52:58 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1eaf99e53sm15615096d6.41.2026.06.11.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:52:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXdxx-00000005gee-1rIy;
	Thu, 11 Jun 2026 08:52:57 -0300
Date: Thu, 11 Jun 2026 08:52:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Clear Present bit before tearing down
 scalable-mode context entry
Message-ID: <20260611115257.GD1066031@ziepe.ca>
References: <20260528025557.3209367-1-michael.bommarito@gmail.com>
 <b0278f4d-681c-4731-bc8d-130a56e6d935@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0278f4d-681c-4731-bc8d-130a56e6d935@linux.intel.com>

On Mon, Jun 01, 2026 at 01:35:08PM +0800, Baolu Lu wrote:
> On 5/28/26 10:55, Michael Bommarito wrote:
> > device_pasid_table_teardown() zeroes the 128-bit scalable-mode context
> > entry with context_clear_entry() while the Present bit is still set. This
> > creates a window where the hardware can fetch a torn entry, with some
> > fields already zeroed while Present is still set, leading to unpredictable
> > behavior or spurious faults. The context-cache invalidation is issued only
> > after the entry has been zeroed, and intel_pasid_free_table() then frees
> > the PASID directory pages, so the IOMMU can keep walking a stale Present=1
> > entry that points at freed memory.
> > 
> > While x86 provides strong write ordering, the compiler may reorder the two
> > 64-bit writes to the entry, and the hardware fetch is not guaranteed to be
> > atomic with respect to multiple CPU writes.
> > 
> > Commit c1e4f1dccbe9d ("iommu/vt-d: Clear Present bit before tearing down
> > context entry") fixed this exact pattern in domain_context_clear_one() and
> > the copied-context path, but device_pasid_table_teardown() was not
> > converted.
> > 
> > Align it with the "Guidance to Software for Invalidations" in the VT-d
> > spec, Section 6.5.3.3, using the same ownership handshake as the sibling
> > fix: clear only the Present bit, flush it to the IOMMU, perform the
> > context-cache invalidation, and only then zero the rest of the entry.
> > 
> > Fixes: 81e921fd32161 ("iommu/vt-d: Fix NULL domain on device release")
> > Signed-off-by: Michael Bommarito<michael.bommarito@gmail.com>
> > Assisted-by:Claude:claude-opus-4-7
> > ---
> > Found by static analysis while auditing the callers of context_clear_entry()
> > for the same teardown ordering that c1e4f1dccbe9d addressed. This site is
> > reachable only in scalable mode, so it does not manifest on the legacy-mode
> > hardware available to me; I could not trigger a runtime fault and the change
> > is verified by code inspection only, on the same basis as the sibling fix.
> > Compile-tested on x86_64 with CONFIG_INTEL_IOMMU; no new warnings.
> > 
> >   drivers/iommu/intel/pasid.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Queued for linux-next. Thank you!

What happened to your work to move over to the ARM updator that
doesn't have any of these bugs? :)

Jason
