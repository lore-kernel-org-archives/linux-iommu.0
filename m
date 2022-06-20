Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C665ECCA481
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 21:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4ED73418E9;
	Mon, 20 Jun 2022 21:38:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4ED73418E9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=o2pZhsbn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ua4CuJJR6Ie5; Mon, 20 Jun 2022 21:38:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35A0F408EF;
	Mon, 20 Jun 2022 21:38:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35A0F408EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E390DC002D;
	Mon, 20 Jun 2022 21:38:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E34A5C002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 21:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD01960FC2
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 21:38:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD01960FC2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=o2pZhsbn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MEuBgZcMQQjS for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 21:38:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5793560FA2
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5793560FA2
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 21:38:01 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id a2so19240818lfg.5
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=EgAnwP4MqXgu0q0d6eXWE8mU2Kiz+p4e1fpGeFSH/Y8=;
 b=o2pZhsbnmZB/hPYNsAdRYKSGEUThCWUrSiKDope47O0Hc6y1Ie/Uhr9vlzSWLA7VnO
 6lN78P1MVEepVV3liDs+f/UB+HrgEgGkF966GYg6fLnqq8wNHYQe6N3JVso5Fyy44o6y
 MTQQwOrei2MX3mKbp2o5cf+Ro3YqXr9BSPZ5sDofxPvIy+Jve8CIopY4koLos6Miyhim
 HbI7xS8hrxSimFq+buz+51JhYFW3Umf1FryhoF2UDYiuUfKl62C81eqe/XBlIMtqb1Un
 gQyf5QE3lnyE367qbAyXYc4b7q6kAK5See9cks50Cphd4BQMI3b++pGIJWMs08WbeyvQ
 Qelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=EgAnwP4MqXgu0q0d6eXWE8mU2Kiz+p4e1fpGeFSH/Y8=;
 b=K48N7AhxCz5qxPBDdfDOzmEo3lomDnKfaCQ1jH4q0nvLYZQxcWrF5ldUiFeW1qkvjF
 3S0ujw8FINfO55oPtHOpCCxmgv7Q/rj48B6XeB59mMjRKR+hvZ3oxZ+A6dAw0/iX5AOq
 gqMuJ8ViUD9FX+8lOJiDlLWgiF5MniofwGxJCU70JgVS7Wf6afC8fxIhltIoqHQyPcRg
 7UTjEsepEoYTHqhvCCCr6jtg0//91HyWVK0ELiytHBiokshJz5Ub1hfkZ88Nz+Dazzxw
 dxj5PprnKr6KVBwVXSAfaa4LkykoXnL4dZ0o3S/pGX7D3MJZEYSCsChuI5uVoy/BIXHC
 xB4g==
X-Gm-Message-State: AJIora+cu1Ly+txVV0NFA7OMnun1N7cBwUpZ64TZWsgqXiosYM8izxAD
 7wz6+dEUC3kJsf8NfZ6JKAY=
X-Google-Smtp-Source: AGRyM1s0d2VrYvy3auZpZcZEHLNE88miIB37xA3w0baRw5oXY3mn7ZteuCobzjV8K7l5aFMU1SrfTQ==
X-Received: by 2002:a05:6512:b1c:b0:47d:df52:b5a9 with SMTP id
 w28-20020a0565120b1c00b0047ddf52b5a9mr13983505lfu.293.1655761079086; 
 Mon, 20 Jun 2022 14:37:59 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a05651202e300b0047f647414eesm992667lfq.229.2022.06.20.14.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 14:37:58 -0700 (PDT)
Date: Tue, 21 Jun 2022 00:37:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] dma-direct: take dma-ranges/offsets into account in
 resource mapping
Message-ID: <20220620213755.kczuriyildoublzi@mobilestation>
References: <20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, David Airlie <airlied@linux.ie>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Linu Cherian <lcherian@marvell.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Magnus Damm <magnus.damm@gmail.com>, Srujana Challa <schalla@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Andy Gross <agross@kernel.org>,
 Sunil Goutham <sgoutham@marvell.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Arnaud Ebalard <arno@natisbad.org>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Alex Deucher <alexander.deucher@amd.com>, ntb@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Boris Brezillon <bbrezillon@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Oded Gabbay <ogabbay@kernel.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, iommu@lists.linux-foundation.org,
 Li Yang <leoyang.li@nxp.com>, linux-renesas-soc@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmaengine@vger.kernel.org,
 Shawn Guo <shawnguo@kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Folks,

On Fri, Jun 10, 2022 at 11:08:02AM +0300, Serge Semin wrote:
> A basic device-specific linear memory mapping was introduced back in
> commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
> preserved in the device.dma_pfn_offset field, which was initialized for
> instance by means of the "dma-ranges" DT property. Afterwards the
> functionality was extended to support more than one device-specific region
> defined in the device.dma_range_map list of maps. But all of these
> improvements concerned a single pointer, page or sg DMA-mapping methods,
> while the system resource mapping function turned to miss the
> corresponding modification. Thus the dma_direct_map_resource() method now
> just casts the CPU physical address to the device DMA address with no
> dma-ranges-based mapping taking into account, which is obviously wrong.
> Let's fix it by using the phys_to_dma_direct() method to get the
> device-specific bus address from the passed memory resource for the case
> of the directly mapped DMA.

So any comment on the suggest modification? Any notes against or for?

-Sergey

> =

> Fixes: 25f1e1887088 ("dma: Take into account dma_pfn_offset")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> =

> ---
> =

> After a long discussion with Christoph and Robin regarding this patch
> here:
> https://lore.kernel.org/lkml/20220324014836.19149-4-Sergey.Semin@baikalel=
ectronics.ru
> and here
> https://lore.kernel.org/linux-pci/20220503225104.12108-2-Sergey.Semin@bai=
kalelectronics.ru/
> It was decided to consult with wider maintainers audience whether it's ok
> to accept the change as is or a more sophisticated solution needs to be
> found for the non-linear direct MMIO mapping.
> =

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> =

> file: arch/arm/mach-orion5x/board-dt.c
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: linux-arm-kernel@lists.infradead.org
> =

> file: drivers/crypto/marvell/cesa/cesa.c
> Cc: Srujana Challa <schalla@marvell.com>
> Cc: Arnaud Ebalard <arno@natisbad.org>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: linux-crypto@vger.kernel.org
> =

> file: drivers/dma/{fsl-edma-common.c,pl330.c,sh/rcar-dmac.c}
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> =

> file: arch/arm/boot/dts/{vfxxx.dtsi,ls1021a.dtsi,imx7ulp.dtsi,fsl-ls1043a=
.dtsi}
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> =

> file: arch/arm/boot/dts/r8a77*.dtsi, arch/arm64/boot/dts/renesas/r8a77*.d=
tsi
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-renesas-soc@vger.kernel.org
> =

> file: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=F6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> =

> file: drivers/gpu/drm/virtio/virtgpu_vram.c
> Cc: David Airlie <airlied@linux.ie>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> =

> file: drivers/media/common/videobuf2/videobuf2-dma-contig.c
> Cc: Tomasz Figa <tfiga@chromium.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> =

> file: drivers/misc/habanalabs/common/memory.c
> Cc: Oded Gabbay <ogabbay@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> =

> file: drivers/mtd/nand/raw/qcom_nandc.c
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> =

> file: arch/arm64/boot/dts/qcom/{ipq8074.dtsi,ipq6018.dtsi,qcom-sdx55.dtsi=
,qcom-ipq4019.dtsi,qcom-ipq8064.dtsi}
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> =

> file: drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> Cc: Sunil Goutham <sgoutham@marvell.com>
> Cc: Linu Cherian <lcherian@marvell.com>
> Cc: Geetha sowjanya <gakula@marvell.com>
> =

> file: drivers/ntb/ntb_transport.c
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: ntb@lists.linux.dev
> ---
>  kernel/dma/direct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 9743c6ccce1a..bc06db74dfdb 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -497,7 +497,7 @@ int dma_direct_map_sg(struct device *dev, struct scat=
terlist *sgl, int nents,
>  dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> -	dma_addr_t dma_addr =3D paddr;
> +	dma_addr_t dma_addr =3D phys_to_dma_direct(dev, paddr);
>  =

>  	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
>  		dev_err_once(dev,
> -- =

> 2.35.1
> =

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
