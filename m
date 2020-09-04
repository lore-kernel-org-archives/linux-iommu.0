Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C33C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 12:19:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B2A2137B
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS/byoFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B2A2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 52A2B86E1C;
	Fri,  4 Sep 2020 12:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hkrV5CpOLMiH; Fri,  4 Sep 2020 12:19:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4426586670;
	Fri,  4 Sep 2020 12:19:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19512C07FF;
	Fri,  4 Sep 2020 12:19:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 959C9C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 12:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8A61B86DBC
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 12:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 41MeJ+X9KJhQ for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 12:19:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7F63086DB2
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 12:19:53 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id q21so5911553edv.1
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xpMuN6oufyDsPAKl7hqAVZXkONbQHQ1IA1e69CcugwI=;
 b=VS/byoFLeR9gTw/tfqWAMD+WnTiGH4K21Z/4suj5vpyhN4kjKp7gDA90GmeDX8Qg5V
 6FmxgLfqRbYdVIf+/zpUr3/EGORx/5pNL2nUvdcoVUQQfCX/3kw/BZLt4d1asqkax/8T
 XfySzac9YJ+V3wtMhCkKP9mgTGM66voPz9+00PCeUmqOGpHetIcPgi0Rx3NCmToTNnTD
 VRdcyU4+JklxYByZ9XcyapKWe3MH+ocHmezSg2mzIOTA8V9/m0ipPI+L7Av1/+/j5AiV
 1nJEn4ZMDtxFL4AHMLSuniTAnoo/MPZaJ9MYfmy7VsRD0cIW5dFINa2GydcsPI7Gr3Hl
 dzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xpMuN6oufyDsPAKl7hqAVZXkONbQHQ1IA1e69CcugwI=;
 b=qYKWvSYEjQHIDOXKyf3J7BNNSi6Ww1Yrs2mDJaxrfr2O36ZjOxmguwDajn7WYJYaHv
 1iRAwlbvTxSlLwn2WAhwhjd0VRSsBPJO2YxyIMDm77Tte+nkvxj58/6xTGBymU3O/qeE
 2lcPNTWCGvXYKxOQKjKjH5WksMblFkWRfHNOCXrJG09MDHW8OOmO/U3aMQLNs9tX50An
 MxnXPh2t9oDbVB2L/z/pMpfFusFQcqOuRmGLdTBggBk+k5ZIGp8Q0ziMAosSvE3eAVLD
 5ONJmATkeIuPvdobPUYg0GPBe6NKac1lzffeMKLQUiL7YKEUOlLYTXMaRnSk6tgkEGN4
 nuqA==
X-Gm-Message-State: AOAM531iD3ij7txZ9i/51bjasrJ5WN2kog/jDFvNK40iLGDsgDDf9jkw
 9L1Jrle5Sa/Q0f3PaKrxPx8=
X-Google-Smtp-Source: ABdhPJzuwMBGdBk9IYYGRNIj0xeJachDfQfz2WniTevu+3xzRvwqoytHGkTtUp2e0fxhiAgvCksl0A==
X-Received: by 2002:a05:6402:503:: with SMTP id
 m3mr8390126edv.45.1599221991805; 
 Fri, 04 Sep 2020 05:19:51 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id x10sm5740082eds.21.2020.09.04.05.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 05:19:50 -0700 (PDT)
Date: Fri, 4 Sep 2020 14:19:49 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v5] iommu/tegra-smmu: Add locking around mapping operations
Message-ID: <20200904121949.GA570531@ulmo>
References: <20200901203730.27865-1-digetx@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200901203730.27865-1-digetx@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============6907215904475706481=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6907215904475706481==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 11:37:30PM +0300, Dmitry Osipenko wrote:
> The mapping operations of the Tegra SMMU driver are subjected to a race
> condition issues because SMMU Address Space isn't allocated and freed
> atomically, while it should be. This patch makes the mapping operations
> atomic, it fixes an accidentally released Host1x Address Space problem
> which happens while running multiple graphics tests in parallel on
> Tegra30, i.e. by having multiple threads racing with each other in the
> Host1x's submission and completion code paths, performing IOVA mappings
> and unmappings in parallel.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>=20
> Changelog:
>=20
> v5: - Replaced GFP_NOWAIT check with __GFP_ATOMIC to fix "sleep in
>       atomic context" warnings, NOWAIT !=3D ATOMIC.
>=20
> v4: - Returned to use spinlock, but now using a smarter allocation
>       logic that performs allocation in a sleeping context whenever
>       possible.
>=20
>     - Removed the stable tag because patch isn't portable as-is
>       since the arguments of map/unmap() callbacks changed recently.
>       Perhaps we could just ignore older kernels for now. It will be
>       possible to fix older kernels with a custom patch if will be needed.
>=20
> v3: - No changes. Resending for visibility.
>=20
>  drivers/iommu/tegra-smmu.c | 95 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 84 insertions(+), 11 deletions(-)

Seems to work fine. Tested on Jetson TX1 with display and GPU, which are
the primary users of the SMMU.

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9SMOIACgkQ3SOs138+
s6H9aA/+POA3gKeeFXU13V+vbYgFzYonGue9SVkjCLeoT91VnE/GC8951N6yBoU+
LuxfBZj1l3O52ICRMHIAX4A1SRrHdhoPvj3GsDWdCpxuVinvlm3ZpsIq+klF2yfp
jmuzRCKisOr0cWz+WUbMEjSu5E4IIFQOjaG4pejbKuma7bcVLisSTtlXorgGp29+
4MCueGk+BVMdGqr7dw+9J6fdFk2v5JWN/UT9rFsLrMTkvZ3JwAKUHRDq0W9iItZN
EIGy+FBETildbjBMBplBUxF00U7JedZuvqfEyZUYPxX3VkiAx0+b5bf3CKySRYYT
ew16Kcv99xqpI9pCoVfQW57b28lX3HJ/okOuFx+zDE24jfX9cMJJ5y9Jr+za3CN6
rCtILMNBCQQIlgkXgePW4EQuGhHYtbc7CEfHQ6Mam7ePlteZq72yOURxszSz5t2f
fun4hdomQNYQY/6yEYd90HGtf7mdKOiIlezNwx/xWyE+PWk8u8LUHcY3VY/ymE07
ZfajZTDFr/fz3Bz/pAPRPJt0YgIPeg+PjNESa1HB3RKyxBCCeo8F4gA9KSc6K2ve
fX5EqIbZx0ZbGFciLgR3liIOLd3KvDUKfTarRfXjKyb4EIOosb4R8ZE2WDBe8qDF
UxolffLfQYAXanJ8rpduYEuWG0gIBMsGPzuE21RTg9Os5erG1ng=
=i6XW
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

--===============6907215904475706481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6907215904475706481==--
