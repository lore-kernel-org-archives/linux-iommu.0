From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 10/13] pci: export pci_user functions for use by other
	drivers
Date: Mon, 14 May 2012 15:20:40 -0600
Message-ID: <CAErSpo6-Oy6eTgUBNRfM3HwFSLpDXJt3K1N0DKFpyYsNiSxwRQ@mail.gmail.com>
References: <20120511222148.30496.68571.stgit@bling.home>
	<20120511225636.30496.26907.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120511225636.30496.26907.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index dc25da3..b437225 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -770,6 +770,14 @@ static inline int pci_write_config_dword(const struc=
t pci_dev *dev, int where,
> =A0 =A0 =A0 =A0return pci_bus_write_config_dword(dev->bus, dev->devfn, wh=
ere, val);
> =A0}
>
> +/* user-space driven config access */
> +extern int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 =
*val);
> +extern int pci_user_read_config_word(struct pci_dev *dev, int where, u16=
 *val);
> +extern int pci_user_read_config_dword(struct pci_dev *dev, int where, u3=
2 *val);
> +extern int pci_user_write_config_byte(struct pci_dev *dev, int where, u8=
 val);
> +extern int pci_user_write_config_word(struct pci_dev *dev, int where, u1=
6 val);
> +extern int pci_user_write_config_dword(struct pci_dev *dev, int where, u=
32 val);

If you repost this, can you remove the externs when you move these
declarations?  I know the file's currently a random mix, but we might
as well make a tiny improvement.

Looks fine to me otherwise, and if you don't have any other reason to
update this series, don't worry about it.

Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

> =A0int __must_check pci_enable_device(struct pci_dev *dev);
> =A0int __must_check pci_enable_device_io(struct pci_dev *dev);
> =A0int __must_check pci_enable_device_mem(struct pci_dev *dev);
>
