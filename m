Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1C74C14
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870001; cv=none; b=e4t1AHOT3H66RpBpCH6lWvf4qbXYcO2MkbzXLVqOfsbh/63TGKwJGG8msZGQsgcWNJAuBJfP84HDHG9ZFZyQhNVIJ2W7wtiKYKGZrraff2bvbsKSDodl+jglERNdpJGcflVcTzVPdvMVWW0f/QZ2PkM25/k0iT9Q3/z3HUAIVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870001; c=relaxed/simple;
	bh=lWqOivKiM8YwclLe0wpLXkznfn7oWAcsJolNToRP6qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgP9KvvjBzfPy5aiKsbyRmI3ls25R36SV3LsRML5nl0QL3Fyx/KjH8EDx6DK7L3NNFhHHftR8iteFkKzsJA+gj8ae8Lnaj0dgw+rbjmfpHceBcPA9l9OKr28AvwbLiI0t8uikEOSrLHGc6sQ6GECYiCprhtzNjFJQUcPj5whs3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ipy1oM0O; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ipy1oM0O"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee243b98caso457761cf.1
        for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764869997; x=1765474797; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEkJ3Ls4YdvhkyZtPoV9AUwtj0PZk1MF7CQ9DS4hvnE=;
        b=Ipy1oM0O9RQbSeMx+IMLznOIUUx6loSqv7fWzCQK8aar1ch9pOLQHI4geqSB6ljpNQ
         XlUN0fqvSN1t5t1thMVyABrhnOFw98mnDeL0r2YU55qDAVLpGV9KKp3StXeTWCZCRV6e
         jXg4QW91szrf6XQFH3lLo6aXJ8UHekcCQi73c+OgRyRQsFYirMCYsnBkbqaK2y04CZbj
         1fz9O5t7LiBo/BQu3DMRNv5VemSPOOviSz3GQ+FJ+gZ2UNW+O87N654aP8LYAltrtGGU
         Nya/0/Uj+oXi6bBDD/+ThXJzakM9uRkEiXZz48hvTiVRfgsDkqg7gQDNtBwe/NIJko4m
         DDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764869997; x=1765474797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xEkJ3Ls4YdvhkyZtPoV9AUwtj0PZk1MF7CQ9DS4hvnE=;
        b=DSAk29bvoJEV+baOJZtX1HGoIBUrcBqx8TkfzxH/joYQwmDwCR1i4EynluD5NWJEWA
         JyL42vyqS2/RyX0hFpPcpi4n5Ufj8MTKDP+ydo3232z6Fz9++NGMqBe594TpW+IcDpzD
         qaF0ouQH+R345mhAJHr6DUQ457UAwi/ZVdFwfay8cRwXwaT9rxecnxaOpjslzx2zRSs3
         Np7hQZlvSiLFRv8tD5VuqDZjiBrJAc+nHiJjP5m1CBngCs6DMHWnyDYxn904TGu8dKVx
         19AkmCL6yKJ+iZTWlL9H2fVDASlbJa7OUIMsvXBE7X7Gha7KVsYnMllmEtBb0hlnMgb2
         k6MQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6Sz1DuKIbt6zUC9LWso8HUAxHJLK5nDlcj6c9sZTQPctXVS0zaxIIOUMQTq3qT5X02yyg8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzE28asscGh66EOBfdS1nWal2t5epte5qqaHUnrHf1U5yaG3Z69
	o0bPxQd8pgSbE5ewwPFBs2uqwaPSVi8bMiIGd3CTnum0r33UxcrqL2NPMwBeAskcQBN21V+Hy0p
	RInjVv7qUIIQ+oTuVyouZhjZT31/gK5GnI1GO+mPT
X-Gm-Gg: ASbGncutOru/+DUM4WRsQ0vYctmeopjfsZjPPIkoe03ujAovThZPkJqr+4zyo9mxy9D
	uITEDlq1aIHwFCYhlqIfo/kydJtQll2K1Kzm1CIUOSQzibdWUt9rbAVp/SUNcImIqOQehXfzLH8
	f86H1gvXVzWDILA6IBmDNWazLD7ygoYCyWsG6EybDGD8PvIzinXKGRKL/C9y3DeUVlAfO8IlsJA
	OLZvY4FJmoXNtjuhn5QagQZd3AkFjQE37cOEgb2CDi510MnOLWZadhMUZh6BMJQIxBC7vFeAV0N
	GbDShjK1ao8TDgdXqyG/sKPlbfg=
X-Google-Smtp-Source: AGHT+IHiF6qF03HSNGOxrJ382JZ2j9Kn5YMuGYeSN6TAKnyptQ4xchJZqWblg8nGkx8SvcL4NrQN6UzliRDwY9xgUwY=
X-Received: by 2002:ac8:5f50:0:b0:4b7:aa51:116a with SMTP id
 d75a77b69052e-4f02cb81987mr4080441cf.4.1764869997221; Thu, 04 Dec 2025
 09:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com> <20251202230303.1017519-12-skhawaja@google.com>
 <fc6632e7-f0eb-437c-b687-c31c019f3d1f@linux.intel.com>
In-Reply-To: <fc6632e7-f0eb-437c-b687-c31c019f3d1f@linux.intel.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 4 Dec 2025 09:39:46 -0800
X-Gm-Features: AWmQ_bkSqjyaarzJGbiFKH6x2EpQi5FFL6mZ3NXJW-L-mVkTwb3R9MHFbcUqGF4
Message-ID: <CAAywjhSTn6hnzVDSpPGTD2=F2vweRc17e1Fd0vJVL-awpd_dcA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/32] iommu/pages: Add APIs to preserve/unpreserve/restore
 iommu pages
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 6:30=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com> =
wrote:
>
> On 12/3/25 07:02, Samiullah Khawaja wrote:
> > +int iommu_preserve_pages(struct iommu_pages_list *list)
> > +{
> > +     struct ioptdesc *iopt;
> > +     int count =3D 0;
> > +     int ret;
> > +
> > +     list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> > +             ret =3D kho_preserve_folio(ioptdesc_folio(iopt));
> > +             if (ret) {
> > +                     iommu_unpreserve_pages(list, count);
> > +                     return ret;
> > +             }
> > +
> > +             ++count;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_preserve_pages);
>
> What is the purpose of "count"?

Thanks for reviewing.

The count is there to unpreserve only the preserved pages if an error
occurs during preservation. For example if 4 pages (from the start of
the list) were preserved out of 10 pages in the list, the unpreserve
function will unpreserve the first 4 pages from the start of the list.
Please take a look at the implementation of iommu_unpreserve_pages for
details.
>
> Thanks,
> baolu

Sami
