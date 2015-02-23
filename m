From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 linux-next] iommu: Enable LPAE pagetable on ARM only
Date: Tue, 24 Feb 2015 01:58:17 +0200
Message-ID: <4372575.Lr7FssDpKu@avalon>
References: <2868840.GyWYJOzqWH@avalon> <1424735721-32313-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1424735721-32313-1-git-send-email-vincent.stehle@laposte.net>
Sender: linux-next-owner@vger.kernel.org
To: Vincent =?ISO-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc: iommu@lists.linux-foundation.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Vincent,

Thank you for the patch.

On Tuesday 24 February 2015 00:55:21 Vincent Stehl=E9 wrote:
> LPAE iommu page table makes sense only for ARM architecture. Add the
> corresponding dependency in Kconfig (and enable for COMPILE_TEST, too=
, as
> per Laurent's suggestion).
>=20
> Signed-off-by: Vincent Stehl=E9 <vincent.stehle@laposte.net>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>=20
> Changes since v1:
> - Add condition on COMPILE_TEST
>=20
>  drivers/iommu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index baa0d97..27cd88d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -22,6 +22,7 @@ config IOMMU_IO_PGTABLE
>=20
>  config IOMMU_IO_PGTABLE_LPAE
>  	bool "ARMv7/v8 Long Descriptor Format"
> +	depends on ARM || COMPILE_TEST
>  	select IOMMU_IO_PGTABLE
>  	help
>  	  Enable support for the ARM long descriptor pagetable format.

--=20
Regards,

Laurent Pinchart
