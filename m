Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70349C43460
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 05:02:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADFC61151
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 05:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADFC61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B026A6066B;
	Mon, 19 Apr 2021 05:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QJHIT4P2dhUd; Mon, 19 Apr 2021 05:02:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E67A607A9;
	Mon, 19 Apr 2021 05:02:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36EBDC000F;
	Mon, 19 Apr 2021 05:02:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E042AC000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 05:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD60F835D9
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 05:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wuut-fvb4L0i for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 05:02:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB97B835E4
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 05:02:19 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65BC961078;
 Mon, 19 Apr 2021 05:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618808539;
 bh=srAR5o/oGq5ioibP/eXNEOXMJgehSJWXVDMJHT8j86M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q2aSyWKadyluHjWWN1SwyxF3iNnBxBRV4eFwfMyHPgeuOCbx3zVu4VA/PQblKt1mX
 LG/8Qa12wOxexoPdM1AtRUqEwffA6hhUzg5XvoNYf5i8CVaEzIb5aHKsxdmdIZ0VNh
 EB/GtCUOovxwGQ5QiY5CwzbiGBepA6YRCHaOc9bFp2O+m0lnHel/QMKuqas1XJG+Ml
 vece3azY0OPvilnrF9TxEM4Y2QEUh42RCB/qgDYU4n+IIRFMdKunRACTXFpDc2oJTx
 Tw4u0mxUHQNeAMruPlzpJF4CCm1VJVvyur9NU2SbLDowYlZY9RFqgpKroyAxadDiZV
 1t4tD3zjj0ZKQ==
Date: Mon, 19 Apr 2021 08:02:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: Re: [RFC v1 PATCH 3/3] driver: update all the code that use
 soc_device_match
Message-ID: <YH0O1104YEdjY9mb@unreal>
References: <20210419042722.27554-1-alice.guo@oss.nxp.com>
 <20210419042722.27554-4-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210419042722.27554-4-alice.guo@oss.nxp.com>
Cc: ulf.hansson@linaro.org, aymen.sghaier@nxp.com, geert+renesas@glider.be,
 rafael@kernel.org, airlied@linux.ie, mturquette@baylibre.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 a.hajda@samsung.com, netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 will@kernel.org, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 wim@linux-watchdog.org, herbert@gondor.apana.org.au, horia.geanta@nxp.com,
 khilman@baylibre.com, narmstrong@baylibre.com, linux-staging@lists.linux.dev,
 iommu@lists.linux-foundation.org, peter.ujfalusi@gmail.com, kishon@ti.com,
 tony@atomide.com, linux-omap@vger.kernel.org, stern@rowland.harvard.edu,
 kuba@kernel.org, linus.walleij@linaro.org, linux@roeck-us.net,
 linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Roy.Pledge@nxp.com, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 edubezval@gmail.com, linux-gpio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, ssantosh@kernel.org,
 matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, balbi@kernel.org, tomba@kernel.org,
 sboyd@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, adrian.hunter@intel.com, robert.foss@linaro.org,
 leoyang.li@nxp.com, linux@prisktech.co.nz, vkoul@kernel.org,
 linux-crypto@vger.kernel.org, daniel@ffwll.ch, j-keerthy@ti.com,
 dmaengine@vger.kernel.org, jyri.sarha@iki.fi, davem@davemloft.net
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Apr 19, 2021 at 12:27:22PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Update all the code that use soc_device_match because add support for
> soc_device_match returning -EPROBE_DEFER.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  drivers/bus/ti-sysc.c                         |  2 +-
>  drivers/clk/renesas/r8a7795-cpg-mssr.c        |  4 +++-
>  drivers/clk/renesas/rcar-gen2-cpg.c           |  2 +-
>  drivers/clk/renesas/rcar-gen3-cpg.c           |  2 +-
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c       |  7 ++++++-
>  drivers/dma/ti/k3-psil.c                      |  3 +++
>  drivers/dma/ti/k3-udma.c                      |  2 +-
>  drivers/gpu/drm/bridge/nwl-dsi.c              |  2 +-
>  drivers/gpu/drm/meson/meson_drv.c             |  4 +++-
>  drivers/gpu/drm/omapdrm/dss/dispc.c           |  2 +-
>  drivers/gpu/drm/omapdrm/dss/dpi.c             |  4 +++-
>  drivers/gpu/drm/omapdrm/dss/dsi.c             |  3 +++
>  drivers/gpu/drm/omapdrm/dss/dss.c             |  3 +++
>  drivers/gpu/drm/omapdrm/dss/hdmi4_core.c      |  3 +++
>  drivers/gpu/drm/omapdrm/dss/venc.c            |  4 +++-
>  drivers/gpu/drm/omapdrm/omap_drv.c            |  3 +++
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |  4 +++-
>  drivers/gpu/drm/rcar-du/rcar_lvds.c           |  2 +-
>  drivers/gpu/drm/tidss/tidss_dispc.c           |  4 +++-
>  drivers/iommu/ipmmu-vmsa.c                    |  7 +++++--
>  drivers/media/platform/rcar-vin/rcar-core.c   |  2 +-
>  drivers/media/platform/rcar-vin/rcar-csi2.c   |  2 +-
>  drivers/media/platform/vsp1/vsp1_uif.c        |  4 +++-
>  drivers/mmc/host/renesas_sdhi_core.c          |  2 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  2 +-
>  drivers/mmc/host/sdhci-of-esdhc.c             | 21 ++++++++++++++-----
>  drivers/mmc/host/sdhci-omap.c                 |  2 +-
>  drivers/mmc/host/sdhci_am654.c                |  2 +-
>  drivers/net/ethernet/renesas/ravb_main.c      |  4 +++-
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  2 +-
>  drivers/net/ethernet/ti/cpsw.c                |  2 +-
>  drivers/net/ethernet/ti/cpsw_new.c            |  2 +-
>  drivers/phy/ti/phy-omap-usb2.c                |  4 +++-
>  drivers/pinctrl/renesas/core.c                |  2 +-
>  drivers/pinctrl/renesas/pfc-r8a7790.c         |  5 ++++-
>  drivers/pinctrl/renesas/pfc-r8a7794.c         |  5 ++++-
>  drivers/soc/fsl/dpio/dpio-driver.c            | 13 ++++++++----
>  drivers/soc/renesas/r8a774c0-sysc.c           |  5 ++++-
>  drivers/soc/renesas/r8a7795-sysc.c            |  2 +-
>  drivers/soc/renesas/r8a77990-sysc.c           |  5 ++++-
>  drivers/soc/ti/k3-ringacc.c                   |  2 +-
>  drivers/staging/mt7621-pci/pci-mt7621.c       |  2 +-
>  drivers/thermal/rcar_gen3_thermal.c           |  4 +++-
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c   | 10 +++++++--
>  drivers/usb/gadget/udc/renesas_usb3.c         |  2 +-
>  drivers/usb/host/ehci-platform.c              |  4 +++-
>  drivers/usb/host/xhci-rcar.c                  |  2 +-
>  drivers/watchdog/renesas_wdt.c                |  2 +-
>  48 files changed, 131 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> index 5fae60f8c135..00c59aa217c1 100644
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -2909,7 +2909,7 @@ static int sysc_init_soc(struct sysc *ddata)
>  	}
>  
>  	match = soc_device_match(sysc_soc_feat_match);
> -	if (!match)
> +	if (!match || IS_ERR(match))
>  		return 0;
>  
>  	if (match->data)
> diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
> index c32d2c678046..90a18336a4c3 100644
> --- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
> @@ -439,6 +439,7 @@ static const unsigned int r8a7795es2_mod_nullify[] __initconst = {
>  
>  static int __init r8a7795_cpg_mssr_init(struct device *dev)
>  {
> +	const struct soc_device_attribute *match;
>  	const struct rcar_gen3_cpg_pll_config *cpg_pll_config;
>  	u32 cpg_mode;
>  	int error;
> @@ -453,7 +454,8 @@ static int __init r8a7795_cpg_mssr_init(struct device *dev)
>  		return -EINVAL;
>  	}
>  
> -	if (soc_device_match(r8a7795es1)) {
> +	match = soc_device_match(r8a7795es1);
> +	if (!IS_ERR(match) && match) {

"if (!IS_ERR_OR_NULL(match))" in all places.

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
