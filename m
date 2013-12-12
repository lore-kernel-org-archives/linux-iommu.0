From: Kenneth <kenhomza-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: IOMMU feedback Gigabyte and AMD
Date: Thu, 12 Dec 2013 14:44:18 -0500
Message-ID: <52AA1212.6080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

HI, If I try and install Ubuntu 13.10 AMD/64,
On a Gigabyte ga-990fxa-ud7 Revision 3 Motherboard with FD bios,
I have to enable IOMMU in the bios and complete the install process,
With out enabling IOMMU I have no USB 2.0 port inputs, the default ports 
one would use for a usb keyboard and mouse,
after completing the Ubuntu 13.10 install I have to disable IOMMU in the 
bios and then add iommu=soft to the kernel commandline/GRUB boot loader,
With out adding iommu=soft cd/dvd drives are not seen after boot.
Here is a link to Arch linux forums with the same errors I had and stuff.
https://bbs.archlinux.org/viewtopic.php?pid=1319548

This is jest some feedback for you, maybe some one will see this and 
look into it, it's beyond my skill level.
Thank you ....
