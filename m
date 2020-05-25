Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93D9C433E0
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 08:36:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AA02071A
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 08:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsx2pZd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AA02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6404A86246;
	Mon, 25 May 2020 08:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FXlhyiDlgco4; Mon, 25 May 2020 08:36:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A1E9D8637A;
	Mon, 25 May 2020 08:36:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BD49C0865;
	Mon, 25 May 2020 08:36:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B35ACC016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 08:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AE9408637A
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 08:36:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0n9Hy8yuMFqE for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 08:36:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5EB8586246
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 08:36:00 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id j21so19692674ejy.1
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 01:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jQ/1T19bXnZaakT7DH/kq2gJWYm88BN6q+0IdQ40jHg=;
 b=rsx2pZd8wxkoDGQhj/794PwNEe74GuAHRMtWvDBkMmQZCL9cF92qoX/3qFeN9O+et4
 SygvEPvI2P2orOWR3kWalcCWEEv2xfa2myWd8EzT+NUnIhZYW2CBmZEx7vV4dlQMF9nz
 0d2OLsKIm/8/v6PM3AFBBE6ESvEOMyvblBh17GnHAgJneOpZhzyqRWBKmTtYQzUZp+hx
 Q2ga83CuHFn2qOcno8r5B3A47Mk13CAYh49sCp5+GNW2hSge7JEAWW7an6XdWRKWaItM
 GEueSyWX870sZTv6+ED6SBgFjfdCjXi6Ghq2UD7mYY5VWXEaUvV+ikGlWT/Ozh+jv5uV
 Xwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jQ/1T19bXnZaakT7DH/kq2gJWYm88BN6q+0IdQ40jHg=;
 b=oFq+f+f0ddoAMEVhXwjkYph72OwcobEF+1EuC9j/Sq/wCXxUT1ZfBTnrZ5yikZ/zBZ
 NxqC8ldw+4FX3cxPB1yv3C8JfMEo/tGcdsvqhz6SzeyXruj8hOwFZOwDl0OUAdebGG7n
 VXd6d3OErhRaJ8XQg0/nsegYoSvANQRaUeEQ3Xb2Vt1jTMa0QFbA0oFS9VlHnjolNJn6
 ZRlhbviQtuidT8QqpxDPzNxVJsa+s0cSFuadqY+tHHlv4pxWzRmgCROnMiHd6EFv7vrp
 I6lRuf24lDx40tS8xTdOLz/zEHoweN/U1bTCfFvBPv2R38JMrHLIXne1U/DobXlu/5DN
 L74A==
X-Gm-Message-State: AOAM531gGosCJD1EfcoqG9C8JW6AMAXCVlHQI10dugwx1jvtetOZ73JI
 HF6zsLBcUvDx/2Lr8KoskCA=
X-Google-Smtp-Source: ABdhPJzQwaND4vhb1xrd9qgq+0Mdu8VnEgf/VQ6+ZiPeYqLMNuz0AufHgS5BzjTmR0a3Sy+SGa2HWg==
X-Received: by 2002:a17:906:814b:: with SMTP id
 z11mr16879427ejw.531.1590395758662; 
 Mon, 25 May 2020 01:35:58 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
 by smtp.gmail.com with ESMTPSA id bz15sm14483994ejc.64.2020.05.25.01.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 01:35:57 -0700 (PDT)
Date: Mon, 25 May 2020 10:35:56 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1] iommu/tegra-smmu: Add missing locks around mapping
 operations
Message-ID: <20200525083556.GA2382769@ulmo>
References: <20200524183755.3774-1-digetx@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200524183755.3774-1-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============7671337750810730311=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7671337750810730311==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2020 at 09:37:55PM +0300, Dmitry Osipenko wrote:
> The mapping operations of the Tegra SMMU driver are subjected to a race
> condition issues because SMMU Address Space isn't allocated and freed
> atomically, while it should be. This patch makes the mapping operations
> atomic, it fixes an accidentally released Host1x Address Space problem
> which happens while running multiple graphics tests in parallel on
> Tegra30, i.e. by having multiple threads racing with each other in the
> Host1x's submission and completion code paths, performing IOVA mappings
> and unmappings in parallel.
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 43 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 7426b7666e2b..4f956a797838 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/dma-mapping.h>
> =20
>  #include <soc/tegra/ahb.h>
> @@ -49,6 +50,7 @@ struct tegra_smmu_as {
>  	struct iommu_domain domain;
>  	struct tegra_smmu *smmu;
>  	unsigned int use_count;
> +	spinlock_t lock;
>  	u32 *count;
>  	struct page **pts;
>  	struct page *pd;
> @@ -308,6 +310,8 @@ static struct iommu_domain *tegra_smmu_domain_alloc(u=
nsigned type)
>  		return NULL;
>  	}
> =20
> +	spin_lock_init(&as->lock);
> +
>  	/* setup aperture */
>  	as->domain.geometry.aperture_start =3D 0;
>  	as->domain.geometry.aperture_end =3D 0xffffffff;
> @@ -578,7 +582,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_=
addr_t iova,
>  		struct page *page;
>  		dma_addr_t dma;
> =20
> -		page =3D alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
> +		page =3D alloc_page(GFP_ATOMIC | __GFP_DMA | __GFP_ZERO);

I'm not sure this is a good idea. My recollection is that GFP_ATOMIC
will allocate from a special reserved region of memory, which may be
easily exhausted.

Is there any reason why we need the spinlock? Can't we use a mutex
instead?

>  		if (!page)
>  			return NULL;
> =20
> @@ -655,8 +659,9 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *=
as, unsigned long iova,
>  	smmu_flush(smmu);
>  }
> =20
> -static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iov=
a,
> -			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +static int
> +tegra_smmu_map_locked(struct iommu_domain *domain, unsigned long iova,
> +		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)

I think it's more typical to use the _unlocked suffix for functions that
don't take a lock themselves.

>  {
>  	struct tegra_smmu_as *as =3D to_smmu_as(domain);
>  	dma_addr_t pte_dma;
> @@ -685,8 +690,9 @@ static int tegra_smmu_map(struct iommu_domain *domain=
, unsigned long iova,
>  	return 0;
>  }
> =20
> -static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned lon=
g iova,
> -			       size_t size, struct iommu_iotlb_gather *gather)
> +static size_t
> +tegra_smmu_unmap_locked(struct iommu_domain *domain, unsigned long iova,
> +			size_t size, struct iommu_iotlb_gather *gather)
>  {
>  	struct tegra_smmu_as *as =3D to_smmu_as(domain);
>  	dma_addr_t pte_dma;
> @@ -702,6 +708,33 @@ static size_t tegra_smmu_unmap(struct iommu_domain *=
domain, unsigned long iova,
>  	return size;
>  }
> =20
> +static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iov=
a,
> +			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +{
> +	struct tegra_smmu_as *as =3D to_smmu_as(domain);
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&as->lock, flags);
> +	ret =3D tegra_smmu_map_locked(domain, iova, paddr, size, prot, gfp);
> +	spin_unlock_irqrestore(&as->lock, flags);
> +
> +	return ret;
> +}
> +
> +static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned lon=
g iova,
> +			       size_t size, struct iommu_iotlb_gather *gather)
> +{
> +	struct tegra_smmu_as *as =3D to_smmu_as(domain);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&as->lock, flags);
> +	size =3D tegra_smmu_unmap_locked(domain, iova, size, gather);
> +	spin_unlock_irqrestore(&as->lock, flags);
> +
> +	return size;
> +}

Why the extra functions here? We never call locked vs. unlocked variants
in the driver and the IOMMU framework only has a single callback, so I
think the locking can just move into the main implementation.

Thierry

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Lg2kACgkQ3SOs138+
s6F2gQ//eHJZIvBIrliCm/OVpD0ZDodUlg7jxmVdBBCH8SMkbQPXgQhO5YhpHMRq
LdOAztHnqXwDn+zt+XM3UvMJFoUivCC70GDsOXu9JYRmDMSlH+uE01YGSpC4Rmig
TZ9KDzarm4EDL7dC9XFOEQguI5LGXtcmwct45oDSXZ/28zcTMj0Od6SgazVOuL1i
z+jexSPTCoCtBabxvG4BQoolonhl8xpAG53ijryPJKyID4BH7oc+Q3+vAmc1FJII
iQ67Wi9hhmS9vcqld08KcAspAA6ZAMBHq6dTz/JzptON63FZ80bdmgHUgL6y8szy
Epf4AMWT4xMQCfOk47J1K3XtpEW+ic9guL3J4KL74bFJp89JgOIY8iRtnSyiMu3h
xw6omwr7mDCHt/P5U5W2D7UvvhTxJ6eMh3oHicbJbbbKLzDIkvemNvLpXvCZD2Pl
uOJl6RnGm1/LFyVdBXHt/xzGvw5+hv/tMIDrIc3q+se01IO0zTA31WNB2MxE6jFw
3mbfHV+LQzuXVgQJYzr8qGXLMSuW9E4tdt55bTCK79dDUr5coiczjSkcKMYy2kHA
syrAkY5m54tscMcnwBdIxqw7DVNJSRw54mWs6FO/K+oNNZxuBFPYYfpXQouMh+K/
PPxk8x307iPiOYlvXPF1wS4Za4Zx1vIpfrxvK6h5ddSdFdky9nQ=
=h3MX
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

--===============7671337750810730311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7671337750810730311==--
