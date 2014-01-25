From: Mark Derbyshire <mark-+evXrPDj4/c@public.gmane.org>
Subject: [PATCH] iommu/amd: Add quirk for broken Marvell 88SE91xx SATA
Date: Fri, 24 Jan 2014 21:10:13 -0700
Message-ID: <8F5D7A6AD678AC8048FC0E15@mark.taom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Thomas Kuther writes:

> I have the same board (990FXA-UD5) and the same problem.
>
> Applied the patch (against 3.12.2) and dmesg reads:
> [    0.755642] AMD-Vi: Applying merge-fn quirk for device 0000:03:00.0
> [    0.755648] AMD-Vi: Applying merge-fn quirk for device 0000:09:00.0
>
> 03:00 is the SATA controller, 09:00 the eSATA one.
> ID's from `lscpi -nvvv` are identical to Manfred's.
>
> Also, the device works OK when passed through to a Qemu VM using
> vfio-pci, so basically it does work when IOMMU is enabled, just not
> on the host side.
>
> A fix would be great, I'm willing to test, too.

I have a GA-990FXA-UD3 board that fails similarly, although only the 
eSATA onboard controller is affected (Marvell 88SE9172). In my case the 
real device is 03:00.0, but the IO_PAGE_FAULTS come from 03:00.1. 
Unfortunately 03:00.1 does not appear in the ACPI tables.

The conceptual problem with the patch for the above scenario is while 
the alias table is set up to map 03:00.1 to 03:00.0, the code never 
writes a device table entry for 03:00.1, making this effectively a 
no-op. One way to get around this is to make 03:00.1 a device and 
reverse the mapping from 03:00.0 to 03:00.1. While this doesn't 
generalize to multiple functions, that isn't a problem for the devices 
we're trying to fix.

I'm not advocating this as the proper approach, but if the lines in the 
original patch:

		for (i = 1; i < 8; ++i)
			amd_iommu_alias_table[base_devid + i] = devid;

are changed to:

                amd_iommu_alias_table[devid] = base_devid + 1;
                set_dev_entry_from_acpi(amd_iommu_rlookup_table[devid], 
base_devid + 1, 0, 0);

my eSATA controller works fine on 3.12.6. I hope this helps in arriving 
at the correct solution.

Cheers,
Mark
