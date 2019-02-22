From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Date: Fri, 22 Feb 2019 10:11:01 +0800
Message-ID: <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
References: <20190131234740.GO6749@zn.tnic>
 <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190221171321.GD12997@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: bhe@redhat.com, Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On 02/21/19 at 06:13pm, Borislav Petkov wrote:
> On Wed, Feb 20, 2019 at 05:41:46PM +0800, Dave Young wrote:
> > Previously Joerg posted below patch, maybe he has some idea. Joerg?
> 
> Isn't it clear from the commit message?

Then, does it answered your question?

256M is set as a default value in the patch, but it is not a predict to
satisfy all use cases, from the description it is also possible that some
people run out of the 256M and the ,low and ,high format is still
necessary to exist even if we make crashkernel=X do the allocation
automatically in high in case failed in low area.

crashkernel=X:  allocate in low first, if not possible, then allocate in
high

In case people have a lot of devices need more swiotlb, then he manually
set the ,high with ,low together.

What's your suggestion then?  remove ,low and ,high and increase default
256M in case we get failure bug report?
