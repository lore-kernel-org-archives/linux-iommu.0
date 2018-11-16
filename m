From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
Date: Thu, 15 Nov 2018 22:40:49 -0800
Message-ID: <20181116064049.GA5320@bombadil.infradead.org>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org>
 <CAFqt6zbLjtDab3Bz67trbnQRQdutvgA=YvAFhoW4bxsg657mGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAFqt6zbLjtDab3Bz67trbnQRQdutvgA=YvAFhoW4bxsg657mGQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>, Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux1394-devel@lists.sourceforge.net, Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Rothwell <sfr@canb.auug.org.au>, oleksandr_andrushchenko@epam.com, joro@8bytes.org, Russell King - ARM Linux <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org, airlied@linux.ie, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, treding@nvidia.com, linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>, pawel@osciak.com, Rik van Riel <riel@surriel.com>, rppt@linux.vnet.ibm.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, mchehab@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, Juergen Gross <jgross@suse.com>, Randy Dunlap <rdunlap@infradead.>
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 16, 2018 at 11:00:30AM +0530, Souptick Joarder wrote:
> On Thu, Nov 15, 2018 at 11:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 11/15/18 7:45 AM, Souptick Joarder wrote:
> > What is the opposite of vm_insert_range() or even of vm_insert_page()?
> > or is there no need for that?
> 
> There is no opposite function of vm_insert_range() / vm_insert_page().
> My understanding is, in case of any error, mmap handlers will return the
> err to user process and user space will decide the next action. So next
> time when mmap handler is getting invoked it will map from the beginning.
> Correct me if I am wrong.

The opposite function, I suppose, is unmap_region().

> > s/no./number/
> 
> I didn't get it ??

This is a 'sed' expression.  's' is the 'substitute' command; the /
is a separator, 'no.' is what you wrote, and 'number' is what Randy
is recommending instead.

> > > +     for (i = 0; i < page_count; i++) {
> > > +             ret = vm_insert_page(vma, uaddr, pages[i]);
> > > +             if (ret < 0)
> > > +                     return ret;
> >
> > For a non-trivial value of page_count:
> > Is it a problem if vm_insert_page() succeeds for several pages
> > and then fails?
> 
> No, it will be considered as total failure and mmap handler will return
> the err to user space.

I think what Randy means is "What happens to the inserted pages?" and
the answer is that mmap_region() jumps to the 'unmap_and_free_vma'
label, which is an accurate name.

Thanks for looking, Randy.
