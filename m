From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
 VT-d PI
Date: Fri, 9 Jan 2015 15:54:36 +0100
Message-ID: <20150109145435.GA22469@potion.brq.redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <1418397300-10870-14-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418397300-10870-14-git-send-email-feng.wu@intel.com>
Sender: kvm-owner@vger.kernel.org
To: Feng Wu <feng.wu@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, gleb@kernel.org, pbonzini@redhat.com, dwmw2@infradead.org, joro@8bytes.org, alex.williamson@redhat.com, jiang.liu@linux.intel.com, eric.auger@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

2014-12-12 23:14+0800, Feng Wu:
> This patch defines a new interface kvm_find_dest_vcpu for
> VT-d PI, which can returns the destination vCPU of the
> interrupt for guests.
>=20
> Since VT-d PI cannot handle broadcast/multicast interrupt,
> Here we only handle Fixed and Lowest priority interrupts.
>=20
> The current method of handling guest lowest priority interrtups
> is to use a counter 'apic_arb_prio' for each vCPU, we choose the
> vCPU with smallest 'apic_arb_prio' and then increase it by 1.
> However, for VT-d PI, we cannot re-use this, since we no longer
> have control to 'apic_arb_prio' with posted interrupt direct
> delivery by Hardware.
>=20
> Here, we introduce a similar way with 'apic_arb_prio' to handle
> guest lowest priority interrtups when VT-d PI is used. Here is the
> ideas:
> - Each vCPU has a counter 'round_robin_counter'.
> - When guests sets an interrupts to lowest priority, we choose
> the vCPU with smallest 'round_robin_counter' as the destination,
> then increase it.

There are two points relevant to this patch in new KVM's implementation=
,
("KVM: x86: amend APIC lowest priority arbitration",
 https://lkml.org/lkml/2015/1/9/362)

1) lowest priority depends on TPR
2) there is no need for balancing

(1) has to be considered with PI as well.
I kept (2) to avoid whining from people building on that behaviour, but
lowest priority backed by PI could be transparent without it.

Patch below removes the balancing, but I am not sure this is a price we
allowed ourselves to pay ... what are your opinions?


---8<---
KVM: x86: don't balance lowest priority interrupts

Balancing is not mandated by specification and real hardware most likel=
y
doesn't do it.  We break backward compatibility to allow optimizations.
(Posted interrupts can deliver to only one fixed destination.)

Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/lapic.c            | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
index 97a5dd0222c8..aa4bd8286232 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -370,7 +370,6 @@ struct kvm_vcpu_arch {
 	u64 apic_base;
 	struct kvm_lapic *apic;    /* kernel irqchip context */
 	unsigned long apic_attention;
-	int32_t apic_arb_prio;
 	int mp_state;
 	u64 ia32_misc_enable_msr;
 	bool tpr_access_reporting;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 5b9d8c589bba..eb85af8e8fc0 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -749,7 +749,6 @@ static int __apic_accept_irq(struct kvm_lapic *apic=
, int delivery_mode,
 				  trig_mode, vector);
 	switch (delivery_mode) {
 	case APIC_DM_LOWEST:
-		vcpu->arch.apic_arb_prio++;
 	case APIC_DM_FIXED:
 		/* FIXME add logic for vcpu on reset */
 		if (unlikely(!apic_enabled(apic)))
@@ -837,11 +836,9 @@ int kvm_apic_compare_prio(struct kvm_vcpu *vcpu1, =
struct kvm_vcpu *vcpu2)
 	 *      - uses the APR register (which also considers ISR and IRR),
 	 *      - chooses the highest APIC ID when APRs are identical,
 	 *      - and allows a focus processor.
-	 * XXX: pseudo-balancing with apic_arb_prio is a KVM-specific feature
 	 */
-	int tpr =3D kvm_apic_get_reg(vcpu1->arch.apic, APIC_TASKPRI) -
-	          kvm_apic_get_reg(vcpu2->arch.apic, APIC_TASKPRI);
-	return tpr ? : vcpu1->arch.apic_arb_prio - vcpu2->arch.apic_arb_prio;
+	return kvm_apic_get_reg(vcpu1->arch.apic, APIC_TASKPRI) -
+	       kvm_apic_get_reg(vcpu2->arch.apic, APIC_TASKPRI);
 }
=20
 static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
@@ -1595,7 +1592,6 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.pv_eoi.msr_val =3D 0;
 	apic_update_ppr(apic);
=20
-	vcpu->arch.apic_arb_prio =3D 0;
 	vcpu->arch.apic_attention =3D 0;
=20
 	apic_debug("%s: vcpu=3D%p, id=3D%d, base_msr=3D"
--=20
2.2.0

