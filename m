Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA9C31E4A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 19:38:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7896D2173C
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 19:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7896D2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6017A1591;
	Thu, 13 Jun 2019 19:38:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 125B813CB
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 19:38:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from pokefinder.org (sauhun.de [88.99.104.3])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 971B3711
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 19:38:00 +0000 (UTC)
Received: from localhost (p5486CF99.dip0.t-ipconnect.de [84.134.207.153])
	by pokefinder.org (Postfix) with ESMTPSA id B9EC74A127B;
	Thu, 13 Jun 2019 21:37:59 +0200 (CEST)
Date: Thu, 13 Jun 2019 21:37:59 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v6 1/5] iommu: add an exported function to get
	minimum page size for a domain
Message-ID: <20190613193759.GB6863@kunai>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
In-Reply-To: <1560421215-10750-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: axboe@kernel.dk, linux-renesas-soc@vger.kernel.org, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, hch@lst.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============4418804930578453961=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============4418804930578453961==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 07:20:11PM +0900, Yoshihiro Shimoda wrote:
> This patch adds an exported function to get minimum page size for
> a domain. This patch also modifies similar codes on the iommu.c.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/iommu/iommu.c | 18 +++++++++++++++---
>  include/linux/iommu.h |  1 +
>  2 files changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2a90638..7ed16af 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -280,6 +280,18 @@ iommu_insert_device_resv_regions(struct list_head *d=
ev_resv_regions,
>  	return ret;
>  }
> =20
> +/**
> + * iommu_get_minimum_page_size - get minimum page size for a domain
> + * @domain: the domain
> + *
> + * Allow iommu driver to get a minimum page size for a domain.
> + */
> +unsigned long iommu_get_minimum_page_size(struct iommu_domain *domain)
> +{
> +	return 1UL << __ffs(domain->pgsize_bitmap);
> +}
> +EXPORT_SYMBOL_GPL(iommu_get_minimum_page_size);

What about making this a 'static inline' in the iommu header file? I'd
think it is simple enough and would save us the EXPORT symbol.


--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0CphcACgkQFA3kzBSg
KbavgQ/+JwWPeuVMxx3ApPN3s2nlNe+Sp7vVq6kDrfjELjZdDMHLzLE8PXjCRb4k
gAesEh8M5QcwY/VqkV0XW07TxDLGkSLvKxR3S6vyeGNlzYbttlYRb7qzgpiKu6E3
miXxc2HRrYQMVeFmZJ0ntoPIwHB3Ydsq2am91JSiOKVSmEJgbw1gYGcAMbI8o41I
yfiTwI0DBd/ooD7befuhJoJziIO8J90QI3HNMzkC+viD6RugwwidU7sho5JDCmw4
ha62jLZy42Ijg96Pqd9f7zDtGFJ2SB/h0mqv3+EBKW6+efzHAmVSEd1WoxyBLMjy
WQx6xcthVIQGBwMfUA9p1F8ZDKoiYv5TAxNqPTW6JUpcT2bDpwcrS5LzQvt5RRhE
tJZcPzeBHFW6Jdp9/rgbdooJhauvP4DxtxlcoMieYq3Re4jKQq2YMqS7MLuHK5Je
PqCSIZZH7vl4hKHr3UuRfLOIEdD7hd+5FIi/X8hYmV2+rc5HYECpe4Jy+Ir/1YV2
Omda5LDqeEtyvWjjvGuNJps3XFZEVkjZYKkRYAzw4J7QLlzHOAHBht4q6iZza69K
qx9iY6g98ViBoeReaBHOsq4QGllCfC/BR0k+q94sDAexjK771I++9rjV+sr08NkB
dgIaqwkz3rKn6MBWAaXBXkJvt9jyZjtVgcVYKw/AvLOTkG2MwqU=
=5ihp
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

--===============4418804930578453961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4418804930578453961==--
