From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
Date: Wed, 20 Mar 2019 08:20:47 +0800
Message-ID: <CANMq1KAWbfNJQt=RaK-+us7eS6ReLFqaEbO3hMPfBy_w3ukj7A@mail.gmail.com>
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
 <20190111102155.in5rctq5krs4ewfi@8bytes.org> <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
 <789fb2e6-0d80-b6de-adf3-57180a50ec3e@suse.cz> <CANMq1KCfhWdWtXP_PRd_LEEcWV8SQg=hOy4V7_grqtL873uUCg@mail.gmail.com>
 <CANMq1KBKF9aRj+8t+AQusNLOF5jrHJ4qY5C00AKXkO6e-8wKuQ@mail.gmail.com> <20190319105637.4949b00b854e955d61c0359d@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190319105637.4949b00b854e955d61c0359d@linux-foundation.org>
Sender: stable-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <Alexander.Levin@microsoft.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>h
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 20, 2019 at 1:56 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 19 Mar 2019 15:41:43 +0800 Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> > On Mon, Feb 25, 2019 at 8:23 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > On Thu, Feb 14, 2019 at 1:12 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > >
> > > > On 1/22/19 11:51 PM, Nicolas Boichat wrote:
> > > > > Hi Andrew,
> > > > >
> > > > > On Fri, Jan 11, 2019 at 6:21 PM Joerg Roedel <joro@8bytes.org> wrote:
> > > > >>
> > > > >> On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
> > > > >> > Does anyone have any further comment on this series? If not, which
> > > > >> > maintainer is going to pick this up? I assume Andrew Morton?
> > > > >>
> > > > >> Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
> > > > >> this should go through mm.
> > > > >
> > > > > Gentle ping on this series, it seems like it's better if it goes
> > > > > through your tree.
> > > > >
> > > > > Series still applies cleanly on linux-next, but I'm happy to resend if
> > > > > that helps.
> > > >
> > > > Ping, Andrew?
> > >
> > > Another gentle ping, I still don't see these patches in mmot[ms]. Thanks.
> >
> > Andrew: AFAICT this still applies cleanly on linux-next/master, so I
> > don't plan to resend... is there any other issues with this series?
> >
> > This is a regression, so it'd be nice to have it fixed in mainline, eventually.
>
> Sorry, seeing "iommu" and "arm" made these escape my gimlet eye.

Thanks for picking them up!

> I'm only seeing acks on [1/3].  What's the review status of [2/3] and [3/3]?

Replied on the notification, [2/3] had a Ack, [3/3] is somewhat controversial.
