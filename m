From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH V3 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Fri, 8 Feb 2019 15:51:59 +0100
Message-ID: <20190208145159.GA17854@aepfle.de>
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lantianyu1986@gmail.com
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com, kys@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com, sashal@kernel.org, dan.carpenter@oracle.com
List-Id: iommu@lists.linux-foundation.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Feb 07, lantianyu1986@gmail.com wrote:

> +++ b/drivers/iommu/Kconfig
> +config HYPERV_IOMMU
> +	bool "Hyper-V x2APIC IRQ Handling"
> +	depends on HYPERV
> +	select IOMMU_API
> +	help


Consider adding 'default HYPERV' like some other drivers already do it.

Olaf

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXF2XjAAKCRBdQqD6ppg2
fmGcAJ9YHvrop3zssh0S9nzhUQtTdp2DvQCfeSlpubU2Zx7jnb8G+URfPb4FQDg=
=ilV3
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
