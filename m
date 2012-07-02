From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: Request VFIO inclusion in linux-next
Date: Mon, 02 Jul 2012 13:41:09 +1000
Message-ID: <4FF11855.2060605@ozlabs.ru>
References: <1340686552.1207.128.camel@bling.home> <20120627123733.GA5449@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120627123733.GA5449@mwanda>
Sender: linux-next-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, iommu <iommu@lists.linux-foundation.org>, qemu-devel <qemu-devel@nongnu.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>, chrisw <chrisw@sous-sol.org>, "Roedel, Joerg" <Joerg.Roedel@amd.com>, linux-next@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 27/06/12 22:37, Dan Carpenter wrote:
> On Mon, Jun 25, 2012 at 10:55:52PM -0600, Alex Williamson wrote:
>> Hi,
>>
>> VFIO has been kicking around for well over a year now and has been
>> posted numerous times for review.  The pre-requirements are finally
>> available in linux-next (or will be in the 20120626 build) so I'd like
>> to request a new branch be included in linux-next with a goal of being
>> accepted into v3.6.
>>
> 
> Could you run Sparse over the driver?
> http://lwn.net/Articles/205624/
> 
> It reports a bunch of endian problems.  Some are definitely bugs
> like:
> 	*prev |= cpu_to_le32((u32)epos << 20);


What is wrong here?



-- 
Alexey
