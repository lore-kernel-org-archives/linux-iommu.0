Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACDCC433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 08:05:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD4C206CD
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 08:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD4C206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EF1B686D1D;
	Mon,  6 Jul 2020 08:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jgDsjeSztiZc; Mon,  6 Jul 2020 08:05:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EB18C86D23;
	Mon,  6 Jul 2020 08:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6D26C1797;
	Mon,  6 Jul 2020 08:05:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A827C0733
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2615387500
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JJLygcBYHDIy for <iommu@lists.linux-foundation.org>;
 Sat,  4 Jul 2020 11:45:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3A2CD874F7
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:45:00 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 7F6811C0BD2; Sat,  4 Jul 2020 13:44:53 +0200 (CEST)
Date: Sat, 4 Jul 2020 13:44:52 +0200
From: Pavel Machek <pavel@denx.de>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v2 0/7] Tighten PCI security, expose dev location in sysfs
Message-ID: <20200704114452.GA15530@amd>
References: <20200630044943.3425049-1-rajatja@google.com>
MIME-Version: 1.0
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Mon, 06 Jul 2020 08:05:12 +0000
Cc: Todd Broch <tbroch@google.com>, linux-pci@vger.kernel.org,
 lalithambika.krishnakumar@intel.com,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 oohall@gmail.com, Benson Leung <bleung@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Alex Levin <levinale@google.com>
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
Content-Type: multipart/mixed; boundary="===============8864173711380169313=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8864173711380169313==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * The first 3 patches tighten the PCI security using ACS, and take care
>   of a border case.
> * The 4th patch takes care of PCI bug.
> * 5th and 6th patches expose a device's location into the sysfs to allow
>   admin to make decision based on that.

I see no patch for Documentation -- new sysfs interfaces should be
documented for 5/6.

									Pavel

>  drivers/base/core.c         | 35 +++++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++---------
>  drivers/pci/ats.c           |  2 +-
>  drivers/pci/bus.c           | 13 ++++++------
>  drivers/pci/of.c            |  2 +-
>  drivers/pci/p2pdma.c        |  2 +-
>  drivers/pci/pci-acpi.c      | 13 ++++++------
>  drivers/pci/pci-driver.c    |  1 +
>  drivers/pci/pci.c           | 34 ++++++++++++++++++++++++++----
>  drivers/pci/pci.h           |  3 ++-
>  drivers/pci/probe.c         | 20 +++++++++++-------
>  drivers/pci/quirks.c        | 19 +++++++++++++----
>  include/linux/device.h      | 42 +++++++++++++++++++++++++++++++++++++
>  include/linux/device/bus.h  |  8 +++++++
>  include/linux/pci.h         | 13 ++++++------
>  15 files changed, 191 insertions(+), 47 deletions(-)
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8Aa7QACgkQMOfwapXb+vKywACguAX/M2pdPQp3cMcFaM8SJJbH
zsoAn1By+0ZFx363Y5WWGNssFTuDT0Al
=AJH4
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--===============8864173711380169313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8864173711380169313==--
