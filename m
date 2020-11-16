Return-Path: <SRS0=dfl9=EW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFAFC5519F
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 15:59:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3274D20A8B
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 15:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek5b06i+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3274D20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9D7AE20468;
	Mon, 16 Nov 2020 15:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yPGJHI+gWjAU; Mon, 16 Nov 2020 15:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 579FB2012F;
	Mon, 16 Nov 2020 15:59:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40514C0891;
	Mon, 16 Nov 2020 15:59:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 603FFC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 15:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4D7608672B
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 15:59:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HqKcCT2OCwuc for <iommu@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 15:59:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C69568608B
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 15:59:40 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id d12so19195023wrr.13
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 07:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=z5ur65gLeEENNkFOpp7pfGnPUJSHbI8yD0TwgMdNv0Y=;
 b=ek5b06i+kiObeO8ER7rtiAmRtiIHnS7ck1QByi8fBldniHgRqNyS+s9hpOHu4AgMPo
 TiCdS683L4b4WEVKFg8q/lKravN6yX8EnGW+11FuJIODvmeoV3nQaS5s2CsJn6WJVSI2
 xrAKcjGgZaYED7tvzsaa8W+J1+7iKDQwEW848C22xMg4kB1BuuGAs7ajjSgbBc2eRPXt
 wFBqY2n6mnVxQOFVbKCR2PkUiVxYhaBGJlyAgvOQboY1szy7LcpV0aQ5CwFwKipTyvHi
 rVxgqTU63TVh//y8wwVKARX48Q5hafdQz/Nr/ro2sHxhU3KjzQAXgjps1wqHH9dJ/VHu
 0h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=z5ur65gLeEENNkFOpp7pfGnPUJSHbI8yD0TwgMdNv0Y=;
 b=Wx3+AI1KbAJxbBIiWCktcW3z3Kj7XgejcN7zJLHrQLVdgL3Uz+wauhY6eIxw/P8BDg
 PsAfTTx+7uphUAMK8q1yeROa3ncULEAWwD89yOf9+dQov3mVdHjx+6+VvO/H2o2tJimI
 cZh9WS2PUN1oDDlYPqAhTtmMIbNfwe5sclv34vS1gUGE1qbsyl3WTo6NIbSROxmYWJYj
 WWokDJCCcp4omYJqSi2bdxzD0od2OrpOwpVYVVd+QYsxu3kRX+abmL1KdoqmGy845KyN
 VoTfOiZuJnI8EoQ7ehrUqsscbTJis70atxTeVJtMroHVqGCXuJ689Gfa+BhqCzsF/d5T
 7/xw==
X-Gm-Message-State: AOAM530widziKMGCkv1ouFxh/nkFd+vh06xooaHEeN+YBe8Z6ic4/fWR
 OCKEKeWvfo367M1JCtknM+A=
X-Google-Smtp-Source: ABdhPJwLmovywBzsrJ1BE+ohK9taILO9CTOyD86991/89fhQXG/wjeb9riDdYI5Owzd2IacBnREkdg==
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr20297381wrq.294.1605542379314; 
 Mon, 16 Nov 2020 07:59:39 -0800 (PST)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id g20sm20089864wmh.20.2020.11.16.07.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 07:59:37 -0800 (PST)
Date: Mon, 16 Nov 2020 16:59:36 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v6 3/3] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
Message-ID: <20201116155936.GE2224373@ulmo>
References: <20201106042710.55979-1-john.stultz@linaro.org>
 <20201106042710.55979-3-john.stultz@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201106042710.55979-3-john.stultz@linaro.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, iommu@lists.linux-foundation.org,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 linux-gpio@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Jon Hunter <jonathanh@nvidia.com>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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
Content-Type: multipart/mixed; boundary="===============0972942280989011395=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0972942280989011395==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 04:27:10AM +0000, John Stultz wrote:
> Allow the qcom_scm driver to be loadable as a permenent module.
>=20
> This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> ensure that drivers that call into the qcom_scm driver are
> also built as modules. While not ideal in some cases its the
> only safe way I can find to avoid build errors without having
> those drivers select QCOM_SCM and have to force it on (as
> QCOM_SCM=3Dn can be valid for those drivers).
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3:
> * Fix __arm_smccc_smc build issue reported by
>   kernel test robot <lkp@intel.com>
> v4:
> * Add "depends on QCOM_SCM || !QCOM_SCM" bit to ath10k
>   config that requires it.
> v5:
> * Fix QCOM_QCM typo in Kconfig, it should be QCOM_SCM
> ---
>  drivers/firmware/Kconfig                | 4 ++--
>  drivers/firmware/Makefile               | 3 ++-
>  drivers/firmware/qcom_scm.c             | 4 ++++
>  drivers/iommu/Kconfig                   | 2 ++
>  drivers/net/wireless/ath/ath10k/Kconfig | 1 +
>  5 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 3315e3c215864..5e369928bc567 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -235,8 +235,8 @@ config INTEL_STRATIX10_RSU
>  	  Say Y here if you want Intel RSU support.
> =20
>  config QCOM_SCM
> -	bool
> -	depends on ARM || ARM64
> +	tristate "Qcom SCM driver"
> +	depends on (ARM && HAVE_ARM_SMCCC) || ARM64
>  	select RESET_CONTROLLER
> =20
>  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 5e013b6a3692e..523173cbff335 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -17,7 +17,8 @@ obj-$(CONFIG_ISCSI_IBFT)	+=3D iscsi_ibft.o
>  obj-$(CONFIG_FIRMWARE_MEMMAP)	+=3D memmap.o
>  obj-$(CONFIG_RASPBERRYPI_FIRMWARE) +=3D raspberrypi.o
>  obj-$(CONFIG_FW_CFG_SYSFS)	+=3D qemu_fw_cfg.o
> -obj-$(CONFIG_QCOM_SCM)		+=3D qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> +obj-$(CONFIG_QCOM_SCM)		+=3D qcom-scm.o
> +qcom-scm-objs +=3D qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>  obj-$(CONFIG_TI_SCI_PROTOCOL)	+=3D ti_sci.o
>  obj-$(CONFIG_TRUSTED_FOUNDATIONS) +=3D trusted_foundations.o
>  obj-$(CONFIG_TURRIS_MOX_RWTM)	+=3D turris-mox-rwtm.o
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 7be48c1bec96d..6f431b73e617d 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1280,6 +1280,7 @@ static const struct of_device_id qcom_scm_dt_match[=
] =3D {
>  	{ .compatible =3D "qcom,scm" },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, qcom_scm_dt_match);
> =20
>  static struct platform_driver qcom_scm_driver =3D {
>  	.driver =3D {
> @@ -1295,3 +1296,6 @@ static int __init qcom_scm_init(void)
>  	return platform_driver_register(&qcom_scm_driver);
>  }
>  subsys_initcall(qcom_scm_init);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. SCM driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 04878caf6da49..c64d7a2b65134 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -248,6 +248,7 @@ config SPAPR_TCE_IOMMU
>  config ARM_SMMU
>  	tristate "ARM Ltd. System MMU (SMMU) Support"
>  	depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=3Dm this can't be =3Dy
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU if ARM

This, in conjunction with deferred probe timeout, causes mayhem on
Tegra186. The problem, as far as I can tell, is that there are various
devices that are hooked up to the ARM SMMU, but if ARM SMMU ends up
being built as a loadable module, then those devices will initialize
without IOMMU support (because deferred probe will timeout before the
ARM SMMU module can be loaded from the root filesystem).

Unfortunately, the ARM SMMU module will eventually end up being loaded
once the root filesystem has been mounted (for example via SDHCI or
Ethernet, both with using just plain, non-IOMMU-backed DMA API) and then
initialize, configuring as "fault by default", which then results from a
slew of SMMU faults from all the devices that have previously configured
themselves without IOMMU support.

One way to work around this is to just disable all QCOM-related drivers
for the build so that ARM SMMU will be built-in again. I'm going to
guess that distributions aren't going to be too happy about having to
make that kind of choice.

Another way would be for the ARM SMMU module to be included in the
initial ramdisk, which /should/ solve this as well, though I haven't
actually tested that yet. That's not ideal, because it means that users
will have to use an initial ramdisk in order to make this work, and not
all of them may want to.

Perhaps a better solution for now would be to make QCOM_SCM always
built-in, so that ARM SMMU can also always be built-in? I suspect that
this will be a problem not only on Tegra but on any platform that uses
an ARM SMMU. I think this is also not directly related to the QCOM_SCM
code because this would also happen if ARM SMMU were built as a module
for a kernel that doesn't have any QCOM drivers enabled. So in general
any configuration that builds ARM SMMU as a module seems like it would
currently be broken (if it also keeps the "fault by default" default).
Is this something that people have extensively tested? I can't see how
that would currently work, since there's no way for an ARM SMMU master
to somehow recover and switch to IOMMU-backed DMA API dynamically once
the ARM SMMU becomes available.

I guess yet another possibility would be for the ARM SMMU driver to
detect whether it was loaded after all of its consumers and switch to
"bypass by default" automatically in such a situation. That should allow
any driver probed after the ARM SMMU to still take advantage of IOVA
translation, but will not impact the devices probed before the ARM SMMU.

Thierry

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+yoeQACgkQ3SOs138+
s6EeIw/+Jkiy34v/1TaxUz5pLZYHnJwmKT1lGYDf9KdRC9vO87BZVqj5/lNO5IXa
+dyBEeU5axJ6Iyohml966Ry57AnSRjtMjeuqJCEwK0bZFZxwGe9oq9NnHmSuYPVa
MX8qpw9npa2QUFnNs3w+YE2cxcndyR6kcl3LPNNpFJ9zdAeD7S1wc9kgC69P+mV3
ZWN7koQ5I5WLfwRkOLEpV2NyuyREYw2u2KboLNt4Sy7+M5ZaGQDDsrQ6hUXT9BkF
NmaYl/ao4ukTocxLoe3Ol/mcrM8PExy4kPSnw1FAYIO5g4sXUjpzY/Ks1ajZymM6
jqeCVC+pTnSVI9E34lj01CdiZODV7Wl6cgO6GEmey7YXwf6AN2D61WPMXaA3Pryj
KSngHp099W9E7wyUj9TQlXXDWzmmiDrk2GNaxvjiU08V0ADCV+aP7I7S5723MySN
43PqFETM/omI+WWMRbdZ/pNqQENzsOhRfCo1PVyIdlfYMfu57QpP7eqXNyhvIu30
JSzz9G6TPVMtMeOlE1n9v8xHYm1jF8kb3itX1966++MniHV5SwP5MQwMfHCXk7ER
SDue3dleku/Yb0WCPGCRF3oMzHV/cELFtsQmRUerXHSgvmc0Auq3YMhqfzoTVb1s
quggJ16RzZOdPqMecJoPOeJPTlpjGER1HNvwiLPAY2+U0GAPZcM=
=oQiu
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--

--===============0972942280989011395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0972942280989011395==--
