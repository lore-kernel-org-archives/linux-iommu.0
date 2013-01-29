From: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [git pull] ioapic-cleanups-for-v3.9
Date: Tue, 29 Jan 2013 10:07:25 +0100
Message-ID: <20130129090725.GA5775@gmail.com>
References: <20130125100040.GA13908@8bytes.org>
	<20130125104915.GB23332@gmail.com>
	<20130128155757.GA3643@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130128155757.GA3643-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


* Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> Hi Ingo,
> 
> On Fri, Jan 25, 2013 at 11:49:15AM +0100, Ingo Molnar wrote:
> > Hm, there are some not so trivial looking conflicts in 
> > io_apic.c, due to the MSI patches I applied yesterday:
> > 
> >  5ca72c4f7c41 AHCI: Support multiple MSIs
> >  08261d87f7d1 PCI/MSI: Enable multiple MSIs with pci_enable_msi_block_auto()
> >  51906e779f2b x86/MSI: Support multiple MSIs in presense of IRQ remapping
> > 
> > Could you please resolve them and resend?
> 
> Okay, I resolved the conflicts and tested the result again. Here it is:
> 
> The following changes since commit 5ca72c4f7c412c2002363218901eba5516c476b1:
> 
>   AHCI: Support multiple MSIs (2013-01-24 17:25:13 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/ioapic-cleanups-for-tip
> 
> for you to fetch changes up to a1bb20c232d066de0762f8e7cf332e5ce8385210:
> 
>   x86, irq: Move irq_remapped out of x86 core code (2013-01-28 12:51:52 +0100)
> 
> ----------------------------------------------------------------
> Cleanup X86 IOAPIC code from interrupt remapping details
> 
> These patches move all interrupt remapping specific checks out of the
> x86 core code and replaces the respective call-sites with function
> pointers. As a result the interrupt remapping code is better abstraced
> from x86 core interrupt handling code.
> 
> The code was rebased to v3.8-rc4 and tested on systems with AMD-Vi and
> Intel VT-d (both capable of interrupt remapping). The systems were
> tested with IOMMU enabled and with IOMMU disabled. No issues were found.
> 
> ----------------------------------------------------------------
> Joerg Roedel (19):
>       x86, apic: Move irq_remapping_enabled checks into IRQ-remapping code
>       x86, apic: Mask IO-APIC and PIC unconditionally on LAPIC resume
>       x86, io_apic: Introduce x86_io_apic_ops.disable()
>       x86, io_apic: Introduce x86_io_apic_ops.print_entries for debugging
>       x86, hpet: Introduce x86_msi_ops.setup_hpet_msi
>       x86, msi: Use IRQ remapping specific setup_msi_irqs routine
>       x86, io_apic: Introduce set_affinity function pointer
>       x86, io_apic: Convert setup_ioapic_entry to function pointer
>       x86, io_apic: Move irq_remapping_enabled checks out of check_timer()
>       x86, io_apic: Remove irq_remapping_enabled check in setup_timer_IRQ0_pin
>       x86, irq: Move irq_remapping_enabled declaration to iommu code
>       x86, irq: Add data structure to keep AMD specific irq remapping information
>       x86, io-apic: Move CONFIG_IRQ_REMAP code out of x86 core
>       x86, io-apic: Remove !irq_remapped() check from __target_IO_APIC_irq()
>       x86, irq: Move irq_remapped() check into free_remapped_irq
>       x86, irq: Introduce setup_remapped_irq()
>       x86, msi: Introduce x86_msi.compose_msi_msg call-back
>       x86, io_apic: Introduce eoi_ioapic_pin call-back
>       x86, irq: Move irq_remapped out of x86 core code
> 
>  arch/x86/include/asm/hpet.h          |    5 +-
>  arch/x86/include/asm/hw_irq.h        |   13 +-
>  arch/x86/include/asm/io_apic.h       |   28 +++
>  arch/x86/include/asm/irq_remapping.h |   40 ++-
>  arch/x86/include/asm/pci.h           |    3 +
>  arch/x86/include/asm/x86_init.h      |   27 +-
>  arch/x86/kernel/apic/apic.c          |   28 +--
>  arch/x86/kernel/apic/io_apic.c       |  446 +++++++++++-----------------------
>  arch/x86/kernel/hpet.c               |    2 +-
>  arch/x86/kernel/x86_init.c           |   24 +-
>  drivers/iommu/amd_iommu.c            |    8 +-
>  drivers/iommu/dmar.c                 |    2 +
>  drivers/iommu/intel-iommu.c          |    2 +
>  drivers/iommu/intel_irq_remapping.c  |   12 +
>  drivers/iommu/irq_remapping.c        |  231 +++++++++++++++++-
>  drivers/iommu/irq_remapping.h        |    1 +
>  include/linux/irq.h                  |    3 +
>  17 files changed, 504 insertions(+), 371 deletions(-)
> 
> Please pull.

Pulled, thanks Joerg!

	Ingo
