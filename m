Return-Path: <SRS0=Qq8a=PF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C901C433F5
	for <iommu@archiver.kernel.org>; Sun, 17 Oct 2021 14:12:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD1360FE3
	for <iommu@archiver.kernel.org>; Sun, 17 Oct 2021 14:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FD1360FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 249BB81B14;
	Sun, 17 Oct 2021 14:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TtBJZsQnfek4; Sun, 17 Oct 2021 14:12:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1A95C81B35;
	Sun, 17 Oct 2021 14:12:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB790C000F;
	Sun, 17 Oct 2021 14:12:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BAC8C000D;
 Sun, 17 Oct 2021 14:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1519C81B35;
 Sun, 17 Oct 2021 14:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xm28Q_dSsA7x; Sun, 17 Oct 2021 14:12:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E7CD81B14;
 Sun, 17 Oct 2021 14:12:29 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C7F0604DB;
 Sun, 17 Oct 2021 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634479948;
 bh=RmSMKTg5TcL3qjURkxbM+BvVnDKiX6oL/7vB+Xbd55c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p9N+SfeMaoSGCiyxtDBec1UPv6WMgXjFcy/M3JLFPbVafXBNaxdjpG9B30dDW+YCM
 1w7o17spKr/RDQdS/NDnncfMCzYUuyBikegmGijUFJIAFKXC6JxKBQkOyxWpOPSkMG
 Xcf3Ny84a19kDTXcxLIlTN6rmnIPZn1mjgXZZ9+Dc8WFgbhY12z4AcuEe7HWqRja5M
 sJePhxIZkZFRjmpYsRgp1Xe1IXRkzbSJzbuO1E9W0NfEhJS5mWuBnyV95F9ShTR0m/
 N7QNQaMRxo2QFps6aw3PgKihE2TivErXbQejJdKE4pf9mljG1KyIeEc1cS3pdn6VoR
 5yxzQIavynIbg==
Date: Sun, 17 Oct 2021 16:12:19 +0200
From: Wolfram Sang <wsa@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
Message-ID: <YWwvQ+YMAKzX1aO3@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matt Mackall <mpm@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gonglei <arei.gonglei@huawei.com>,
 "David S. Miller" <davem@davemloft.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jie Deng <jie.deng@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@codeaurora.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Eric Van Hensbergen <ericvh@gmail.com>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-um@lists.infradead.org,
 virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 v9fs-developer@lists.sourceforge.net, kvm@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20211013105226.20225-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211013105226.20225-1-mst@redhat.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>, nvdimm@lists.linux.dev,
 Dominique Martinet <asmadeus@codewreck.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, David Airlie <airlied@linux.ie>,
 Viresh Kumar <vireshk@kernel.org>, Jason Wang <jasowang@redhat.com>,
 linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, linux-scsi@vger.kernel.org,
 Will Deacon <will@kernel.org>, v9fs-developer@lists.sourceforge.net,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org,
 Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Takashi Iwai <tiwai@suse.com>,
 Gonglei <arei.gonglei@huawei.com>, Kalle Valo <kvalo@codeaurora.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, virtualization@lists.linux-foundation.org,
 Jeff Dike <jdike@addtoit.com>, Vivek Goyal <vgoyal@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>,
 Johan Hedberg <johan.hedberg@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Eric Van Hensbergen <ericvh@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matt Mackall <mpm@selenic.com>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Cristian Marussi <cristian.marussi@arm.com>, Jens Axboe <axboe@kernel.dk>,
 Jie Deng <jie.deng@intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "David S. Miller" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============5539766121074162520=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5539766121074162520==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="byZ/nyBYz0KyHzOz"
Content-Disposition: inline


--byZ/nyBYz0KyHzOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 06:55:31AM -0400, Michael S. Tsirkin wrote:
> This will enable cleanups down the road.
> The idea is to disable cbs, then add "flush_queued_cbs" callback
> as a parameter, this way drivers can flush any work
> queued after callbacks have been disabled.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Wolfram Sang <wsa@kernel.org> # for I2C changes


--byZ/nyBYz0KyHzOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFsLz8ACgkQFA3kzBSg
KbbhcRAAqrAP/5XyaQEyoVcqsJ6xfTgBJXC8/fUFVary0yMagmjEQLKzCbVBRQiF
UyKdQuoAJkemPBp13oZuYHgojk26k9r+hRKLoXigmy0tMboLZisXMh7/pcFDyz2e
1C+0lbx3IQ5Q9LV590CAlOS1i7wPOXFDW0LkIu1mb8TX2Z2NU4G7Tz9TQlGBXO39
MhIC6ggPDf141nztlFknKIlcLzpBXatCQrhN7cdcr3LxTjoKa20bHHVIGokKmFma
sJK0vVc5vuqlye+Ea8AZ1jzol4xFQRcSHoNCC5MfHUfxVaJ3mvYQ6jXl9cAfYkLN
0V5IehblsGFyBZ/Kpw/9SnPGTBV2Chs/o4JURyiKp3wVIpkAMagVz9OI4cOC+TTt
8007Fqv9jQtFpu+w9FC3//i0C+JiUH12eYjCt8Me4FZC4EHIosqfm8i7yRB+MZIv
WtaR04OJSlPS/DVFNb1AhUrvITU7uOw2fvVRyyC33iPXIJpvDoyoS9voJTGWYxRn
u7CYO2yy9EfLoB6bPLn4wbfk1TUlbBpSuuycqOpSfjJ0CSEK0d/t4fKkwsDZ+gxb
bS6NiNuzBiaxzsm8EUVR1q+gqY46ywMDIOYmbBykiXipERJofhxjro8Czauj9+b6
FgdQ6J1aFiV8/k36NqD1M5WdM3VecyPECGa7Ba2Nce+uc/k8jCw=
=Y+5l
-----END PGP SIGNATURE-----

--byZ/nyBYz0KyHzOz--

--===============5539766121074162520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5539766121074162520==--
