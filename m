Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE0C433DF
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 11:28:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4043A20758
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 11:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4043A20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D8E1387C50;
	Wed, 20 May 2020 11:28:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mMOH++ZM242G; Wed, 20 May 2020 11:28:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 29FA687BE3;
	Wed, 20 May 2020 11:28:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11447C07FF;
	Wed, 20 May 2020 11:28:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87D6AC0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 11:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 75C4187BE3
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 11:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nBofMMvwPSsp for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 11:28:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4AFB787985
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 11:28:38 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8F94FAD78;
 Wed, 20 May 2020 11:28:38 +0000 (UTC)
Message-ID: <2aa6f276085319a5af7a96b3d7bdd0501641a7d7.camel@suse.de>
Subject: Re: [PATCH 09/15] device core: Add ability to handle multiple dma
 offsets
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 20 May 2020 13:28:32 +0200
In-Reply-To: <20200519203419.12369-10-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-10-james.quinlan@broadcom.com>
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Saravana Kannan <saravanak@google.com>, Frank Rowand <frowand.list@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============1250764474108633261=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1250764474108633261==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Ttdr9J6hcKekh9mdkCgm"


--=-Ttdr9J6hcKekh9mdkCgm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jim,
thanks for having a go at this! My two cents.

On Tue, 2020-05-19 at 16:34 -0400, Jim Quinlan wrote:
> The device variable 'dma_pfn_offset' is used to do a single
> linear map between cpu addrs and dma addrs.  The variable
> 'dma_map' is added to struct device to point to an array
> of multiple offsets which is required for some devices.
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---

[...]

> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -493,6 +493,8 @@ struct dev_links_info {
>   * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a sm=
aller
>   *		DMA limit than the device itself supports.
>   * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> + * @dma_map:	Like dma_pfn_offset but used when there are multiple
> + *		pfn offsets for multiple dma-ranges.
>   * @dma_parms:	A low level driver may set these to teach IOMMU code
> about
>   * 		segment limitations.
>   * @dma_pools:	Dma pools (if dma'ble device).
> @@ -578,7 +580,12 @@ struct device {
>  					     allocations such descriptors. */
>  	u64		bus_dma_limit;	/* upstream dma constraint */
>  	unsigned long	dma_pfn_offset;
> -
> +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> +	const void *dma_offset_map;	/* Like dma_pfn_offset, but for
> +					 * the unlikely case of multiple
> +					 * offsets. If non-null, dma_pfn_offset
> +					 * will be 0. */

I get a bad feeling about separating the DMA offset handling into two disti=
nct
variables. Albeit generally frowned upon, there is a fair amount of tricker=
y
around dev->dma_pfn_offset all over the kernel. usb_alloc_dev() comes to mi=
nd
for example. And this obviously doesn't play well with it. I feel a potenti=
al
solution to multiple DMA ranges should completely integrate with the curren=
t
device DMA handling code, without special cases, on top of that, be transpa=
rent
to the user.

In more concrete terms, I'd repackage dev->bus_dma_limit and
dev->dma_pfn_offset into a list/array of DMA range structures and adapt/cre=
ate
the relevant getter/setter functions so as for DMA users not to have to wor=
ry
about the specifics of a device's DMA constraints. For example, instead of
editing dev->dma_pfn_offset, you'd be passing a DMA range structure to the
device core, and let it take the relevant decisions on how to handle it
internally (overwrite, add a new entry, merge them, etc...).

Easier said than done. :)

Regards,
Nicolas


--=-Ttdr9J6hcKekh9mdkCgm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7FFGAACgkQlfZmHno8
x/62Gwf/ZcX0GjUG2kX8dOQj+DmylB81fPXdO67lCfYb36/3AaWub3SgdS6OElwx
EUkGWiXfQspc2tFLJ9QHVOvKZ4dn1axmHzBdSUxOS3Y7K/5Ui7G7hzbi22njfPOR
TjQzAlozY8g7HB3GWRHX6ptZwNsk2GgfywpFPTHQzZphJtsqhRkC+1NBVZJqcxUg
PP0lJ4op3lIusNEoZXTvss0CGvIqPZroj3V6gxMllerV0UGayKnZRijn+VnqKhM0
kJUKjAA7TXjaIHzJZYfVncgp2eZtNCpmP+WM7/YDKoNbbkJYHBelwCqCq42YEJhk
50yZpb9YqlD0TwGBilnlPIHc33lp8g==
=LCl4
-----END PGP SIGNATURE-----

--=-Ttdr9J6hcKekh9mdkCgm--


--===============1250764474108633261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1250764474108633261==--

