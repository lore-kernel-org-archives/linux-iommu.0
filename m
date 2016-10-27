From: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Subject: SMR masking and PCI
Date: Thu, 27 Oct 2016 17:10:00 +0000
Message-ID: <VI1PR0401MB26389CC8820C9654337B578E8DAA0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

A question about how the SMR masking defined in the arm,smmu binding
relates to the PCI iommu-map.

The #iommu-cells property defines the number of cells an "IOMMU specifier"
takes and 2 is specified to be:

   SMMUs with stream matching support and complex masters
   may use a value of 2, where the second cell represents
   an SMR mask to combine with the ID in the first cell.

An iommu-map entry is defined as:

   (rid-base,iommu,iommu-base,length)

What seems to be currently missing in the iommu-map support is
the possibility the case where #iommu-cells=<2>.

In this case iommu-base which is an IOMMU specifier should
occupy 2 cells.  For example on an ls2085a we would want:

	iommu-map = <0x0   0x6 0x7 0x3ff 0x1
		       0x100 0x6 0x8 0x3ff 0x1>;

...to mask our stream IDs to 10 bits.

This should work in theory and comply with the bindings, no?

of_pci_map_rid() seems to have a hardcoded assumption that
each field in the map is 4 bytes.

(Also, I guess that msi-map is not affected by this since it
is not related to the IOMMU...but we do have common code
handling both maps.)

Thanks,
Stuart
