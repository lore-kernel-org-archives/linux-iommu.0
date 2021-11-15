Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E355DC433FE
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 15:31:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8521161B4C
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 15:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8521161B4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4954B605E1;
	Mon, 15 Nov 2021 15:31:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z6MToa8yeh44; Mon, 15 Nov 2021 15:31:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0321C60594;
	Mon, 15 Nov 2021 15:31:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCAFCC002E;
	Mon, 15 Nov 2021 15:31:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 672BEC0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 04:32:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B65A40317
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 04:32:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0OGMyp0u-eXr for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 04:32:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2DC140315
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 04:32:47 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3464B3F175
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 04:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1636950764;
 bh=r4ZWGl3iCPA6hDwfXpoPdrYcadHNqNqEtZJMc3MEasI=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
 b=RtQ01VWK+RahGOS4kE38L8Mz+OYZ3KUaJrtV053u73JkwAiqC/+u3hB3JzOZIKHPv
 aMpW/TkcG3uMV0YMnXRKA6SiXNF5IbP7eO8bJhAmKC6AuTm7wDerxGIaZzlF8ZaQ6T
 +fYuyZ2vRIOeFRgvjCIsrW0qebO3XJTXBClJAPhujsPd3I5b5r48QHNKyLn8/1dchf
 fpvgMSmH9ziPz1iELzAXfMAuE7cORAl+uyJMbvnsEBHbQov0WBFvf1yd4Sn6JggQhf
 ivZuzVSSnz9elRkpewa/OmPbnoPNeM/38dDsxu7gyLWUi3gvLUQwZaloba115PZj0v
 jyiWOCFmNWE2g==
Received: by mail-pf1-f200.google.com with SMTP id
 l7-20020a622507000000b00494608c84a4so9407308pfl.6
 for <iommu@lists.linux-foundation.org>; Sun, 14 Nov 2021 20:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=r4ZWGl3iCPA6hDwfXpoPdrYcadHNqNqEtZJMc3MEasI=;
 b=w03TPkwjI1JnmrE2PVNIrajJ1s13mxUpEMp8xn9tBOX76ERH25CWBcnhUOqGnq3z3c
 omLeN9wFLpRP+VTD6L0tfKjTH2cdP0OxYpSQEAKWMHYTxv8diDjgCLyq8Mhb1Ex4/OSP
 Yaz16o1ZlLe24/kBZqcsJ0onEMGAL2ch2gklw8yAfF8QJD4+2MVHtoAj77VyBH9QjYFz
 r4fKWl88MidccQva6lNfyBibI+OWT0vnho72CYRhyM/gKT30A43UyNVoSDkzn0K5Xpp8
 G/ARWYb3ta4uKmJ7xeaDChKk3DCbNY1sG7kgfswLTVXCD+GgZtThqbugU2MfFBx3Yqw/
 42mQ==
X-Gm-Message-State: AOAM531hmxxUGm+sPXwlQdp5KQIZKmuxmjHC1WuYKkFyuAlDBqgpyvIf
 obqgzVxwy2LkTPOefDh1gXg80eL6leCNJA7XbwzORlt6eZ9HfS6X6OhbabRpY+IxHIvkOS4O7pg
 BzzX/Tpw8AckbSk7zrEMAuLpPCP04Fet/Ouc6l0Ai5sfbO5PDr3KMNBnfdrGnjxA=
X-Received: by 2002:a65:6a4b:: with SMTP id o11mr22666648pgu.305.1636950762752; 
 Sun, 14 Nov 2021 20:32:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzK3IH5Wl3v139keC34aAowOOjNz1B+4mSvW9CmmCutt4A9c/e138vdG3ipPqwlnRHQB8H048T5Duy6TNx+hJU=
X-Received: by 2002:a65:6a4b:: with SMTP id o11mr22666635pgu.305.1636950762477; 
 Sun, 14 Nov 2021 20:32:42 -0800 (PST)
MIME-Version: 1.0
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Mon, 15 Nov 2021 17:32:31 +1300
Message-ID: <CAKAwkKvOmBFJwE7pQTAZd8b582sOdcnthe=FOEufxYhzQ00jWQ@mail.gmail.com>
Subject: [PROBLEM] crashkernel gets stuck at DMAR-IR: Copied IR table for
 dmar1 from previous kernel
To: iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Mon, 15 Nov 2021 15:31:32 +0000
Cc: Alex Williamson <alex.williamson@redhat.com>,
 lkml <linux-kernel@vger.kernel.org>,
 nathan.langford@xcelesunifiedtechnologies.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Dear IOMMU Subsystem Maintainers,

I have been debugging an issue with Nathan Langford, CC here, for some months
now, along with Alex Williamson on the linux-pci mailing list, and I just wanted
to check that we aren't also running into an IOMMU bug when enabling IRQ
remapping in the crashkernel.

Nathan has a system with 8x 2080TI graphics cards, and we are passing through
multiple GPUs to a KVM VM via vfio-pci. When we pass through 2x GPUs that share
the same upstream PCI switch, and reboot the VM a handful of times, an IRQ storm
occurs, and locks up the host system.

System Information:
- SuperMicro X9DRG-O(T)F
- 8x Nvidia GeForce RTX 2080 Ti GPUs
- Ubuntu 20.04 LTS
- 5.14.0 mainline kernel
- libvirt 6.0.0-0ubuntu8.10
- qemu 4.2-3ubuntu6.16
- intel_iommu=on

In the logs we see:

irq 31: nobody cared (try booting with the "irqpoll" option)
Call Trace:
 <IRQ>
 dump_stack_lvl+0x4a/0x5f
 dump_stack+0x10/0x12
 __report_bad_irq+0x3a/0xaf
 note_interrupt.cold+0xb/0x60
 handle_irq_event_percpu+0x72/0x80
 handle_irq_event+0x3b/0x60
 handle_fasteoi_irq+0x9c/0x150
 __common_interrupt+0x4b/0xb0
 common_interrupt+0x4a/0xa0
 asm_common_interrupt+0x1e/0x40
RIP: 0010:__do_softirq+0x73/0x2ae
handlers:
[<00000000b16da31d>] vfio_intx_handler
Disabling IRQ #31

Extra details on LKML / linux-pci:
https://lkml.org/lkml/2021/9/13/85

Now, Nathan has "kernel.hardlockup_panic = 1" set, which causes the kernel to
panic, and reboot to the crashkernel, and this is where the IOMMU issues begin.

The crashkernel loads, and gets as far as:

DMAR: Host address width 46
DMAR: DRHD base: 0x000000fbffe000 flags: 0x0
DMAR: dmar0: reg_base_addr fbffe000 ver 1:0 cap d2078c106f0466 ecap f020de
DMAR: DRHD base: 0x000000cbffc000 flags: 0x1
DMAR: dmar1: reg_base_addr cbffc000 ver 1:0 cap d2078c106f0466 ecap f020de
DMAR: RMRR base: 0x0000005f21a000 end: 0x0000005f228fff
DMAR: ATSR flags: 0x0
DMAR: RHSA base: 0x000000fbffe000 proximity domain: 0x1
DMAR: RHSA base: 0x000000cbffc000 proximity domain: 0x0
DMAR-IR: IOAPIC id 3 under DRHD base  0xfbffe000 IOMMU 0
DMAR-IR: IOAPIC id 0 under DRHD base  0xcbffc000 IOMMU 1
DMAR-IR: IOAPIC id 2 under DRHD base  0xcbffc000 IOMMU 1
DMAR-IR: HPET id 0 under DRHD base 0xcbffc000
[    3.271530] DMAR-IR: Queued invalidation will be enabled to support
x2apic and Intr-remapping.
[    3.282572] DMAR-IR: Copied IR table for dmar0 from previous kernel
[   13.291319] DMAR-IR: Copied IR table for dmar1 from previous kernel

I added the timestamps for the last couple entries. There is a ten second hang
between copying the IR table from dmar0 and copying the IR table from dmar1.

After this, the kernel just hangs, and the system has to be hard rebooted.

Full dmesg:
https://paste.ubuntu.com/p/M7Bdyk9YV7/

We never see the next message that usually happens with plain old sysrq-trigger,
which is:

DMAR-IR: Enabled IRQ remapping in x2apic mode

Would an ongoing IRQ storm prevent IRQ remapping being enabled?

From my understanding, when we start the crashkernel, PCI devices are in an
undefined state, and could keep on sending DMA or IRQ requests to the
crashkernel, which could break things through data corruption or causing IRQs to
be blocked if we get too many spurious IRQs. This would then cause problems if
we try and re-initialise these PCI devices and they have IRQs blocked.

Which is why we copy the old IR tables from dmar regions, and unblock blocked
IRQs. But if an IRQ storm is ongoing, is there anything we can really do? Is it
a bug to just hang here, or is it an indication that the system administrator
needs to go and do a full hardware reset?

Please let us know if you need any additional debugging information, we can
build patched kernels if you need extra debug output.

Thanks,
Matthew
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
