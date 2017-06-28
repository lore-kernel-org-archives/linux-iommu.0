From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 28 Jun 2017 11:31:23 -0600
Message-ID: <20170628113123.2e5b5088@w520.home>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
	<CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
	<20170505112706.7785948c@t450s.home>
	<CAOcCaLbAS0FkRrG8YZNM5rYUtCFeUGkdgdy=4o16Njufdy8Gag@mail.gmail.com>
	<545f19a3-4923-cdec-4ce9-2a4155a04f6a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <545f19a3-4923-cdec-4ce9-2a4155a04f6a-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthias Ehrenfeuchter <efeu-5Zrl/DuVEGLQT0dZR+AlfA@public.gmane.org>, John.Bridgman-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 29 Jun 2017 00:23:20 +0700
Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org> wrote:
> So, I'm trying to reproduce this issue on the Ryzen system w/ the following setup:
> 
>    * Host kernel v4.11 (with this patch https://lkml.org/lkml/2017/6/23/295)
> 
>    * guest VM RHEL7.3
> 
>    * guest graphic driver = radeon
> 
>    * qemu-system-x86_64 --version
>      QEMU emulator version 2.9.50 (v2.9.0-1659-g577caa2-dirty)
> 
>    * kvm-amd npt=1
> 
>    * dGPU is 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
> [AMD/ATI] Tobago PRO [Radeon R7 360 / R9 360 OEM] (rev 81)
> 
>    * qemu-system-x86_64 -smp 4 -enable-kvm -M q35 -m 4096 -cpu host -bios 
> /usr/share/qemu/bios.bin -device 
> ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root.1 -drive 
> file=/sandbox/vm-images/rhel7.3.qcow2,if=virtio,id=disk0 -net none -vga none 
> -nodefaults -device 
> vfio-pci,host=08:00.0,x-vga=on,addr=0.0,multifunction=on,bus=root.1,romfile=/sandbox/vm-images/vbios.rom 
> -usb -device usb-host,hostbus=3,hostport=1 -device usb-host,hostbus=3,hostport=3 
> -device vfio-pci,host=0000:08:00.1 -device vfio-pci,host=0000:09:00.0
> 
> With this setup, I am able to pass-through the dGPU and run the following test:
>    * Starting up the guest w/ full GNOME GUI on the attached monitor.
>    * glxgears (running @ 60 FPS)
>    * Playing 1080p HD video on Youtube
> 
> I am not noticing issues here. What kind of test are you running in the guest VM?


Hi Suravee,

Thanks for your help!  I think we'd be in real trouble if glxgears
reported something less than 60fps (perhaps that might be easier to
debug though).  I'd suggest trying one of the Unigine benchmarks, like
Heaven.  There should be a noticeable and consistent framerate
difference for npt=0/1.  Thanks,

Alex
