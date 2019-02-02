From: Tianyu Lan <lantianyu1986@gmail.com>
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Sat, 2 Feb 2019 10:51:23 +0800
Message-ID: <CAOLK0pw3zaanNbzJ67sqPQ=ETctM39+=kSh99euq0wmz-ehrUA@mail.gmail.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com> <20190201163443.GS32526@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201163443.GS32526@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, mchehab+samsung@kernel.org, davem@davemloft.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, akpm@linux-foundation.org, nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com, kys@microsoft.com, Vitaly Kuznetsov <vkuznets@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg:
             Thanks for your review.

On Sat, Feb 2, 2019 at 12:34 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi,
>
> On Thu, Jan 31, 2019 at 06:17:32PM +0800, lantianyu1986@gmail.com wrote:
> > +config HYPERV_IOMMU
> > +     bool "Hyper-V stub IOMMU support"
>
> This is not a real IOMMU driver, it only implements IRQ remapping
> capabilities. Please change the name to reflect that, e.g. to
> "Hyper-V IRQ Remapping Support" or something like that.

Yes, that makes sense. Will update.

>
> > +static int __init hyperv_prepare_irq_remapping(void)
> > +{
> > +     struct fwnode_handle *fn;
> > +     u32 apic_id;
> > +     int i;
> > +
> > +     if (x86_hyper_type !=3D X86_HYPER_MS_HYPERV ||
> > +         !x2apic_supported())
> > +             return -ENODEV;
> > +
> > +     fn =3D irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> > +     if (!fn)
> > +             return -EFAULT;
>
> Why does this return -EFAULT? I guess there is no fault happening in
> irq_domain_alloc_named_id_fwnode()...

Yes, =E2=80=9C-ENOMEM=E2=80=9D should be more accurate.

--=20
Best regards
Tianyu Lan
