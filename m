Return-Path: <SRS0=ZMNw=SJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A37C10F0E
	for <iommu@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34B1213F2
	for <iommu@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34B1213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8FD7EC6C;
	Sun,  7 Apr 2019 21:06:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 32D4CC59
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Apr 2019 21:06:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 88667709
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Apr 2019 21:06:52 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 925D3308794B;
	Sun,  7 Apr 2019 21:06:51 +0000 (UTC)
Received: from x1.home (ovpn-116-153.phx2.redhat.com [10.3.116.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1EE6E1001E91;
	Sun,  7 Apr 2019 21:06:51 +0000 (UTC)
Date: Sun, 7 Apr 2019 15:06:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
Message-ID: <20190407150650.060cc508@x1.home>
In-Reply-To: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Sun, 07 Apr 2019 21:06:51 +0000 (UTC)
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
	Jiang Liu <jiang.liu@linux.intel.com>, James Smart <jsmart2021@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190407210650.8oftfllq159S4tr57rm--PinLXeZvT636y6zZxTWz2Q@z>

On Sun, 7 Apr 2019 12:10:38 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> Hi Jiang,
> 
> If I tell qemu to use PCI pass-through for a PCI adapter and next load the
> lpfc driver for an lpfc adapter that has not been passed through to any VM
> a kernel bug is hit. Do you perhaps know whether it should be possible to
> a load kernel driver in this scenario? If so, do you know what should change
> to avoid that this kernel bug is hit? Should the iommu code be modified or
> should the lpfc code be modified? I'm asking you because I think that you
> introduced the BUG() statement that was hit. See also commit ab8dfe251571
> ("iommu/vt-d: Introduce helper functions to improve code readability"; v3.17).

Do both of these lpfc devices belong to the same IOMMU group?
(/sys/kernel/iommu_groups/)  Thanks,

Alex

> ------------[ cut here ]------------
> kernel BUG at drivers/iommu/intel-iommu.c:608!
> invalid opcode: 0000 [#1] SMP
> CPU: 7 PID: 7842 Comm: modprobe Not tainted 5.0.7+ #2
> Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F10 08/03/2015
> RIP: 0010:domain_get_iommu+0x50/0x60
> Code: c2 01 eb 0b 48 83 c0 01 8b 34 87 85 f6 75 0b 48 39 c2 48 63 c8 75 ed 31 c0 c3 48 c1 e1 03 48 8b 05 15 9b cd 00 48 8b 04 08 c3 <0f> 0b 31 c9 eb ee 66 2e 0f 1f 84 00 00 00 00 00 41 55 8b 05 d0 9a
> RSP: 0018:ffffa7884024ba60 EFLAGS: 00010202
> RAX: ffff96c8897c60c0 RBX: 00000004046c2000 RCX: ffff96c88edab000
> RDX: 00000000fffffff0 RSI: ffff96c88e08de80 RDI: ffff96c8897c60c0
> RBP: 0000000000000000 R08: ffff96c88b806b40 R09: ffff96c88f802f50
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff96c88edab0b0
> R13: ffffffffffffffff R14: 0000000000001000 R15: ffff96c8897c60c0
> FS:  00007fec74c05b80(0000) GS:ffff96c89fbc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fec74c5dc80 CR3: 0000000404686004 CR4: 00000000001626e0
> Call Trace:
>   __intel_map_page+0x7e/0x150
>   intel_alloc_coherent+0xa7/0x130
>   dma_alloc_attrs+0x6b/0xc0
>   dma_pool_alloc+0xb8/0x1a0
>   lpfc_mem_alloc+0x109/0x3e0 [lpfc]
>   lpfc_pci_probe_one+0xdac/0x2060 [lpfc]
>   pci_device_probe+0xc3/0x140
>   really_probe+0xd2/0x380
>   driver_probe_device+0xae/0xf0
>   __driver_attach+0xd5/0x100
>   ? driver_probe_device+0xf0/0xf0
>   bus_for_each_dev+0x5b/0x90
>   bus_add_driver+0x208/0x220
>   ? 0xffffffffc0ad9000
>   driver_register+0x66/0xb0
>   ? 0xffffffffc0ad9000
>   lpfc_init+0xd5/0x1000 [lpfc]
>   do_one_initcall+0x2e/0x181
>   ? __vunmap+0x75/0xb0
>   do_init_module+0x55/0x1e0
>   load_module+0x2438/0x2560
>   ? __do_sys_finit_module+0x8f/0xd0
>   __do_sys_finit_module+0x8f/0xd0
>   do_syscall_64+0x44/0xf0
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fec74d212f9
> Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6f 4b 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffea26c1458 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 000055eeaf1669c0 RCX: 00007fec74d212f9
> RDX: 0000000000000000 RSI: 000055eeaf0ee3c8 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000000000000 R09: 000055eeaf166400
> R10: 0000000000000004 R11: 0000000000000246 R12: 000055eeaf0ee3c8
> R13: 0000000000040000 R14: 000055eeaf16eb90 R15: 000055eeaf1669c0
> Modules linked in: lpfc(+) scsi_transport_fc mlx4_ib ib_uverbs ib_core mlx4_en mlx4_core pci_stub af_packet vhost_net vhost tun vfio_pci vfio_virqfd vfio_iommu_type1 vfio fuse dm_crypt algif_skcipher af_alg loop devlink bridge stp llc xt_tcpudp ip6t_rpfilter ip6t_REJECT 
> nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
> scsi_transport_iscsi ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables bpfilter coretemp hwmon intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm irqbypass crct10dif_pclmul snd_hda_codec_hdmi crc32_pclmul 
> ghash_clmulni_intel snd_hda_codec_realtek snd_hda_codec_generic aesni_intel aes_x86_64 crypto_simd cryptd snd_hda_intel iTCO_wdt mei_me iTCO_vendor_support joydev mxm_wmi glue_helper e1000e alx
>   mdio intel_rapl_perf snd_hda_codec mei ptp lpc_ich pcspkr i2c_i801 snd_hda_core pps_core mfd_core fan thermal wmi pcc_cpufreq acpi_pad button snd_usb_audio snd_usbmidi_lib snd_hwdep snd_rawmidi snd_seq_device snd_pcm snd_timer snd soundcore ext4 crc16 mbcache jbd2 
> hid_generic usbhid sd_mod i915 intel_gtt i2c_algo_bit iosf_mbi drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ahci libahci drm drm_panel_orientation_quirks xhci_pci libata ehci_pci agpgart ehci_hcd xhci_hcd i2c_core video usbcore usb_common sg dm_multipath 
> dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod unix ipv6 autofs4 [last unloaded: scsi_transport_fc]
> ---[ end trace cc531c0d02c790cc ]---
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
