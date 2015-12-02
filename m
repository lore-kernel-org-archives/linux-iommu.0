From: Laine Stump <laine-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Regression in kernel 4.2.3+ (relative to 4.1.10) on AMD 990FX
	system with IOMMU enabled
Date: Wed, 2 Dec 2015 14:56:37 -0500
Message-ID: <565F4CF5.90107@redhat.com>
References: <563A3F64.50808@redhat.com> <5644CD81.2020304@redhat.com>
	<20151118151841.GA2517@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151118151841.GA2517-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/18/2015 10:18 AM, Joerg Roedel wrote:
> Hello Laine,
>
> On Thu, Nov 12, 2015 at 12:33:53PM -0500, Laine Stump wrote:
>> After a crash course in kernel building from Alex, I bisected down
>> to commit aafd8ba - a kernel built without this commit succeeds in
>> setting up all the devices mentioned, adding it causes failure (and
>> a very long delay during boot). Joerg, do you have any ideas for
>> debugging the problem further to see what in the commit causes this
>> problem? (note that 2 other people with the same chipset but
>> slightly different hardware plugged into it report no failure - see
>> the other replies to the parent of this message for more detail).
>> I'm happy to build a kernel with any suggested patches and report
>> results...
>>
>> commit aafd8ba0ca74894b9397e412bbd7f8ea2662ead8
>> Author: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>> Date:   Thu May 28 18:41:39 2015 +0200
>>
>>      iommu/amd: Implement add_device and remove_device
>>
>>      Implement these two iommu-ops call-backs to make use of the
>>      initialization and notifier features of the iommu core.
>>
>>      Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>
> I have no idea yet how this patch causes your regression. You certainly
> already posted it, but since I was not on Cc, can you please give me an
> overview about the problem you are seeing with this patch?

Sure. Sorry it took so long to get back to you. (My to-do list keeps 
getting longer instead of shorter, and I'm thrashing a bit).

Here's my original description, along with some questions from Alex and 
my responses:

On 11/05/2015 02:05 PM, Laine Stump wrote:
 > On 11/04/2015 04:08 PM, Alex Williamson wrote:
 >> On Wed, 2015-11-04 at 12:24 -0500, Laine Stump wrote:
 >>> Last week I upgraded my Fedora 22 AMD 990FX system from kernel 
4.1.10 to
 >>> 4.2.3 (standard Fedora builds) and multiple devices stopped working:
 >>>
 >>> * 00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00
 >>> Azalia (Intel HDA) (rev 40)
 >>>
 >>> * 02:00.[01] Ethernet controller: Intel Corporation 82576 Gigabit
 >>> Network Connection
 >>>
 >>> * 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar
 >>> HDMI Audio [Radeon HD 5400/6300 Series]
 >>>
 >>> (The 1st is integrated on the motherboard, the 2nd & 3rd are behind
 >>> an AMD RD890 pci-pci bridge. There may be other devices failing,
 >>> but these are the ones immediately obvious.)
 >>>
 >>> Whatever is the source of the failure, it ends up that the drivers
 >>> for these devices aren't loaded.
 >>>
 >>> At Alex Williamson's suggestion, I tried disabling IOMMU in the BIOS,
 >>> and magically all the devices resumed normal operation (except that
 >>> I can't do vfio device assignment because the IOMMU is disabled).
 >>>
 >>> Reverting to kernel 4.1.10 very definitely eliminates the problem. I've
 >>> also tried kernel 4.2.5 and it has the same problem as 4.2.3 (these
 >>> three are the only pre-built kernels for F22). I can provide dmesg /
 >>> lspci output from each of these, or any other debug info anyone
 >>> might like me to gather.
 >>
 >> I built a 4.2.3 kernel for my 990fx system and can't seem to
 >> reproduce it.  Does 'lspci -k' for those devices show any driver?
 >
 > 00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00
 > Azalia (Intel HDA) (rev 40)
 >      Subsystem: Gigabyte Technology Co., Ltd Device a132
 >      Kernel modules: snd_hda_intel
 > 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI
 > Audio [Radeon HD 5400/6300 Series]
 >      Subsystem: Gigabyte Technology Co., Ltd Device aa68
 >      Kernel modules: snd_hda_intel
 > 02:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network
 > Connection (rev 01)
 >      Subsystem: Intel Corporation Gigabit ET Dual Port Server Adapter
 >      Kernel driver in use: igb
 >      Kernel modules: igb
 > 02:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network
 > Connection (rev 01)
 >      Subsystem: Intel Corporation Gigabit ET Dual Port Server Adapter
 >      Kernel modules: igb
 >
 > /sys/devices/pci0000:00/0000:00:04.0/0000:02:00.0 does show a link
 > from driver to ........drivers/igb, but .......:02::00.1 doesn't
 > have a link, and neither of them shows up in /sys/class/net.
 >
 > Similarly for 01:00.[01] (which are behind the PCI to PCI bridge at
 > 00:02.0), the .0 device does have a link to the radeon driver, but
 > the .1 device (which is the sound device on the radeon video card)
 > has no driver link.
 >
 > And 00:14.2 (the motherboard integrated sound device) shows no driver
 > link in sysfs either.
 >
 >> Does 'lsmod'
 >> show the drivers loaded, igb and snd_hda_intel?  If not, does
 >> manually modprobe'ing either of those drivers change anything?
 >
 > Both of those drivers show up in lsmod output.
 >
 >> You haven't
 >> installed a script that writes to driver_override or setup a
 >> configuration where those devices are claimed by pci-stub and
 >> forgotten about it, have you? (it's happened to me)
 >
 > Not that I'm aware of. /etc/modules.d/local.conf had a few stray very
 > old items that I'd forgotten about, but I removed those and the
 > results are the same.
 >
 >> Otherwise, dmesg is probably a good place to start.

On 11/08/2015 11:52 AM, Laine Stump wrote:
 > Here is the dmesg
 > with IOMMU enabled in the BIOS (i.e. the devices *don't* work):
 >
 >    http://fpaste.org/296772/14490851/
 >
 > and here is is when IOMMU has been *disabled* in the BIOS (the
 > devices *do* work):
 >
 >    http://fpaste.org/296774/44908550/
 >

(I refreshed those links since they were almost a month old).

It was after getting the above dmesg's that I bisected kernel builds 
down to aafd8ba. If it would help, I can provide dmesg from just 
before/after that commit, with any sort of extra debugging you'd like 
turned on, or if you have a patch you'd like tested (or just something 
to add extra debugging) I'm happy to do that to. Since this is my main 
test machine for vfio device assignment, I'm open to do just about 
anything to help figure out the problem, but don't really have the 
knowledge to figure it out myself. :-)
