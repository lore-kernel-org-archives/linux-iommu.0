From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on
	AMD boards.
Date: Mon, 29 Apr 2019 13:22:11 +0200
Message-ID: <20190429112211.GK26546@localhost>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
	<20190429094847.GI26546@localhost>
	<26c4a175-dae2-3410-6924-92fe7c8ec6fe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <26c4a175-dae2-3410-6924-92fe7c8ec6fe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "StarostaCZ-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <starostacz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 29, 2019 at 12:51:20PM +0200, StarostaCZ-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> Hello,
> sorry for other questions, but I am new in this list:
> Is Ubuntu server 19.04 with "kernel 5.0.9-050009-generic" good for this 
> test?

Yes, that might do depending on what else debian put in that kernel.

> Can I add attachments to this lists?

Sure, it's even preferred. Just try to trim non-relevant bits, and
perhaps provide a link to the full log.

> And who is xhci and iommu maintainers? Are they CC in this mail?

Yes, that's Mathias and Joerg, respectively, that I added on CC.

> Dne 29.4.2019 v 11:48 Johan Hovold napsal(a):
> > So this is a debian 4.18 kernel seemingly crashing due to a xhci or
> > iommu issue.
> >
> > Can you reproduce this on a mainline kernel?
> >
> > If so, please post the corresponding logs to the lists and CC the xhci
> > and iommu maintainers (added to CC).

Here's an excerpt from the 4.18 log meanwhile:

[    0.000000] Linux version 4.18.0-0.bpo.1-amd64 (debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org) (gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)) #1 SMP Debian 4.18.6-1~bpo9+1 (2018-09-13)

...

[  960.145603] xhci_hcd 0000:15:00.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
[ 1790.293623] xhci_hcd 0000:15:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x00000000fff50000 flags=0x0020]
[ 1790.300905] xhci_hcd 0000:15:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x00000000fde9e000 flags=0x0020]

...

[ 4789.145364] xhci_hcd 0000:15:00.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
[ 4789.310916] xhci_hcd 0000:15:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x00000000ff63c000 flags=0x0020]
[ 4789.317023] xhci_hcd 0000:15:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x00000000ff5c6000 flags=0x0020]
[ 4789.702446] xhci_hcd 0000:15:00.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
[ 4789.766842] xhci_hcd 0000:15:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x00000000fdeaf000 flags=0x0020]
[ 4789.781531] AMD-Vi: Event logged [IO_PAGE_FAULT device=15:00.0 domain=0x0000 address=0x00000000fdeaf040 flags=0x0020]
[ 4790.093644] general protection fault: 0000 [#1] SMP NOPTI
[ 4790.094186] CPU: 2 PID: 24561 Comm: readua Not tainted 4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
[ 4790.094738] Hardware name: Micro-Star International Co., Ltd MS-7B38/A320M PRO-VD PLUS (MS-7B38), BIOS 1.C0 11/02/2018
[ 4790.095333] RIP: 0010:prefetch_freepointer+0x10/0x20
[ 4790.095936] Code: 58 48 c7 c7 30 09 a5 b0 e8 4b 64 eb ff eb 90 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 85 f6 74 13 8b 47 20 48 01 c6 <48> 33 36 48 33 b7 38 01 00 00 0f 18 0e f3 c3 90 0f 1f 44 00 00 8b 
[ 4790.097314] RSP: 0018:ffffb6e303e67ce0 EFLAGS: 00010286
[ 4790.098016] RAX: 0000000000000000 RBX: 93773f762ca13047 RCX: 00000000000077df
[ 4790.098711] RDX: 00000000000077de RSI: 93773f762ca13047 RDI: ffff9a30de807c00
[ 4790.099413] RBP: ffff9a30d20cc018 R08: ffff9a30deca4de0 R09: 0000000000000000
[ 4790.100141] R10: ffff9a306f3c6638 R11: 0000000000000000 R12: 00000000006000c0
[ 4790.100871] R13: 0000000000000008 R14: ffff9a30de807c00 R15: ffff9a30de807c00
[ 4790.101619] FS:  0000000000000000(0000) GS:ffff9a30dec80000(0063) knlGS:00000000f7d6a700
[ 4790.102387] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[ 4790.103157] CR2: 00000000ffc77e3c CR3: 00000000af0c0000 CR4: 00000000003406e0
[ 4790.103954] Call Trace:
[ 4790.104753]  kmem_cache_alloc_trace+0xb5/0x1c0
[ 4790.105580]  ? proc_do_submiturb+0x35a/0xda0 [usbcore]
[ 4790.106382]  proc_do_submiturb+0x35a/0xda0 [usbcore]
[ 4790.107189]  ? futex_wake+0x94/0x170
[ 4790.108009]  proc_submiturb_compat+0xb1/0xe0 [usbcore]
[ 4790.108851]  usbdev_do_ioctl+0x894/0x1170 [usbcore]
[ 4790.109704]  usbdev_compat_ioctl+0xc/0x10 [usbcore]
[ 4790.110553]  __ia32_compat_sys_ioctl+0xc0/0x250
[ 4790.111413]  do_fast_syscall_32+0x98/0x1e0
[ 4790.112280]  entry_SYSCALL_compat_after_hwframe+0x45/0x4d
[ 4790.113167] Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipt_REJECT nf_reject_ipv4 xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack libcrc32c iptable_filter binfmt_misc nls_ascii nls_cp437 vfat fat efi_pstore edac_mce_amd ccp rng_core kvm snd_hda_codec_realtek snd_hda_codec_generic irqbypass crct10dif_pclmul crc32_pclmul snd_hda_codec_hdmi snd_hda_intel ghash_clmulni_intel wmi_bmof snd_hda_codec efivars pcspkr snd_hda_core snd_hwdep snd_pcm k10temp snd_timer sg snd soundcore sp5100_tco evdev pcc_cpufreq acpi_cpufreq efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb sd_mod hid_generic usbhid hid crc32c_intel aesni_intel aes_x86_64 crypto_simd cryptd glue_helper amdgpu ch
 ash gpu_sched
[ 4790.120417]  i2c_algo_bit i2c_piix4 ttm drm_kms_helper ahci xhci_pci libahci xhci_hcd drm libata r8169 mii usbcore scsi_mod usb_common wmi video gpio_amdpt gpio_generic button
[ 4790.122857] ---[ end trace bdd21237253335ac ]---
[ 4791.452933] RIP: 0010:prefetch_freepointer+0x10/0x20
[ 4791.461318] Code: 58 48 c7 c7 30 09 a5 b0 e8 4b 64 eb ff eb 90 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 85 f6 74 13 8b 47 20 48 01 c6 <48> 33 36 48 33 b7 38 01 00 00 0f 18 0e f3 c3 90 0f 1f 44 00 00 8b 
[ 4791.479889] RSP: 0018:ffffb6e303e67ce0 EFLAGS: 00010286
[ 4791.490112] RAX: 0000000000000000 RBX: 93773f762ca13047 RCX: 00000000000077df
[ 4791.500551] RDX: 00000000000077de RSI: 93773f762ca13047 RDI: ffff9a30de807c00
[ 4791.509946] RBP: ffff9a30d20cc018 R08: ffff9a30deca4de0 R09: 0000000000000000
[ 4791.519575] R10: ffff9a306f3c6638 R11: 0000000000000000 R12: 00000000006000c0
[ 4791.530038] R13: 0000000000000008 R14: ffff9a30de807c00 R15: ffff9a30de807c00
[ 4791.541665] FS:  0000000000000000(0000) GS:ffff9a30dec80000(0063) knlGS:00000000f7d6a700
[ 4791.544526] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[ 4791.546019] CR2: 00000000ffc77e3c CR3: 00000000af0c0000 CR4: 00000000003406e0 

Johan
