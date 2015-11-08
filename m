From: Laine Stump <laine-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Regression in kernel 4.2.3+ (relative to 4.1.10) on AMD 990FX
	system with IOMMU enabled
Date: Sun, 8 Nov 2015 11:52:56 -0500
Message-ID: <563F7DE8.1090206@redhat.com>
References: <563A3F64.50808@redhat.com> <1446671291.3692.147.camel@redhat.com>
	<563BA893.4020202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <563BA893.4020202-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

On 11/05/2015 02:05 PM, Laine Stump wrote:
> On 11/04/2015 04:08 PM, Alex Williamson wrote:
>>
>> I built a 4.2.3 kernel for my 990fx system and can't seem to reproduce
>> it.  Does 'lspci -k' for those devices show any driver?
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
> /sys/devices/pci0000:00/0000:00:04.0/0000:02:00.0 does show a link from
> driver to ........drivers/igb, but .......:02::00.1 doesn't have a link,
> and neither of them shows up in /sys/class/net.
>
> Similarly for 01:00.[01] (which are behind the PCI to PCI bridge at
> 00:02.0), the .0 device does have a link to the radeon driver, but the
> .1 device (which is the sound device on the radeon video card) has no
> driver link.
>
> And 00:14.2 (the motherboard integrated sound device) shows no driver
> link in sysfs either.
>
>> Does 'lsmod'
>> show the drivers loaded, igb and snd_hda_intel?  If not, does manually
>> modprobe'ing either of those drivers change anything?
>
> Both of those drivers show up in lsmod output.
>
>> You haven't
>> installed a script that writes to driver_override or setup a
>> configuration where those devices are claimed by pci-stub and forgotten
>> about it, have you? (it's happened to me)
>
> Not that I'm aware of. /etc/modules.d/local.conf had a few stray very
> old items that I'd forgotten about, but I removed those and the results
> are the same.
>
>    Otherwise, dmesg is probably
>> a good place to start.
>
> Thanks to the uber-verbosity of systemd, this file is about 11MB. Where
> do you want me to put it?

I figured out that somehow my kernel commandlines had gotten options to 
put systemd logging into kmsg *and* set its logging to debug mode. Now 
that that is fixed, dmesg is much more manageable. Here is the dmesg 
with IOMMU enabled in the BIOS (i.e. the devices *don't* work):

   http://fpaste.org/288181/70011531/

and here is is when IOMMU has been *disabled* in the BIOS (the devices 
*do* work):

   http://fpaste.org/288182/47001302/
