From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH linux-next] iommu: Enable LPAE pagetable on ARM only
Date: Wed, 25 Feb 2015 10:00:45 +0000
Message-ID: <20150225100044.GC20673@arm.com>
References: <1424621346-7822-1-git-send-email-vincent.stehle@laposte.net>
 <2868840.GyWYJOzqWH@avalon>
 <CAMuHMdXpSbEdrQ=1-m_MBv6RUb92waZ0BjLr1p790R9+L3Z8ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXpSbEdrQ=1-m_MBv6RUb92waZ0BjLr1p790R9+L3Z8ww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 24, 2015 at 10:33:02AM +0000, Geert Uytterhoeven wrote:
> On Mon, Feb 23, 2015 at 5:52 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Sunday 22 February 2015 17:09:06 Vincent Stehl=E9 wrote:
> >> LPAE iommu page table makes sense only for ARM architecture. Add t=
he
> >> corresponding dependency in Kconfig.
> >>
> >> This fixes the following runtime warnings on PA-RISC architecture:
> >
> > I suppose this is caused by the selftest code ?
> >
> >>   WARNING: at drivers/iommu/io-pgtable-arm.c:413
> >>   Modules linked in:
> >>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> >> 3.19.0-next-20150222-00002-gc420256 #2 task: 17ca0000 ti: 17ca8000=
 task.ti:
> >> 17ca8000
> >>
> >>        YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
> >>   PSW: 00000000000001001111111100001111 Not tainted
> >>   r00-03  0004ff0f 0000001b 104871b0 17ca83c0
> >>   r04-07  00001000 00000000 00000000 00000000
> >>   r08-11  00000000 40001000 1013b36c 17ca8248
> >>   r12-15  00000080 17e712c0 00000000 17c5e100
> >>   r16-19  0000000c 105d8eb0 40001000 ffffffff
> >>   r20-23  00000000 00800020 1048717c 00000000
> >>   r24-27  00001000 00000000 00000009 10774ce0
> >>   r28-31  00000000 00000027 17ca8480 10486d44
> >>   sr00-03  00000000 00000000 00000000 00000000
> >>   sr04-07  00000000 00000000 00000000 00000000
> >>
> >>   IASQ: 00000000 00000000 IAOQ: 10486df4 10486df8
> >>    IIR: 03ffe01f    ISR: 00000000  IOR: 17c86e54
> >>    CPU:        0   CR30: 17ca8000 CR31: 00000002
> >>    ORIG_R28: 00000001
> >>    IAOQ[0]: __arm_lpae_unmap+0x144/0x4cc
> >>    IAOQ[1]: __arm_lpae_unmap+0x148/0x4cc
> >>    RP(r2): arm_lpae_unmap+0x34/0x6c
> >>   Backtrace:
> >>    [<104871b0>] arm_lpae_unmap+0x34/0x6c
> >>    [<10127944>] 0x10127944
> >>    [<10168ee0>] do_one_initcall+0x128/0x1dc
> >>    [<101028fc>] 0x101028fc
> >>    [<10161b48>] kernel_init+0x1c/0x118
> >>    [<1015d01c>] end_fault_vector+0x1c/0x24
> >>    [<101762ec>] save_stack_trace+0x28/0x60
> >>
> >> Signed-off-by: Vincent Stehl=E9 <vincent.stehle@laposte.net>
> >> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> ---
> >>
> >>
> >> Hi,
> >>
> >> This can be seen with e.g. Linux next-20150222 on parisc with allm=
odconfig.
> >>
> >> Best regards,
> >>
> >> V.
> >>
> >>
> >>  drivers/iommu/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> >> index baa0d97..c73fd72 100644
> >> --- a/drivers/iommu/Kconfig
> >> +++ b/drivers/iommu/Kconfig
> >> @@ -22,6 +22,7 @@ config IOMMU_IO_PGTABLE
> >>
> >>  config IOMMU_IO_PGTABLE_LPAE
> >>       bool "ARMv7/v8 Long Descriptor Format"
> >> +     depends on ARM
> >
> > How about ARM || COMPILE_TEST ? It can still be useful to compile t=
he module
> > on other architectures.
>=20
> COMPILE_TEST is meant for test-compiling drivers or subsystems that a=
re not
> useful on all platforms. IMHO COMPILE_TEST kernels are still supposed=
 to boot
> without ill effects.
>=20
> Now, I understand the issue on PA-RISC is with the selftest, not with=
 the actual
> IOMMU_IO_PGTABLE_LPAE module? Then IOMMU_IO_PGTABLE_LPAE
> can depend on ARM || COMPILE_TEST (|| ARM64, cfr. Laurent's later ema=
il).
>=20
> But the selftest should protect itself against running on non-ARM, ei=
ther
> by making IOMMU_IO_PGTABLE_LPAE_SELFTEST depend on ARM(64)
> (without "|| COMPILE_TEST"), or by adding a check to arm_lpae_do_self=
tests(),
> to please all compile-testers.

Perhaps, but actually the issues reported by the self-test are *real* b=
ugs
that I've now got fixes for. They just don't show up on arm platforms
because of different right shift behaviour.

Will
