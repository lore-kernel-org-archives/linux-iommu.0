From: Sedat Dilek <sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Linux-4.19] ThinkPad T470 not booting with "intel_iommu=on"
Date: Tue, 16 Oct 2018 10:41:17 +0200
Message-ID: <CA+icZUXdr7_3BcunvQ8D8JE1KYhyVoERKBbLzANOR5D7GgZKuA@mail.gmail.com>
References: <CA+icZUXnB2LbB-X_pQeM=OQDEVcWQdUr9TLbG1cXnpwuTe=mNw@mail.gmail.com>
	<95f69db6-becd-adce-5477-264de839bcd8@linux.intel.com>
	<CA+icZUV8rEsY890jSd7K1+KQFUNC4MQk3z9MPBT8fpdTEG3X_w@mail.gmail.com>
	<cc4d8a8e-bf00-7a43-f022-baeb7628a238@linux.intel.com>
Reply-To: sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cc4d8a8e-bf00-7a43-f022-baeb7628a238-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Oct 16, 2018 at 10:03 AM Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>
> Hi,
>
> On 10/16/18 3:56 PM, Sedat Dilek wrote:
> > On Tue, Oct 16, 2018 at 8:37 AM Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> >>
> >> Hi Sedat,
> >>
> >> Sorry for late reply.
> >>
> >> Do you still have this issue with newer rc's (like 4.19-rc8)?
> >>
> >> I checked the dmesg log you attached there, it seems that the vt-d was
> >> not on actually.
> >>
> >
> > Hi Lu,
> >
> > Thanks for asking.
> >
> > I am running a Clang-7 compiled Linux 4.19-rc6 and VirtualBox is
> > reporting "IOMMU found".
> >
> > root@iniza:~# dmesg | grep -i iommu
> > [    0.000000] Command line: initrd=\initrd.img-4.19.0-rc6-1-amd64-cbl
> > root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro intel_iommu=on
> > [    0.145385] Kernel command line:
> > initrd=\initrd.img-4.19.0-rc6-1-amd64-cbl
> > root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro intel_iommu=on
> > [    0.145411] DMAR: IOMMU enabled
> > [    0.243068] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> > [    0.893466] iommu: Adding device 0000:00:00.0 to group 0
> > [    0.893475] iommu: Adding device 0000:00:02.0 to group 1
> > [    0.893490] iommu: Adding device 0000:00:14.0 to group 2
> > [    0.893498] iommu: Adding device 0000:00:14.2 to group 2
> > [    0.893508] iommu: Adding device 0000:00:15.0 to group 3
> > [    0.893519] iommu: Adding device 0000:00:16.0 to group 4
> > [    0.893545] iommu: Adding device 0000:00:1c.0 to group 5
> > [    0.893564] iommu: Adding device 0000:00:1c.6 to group 6
> > [    0.893580] iommu: Adding device 0000:00:1d.0 to group 7
> > [    0.893598] iommu: Adding device 0000:00:1d.2 to group 8
> > [    0.893624] iommu: Adding device 0000:00:1f.0 to group 9
> > [    0.893632] iommu: Adding device 0000:00:1f.2 to group 9
> > [    0.893640] iommu: Adding device 0000:00:1f.3 to group 9
> > [    0.893648] iommu: Adding device 0000:00:1f.4 to group 9
> > [    0.893656] iommu: Adding device 0000:00:1f.6 to group 9
> > [    0.893676] iommu: Adding device 0000:04:00.0 to group 10
> > [    0.893693] iommu: Adding device 0000:3e:00.0 to group 11
> > [    1.116440] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > [    1.116463] AMD IOMMUv2 functionality not available on this system
> > [   42.117773] vboxpci: IOMMU found
> >
> > How can I be sure Intel-IOMMU is working correctly beyond checking dmesg logs?
>
> Perhaps you need to check whether you've configured your VirtualBox to
> simulate an Intel-IOMMU device.
>

Checking [1]...
[ Unfortunately, I have the German VirtualBox version. ]

System > Acceleration > Activate VT-x (here: yes)

[ dmesg ]
[   11.521117] [drm] VT-d active for gfx access

[ vbox version ]
[   42.048419] vboxdrv: Successfully loaded version 5.2.18_Debian
(interface 0x00290001)

- sed@ -

[1] https://www.virtualbox.org/manual/ch09.html#pcipassthrough

> Best regards,
> Lu Baolu
>
> >
> > [1] recommends to check...
> >
> > root@iniza:~# find /sys | grep dmar
> >
> > Shall I re-check with Linux v4.19-rc8?
> >
> > Thanks in advance.
> >
> > Regards,
> > - Sedat -
> >
> > [1] https://stackoverflow.com/questions/44286683/check-for-iommu-support-on-linux
> > [2] https://www.kernel.org/doc/Documentation/Intel-IOMMU.txt
> >
> >> Best regards,
> >> Lu Baolu
> >>
> >> On 9/5/18 8:04 PM, Sedat Dilek wrote:
> >>> Hi Joerg,
> >>>
> >>> "intel_ioomu=on" was working fine here on my ThinkPad T470 with
> >>> debian/testing AMD64 with Linux v4.17.y and v4.18.y.
> >>>
> >>> With testing Linux v4.19-rc1 and v4.19-rc2 my machine is not booting -
> >>> black screen.
> >>> These kernels are built with LLVM/Clang v7.0.0rc2 (v4.18.y too).
> >>>
> >>> Furthermore, I switched from GRUB to systemd-boot v239.
> >>>
> >>> [ /boot/efi/loader/entries/debian.conf ]
> >>>
> >>> title Debian GNU/Linux buster/sid [ debian kernel ]
> >>> linux /vmlinuz-4.17.0-3-amd64
> >>> initrd /initrd.img-4.17.0-3-amd64
> >>> options root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro intel_iommu=on
> >>>
> >>> [ /boot/efi/loader/entries/debian-llvmlinux.conf ]
> >>>
> >>> title Debian GNU/Linux buster/sid [ llvmlinux kernel (EXPERIMENTAL) ]
> >>> linux /vmlinuz-4.19.0-rc2-3-iniza-llvmlinux
> >>> initrd /initrd.img-4.19.0-rc2-3-iniza-llvmlinux
> >>> options root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro
> >>>
> >>> Any hints or hints to debug this?
> >>> Any other kernel boot cheats [1] I can try?
> >>>
> >>> My kernel-config and dmesg output is attached.
> >>>
> >>> Thanks in advance.
> >>>
> >>> Regards,
> >>> - Sedat -
> >>>
> >>>
> >>> Documentation/intel_txt.txt
> >>> Documentation/admin-guide/kernel-parameters.txt
> >>> Documentation/Intel-IOMMU.txt
> >>>
> >>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n1645
> >>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/Intel-IOMMU.txt
> >>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/intel_txt.txt
> >>>
> >>>
> >>> _______________________________________________
> >>> iommu mailing list
> >>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> >>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >>>
> >
