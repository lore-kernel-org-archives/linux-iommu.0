From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
 VT-d PI
Date: Fri, 9 Jan 2015 16:47:48 +0100
Message-ID: <20150109154748.GD9877@potion.brq.redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <1418397300-10870-14-git-send-email-feng.wu@intel.com>
 <20150109145435.GA22469@potion.brq.redhat.com>
 <54AFEC00.80507@redhat.com>
 <20150109151258.GC9877@potion.brq.redhat.com>
 <54AFF128.1080603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54AFF128.1080603@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Feng Wu <feng.wu@intel.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, gleb@kernel.org, dwmw2@infradead.org, joro@8bytes.org, alex.williamson@redhat.com, jiang.liu@linux.intel.com, eric.auger@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

2015-01-09 16:18+0100, Paolo Bonzini:
> On 09/01/2015 16:12, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> > > The chipset doesn't support it. :(
> >=20
> > I meant that we need to recompute PI entries for lowest priority
> > interrupts every time guest's TPR changes.
> >=20
> > Luckily, Linux doesn't use TPR, but other OS might be a reason to d=
rop
> > lowest priority from PI optimizations.  (Or make it more complicate=
d.)
>=20
> Doing vector hashing is a possibility as well.  I would like to know
> what existing chipsets do in practice, then we can mimic it.

When looking at /proc/interrupts from time to time, I have only seen
interrupts landing on the first CPU of the set.

We could also distinguish between AMD and Intel ...
AMD should deliver to the highest APIC ID.
(If we still need to decide after focus processor and APR checks.)

I'll try to check using a more trustworthy approach.
