From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Date: Mon, 25 Feb 2019 10:39:51 +0100
Message-ID: <20190225093950.GB26145@zn.tnic>
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
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFgQCTtYJOU=rdpzMaxXxRFAHGkOWYXFD+XiHSHMhGdRFmK+9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Joerg Roedel <jroedel@suse.de>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: iommu@lists.linux-foundation.org

On Sun, Feb 24, 2019 at 09:25:18PM +0800, Pingfan Liu wrote:
> Maybe I misunderstood you, but does "requested range failed" mean that
> user specify the range? If yes, then it should be the duty of user as
> you said later, not the duty of kernel"

No, it should say that it selected a different range only when the user
didn't specify it. Which would mean that the user didn't care about the
range - she/he only wanted to have *any* crashkernel range reserved.
I.e., crashkernel=X invocation.

> We do not know the memory layout of a system, maybe a system with
> memory less than 4GB. So it is better to try all the range of system
> memory.

Ok. If 4G fails, you set high and then try again.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
