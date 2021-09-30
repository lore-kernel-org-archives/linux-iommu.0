Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB40C433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 03:02:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F71E6140F
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 03:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F71E6140F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0133784093;
	Thu, 30 Sep 2021 03:02:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rzORqyQWlDZ0; Thu, 30 Sep 2021 03:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BBAF384095;
	Thu, 30 Sep 2021 03:02:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8918EC000F;
	Thu, 30 Sep 2021 03:02:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F6B4C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 03:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 344DC84092
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 03:02:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qjy0wLK3yYxC for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 03:02:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 39E6A84090
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 03:02:51 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HKdMn5D01z4xVP; Thu, 30 Sep 2021 13:02:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632970965;
 bh=bVSYF7uJlZF85jEcbVvfB45l/qUznn+q8FvDHqhizO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cnh0oOWxARQj4pXBGaJspCnYZDi/18iEwECYzATMMFrV0rie8dj0kAKHE/rojFdlt
 W6n99DYr6n44OH89RrDLmVenjwb8Lc2SIRK+Y/XtQRVahr5LhQpGQvWgvHA7c3eojn
 o5dCH4z4NayPEdPTkPZ3TFrt6RGrjXspxXuJFtFw=
Date: Thu, 30 Sep 2021 12:48:16 +1000
From: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
Message-ID: <YVUlcJJBcgQrDTY4@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB54330421CA825F5CAA44BAC98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922010014.GE327412@nvidia.com> <YVPTdqWw6or3mK/h@yekko>
 <20210929122230.GO964074@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210929122230.GO964074@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============4192702854174368401=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4192702854174368401==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h1nhRvd2ptQmOAKV"
Content-Disposition: inline


--h1nhRvd2ptQmOAKV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 29, 2021 at 09:22:30AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 12:46:14PM +1000, david@gibson.dropbear.id.au wro=
te:
> > On Tue, Sep 21, 2021 at 10:00:14PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 22, 2021 at 12:54:02AM +0000, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Wednesday, September 22, 2021 12:01 AM
> > > > >=20
> > > > > >  One open about how to organize the device nodes under
> > > > > /dev/vfio/devices/.
> > > > > > This RFC adopts a simple policy by keeping a flat layout with m=
ixed
> > > > > devname
> > > > > > from all kinds of devices. The prerequisite of this model is th=
at devnames
> > > > > > from different bus types are unique formats:
> > > > >=20
> > > > > This isn't reliable, the devname should just be vfio0, vfio1, etc
> > > > >=20
> > > > > The userspace can learn the correct major/minor by inspecting the
> > > > > sysfs.
> > > > >=20
> > > > > This whole concept should disappear into the prior patch that add=
s the
> > > > > struct device in the first place, and I think most of the code he=
re
> > > > > can be deleted once the struct device is used properly.
> > > > >=20
> > > >=20
> > > > Can you help elaborate above flow? This is one area where we need
> > > > more guidance.
> > > >=20
> > > > When Qemu accepts an option "-device vfio-pci,host=3DDDDD:BB:DD.F",
> > > > how does Qemu identify which vifo0/1/... is associated with the spe=
cified=20
> > > > DDDD:BB:DD.F?=20
> > >=20
> > > When done properly in the kernel the file:
> > >=20
> > > /sys/bus/pci/devices/DDDD:BB:DD.F/vfio/vfioX/dev
> > >=20
> > > Will contain the major:minor of the VFIO device.
> > >=20
> > > Userspace then opens the /dev/vfio/devices/vfioX and checks with fstat
> > > that the major:minor matches.
> > >=20
> > > in the above pattern "pci" and "DDDD:BB:DD.FF" are the arguments pass=
ed
> > > to qemu.
> >=20
> > I thought part of the appeal of the device centric model was less
> > grovelling around in sysfs for information.  Using type/address
> > directly in /dev seems simpler than having to dig around matching
> > things here.
>=20
> I would say more regular grovelling. Starting from a sysfs device
> directory and querying the VFIO cdev associated with it is much more
> normal than what happens today, which also includes passing sysfs
> information into an ioctl :\

Hm.. ok.  Clearly I'm unfamiliar with the things that do that.  Other
than current VFIO, the only model I've really seen is where you just
point your program at a device node.

> > Note that this doesn't have to be done in kernel: you could have the
> > kernel just call them /dev/vfio/devices/vfio0, ... but add udev rules
> > that create symlinks from say /dev/vfio/pci/DDDD:BB:SS.F - >
> > ../devices/vfioXX based on the sysfs information.
>=20
> This is the right approach if people want to do this, but I'm not sure
> it is worth it given backwards compat requires the sysfs path as
> input.

You mean for userspace that needs to be able to go back to the old
VFIO interface as well?  It seems silly to force this sysfs mucking
about on new programs that depend on the new interface.

> We may as well stick with sysfs as the command line interface
> for userspace tools.

> And I certainly don't want to see userspace tools trying to reverse a
> sysfs path into a /dev/ symlink name when they can directly and
> reliably learn the correct cdev from the sysfspath.

Um.. sure.. but they can get the correct cdev from the sysfspath no
matter how we name the cdevs.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h1nhRvd2ptQmOAKV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFVJXAACgkQbDjKyiDZ
s5IQsQ//a9V6hdhkrwfjVg6eLiQNWabABagPIW1pwpFfrQKDiYkmXjBOg5EV0sXq
nld3ED5fjbeTz1XIGFLihE2soGMjfi1+h9bIWl+Yq1idN6Gxkd1Gq3JDqbfg6C4R
SnR1SmqsRvan+Br2Et/2jrdx3qEKEsdvCod33q443cKjNkmDtzrUHJiVE25SRyO/
Z2N2E4N8l+c1nbABzadlLJtKRmO84ptwgnCCnaeg0dg9EBatl00CxNVhM9HuHkOG
q277x6vv5rEBhrW+MbjQNVt0wcKG1lCtWfdOrFl0QkBeI0fjSFCSQcxwnE7r8ehN
/oyBmSaHuuAj5EVUPmJKh7PBf2zlpmhJUe9jOrrsUC7GXW3ykTvCG477Vpr7Pq21
zPcLDzrfrs1J1SW8o8Yc01lW3lsECwqzUW0dO83pblaz0AQimYFmbm+X7FXiHPOu
/cXcoCBpTvBAyXt2I1eThH8HZY4gQoxmL0FWF87ifCKyFWvsZkmSaafEBE2nzkah
c1wutGjFbhxdFZlZbu/R702kC/S4QYoPXgXno9bJkmnZE1xhesbiVBEeeMDu9xak
eCiYkC4yZ3tR/qxsoHpzaa5SS95jbmU9kjNL3QAnasRdMCbRjWXmOApy7h4Avb67
idR+fs+Yk2p9P4kmQUVPeQwF2JW2hvDzh22naJeS9RtLxhlTwtc=
=rIzq
-----END PGP SIGNATURE-----

--h1nhRvd2ptQmOAKV--

--===============4192702854174368401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4192702854174368401==--
