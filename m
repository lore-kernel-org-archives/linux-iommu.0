From: Rosen Penev <rosenp@gmail.com>
Subject: Re: MT76x2U crashes XHCI driver on AMD Ryzen system
Date: Sun, 3 Mar 2019 23:20:45 -0800
Message-ID: <CAKxU2N-k-9DCYBv6W3CohL963dr3AeY3VHyt8FrUuo=BfacDsw@mail.gmail.com>
References: <20190115090400.GA2267@localhost.localdomain> <20190218143742.GA11872@redhat.com>
 <20190226100535.GA20740@8bytes.org> <20190226103450.GA2989@redhat.com>
 <20190226104413.GH20740@8bytes.org> <20190226112407.GB2989@redhat.com>
 <20190228090411.GA24938@redhat.com> <20190228104223.GA2749@redhat.com>
 <20190228121948.GD6072@redhat.com> <20190228134029.GC1594@8bytes.org> <20190304071037.GA2787@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304071037.GA2787@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, linux-wireless <linux-wireless@vger.kernel.org>, Samuel Sieb <samuel@sieb.net>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Mar 3, 2019 at 11:10 PM Stanislaw Gruszka <sgruszka@redhat.com> wrote:
>
> On Thu, Feb 28, 2019 at 02:40:29PM +0100, Joerg Roedel wrote:
> > On Thu, Feb 28, 2019 at 01:19:48PM +0100, Stanislaw Gruszka wrote:
> > > Nevermind, the patch is wrong, s->dma_address is initalized in sg_num_pages().
> >
> > Yes, it is. In sg_num_pages() the offset into the IOMMU mapping is
> > stored in s->dma_address, taking also the segment boundary mask into
> > account. map_sg() later only adds the base-address to that.
>
> I have some more info about the issues in
> https://bugzilla.kernel.org/show_bug.cgi?id=202673
>
> We have some bugs in mt76. Apparently we should not use
> page_frag_alloc() with size bigger than PAGE_SIZE as page_frag_alloc()
> can fallback to single page allocation. And also we should not make
> sizes unaligned as pointed in commit:
> 3bed3cc4156e ("net: Do not allocate page fragments that are not skb aligned"
As a small and totally unrelated note, page_frag_alloc is only used in
mt76 and the nvme driver ;)
>
> However after fixing that mt76usb still did not work. To make things
> work we had to change rx frag size from 2048 to PAGE_SIZE and change
> virt_to_head_page() to virt_to_page() when setting SG's.
>
> I think I understand why first change was needed. If we do 2 separate
> dma maps of 2 different buffers in single page i.e (PAGE + off=0
> and PAGE + off=2048) it causes problem. So either map_sg() return
> error which mt76usb does not handle correctly or there is issue
> in AMD IOMMU because two dma maps use the same page.
>
> But I don't understand why the second change was needed. Without
> it we have issue with incorrect page->_refcount . It is somehow
> related with AMD IOMMU, because on different platforms we do not
> have such problems.
>
> Joerg, could you look at this ? Thanks.
>
> Stanislaw
