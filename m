Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF72812B176
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082817; cv=none; b=uaP8G+11ssPVrqQT01DQ2bfo7zLnyVzIjrStr2JS/FsixLBWtiV7ziMCUxrVko/++eKURWnNIkbOmsDgLysjU/985t8E5Kpda1jOyI9381djPO22tn5s4eifshAZqIDIUnklq0xMiM4FcKt9nqeljhGJxDaUqBaPeZeO5H6CCX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082817; c=relaxed/simple;
	bh=0MqygOtxb2vrWsgnpTG1P7bZ4axPMOcPGvsm2uDa8JM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5z4+RRIXH/xpFggMG7gmurW683l0z3YiLlFUDMj6hYdVw5DknRzNeE0e3zyEUnzuwVWZe8YzM6YvyCFOOqk6famN5uT7HPi1MnVX54IUVz5hRZGlCB4wNKk9hohnELgXmauShyvQAWSB8ZW/9DTff7Ls2fqs0Dw4AKmF6IVfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gCkWnB+W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gCkWnB+W"
Received: from DESKTOP-0403QTC. (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3F8F420B7165;
	Mon, 19 Aug 2024 08:53:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F8F420B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724082815;
	bh=0MqygOtxb2vrWsgnpTG1P7bZ4axPMOcPGvsm2uDa8JM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gCkWnB+WGmxkR4W4vVyf11CNSigazVk5lEvS80+jfXFwUhHCshNRtHYWiWx9jOtVe
	 0/6bm6+GjKeX1HyImZIhZtsSR1YB+rds4No4el46H3xZPgyWN3jdJipJ0NGlWqrLnG
	 Vh/mjQlpAwdhO00JQvbIZPk5bT/8anRY2un56guY=
Date: Mon, 19 Aug 2024 08:53:34 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Tina Zhang <tina.zhang@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] iommu/vt-d: Introduce batched cache invalidation
Message-ID: <20240819085334.247199c3@DESKTOP-0403QTC.>
In-Reply-To: <03553755-6404-4bb3-badf-5091755f36b7@intel.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
	<20240815065221.50328-5-tina.zhang@intel.com>
	<20240816093846.40dbd623@DESKTOP-0403QTC.>
	<afec1d30-4bb3-4d39-9ff1-eb8ecb26bed3@linux.intel.com>
	<03553755-6404-4bb3-badf-5091755f36b7@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Yi,

On Mon, 19 Aug 2024 15:58:35 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 2024/8/17 11:28, Baolu Lu wrote:
> > On 2024/8/17 0:38, Jacob Pan wrote: =20
> >> On Thu, 15 Aug 2024 14:52:21 +0800
> >> Tina Zhang <tina.zhang@intel.com> wrote:
> >> =20
> >>> @@ -270,7 +343,8 @@ static void cache_tag_flush_iotlb(struct
> >>> dmar_domain *domain, struct cache_tag * u64 type =3D
> >>> DMA_TLB_PSI_FLUSH; if (domain->use_first_level) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qi_flush_piotlb(iommu, ta=
g->domain_id, tag->pasid,
> >>> addr, pages, ih);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qi_batch_add_piotlb(iommu=
, tag->domain_id,
> >>> tag->pasid, addr,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pages, ih, domain->qi_batc=
h);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> @@ -287,7 +361,8 @@ static void cache_tag_flush_iotlb(struct
> >>> dmar_domain *domain, struct cache_tag * }
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ecap_qis(iommu->ecap))
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qi_flush_iotlb(iommu, tag=
->domain_id, addr | ih,
> >>> mask, type);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qi_batch_add_iotlb(iommu,=
 tag->domain_id, addr | ih,
> >>> mask, type,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 domain->qi_batch); =20
> >> If I understand this correctly, IOTLB flush maybe deferred until
> >> the batch array is full, right? If so, is there a security gap
> >> where callers think the mapping is gone after the call returns? =20
> > No. All related caches are flushed before function return. A domain
> > can have multiple cache tags. Previously, we sent individual cache
> > invalidation requests to hardware. This change combines all
> > necessary invalidation requests into a single batch and raise them
> > to hardware together to make it more efficient. =20
>=20
> Hi Jacob,
>=20
> Do you mean the configuration that iommu.strict=3D=3D0? :) As the above
> explanation from Baolu, this patch is not for that although it uses
> the term "batched". Also, it would reduce the VMExits that due to the
> IOTLB/DevTLB invalidation a lot in the virtualization environment.
>=20
No, I understand this is a different "batch", not for deferred flush.
I am asking why it has to gather QI_MAX_BATCHED_DESC_COUNT before it
does the flush. See my other reply.

Thanks,

Jacob



