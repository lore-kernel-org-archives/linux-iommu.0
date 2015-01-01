From: nick <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Question about moving code in amd-iommu.c
Date: Thu, 01 Jan 2015 00:06:53 -0500
Message-ID: <54A4D5ED.5030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Greetings Joerg,
I assume you wrote this code as the maintainer : 
 /* FIXME: Move this to PCI code */
 #define PCI_PRI_TLP_OFF         (1 << 15)

static bool pci_pri_tlp_required(struct pci_dev *pdev)
{
        u16 status;
        int pos;

        pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
        if (!pos)
               return false;

        pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);

        return (status & PCI_PRI_TLP_OFF) ? true : false;
}
I am wondering due to the fix me being rather value as to where to move this code.
Have a Great New Year's,
Nick
