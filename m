From: Tianyu Lan <lantianyu1986@gmail.com>
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Thu, 31 Jan 2019 20:08:02 +0800
Message-ID: <CAOLK0pwve6spShSBt_jBwECJWTtTtHYRz+yLi4vz18GnznMw1g@mail.gmail.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com> <20190131115944.GB19969@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131115944.GB19969@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, Joerg Roedel <joro@8bytes.org>, mchehab+samsung@kernel.org, davem@davemloft.net, akpm@linux-foundation.org, nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com, kys@microsoft.com, vkuznets@redhat.com, Alex Williamson <alex.williamson@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 7:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 31, 2019 at 06:17:32PM +0800, lantianyu1986@gmail.com wrote:
> > --- /dev/null
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define pr_fmt(fmt)     "HYPERV-IR: " fmt
>
> Minor nit, you never do any pr_*() calls, so this isn't needed, right?

Yes, you are right. I will remove it. Sorry. I used pr_info() during
development stage and removed
them before sending patch out. Thanks.

>
> > +static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
> > +struct irq_domain *ioapic_ir_domain;
>
> Global?  Why?

It should be "static" here.

-- 
Best regards
Tianyu Lan
