From: Nick Sarnie <commendsarnex@gmail.com>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Tue, 17 Oct 2017 00:16:13 -0400
Message-ID: <CAOcCaLYmNe=wPSD-UkUJYZsbrEDjwf9anKH4_XU7-+f2VCfATA@mail.gmail.com>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
 <CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
 <20170505112706.7785948c@t450s.home> <CAOcCaLbAS0FkRrG8YZNM5rYUtCFeUGkdgdy=4o16Njufdy8Gag@mail.gmail.com>
 <545f19a3-4923-cdec-4ce9-2a4155a04f6a@amd.com> <CAK8d-aJ+XHi+5sr6bHj3D2BaG94v6Lyk1C_ZuA4erDVhEyp-uQ@mail.gmail.com>
 <5d2ea709-8f90-bfaa-975d-48aed39e75ad@amd.com> <20170628130855.76c2b700@w520.home>
 <BN6PR12MB1348B4850D77192356D960E9E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
 <BN6PR12MB13481A39CD3EA714754FEE49E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
 <CAEk7i1-Ar0ES8ekmSGiRrrWzTz8gFb2RDTW6KsbuNdDubVerww@mail.gmail.com>
 <ecfb6f20-6f74-3d46-b3fb-696d36ab4008@redhat.com> <CAOcCaLao_Y-8KP60baoSehtCu7C5CVnuuZNEom-zi54Fa2h+sQ@mail.gmail.com>
 <CAAq2Xdpu_rv7FgVfGCv-nYttGzH6hZujqdYvcf4qgXetkOGLzw@mail.gmail.com>
 <CAAq2XdppNcKcmbJhPQ9WfTowKSmp76jhDa9JHM1rc92Enx=1Zg@mail.gmail.com>
 <CAOcCaLbs8UPNUDus7hQoVez0gu_7CJCT1sZArdDjiqDGXAT44Q@mail.gmail.com> <CAAq2XdqHMNJ_R8diSHUatBw9p2-SH7v9us9StmP+obTOAc8-FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAAq2XdqHMNJ_R8diSHUatBw9p2-SH7v9us9StmP+obTOAc8-FQ@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Suravee.Suthikulpanit@amd.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Bridgman, John" <John.Bridgman@amd.com>, Jerome Glisse <jglisse@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 28, 2017 at 2:53 PM, Suravee Suthikulpanit
<Suravee.Suthikulpanit@amd.com> wrote:
>
>
> On 6/29/17 00:26, Steven Walter wrote:
>>>
>>> So, I'm trying to reproduce this issue on the Ryzen system w/ the
>>> following
>>> setup:
>>>
>>>   * Host kernel v4.11 (with this patch
>>> https://lkml.org/lkml/2017/6/23/295)
>>>
>>>   * guest VM RHEL7.3
>>>
>>>   * guest graphic driver = radeon
>>>
>>>   * qemu-system-x86_64 --version
>>>     QEMU emulator version 2.9.50 (v2.9.0-1659-g577caa2-dirty)
>>>
>>>   * kvm-amd npt=1
>>>
>>>   * dGPU is 08:00.0 VGA compatible controller: Advanced Micro Devices,
>>> Inc.
>>> [AMD/ATI] Tobago PRO [Radeon R7 360 / R9 360 OEM] (rev 81)
>>>
>>>   * qemu-system-x86_64 -smp 4 -enable-kvm -M q35 -m 4096 -cpu host -bios
>>> /usr/share/qemu/bios.bin -device
>>> ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root.1
>>> -drive file=/sandbox/vm-images/rhel7.3.qcow2,if=virtio,id=disk0 -net none
>>> -vga none -nodefaults -device
>>>
>>> vfio-pci,host=08:00.0,x-vga=on,addr=0.0,multifunction=on,bus=root.1,romfile=/sandbox/vm-images/vbios.rom
>>> -usb -device usb-host,hostbus=3,hostport=1 -device
>>> usb-host,hostbus=3,hostport=3 -device vfio-pci,host=0000:08:00.1 -device
>>> vfio-pci,host=0000:09:00.0
>>>
>>> With this setup, I am able to pass-through the dGPU and run the following
>>> test:
>>>   * Starting up the guest w/ full GNOME GUI on the attached monitor.
>>>   * glxgears (running @ 60 FPS)
>>>   * Playing 1080p HD video on Youtube
>>>
>>> I am not noticing issues here. What kind of test are you running in the
>>> guest VM?
>>
>> Try running the open source game "torcs" inside the VM.  I think
>> you'll find that there's a very noticeable performance different
>> between npt=1 and npt=0
>
>
> Hm.. actually torcs seems to be running fine w/ npt=1 setup. Although I
> think my driving skill is ~20% worse :(
>
> S

Hi Suravee,

Did you get a chance to test this again with a more graphically
intense program such as the Unigine Heaven benchmark? This is still a
massive issue in the community.

Thanks,
Sarnex
