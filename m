From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Date: Mon, 25 Feb 2019 09:53:46 +0800
Message-ID: <20190225015346.GC1941@dhcp-128-65.nay.redhat.com>
References: <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de>
 <20190222130026.GA30766@zn.tnic>
 <CAFgQCTtYJOU=rdpzMaxXxRFAHGkOWYXFD+XiHSHMhGdRFmK+9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFgQCTtYJOU=rdpzMaxXxRFAHGkOWYXFD+XiHSHMhGdRFmK+9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>, Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: iommu@lists.linux-foundation.org

On 02/24/19 at 09:25pm, Pingfan Liu wrote:
> On Fri, Feb 22, 2019 at 9:00 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Feb 22, 2019 at 09:42:41AM +0100, Joerg Roedel wrote:
> > > The current default of 256MB was found by experiments on a bigger
> > > number of machines, to create a reasonable default that is at least
> > > likely to be sufficient of an average machine.
> >
> > Exactly, and this is what makes sense.
> >
> > The code should try the requested reservation and if it fails, it should
> > try high allocation with default swiotlb size because we need to reserve
> > *some* range.
> >
> > If that reservation succeeds, we should say something along the lines of
> >
> > "... requested range failed, reserved <X> range instead."
> >
> Maybe I misunderstood you, but does "requested range failed" mean that
> user specify the range? If yes, then it should be the duty of user as
> you said later, not the duty of kernel"

If you go with the changes in your current patch it is needed to say
something like:
"crashkernel: can not find free memory under 4G, reserve XM@.. instead" 

Also need to print the reserved low memory area in case ,high being used.

But for 896M -> 4G, the 896M faulure is not necessary to show in dmesg,
it is some in kernel logic.

Thanks
Dave
