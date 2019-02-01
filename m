From: Tianyu Lan <lantianyu1986@gmail.com>
Subject: Re: [PATCH 1/3] x86/Hyper-V: Set x2apic destination mode to physical
 when x2apic is available
Date: Fri, 1 Feb 2019 15:10:55 +0800
Message-ID: <CAOLK0pyET5GGqMcoK7u5781mf_U1js6LtfoYxMpntwVCfGO3Zg@mail.gmail.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com> <20190201070655.GA14343@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201070655.GA14343@kadam>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, mchehab+samsung@kernel.org, sashal@kernel.org, sthemmin@microsoft.com, Joerg Roedel <joro@8bytes.org>, the arch/x86 maintainers <x86@kernel.org>, michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>, Lan Tianyu <Tianyu.Lan@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, haiyangz@microsoft.com, Alex Williamson <alex.williamson@redhat.com>, bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.ferre@microchip.com, iommu@lists.linux-foundation.org, devel@linuxdriverproject.org, akpm@linux-foundation.org, davem@davemloft.net
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 1, 2019 at 3:07 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Jan 31, 2019 at 06:17:31PM +0800, lantianyu1986@gmail.com wrote:
> >
> >
>
> This comment needs to be indented one tab or it looks like we're outside
> the funciton.
>
> > +/*
> > + * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> > + * set x2apic destination mode to physcial mode when x2apic is available
> > + * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
> > + * have 8-bit APIC id.
> > + */
> > +# if IS_ENABLED(CONFIG_HYPERV_IOMMU)
> > +     if (x2apic_supported())
> > +             x2apic_phys = 1;
> > +# endif
>
> The IS_ENABLED() macro is really magical.  You could write this like so:
>
>         if (IS_ENABLED(CONFIG_HYPERV_IOMMU) && x2apic_supported())
>                 x2apic_phys = 1;
>
> It works the same and is slightly more pleasant to look at.

Yes, that will better. Thanks for your suggestion. Dan

-- 
Best regards
Tianyu Lan
