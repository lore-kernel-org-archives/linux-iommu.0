From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
 VT-d PI
Date: Fri, 09 Jan 2015 15:56:00 +0100
Message-ID: <54AFEC00.80507@redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com> <1418397300-10870-14-git-send-email-feng.wu@intel.com> <20150109145435.GA22469@potion.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20150109145435.GA22469@potion.brq.redhat.com>
Sender: kvm-owner@vger.kernel.org
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Feng Wu <feng.wu@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, gleb@kernel.org, dwmw2@infradead.org, joro@8bytes.org, alex.williamson@redhat.com, jiang.liu@linux.intel.com, eric.auger@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 09/01/2015 15:54, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> There are two points relevant to this patch in new KVM's implementati=
on,
> ("KVM: x86: amend APIC lowest priority arbitration",
>  https://lkml.org/lkml/2015/1/9/362)
>=20
> 1) lowest priority depends on TPR
> 2) there is no need for balancing
>=20
> (1) has to be considered with PI as well.

The chipset doesn't support it. :(

> I kept (2) to avoid whining from people building on that behaviour, b=
ut
> lowest priority backed by PI could be transparent without it.
>=20
> Patch below removes the balancing, but I am not sure this is a price =
we
> allowed ourselves to pay ... what are your opinions?

I wouldn't mind, but it requires a lot of benchmarking.

Paolo
