From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Date: Fri, 22 Mar 2019 16:22:16 +0800
Message-ID: <20190322082216.GA23356@dhcp-128-65.nay.redhat.com>
References: <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de>
 <20190222130026.GA30766@zn.tnic>
 <20190225110043.GA5884@suse.de>
 <20190225111216.GA9276@dhcp-128-65.nay.redhat.com>
 <20190225113003.GE26145@zn.tnic>
 <CAFgQCTvP-YDUEcHTgupr+ar+qeoj5rw1y8k+6kzrzHPzTqBkaw@mail.gmail.com>
 <CAFgQCTs9pJ=3Jt1YLv6RmBWeViH8cmuMcKG+2Aj-Vo2Kh-Wcog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFgQCTs9pJ=3Jt1YLv6RmBWeViH8cmuMcKG+2Aj-Vo2Kh-Wcog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>, Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: iommu@lists.linux-foundation.org

Hi Pingfan, 

Thanks for the effort,
On 03/01/19 at 11:19am, Pingfan Liu wrote:
> On Fri, Mar 1, 2019 at 11:04 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > Hi Borislav,
> >
> > Do you think the following patch is good at present?
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 81f9d23..9213073 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -460,7 +460,7 @@ static void __init
> > memblock_x86_reserve_range_setup_data(void)
> >  # define CRASH_ADDR_LOW_MAX    (512 << 20)
> >  # define CRASH_ADDR_HIGH_MAX   (512 << 20)
> >  #else
> > -# define CRASH_ADDR_LOW_MAX    (896UL << 20)
> > +# define CRASH_ADDR_LOW_MAX    (1 << 32)
> >  # define CRASH_ADDR_HIGH_MAX   MAXMEM
> >  #endif
> >
> Or patch lools like:
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3d872a5..ed0def5 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -459,7 +459,7 @@ static void __init
> memblock_x86_reserve_range_setup_data(void)
>  # define CRASH_ADDR_LOW_MAX    (512 << 20)
>  # define CRASH_ADDR_HIGH_MAX   (512 << 20)
>  #else
> -# define CRASH_ADDR_LOW_MAX    (896UL << 20)
> +# define CRASH_ADDR_LOW_MAX    (1 << 32)
>  # define CRASH_ADDR_HIGH_MAX   MAXMEM
>  #endif
> 
> @@ -551,6 +551,15 @@ static void __init reserve_crashkernel(void)
>                                                     high ? CRASH_ADDR_HIGH_MAX
>                                                          : CRASH_ADDR_LOW_MAX,
>                                                     crash_size, CRASH_ALIGN);
> +#ifdef CONFIG_X86_64
> +               /*
> +                * crashkernel=X reserve below 4G fails? Try MAXMEM
> +                */
> +               if (!high && !crash_base)
> +                       crash_base = memblock_find_in_range(CRASH_ALIGN,
> +                                               CRASH_ADDR_HIGH_MAX,
> +                                               crash_size, CRASH_ALIGN);
> +#endif
> 
> which tries 0-4G, the fall back to 4G above

This way looks good to me, I will do some testing with old kexec-tools,
Once testing done I can take up this again and repost later with some documentation
update.  Also will split to 2 patches  one to drop the old limitation,
another for the fallback.

Thanks
Dave
