From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Date: Wed, 20 Feb 2019 17:41:46 +0800
Message-ID: <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
References: <20190131105732.GC6749@zn.tnic>
 <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic>
 <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220083241.GA3447@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: bhe@redhat.com, Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On 02/20/19 at 09:32am, Borislav Petkov wrote:
> On Mon, Feb 18, 2019 at 09:48:20AM +0800, Dave Young wrote:
> > It is ideal if kernel can do it automatically, but I'm not sure if
> > kernel can predict the swiotlb reserved size automatically.
> 
> Do you see how even more absurd this gets?
> 
> If the kernel cannot know the swiotlb reserved size automatically, how
> is the normal user even supposed to know?!
> 
> I see swiotlb_size_or_default() so we have a sane default which we fall
> back to. Now where's the problem with that?

Good question, I expect some answer from people who know more about the
background.  It would be good to have some actual test results, Pingfan
is trying to do some tests.

Previously Joerg posted below patch, maybe he has some idea. Joerg?

commit 94fb9334182284e8e7e4bcb9125c25dc33af19d4
Author: Joerg Roedel <jroedel@suse.de>
Date:   Wed Jun 10 17:49:42 2015 +0200

    x86/crash: Allocate enough low memory when crashkernel=high

Thanks
Dave
