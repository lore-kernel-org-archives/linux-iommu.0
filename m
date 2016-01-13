From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Add support for multiple DMA aliases
Date: Wed, 13 Jan 2016 21:28:25 +0000
Message-ID: <1452720505.88154.71.camel@infradead.org>
References: <1452518415-97637-1-git-send-email-jacek.lawrynowicz@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3338401455715179960=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1452518415-97637-1-git-send-email-jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============3338401455715179960==
Content-Type: multipart/signed; micalg="sha-1"; protocol="application/x-pkcs7-signature";
	boundary="=-4jU8/SP06glSkCAv1/KF"


--=-4jU8/SP06glSkCAv1/KF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-01-11 at 14:20 +0100, Jacek Lawrynowicz wrote:
> This patch solves IOMMU support issues with PCIe non-transparent bridges
> that use Requester ID look-up tables (LUT), e.g. PEX8733. Before exiting
> the bridge, packet's RID is rewritten according to LUT programmed by
> a driver. Modified packets are then passed to a destination bus and
> processed upstream. The problem is that such packets seem to come from
> non-existent nodes that are hidden behind NTB and are not discoverable
> by a destination node, so IOMMU discards them. Adding DMA alias for a
> given LUT entry allows IOMMU to create a proper mapping that enables
> inter-node communication.
>=20
> The current DMA alias implementation supports only single alias, so it's
> not possible to connect more than two nodes when IOMMU is enabled. This
> implementation enables all possible aliases on a given bus (256) that
> are stored in a bitset. Alias devfn is directly translated to a bit
> number. The bitset is not allocated for devices that have no need for
> DMA aliases.
>=20
> More details can be found in following article:
> http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%20Mul=
itHostSystemDesigns.pdf
>=20
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Acked-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Strictly speaking, this is more in PCI code than IOMMU code. And it
doesn't actually touch the Intel VT-d code at all; the subject is a bit
misleading.

But I'm happy enough to add it to my intel-iommu tree if nobody else
picks it up. Bjorn?=C2=A0

> ---
> =C2=A0drivers/iommu/iommu.c |=C2=A0=C2=A08 ++++----
> =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 19 +++++++++++++++=
++++
> =C2=A0drivers/pci/probe.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01 +
> =C2=A0drivers/pci/quirks.c=C2=A0=C2=A0| 15 ++++++---------
> =C2=A0drivers/pci/search.c=C2=A0=C2=A0| 14 +++++++++-----
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0| 15 ++++++++-------
> =C2=A06 files changed, 47 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0e3b009..2032e1f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -686,10 +686,10 @@ static struct iommu_group *get_pci_alias_group(stru=
ct pci_dev *pdev,
> =C2=A0			continue;
> =C2=A0
> =C2=A0		/* We alias them or they alias us */
> -		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pdev->dma_alias_devfn =3D=3D tmp->devfn)=
 ||
> -		=C2=A0=C2=A0=C2=A0=C2=A0((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEV=
FN) &&
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tmp->dma_alias_devfn =3D=3D pdev->devfn)=
) {
> +		if ((pdev->dma_alias_mask &&
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_bit(tmp->devfn, pdev->dma_alias_mas=
k)) ||
> +		=C2=A0=C2=A0=C2=A0=C2=A0((tmp->dma_alias_mask &&
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_bit(pdev->devfn, tmp->dma_alias_mas=
k)))) {
> =C2=A0
> =C2=A0			group =3D get_pci_alias_group(tmp, devfns);
> =C2=A0			if (group) {
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 314db8c..b0d6a0a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4568,6 +4568,25 @@ int pci_set_vga_state(struct pci_dev *dev, bool de=
code,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * pci_add_dma_alias - Allows to add multiple devfn aliases for given de=
vice
> + * @dev: the PCI device for which alias is added
> + * @devfn: alias slot and function
> + *
> + * This helper encodes 8-bit devfn as bit number in dma_alias_mask
> + */
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> +{
> +	if (!dev->dma_alias_mask) {
> +		dev->dma_alias_mask =3D kcalloc(BITS_TO_LONGS(U8_MAX),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sizeof(long), GFP_KERNEL);
> +		dev_warn(&dev->dev, "Unable to allocate DMA alias mask.\n");
> +	}
> +	if (dev->dma_alias_mask)
> +		set_bit(devfn, dev->dma_alias_mask);
> +}
> +EXPORT_SYMBOL_GPL(pci_add_dma_alias);
> +
> =C2=A0bool pci_device_is_present(struct pci_dev *pdev)
> =C2=A0{
> =C2=A0	u32 v;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index edb1984..b23c25f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1508,6 +1508,7 @@ static void pci_release_dev(struct device *dev)
> =C2=A0	pcibios_release_device(pci_dev);
> =C2=A0	pci_bus_put(pci_dev->bus);
> =C2=A0	kfree(pci_dev->driver_override);
> +	kfree(pci_dev->dma_alias_mask);
> =C2=A0	kfree(pci_dev);
> =C2=A0}
> =C2=A0
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7e32730..37968f7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3568,8 +3568,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, int=
 probe)
> =C2=A0static void quirk_dma_func0_alias(struct pci_dev *dev)
> =C2=A0{
> =C2=A0	if (PCI_FUNC(dev->devfn) !=3D 0) {
> -		dev->dma_alias_devfn =3D PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
> -		dev->dev_flags |=3D PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> =C2=A0	}
> =C2=A0}
> =C2=A0
> @@ -3584,8 +3583,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe47=
6, quirk_dma_func0_alias);
> =C2=A0static void quirk_dma_func1_alias(struct pci_dev *dev)
> =C2=A0{
> =C2=A0	if (PCI_FUNC(dev->devfn) !=3D 1) {
> -		dev->dma_alias_devfn =3D PCI_DEVFN(PCI_SLOT(dev->devfn), 1);
> -		dev->dev_flags |=3D PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
> =C2=A0	}
> =C2=A0}
> =C2=A0
> @@ -3649,11 +3647,10 @@ static void quirk_fixed_dma_alias(struct pci_dev =
*dev)
> =C2=A0
> =C2=A0	id =3D pci_match_id(fixed_dma_alias_tbl, dev);
> =C2=A0	if (id) {
> -		dev->dma_alias_devfn =3D id->driver_data;
> -		dev->dev_flags |=3D PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> -		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
> -			=C2=A0PCI_SLOT(dev->dma_alias_devfn),
> -			=C2=A0PCI_FUNC(dev->dma_alias_devfn));
> +		pci_add_dma_alias(dev, id->driver_data);
> +		dev_info(&dev->dev, "Enabling fixed DMA alias to %02lx.%ld\n",
> +			=C2=A0PCI_SLOT(id->driver_data),
> +			=C2=A0PCI_FUNC(id->driver_data));
> =C2=A0	}
> =C2=A0}
> =C2=A0
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index a20ce7d..33e0f03 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -40,11 +40,15 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
> =C2=A0	=C2=A0* If the device is broken and uses an alias requester ID for
> =C2=A0	=C2=A0* DMA, iterate over that too.
> =C2=A0	=C2=A0*/
> -	if (unlikely(pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN)) {
> -		ret =3D fn(pdev, PCI_DEVID(pdev->bus->number,
> -					=C2=A0pdev->dma_alias_devfn), data);
> -		if (ret)
> -			return ret;
> +	if (unlikely(pdev->dma_alias_mask)) {
> +		u8 devfn;
> +
> +		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
> +			ret =3D fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
> +				=C2=A0data);
> +			if (ret)
> +				return ret;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	for (bus =3D pdev->bus; !pci_is_root_bus(bus); bus =3D bus->parent=
) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6ae25aa..ace132d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -172,16 +172,14 @@ enum pci_dev_flags {
> =C2=A0	PCI_DEV_FLAGS_ASSIGNED =3D (__force pci_dev_flags_t) (1 << 2),
> =C2=A0	/* Flag for quirk use to store if quirk-specific ACS is enabled */
> =C2=A0	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK =3D (__force pci_dev_flags_t) (1 <=
< 3),
> -	/* Flag to indicate the device uses dma_alias_devfn */
> -	PCI_DEV_FLAGS_DMA_ALIAS_DEVFN =3D (__force pci_dev_flags_t) (1 << 4),
> =C2=A0	/* Use a PCIe-to-PCI bridge alias even if !pci_is_pcie */
> -	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS =3D (__force pci_dev_flags_t) (1 << 5),
> +	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS =3D (__force pci_dev_flags_t) (1 << 4),
> =C2=A0	/* Do not use bus resets for device */
> -	PCI_DEV_FLAGS_NO_BUS_RESET =3D (__force pci_dev_flags_t) (1 << 6),
> +	PCI_DEV_FLAGS_NO_BUS_RESET =3D (__force pci_dev_flags_t) (1 << 5),
> =C2=A0	/* Do not use PM reset even if device advertises NoSoftRst- */
> -	PCI_DEV_FLAGS_NO_PM_RESET =3D (__force pci_dev_flags_t) (1 << 7),
> +	PCI_DEV_FLAGS_NO_PM_RESET =3D (__force pci_dev_flags_t) (1 << 6),
> =C2=A0	/* Get VPD from function 0 VPD */
> -	PCI_DEV_FLAGS_VPD_REF_F0 =3D (__force pci_dev_flags_t) (1 << 8),
> +	PCI_DEV_FLAGS_VPD_REF_F0 =3D (__force pci_dev_flags_t) (1 << 7),
> =C2=A0};
> =C2=A0
> =C2=A0enum pci_irq_reroute_variant {
> @@ -279,7 +277,7 @@ struct pci_dev {
> =C2=A0	u8		rom_base_reg;	/* which config register controls the ROM */
> =C2=A0	u8		pin;		/* which interrupt pin this device uses */
> =C2=A0	u16		pcie_flags_reg;	/* cached PCIe Capabilities Register */
> -	u8		dma_alias_devfn;/* devfn of DMA alias, if any */
> +	unsigned long	*dma_alias_mask;/* mask of enabled devfn aliases */
> =C2=A0
> =C2=A0	struct pci_driver *driver;	/* which driver has allocated this devi=
ce */
> =C2=A0	u64		dma_mask;	/* Mask of the bits of bus address this
> @@ -1238,6 +1236,9 @@ resource_size_t pcibios_iov_resource_alignment(stru=
ct pci_dev *dev, int resno);
> =C2=A0
> =C2=A0int pci_set_vga_state(struct pci_dev *pdev, bool decode,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int command_bits, u3=
2 flags);
> +
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
> +
> =C2=A0/* kmem_cache style wrapper around pci_alloc_consistent() */
> =C2=A0
> =C2=A0#include=20
--=20
dwmw2

--=-4jU8/SP06glSkCAv1/KF
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISjjCCBicw
ggUPoAMCAQICAw3vNzANBgkqhkiG9w0BAQUFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcx
ODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENB
MB4XDTE1MDUwNTA5NDM0MVoXDTE2MDUwNTA5NTMzNlowQjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFk
ZWFkLm9yZzEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMkbm9kPbx1j/X4RVyf/pPKSYwelcco69TvnQQbKM8m8xkWjXJI1
jpJ1jMaGUZGFToINMSZi7lZawUozudWbXSKy1SikENSTJHffsdRAIlsp+hR8vWvjsKUry6sEdqPG
doa5RY7+N4WRusWZDYW/RRWE6i9EL9qV86CVPYqw22UBOUw4/j/HVGCV6TSB8yE5iEwhk/hUuzRr
FZm1MJMR7mCS7BCR8Lr5jFY61lWpBiXNXIxLZCvDc26KR5L5tYX43iUVO3fzES1GRVoYnxxk2tmz
fcsZG5vK+Trc9L8OZJfkYrEHH3+Iw41MQ0w/djVtYr1+HYldx0QmYXAtnhIj+UMCAwEAAaOCAtkw
ggLVMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcD
BDAdBgNVHQ4EFgQUszC96C3w5/2+d+atSr0IpT26YI4wHwYDVR0jBBgwFoAUU3Ltkpzg2ssBXHx+
ljVO8tS4UYIwHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzCCAUwGA1UdIASCAUMwggE/
MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1
dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3YXMgaXNzdWVkIGFjY29yZGluZyB0byB0
aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVtZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9s
aWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUgaW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNl
IG9mIHRoZSByZWx5aW5nIHBhcnR5IG9ibGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRw
Oi8vY3JsLnN0YXJ0c3NsLmNvbS9jcnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsG
AQUFBzABhi1odHRwOi8vb2NzcC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYI
KwYBBQUHMAKGNmh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50
LmNhLmNydDAjBgNVHRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQEF
BQADggEBAHMQmxHHodpS85X8HRyxhvfkys7r+taCNOaNU9cxQu/cZ/6k5nS2qGNMzZ6jb7ueY/V7
7p+4DW/9ZWODDTf4Fz00mh5SSVc20Bz7t+hhxwHd62PZgENh5i76Qq2tw48U8AsYo5damHby1epf
neZafLpUkLLO7AGBJIiRVTevdvyXQ0qnixOmKMWyvrhSNGuVIKVdeqLP+102Dwf+dpFyw+j1hz28
jEEKpHa+NR1b2kXuSPi/rMGhexwlJOh4tK8KQ6Ryr0rIN//NSbOgbyYZrzc/ZUWX9V5OA84ChFb2
vkFl0OcYrttp/rhDBLITwffPxSZeoBh9H7zYzkbCXKL3BUIwggYnMIIFD6ADAgECAgMN7zcwDQYJ
KoZIhvcNAQEFBQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYD
VQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENv
bSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAeFw0xNTA1MDUwOTQzNDFa
Fw0xNjA1MDUwOTUzMzZaMEIxHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcxIjAgBgkqhkiG
9w0BCQEWE2R3bXcyQGluZnJhZGVhZC5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDJG5vZD28dY/1+EVcn/6TykmMHpXHKOvU750EGyjPJvMZFo1ySNY6SdYzGhlGRhU6CDTEmYu5W
WsFKM7nVm10istUopBDUkyR337HUQCJbKfoUfL1r47ClK8urBHajxnaGuUWO/jeFkbrFmQ2Fv0UV
hOovRC/alfOglT2KsNtlATlMOP4/x1Rglek0gfMhOYhMIZP4VLs0axWZtTCTEe5gkuwQkfC6+YxW
OtZVqQYlzVyMS2Qrw3NuikeS+bWF+N4lFTt38xEtRkVaGJ8cZNrZs33LGRubyvk63PS/DmSX5GKx
Bx9/iMONTENMP3Y1bWK9fh2JXcdEJmFwLZ4SI/lDAgMBAAGjggLZMIIC1TAJBgNVHRMEAjAAMAsG
A1UdDwQEAwIEsDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFLMwvegt
8Of9vnfmrUq9CKU9umCOMB8GA1UdIwQYMBaAFFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB4GA1UdEQQX
MBWBE2R3bXcyQGluZnJhZGVhZC5vcmcwggFMBgNVHSAEggFDMIIBPzCCATsGCysGAQQBgbU3AQID
MIIBKjAuBggrBgEFBQcCARYiaHR0cDovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5LnBkZjCB9wYI
KwYBBQUHAgIwgeowJxYgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwAwIBARqBvlRo
aXMgY2VydGlmaWNhdGUgd2FzIGlzc3VlZCBhY2NvcmRpbmcgdG8gdGhlIENsYXNzIDEgVmFsaWRh
dGlvbiByZXF1aXJlbWVudHMgb2YgdGhlIFN0YXJ0Q29tIENBIHBvbGljeSwgcmVsaWFuY2Ugb25s
eSBmb3IgdGhlIGludGVuZGVkIHB1cnBvc2UgaW4gY29tcGxpYW5jZSBvZiB0aGUgcmVseWluZyBw
YXJ0eSBvYmxpZ2F0aW9ucy4wNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5zdGFydHNzbC5j
b20vY3J0dTEtY3JsLmNybDCBjgYIKwYBBQUHAQEEgYEwfzA5BggrBgEFBQcwAYYtaHR0cDovL29j
c3Auc3RhcnRzc2wuY29tL3N1Yi9jbGFzczEvY2xpZW50L2NhMEIGCCsGAQUFBzAChjZodHRwOi8v
YWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zdWIuY2xhc3MxLmNsaWVudC5jYS5jcnQwIwYDVR0SBBww
GoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMA0GCSqGSIb3DQEBBQUAA4IBAQBzEJsRx6HaUvOV
/B0csYb35MrO6/rWgjTmjVPXMULv3Gf+pOZ0tqhjTM2eo2+7nmP1e+6fuA1v/WVjgw03+Bc9NJoe
UklXNtAc+7foYccB3etj2YBDYeYu+kKtrcOPFPALGKOXWph28tXqX53mWny6VJCyzuwBgSSIkVU3
r3b8l0NKp4sTpijFsr64UjRrlSClXXqiz/tdNg8H/naRcsPo9Yc9vIxBCqR2vjUdW9pF7kj4v6zB
oXscJSToeLSvCkOkcq9KyDf/zUmzoG8mGa83P2VFl/VeTgPOAoRW9r5BZdDnGK7baf64QwSyE8H3
z8UmXqAYfR+82M5Gwlyi9wVCMIIGNDCCBBygAwIBAgIBHjANBgkqhkiG9w0BAQUFADB9MQswCQYD
VQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwg
Q2VydGlmaWNhdGUgU2lnbmluZzEpMCcGA1UEAxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMDcxMDI0MjEwMTU1WhcNMTcxMDI0MjEwMTU1WjCBjDELMAkGA1UEBhMCSUwxFjAU
BgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRl
IFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUg
Q2xpZW50IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxwmDzM4t2BqxKaQuE6uW
vooyg4ymiEGWVUet1G8SD+rqvyNH4QrvnEIaFHxOhESip7vMz39ScLpNLbL1QpOlPW/tFIzNHS3q
d2XRNYG5Sv9RcGE+T4qbLtsjjJbi6sL7Ls/f/X9ftTyhxvxWkf8KW37iKrueKsxw2HqolH7GM6FX
5UfNAwAu4ZifkpmZzU1slBhyWwaQPEPPZRsWoTb7q8hmgv6Nv3Hg9rmA1/VPBIOQ6SKRkHXG0Hhm
q1dOFoAFI411+a/9nWm5rcVjGcIWZ2v/43Yksq60jExipA4l5uv9/+Hm33mbgmCszdj/Dthf13tg
Av2O83hLJ0exTqfrlwIDAQABo4IBrTCCAakwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
AQYwHQYDVR0OBBYEFFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mH
MMo0aEPQQa7yMGYGCCsGAQUFBwEBBFowWDAnBggrBgEFBQcwAYYbaHR0cDovL29jc3Auc3RhcnRz
c2wuY29tL2NhMC0GCCsGAQUFBzAChiFodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9zZnNjYS5jcnQw
WwYDVR0fBFQwUjAnoCWgI4YhaHR0cDovL3d3dy5zdGFydHNzbC5jb20vc2ZzY2EuY3JsMCegJaAj
hiFodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmwwgYAGA1UdIAR5MHcwdQYLKwYBBAGB
tTcBAgEwZjAuBggrBgEFBQcCARYiaHR0cDovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5LnBkZjA0
BggrBgEFBQcCARYoaHR0cDovL3d3dy5zdGFydHNzbC5jb20vaW50ZXJtZWRpYXRlLnBkZjANBgkq
hkiG9w0BAQUFAAOCAgEACoMIfXirLAZcuGOMXq4cuSN3TaFx2H2GvD5VSy/6rV55BYHbWNaPeQn3
oBSU8KgQZn/Kck1JxbLpAxVCNtsxeW1R87ifhsYZ0qjdrA9anrW2MAWCtosmAOT4OxK9QPoSjCMx
M3HbkZCDJgnlE8jMopH21BbyAYr7b5EfGRQJNtgWcvqSXwKHnTutR08+Kkn0KAkXCzeQNLeA5LlY
UzFyM7kPAp8pIRMQ+seHunmyG642S2+y/qHEdMuGIwpfz3eDF1PdctL04qYK/zu+Qg1Bw0RwgigV
Zs/0c5HP2/e9DBHh7eSwtzYlk4AUr6yxLlcwSjOfOmKEQ/Q8tzh0IFiNu9IPuTGAPBn4CPxD0+Ru
8T2wg8/s43R/PT3kd1OEqOJUl7q+h+r6fpvU0Fzxd2tC8Ga6fDEPme+1Nbi+03pVjuZQKbGwKJ66
gEn06WqaxVZC+J8hh/jR0k9mST1iAZPNYulcNJ8tKmVtjYsv0L1TSm2+NwON58tO+pIVzu3DWwSE
XSf+qkDavQam+QtEOZxLBXI++aMUEapSn+k3Lxm48ZCYfAWLb/Xj7F5JQMbZvCexglAbYR0kIHqW
5DnsYSdMD/IplJMojx0NBrxJ3fN9dvX2Y6BIXRsF1du4qESm4/3CKuyUV7p9DW3mPlHTGLvYxnyK
Qy7VFBkoLINszBrOUeIxggNvMIIDawIBATCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcx
ODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENB
AgMN7zcwCQYFKw4DAhoFAKCCAa8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTYwMTEzMjEyODI1WjAjBgkqhkiG9w0BCQQxFgQUrU70Vb31zJyxJRLC6F7oG0MMJC8w
gaUGCSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0
ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMN7zcwgacG
CyqGSIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRk
LjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAw3vNzANBgkq
hkiG9w0BAQEFAASCAQBj4EXGMozzg2gkzSSN9O4xu64fJ6qO6d/gijRzUnphoVaTxJpplFi13CK1
6a6GKhLuh2w0/e9dU3S7/gmKYEOeiL0OI1AC4XCJFR1EBCOa1ze0+rAezV49/XKPPUWPYIUQO456
HYsdYhgGr+aAmzNkJ4V6KSFXhI47feaip2PANqa+dYUeXbDuXO1MzMz0OvY1lspA0KEo1coObunX
5A3tzmgOjm/AIylq1bz0OAysDfrKMqAnGMzpzn6acm1LchEIYK9me2M/SQwlTcOXVJLCRdBlB9fe
6Rcvq6vsNpzcdD/f9cI3r8flIlgh/y7DHB8lzGxWlNk6P2HYyF8LskN/AAAAAAAA


--=-4jU8/SP06glSkCAv1/KF--


--===============3338401455715179960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3338401455715179960==--
