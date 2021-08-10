Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FADC4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 05:50:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50B561052
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 05:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A50B561052
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64DEF40176;
	Tue, 10 Aug 2021 05:50:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdTfQ50g7KcX; Tue, 10 Aug 2021 05:50:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D49640177;
	Tue, 10 Aug 2021 05:50:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA64C001A;
	Tue, 10 Aug 2021 05:50:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FC5EC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 05:50:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3ABE540177
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 05:50:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZaF2sIRcFQXR for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 05:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CC0F40176
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 05:49:57 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4GkMVC12sBz9t1r; Tue, 10 Aug 2021 15:49:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1628574595;
 bh=YbLbuCNThcsSOrx2jsnQ+qzGIrL3Sa8qjMo2zoixYUk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TeeDGUoi3NfNePEFQSurbRphCjdsdRl92M3NlH0a65wrFgIloP1NN6EO9vuxoXjQl
 udEmuz3ZOLaCGmOkdxw46T2GZODcFJG3GGzxjvmKp9561SKItehYNy4VqRZ7gF8fvd
 MWmJCHrItKpAeDqd/tvw36MdmlpQzJ0M+OfZ+rrs=
Date: Tue, 10 Aug 2021 14:47:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <YRIE9eDADmPoWWg9@yekko>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YP4/KJoYfbaf5U94@yekko>
 <BN9PR11MB54332594B1B4003AE4B9238C8CEA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YQig7EIVMAuzSgH4@yekko>
 <BN9PR11MB54338C2863EA94145710A1BA8CF09@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YQy+ZsCab6Ni/sN7@yekko>
 <BN9PR11MB54338800A20821429D7C34038CF69@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB54338800A20821429D7C34038CF69@BN9PR11MB5433.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============8843567529007437385=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8843567529007437385==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wV885SpJ7rTOEsIJ"
Content-Disposition: inline


--wV885SpJ7rTOEsIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 09, 2021 at 08:34:06AM +0000, Tian, Kevin wrote:
> > From: David Gibson <david@gibson.dropbear.id.au>
> > Sent: Friday, August 6, 2021 12:45 PM
> > > > > In concept I feel the purpose of DMA endpoint is equivalent to the
> > routing
> > > > > info in this proposal.
> > > >
> > > > Maybe?  I'm afraid I never quite managed to understand the role of =
the
> > > > routing info in your proposal.
> > > >
> > >
> > > the IOMMU routes incoming DMA packets to a specific I/O page table,
> > > according to RID or RID+PASID carried in the packet. RID or RID+PASID
> > > is the routing information (represented by device cookie +PASID in
> > > proposed uAPI) and what the iommu driver really cares when activating
> > > the I/O page table in the iommu.
> >=20
> > Ok, so yes, endpoint is roughly equivalent to that.  But my point is
> > that the IOMMU layer really only cares about that (device+routing)
> > combination, not other aspects of what the device is.  So that's the
> > concept we should give a name and put front and center in the API.
> >=20
>=20
> This is how this proposal works, centered around the routing info. the=20
> uAPI doesn't care what the device is. It just requires the user to specif=
y=20
> the user view of routing info (device fd + optional pasid) to tag an IOAS=
=2E=20

Which works as long as (just device fd) and (device fd + PASID) covers
all the options.  If we have new possibilities we need new interfaces.
And, that can't even handle the case of one endpoint for multiple
devices (e.g. ACS-incapable bridge).

> the user view is then converted to the kernel view of routing (rid or=20
> rid+pasid) by vfio driver and then passed to iommu fd in the attaching=20
> operation. and GET_INFO interface is provided for the user to check=20
> whether a device supports multiple IOASes and whether pasid space is=20
> delegated to the user. We just need a better name if pasid is considered=
=20
> too pci specific...
>=20
> But creating an endpoint per ioasid and making it centered in uAPI is not=
=20
> what the IOMMU layer cares about.

It's not an endpoint per ioasid.  You can have multiple endpoints per
ioasid, just not the other way around.  As it is multiple IOASes per
device means *some* sort of disambiguation (generally by PASID) which
is hard to describe generall.  Having endpoints as a first-class
concept makes that simpler.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wV885SpJ7rTOEsIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmESBPMACgkQbDjKyiDZ
s5KILhAAr8fnsZWEExknNW7F+hGmqod7sHARGhdyn8YrbJrbReSFRrbiKDonU3Ac
Y2GRkVC2UY5HKw8uHyBcSlqYT0RQNuJxP4NsNrG67qJpvPIPsPIRAsys1RoRNkg9
/BsPhKbqMWmHneJvAzIa/+sC15AlWi3uqoXSfUI44j/UjHE+R/UIzPtntCjHtZvG
IWkR08OixLFBqd5SPxkLYs7YIeX088vUBk1bIkD8DeZLp7ZQnRBxQ3pEzwIrAYYA
iQyMnav9EkhI4NLzlN+4JVozFQ5yH1Yk89gbLNhgN4+AqdocNhrzROMzcmi4z/qd
PQSqKGTCbqklyM7TmrU3PZidR5ULFv4CNZR2mxUehIBHh0Hbiszfdw67jB7j8e7+
03nGDMwfyr1ZK4X6DJ0HjWI/CXA2vL0DAQjJnzz+wSAwJH7AxxCf9Wt/ykGIbWR9
+HIKRdVl2XVAzDOL9ySXeHFGTZ2ypQ1Xxm0DNS/RSDKPeUSmM2k6iHmZC8E/s58v
n0aXJSOR7Nvh+L9Gv5N56Ox8zxvUxfITNducyyMRa+JXT+UFfJIOEjRU9apAEJd6
GEO8C3NqSLG/jU78CKqQObOfATlFBt8iJM9gtZVCFCs57J5udZlse7YmokYK9AWa
ddjx/N6iMOaYdU0VJCG199aWbdU2ZEBVRNaQFuX8oQzZlgT+Szo=
=URlp
-----END PGP SIGNATURE-----

--wV885SpJ7rTOEsIJ--

--===============8843567529007437385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8843567529007437385==--
