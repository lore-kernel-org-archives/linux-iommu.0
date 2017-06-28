From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 28 Jun 2017 13:26:08 -0400
Message-ID: <CAK8d-aJ+XHi+5sr6bHj3D2BaG94v6Lyk1C_ZuA4erDVhEyp-uQ@mail.gmail.com>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
 <CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
 <20170505112706.7785948c@t450s.home> <CAOcCaLbAS0FkRrG8YZNM5rYUtCFeUGkdgdy=4o16Njufdy8Gag@mail.gmail.com>
 <545f19a3-4923-cdec-4ce9-2a4155a04f6a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <545f19a3-4923-cdec-4ce9-2a4155a04f6a@amd.com>
Sender: kvm-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Nick Sarnie <commendsarnex@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, iommu@lists.linux-foundation.org, Matthias Ehrenfeuchter <efeu@markju.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, John.Bridgman@amd.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 28, 2017 at 1:23 PM, Suravee Suthikulpanit
<Suravee.Suthikulpanit@amd.com> wrote:
>
>
> On 6/25/17 12:55, Nick Sarnie wrote:
>>
>> On Fri, May 5, 2017 at 1:27 PM, Alex Williamson
>> <alex.williamson@redhat.com> wrote:
>>>
>>> On Wed, 3 May 2017 12:28:35 -0400
>>> Nick Sarnie <commendsarnex@gmail.com> wrote:
>>>
>>>> On Wed, May 3, 2017 at 10:37 AM, Matthias Ehrenfeuchter
>>>> <efeu@markju.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> There are a lot of messages/threads out there about bad performance
>>>>> while
>>>>> using AMDs Ryzen with KVM GPU passthrough. It revolves all on
>>>>> enabling/disabling npt, while enabled overall VM performance is nice
>>>>> but the
>>>>> GPU performance gives me about 20% (and a lot of drops to zero GPU
>>>>> usage,
>>>>> while CPU/Disk/Ram also doing nothing) compared to npt disabled. But
>>>>> while
>>>>> npt is disabled overall VM performance is like beeing on 4x86 with
>>>>> floppy
>>>>> disk as only storage. (Ex. it takes 2 seconds just to open startmenu
>>>>> while
>>>>> host and vm are in idle, and neither CPU pinning, changing CPU model,
>>>>> changing storage device nor using hugepages changed anything).
>>>>>
>>>>> So everything I read pointed to a bug in the npt implementation?
>>>>> Anything I
>>>>> could do to get closer to the "thing" issuing this?
>>>>>
>>>>> Best Regards
>>>>>
>>>>> efeu
>>>>> _______________________________________________
>>>>> iommu mailing list
>>>>> iommu@lists.linux-foundation.org
>>>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>>>
>>>>
>>>> I heard from Joerg that it might be related to a lower intercept rate
>>>> being used when NPT is enabled, but we haven't been able to find a way
>>>> to trace that to confirm.
>>>
>>>
>>> Joerg/Paolo, any ideas how we might debug this?  Anyone from AMD
>>> watching?  Thanks,
>>>
>>> Alex
>>
>>
>>
>> Hi all,
>>
>> A somewhat major update.
>>
>> I managed to install Xen with my GPU passthrough config and test the
>> performance with NPT enabled.
>>
>> There is no performance drop with NPT on Xen, it matches the GPU
>> performance of KVM with NPT disabled. The CPU performance is also
>> great.
>>
>> John Bridgman (ccd) from AMD says he's going to ask around AMD about
>> this next week, but it would be even better if some AMD guys that read
>> this ML shared their ideas or took a look.
>>
>> Let me know if you need any more information.
>>
>> Thanks,
>> Sarnex
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
>
> So, I'm trying to reproduce this issue on the Ryzen system w/ the following
> setup:
>
>   * Host kernel v4.11 (with this patch https://lkml.org/lkml/2017/6/23/295)
>
>   * guest VM RHEL7.3
>
>   * guest graphic driver = radeon
>
>   * qemu-system-x86_64 --version
>     QEMU emulator version 2.9.50 (v2.9.0-1659-g577caa2-dirty)
>
>   * kvm-amd npt=1
>
>   * dGPU is 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Tobago PRO [Radeon R7 360 / R9 360 OEM] (rev 81)
>
>   * qemu-system-x86_64 -smp 4 -enable-kvm -M q35 -m 4096 -cpu host -bios
> /usr/share/qemu/bios.bin -device
> ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root.1
> -drive file=/sandbox/vm-images/rhel7.3.qcow2,if=virtio,id=disk0 -net none
> -vga none -nodefaults -device
> vfio-pci,host=08:00.0,x-vga=on,addr=0.0,multifunction=on,bus=root.1,romfile=/sandbox/vm-images/vbios.rom
> -usb -device usb-host,hostbus=3,hostport=1 -device
> usb-host,hostbus=3,hostport=3 -device vfio-pci,host=0000:08:00.1 -device
> vfio-pci,host=0000:09:00.0
>
> With this setup, I am able to pass-through the dGPU and run the following
> test:
>   * Starting up the guest w/ full GNOME GUI on the attached monitor.
>   * glxgears (running @ 60 FPS)
>   * Playing 1080p HD video on Youtube
>
> I am not noticing issues here. What kind of test are you running in the
> guest VM?

Try running the open source game "torcs" inside the VM.  I think
you'll find that there's a very noticeable performance different
between npt=1 and npt=0
-- 
-Steven Walter <stevenrwalter@gmail.com>
