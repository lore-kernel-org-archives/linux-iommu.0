From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V2] iommu: Use %pa and %zx instead of casting
Date: Sun, 23 Jun 2013 21:38:48 +0200
Message-ID: <CAMuHMdWHGmVpaqzMr9WZ++S9KcU=XL1c2Jdb7vDFxPD7=jbidg@mail.gmail.com>
References: <20130621153331.2881.35589.stgit@bling.home>
	<20130623114930.GA2557@8bytes.org>
	<1372009427.3137.54.camel@joe-AO722>
	<CAMuHMdWb4WK9ZuJ-vwdywgDSSbZTnnS1emF02VzrUgrSt5VKsg@mail.gmail.com>
	<1372015744.3137.74.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372015744.3137.74.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Jun 23, 2013 at 9:29 PM, Joe Perches <joe@perches.com> wrote:
>> While we're at it, paddr is phys_addr_t (which can be 32-bit or 64-bit),
>> so it should be cast to unsigned long long (instead of unsigned long),
>> and printed using %llx (instead of %lx).
>
> Sounds good to me, except using %pa instead is better still.

Thanks, you're right. Still not used to this newish %pa...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
