From: Gabor Locsei <gabor.locsei-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: IOMMU detection via sysfs
Date: Wed, 22 Mar 2017 11:06:47 +0000
Message-ID: <DB4PR07MB0701CD0B470B1B18ECF99D98E13C0@DB4PR07MB0701.eurprd07.prod.outlook.com>
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
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

I have systems with IOMMU optionally enabled, and I would like to find a method to check these capabilities that doesn't rely on dmesg.
The evident problem is that dmesg eventually clear boot time messages so the relevant lines may just disappear.

Looks like there are sysfs entries that seem to be fit for this purpose. 

DMAR			The file /sys/firmware/acpi/tables/DMAR exists. (This file exists on every lab node.)
IOMMU			The directory /sys/devices/virtual/iommu/ exists and there are dmar0, etc device subdirectories in it

I have looked into the ACPI DMAR tables with iasl, but they look the same regardless of the cmdline iommu settings.
The question is, provided that the platform has ACPI, is it safe to rely on sysfs, is the above enough to prove that IOMMU is available? The oldest kernel version to verify against is 3.10.0 from RHEL.

Thanks!

best regards,
Gabor
