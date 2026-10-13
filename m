Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5351C328
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904502; cv=none; b=SiWuK3Gypp5T3Cn+ix8/4I9P8XbZsnrUznB02wOP0vvAdzRvZe9Xn3SrEWcetMJZiQVnBPNzqtWdxAUFakzNwA+/2M1MPIYeWRmvrSvLkDmlvmbBY/8f6VVB9lErex0YkR22sLcQaoylOS8CnOX0AbiE2rU5cG/buJDuJ6rW4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904502; c=relaxed/simple;
	bh=VgO+C+8KDYSTE6ugGfRNQKKkE0G27if6p6FDk0jABBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6u7xQbaT2hbHrQfmlzUiXshlIsZ5/y9nylrIi73+pglnIngATzwubG3hXPEVTJEIlnXHfn00Le8y3fBhUZ1GSm5KsxltxVrXnUxohnXHlZHxHe/kmfM38b/VUMqv3UYzYnsMQmFYioXJv796X5WKeSfWIxqJJyqkr1Vr5Zaivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=El+ca2I/; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="El+ca2I/"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5338f65913dso35289571cf.2
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1791904500; x=1792509300; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Kz+IQfSF4Bo0R4irbQAkdmm6GDBbYpLf1oqZAlKJ38=;
        b=El+ca2I//xQThyHGyG+VxaBZeRGw2NwGEgVToFRJktjWwzjEhDTh813m1Lv9kuiuW4
         j1a/zHHyKwr+ijJZH8+6q2gUROj0nnEpIcGj1eC2vLpAdglfjiOiVc2XVh5JZARCj+gx
         jjbQY3IMR0ZLJx2of+LC0XQ5LR6KbeHZWDQ/owK+113W4M32YepIi5hMSD6DPzsHqhBb
         byB8zMWBYSIRBzCpjp0Y0iLnvwuyFjrb/h26nCdMx4ZkCr9rqBrk9d3GsJT+dRmjA7pg
         VfXKi5rz41plLClKGGkKNgZDb2HJXHz+VXtxV+ErhUzHJqcy44tgkQos5+Ues6uYmd2C
         Wk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904500; x=1792509300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Kz+IQfSF4Bo0R4irbQAkdmm6GDBbYpLf1oqZAlKJ38=;
        b=s09bBFqhpD4zx62Mgo/jXaDqmOVHEVLqJU26KfmcrlK3WNPHlKUW5N/Imq3LFVczOA
         7l1meSLmaeEpO6xPVZEM8pbc4tyS5FUWQ5iMgtX7C3OSMil6g63kdbuPUfvzWMxwMM9W
         C5bo6xbwHXzhoNL1jOKpVNwbrSbpw3j/qn5ZXmPMwwDScHRGzXuiM73jNr8WpvIvl7XE
         qEpPaqshy4X5WZeFGKG/JwhGtCZvFy1sJgBvCGlYR4iF1PLjl1feFrb767PsPgNs3R3G
         muzUga4E7JsZdVUaW4TAiiHaBpt7DKm64MTpWt4/v/xE9IXQkF3wCaLoDUysGtz8AVbU
         heCw==
X-Forwarded-Encrypted: i=1; AKwUvByGt2uwmKclMNOwOX4nHw8WjhgueCSWQonjnxSjLgmDwu7NkBLv7hjy9SjvtS9Ec1p/1PzHHg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIUANHTU/IpMY+xTfi/pBTe7plU/8g6WQuyeut8H51IjPQ1PJOC
	YpDd8E/olDidIsmGfqkOgBtkEmttgZFg4Wqr2l3hjL3Mf1KWyDmJX6SkukCroxstpyM=
X-Gm-Gg: AYBFou0p2DFvA2pNRQwFGxpnwx1EV1aHeT9WEc1Zsid5T5xLj4lswH08xbaP7q281gd
	noa/EoPkVLiPvhz2sw41+mtU4sLxrbtJbahsfH+MJjuth0+7WYoZUgv0mjj1MdG0aqln1okjhY0
	LKoeoWKoR8YAeynTtZb7ORWC01CViuxyJriw9smvJyz1vud1fjUckT13G9GpH6bwCgVwiord/v6
	FzcNl809k4z6yD7yzoxP8nz/hItIGHvDfrF4tXHWxyQdscs9EFCgkN5VoUUWfrb8xlEsmgulhBS
	K3MG4nxdGpjPy4GFkv2AScyoTE6ibx7z7gZQREq11yHjuVu0Zl3rl/xAQ1SI0jquJMi0G0FX04B
	6TFIB7FJvE7wWTSZsclvaLzpVLim9PoUYamHLFSNMzMolnyDVHNKjCi2MvVVtZhRgE6jLsdjSxQ
	UGKdhZIw6oT3V1TzJ1tGxc7xvXX7Ptj8KPCGMTQCDIfAbDSQx3mwJO9zXv3HOLeg3mnZjsun6cZ
	xVEw61n098R1PTIhsBgkEbc0j8sBXrRFvO4L6UN9gw7l2PJuxO9+2GpE/OokiUExGc=
X-Received: by 2002:a05:622a:e4d5:20b0:535:a5f9:752c with SMTP id d75a77b69052e-535a5f97acemr137130051cf.75.1791904499634;
        Tue, 13 Oct 2026 08:14:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7e32cesm100542321cf.28.2026.10.13.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:14:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xGeDS-00000009ss0-0PwU;
	Tue, 13 Oct 2026 12:14:58 -0300
Date: Tue, 13 Oct 2026 12:14:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <20261013151458.GL14213@ziepe.ca>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
 <aszfVNP6DGzWYdK0@shlinux89>
 <as1zR1wc7ERxvR1F@nvidia.com>
 <e8c22eb2-ed1f-47c7-b2ac-c56ead1cba8b@arm.com>
 <20261013124400.GI14213@ziepe.ca>
 <as5ERENDfgC6FB0b@shlinux89>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as5ERENDfgC6FB0b@shlinux89>

On Tue, Oct 13, 2026 at 10:46:28PM +0800, Peng Fan wrote:
> Hi Nicolin, Robin, Jason
> 
> On Tue, Oct 13, 2026 at 09:44:00AM -0300, Jason Gunthorpe wrote:
> >On Tue, Oct 13, 2026 at 12:22:06PM +0100, Robin Murphy wrote:
> >> If we're not going to support PASID for shared streams (which I suggest we
> >> don't...) than we shouldn't strictly need to worry about CD tables anyway.
> >> So rather than having to special-case CD table sharing for shared streams,
> >> perhaps it might make sense to generalise back to a "default" per-domain CD
> >> for non-PASID use, which can then get switched for the private per-stream
> >> cd_table if and when a device does enable PASID?
> >
> >If we have stared STEs then the group becomes the per-STE data
> >structure not the master.. We don't have any way right now to do that,
> >but it would make some sense for the group to store the shared CD
> 
> Thanks for the detailed feedback, reply you all here.
> 
> For the CD table question: since shared-SID masters are in the same
> group and always use the same domain, the CD content is identical.
> With skip_shared_ste(), only stream->master's STE (and thus its
> cd_table) is active in hardware.  The other masters' cd_tables are
> allocated but never referenced by the STE.
> 
> I see two options:
> 
> A) Keep skip_shared_ste() and add arm_smmu_cd_owner() to redirect
>    all cd_table operations to stream->master. This is a minimal
>    change that works for our use case (platform devices, no PASID,
>    no domain switching).
> 
> B) Drop skip_shared_ste() entirely and share the CD table at the
>    group or domain level. This is cleaner but a larger change.
> 
> I'm leaning towards (A) for now to keep the series focused on the
> simple shared-SID case.  Would that be acceptable, or do you prefer
> we go with (B) from the start?

I think the skip is in the wrong place perhaps?

The group is always guarenteed to have all the masters in it.

So we could split them into primary masters and secondary ones. The
secondary ones are all the devices thare share SIDs with the primary.

The group list is guarenteed to have all masters in it, so we can
simply fully skip attach from the secondary. It is guarenteed by the
group that a primary will have already attached to the STE with
exactly the same domain so the secondary just needs to do NOP.

If you do that then all these questions go away since there is only
ever one thing writing the STE, it is always stable and no issue.

This does leave a problem for master remove to switch the STE to one
of the secondaries, but that sounds like it could be managed through
the release domain mechanism, just nominate a secondary to be primary
and execute an attach on it in the normal way. The hitless STE
mechanism will make it work safely.

Jason
