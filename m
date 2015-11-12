From: Laine Stump <laine-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Regression in kernel 4.2.3+ (relative to 4.1.10) on AMD 990FX
	system with IOMMU enabled
Date: Thu, 12 Nov 2015 12:33:53 -0500
Message-ID: <5644CD81.2020304@redhat.com>
References: <563A3F64.50808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <563A3F64.50808-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

(Cc'ing Joerg because I have a question for him down towards the bottom...)

On 11/04/2015 12:24 PM, Laine Stump wrote:
> Last week I upgraded my Fedora 22 AMD 990FX system from kernel 4.1.10 to
> 4.2.3 (standard Fedora builds) and multiple devices stopped working:
>
> * 00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00
> Azalia (Intel HDA) (rev 40)
>
> * 02:00.[01] Ethernet controller: Intel Corporation 82576 Gigabit
> Network Connection
>
> * 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar
> HDMI Audio [Radeon HD 5400/6300 Series]
>
> (The 1st is integrated on the motherboard, the 2nd & 3rd are behind an
> AMD RD890 pci-pci bridge. There may be other devices failing, but these
> are the ones immediately obvious.)
>
> Whatever is the source of the failure, it ends up that the drivers for
> these devices aren't loaded.

That is actually a bit misleading/incorrect - the igb device is 
apparently loaded for one of the two devices in the 82576 card 
(02:00.0), and one (out of expected 7) VF device entries is created in 
/sys/devices/pci0000:00/*, but something happens that results in none of 
these devices being put in /sys/class/net, the other 6 VFs don't get 
entries in /sys/device/pci0000:00/*, and the igb driver isn't loaded for 
the 2nd PF (02:00.1).

> At Alex Williamson's suggestion, I tried disabling IOMMU in the BIOS,
> and magically all the devices resumed normal operation (except that I
> can't do vfio device assignment because the IOMMU is disabled).

After a crash course in kernel building from Alex, I bisected down to 
commit aafd8ba - a kernel built without this commit succeeds in setting 
up all the devices mentioned, adding it causes failure (and a very long 
delay during boot). Joerg, do you have any ideas for debugging the 
problem further to see what in the commit causes this problem? (note 
that 2 other people with the same chipset but slightly different 
hardware plugged into it report no failure - see the other replies to 
the parent of this message for more detail). I'm happy to build a kernel 
with any suggested patches and report results...

commit aafd8ba0ca74894b9397e412bbd7f8ea2662ead8
Author: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date:   Thu May 28 18:41:39 2015 +0200

     iommu/amd: Implement add_device and remove_device

     Implement these two iommu-ops call-backs to make use of the
     initialization and notifier features of the iommu core.

     Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
