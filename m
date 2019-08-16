Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08150C3A59F
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 19:48:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C386221726
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 19:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C386221726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A0BF8B7A;
	Fri, 16 Aug 2019 19:48:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 27893B2F
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 19:48:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from pokefinder.org (sauhun.de [88.99.104.3])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 8D75BE5
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 19:48:22 +0000 (UTC)
Received: from localhost (p54B33308.dip0.t-ipconnect.de [84.179.51.8])
	by pokefinder.org (Postfix) with ESMTPSA id 1A8D44A14FE;
	Fri, 16 Aug 2019 21:48:21 +0200 (CEST)
Date: Fri, 16 Aug 2019 21:48:20 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v9 2/5] iommu/dma: Add a new dma_map_ops of
	get_merge_boundary()
Message-ID: <20190816194820.GB6886@kunai>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1564129876-28261-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
In-Reply-To: <1564129876-28261-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: axboe@kernel.dk, linux-renesas-soc@vger.kernel.org, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de
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
Content-Type: multipart/mixed; boundary="===============5626338043742661986=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============5626338043742661986==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 05:31:13PM +0900, Yoshihiro Shimoda wrote:
> This patch adds a new dma_map_ops of get_merge_boundary() to
> expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Joerg, can we have your ack for this patch so Christoph can take this
series via his tree?

Thanks,

   Wolfram

> ---
>  drivers/iommu/dma-iommu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a7f9c3e..2992ce4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1085,6 +1085,16 @@ static int iommu_dma_get_sgtable(struct device *de=
v, struct sg_table *sgt,
>  	return ret;
>  }
> =20
> +static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> +{
> +	struct iommu_domain *domain =3D iommu_get_dma_domain(dev);
> +
> +	if (domain->type !=3D IOMMU_DOMAIN_DMA)
> +		return 0;	/* can't merge */
> +
> +	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
> +}
> +
>  static const struct dma_map_ops iommu_dma_ops =3D {
>  	.alloc			=3D iommu_dma_alloc,
>  	.free			=3D iommu_dma_free,
> @@ -1100,6 +1110,7 @@ static const struct dma_map_ops iommu_dma_ops =3D {
>  	.sync_sg_for_device	=3D iommu_dma_sync_sg_for_device,
>  	.map_resource		=3D iommu_dma_map_resource,
>  	.unmap_resource		=3D iommu_dma_unmap_resource,
> +	.get_merge_boundary	=3D iommu_dma_get_merge_boundary,
>  };
> =20
>  /*
> --=20
> 2.7.4
>=20

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1XCIQACgkQFA3kzBSg
KbZ8OBAApd6wfSbUGk8bR2bHXmdMHPFIldoc2rP9hr9PM+q3qiQINrZttJrWtrDG
LFHddbWI0gio2yyl/e+9g5QRBF4rRzcLDhJxRSqn8KfAvxu4jU19HAN2rjboS7zl
R0MNVdj+uBCaxvDVXKfuRa+HUUGKtJCTB0Pp79iMJcVL/fq3emVy9cJIwp/K5Z5W
srwNpawQ2wPlC7IY293k+SJL9VCgGG3zMgsyQnQ5ZFZeybkBwsbltc9bw53HwA5G
MgHUt37Csrg+6V+5RlJx4LSY3J03x6N0h+CqSSohD24vNq3TRjoQQT6/yX+BgkDU
BtsT1CB/Ff1ehHSy4yHJc0+AGuLMx8dDhv2QKI+ZNWIbRkVcT5LYoygsdTAZ5w3n
uf59EWdIV2MvpK80WimH25kXMtlTWMmHbWmm3hjpmLFAypp3ZIFn4olIQ7l1Gi2k
jg8dAH4uA4Mu70cWApfnk/ujiSaBtvIfuTFqKcWRmML/liD8Wm+JhDoZzxw0dax5
RPu8KBIR0W/2DLZ8bKKaDzP3I5rzcBEbyrdVosgADXwPiX2ILq1et21iSz7+Z7G6
bidUnMWjOwlP1hhMOiZnzj2uZd9uhwpg87Iz7nY8PMrpJQbSQiJctt2FVfV+/xwq
DPFYl62HmlAiU8J9dEoRIHeo49sW5PO4uTBlMT+F2uLqfugrQns=
=70Bs
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

--===============5626338043742661986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5626338043742661986==--
