From: Pavel Fedin <p.fedin@samsung.com>
Subject: RE: [PATCH 00/10] KVM PCIe/MSI passthrough on ARM/ARM64
Date: Tue, 26 Jan 2016 20:25:06 +0300
Message-ID: <000001d1585e$8097d7e0$81c787a0$@samsung.com>
References: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-reply-to: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
Content-language: ru
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: 'Eric Auger' <eric.auger@linaro.org>, eric.auger@st.com, alex.williamson@redhat.com, will.deacon@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
Cc: patches@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

 Hello!
 I'd like just to clarify some things for myself and better wrap my head around it...

> On x86 all accesses to the 1MB PA region [FEE0_0000h - FEF0_000h] are directed
> as interrupt messages: accesses to this special PA window directly target the
> APIC configuration space and not DRAM, meaning the downstream IOMMU is bypassed.

 So, this is effectively the same as always having hardwired 1:1 mappings on all IOMMUs, isn't it ?
 If so, then we can't we just do the same, just by forcing similar 1:1 mapping? This is what i tried to do in my patchset. All of
you are talking about a situation which arises when we are emulating different machine with different physical addresses layout. And
e. g. if our host has MSI at 0xABADCAFE, our target could have valid RAM at the same location, and we need to handle it somehow,
therefore we have to move our MSI window out of target's RAM. But how does this work on a PC then? What if our host is PC, and we
want to emulate some ARM board, which has RAM at FE00 0000 ? Or does it mean that PC architecture is flawed and can reliably handle
PCI passthrough only for itself ?

Kind regards,
Pavel Fedin
Senior Engineer
Samsung Electronics Research center Russia
