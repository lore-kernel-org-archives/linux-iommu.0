Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F6C433FE
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 01:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70BB5826DF;
	Tue,  3 May 2022 01:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id viMC1BmL3wth; Tue,  3 May 2022 01:07:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AFE1F82865;
	Tue,  3 May 2022 01:07:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73632C0039;
	Tue,  3 May 2022 01:07:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE0D0C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 01:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA7B460D80
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 01:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KIMoNC6m7wrs for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 01:07:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55F0760640
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 01:07:07 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4Kshd034Yjz4xXk; Tue,  3 May 2022 11:07:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1651540020;
 bh=FcQqpF/NUTSEkTfna7zkc9NiXTOuuNW4TCrr3MzIYmc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AXGMrufxSYfrSBS4gbcoPHraL775trm94VEF0+jqryVFYaeg+Vtzx0dvaYA2XgHk6
 6gL+bOqk7VTE4nPUgXNHqMTd/PY+1pda10bPFkx9Vu7oyuvMJScr0J7kSzpYC6KSi5
 ziGPkDDbZygErM93fUtkOtqbKJOtxNYWjz8QFiF4=
Date: Mon, 2 May 2022 17:30:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Message-ID: <Ym+IfTvdD2zS6j4G@yekko>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323165125.5efd5976.alex.williamson@redhat.com>
 <20220324003342.GV11336@nvidia.com>
 <20220324160403.42131028.alex.williamson@redhat.com>
 <YmqqXHsCTxVb2/Oa@yekko> <20220428151037.GK8364@nvidia.com>
 <YmuDtPMksOj7NOEh@yekko> <20220429124838.GW8364@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220429124838.GW8364@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6457592243517688560=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6457592243517688560==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ixSynOD2EsVNzN9y"
Content-Disposition: inline


--ixSynOD2EsVNzN9y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2022 at 09:48:38AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 29, 2022 at 04:20:36PM +1000, David Gibson wrote:
>=20
> > > I think PPC and S390 are solving the same problem here. I think S390
> > > is going to go to a SW nested model where it has an iommu_domain
> > > controlled by iommufd that is populated with the pinned pages, eg
> > > stored in an xarray.
> > >=20
> > > Then the performance map/unmap path is simply copying pages from the
> > > xarray to the real IOPTEs - and this would be modeled as a nested
> > > iommu_domain with a SW vIOPTE walker instead of a HW vIOPTE walker.
> > >=20
> > > Perhaps this is agreeable for PPC too?
> >=20
> > Uh.. maybe?  Note that I'm making these comments based on working on
> > this some years ago (the initial VFIO for ppc implementation in
> > particular).  I'm no longer actively involved in ppc kernel work.
>=20
> OK
> =20
> > > > 3) "dynamic DMA windows" (DDW).  The IBM IOMMU hardware allows for =
2 IOVA
> > > > windows, which aren't contiguous with each other.  The base address=
es
> > > > of each of these are fixed, but the size of each window, the pagesi=
ze
> > > > (i.e. granularity) of each window and the number of levels in the
> > > > IOMMU pagetable are runtime configurable.  Because it's true in the
> > > > hardware, it's also true of the vIOMMU interface defined by the IBM
> > > > hypervisor (and adpoted by KVM as well).  So, guests can request
> > > > changes in how these windows are handled.  Typical Linux guests will
> > > > use the "low" window (IOVA 0..2GiB) dynamically, and the high window
> > > > (IOVA 1<<60..???) to map all of RAM.  However, as a hypervisor we
> > > > can't count on that; the guest can use them however it wants.
> > >=20
> > > As part of nesting iommufd will have a 'create iommu_domain using
> > > iommu driver specific data' primitive.
> > >=20
> > > The driver specific data for PPC can include a description of these
> > > windows so the PPC specific qemu driver can issue this new ioctl
> > > using the information provided by the guest.
> >=20
> > Hmm.. not sure if that works.  At the moment, qemu (for example) needs
> > to set up the domains/containers/IOASes as it constructs the machine,
> > because that's based on the virtual hardware topology.  Initially they
> > use the default windows (0..2GiB first window, second window
> > disabled).  Only once the guest kernel is up and running does it issue
> > the hypercalls to set the final windows as it prefers.  In theory the
> > guest could change them during runtime though it's unlikely in
> > practice.  They could change during machine lifetime in practice,
> > though, if you rebooted from one guest kernel to another that uses a
> > different configuration.
> >=20
> > *Maybe* IOAS construction can be deferred somehow, though I'm not sure
> > because the assigned devices need to live somewhere.
>=20
> This is a general requirement for all the nesting implementations, we
> start out with some default nested page table and then later the VM
> does the vIOMMU call to change it. So nesting will have to come along
> with some kind of 'switch domains IOCTL'
>=20
> In this case I would guess PPC could do the same and start out with a
> small (nested) iommu_domain and then create the VM's desired
> iommu_domain from the hypercall, and switch to it.
>=20
> It is a bit more CPU work since maps in the lower range would have to
> be copied over, but conceptually the model matches the HW nesting.

Ah.. ok.  IIUC what you're saying is that the kernel-side IOASes have
fixed windows, but we fake dynamic windows in the userspace
implementation by flipping the devices over to a new IOAS with the new
windows.  Is that right?

Where exactly would the windows be specified?  My understanding was
that when creating a back-end specific IOAS, that would typically be
for the case where you're using a user / guest managed IO pagetable,
with the backend specifying the format for that.  In the ppc case we'd
need to specify the windows, but we'd still need the IOAS_MAP/UNMAP
operations to manage the mappings.  The PAPR vIOMMU is
paravirtualized, so all updates come via hypercalls, so there's no
user/guest managed data structure.

That should work from the point of view of the userspace and guest
side interfaces.  It might be fiddly from the point of view of the
back end.  The ppc iommu doesn't really have the notion of
configurable domains - instead the address spaces are the hardware or
firmware fixed PEs, so they have a fixed set of devices.  At the bare
metal level it's possible to sort of do domains by making the actual
pagetable pointers for several PEs point to a common place.

However, in the future, nested KVM under PowerVM is likely to be the
norm.  In that situation the L1 as well as the L2 only has the
paravirtualized interfaces, which don't have any notion of domains,
only PEs.  All updates take place via hypercalls which explicitly
specify a PE (strictly speaking they take a "Logical IO Bus Number"
(LIOBN), but those generally map one to one with PEs), so it can't use
shared pointer tricks either.

Now obviously we can chose devices to share a logical iommu domain by
just duplicating mappings across the PEs, but what we can't do is
construct mappings in a domain and *then* atomically move devices into
it.


So, here's an alternative set of interfaces that should work for ppc,
maybe you can tell me whether they also work for x86 and others:

  * Each domain/IOAS has a concept of one or more IOVA windows, which
    each have a base address, size, pagesize (granularity) and optionally
    other flags/attributes.
      * This has some bearing on hardware capabilities, but is
        primarily a software notion
  * MAP/UNMAP operations are only permitted within an existing IOVA
    window (and with addresses aligned to the window's pagesize)
      * This is enforced by software whether or not it is required by
        the underlying hardware
  * Likewise IOAS_COPY operations are only permitted if the source and
    destination windows have compatible attributes
  * A newly created kernel-managed IOAS has *no* IOVA windows
  * A CREATE_WINDOW operation is added
      * This takes a size, pagesize/granularity, optional base address
        and optional additional attributes=20
      * If any of the specified attributes are incompatible with the
        underlying hardware, the operation fails
    * "Compatibility" doesn't require an exact match: creating a small
       window within the hardware's much larger valid address range is
       fine, as is creating a window with a pagesize that's a multiple
       of the hardware pagesize
    * Unspecified attributes (including base address) are allocated by
      the kernel, based on the hardware capabilities/configuration
    * The properties of the window (including allocated ones) are
      recorded with the IOAS/domain
    * For IOMMUs like ppc which don't have fixed ranges, this would
      create windows on the backend to match, if possible, otherwise
      fail
  * A REMOVE_WINDOW operation reverses a single CREATE_WINDOW
    * This would also delete any MAPs within that window
  * ATTACH operations recaculate the hardware capabilities (as now),
    then verify then against the already created windows, and fail if
    the existing windows can't be preserved

MAP/UNMAP, CREATE/REMOVE_WINDOW and ATTACH/DETACH operations can
happen in any order, though whether they succeed may depend on the
order in some cases.

So, for a userspace driver setup (e.g. DPDK) the typical sequence
would be:

  1. Create IOAS
  2. ATTACH all the devices we want to use
  3. CREATE_WINDOW with the size and pagesize we need, other
     attributes unspecified
       - Because we already attached the devices, this will allocate a
         suitable base address and attributes for us
  4. IOAS_MAP the buffers we want into the window that was allocated
     for us
  5. Do work

For qemu or another hypervisor with a ppc (PAPR) guest, the sequence would =
be:

  1. Create IOAS for each guest side bus
  2. Determine the expected IOVA ranges based on the guest
     configuration (model of vIOMMU, what virtual devices are present)
  3. CREATE_WINDOW ranges for the default guest side windows.  This
     will have base address specified
       - If this fails, we're out of luck, report error and quit
  4. ATTACH devices that are on the guest bus associated with each
     IOAS
       - Again, if this fails, report error and quit
  5. Start machine, boot guest
  6. During runtime:
       - If the guest attempts to create new windows, do new
         CREATE_WINDOW operations.  If they fail, fail the initiating
	 hypercall
       - If the guest maps things into the IO pagetable, IOAS_MAP
         them.  If that fails, fail the hypercall
       - If the user hotplugs a device, try to ATTACH it.  If that
         fails, fail the hotplug operation.
       - If the machine is reset, REMOVE_WINDOW whatever's there and
         CREATE_WINDOW the defaults again

For qemu with an x86 guest, the sequence would be:

  1. Create default IOAS
  2. CREATE_WINDOW for all guest memory blocks
     - If it fails, report and quit
  3. IOAS_MAP guest RAM into default IOAS so that GPA=3D=3DIOVA
  4. ATTACH all virtual devices to the default IOAS
     - If it fails, report and quit
  5. Start machine, boot guest
  6. During runtime
     - If the guest assigns devices to domains on the vIOMMU, create
       new IOAS for each guest domain, and ATTACH the device to the
       new IOAS
     - If the guest triggers a vIOMMU cache flush, (re)mirror the guest IO
       pagetables into the host using IOAS_MAP or COPY
     - If the user hotplugs a device, ATTACH it to the default
       domain.  If that fails, fail the hotplug
     - If the user hotplugs memory, CREATE_WINDOW in the default IOAS
       for the new memory region.  If that fails, fail the hotplug
     - On system reset, re-ATTACH all devices to default IOAS, remove
       all non-default IOAS


> > > > You might be able to do this by simply failing this outright if
> > > > there's anything other than exactly one IOMMU group bound to the
> > > > container / IOAS (which I think might be what VFIO itself does now).
> > > > Handling that with a device centric API gets somewhat fiddlier, of
> > > > course.
> > >=20
> > > Maybe every device gets a copy of the error notification?
> >=20
> > Alas, it's harder than that.  One of the things that can happen on an
> > EEH fault is that the entire PE gets suspended (blocking both DMA and
> > MMIO, IIRC) until the proper recovery steps are taken. =20
>=20
> I think qemu would have to de-duplicate the duplicated device
> notifications and then it can go from a device notifiation to the
> device's iommu_group to the IOAS to the vPE?

It's not about the notifications.  When the PE goes into
suspended/error state, that changes guest visible behaviour of
devices.  It essentially blocks all IO on the bus (the design
philosophy is to prioritize not propagating bad data above all else).
That state is triggered on (certain sorts of) IO errors and will
remain until explicit recovery steps are taken.

The guest might see that IO blockage before it gets/processes the
notifications (because concurrency).  On the host side only the host
PE will be affected, but on the guest side we can only report and
recover things at the guest PE level, which might be larger than a
host PE.

So the problem is if we have a guest PE with multiple host PEs, and we
trip an error which puts one of the host PEs into error state, we have
what's essentially an inconsistent, invalid state from the point of
view of the guest interfaces.  The guest has no way to sensibly query
or recover from this.

To make this work, essentially we'd have to trap the error on the
host, then inject errors to put all of the host PEs in the guest PE
into the same error state.  When the guest takes recovery actions we'd
need to duplicate those actions on all the host PEs.  If one of those
steps fails on one of the host PEs we have to work out out to report
that and bring the PEs back into a synchronized state.

Like I said, it might be possible, but it's really, really hairy.  All
for a feature that I'm not convinced anyone has ever used in earnest.

> A simple serial number in the event would make this pretty simple.
>=20
> The way back to clear the event would just forward the commands
> through a random device in the iommu_group to the PE?
>=20
> Thanks,
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ixSynOD2EsVNzN9y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoULxWu4/Ws0dB+XtgypY4gEwYSIFAmJviHUACgkQgypY4gEw
YSJl8hAAqUKqKEAUfVFZP33+HwYE5LCjBxJFGJLCET4yTQOiyVG2WgUJBK0N7Dju
xlN2cYSsYyXfM68q8CPnjJR6B1QOXOAhFeg6UUV7WGMxzTd8FX52NX6fp17ssf3I
/0FhfveuiczH2briyYaw7IbdrAKZiOJh4wIpmNUndJEO94Q31as5tag8RCE+/GdX
X9C+0WCD6QXiBh5y+UI2B/2mW4EAcXf3TeecAK3bN+u38d5s1lmXKM3DQS9N+3YF
9XyZhxka8HuNzWaQiPo4Kl51xnCdjjiofC0qJpv8L8EfhPoxAWz54wLlNazqFLYU
uOcbHuh+urRsDQZVKfuYlHu0aEBOgo7IOLBJi2bHFRHSQv1K3XcwucfsPL3FqMJw
KYDID27TeRFGaL0t6zXXwAaUrn/mQgBEv1HBGKxAUuSL7GB/ITFYdhh7ZuuYWJID
gjlpfeqjN2tBiLkzjyCY5oGf9skduCEMmbrjRps33WUCspWsnPUwXfqgATor/y7J
lpmkzlBAN6Sxyw8MzBXVFmZCXLzrdE8HKk3arHU1sfkEEIu4R/efCWPvsH12JqeL
FJF24ibm9ZvC51WiUCh8BvV2OzIvbijROedDcA/uikMoMjvVJdMSehUHzO9KLgBQ
XDmLJLzqscjP5+KgE8B8BqL/cps9xoQDOmiCmTN1frYIkGJqZOo=
=+FOZ
-----END PGP SIGNATURE-----

--ixSynOD2EsVNzN9y--

--===============6457592243517688560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6457592243517688560==--
