From: David Kiarie <davidkiarie4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: IVDB DTE_ALL Settings
Date: Tue, 4 Aug 2015 05:57:45 +0300
Message-ID: <20150804025745.GA4128@debian.debian>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: valentine.sinitsyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jankiskza-S0/GAf8tV78@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I hope am not messing something up,...

The Linux AMD IOMMU driver does not seem to be applying DTE settings listed in the ALL field correctly.

The relevant code:

  switch (e->type) {

  case IVHD_DEV_ALL:

    DUMP_printk("  DEV_ALL\t\t\t first devid: %02x:%02x.%x"
                " last device %02x:%02x.%x flags: %02x\n",
                PCI_BUS_NUM(iommu->first_device),
                PCI_SLOT(iommu->first_device),
                PCI_FUNC(iommu->first_device),
                PCI_BUS_NUM(iommu->last_device),
                PCI_SLOT(iommu->last_device),
                PCI_FUNC(iommu->last_device),
                         e->flags);

               for (dev_i = iommu->first_device;
                    dev_i <= iommu->last_device; ++dev_i)
                    set_dev_entry_from_acpi(iommu, dev_i,
                                    e->flags, 0);
                    break;

  case IVHD_DEV_SELECT:

Basically, the iommu->last/first_device fields are initialized in another state of the driver much later in the code(during PCI initialization); the values 
iommu->first/last_device are used before initialization which breaks the logic of this code.

On the other hand, this might be a lame bug as I have not seen any IOMMU using the ALL settings but I haven't seen many.

Cheers,
David.
