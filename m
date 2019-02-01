From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
Date: Fri, 1 Feb 2019 18:08:04 +0530
Message-ID: <CAFqt6zbMHG3htSsOwV3SaEEp1rMbFCoDD_3EacDk1hw_a1HJeQ@mail.gmail.com>
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <1701923.z6LKAITQJA@phil> <CAFqt6zbxyMB3VCzbWo1rPdfKXLVTNx+RY0=guD5CRxD37gJzsA@mail.gmail.com>
 <1572595.mVW1PIlZyR@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572595.mVW1PIlZyR@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: hjc@rock-chips.com, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, vbabka@suse.cz, Rik van Riel <riel@surriel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com, airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org, pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>, mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arm-kernel@lists.infradead.org, linux1394-devel@lists.sourceforge
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 6:04 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 31. Januar 2019, 13:31:52 CET schrieb Souptick Joarder:
> > On Thu, Jan 31, 2019 at 5:37 PM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > Am Donnerstag, 31. Januar 2019, 04:08:12 CET schrieb Souptick Joarder:
> > > > Previouly drivers have their own way of mapping range of
> > > > kernel pages/memory into user vma and this was done by
> > > > invoking vm_insert_page() within a loop.
> > > >
> > > > As this pattern is common across different drivers, it can
> > > > be generalized by creating new functions and use it across
> > > > the drivers.
> > > >
> > > > vm_insert_range() is the API which could be used to mapped
> > > > kernel memory/pages in drivers which has considered vm_pgoff
> > > >
> > > > vm_insert_range_buggy() is the API which could be used to map
> > > > range of kernel memory/pages in drivers which has not considered
> > > > vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
> > > >
> > > > We _could_ then at a later "fix" these drivers which are using
> > > > vm_insert_range_buggy() to behave according to the normal vm_pgoff
> > > > offsetting simply by removing the _buggy suffix on the function
> > > > name and if that causes regressions, it gives us an easy way to revert.
> > > >
> > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > Suggested-by: Russell King <linux@armlinux.org.uk>
> > > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > >
> > > hmm, I'm missing a changelog here between v1 and v2.
> > > Nevertheless I managed to test v1 on Rockchip hardware
> > > and display is still working, including talking to Lima via prime.
> > >
> > > So if there aren't any big changes for v2, on Rockchip
> > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> >
> > Change log is available in [0/9].
> > Patch [1/9] & [4/9] have no changes between v1 -> v2.
>
> I never seem to get your cover-letters, so didn't see that, sorry.

I added you in sender list for all cover-letters but it didn't reach
your inbox :-)
Thanks for reviewing and validating the patch.

>
> But great that there weren't changes then :-)
>
> Heiko
>
>
