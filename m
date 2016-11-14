From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [bug report] iommu/vt-d: Fix IOMMU lookup for SR-IOV Virtual Functions
Date: Mon, 14 Nov 2016 14:09:52 +0300
Message-ID: <20161114110951.GA1881@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Ashok Raj,

This is a semi-automatic email about new static checker warnings.

The patch 1c387188c60f: "iommu/vt-d: Fix IOMMU lookup for SR-IOV 
Virtual Functions" from Oct 21, 2016, leads to the following Smatch 
complaint:

drivers/iommu/intel-iommu.c:918 device_to_iommu()
	 error: we previously assumed 'pdev' could be null (see line 908)

drivers/iommu/intel-iommu.c
   907		for_each_active_iommu(iommu, drhd) {
   908			if (pdev && segment != drhd->segment)
                            ^^^^
Other code assumes pdev can be NULL.

   909				continue;
   910	
   911			for_each_active_dev_scope(drhd->devices,
   912						  drhd->devices_cnt, i, tmp) {
   913				if (tmp == dev) {
   914					/* For a VF use its original BDF# not that of the PF
   915					 * which we used for the IOMMU lookup. Strictly speaking
   916					 * we could do this for all PCI devices; we only need to
   917					 * get the BDF# from the scope table for ACPI matches. */
   918					if (pdev->is_virtfn)
                                            ^^^^^^^^^^^^^^^
Not checked.

   919						goto got_pdev;
   920	
   921                                  *bus = drhd->devices[i].bus;
   922                                  *devfn = drhd->devices[i].devfn;
   923                                  goto out;
   924                          }
   925  
   926                          if (!pdev || !dev_is_pci(tmp))
                                     ^^^^
Checked here as well.

   927                                  continue;
   928  
   929                          ptmp = to_pci_dev(tmp);
   930                          if (ptmp->subordinate &&
   931                              ptmp->subordinate->number <= pdev->bus->number &&
   932                              ptmp->subordinate->busn_res.end >= pdev->bus->number)
   933                                  goto got_pdev;
   934                  }
   935  
   936                  if (pdev && drhd->include_all) {
   937                  got_pdev:

regards,
dan carpenter
