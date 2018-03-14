From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
 devices
Date: Wed, 14 Mar 2018 13:23:26 +0100
Message-ID: <20180314122326.GA19651@wunner.de>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com>
 <CAAFQd5A5Rj1KAZjUc5ZUKuKnbkA5Q6aLw9z0H3_kfyBQOOF-gw@mail.gmail.com>
 <2217404.A2W3Iek6du@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2217404.A2W3Iek6du@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomasz Figa <tfiga@chromium.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>, Sricharan R <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 14, 2018 at 12:12:05PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
> > On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > > On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> > >> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > >>> The lists managing the device-links can be traversed to
> > >>> find the link between two devices. The device_link_add() APIs
> > >>> does traverse these lists to check if there's already a link
> > >>> setup between the two devices.
> > >>> So, add a new APIs, device_link_find(), to find an existing
> > >>> device link between two devices - suppliers and consumers.
> > >>
> > >> I'm wondering if this API would be useful for anything else that the
> > >> problem we're trying to solve with deleting links without storing them
> > >> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
> > >> better alternative?
> > >
> > > Yea, that sounds simpler i think. Will add this API instead of
> > > find_link(). Thanks.
> > 
> > Perhaps let's wait for a moment to see if there are other opinions. :)
> > 
> > Rafael, Lucas, any thoughts?
> 
> It is not clear to me what the device_link_del_dev(consumer, supplier)
> would do.

The point appears to be that the pointer to the device_link need not be
stored somewhere for later deletion.  The newly added function would
check if a device link exists and delete it if so.

However I don't understand why storing the pointer would be a problem?
Also, would using DL_FLAG_AUTOREMOVE avoid the need for the additional
function?

Thanks,

Lukas
