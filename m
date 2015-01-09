From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
 VT-d PI
Date: Fri, 9 Jan 2015 16:12:59 +0100
Message-ID: <20150109151258.GC9877@potion.brq.redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <1418397300-10870-14-git-send-email-feng.wu@intel.com>
 <20150109145435.GA22469@potion.brq.redhat.com>
 <54AFEC00.80507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54AFEC00.80507@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Feng Wu <feng.wu@intel.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, gleb@kernel.org, dwmw2@infradead.org, joro@8bytes.org, alex.williamson@redhat.com, jiang.liu@linux.intel.com, eric.auger@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

2015-01-09 15:56+0100, Paolo Bonzini:
>=20
>=20
> On 09/01/2015 15:54, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> > There are two points relevant to this patch in new KVM's implementa=
tion,
> > ("KVM: x86: amend APIC lowest priority arbitration",
> >  https://lkml.org/lkml/2015/1/9/362)
> >=20
> > 1) lowest priority depends on TPR
> > 2) there is no need for balancing
> >=20
> > (1) has to be considered with PI as well.
>=20
> The chipset doesn't support it. :(

I meant that we need to recompute PI entries for lowest priority
interrupts every time guest's TPR changes.

Luckily, Linux doesn't use TPR, but other OS might be a reason to drop
lowest priority from PI optimizations.  (Or make it more complicated.)

> > I kept (2) to avoid whining from people building on that behaviour,=
 but
> > lowest priority backed by PI could be transparent without it.
> >=20
> > Patch below removes the balancing, but I am not sure this is a pric=
e we
> > allowed ourselves to pay ... what are your opinions?
>=20
> I wouldn't mind, but it requires a lot of benchmarking.

(I was afraid it would come to that.)
