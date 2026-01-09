Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BC1DDC1D
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989188; cv=pass; b=oq+7xRwV6fuPSybDgUQT6wr3M/sJJnwCuK8D3o+SSQ0vR43C6vof5ivEnaNmDAGUw4u5wAT9MlW+mX28Yj2pOjtRbtGubDlLf0VEPnPdDfFhTGl5El6/S8wguIa016RAPbMfK2/8H3br6JMR4UauV1raupOiNoxkXszhUZw49gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989188; c=relaxed/simple;
	bh=lnIUJQkxS9Pwv0vAZpiGY6C+0KRrIsW0ImsiyQtadNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNhlc1LZSlEJ970gU35TszwnlJv9jHUidOws5CzcYov3hXYTapBqKcekKURi+QTQOd55vSjt3O8+OaUAu9igEMAnuEBtNqXKoUfbFoV1YHLDVPvkha8vgFjCmvnweHE9nqqqGTKUHTv+Hv5uOvdO63CGkqDS1JcFf4q6rDr0Q0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUuoZMBT; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUuoZMBT"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee147baf7bso16591cf.1
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 12:06:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767989186; cv=none;
        d=google.com; s=arc-20240605;
        b=Gy/IbQNWr7qV1TFZbdv992MdRvmwBPBd+1TaQRsZ276gVsoadwNS8mK6hcZK+gkWoZ
         7/LcD2XKKQ2WLfDGKHRMIS7tu2h/uLpYNJ9QULfBR21Yefp5jMygYUKxyOoop2bXhT2d
         8ma9jRPUj6ENepUSLHK2+YOiXC/MlNKga6aBcp4AgmJS2rHEv3Isthz/McYRcf4i5vYa
         8mRODbvY5tpP+1Xu3RZuXK99QVXdK0wNWyYvZT8lOyKXRLY0Nd8QRuCj1Sv8RXacuZw5
         pMav61qI7nwEUmT3NMy3X3nqyzn1LDt8KptMbW3szSyOUDlYuu1h1Vma2q9lLmSabPrq
         cpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3v9Ac84hXSFfPtALk5IIwgHNdB2cCIMVGKjZbTXyYLE=;
        fh=u+7l5g27ZSP0ecxOs7JdXvqD+uvGIUMjp5piLzyQvGY=;
        b=QZn7PCaHG+sxYkSRRFm90W2NcvdiPhC8qb2OM1q01NppWnmhwuvB22h7DTeOO25aGw
         oRogT+r2n9XytrFmnmFOZfw4V1RVBm7sJ8KV38VjgDJ3tiBUv6C+5zScwI0s0OSL8ASa
         JV8uZvQUimN+eAzvlcFMDHSDCwa/G2RFkIfZCReLWYMgm/CfcXXbo+x0naXtp/7CxvKa
         Vb2QUrFrPxy/N/0q/87PtdZsXiibrNImnJvq00g43989BwSHw0gK6JKX5oNtXdgSJjJw
         pgf5642N5ngnPhmW8onViXgnQliXkNfG/7IOgg+7D9sdK28lQuziRUSN27u3UrXU8KUK
         ZFFg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767989186; x=1768593986; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v9Ac84hXSFfPtALk5IIwgHNdB2cCIMVGKjZbTXyYLE=;
        b=lUuoZMBT/kPRvTL4eMyDavFSUxFjPu2vx1iXBnqsilum7WEEU7XTmanix/0SqKah21
         cKB1EVHklegTzzFYUgqKa8wffwfjwbr/Yi6LWs72605ec8Mkut3wK5x/JLHKCxSAcIFi
         mlWzDMi17miIL9p4myLxN4/Nwwrb6KSzw73GKQX5G2ozHvk90XausByX+p26Jb1Qvd3w
         j9QWgbHvMa9XtG4siEfmHjeANi6MxQJjxCkRXMVl+uZKUwh89sx0ZvTttI7Ajax0wNmD
         T97neV7gy4xIljXElomkJEG21h+94ZjQPsYJlX4ak+MRThHJG1B5pXa393m2MsD/kQgu
         3P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989186; x=1768593986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3v9Ac84hXSFfPtALk5IIwgHNdB2cCIMVGKjZbTXyYLE=;
        b=DacGydxhZWju62yqXlkKH3BJSxNFSQW0K+qrYKSdN+1a4LRGggB7s66ZL3prubpVUA
         E6s2G75ZJdUt/wj+7ht7Jjz7Lcl2VJTeBUAFKdnIfhZsZzczqXKRizNtIQdEP/xcW/5C
         LEGYJqy4KkYR8VN4eq+omUulEP45BYaquVvzZqiu+OPObyHElKhe90jSVeZP8R5svkVC
         M+1nuEyV1bREGiy/CYRCYfu4eGvcALRYXwAy/BbHVXWngyWVCxYxlnDl0SvujtENswUP
         SUo6aX53eiAtlGdLHHe1Ww1WQ7HZ4tclHmwaBLJbtH4ohaGQJJrN519/k6zdA44LOT83
         PBBA==
X-Forwarded-Encrypted: i=1; AJvYcCVJGa0IBQvUC49qva+FqVUa+UrlwQNS/M7giTkpcP/xtSL5YkBdn6SL/ndhYw1g96+pvj9fDg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf2WKykrGOmCovt/CiYQWJlGuyAYd3IT58+mR1GFIDpYCI1FZR
	d0H31QQEicyn/lAwVdkzXO0UQQX2XKxdsTnjXqPhFc9ldFxt0T7Hz6K2bMPjx6yWjxV6KR3/2Qe
	Sk6bf9AS77iQF+enqa75odRvU1TzU2ubVsxdnucSV
X-Gm-Gg: AY/fxX7znPjjP1QJe9ZSGTQmCdq6MfbTH3JZZo/tVmLLAWJ96zEEnLDCL8ig287lX+e
	X5RXrsIsO4BOMIkrvLx6L0WCspcV9ceLWn0hi1yLjtQh3T3OuJswnP8VNm/AhIYAHpIyg4VFYDI
	8wnNiyAR72LSAmRS1A8Yel7mV8xQMMU4wK65FBrQKfJgX5X/ARAoKPmIbGA5YAouxh86npKYbHv
	lF8kW7M3mue0GhNcw7Wh8UbPDJt1eHtqmYSdY9N/nEWomHWf5bIp0vB6UVkV5kkKej4+RPmAcV2
	+w9NG2FbNMICUaNGDC5FFEC5e6I=
X-Received: by 2002:a05:622a:1482:b0:4ff:c103:49f1 with SMTP id
 d75a77b69052e-501182d936amr2352541cf.6.1767989185723; Fri, 09 Jan 2026
 12:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107201800.2486137-1-skhawaja@google.com> <20260107202812.GD340082@ziepe.ca>
 <20260107204607.GE340082@ziepe.ca>
In-Reply-To: <20260107204607.GE340082@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 9 Jan 2026 12:06:13 -0800
X-Gm-Features: AZwV_QjV34fhG0Fu3VYkE_TAOZmadp8pGOc9Pcce_ry5TSbSRKbYuzuTqpawuWI
Message-ID: <CAAywjhTEyOUmxWeCX6GwCBSnMf-p18Ksu2TUYeQ57K8H4RW-9w@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/vt-d: Add support to hitless replace IOMMU domain
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 12:46=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Jan 07, 2026 at 04:28:12PM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 07, 2026 at 08:17:57PM +0000, Samiullah Khawaja wrote:
> > > Intel IOMMU Driver already supports replacing IOMMU domain hitlessly =
in
> > > scalable mode.
> >
> > It does? We were just talking about how it doesn't work because it
> > makes the PASID entry non-present while loading the new domain.
>
> If you tried your tests in scalable mode they are probably only
> working because the HW is holding the entry in cache while the CPU is
> completely mangling it:
>
> int intel_pasid_replace_first_level(struct intel_iommu *iommu,
>                                     struct device *dev, phys_addr_t fsptp=
tr,
>                                     u32 pasid, u16 did, u16 old_did,
>                                     int flags)
> {
> [..]
>         *pte =3D new_pte;
>
> That just doesn't work for "replace", it isn't hitless unless the
> entry stays in the cache. Since your test effectively will hold the
> context entry in the cache while testing for "hitless" it doesn't
> really test if it is really working without races..

Ah.. you are absolutely correct. This will not work if the entries are
not cached.
>
> All of this needs to be reworked to always use the stack to build the
> entry, like the replace path does, and have a ARM-like algorithm to
> update the live memory in just the right order to guarentee the HW
> does not see a corrupted entry.

Agreed. I will go through the VTD specs and also the ARM driver to
determine the right order to set this up.
>
> It is a little bit tricky, but it should start with reworking
> everything to consistently use the stack to create the new entry and
> calling a centralized function to set the new entry to the live
> memory. This replace/not replace split should be purged completely.
>
> Some discussion is here
>
> https://lore.kernel.org/all/20260106142301.GS125261@ziepe.ca/
>
> It also needs to be very careful that the invalidation is doing both
> the old and new context entry concurrently while it is being replaced.

Yes, let me follow the discussion over there closely.
>
> For instance the placement of cache_tag_assign_domain() looks wrong to
> me, it can't be *after* the HW has been programmed to use the new tags
> :\
>
> I also didn't note where the currently active cache_tag is removed
> from the linked list during attach, is that another bug?

You are correct, the placement of cache_tag_assign_domain is wrong.
The removal of the currently active cache tag is done in
dmar_domain_attach_device, but I will re-evaluate the placement of
both in the v2.
>
> In short, this needs alot of work to actually properly implement
> hitless replace the way ARM can. Fortunately I think it is mostly
> mechanical and should be fairly straightfoward. Refer to the ARM
> driver and try to structure vtd to have the same essential flow..

Thank you for the feedback. I will prepare a v2 series addressing these poi=
nts.
>
> Jason
