From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
 devices
Date: Wed, 14 Mar 2018 13:27:59 +0100
Message-ID: <20180314122759.GB19651@wunner.de>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <2217404.A2W3Iek6du@aspire.rjw.lan>
 <CAAFQd5CQXY0Efv+2MC1kTVW5q4eZjJ=gwVaR-LA=3agnSSHzUw@mail.gmail.com>
 <2705105.V6KYPvoJqj@aspire.rjw.lan>
 <11eae0bc-7921-e598-9c01-63498400c85b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11eae0bc-7921-e598-9c01-63498400c85b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tfiga@chromium.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>, Sricharan R <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 14, 2018 at 12:14:15PM +0000, Robin Murphy wrote:
> >>On Wed, Mar 14, 2018 at 8:12 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>>On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
> >>>>On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>>On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> >>>>>>On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>>>>The lists managing the device-links can be traversed to
> >>>>>>>find the link between two devices. The device_link_add() APIs
> >>>>>>>does traverse these lists to check if there's already a link
> >>>>>>>setup between the two devices.
> >>>>>>>So, add a new APIs, device_link_find(), to find an existing
> >>>>>>>device link between two devices - suppliers and consumers.
> >>>>>>
> >>>>>>I'm wondering if this API would be useful for anything else that the
> >>>>>>problem we're trying to solve with deleting links without storing them
> >>>>>>anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
> >>>>>>better alternative?
> >>>>>
> >>>>>Yea, that sounds simpler i think. Will add this API instead of
> >>>>>find_link(). Thanks.
> >>>>
> >>>>Perhaps let's wait for a moment to see if there are other opinions. :)
> >>>>
> >>>>Rafael, Lucas, any thoughts?
> >>>
> >>>It is not clear to me what the device_link_del_dev(consumer, supplier)
> >>>would do.
> 
> Not quite - the issue here is that we have one supplier with an arbitrarily
> large number of consumers, and would prefer that supplier not to have to
> spend a whole bunch of memory to store all the struct device_link pointers
> for the sole reason of having something to give to device_link_del() at the
> end, given that the device links code is already keeping track of everything
> internally anyway.

Makes sense to me.  How about an additional flag which autoremoves the
link on provider unbind?

Thanks,

Lukas
