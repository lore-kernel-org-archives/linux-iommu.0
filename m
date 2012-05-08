From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] irq_remap: fix the UP build failure
Date: Tue, 8 May 2012 11:09:45 +0200
Message-ID: <20120508090945.GC27323@gmail.com>
References: <20120508035153.GA30652@gmail.com>
 <1336460934-23592-2-git-send-email-suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1336460934-23592-2-git-send-email-suresh.b.siddha@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Joerg Roedel <joerg.roedel@amd.com>
List-Id: iommu@lists.linux-foundation.org


* Suresh Siddha <suresh.b.siddha@intel.com> wrote:

> Fix the below UP build failure with CONFIG_IRQ_REMAP enabled.
>=20
>  drivers/iommu/intel_irq_remapping.c:955:19: error: =E2=80=98struct i=
rq_data=E2=80=99 has no member named =E2=80=98affinity=E2=80=99

hm:

> +++ b/drivers/iommu/intel_irq_remapping.c
> +#ifdef CONFIG_SMP
> +#endif
> +#ifdef CONFIG_SMP
> +#endif
> +#ifdef CONFIG_SMP
> +#endif
> +#ifdef CONFIG_SMP
> +#endif

Adding this many #ifdefs is a bit sad. Could we not make the UP=20
side have the (supposedly zero length!) affinity cpumask=20
instead, or so, and make sure that the SMP functions compile to=20
something sensible on UP?

Thanks,

	Ingo
