Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE42156875
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881949; cv=none; b=T+eRRVGmgq1+cpUK+vUmOmB042HmQOm+uKe+m8/s3BPfAgn4L9YeW0wCZN6XwoZdS/R0UYeIXw7CAOeXsRqO6DyMzI1NG7duXOmzpGFKe9SXN2pUNsi3XO1nFE5UjqzPJ8llCh/8tb9uDztmsa2HvtE6b2MmrxMHrB62wrip+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881949; c=relaxed/simple;
	bh=4pxbq7Tr3FScTIUfBkP5KmX00rBiyos8FPre6pu9ARY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uieuCvg62i40lVmv6v4TmO49zNen55nA0YION14c5+bX24oWuf5OkqLljI6PlNSilDDHOAIZzBkwc0fN64Y70hkQ/yxf2ylbdl9UUgIhCPXZ5DzsEupRPDZb7O+92UrQNmcol4TAbmCtv2NQNrRpWtZYPtXfer5snnubhfinrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JtAs+pw1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JtAs+pw1"
Received: from DESKTOP-0403QTC. (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id F26A920B7165;
	Wed, 28 Aug 2024 14:52:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F26A920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724881947;
	bh=0VVUu+ZGbQuikknnxpW1lMpLrgIKLSfcAz9lQGO7sfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JtAs+pw1A82Qh22yo2SSURx/LSDTmH0ULXOIIEc8t8tRiUCEf512H8sYQFQqb5bCw
	 xSKj9F8jOIVE3tWJ87bdF84sQYALukd7cFjQpSmWVWRLuiC7Du1K9LyYtf7CE0rqQO
	 ZDDgSx0MjpRHEvaqYXcb5grRZyDRW4KXV7ffNlII=
Date: Wed, 28 Aug 2024 14:52:24 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240828145224.2e949806@DESKTOP-0403QTC.>
In-Reply-To: <8215e4d4-2077-4fca-a002-27ddbfc0ddf2@amd.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
	<20240821133554.7405-2-vasant.hegde@amd.com>
	<20240821163147.GZ3468552@ziepe.ca>
	<67436cba-3d05-4528-9519-231b8396ed51@intel.com>
	<20240822124433.GD3468552@ziepe.ca>
	<0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
	<8215e4d4-2077-4fca-a002-27ddbfc0ddf2@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Vasant,

On Sat, 24 Aug 2024 20:17:45 +0530
Vasant Hegde <vasant.hegde@amd.com> wrote:

> Yi,
>=20
>=20
> On 8/23/2024 2:28 PM, Yi Liu wrote:
> > On 2024/8/22 20:44, Jason Gunthorpe wrote: =20
> >> On Thu, Aug 22, 2024 at 07:27:39PM +0800, Yi Liu wrote: =20
> >>> On 2024/8/22 00:31, Jason Gunthorpe wrote:
> >>> =20
> >>>>> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
> >>>>> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 enforced on device
> >>>>> attachment
> >>>>> =C2=A0=C2=A0=C2=A0 * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field=
 of hwpt
> >>>>> allocation data is
> >>>>> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 valid.
> >>>>> + * @IOMMUFD_HWPT_ALLOC_PASID: When the domain is used on a
> >>>>> device, with no
> >>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 PASID, the device will support
> >>>>> later attaching
> >>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 a PASID as well. Some HW
> >>>>> requires a specific
> >>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 domain format on the device to
> >>>>> allow PASID to
> >>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 work. =20
> >>>>
> >>>> Maybe:
> >>>>
> >>>> =C2=A0=C2=A0 Requests a domain that can be used with PASID. The doma=
in can
> >>>> be attached to any PASID on the device. Any domain attached to
> >>>> the non-PASID part of the device must also be flaged, otherwise
> >>>> attaching a PASID will blocked.
> >>>>
> >>>> Yi will need to add a check that IOMMUFD_HWPT_ALLOC_PASID was
> >>>> specified on the RID domain while processing attach on the PASID
> >>>> domain. =20
> >>>
> >>> this means if userspace wants to user pasid on a device, it
> >>> should allocate hwpt with this flag, no matter the hwpt is going
> >>> to be attached to RID or pasid. is it? =20
> >> =20
> >> Yes>> =20
> >>> I still have a confusion. Say on AMD, is it a legitimate
> >>> configuration that the RID is attached to a domain that uses V1
> >>> page table while pasid is attached to domains that use V2 page
> >>> table? From architecture p.o.v., it seems allowed. =20
> >>
> >> I think that is exactly what they have been saying their design
> >> cannot do. =20
> >=20
> > ok. I don't think Intel has this limitation. RID/PASID is free to
> > use s1 or s2 format page table. So such enforcement is nop on Intel
> > platform.=20
> >>
> >> If you want to use PASID you must install a GCR3 table full of V2
> >> tables. Doing this denies use of the V1 format for anything except
> >> a NESTING_PARENT. =20
> >=20
> > thanks for the explanation. So if pasid is to be used, amd iommu
> > driver just programs the GCR3 tables and the request without pasid
> > would use the v2 page table installed at pasid#0. It does not use
> > the DTE->host_page_table at all. I remember the
> > DTE->host_page_table uses v1 format. =20
>=20
>=20
> Right. Only V2 page table supports PASID. So when user space requests
> hwpt with PASID AMD driver will allocate V2 page table with GCR3
> setup and updated DTE. So it can handle attaching Device ID (uses
> PASID#0) and PASID (as GCR3 table is already setup).
>=20
> Note that when we use NESTED page table it will have both v1 (L2 /
> stage 2 level) and v2 page table (L1 / stage 1 level). Even in this
> setup V2 page table inside guest can support PASID.
>=20
Sorry I am still confused. So V2 can support both PASID and no PASID
(untagged DMA). For the nested case, if the guest wants to allocate
a UNMANAGED domain, would you use V1? If this code in [3/5] below runs
in the guest:

static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)

	/*
	 * Force IOMMU v1 page table when allocating
	 * domain for pass-through devices.
	 */
	if (type =3D=3D IOMMU_DOMAIN_UNMANAGED)
		pgtable =3D AMD_IOMMU_V1;

Hardware-wise, in nested case, can V1 be used in L1/S1 for DMA w/o
PASID?

Thanks,

Jacob
