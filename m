Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA81F03DE
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467098; cv=none; b=tgMHPx9Hhqazkru32Jwpo6TnPNr0VrQAB2bdE87sISXXgsSZtyd3A3IvR5v3kCsXOH+3AHKjsRKx4ypoRZaNZUe1jVA31faCseQslS1NRYsBggn8CUJaN4qPkJubZMYDbdmfjUa3NCPETvLh7kPmYBLhBBYZGK/K7PuLVg568CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467098; c=relaxed/simple;
	bh=bkfcyGBP+L544g1cGjx51AxtTZqgEP0keRH+RYiDUZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIaTYBgIIeJ2Uf6oBBbv2xfF7fEeo9HZQMZDBjQu/D2hMTBN4SI4Kx9sthPDvrsqijfn4AExVXAfOMvOHyvSpaJBQ0RlnTRL4wrrE885E/MccScOLSTJn/0HMQdlGXr+/8QITOKCTI/Bxiy9Or0ANKUl696+bovBFsGSkKVKsho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ZUxjObzu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lo+5id/e; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ZUxjObzu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lo+5id/e"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B66257A00D5;
	Fri, 17 Apr 2026 19:04:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 17 Apr 2026 19:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776467093;
	 x=1776553493; bh=M9Muqnw/JqGvJZEoZVKMdWQjK3505PcZ7Hk7U4+H85c=; b=
	ZUxjObzu1Vj/dVCmXrpn3LF526iGjXmNKyhELbo0R7p+M0OmtX/DibCovnjG65HN
	WHREE6iQH8Jeu/JTQVL/hlUCEabI5wfAkZraBpHEPUABQReClsQ5sCxIT8FQy36c
	jNy7YZbCnfHrjo1rLlTJVwM6+B5UsP0NpiRpek4mYOO3iXiJNEhp8OAMhaLkHdU7
	e3w+zoiQEMKjC2H2A8GybKFsyyimug2hiD9Mm9BUKiBu8JtfKH39pITBm2QQsLgD
	OKo9w/spl2vFK1Gf/gqNeAOD/G7pgn7UFY3pBv1vXUaEmpqQFeeM7lpRoduT6o7x
	Od1CYh6b4W8BVRbp3Zl7OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776467093; x=
	1776553493; bh=M9Muqnw/JqGvJZEoZVKMdWQjK3505PcZ7Hk7U4+H85c=; b=L
	o+5id/ea9SliaYVIUxWQp0JrGFg4Q8IZxMWkocm2xowAAjwTgaIvqqkjr436CWjs
	s4lDJzCpLBeTzTBxHFWESq5An+kVNP49XFnjP8RDlAnqXDnqpdB704dGT1fkaF8S
	Ibmjc2u0vOQub1OvshI1iyZ9xl463YCR6cYkZOX8cJJt3O8YirtMFKhGlXq9xB50
	fJN/lhkICVUzcoNBCG3lvsNtK5P9M9DROp/BBk2WGJxe7CjL1GZKTPwmGMH0I8jV
	JD2cZdDqSa4VkzP4o57iBfaKFTVGIZmxEdlK62cAyDSsJIn4vCUJCPf+70tB2bLm
	SKXtx4wrTuTQv++aZsZpw==
X-ME-Sender: <xms:lLziacv-4iFGdpzjOke0cGoDQuH_NJrLqowTtCsB2T-qHXEGgSRlOA>
    <xme:lLziaX8cOyv_qTlo8a869HYfpjmo9ILt-jeqA2aa2l_MHRjgYUQiSglyVjK5aR3Zq
    qzYj41iWUvqXekFjdJz0rj7mAU7qd5brFUzVbTOxcjP28L9SVsmOw>
X-ME-Received: <xmr:lLziaelX1WBGxK_LO_55043Z3GWD-t881RUbSQilNjNsQiSwMjlM00KyIZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepgeduvefhjeeufeevudeiueeuieeftedtkeevkefhgfdvteefleeuhefgtdeh
    fffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrphgrnheslhhinhhugidrmhhitghroh
    hsohhfthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhsthhsrdhlihhnuhigrd
    guvghvpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhho
    rhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehsmhhoshhtrghfrgesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopehnih
    gtohhlihhntgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:lLziafMPBNLE_Yt30yPY9RznaWTdNpu-WCpcpMivIZMe11vYyR2Mfg>
    <xmx:lLziaVJaElD2GimNQtaxOo27_-njlX0jNQLoLIeWdtZ_9M5QTcY-6Q>
    <xmx:lLziaSGfxjDq4d3bUtgUmMmZu4TKNPvvz0ehgHWGIJt1zfKj9pzuYg>
    <xmx:lLziaeBsomZdydQGR-ZLusL3XAyQII17zwmMwKiVQZ7cO5WmX7M43A>
    <xmx:lbziaXOlNtyKnd4wkiuNxrCoZu_En4ZnN1x_P7nDF52qhq5Ohel_VvS6>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 19:04:51 -0400 (EDT)
Date: Fri, 17 Apr 2026 17:04:50 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 alex@shazbot.org
Subject: Re: [PATCH V4 05/10] vfio: Allow null group for noiommu without
 containers
Message-ID: <20260417170450.00e1d8ba@shazbot.org>
In-Reply-To: <20260417100609.00004775@linux.microsoft.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-6-jacob.pan@linux.microsoft.com>
	<20260416140601.255ec031@shazbot.org>
	<20260417100609.00004775@linux.microsoft.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Apr 2026 10:06:09 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Hi Alex,
>=20
> On Thu, 16 Apr 2026 14:06:01 -0600
> Alex Williamson <alex@shazbot.org> wrote:
>=20
> > From: Alex Williamson <alex@shazbot.org>
> > To: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
> > <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg
> > Roedel  <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David
> > Matlack  <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>,
> > Nicolin Chen  <nicolinc@nvidia.com>, "Tian, Kevin"
> > <kevin.tian@intel.com>, Yi Liu  <yi.l.liu@intel.com>,
> > skhawaja@google.com, pasha.tatashin@soleen.com, Will  Deacon
> > <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
> > alex@shazbot.org Subject: Re: [PATCH V4 05/10] vfio: Allow null group
> > for noiommu without  containers Date: Thu, 16 Apr 2026 14:06:01 -0600
> > X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
> >=20
> > On Tue, 14 Apr 2026 14:14:07 -0700
> > Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> >  =20
> > > In case of noiommu mode is enabled for VFIO cdev without VFIO
> > > container nor IOMMUFD provided compatibility container, there is no
> > > need to create a dummy group. Update the group operations to
> > > tolerate null group pointer.
> > >=20
> > > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > >=20
> > > ---
> > > v4: (Jason)
> > >    - Avoid null pointer deref in error unwind
> > >    - Add null group check in vfio_device_group_unregister
> > >    - repartition to include vfio_device_has_group() in this patch
> > > ---
> > >  drivers/vfio/group.c     | 20 ++++++++++++++++++++
> > >  drivers/vfio/vfio.h      | 17 +++++++++++++++++
> > >  drivers/vfio/vfio_main.c | 14 ++++++++++++++
> > >  include/linux/vfio.h     |  9 +++++++++
> > >  4 files changed, 60 insertions(+)
> > >=20
> > > diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> > > index 0fa9761b13d3..451e49d851f8 100644
> > > --- a/drivers/vfio/group.c
> > > +++ b/drivers/vfio/group.c
> > > @@ -390,6 +390,9 @@ int vfio_device_block_group(struct vfio_device
> > > *device) struct vfio_group *group =3D device->group;
> > >  	int ret =3D 0;
> > > =20
> > > +	if (vfio_null_group_allowed() && !group)
> > > +		return 0;   =20
> >=20
> > I think this comes down to the fact that at the end of this series,
> > VFIO_NOIOMMU still depends on VFIO_GROUP.  vfio_null_group_allowed()
> > can only return true if CONTAINER support is entirely disabled.  Why
> > do we still select VFIO_GROUP for VFIO_NOIOMMU and build group.s when
> > there's no container support to use it? =20
> If we solve this in Kconfig, I think the dependency should be
> config VFIO_GROUP
>         bool "Support for the VFIO group /dev/vfio/$group_id"
> +       depends on !(VFIO_NOIOMMU && !(VFIO_CONTAINER ||
>   IOMMUFD_VFIO_CONTAINER))
> But this causes circular dependency in that
>        symbol VFIO_NOIOMMU depends on VFIO_GROUP
>        symbol VFIO_GROUP depends on VFIO_NOIOMMU
>=20
> If we cannot force VFIO_GROUP=3Dn when container is entirely disabled and
> NOIOMMU & cdev is enabled, then user is free to set VFIO_GROUP=3Dy, which
> creates a VFIO_GROUP that cannot be used due to lack of container.
> There is no functional issue but less clean.
> i.e.
> #  tree /dev/vfio/   =20
> /dev/vfio/           =20
> |-- devices          =20
> |   `-- noiommu-vfio0=20
> `-- noiommu-0         //not usable
> # ls /sys/class/vfio
> noiommu-0          =20
>=20
> Maybe there is a way to force VFIO_GROUP=3Dn w/o the circular dependency?

What I'm trying to point out is that vfio_null_group_allowed() is being
used in a scenario in group.c that shouldn't exist.  If all container
support is disabled, all group support should also be disabled,
regardless of no-iommu.  Otherwise we get into the scenario you show
above.  No-iommu is a feature, currently only a feature of the
group/container model, but that's what we're trying to address here.

I'm not sure what the Kconfig looks like to achieve that.

> > Also note that vfio_noiommu is S_IWUSR, so it is mutable at runtime. =20
> Good point, maybe we can make it a one-way latch? i.e.
>  - echo 1 > .../enable_unsafe_noiommu_mode =E2=80=94 works (n=E2=86=92y)
>  - echo 0 > .../enable_unsafe_noiommu_mode =E2=80=94 returns -EPERM (y=E2=
=86=92n blocked)
>  - Boot param vfio.enable_unsafe_noiommu_mode=3D1 =E2=80=94 works
>  - Writing 1 when already 1 =E2=80=94 no-op, succeeds

It's a question of whether you'll break anyone.  IIRC, group-based
no-iommu works that you can enabled it, create a no-iommu group,
disabled it, and the no-iommu group continues to work.  Is it useful,
does anyone use it... I dunno.  Thanks,

Alex
