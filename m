Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E898EC433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 14:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BBFD41C94;
	Wed,  8 Dec 2021 14:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cO_IJuVBjNJH; Wed,  8 Dec 2021 14:51:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EABF641C57;
	Wed,  8 Dec 2021 14:51:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9D9AC0039;
	Wed,  8 Dec 2021 14:51:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7F9AC001E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 14:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 995164040D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 14:51:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMALrOlM28Ad for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 14:51:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6B6341C57
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 14:51:40 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id r11so9073934edd.9
 for <iommu@lists.linux-foundation.org>; Wed, 08 Dec 2021 06:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QWHLsi58iBRKLpnRUwKPYaAT671ZxtkhBU1FfVlVdXg=;
 b=K+4tRxGphRbws1f4Rrz0JYGa2Qx/72RzMwQUficOEbDv1SlOEhtiw3VGzPcnLY3Jo2
 1P1jH2DJ2Il+6mtk7fPD06NeoCXeeNnt2d95pXGlX5eWBMj/BalrT7AJOOOFH5y4B+Yh
 b8/2uLh2bql/u5eRW9MQFgc6RCd3QhgJOBn/VzNrFN+K03/4iWwEiusX0q52KMF94+9w
 J7Ciwb0oFbIlV1xP3Q5cI99NcmtmsYgSsVKyS9dXEuTU3n0Y6frI6wYMO9YbKq4gRIE+
 YIu3o09Kn/5UNq4wSkPPAnn1vwABqCMS/QkwAmQ2i9tW+t2V5+C6zjqZk2zV+Y3arYOb
 XWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QWHLsi58iBRKLpnRUwKPYaAT671ZxtkhBU1FfVlVdXg=;
 b=uwjs7MGlEIjv2YORKpMy9/ky3LtATv1fURcQdyN+CFgaqmMKOlXfLjzt+eSCaInNuW
 4WC0Ky8VsL+pRmHLOX4QSd1YDxJXywDhq4lYQJ6sQobp+zx0NCoWSHsrblzDqSecYooL
 oxTOQxXU2bj9mnlRwvPGxZkEo1jsCeJkgSACtT0GKIJgjaFe8GFX3FZEG/R5NrlfT0W9
 fpjy383SQCtj4c4b2ou1zaCNKaDgEvB06QcjyrXmY409Qnb36/hoSLP1sSnCb/i+fj2e
 uYSqSBGoivFI0/ZL5berOIo9qreXSmvZcE6WGHSBpAgO6ndNLszUlHF8t+Y3uo+Qxq/p
 3o6w==
X-Gm-Message-State: AOAM532+Kn/CVUWtC8RRmYAMKoopS91Br21nSg1s9+4k7z8garpLsK5l
 LyhrfhJHOrz/FCmgNpdXv3Q=
X-Google-Smtp-Source: ABdhPJxCx1VEvF7FzfkCtA0NwaIDc28iCguT9i8qNKGCpeXl8YVLWLN6FoGepTtKHBM7AnLSsJFzHw==
X-Received: by 2002:a05:6402:4302:: with SMTP id
 m2mr19576689edc.349.1638975092953; 
 Wed, 08 Dec 2021 06:51:32 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id h10sm2087524edr.95.2021.12.08.06.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Dec 2021 06:51:32 -0800 (PST)
Message-ID: <518c3e07-41c8-feeb-5298-702c101994c7@redhat.com>
Date: Wed, 8 Dec 2021 15:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>
References: <20211208015236.1616697-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
 iommu@lists.linux-foundation.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 12/8/21 02:52, Sean Christopherson wrote:
> Overhaul and cleanup APIC virtualization (Posted Interrupts on Intel VMX,
> AVIC on AMD SVM) to streamline things as much as possible, remove a bunch
> of cruft, and document the lurking gotchas along the way.
> 
> Patch 01 is a fix from Paolo that's already been merged but hasn't made
> its way to kvm/queue.  It's included here to avoid a number of conflicts.
> 
> Based on kvm/queue, commit 1cf84614b04a ("KVM: x86: Exit to ...")

Queued, thanks; patches 24-26 for 5.16 and the rest for 5.17.

Just one nit: please tune the language to have a little fewer idiomatic 
phrases, as that can be a bit taxing on non-native speakers.  I for one 
enjoy learning a few new words, and it even adds some "personality" to 
the remote interactions, but it probably distracts people that aren't 
too preficient in English.

Paolo

> v3:
>   - Rebase to kvm/queue (and drop non-x86 patches as they've been queued).
>   - Redo AVIC patches, sadly the vcpu_(un)blocking() hooks need to stay.
>   - Add a patch to fix a missing (docuentation-only) barrier in nested
>     posted interrupt delivery. [Paolo]
>   - Collect reviews.
> 
> v2:
>   - https://lore.kernel.org/all/20211009021236.4122790-1-seanjc@google.com/
>   - Collect reviews. [Christian, David]
>   - Add patch to move arm64 WFI functionality out of hooks. [Marc]
>   - Add RISC-V to the fun.
>   - Add all the APICv fun.
> 
> v1: https://lkml.kernel.org/r/20210925005528.1145584-1-seanjc@google.com
> 
> Paolo Bonzini (1):
>    KVM: fix avic_set_running for preemptable kernels
> 
> Sean Christopherson (25):
>    KVM: nVMX: Ensure vCPU honors event request if posting nested IRQ
>      fails
>    KVM: VMX: Clean up PI pre/post-block WARNs
>    KVM: VMX: Handle PI wakeup shenanigans during vcpu_put/load
>    KVM: Drop unused kvm_vcpu.pre_pcpu field
>    KVM: Move x86 VMX's posted interrupt list_head to vcpu_vmx
>    KVM: VMX: Move preemption timer <=> hrtimer dance to common x86
>    KVM: x86: Unexport LAPIC's switch_to_{hv,sw}_timer() helpers
>    KVM: x86: Remove defunct pre_block/post_block kvm_x86_ops hooks
>    KVM: SVM: Signal AVIC doorbell iff vCPU is in guest mode
>    KVM: SVM: Don't bother checking for "running" AVIC when kicking for
>      IPIs
>    KVM: SVM: Remove unnecessary APICv/AVIC update in vCPU unblocking path
>    KVM: SVM: Use kvm_vcpu_is_blocking() in AVIC load to handle preemption
>    KVM: SVM: Skip AVIC and IRTE updates when loading blocking vCPU
>    iommu/amd: KVM: SVM: Use pCPU to infer IsRun state for IRTE
>    KVM: VMX: Don't do full kick when triggering posted interrupt "fails"
>    KVM: VMX: Wake vCPU when delivering posted IRQ even if vCPU == this
>      vCPU
>    KVM: VMX: Pass desired vector instead of bool for triggering posted
>      IRQ
>    KVM: VMX: Fold fallback path into triggering posted IRQ helper
>    KVM: VMX: Don't do full kick when handling posted interrupt wakeup
>    KVM: SVM: Drop AVIC's intermediate avic_set_running() helper
>    KVM: SVM: Move svm_hardware_setup() and its helpers below svm_x86_ops
>    KVM: SVM: Nullify vcpu_(un)blocking() hooks if AVIC is disabled
>    KVM: x86: Skip APICv update if APICv is disable at the module level
>    KVM: x86: Drop NULL check on kvm_x86_ops.check_apicv_inhibit_reasons
>    KVM: x86: Unexport __kvm_request_apicv_update()
> 
>   arch/x86/include/asm/kvm-x86-ops.h |   2 -
>   arch/x86/include/asm/kvm_host.h    |  12 -
>   arch/x86/kvm/hyperv.c              |   3 +
>   arch/x86/kvm/lapic.c               |   2 -
>   arch/x86/kvm/svm/avic.c            | 116 ++++---
>   arch/x86/kvm/svm/svm.c             | 479 ++++++++++++++---------------
>   arch/x86/kvm/svm/svm.h             |  16 +-
>   arch/x86/kvm/vmx/posted_intr.c     | 234 +++++++-------
>   arch/x86/kvm/vmx/posted_intr.h     |   8 +-
>   arch/x86/kvm/vmx/vmx.c             |  66 ++--
>   arch/x86/kvm/vmx/vmx.h             |   3 +
>   arch/x86/kvm/x86.c                 |  41 ++-
>   drivers/iommu/amd/iommu.c          |   6 +-
>   include/linux/amd-iommu.h          |   6 +-
>   include/linux/kvm_host.h           |   3 -
>   virt/kvm/kvm_main.c                |   3 -
>   16 files changed, 510 insertions(+), 490 deletions(-)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
