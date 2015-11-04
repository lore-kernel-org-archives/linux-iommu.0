From: Laine Stump <laine-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Regression in kernel 4.2.3+ (relative to 4.1.10) on AMD 990FX system
	with IOMMU enabled
Date: Wed, 4 Nov 2015 12:24:52 -0500
Message-ID: <563A3F64.50808@redhat.com>
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

Last week I upgraded my Fedora 22 AMD 990FX system from kernel 4.1.10 to 
4.2.3 (standard Fedora builds) and multiple devices stopped working:

* 00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 
Azalia (Intel HDA) (rev 40)

* 02:00.[01] Ethernet controller: Intel Corporation 82576 Gigabit 
Network Connection

* 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar 
HDMI Audio [Radeon HD 5400/6300 Series]

(The 1st is integrated on the motherboard, the 2nd & 3rd are behind an 
AMD RD890 pci-pci bridge. There may be other devices failing, but these 
are the ones immediately obvious.)

Whatever is the source of the failure, it ends up that the drivers for 
these devices aren't loaded.

At Alex Williamson's suggestion, I tried disabling IOMMU in the BIOS, 
and magically all the devices resumed normal operation (except that I 
can't do vfio device assignment because the IOMMU is disabled).

Reverting to kernel 4.1.10 very definitely eliminates the problem. I've 
also tried kernel 4.2.5 and it has the same problem as 4.2.3 (these 
three are the only pre-built kernels for F22). I can provide dmesg / 
lspci output from each of these, or any other debug info anyone might 
like me to gather.

What can I do to help figure out the cause of this problem and get it 
fixed? (keeping in mind that the last time I built a Linux kernel for 
myself was 2.6.something about 7 years ago :-). I would be willing to 
set things up to build my own and go bisecting with git, but there's 
likely something more expedient...)
