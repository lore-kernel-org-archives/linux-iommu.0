From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Date: Mon, 25 Feb 2019 12:00:43 +0100
Message-ID: <20190225110043.GA5884@suse.de>
References: <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de>
 <20190222130026.GA30766@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222130026.GA30766@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, bhe@redhat.com, Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 22, 2019 at 02:00:26PM +0100, Borislav Petkov wrote:
> On Fri, Feb 22, 2019 at 09:42:41AM +0100, Joerg Roedel wrote:
> > The current default of 256MB was found by experiments on a bigger
> > number of machines, to create a reasonable default that is at least
> > likely to be sufficient of an average machine.
> 
> Exactly, and this is what makes sense.
> 
> The code should try the requested reservation and if it fails, it should
> try high allocation with default swiotlb size because we need to reserve
> *some* range.

Right, makes sense. While at it, maybe it is time to move the default
allocation policy to 'high' again. The change was reverted six years ago
because it broke old kexec tools, but those are probably out-of-service
now. I think this change would make the whole crashdump allocation
process less fragile.

Regards,

	Joerg
