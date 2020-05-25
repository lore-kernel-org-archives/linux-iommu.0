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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11430C433DF
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 12:20:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DA32054F
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 12:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di+qYWJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DA32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9D2EE86B0E;
	Mon, 25 May 2020 12:20:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ThvJDL6xxbQw; Mon, 25 May 2020 12:20:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5055986B19;
	Mon, 25 May 2020 12:20:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1098FC0865;
	Mon, 25 May 2020 12:20:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC22FC016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 12:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A6CF5203D8
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 12:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jrmYRX+tQHgx for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 12:20:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 6981E203D3
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 12:20:20 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id g9so14833734edr.8
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MXosGYmUHtAEFYy6jSs8p/66T53afUQWxzk9JcrKto0=;
 b=di+qYWJmJWURxKMHFLZPYn9vEgLW9TgdmNafxRBUSTOUr+hcnAuz6x7tKiO5c0SoaQ
 OH2rahlHeYaoPNTbAFm32lwVTo9uokNyeq2ivYGvikyzxo7pPweDoFjOglG6JYeiXzaV
 7q9jU4xOAsElIdnFMyKYpH9j7VgfwoTQ8yOsvdq4JgTRAp7vqyhXHxAClix4fdFDlI3T
 MJ/PfO/R0Nf8BafVmxc/t185yxYelvw9qW1DgGsD4N/EDc5hFeC9YRqVbUiGVn4W+hzE
 PRJ0Xt1C5EAZ1W6qjIUgfUCc2H34qj8a3JvTIxFD2O8eLFKctX9kq7PW0sps1GgnESQE
 b09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MXosGYmUHtAEFYy6jSs8p/66T53afUQWxzk9JcrKto0=;
 b=pR3oOOJcP8j2ox9cNYCENRoyOTivDULy0rtwDlGNYy0DuE6YED9Fl7XECLR+1Hgwi5
 3Qf/4GnYnecZp9KDqscJP5SmnmWUELMtJiM+kVzIHGiyBcKmH7f8h52FO+4+dyWJuEsk
 GfqSuyy/j9ifbMI8aLQBky/oCEla7+sd/jTXag34VuIgshgqAKmF42sI/00zMUM8E37R
 tjZJnKr7FduZhcncLBz9CqPpQL+cC2u5D+OFEI5Jg2CDxo3nPGrMKdCP60qrZePLNhif
 E5YXrS/9nnubKyK0uvpDgZvfhBDnYTIIPvBbZxVwpDAMHtLBTuf9NAnAfog6V/WxRYsz
 OjAQ==
X-Gm-Message-State: AOAM533vInBAK1dBLdqx3mxdHKB+jYgNNGvsipCjIP87FzQiGoAEkqMS
 grtgr8fto0hVDe5Q6NHrOJU=
X-Google-Smtp-Source: ABdhPJy95EUTa2j78zUhTsbgmTzsuGIlDPTbLDugPENf5wMLJV/BUvunl6QfUF72P3ereYITcrV9jw==
X-Received: by 2002:aa7:ca13:: with SMTP id y19mr14478891eds.30.1590409218639; 
 Mon, 25 May 2020 05:20:18 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
 by smtp.gmail.com with ESMTPSA id w4sm15210295edx.66.2020.05.25.05.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 05:20:17 -0700 (PDT)
Date: Mon, 25 May 2020 14:20:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1] iommu/tegra-smmu: Add missing locks around mapping
 operations
Message-ID: <20200525122016.GB2393266@ulmo>
References: <20200524183755.3774-1-digetx@gmail.com>
 <20200525083556.GA2382769@ulmo>
 <ffa2f98f-1809-e4f0-009e-d06dcde0ed49@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ffa2f98f-1809-e4f0-009e-d06dcde0ed49@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4698228091344694403=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4698228091344694403==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 01:51:50PM +0300, Dmitry Osipenko wrote:
> 25.05.2020 11:35, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, May 24, 2020 at 09:37:55PM +0300, Dmitry Osipenko wrote:
> >> The mapping operations of the Tegra SMMU driver are subjected to a race
> >> condition issues because SMMU Address Space isn't allocated and freed
> >> atomically, while it should be. This patch makes the mapping operations
> >> atomic, it fixes an accidentally released Host1x Address Space problem
> >> which happens while running multiple graphics tests in parallel on
> >> Tegra30, i.e. by having multiple threads racing with each other in the
> >> Host1x's submission and completion code paths, performing IOVA mappings
> >> and unmappings in parallel.
> >>
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/iommu/tegra-smmu.c | 43 +++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 38 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> >> index 7426b7666e2b..4f956a797838 100644
> >> --- a/drivers/iommu/tegra-smmu.c
> >> +++ b/drivers/iommu/tegra-smmu.c
> >> @@ -12,6 +12,7 @@
> >>  #include <linux/of_device.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/slab.h>
> >> +#include <linux/spinlock.h>
> >>  #include <linux/dma-mapping.h>
> >> =20
> >>  #include <soc/tegra/ahb.h>
> >> @@ -49,6 +50,7 @@ struct tegra_smmu_as {
> >>  	struct iommu_domain domain;
> >>  	struct tegra_smmu *smmu;
> >>  	unsigned int use_count;
> >> +	spinlock_t lock;
> >>  	u32 *count;
> >>  	struct page **pts;
> >>  	struct page *pd;
> >> @@ -308,6 +310,8 @@ static struct iommu_domain *tegra_smmu_domain_allo=
c(unsigned type)
> >>  		return NULL;
> >>  	}
> >> =20
> >> +	spin_lock_init(&as->lock);
> >> +
> >>  	/* setup aperture */
> >>  	as->domain.geometry.aperture_start =3D 0;
> >>  	as->domain.geometry.aperture_end =3D 0xffffffff;
> >> @@ -578,7 +582,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, d=
ma_addr_t iova,
> >>  		struct page *page;
> >>  		dma_addr_t dma;
> >> =20
> >> -		page =3D alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
> >> +		page =3D alloc_page(GFP_ATOMIC | __GFP_DMA | __GFP_ZERO);
> >=20
> > I'm not sure this is a good idea. My recollection is that GFP_ATOMIC
> > will allocate from a special reserved region of memory, which may be
> > easily exhausted.
>=20
> So far I haven't noticed any problems. Will be great if you could
> provide more details about the pool size and how this exhaustion problem
> could be reproduced in practice.

I can't exactly pinpoint where that pool is created nor what its size
is, but just from looking at:

	Documentation/core-api/memory-allocation.rst

and searching for GFP_ATOMIC it says:

  * If you think that accessing memory reserves is justified and the kernel
    will be stressed unless allocation succeeds, you may use ``GFP_ATOMIC``.

That doesn't sound like the case that we're running into here. It sounds
to me like GFP_ATOMIC should really only be used in cases where
interrupts are being processed or where allocations really need to be
successful to ensure the system keeps operational (i.e. during handling
of severe errors, ...). Failure to allocate a page directory is hardly
very critical.

> > Is there any reason why we need the spinlock? Can't we use a mutex
> > instead?
>=20
> This is what other IOMMU drivers do. I guess mutex might be too
> expensive, it may create a noticeable contention which you don't want to
> have in a case of a GPU submission code path.

I see indeed that many other drivers seem to heavily make use of
GFP_ATOMIC. But that doesn't necessarily mean that it's the right thing
to do on Tegra (or for the other drivers for that matter).

Do we have a good way to find out how bad exactly the contention would
be when using a mutex?

> I also suspect that drivers of other platforms are using IOMMU API in
> interrupt context, although today this is not needed for Tegra.
>=20
> >>  		if (!page)
> >>  			return NULL;
> >> =20
> >> @@ -655,8 +659,9 @@ static void tegra_smmu_set_pte(struct tegra_smmu_a=
s *as, unsigned long iova,
> >>  	smmu_flush(smmu);
> >>  }
> >> =20
> >> -static int tegra_smmu_map(struct iommu_domain *domain, unsigned long =
iova,
> >> -			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> >> +static int
> >> +tegra_smmu_map_locked(struct iommu_domain *domain, unsigned long iova,
> >> +		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> >=20
> > I think it's more typical to use the _unlocked suffix for functions that
> > don't take a lock themselves.
>=20
> Personally I can't feel the difference. Both variants are good to me. I
> can replace the literal postfix with a __tegra_smmu prefix, similarly to
> what we have in the GART driver, to avoid bikeshedding.

In my opinion a function name is most useful when it describes what the
function does. To me, an _unlocked suffix indicates that the function
itself doesn't lock, and therefore it needs to be called with some
specific lock already held.

Conversely, a _locked suffix indicates that the function will itself
take that specific lock and hence it can be used without taking any
extra care about locking.

With that interpretation the code below (taking a lock and then calling
a "_locked" function) seems like a bug on the surface.

Admittedly that's somewhat subjective. The __ prefix seems like a good
way to avoid some of the ambiguity, since it's probably an even more
common  theme.

>=20
> >>  {
> >>  	struct tegra_smmu_as *as =3D to_smmu_as(domain);
> >>  	dma_addr_t pte_dma;
> >> @@ -685,8 +690,9 @@ static int tegra_smmu_map(struct iommu_domain *dom=
ain, unsigned long iova,
> >>  	return 0;
> >>  }
> >> =20
> >> -static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned =
long iova,
> >> -			       size_t size, struct iommu_iotlb_gather *gather)
> >> +static size_t
> >> +tegra_smmu_unmap_locked(struct iommu_domain *domain, unsigned long io=
va,
> >> +			size_t size, struct iommu_iotlb_gather *gather)
> >>  {
> >>  	struct tegra_smmu_as *as =3D to_smmu_as(domain);
> >>  	dma_addr_t pte_dma;
> >> @@ -702,6 +708,33 @@ static size_t tegra_smmu_unmap(struct iommu_domai=
n *domain, unsigned long iova,
> >>  	return size;
> >>  }
> >> =20
> >> +static int tegra_smmu_map(struct iommu_domain *domain, unsigned long =
iova,
> >> +			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> >> +{
> >> +	struct tegra_smmu_as *as =3D to_smmu_as(domain);
> >> +	unsigned long flags;
> >> +	int ret;
> >> +
> >> +	spin_lock_irqsave(&as->lock, flags);
> >> +	ret =3D tegra_smmu_map_locked(domain, iova, paddr, size, prot, gfp);
> >> +	spin_unlock_irqrestore(&as->lock, flags);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned =
long iova,
> >> +			       size_t size, struct iommu_iotlb_gather *gather)
> >> +{
> >> +	struct tegra_smmu_as *as =3D to_smmu_as(domain);
> >> +	unsigned long flags;
> >> +
> >> +	spin_lock_irqsave(&as->lock, flags);
> >> +	size =3D tegra_smmu_unmap_locked(domain, iova, size, gather);
> >> +	spin_unlock_irqrestore(&as->lock, flags);
> >> +
> >> +	return size;
> >> +}
> >=20
> > Why the extra functions here? We never call locked vs. unlocked variants
> > in the driver and the IOMMU framework only has a single callback, so I
> > think the locking can just move into the main implementation.
>=20
> Because this makes code cleaner, easier to read and follow. You don't
> need to care about handling error code paths. This is the same what we
> do in the GART driver. Pretty much every other IOMMU driver use this
> code pattern as well.

Alright, I don't mind very much. It just seemed odd to have that extra
function that doesn't really do anything.

Thierry

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Lt/0ACgkQ3SOs138+
s6GD5w//XJ8dxXtLk7rUsBl81rwhujPpPYRZeLZd63bOlUQYYC7i0f7djSh++QFi
X5DkmQZvUNcpdS11QAK5VZZZU7PVb+7Y6Ee8SDGVRA2xl9Rp/FbTTN+w9fnBG5NO
9M0mT4JJoJBEUI1TInuBOjzKi+4zpeYKnJcfvD99Xr0+Rcy1Hw4FNVNxAMNe3Jl+
KSuYkuFr/vRO5n/I9sw6C74WQ1/dqxxGfs38kDCTYmNAyga//C8Q+XCcwrUavQ/t
8gcQyEVeS/DWkAe1dfE3W9PV1QNCeknFI6ov0YqGkzmQUpNIq4eq8zAo1uN7Azpm
fPap9SrMANeTuxf9qR2YuyoPmt5TnE+1+BiErO/bRVEOLHwGJox7htj4pG2cMKkd
E618VQ5Zbn8/6iqe7O/zCj1uK5MU0+jyDxv4cJO4xEWdPSb3tswTMG1cJPmy3YBM
1dEW4p/mhXGrEx6yt1m/+0/SVWfS3zGN968zmvq43OVBxedxVAL8H77Hpj8GvoZ+
GtUVngpfJFUh6eoWcatOnuO1Rv1hceLbrmeihlXGns//tESibwiyQcDgkbsLARYC
T2H+E1PjqF74SJ7vfHIQEBZ+IwaCaygH/2ZTthps23r5kxoOx6j3LP4LRioa3CLi
HphJwhVN7peUN3jqzsa4LkYlS/ocjN5IR88X+7G1d6LVKSrYv0w=
=HzoQ
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--

--===============4698228091344694403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4698228091344694403==--
