From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 linux-next] iommu: Enable LPAE pagetable on ARM and ARM64 only
Date: Tue, 24 Feb 2015 02:23:48 +0200
Message-ID: <6851919.VIGEV8htgx@avalon>
References: <3203874.zEMjzr0PS0@avalon> <1424737221-1193-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1424737221-1193-1-git-send-email-vincent.stehle@laposte.net>
Sender: linux-next-owner@vger.kernel.org
To: Vincent =?ISO-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc: iommu@lists.linux-foundation.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 24 February 2015 01:20:21 Vincent Stehl=E9 wrote:
> LPAE iommu page table makes sense only for ARM and ARM64 architecture=
s. Add
> the corresponding dependency in Kconfig (and enable for COMPILE_TEST,=
 too,
> as per Laurent's suggestion).
>=20
> Signed-off-by: Vincent Stehl=E9 <vincent.stehle@laposte.net>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Will Deacon <will.deacon@arm.com>

Now,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>=20
> On 02/24/2015 01:02 AM, Laurent Pinchart wrote:
> > Shouldn't this be ARM || ARM64 || COMPILE_TEST ?
>=20
> Hi Laurent,
>=20
> It makes perfect sense; thanks. I completely forgot, as I have yet to=
 see
> one of those. Here is v3 of the patch.
>=20
> Best regards,
>=20
> V.
>=20
>=20
> Changes since v2:
> - Add condition on ARM64
>=20
> Changes since v1:
> - Add condition on COMPILE_TEST
>=20
>=20
>  drivers/iommu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index baa0d97..a440922 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -22,6 +22,7 @@ config IOMMU_IO_PGTABLE
>=20
>  config IOMMU_IO_PGTABLE_LPAE
>  	bool "ARMv7/v8 Long Descriptor Format"
> +	depends on ARM || ARM64 || COMPILE_TEST
>  	select IOMMU_IO_PGTABLE
>  	help
>  	  Enable support for the ARM long descriptor pagetable format.

--=20
Regards,

Laurent Pinchart
