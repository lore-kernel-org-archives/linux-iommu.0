From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Date: Mon, 25 Feb 2019 19:12:16 +0800
Message-ID: <20190225111216.GA9276@dhcp-128-65.nay.redhat.com>
References: <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de>
 <20190222130026.GA30766@zn.tnic>
 <20190225110043.GA5884@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225110043.GA5884@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Borislav Petkov <bp@alien8.de>, bhe@redhat.com, Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: iommu@lists.linux-foundation.org

On 02/25/19 at 12:00pm, Joerg Roedel wrote:
> On Fri, Feb 22, 2019 at 02:00:26PM +0100, Borislav Petkov wrote:
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
> 
> Right, makes sense. While at it, maybe it is time to move the default
> allocation policy to 'high' again. The change was reverted six years ago
> because it broke old kexec tools, but those are probably out-of-service
> now. I think this change would make the whole crashdump allocation
> process less fragile.

One concern about this is for average cases, one do not need so much
memory for kdump.  For example in RHEL we use crashkernel=auto to
automatically reserve kdump kernel memory, and for x86 the reserved size
is like below now:
1G-64G:160M,64G-1T:256M,1T-:512M

That means for a machine with less than 64G memory we only allocate
160M, it works for most machines in our lab.

If we move to high as default, it will allocate 160M high + 256M low. It
is too much for people who is good with the default 160M.  Especially
for virtual machine with less memory (but > 4G)

To make the process less fragile maybe we can remove the 896M limitation
and only try <4G then go to high.

Thanks
Dave
