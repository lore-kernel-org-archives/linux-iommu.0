From: Joerg Roedel <joro@8bytes.org>
Subject: Re: RFC: vfio API changes needed for powerpc (v3)
Date: Thu, 11 Apr 2013 14:56:59 +0200
Message-ID: <20130411125659.GL6858@8bytes.org>
References: <9F6FE96B71CF29479FF1CDC8046E15035A29FB@039-SN1MPN1-003.039d.mgd.msft.net>
 <1365200245.17535.13@snotra>
 <9F6FE96B71CF29479FF1CDC8046E15035A5CA3@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15035A5CA3@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: kvm-owner@vger.kernel.org
To: Yoder Stuart-B08248 <B08248@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "agraf@suse.de" <agraf@suse.de>, Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2013 at 01:22:15AM +0000, Yoder Stuart-B08248 wrote:
> > What happens if a normal unmap call is done on the MSI iova?  Do we
> > need a separate unmap?
> 
> I was thinking a normal unmap on an MSI windows would be an error...but
> I'm not set on that.   I put the msi unmap there to make things symmetric,
> a normal unmap would work as well...and then we could drop the msi unmap.

Hmm, this API semantic isn't very clean. When you explicitly map the MSI
banks a clean API would also allow to unmap them. But that is not
possible in your design because the kernel is responsible for mapping
MSIs and you can't unmap a MSI bank that is in use by the kernel.

So since the kernel owns the MSI setup anyways it should also take care
of mapping the MSI banks. What is the reason to not let the kernel
allocate the MSI banks top-down from the end of the DMA window space?
Just let userspace know (or even set if needed) in advance how many of
the windows it configures the kernel will take for mapping MSI banks and
you are fine, no?


	Joerg


