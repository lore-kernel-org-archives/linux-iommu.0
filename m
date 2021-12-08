Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80E1C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 762E280E4C;
	Wed,  8 Dec 2021 23:43:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6jDkSxE3VEWG; Wed,  8 Dec 2021 23:43:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BC2480DBD;
	Wed,  8 Dec 2021 23:43:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1035CC002F;
	Wed,  8 Dec 2021 23:43:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FA17C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 23:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D94980DCC
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 23:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aUpIjxGkSJKY for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 23:43:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1E0580DBD
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 23:43:51 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id u11so2621218plf.3
 for <iommu@lists.linux-foundation.org>; Wed, 08 Dec 2021 15:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=D2Zllh8RS1Zi9zjCh06QY/RvfPuDSokdYb3fzzSJ8v0=;
 b=mq1FlM0Xuz3aQpWiXly0avavyF+dvXxhaqEyCb3mYFuN0cthNnCNPoJBuhh01ViSOm
 nerM+TRGjZ1cLalph2Rxsp/l48afYhC88VdcxVl18BZ2N23wcwZAgl14/Cbk862iuWma
 u+zhdN3JpeGuahQQTMlI5GN/EaabZfA/yLUB03GRRt2PHcw8Dsb7xBvcTW535b03vYhN
 cRCILk7apuletDmIrD7Wco3w5LVqsMqKXa8G44z312u55+dMHzRZc9JAkGkaIysjfCZa
 sLk1ZpyUmKb4GFjJFhCKUA/+K3ff+9u7/bR8LaS87oe1KcuKRWytUimno/Q5dfXO1m/t
 hERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D2Zllh8RS1Zi9zjCh06QY/RvfPuDSokdYb3fzzSJ8v0=;
 b=0mkFFE9TkzPlsMEpyrn8UKIFgUm0B/B0DgKXj5jYC+GnhAHGYLHt9o2aieNFxnk39V
 f70SLiyIc0qZBI2JZ0WjEVFAVCpchTlSo4PuqmioCbZKiXXZXpBttgsphDRZ8Y2xquJw
 zTp2WQ/riZ0TAleDxM0s9PiFayjoAVwRH58ibn8+N4deu5okBCeE0D5trLSqzii/+hyF
 1SZXtUMMgEMM+zTFFhsYosrW4Y/Vlc3j9R6Rx0y5JgqDX22SlOqkyUtL07uCR2hvqCca
 9pz6pfmjvsfGH/qae2LIJSmPg9D6dvNugRJySiXcKsGNHJa5MgPME6UVKer34Q3xXutl
 k3ug==
X-Gm-Message-State: AOAM531/YoiwBGN1rQvNxI0Q46wMj17IK5gGUvfAXwFl/ERLbil/cT6I
 cPA5dyF3aOESHu0vRrN1lyO8Kw==
X-Google-Smtp-Source: ABdhPJw/+1ilvMNYIcm+3goUyHH7lRTGi/Xr7IjyerSAkXdKoQjUDtsvqMlZKCw5KsqmNJTvunnjCg==
X-Received: by 2002:a17:902:bd02:b0:142:728b:e475 with SMTP id
 p2-20020a170902bd0200b00142728be475mr51304604pls.15.1639007030860; 
 Wed, 08 Dec 2021 15:43:50 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id s190sm3443803pgs.74.2021.12.08.15.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 15:43:50 -0800 (PST)
Date: Wed, 8 Dec 2021 23:43:46 +0000
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
Message-ID: <YbFDMjUdVltTSeHr@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Jim Mattson <jmattson@google.com>
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
From: Sean Christopherson via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> >   KVM: SVM: Remove unnecessary APICv/AVIC update in vCPU unblocking path

...

> Probably just luck (can't reproduce this anymore) but
> while running some kvm unit tests with this patch series (and few my patches
> for AVIC co-existance which shouldn't affect this) I got this
> 
> (warning about is_running already set)

My best guess would be the above commit that dropped the handling in the unblock
path, but I haven't been able to concoct a scenario where avic_physical_id_cache
can get out of sync with respect to kvm_vcpu_apicv_active().

> Dec 08 22:53:26 amdlaptop kernel: ------------[ cut here ]------------
> Dec 08 22:53:26 amdlaptop kernel: WARNING: CPU: 3 PID: 72804 at arch/x86/kvm/svm/avic.c:1045 avic_vcpu_load+0xe3/0x100 [kvm_amd]
> Dec 08 22:53:26 amdlaptop kernel: Modules linked in: kvm_amd(O) ccp rng_core kvm(O) irqbypass xt_conntrack ip6table_filter ip6_tables snd_soc_dmic snd_acp3x_>
> Dec 08 22:53:26 amdlaptop kernel:  r8169 realtek 8250_pci usbmon nbd fuse autofs4 [last unloaded: rng_core]
> Dec 08 22:53:26 amdlaptop kernel: CPU: 3 PID: 72804 Comm: qemu-system-i38 Tainted: G           O      5.16.0-rc4.unstable #6
> Dec 08 22:53:26 amdlaptop kernel: Hardware name: LENOVO 20UF001CUS/20UF001CUS, BIOS R1CET65W(1.34 ) 06/17/2021
> Dec 08 22:53:26 amdlaptop kernel: RIP: 0010:avic_vcpu_load+0xe3/0x100 [kvm_amd]
> Dec 08 22:53:26 amdlaptop kernel: Code: 0d 9f e0 85 c0 74 e8 4c 89 f6 4c 89 ff e8 a5 99 f4 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 5b 41 5c 41 5d 41 5e 41 >
> Dec 08 22:53:26 amdlaptop kernel: RSP: 0018:ffffc9000b17bba8 EFLAGS: 00010247
> Dec 08 22:53:26 amdlaptop kernel: RAX: 6f63203a756d6571 RBX: ffff888106194740 RCX: ffff88812e7ac000
> Dec 08 22:53:26 amdlaptop kernel: RDX: ffff8883ff6c0000 RSI: 0000000000000003 RDI: 0000000000000003
> Dec 08 22:53:26 amdlaptop kernel: RBP: ffffc9000b17bbd0 R08: ffff888106194740 R09: 0000000000000000
> Dec 08 22:53:26 amdlaptop kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
> Dec 08 22:53:26 amdlaptop kernel: R13: 0000000000000003 R14: ffff88810023b060 R15: dead000000000100
> Dec 08 22:53:26 amdlaptop kernel: FS:  0000000000000000(0000) GS:ffff8883ff6c0000(0000) knlGS:0000000000000000
> Dec 08 22:53:26 amdlaptop kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Dec 08 22:53:26 amdlaptop kernel: CR2: 00005587e812f958 CR3: 0000000105f31000 CR4: 0000000000350ee0
> Dec 08 22:53:26 amdlaptop kernel: DR0: 00000000004008da DR1: 0000000000000000 DR2: 0000000000000000
> Dec 08 22:53:26 amdlaptop kernel: DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Dec 08 22:53:26 amdlaptop kernel: Call Trace:
> Dec 08 22:53:26 amdlaptop kernel:  <TASK>
> Dec 08 22:53:26 amdlaptop kernel:  svm_vcpu_load+0x56/0x60 [kvm_amd]
> Dec 08 22:53:26 amdlaptop kernel:  kvm_arch_vcpu_load+0x32/0x210 [kvm]
> Dec 08 22:53:26 amdlaptop kernel:  vcpu_load+0x34/0x40 [kvm]
> Dec 08 22:53:26 amdlaptop kernel:  kvm_arch_destroy_vm+0xd4/0x1c0 [kvm]
> Dec 08 22:53:26 amdlaptop kernel:  kvm_destroy_vm+0x163/0x250 [kvm]
> Dec 08 22:53:26 amdlaptop kernel:  kvm_put_kvm+0x26/0x40 [kvm]
> Dec 08 22:53:26 amdlaptop kernel:  kvm_vm_release+0x22/0x30 [kvm]
> Dec 08 22:53:26 amdlaptop kernel:  __fput+0x94/0x250
> Dec 08 22:53:26 amdlaptop kernel:  ____fput+0xe/0x10
> Dec 08 22:53:26 amdlaptop kernel:  task_work_run+0x63/0xa0
> Dec 08 22:53:26 amdlaptop kernel:  do_exit+0x358/0xa30
> Dec 08 22:53:26 amdlaptop kernel:  do_group_exit+0x3b/0xa0
> Dec 08 22:53:26 amdlaptop kernel:  get_signal+0x15b/0x880
> Dec 08 22:53:26 amdlaptop kernel:  ? _copy_to_user+0x20/0x30
> Dec 08 22:53:26 amdlaptop kernel:  ? put_timespec64+0x3d/0x60
> Dec 08 22:53:26 amdlaptop kernel:  arch_do_signal_or_restart+0x106/0x740
> Dec 08 22:53:26 amdlaptop kernel:  ? hrtimer_nanosleep+0x9f/0x120
> Dec 08 22:53:26 amdlaptop kernel:  ? __hrtimer_init+0xd0/0xd0
> Dec 08 22:53:26 amdlaptop kernel:  exit_to_user_mode_prepare+0x112/0x1f0
> Dec 08 22:53:26 amdlaptop kernel:  syscall_exit_to_user_mode+0x17/0x40
> Dec 08 22:53:26 amdlaptop kernel:  do_syscall_64+0x42/0x80
> Dec 08 22:53:26 amdlaptop kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
> Dec 08 22:53:26 amdlaptop kernel: RIP: 0033:0x7f537abb13b5
> Dec 08 22:53:26 amdlaptop kernel: Code: Unable to access opcode bytes at RIP 0x7f537abb138b.
> Dec 08 22:53:26 amdlaptop kernel: RSP: 002b:00007f5376a39680 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
> Dec 08 22:53:26 amdlaptop kernel: RAX: fffffffffffffdfc RBX: 00007f5376a396d0 RCX: 00007f537abb13b5
> Dec 08 22:53:26 amdlaptop kernel: RDX: 00007f5376a396d0 RSI: 0000000000000000 RDI: 0000000000000000
> Dec 08 22:53:26 amdlaptop kernel: RBP: 00007f5376a396c0 R08: 0000000000000000 R09: 0000000000000000
> Dec 08 22:53:26 amdlaptop kernel: R10: 00007f5376a396c0 R11: 0000000000000293 R12: 00007f5376a3b640
> Dec 08 22:53:26 amdlaptop kernel: R13: 0000000000000002 R14: 00007f537ab66880 R15: 0000000000000000
> Dec 08 22:53:26 amdlaptop kernel:  </TASK>
> Dec 08 22:53:26 amdlaptop kernel: ---[ end trace 676058aaf29d0267 ]---
> 
> 
> I'll post my patches tomorrow, after some more testing.
> 
> Best regards,
> 	Maxim Levitsky
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
