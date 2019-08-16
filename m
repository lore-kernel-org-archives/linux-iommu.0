Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCF9C3A59E
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 19:50:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE0D2171F
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 19:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE0D2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0594DB9E;
	Fri, 16 Aug 2019 19:50:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8A7DBB62
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 19:50:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from pokefinder.org (sauhun.de [88.99.104.3])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5E9D076D
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 19:50:27 +0000 (UTC)
Received: from localhost (p54B33308.dip0.t-ipconnect.de [84.179.51.8])
	by pokefinder.org (Postfix) with ESMTPSA id 7AD8C4A14FE;
	Fri, 16 Aug 2019 21:50:26 +0200 (CEST)
Date: Fri, 16 Aug 2019 21:50:26 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, axboe@kernel.dk
Subject: Re: [PATCH v9 3/5] block: sort headers on blk-setting.c
Message-ID: <20190816195026.GC6886@kunai>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1564129876-28261-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
In-Reply-To: <1564129876-28261-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-renesas-soc@vger.kernel.org, ulf.hansson@linaro.org,
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
Content-Type: multipart/mixed; boundary="===============7967510337783848994=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============7967510337783848994==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 05:31:14PM +0900, Yoshihiro Shimoda wrote:
> This patch sorts the headers in alphabetic order to ease
> the maintenance for this part.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---

Jens, can we have your ack for this patch so Christoph can take this
series via his tree (also for patch 4/5)?

Thanks,

   Wolfram

>  block/blk-settings.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 2ae348c..45f2c52 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -2,16 +2,16 @@
>  /*
>   * Functions related to setting various queue properties from drivers
>   */
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
>  #include <linux/bio.h>
>  #include <linux/blkdev.h>
> -#include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
>  #include <linux/gcd.h>
> -#include <linux/lcm.h>
> -#include <linux/jiffies.h>
>  #include <linux/gfp.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/lcm.h>
> +#include <linux/memblock.h>     /* for max_pfn/max_low_pfn */
> +#include <linux/module.h>
> =20
>  #include "blk.h"
>  #include "blk-wbt.h"
> --=20
> 2.7.4
>=20

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1XCQEACgkQFA3kzBSg
KbYjog//dAZQC63XN6l3f9L1WM8IfdYypPCOsUgtWh4QAVYLdZ/jWXQPRpVwR/hF
WMR4XX7hbfiFzT5beBXQL2PdzpfjZBIGb7asS//S+9e1FZxSCOrTZKgu3REzg6xr
+YfC80n4iUw6rYLLz77WRSoFFkwB9n+IKQQt+aH6G3TqkF09y47VNQSPXfd7qysv
6QOmFR9Ks/zteUOZ7IpJHrCHr7BnLZxxP0WibZxkPteccbymLMWc5gL78ZCYj768
96wAiC2kYaimsXtwjRZjfSQnhLRGe4sG+DJREhpv79q73bss8Oj+3rvJziGfnbwN
6utP5aC039RbvIApECeK0pLOnLhXD/rkRQGHQroXVzarEXe/U4Kqhv2bUePym2DE
kg1n72w+DaEHCvF6YplmPQp+1xsIzFc+pk6z4Ck3gZkHv7tuNqCzD5Ljonp6C6fl
FJUKKIrV/vMmsrloglOxWWsV5cqSoc3rtuJK9OAH/p5tLpl5Rv1ZlBLBN6VIG0kM
wKYFmDHXeC6bh31D8a8XlEwbb124uvOWSaYw8OIO7hl/P8/BpDmmuyL90RsuqU2N
ThBk0luayqVqdag5MqZeNqkScfuIaMP4OIVROxa66JqEIH4+wB/kxnneRFGQVg0j
HimmywdZzFbi+FNZTxpjZ7SkN2xHELiGwxQsieJMgtMRJG+nwx8=
=SupF
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--

--===============7967510337783848994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7967510337783848994==--
