From: Ingo Molnar <mingo@kernel.org>
Subject: [v3.0 backport patch] amd_iommu: IO_PAGE_FAULTs on unity mapped
 regions during amd_iommu_init()
Date: Thu, 7 Feb 2013 12:12:52 +0100
Message-ID: <20130207111252.GF8945@gmail.com>
References: <1360205603.2615.19.camel@lorien2>
 <20130207104905.GC8945@gmail.com>
 <20130207110702.GU25591@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130207110702.GU25591@8bytes.org>
Sender: stable-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Shuah Khan <shuah.khan@hp.com>, tglx@linutronix.de, hpa@zytor.com, mingo@redhat.com, stable <stable@vger.kernel.org>, iommu@lists.linux-foundation.org, Greg KH <gregkh@linuxfoundation.org>, x86@kernel.org, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org


* Joerg Roedel <joro@8bytes.org> wrote:

> On Thu, Feb 07, 2013 at 11:49:05AM +0100, Ingo Molnar wrote:
> > 
> > * Shuah Khan <shuah.khan@hp.com> wrote:
> > >  arch/x86/kernel/amd_iommu_init.c |   10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > That file does not exist anymore, it died 2.5+ years ago:
> > 
> >   403f81d8ee53 iommu/amd: Move missing parts to drivers/iommu
> 
> Right, the file was moved for Linux v3.1 AFAIR. But this patch is a
> stable-packport for v3.0 of a patch I sent yersterday :)

I changed the title accordingly.

Thanks,

	Ingo
