From: Ting-Wei Lan <lantw44-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Kernel panic on Linux 4.1 with intel_iommu=on
Date: Wed, 01 Jul 2015 03:32:33 +0800
Message-ID: <1435692753.7564.17.camel@gmail.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hardware:
Intel Core i5 CPU 650 @ 3.20GHz
Intel Ironlake Desktop

In order to use VT-d on this computer, I have to use 'intel_iommu=on
intel_iommu=igfx_off' to prevent graphics problems and system crash.
This problem happens on Linux 3.7 and later versions, including the
latest release, Linux 4.1.

I found Intel-IOMMU.txt says I should file a bug if
intel_iommu=igfx_off fixes anything. I filed the bug on freedesktop ->
DRI -> DRM/Intel.
https://bugs.freedesktop.org/show_bug.cgi?id=91127

After I applied this patch, I no longer saw graphics problems, and Xorg
and Wayland can be successfully started without intel_iommu=igfx_off.
https://bugs.freedesktop.org/show_bug.cgi?id=91127#c6

However, after using the system for about one hour, the system crashed
and printed some messages on the serial console. I have to press the
reset button to reboot the machine.
https://bugs.freedesktop.org/show_bug.cgi?id=91127#c8

Can anyone here help us resolve this problem?
