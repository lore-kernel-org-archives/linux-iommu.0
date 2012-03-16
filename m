From: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/9] Introduce irq_remap_ops to x86
Date: Thu, 15 Mar 2012 17:51:04 -0700
Message-ID: <CAE9FiQWPicLVgqEQmw9_8CsVaD9N8P_h6g42z7pUSibZBXLq-Q@mail.gmail.com>
References: <1331833191-25779-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1331833191-25779-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 15, 2012 at 10:39 AM, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote:
> Hi,
>
> in order to implement interrupt remapping using the AMD IOMMU I did some
> refactoring of the current Intel-specific interrupt remapping code. The
> result is posted for comments in this patch-set.
>
> The patch-set basically removes the Intel-specific calls from the X86
> apic and io-apic code and replaces all of them with helper functions
> that use the irq_remap_ops to hook into an implementation specific
> implementation.
>
> I have done basic testing on this patch-set on a VT-d machine with
> interrupt remapping and found no regression so far. But as usual this
> doesn't mean that there is none ;-)
>
> Anyway, since I am on vacation soon I sent out these patches to receive
> all kinds of comments so that I can start over to add the AMD part when
> I am back.
>
> Thanks,
>
> =A0 =A0 =A0 =A0Joerg
>
> Diffstat:
>
> =A0arch/ia64/include/asm/intr_remapping.h | =A0 =A04 +
> =A0arch/x86/include/asm/intr_remapping.h =A0| =A0101 +++
> =A0arch/x86/include/asm/irq_remapping.h =A0 | =A0 45 --
> =A0arch/x86/kernel/apic/apic.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 20 +-
> =A0arch/x86/kernel/apic/io_apic.c =A0 =A0 =A0 =A0 | =A0276 ++-------
> =A0drivers/iommu/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/iommu/amd_iommu_init.c =A0 =A0 =A0 =A0 | =A0123 +++--
> =A0drivers/iommu/dmar.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/iommu/intel-iommu.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/iommu/intel_intr_remapping.c =A0 | 1065 ++++++++++++++++++++++=
++++++++++
> =A0drivers/iommu/intr_remapping.c =A0 =A0 =A0 =A0 | =A0810 +++-----------=
-----------
> =A0drivers/iommu/intr_remapping.h =A0 =A0 =A0 =A0 | =A0 97 +++-
> =A0include/linux/amd-iommu.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0include/linux/dmar.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 85 ---
> =A014 files changed, 1469 insertions(+), 1163 deletions(-)

Yes, it is good clean up for ioapic.c at least.

Acked-by: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
