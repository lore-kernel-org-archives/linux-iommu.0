Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE92CC432C0
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 01:51:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804022146E
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 01:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9Uril/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804022146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A31885239;
	Mon,  2 Dec 2019 01:51:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kLGIVyDd1Jry; Mon,  2 Dec 2019 01:51:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 43A8685188;
	Mon,  2 Dec 2019 01:51:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B4C5C1DD9;
	Mon,  2 Dec 2019 01:51:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D602C087F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 01:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 779DE860C6
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 01:51:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ChIfE72yUNot for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 01:51:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0DA1485239
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 01:51:35 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id z17so1140833uac.5
 for <iommu@lists.linux-foundation.org>; Sun, 01 Dec 2019 17:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=UYkvgAjWyc/mhe0LLb0UwRpPqZSVWK708Vy5BC3+kZM=;
 b=C9Uril/S4gk0O8tElkMSoyqtdpg9fopgelCTwmKiGlTuwzrXtihTy3zlMzbIVqd7sx
 kXiTABQ42bZsatsrMQzooXGkQ1kptvbiFwx1QPl7k+IuHHgVyTy3uPCgJWzEiQEWnM2W
 rybzhlmHzibJDJarlWWvaSbvc5/xPMndTqyLNPlIYRW6gf5ssY/l1OapJWMdeCmyUT6Z
 hvrJMEOBrrLBUmZo+WbhWT2kKBGmesPgA7hJd3wFVfJsuegw2DggWPW69I5k5trk2r17
 JcVlNTkP2+4WlSdOnMlB4fNSfrc/KazoOd9XacnbbnAqPRVnG2Fh8bnmj2PGbc0SB8p3
 i6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=UYkvgAjWyc/mhe0LLb0UwRpPqZSVWK708Vy5BC3+kZM=;
 b=kZR1OsBToMBhhnUPtFkpM5mlpfs+redfl/CdCQly4P5MDXtnvcSDohCpfXcVIXzPFp
 YURbWN/BNTIdYH4tyQ60bpWBiFmHxL3SZJ/3SmDK3cOTuLKEOapFkgAubGYBzRuU4NHi
 bsrkQWHlaTbyDEUH4sM4gGFJ5IuRkoFoEne6I3X1vVPuyTRyMy5ibCoptVjs6fjVmRY4
 pP2u8rBuSPhKLrfXqhZ4IeZDF68Gg8sT2cGXjf4gQ9aRasSCmfW4OM/3cuf1t4cNT9K1
 PbRl2aFH9TgGAaLHArd6BunqSDrI4pVu18ufgQyQ79H+XZGQUKmH3IhhASpINFSQrfS+
 DEFw==
X-Gm-Message-State: APjAAAV7DhvnJaQo/sOUNRAWHrPf49NvbhILbiadW5fvHYEV4tdihWW9
 Drw3NvJhoLESFF21tMsILsay6/I//PDocz09Vc265Vr1
X-Google-Smtp-Source: APXvYqxbdPkZDVpdLsgPQbmORs9U4qEZOwOVNgktwa1iit5RTJ4ra97DCknaOq1Rvbb+nCpoMxyuVZMgyj5/R/XM2Og=
X-Received: by 2002:ab0:2a0c:: with SMTP id o12mr16944653uar.72.1575251493832; 
 Sun, 01 Dec 2019 17:51:33 -0800 (PST)
MIME-Version: 1.0
References: <CAL20ACJ2cM1Zs3q5rb3jG7fDVNfzySV6WX=+nbdKiS4KT52NaQ@mail.gmail.com>
In-Reply-To: <CAL20ACJ2cM1Zs3q5rb3jG7fDVNfzySV6WX=+nbdKiS4KT52NaQ@mail.gmail.com>
From: Anand Misra <am.online.edu@gmail.com>
Date: Sun, 1 Dec 2019 17:51:22 -0800
Message-ID: <CAL20ACL0SZWcgqJ=K3hA8xXY4PUKFG2OGLX_TnzAKFT7RU7kCw@mail.gmail.com>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:667!
To: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: multipart/mixed; boundary="===============3436342208217405918=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============3436342208217405918==
Content-Type: multipart/alternative; boundary="000000000000b8cda40598aed144"

--000000000000b8cda40598aed144
Content-Type: text/plain; charset="UTF-8"

Correction:

1. get_user_pages_fast() for each hugepage start address for one page
2. sg_alloc_table_from_pages()  using page array from #1
3. dma_map_sg() for num hugepages using sgt from #2




On Sun, Dec 1, 2019 at 5:46 PM Anand Misra <am.online.edu@gmail.com> wrote:

> Hello:
>
> I'm in process of adding iommu support in my driver for a PCIe device. The
> device doesn't publish ACS/ATS via its config space. I've following config:
>
> Linux cmdline: "intel-iommu=on iommu=pt
> vfio_iommu_type1.allow_unsafe_interrupts=1 pcie_acs_override=downstream"
> Centos kernel: 3.10.0-1062.1.2.el7.x86_64
>
> I'm trying to use iommu for multiple hugepages (mmap'ed by process and
> pushed to driver via ioctl). The expectation is to have multiple hugepages
> mapped via iommu with each huge page having an entry in iommu (i.e.
> minimize table walk for DMA). Is this possible?
>
> [1] The driver ioctl has the following sequence:
>
> 1. get_user_pages_fast() for each hugepage start address for one page
> 2. sg_alloc_table_from_pages() using sgt from #3
> 3. dma_map_sg() for num hugepages using sgt from #4
>
> I'm getting kernel crash at #3 for "domain_get_iommu+0x55/0x70":
>
> ----------------------
> [148794.896405] kernel BUG at drivers/iommu/intel-iommu.c:667!
> [148794.896409] invalid opcode: 0000 [#1] SMP
> [148794.896414] Modules linked in: mydrv(OE) nfsv3 nfs_acl nfs lockd grace
> fscache xt_conntrack ipt_MASQUERADE nf_nat_masquerade_ipv4
> nf_conntrack_netlink nfnetlink xt_addrtype iptable_filter iptable_nat
> nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c
> br_netfilter bridge stp llc overlay(T) ipmi_devintf ipmi_msghandler sunrpc
> vfat fat iTCO_wdt mei_wdt iTCO_vendor_support sb_edac intel_powerclamp
> coretemp intel_rapl iosf_mbi kvm_intel kvm snd_hda_codec_hdmi irqbypass
> crc32_pclmul ghash_clmulni_intel aesni_intel snd_hda_codec_realtek lrw
> gf128mul glue_helper ablk_helper cryptd dell_smbios snd_hda_codec_generic
> intel_wmi_thunderbolt dcdbas dell_wmi_descriptor pcspkr snd_hda_intel
> snd_hda_codec snd_hda_core snd_hwdep i2c_i801 snd_seq snd_seq_device sg
> snd_pcm lpc_ich ftdi_sio snd_timer
> [148794.896522]  joydev snd mei_me mei soundcore pcc_cpufreq binfmt_misc
> ip_tables ext4 mbcache jbd2 sd_mod crc_t10dif crct10dif_generic sr_mod
> cdrom nouveau video mxm_wmi i2c_algo_bit drm_kms_helper crct10dif_pclmul
> crct10dif_common crc32c_intel serio_raw syscopyarea sysfillrect sysimgblt
> fb_sys_fops ttm ahci drm libahci ata_generic e1000e pata_acpi libata ptp
> pps_core drm_panel_orientation_quirks wmi [last unloaded: mydrv]
> [148794.896587] CPU: 0 PID: 6020 Comm: TestIommu Kdump: loaded Tainted: G
>           OE  ------------ T 3.10.0-1062.1.2.el7.x86_64 #1
> [148794.896592] Hardware name: Dell Inc. Precision Tower 5810/0HHV7N, BIOS
> A25 02/02/2018
> [148794.896597] task: ffff8c82b6e0d230 ti: ffff8c8ac5b6c000 task.ti:
> ffff8c8ac5b6c000
> [148794.896601] RIP: 0010:[<ffffffff8efff195>]  [<ffffffff8efff195>]
> domain_get_iommu+0x55/0x70
> [148794.896611] RSP: 0018:ffff8c8ac5b6fce8  EFLAGS: 00010202
> [148794.896614] RAX: ffff8c8adbeb0b00 RBX: ffff8c8ad4ac7600 RCX:
> 0000000000000000
> [148794.896619] RDX: 00000000fffffff0 RSI: ffff8c8ace6e5940 RDI:
> ffff8c8adbeb0b00
> [148794.896622] RBP: ffff8c8ac5b6fce8 R08: 000000000001f0a0 R09:
> ffffffff8f00255e
> [148794.896626] R10: ffff8c8bdfc1f0a0 R11: fffff941bc39b940 R12:
> 0000000000000001
> [148794.896630] R13: ffff8c4ce6b9d098 R14: 0000000000000000 R15:
> ffff8c8ac8f22a00
> [148794.896635] FS:  00007f1548320740(0000) GS:ffff8c8bdfc00000(0000)
> knlGS:0000000000000000
> [148794.896639] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [148794.896642] CR2: 00007f1547373689 CR3: 00000036f17c8000 CR4:
> 00000000003607f0
> [148794.896647] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [148794.896651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [148794.896654] Call Trace:
> [148794.896660]  [<ffffffff8f002ee5>] intel_map_sg+0x65/0x1e0
> [...]
>
> ----------------------
>
>
> [2] I've also tried using iommu APIs directly in my driver but I get "PTE
> Read access is not set" for DMA read when attempting DMA from host to
> device memory (size 1KB).
>
> DMAR: DRHD: handling fault status reg 2
> DMAR: [DMA Read] Request device [02:00.0] fault addr ffffc030b000 [fault
> reason 06] PTE Read access is not set
>
> I see the following messages after DMA failure (and eventually system
> crash):
>
> DMAR: DRHD: handling fault status reg 100
> DMAR: DRHD: handling fault status reg 100
>
>
> I've used the following sequence with iommu APIs:
>
> iommu_init:
>
>     iommu_group = iommu_group_get(dev)
>
>     iommu_domain = iommu_domain_alloc(&pci_bus_type)
>
>     init_iova_domain(&iova_domain)
>
>     iommu_attach_group(iommu_domain, iommu_group)
>
> iommu_map:
>
> iova = alloc_iova(&iova_domain, size >> shift, end >> shift, true);
>
>     addr = iova_dma_addr(&iova_domain, iova);
>
> iommu_map_sg(iommu_domain, addr, sgl, sgt->nents, IOMMU_READ |
> IOMMU_WRITE);
>
>
> Thanks,
> am
>
>

--000000000000b8cda40598aed144
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e">Correction:</div><div class=3D"gmail_default" style=3D"font-family:monos=
pace"><br></div><div class=3D"gmail_default" style=3D"font-family:monospace=
"><div class=3D"gmail_default" style=3D"font-family:monospace">1. get_user_=
pages_fast() for each hugepage start address for one page<br></div><div cla=
ss=3D"gmail_default" style=3D"font-family:monospace">2. sg_alloc_table_from=
_pages()=C2=A0 using page array from #1<br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace">3. dma_map_sg() for num hugepages using =
sgt from #2</div><div class=3D"gmail_default" style=3D"font-family:monospac=
e"><br></div><div class=3D"gmail_default" style=3D"font-family:monospace"><=
br></div><div class=3D"gmail_default" style=3D"font-family:monospace"><br><=
/div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Sun, Dec 1, 2019 at 5:46 PM Anand Misra &lt;<a href=3D"mailto=
:am.online.edu@gmail.com">am.online.edu@gmail.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div clas=
s=3D"gmail_default" style=3D"font-family:monospace">Hello:</div><div class=
=3D"gmail_default" style=3D"font-family:monospace"><br></div><div class=3D"=
gmail_default" style=3D"font-family:monospace">I&#39;m in process of adding=
 iommu support in my driver for a PCIe device. The device doesn&#39;t publi=
sh ACS/ATS via its config space. I&#39;ve following config:</div><div class=
=3D"gmail_default" style=3D"font-family:monospace"><br></div><div class=3D"=
gmail_default" style=3D"font-family:monospace">Linux cmdline: &quot;intel-i=
ommu=3Don iommu=3Dpt vfio_iommu_type1.allow_unsafe_interrupts=3D1 pcie_acs_=
override=3Ddownstream&quot;</div><div class=3D"gmail_default" style=3D"font=
-family:monospace"> Centos kernel: 3.10.0-1062.1.2.el7.x86_64</div><div cla=
ss=3D"gmail_default" style=3D"font-family:monospace"><br></div><div class=
=3D"gmail_default" style=3D"font-family:monospace">I&#39;m trying to use io=
mmu for multiple hugepages (mmap&#39;ed by process and pushed to driver via=
 ioctl). The expectation is to have multiple hugepages mapped via iommu wit=
h each huge page having an entry in iommu (i.e. minimize table walk for DMA=
). Is this possible?<br></div><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace"><br></div><div class=3D"gmail_default" style=3D"font-family=
:monospace">[1] The driver ioctl has the following sequence:</div><div clas=
s=3D"gmail_default" style=3D"font-family:monospace"><br></div><div class=3D=
"gmail_default" style=3D"font-family:monospace">1. get_user_pages_fast() fo=
r each hugepage start address for one page<br></div><div class=3D"gmail_def=
ault" style=3D"font-family:monospace">2. sg_alloc_table_from_pages() using =
sgt from #3</div><div class=3D"gmail_default" style=3D"font-family:monospac=
e">3. dma_map_sg() for num hugepages using sgt from #4</div><div class=3D"g=
mail_default" style=3D"font-family:monospace"><br></div><div class=3D"gmail=
_default" style=3D"font-family:monospace">I&#39;m getting kernel crash at #=
3 for &quot;domain_get_iommu+0x55/0x70&quot;:</div><div class=3D"gmail_defa=
ult" style=3D"font-family:monospace"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:monospace">----------------------</div><div class=3D"=
gmail_default" style=3D"font-family:monospace">[148794.896405] kernel BUG a=
t drivers/iommu/intel-iommu.c:667!<br>[148794.896409] invalid opcode: 0000 =
[#1] SMP<br>[148794.896414] Modules linked in: mydrv(OE) nfsv3 nfs_acl nfs =
lockd grace fscache xt_conntrack ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_c=
onntrack_netlink nfnetlink xt_addrtype iptable_filter iptable_nat nf_conntr=
ack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c br_netfil=
ter bridge stp llc overlay(T) ipmi_devintf ipmi_msghandler sunrpc vfat fat =
iTCO_wdt mei_wdt iTCO_vendor_support sb_edac intel_powerclamp coretemp inte=
l_rapl iosf_mbi kvm_intel kvm snd_hda_codec_hdmi irqbypass crc32_pclmul gha=
sh_clmulni_intel aesni_intel snd_hda_codec_realtek lrw gf128mul glue_helper=
 ablk_helper cryptd dell_smbios snd_hda_codec_generic intel_wmi_thunderbolt=
 dcdbas dell_wmi_descriptor pcspkr snd_hda_intel snd_hda_codec snd_hda_core=
 snd_hwdep i2c_i801 snd_seq snd_seq_device sg snd_pcm lpc_ich ftdi_sio snd_=
timer<br>[148794.896522] =C2=A0joydev snd mei_me mei soundcore pcc_cpufreq =
binfmt_misc ip_tables ext4 mbcache jbd2 sd_mod crc_t10dif crct10dif_generic=
 sr_mod cdrom nouveau video mxm_wmi i2c_algo_bit drm_kms_helper crct10dif_p=
clmul crct10dif_common crc32c_intel serio_raw syscopyarea sysfillrect sysim=
gblt fb_sys_fops ttm ahci drm libahci ata_generic e1000e pata_acpi libata p=
tp pps_core drm_panel_orientation_quirks wmi [last unloaded: mydrv]<br>[148=
794.896587] CPU: 0 PID: 6020 Comm: TestIommu Kdump: loaded Tainted: G =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OE =C2=A0------------ T 3.10.0-1062.1.2.el7=
.x86_64 #1<br>[148794.896592] Hardware name: Dell Inc. Precision Tower 5810=
/0HHV7N, BIOS A25 02/02/2018<br>[148794.896597] task: ffff8c82b6e0d230 ti: =
ffff8c8ac5b6c000 task.ti: ffff8c8ac5b6c000<br>[148794.896601] RIP: 0010:[&l=
t;ffffffff8efff195&gt;] =C2=A0[&lt;ffffffff8efff195&gt;] domain_get_iommu+0=
x55/0x70<br>[148794.896611] RSP: 0018:ffff8c8ac5b6fce8 =C2=A0EFLAGS: 000102=
02<br>[148794.896614] RAX: ffff8c8adbeb0b00 RBX: ffff8c8ad4ac7600 RCX: 0000=
000000000000<br>[148794.896619] RDX: 00000000fffffff0 RSI: ffff8c8ace6e5940=
 RDI: ffff8c8adbeb0b00<br>[148794.896622] RBP: ffff8c8ac5b6fce8 R08: 000000=
000001f0a0 R09: ffffffff8f00255e<br>[148794.896626] R10: ffff8c8bdfc1f0a0 R=
11: fffff941bc39b940 R12: 0000000000000001<br>[148794.896630] R13: ffff8c4c=
e6b9d098 R14: 0000000000000000 R15: ffff8c8ac8f22a00<br>[148794.896635] FS:=
 =C2=A000007f1548320740(0000) GS:ffff8c8bdfc00000(0000) knlGS:0000000000000=
000<br>[148794.896639] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000000800500=
33<br>[148794.896642] CR2: 00007f1547373689 CR3: 00000036f17c8000 CR4: 0000=
0000003607f0<br>[148794.896647] DR0: 0000000000000000 DR1: 0000000000000000=
 DR2: 0000000000000000<br>[148794.896651] DR3: 0000000000000000 DR6: 000000=
00fffe0ff0 DR7: 0000000000000400<br>[148794.896654] Call Trace:<br>[148794.=
896660] =C2=A0[&lt;ffffffff8f002ee5&gt;] intel_map_sg+0x65/0x1e0</div><div =
class=3D"gmail_default" style=3D"font-family:monospace">[...]</div><div cla=
ss=3D"gmail_default" style=3D"font-family:monospace"><br></div><div class=
=3D"gmail_default" style=3D"font-family:monospace">----------------------</=
div><div class=3D"gmail_default" style=3D"font-family:monospace"><br></div>=
<div class=3D"gmail_default" style=3D"font-family:monospace"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:monospace">[2] I&#39;ve also =
tried using iommu APIs directly in my driver but I get &quot;PTE Read acces=
s is not set&quot; for DMA read when attempting DMA from host to device mem=
ory (size 1KB). <br></div><div class=3D"gmail_default" style=3D"font-family=
:monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace">DMAR: DRHD: handling fault status reg 2<br>DMAR: [DMA Read] Request=
 device [02:00.0] fault addr ffffc030b000 [fault reason 06] PTE Read access=
 is not set</div><div class=3D"gmail_default" style=3D"font-family:monospac=
e"><br></div><div class=3D"gmail_default" style=3D"font-family:monospace">I=
 see the following messages after DMA failure (and eventually system crash)=
:</div><div class=3D"gmail_default" style=3D"font-family:monospace"><br></d=
iv><div class=3D"gmail_default" style=3D"font-family:monospace">DMAR: DRHD:=
 handling fault status reg 100<br>DMAR: DRHD: handling fault status reg 100=
</div><div class=3D"gmail_default" style=3D"font-family:monospace"><br></di=
v><div class=3D"gmail_default" style=3D"font-family:monospace"><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:monospace">I&#39;ve used th=
e following sequence with iommu APIs:</div><div class=3D"gmail_default" sty=
le=3D"font-family:monospace"><br></div><div class=3D"gmail_default" style=
=3D"font-family:monospace"><p dir=3D"ltr" style=3D"line-height:1.38" id=3D"=
gmail-m_1685275617441092gmail-docs-internal-guid-7c3d4825-7fff-2138-2cb1-c1=
6eaf65e1a7"><span style=3D"font-size:12pt;font-family:Arial;color:rgb(0,0,0=
);background-color:transparent;font-weight:700;font-style:normal;font-varia=
nt:normal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap=
">iommu_init:</span></p><p dir=3D"ltr" style=3D"line-height:1.38"><span sty=
le=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:tr=
ansparent;font-weight:400;font-style:normal;font-variant:normal;text-decora=
tion:none;vertical-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0 =
</span><span style=3D"font-size:11pt;font-family:&quot;Courier New&quot;;co=
lor:rgb(0,0,0);background-color:transparent;font-weight:400;font-style:norm=
al;font-variant:normal;text-decoration:none;vertical-align:baseline;white-s=
pace:pre-wrap">iommu_group =3D </span><span style=3D"font-size:11pt;font-fa=
mily:&quot;Courier New&quot;;color:rgb(0,0,0);background-color:transparent;=
font-weight:700;font-style:normal;font-variant:normal;text-decoration:none;=
vertical-align:baseline;white-space:pre-wrap">iommu_group_get</span><span s=
tyle=3D"font-size:11pt;font-family:&quot;Courier New&quot;;color:rgb(0,0,0)=
;background-color:transparent;font-weight:400;font-style:normal;font-varian=
t:normal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap"=
>(dev)</span></p><p dir=3D"ltr" style=3D"line-height:1.38"><span style=3D"f=
ont-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transpare=
nt;font-weight:400;font-style:normal;font-variant:normal;text-decoration:no=
ne;vertical-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0 </span>=
<span style=3D"font-size:11pt;font-family:&quot;Courier New&quot;;color:rgb=
(0,0,0);background-color:transparent;font-weight:400;font-style:normal;font=
-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pr=
e-wrap">iommu_domain =3D </span><span style=3D"font-size:11pt;font-family:&=
quot;Courier New&quot;;color:rgb(0,0,0);background-color:transparent;font-w=
eight:700;font-style:normal;font-variant:normal;text-decoration:none;vertic=
al-align:baseline;white-space:pre-wrap">iommu_domain_alloc</span><span styl=
e=3D"font-size:11pt;font-family:&quot;Courier New&quot;;color:rgb(0,0,0);ba=
ckground-color:transparent;font-weight:400;font-style:normal;font-variant:n=
ormal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap">(&=
amp;pci_bus_type)</span></p><p dir=3D"ltr" style=3D"line-height:1.38"><span=
 style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-colo=
r:transparent;font-weight:400;font-style:normal;font-variant:normal;text-de=
coration:none;vertical-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0=C2=
=A0 </span><span style=3D"font-size:11pt;font-family:&quot;Courier New&quot=
;;color:rgb(0,0,0);background-color:transparent;font-weight:700;font-style:=
normal;font-variant:normal;text-decoration:none;vertical-align:baseline;whi=
te-space:pre-wrap">init_iova_domain</span><span style=3D"font-size:11pt;fon=
t-family:&quot;Courier New&quot;;color:rgb(0,0,0);background-color:transpar=
ent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:n=
one;vertical-align:baseline;white-space:pre-wrap">(&amp;iova_domain)</span>=
</p><p dir=3D"ltr" style=3D"line-height:1.38"><span style=3D"font-size:11pt=
;font-family:Arial;color:rgb(0,0,0);background-color:transparent;font-weigh=
t:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-a=
lign:baseline;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0 </span><span style=
=3D"font-size:11pt;font-family:&quot;Courier New&quot;;color:rgb(0,0,0);bac=
kground-color:transparent;font-weight:700;font-style:normal;font-variant:no=
rmal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap">iom=
mu_attach_group</span><span style=3D"font-size:11pt;font-family:&quot;Couri=
er New&quot;;color:rgb(0,0,0);background-color:transparent;font-weight:400;=
font-style:normal;font-variant:normal;text-decoration:none;vertical-align:b=
aseline;white-space:pre-wrap">(iommu_domain, iommu_group)</span></p><p dir=
=3D"ltr" style=3D"line-height:1.38"><span style=3D"font-size:12pt;font-fami=
ly:Arial;color:rgb(0,0,0);background-color:transparent;font-weight:700;font=
-style:normal;font-variant:normal;text-decoration:none;vertical-align:basel=
ine;white-space:pre-wrap">iommu_map:</span></p><p dir=3D"ltr" style=3D"line=
-height:1.38;text-indent:36pt"><span style=3D"font-size:11pt;font-family:&q=
uot;Courier New&quot;;color:rgb(0,0,0);background-color:transparent;font-we=
ight:400;font-style:normal;font-variant:normal;text-decoration:none;vertica=
l-align:baseline;white-space:pre-wrap">iova =3D </span><span style=3D"font-=
size:11pt;font-family:&quot;Courier New&quot;;color:rgb(0,0,0);background-c=
olor:transparent;font-weight:700;font-style:normal;font-variant:normal;text=
-decoration:none;vertical-align:baseline;white-space:pre-wrap">alloc_iova</=
span><span style=3D"font-size:11pt;font-family:&quot;Courier New&quot;;colo=
r:rgb(0,0,0);background-color:transparent;font-weight:400;font-style:normal=
;font-variant:normal;text-decoration:none;vertical-align:baseline;white-spa=
ce:pre-wrap">(&amp;iova_domain, size &gt;&gt; shift, end &gt;&gt; shift, tr=
ue);</span></p><p dir=3D"ltr" style=3D"line-height:1.38"><span style=3D"fon=
t-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transparent=
;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none=
;vertical-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0         <=
/span><span style=3D"font-size:11pt;font-family:&quot;Courier New&quot;;col=
or:rgb(0,0,0);background-color:transparent;font-weight:400;font-style:norma=
l;font-variant:normal;text-decoration:none;vertical-align:baseline;white-sp=
ace:pre-wrap">addr =3D </span><span style=3D"font-size:11pt;font-family:&qu=
ot;Courier New&quot;;color:rgb(0,0,0);background-color:transparent;font-wei=
ght:700;font-style:normal;font-variant:normal;text-decoration:none;vertical=
-align:baseline;white-space:pre-wrap">iova_dma_addr</span><span style=3D"fo=
nt-size:11pt;font-family:&quot;Courier New&quot;;color:rgb(0,0,0);backgroun=
d-color:transparent;font-weight:400;font-style:normal;font-variant:normal;t=
ext-decoration:none;vertical-align:baseline;white-space:pre-wrap">(&amp;iov=
a_domain, iova);</span></p><p dir=3D"ltr" style=3D"line-height:1.38"><span =
style=3D"font-size:11pt;font-family:&quot;Courier New&quot;;color:rgb(0,0,0=
);background-color:transparent;font-weight:400;font-style:normal;font-varia=
nt:normal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap=
">     </span><span style=3D"font-size:11pt;font-family:&quot;Courier New&q=
uot;;color:rgb(0,0,0);background-color:transparent;font-weight:700;font-sty=
le:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;=
white-space:pre-wrap">iommu_map_sg</span><span style=3D"font-size:11pt;font=
-family:&quot;Courier New&quot;;color:rgb(0,0,0);background-color:transpare=
nt;font-weight:400;font-style:normal;font-variant:normal;text-decoration:no=
ne;vertical-align:baseline;white-space:pre-wrap">(iommu_domain, addr, sgl, =
sgt-&gt;nents, IOMMU_READ | IOMMU_WRITE);</span></p></div><div class=3D"gma=
il_default" style=3D"font-family:monospace"><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:monospace">Thanks,</div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace">am</div><div class=3D"gmail_default" sty=
le=3D"font-family:monospace"><br></div></div>
</blockquote></div>

--000000000000b8cda40598aed144--

--===============3436342208217405918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3436342208217405918==--
