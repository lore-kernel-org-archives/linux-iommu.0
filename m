From: Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Wed, 15 Apr 2015 16:41:17 +0900
Message-ID: <CAAFQd5A2FgsbusEbxVVqSeC7hY=Ewe-YbJ7bbvk-SjpSC==xDw@mail.gmail.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-3-git-send-email-yong.wu@mediatek.com> <CAAFQd5ASywTX7P9L8cogBbBTra0W1=oVxeWfK5=K7L+SR2xaFA@mail.gmail.com>
 <1426677749.22581.38.camel@mhfsdcap03> <CAAFQd5DOzFmfXki8GwUC75VQFEWzxBUNUgOtSuRtV6tc27kD2A@mail.gmail.com>
 <1428993067.13552.14.camel@mhfsdcap03> <CAAFQd5Db+DacQYa1pdr=w5JpU76AYa-Xhd20wHBF=F6m=Efokw@mail.gmail.com>
 <1429081567.16400.16.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429081567.16400.16.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 15, 2015 at 4:06 PM, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> On Wed, 2015-04-15 at 11:20 +0900, Tomasz Figa wrote:
>> On Tue, Apr 14, 2015 at 3:31 PM, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrot=
e:
>> >> >>
>> >> >> > +
>> >> >> > +       piommu->protect_va =3D devm_kmalloc(piommu->dev, MTK=
_PROTECT_PA_ALIGN*2,
>> >> >>
>> >> >> style: Operators like * should have space on both sides.
>> >> >>
>> >> >> > +                                         GFP_KERNEL);
>> >> >>
>> >> >> Shouldn't dma_alloc_coherent() be used for this?
>> >> >      We don't care the data in it. I think they are the same. C=
ould you
>> >> > help tell me why dma_alloc_coherent may be better.
>> >>
>> >> Can you guarantee that at the time you allocate the memory using
>> >> devm_kmalloc() the memory is not dirty (i.e. some write back data=
 are
>> >> stored in CPU cache) and is not going to be written back in some =
time,
>> >> overwriting data put there by IOMMU hardware?
>> >>
>> > As I noted in the function "mtk_iommu_hw_init":
>> >
>> >        /* protect memory,HW will write here while translation faul=
t */
>> >        protectpa =3D __virt_to_phys(piommu->protect_va);
>> >
>> >      We don=E2=80=99t care the content of this buffer, It is ok ev=
en though its
>> > data is dirty.
>> >     It seem to be a the protect memory. While a translation fault
>> > happened, The iommu HW will overwrite here instead of writing to t=
he
>> > fault physical address which may be 0 or some random address.
>> >
>>
>> Do you mean that it's just a dummy page for hardware behind the IOMM=
U
>> to access when the mapping is not available? How would that work wit=
h
>> potential on demand paging when the hardware needs to be blocked unt=
il
>> the mapping is created?
>>
>> Best regards,
>> Tomasz
>  1. YES
>  2. Sorry. Our iommu HW can not support this right now. The HW can no=
t
> be blocked until the mapping is created.

OK, that explains it. Well, then I guess this is necessary and
contents of that memory don't matter that much. (Although, this might
be a minor security issue, because the faulting hardware would get
access to some data previously stored by kernel code. Not sure how
much of a threat would that be, though.)

>     If the page is not ready, we can not get the physical address, th=
en
> How to fill the pagetable for that memory. I think the dma&iommu may
> guaranty it?

If your hardware can't block until the mapping is created then what
you do currently seems to be the only option. (+/- the missing cache
maintenance at initialization)

Best regards,
Tomasz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
