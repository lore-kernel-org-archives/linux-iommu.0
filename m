Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351A2F2617
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106282; cv=none; b=p45zbr4pupUUyMpjgY/jVsSxsPGnMAayzDnnlFBw4yKiq8pdaT4n/SEMaYoluIdYzm5NslLdteH54EzCnl28UFvQQWtHyeQMilZ9uyTzKoCfDllvMEmk5/nvduXGS2RIv93tuAkB6LhQaThXq9CX24Aqs9d7udGaaPql09rH+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106282; c=relaxed/simple;
	bh=FypwSt37vG1md4KKEG5AIsIq7ywXjB04LKNgH5d/XI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTPT8UzpmHEXUEKFJsW2rV1PtRXLmBCZoDWMNBREBPUCFpqvyujEi2xcUXhvCfx32P4qTRgWVkCE4XzWSwTsMeKeO6dEH1SaLE4lmzyKNwCeFOCbD+fkIgbVR2R/V9bnEfb+2pUfr88FXytUtYgz/Sx4R7r8swSRxXr30vn4NIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nWU9zgkl; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nWU9zgkl"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7946137e7a2so23900796d6.0
        for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760106280; x=1760711080; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7iyPHKtQGvaoZRtoo396PCUKbJdnxgn+DD5EY6z9BQU=;
        b=nWU9zgklAgjGDp5IZAk2sed3GoepzAjT1dsyuT3CrfR5y0JJniW1t5gxKyzU7MjB37
         ZoVwAd7/PfsxC9CjxAHEplxlvCHgBtpwsb1mdoHVM3651Zurdstl5s0A81cAfmU1mpGj
         NgoHiw1K/VGHz2noaa5OeFmCfUiqY4U5ekWgX64kpNccXn1JtFP8EKzeCEhiZu/Im9qx
         YYrxVKX+7yNZyBaOWy2FB4aRafcph0mKauR0n4Ito31mVG2581NAHKZBixG6ShsYauXi
         aog34Kj1Lcb0rltOKKREut+USXDAADckctPD1XMAEd050USdvnIt3eOiTEKLKh0LVobH
         iTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760106280; x=1760711080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iyPHKtQGvaoZRtoo396PCUKbJdnxgn+DD5EY6z9BQU=;
        b=RvrbM+zyf6ehvfNR2KdNspA1V7UhwRVgASs54U+Gx6jXtuz9MpTaHTyVOpLAg35Pds
         kVu6LD4iqK3vW9m6kVbO1hjDGCmbVWqd6keqsHvXAsp0FOjdbz4WeN8M3ZcNOCa1eq1d
         VVNzrSNJiz7bZgokwEIvD5aVFYSXrC6u3HEIfqwlnbgwPtT9OAte+zrXFWQkAdqitDZe
         yz2U21YDv6RU+X7VcwGtRLq5awjWN8w1bteBJuEs3AN91TLMcUzvMrDbuMaHq65dtMyg
         8uyeGhonzYvgwDjziYHw18L2OOjraJqo1sA1Xhmjtz+nthHpcAPLgntMhXI+fIiNd7vV
         GZVA==
X-Forwarded-Encrypted: i=1; AJvYcCVo5y1k5wPLr7E0Q8ry3BYFhciUgQ3k2uz1EQ91Vjnrfwgfw0a/fQ5nNGWKLtkx7sAB2eoghg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuVsOWaFc4d31q5SLUme91vOhTNgMAlYqDc9laJmyPteLWAd61
	igaQxyqmD98DpC1OUWkwrn4SCLwV3SaLQNyVgNMQV//lLydD1KIL25dqYx9lBju/qGM=
X-Gm-Gg: ASbGncsu0YIcsFKSTmOidqxzgKoEMMtYhtHdZe80HN1BuNhMu43F7fSwSes+1J4jfuA
	KZUzyBiwB3CRH0Wg2bE/9fu4+Bm8cVSbWXnKwHOjwC3QSEE4I1kYpWAi0QBgvN45ZL/XInBVnoH
	DTwrzuu9/wMDHvjabPuZ1ORADbf9TlmkI/9jrAjSkfV8/+IE9GKrnKIfEegZSuxNs2H8W6O4M41
	bOBGd7TKxumEq6RjwRSvJg+e/maHGrSP3onIiENjW/ZQw2PDJRKIHLwgPaXVMmOcoiDCFxlJ6j1
	4ZyVg2qhW96A9ixPzMJAyv+M+qqYH5j0US5Q0rrVa2gkDFalaYW667oGETRaOpi1d6ims5IQWto
	02Zdsd6afxkrFBzJk32UaaR/yjFO0i5k1ZhsTKLxTh1zsHNzOs7a11Z2NgWLNH5zWiYi1Av8mq9
	WoJYVR+eh4xJioLTN5aE0MMNXHdBGzJZUD
X-Google-Smtp-Source: AGHT+IGGIljqRupcyKQ0pYTnR2I4bYgZq3r4A5q2oy3k8FchXGU/tlrboTSpOldoH1daTEMHuGVvTA==
X-Received: by 2002:a05:6214:491:b0:807:3dcd:bec5 with SMTP id 6a1803df08f44-87b2f0327e0mr148115976d6.61.1760106279689;
        Fri, 10 Oct 2025 07:24:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc345da73sm17323946d6.8.2025.10.10.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 07:24:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v7E2w-0000000GVkh-1LAr;
	Fri, 10 Oct 2025 11:24:38 -0300
Date: Fri, 10 Oct 2025 11:24:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251010142438.GD3833649@ziepe.ca>
References: <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca>
 <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>
 <20251002173715.GH3195829@ziepe.ca>
 <CA+CK2bC58SLTrROtBQaegzSfjU+bwH_3pjjWdd+JTnHqQPuAwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bC58SLTrROtBQaegzSfjU+bwH_3pjjWdd+JTnHqQPuAwg@mail.gmail.com>

On Thu, Oct 09, 2025 at 09:28:44PM -0400, Pasha Tatashin wrote:
> On Thu, Oct 2, 2025 at 1:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Oct 02, 2025 at 10:03:05AM -0700, Samiullah Khawaja wrote:
> > > > I think the simplest thing is the domain exists forever until
> > > > userspace attaches an iommufd, takes ownership of it and frees it.
> > > > Nothing to do with finish.
> > >
> > > Hmm.. I think this is tricky. There needs to be a way to clean up and
> > > discard the old state if the userspace doesn't need it.
> >
> > Why?
> >
> > Isn't "userspace doesn't need it" some extermely weird unused corner
> > case?
> 
> It might be a corner case, but at cloud scale, even rare cases happen.
> For example, if four VMs are resumed and one crashes while retrieving
> half of its resources, we can't simply reboot the machine because of
> that. We must have a way to recover the machine to a normal state,
> even if some resources are not reclaimed. I would say that finish must
> be properly backward-ordered, but we still should release resources
> that are not reclaimed during finish, as well as those that were
> reclaimed but later closed.

Sure, but as I said, userspace should deal with most of this, and I
think we should lean into the worst error flows end up "leaking"
resources. They are not actually leaked, the luo still holds them and
userspace could still try again later to restore and free them. They
will get cleaned up on the next kexec, and kexec to recover from a
partially failed kexec is not an unreasonable plan...

This means think carefully about the userspace restore sequence so it
is more reliable. Like don't restore the memfd as the first thing :)

Only if there are real measurements that this is not sufficent would I
think about teaching the kernel to do a non-restore flow where it
directly destroys the object in a way that cannot fail. Eg the memfd
can directly free the page list instead of allocating an xarray. This
is alot more complex error path code to add to the kernel so lets not
do it without a strong justification.

You also can't do it until something sequences the vfio and iommufd
parts to unfreeze the memfd, this is very complicated error flows as
well.

Jason
