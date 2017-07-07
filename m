From: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [RFC PATCH 0/2] Add sideband data extraction
Date: Fri,  7 Jul 2017 12:39:57 +0530
Message-ID: <1499411399-25103-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

These patches implements optional DT properties to generate
smaller sideband data from RID which can be further mapped
to MSI Device ID or Stream ID

On some of the systems, sideband data is smaller than RID
(16bits). For such system, sideband data has to be generated
by dropping some of the RID bits

the process of sideband data extracted from RID can be expressed
using optional DT property {iommu/msi}-map-drop-mask.

Example: If drop-mask is 0xFF09 then sideband data is
8 bits bus number followed by 1 bit of device number and
1 bit function number. This means drop-mask=0xFF09 will
convert RID=0x1a10 (16bits) to sideband data 0x6a (10bits).

Srinath Mannam (2):
  dt-bindings: pci: Add drop mask property for MSI and IOMMU
  pcie: sideband data by dropping RID bits

 .../devicetree/bindings/pci/pci-iommu.txt          | 31 ++++++++++++++
 Documentation/devicetree/bindings/pci/pci-msi.txt  | 33 +++++++++++++++
 drivers/iommu/of_iommu.c                           |  4 +-
 drivers/of/irq.c                                   |  3 +-
 drivers/of/of_pci.c                                | 48 ++++++++++++++++++++--
 include/linux/of_pci.h                             |  6 ++-
 6 files changed, 117 insertions(+), 8 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
