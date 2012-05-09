From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] irq_remap: fix the UP build failure
Date: Wed, 9 May 2012 11:30:02 +0200
Message-ID: <20120509093001.GD8585@gmail.com>
References: <20120508035153.GA30652@gmail.com>
 <1336460934-23592-2-git-send-email-suresh.b.siddha@intel.com>
 <20120508090945.GC27323@gmail.com>
 <1336531035.22618.23.camel@sbsiddha-desk.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1336531035.22618.23.camel@sbsiddha-desk.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Joerg Roedel <joerg.roedel@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org


* Suresh Siddha <suresh.b.siddha@intel.com> wrote:

> On Tue, 2012-05-08 at 11:09 +0200, Ingo Molnar wrote:
> > * Suresh Siddha <suresh.b.siddha@intel.com> wrote:
> >=20
> > > Fix the below UP build failure with CONFIG_IRQ_REMAP enabled.
> > >=20
> > >  drivers/iommu/intel_irq_remapping.c:955:19: error: =E2=80=98stru=
ct irq_data=E2=80=99 has no member named =E2=80=98affinity=E2=80=99
> >=20
> > hm:
> >=20
> > > +++ b/drivers/iommu/intel_irq_remapping.c
> > > +#ifdef CONFIG_SMP
> > > +#endif
> > > +#ifdef CONFIG_SMP
> > > +#endif
> > > +#ifdef CONFIG_SMP
> > > +#endif
> > > +#ifdef CONFIG_SMP
> > > +#endif
> >=20
> > Adding this many #ifdefs is a bit sad. Could we not make the UP=20
> > side have the (supposedly zero length!) affinity cpumask=20
> > instead, or so, and make sure that the SMP functions compile to=20
> > something sensible on UP?
> >=20
>=20
> How about using config_enabled() to clean this up? Something=20
> like the appended?
>=20
> I first tried config_enabled(SMP) with out closely looking at=20
> the macro definition and didn't work. I had to use=20
> config_enabled(CONFIG_SMP) to really get this working. So in=20
> the appended patch I fixed config_enabled macro to accept=20
> config_enabled(SMP). If this all sounds ok, then I can split=20
> the appended patch into multiple patches.

Looks a lot cleaner!

Please split out the config_enabled() change into a separate=20
patch and Cc: Linus on the resend.

I like your idea of allowing config_enabled(SMP) as well,=20
there's no reason to say 'config' twice. It's too easy to get=20
this wrong and AFAICS there's no build error if we are using a=20
non-existent config flag, right?

Thanks,

	Ingo
