From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: Seeing conflict with IPMMU driver under ACPI
Date: Tue, 19 Sep 2017 09:49:21 +0300
Message-ID: <2844194.3pNGIKcM4n@avalon>
References: <CAA01098-8301-4703-84CE-5CFA8A68AF13@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAA01098-8301-4703-84CE-5CFA8A68AF13@caviumnetworks.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Jasty, Ananth" <Ananth.Jasty@cavium.com>
Cc: "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, dann frazier <dann.frazier@canonical.com>, "laurent.pinchart+renesas@ideasonboard.com" <laurent.pinchart+renesas@ideasonboard.com>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

Hi Ananth,

On Tuesday, 19 September 2017 03:43:05 EEST Jasty, Ananth wrote:
> Hi, with your IPMMU driver enabled under 4.13 we=E2=80=99re seeing a cras=
h on boot:
>=20
> [ 13.785164] Unable to handle kernel NULL pointer dereference at virtual
> address 00000018
> [ 13.793254] [0000000000000018] user address but active_mm is swapper
> [ 13.799600] Internal error: Oops: 96000004 [#1] SMP
> [ 13.804466] Modules linked in: aes_neon_bs aes_neon_blk crypto_simd cryp=
td
> [ 13.811334] CPU: 152 PID: 1529 Comm: kworker/152:1 Not tainted
> 4.13.0-9-generic #10-Ubuntu
> [ 13.819584] Hardware name: Default string Cavium ThunderX2/Default strin=
g,
> BIOS 5.13 07/20/2017
> [ 13.828285] Workqueue: events deferred_probe_work_func
> [ 13.833410] task: ffff80bee93d0000 task.stack: ffff80bee93dc000
> [ 13.839330] PC is at iommu_ops_from_fwnode+0x4c/0x90
> [ 13.844282] LR is at iommu_ops_from_fwnode+0x28/0x90
>=20
> The ARM SMMUv3 driver (which our platform implements) seems to be losing
> iommu_ops to the IPMMU driver.

You seem not to be the first one to notice:

https://patchwork.kernel.org/patch/9956449/

> Note: our platform uses ACPI for device enumeration.
>=20
> I have no way to test this, but is there a reason the set_iommu isn=E2=80=
=99t in
> _probe?

I can't recall what the reason was I'm afraid.

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 2a38aa1..d4c72da 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1066,6 +1066,9 @@ static int ipmmu_probe(struct platform_device *pdev)
>=20
>         platform_set_drvdata(pdev, mmu);
>=20
> +       if (!iommu_present(&platform_bus_type))
> +               bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> +
>         return 0;
>  }
>=20
> @@ -1108,9 +1111,6 @@ static int __init ipmmu_init(void)
>         if (ret < 0)
>                 return ret;
>=20
> -       if (!iommu_present(&platform_bus_type))
> -               bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> -
>         return 0;
>  }
>=20
>=20
> If I=E2=80=99m wrong, my apologies.

=2D-=20
Regards,

Laurent Pinchart
