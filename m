Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC29C4361B
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 19:59:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE5122D5A
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 19:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE5122D5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 186BD85BF7;
	Thu, 10 Dec 2020 19:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y1qZ2F0StR-E; Thu, 10 Dec 2020 19:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5919C85BC9;
	Thu, 10 Dec 2020 19:59:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39348C013B;
	Thu, 10 Dec 2020 19:59:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C2D6C013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 19:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5DE8185BC9
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 19:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mzpIjSJ1dLZl for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 19:59:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AE58185BBA
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 19:59:02 +0000 (UTC)
Date: Thu, 10 Dec 2020 20:58:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607630342;
 bh=s2+iLf6qBKVf58ffYZN9l2zof1I9JLW9V6wDx6uBGB8=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=eklBHcybGU7NaHOQQv++7WWXgTVIXfU4CnRYhDTvdmMh828hU1HhwGuy262A7mXl3
 UVfMlgSR9hjmxiHEEmyAKdwE8N24GronEa9YX/3xByG12lhH5sLlYjOzWtARATmbU+
 gbjs//eYTsEVpjwIHW5m8/FwAch5WCZ79eUruF3gO37OfRXISugUzkUxi/tczLL5H1
 C81E6xkV7hUWEVha0XOmiWm7bl+CmN06kwTj6Wpcq+BBF8+02d6kP4fL05muxPEfXb
 pZ3KGXhlBNtOeEDWP9EZLwn/4dPMZS2smZLYs42jw9BUNf2bClh/cggGRtfKBSWABt
 n3IVdl/kI4rwg==
From: Wolfram Sang <wsa@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] dma-mapping: move hint unlikely for dma_mapping_error
 from drivers to core
Message-ID: <20201210195855.GA11120@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 George Cherian <gcherian@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Zaibo Xu <xuzaibo@huawei.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Arnaud Ebalard <arno@natisbad.org>,
 Srujana Challa <schalla@marvell.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Elie Morisse <syniurge@gmail.com>,
 Nehal Shah <nehal-bakulchandra.shah@amd.com>,
 Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Andreas Larsson <andreas@gaisler.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Netanel Belgazal <netanel@amazon.com>,
 Arthur Kiyanovski <akiyano@amazon.com>,
 Guy Tzalik <gtzalik@amazon.com>, Saeed Bishara <saeedb@amazon.com>,
 Zorik Machulsky <zorik@amazon.com>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Jay Cliburn <jcliburn@gmail.com>,
 Chris Snook <chris.snook@gmail.com>,
 Ariel Elior <aelior@marvell.com>,
 Sudarsana Kalluru <skalluru@marvell.com>,
 GR-everest-linux-l2@marvell.com,
 Michael Chan <michael.chan@broadcom.com>,
 Raju Rangoju <rajur@chelsio.com>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Ioana Radulescu <ruxandra.radulescu@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Catherine Sullivan <csully@google.com>,
 Sagi Shahar <sagis@google.com>, Jon Olson <jonolson@google.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Hauke Mehrtens <hauke@hauke-m.de>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>,
 John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Boris Pismenny <borisp@nvidia.com>, Jon Mason <jdmason@kudzu.us>,
 Rain River <rain.1986.08.12@gmail.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>,
 Shannon Nelson <snelson@pensando.io>,
 Pensando Drivers <drivers@pensando.io>,
 Jiri Pirko <jiri@resnulli.us>, Edward Cree <ecree.xilinx@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Daniele Venzano <venza@brownhat.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Wingman Kwok <w-kwok2@ti.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Kevin Brace <kevinbrace@bracecomputerlab.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Kalle Valo <kvalo@codeaurora.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Nick Kossifidis <mickflemm@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Luca Coelho <luciano.coelho@intel.com>,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, qat-linux@intel.com,
 linux-i2c@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, wil6210@qti.qualcomm.com,
 b43-dev@lists.infradead.org, iommu@lists.linux-foundation.org
References: <5d08af46-5897-b827-dcfb-181d869c8f71@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5d08af46-5897-b827-dcfb-181d869c8f71@gmail.com>
Cc: Kevin Brace <kevinbrace@bracecomputerlab.com>,
 Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 GR-everest-linux-l2@marvell.com, Ioana Radulescu <ruxandra.radulescu@nxp.com>,
 Madalin Bucur <madalin.bucur@nxp.com>, Michal Simek <michal.simek@xilinx.com>,
 Doug Ledford <dledford@redhat.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Jiri Pirko <jiri@resnulli.us>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 Arnaud Ebalard <arno@natisbad.org>,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guy Tzalik <gtzalik@amazon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-crypto@vger.kernel.org, Shannon Nelson <snelson@pensando.io>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Chris Snook <chris.snook@gmail.com>, Daniele Venzano <venza@brownhat.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, linux-i2c@vger.kernel.org,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jon Olson <jonolson@google.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Rain River <rain.1986.08.12@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Wingman Kwok <w-kwok2@ti.com>,
 Sean Wang <sean.wang@mediatek.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Pensando Drivers <drivers@pensando.io>, Kalle Valo <kvalo@codeaurora.org>,
 Boris Brezillon <bbrezillon@kernel.org>, Sagi Shahar <sagis@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Netanel Belgazal <netanel@amazon.com>, Andreas Larsson <andreas@gaisler.com>,
 Catherine Sullivan <csully@google.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 Alexei Starovoitov <ast@kernel.org>, Elie Morisse <syniurge@gmail.com>,
 Luca Coelho <luciano.coelho@intel.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Jiri Slaby <jirislaby@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, Srujana Challa <schalla@marvell.com>,
 ath10k@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 ath11k@lists.infradead.org, b43-dev@lists.infradead.org,
 Jay Cliburn <jcliburn@gmail.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
 John Crispin <john@phrozen.org>, Michael Chan <michael.chan@broadcom.com>,
 Edward Cree <ecree.xilinx@gmail.com>, iommu@lists.linux-foundation.org,
 wil6210@qti.qualcomm.com, Saeed Bishara <saeedb@amazon.com>,
 bpf@vger.kernel.org, Geetha sowjanya <gakula@marvell.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Zorik Machulsky <zorik@amazon.com>,
 qat-linux@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Nick Kossifidis <mickflemm@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Nehal Shah <nehal-bakulchandra.shah@amd.com>,
 Sunil Goutham <sgoutham@marvell.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Ariel Elior <aelior@marvell.com>, Keyur Chudgar <keyur@os.amperecomputing.com>,
 George Cherian <gcherian@marvell.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 hariprasad <hkelam@marvell.com>, Raju Rangoju <rajur@chelsio.com>,
 Felix Fietkau <nbd@nbd.name>, Saeed Mahameed <saeedm@nvidia.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
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
Content-Type: multipart/mixed; boundary="===============1757655187737059310=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1757655187737059310==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2020 at 03:47:50PM +0100, Heiner Kallweit wrote:
> Zillions of drivers use the unlikely() hint when checking the result of
> dma_mapping_error(). This is an inline function anyway, so we can move
> the hint into the function and remove it from drivers.
> From time to time discussions pop up how effective unlikely() is,
> and that it should be used only if something is really very unlikely.
> I think that's the case here.
>=20
> Patch was created with some help from coccinelle.
>=20
> @@
> expression dev, dma_addr;
> @@
>=20
> - unlikely(dma_mapping_error(dev, dma_addr))
> + dma_mapping_error(dev, dma_addr)
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Wolfram Sang <wsa@kernel.org> # for I2C


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl/SffoACgkQFA3kzBSg
KbYcjxAAgOE4gHcgEP8+Oex1fposdP2Z4KiWFjIYYWG4fo/Ry9PjDbSGh9Nptht2
fnsCRcFXFj4oaSXaflBTq6ky4usgo2Gyp9puXbnpyj7P2uEjrqZs1zUFpAWdzMor
UgiJkW/P2IZjCDfwxE8nn9L0fm8ZfcHWqVohAgDh/9SKsrQCdzlzwvd7vSQ94fXr
qnYrmc6BF68dxVZx4TV18GddP5qFXYKytQ8pXL51XZEJTI05IGmc2l6hs/B4tKj6
muxiEFw5Ac0eseMimi4J5YDJJZxWe28onn69mMJYQDzVPqSZRyhSAqCv0EhMg6Vp
sABbG/eShtxir8A5ZrVRgqCaVyBjPu6pHAxdccHkj4d/6hfvD6F2FDXXaWirAf3i
A4gsMJAmxtBYV0Lyx0D+fzCFnvUSDDSOEayRJdzotQXVCbLvuWHTp6EXVJFD5mMU
/o3LApTC1uYQTXfGh1HHanpSEXLXfVgzjuDHRUsVIwemk5JwUAl6fw4oXbMrHYdZ
v9Inx4U81LGxayz1vGmzbE39AeE7YH/5lH4metjot96RpKa+Gg++mMxUHBPW6Jam
AOz6I3cKYsn7mPkzAZfDNvhvfgz2vxXcGGULSCdaWnVCJY7FMqe8i98w1z/Ymo7U
JSXmDUhFS43r0JqUfbR0sRGgLL+kHTEa6I4ZT8UNd9DmTtS0Jmo=
=4X1P
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--===============1757655187737059310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1757655187737059310==--
