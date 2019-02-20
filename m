From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH] iommu/dmar: fix buffer overflow during PCI bus
 notification
Date: Wed, 20 Feb 2019 19:17:45 +0000
Message-ID: <20190220191744.GC1076@jcartwri.amer.corp.natinst.com>
References: <20190220164630.11087-1-julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220164630.11087-1-julia@ni.com>
Content-Language: en-US
Content-ID: <ECF6261C902C224A8193E495D6ADE262@namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 20, 2019 at 10:46:31AM -0600, Julia Cartwright wrote:
> Commit 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI
> device path") changed the type of the path data, however, the change in
> path type was not reflected in size calculations.  Update to use the
> correct type and prevent a buffer overflow.
>=20
> This bug manifests in systems with deep PCI hierarchies, and can lead to
> an overflow of the static allocated buffer (dmar_pci_notify_info_buf),
> or can lead to overflow of slab-allocated data.
>=20
>    BUG: KASAN: global-out-of-bounds in dmar_alloc_pci_notify_info+0x1d5/0=
x2e0
>    Write of size 1 at addr ffffffff90445d80 by task swapper/0/1
>    CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.14.87-rt49-0=
2406-gd0a0e96 #1
>    Call Trace:
>     ? dump_stack+0x46/0x59
>     ? print_address_description+0x1df/0x290
[..]
>    The buggy address belongs to the variable:
>     dmar_pci_notify_info_buf+0x40/0x60
>=20
> Fixes: 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI devic=
e path")
> Signed-off-by: Julia Cartwright <julia@ni.com>
> ---
>  drivers/iommu/dmar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 6b7df25e1488..9c49300e9fb7 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -145,7 +145,7 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsig=
ned long event)
>  		for (tmp =3D dev; tmp; tmp =3D tmp->bus->self)
>  			level++;
> =20
> -	size =3D sizeof(*info) + level * sizeof(struct acpi_dmar_pci_path);
> +	size =3D sizeof(*info) + level * sizeof(info->path[0]);

This is probably a candidate for struct_size() instead, if that's what
is preferred.

   Julia
