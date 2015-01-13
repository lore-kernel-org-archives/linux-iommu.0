From: Radim =?utf-8?B?S3I/bcOhPw==?= <rkrcmar@redhat.com>
Subject: Re: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
 VT-d PI
Date: Tue, 13 Jan 2015 17:17:16 +0100
Message-ID: <20150113161716.GA12941@potion.brq.redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <1418397300-10870-14-git-send-email-feng.wu@intel.com>
 <20150109145435.GA22469@potion.brq.redhat.com>
 <54AFEC00.80507@redhat.com>
 <E959C4978C3B6342920538CF579893F002341102@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E959C4978C3B6342920538CF579893F002341102@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wu, Feng" <feng.wu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "gleb@kernel.org" <gleb@kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

2015-01-13 00:27+0000, Wu, Feng:
> > On 09/01/2015 15:54, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> > > There are two points relevant to this patch in new KVM's implemen=
tation,
> > > ("KVM: x86: amend APIC lowest priority arbitration",
> > >  https://lkml.org/lkml/2015/1/9/362)
> > >
> > > 1) lowest priority depends on TPR
> > > 2) there is no need for balancing
> > >
> > > (1) has to be considered with PI as well.
> >=20
> > The chipset doesn't support it. :(
> >=20
> > > I kept (2) to avoid whining from people building on that behaviou=
r, but
> > > lowest priority backed by PI could be transparent without it.
> > >
> > > Patch below removes the balancing, but I am not sure this is a pr=
ice we
> > > allowed ourselves to pay ... what are your opinions?
> >=20
> > I wouldn't mind, but it requires a lot of benchmarking.
>=20
> In fact, the real hardware may do lowest priority in round robin way,

Yes, but we won't emulate round robin with PI and I think it is wrong t=
o
have backends with significantly different guest-visible behaviors.

>                                                                      =
 the new
> hardware even doesn't consider the TPR for lowest priority interrupts=
 delivery.

A bold move ... what hardware was the first to do so?

> As discussed with Paolo before, I will submit a patch to support lowe=
st priority for PI
> after this series is merged.

Sure, I see only two good solutions though
 1) don't optimize lowest priority with PI
 2) don't balance lowest priority
