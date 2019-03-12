From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 02/13] driver core: Remove the link if there is no driver
 with AUTO flag
Date: Tue, 12 Mar 2019 16:17:27 -0700
Message-ID: <CAE=gft47TODOqKUxCvd+kDKfGbkQC1OVBarb1MaU3KrptcXiNw@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-3-git-send-email-yong.wu@mediatek.com> <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
 <1551278000.17917.50.camel@mhfsdcap03> <CAE=gft4iHRo8VQot26dH2NaRNLtxxRYWBmSpjkoL2BE_i6eXQw@mail.gmail.com>
 <e15e94be-3eb9-dc7b-2073-4163f91f0259@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e15e94be-3eb9-dc7b-2073-4163f91f0259@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 12, 2019 at 7:21 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 05/03/2019 20:03, Evan Green wrote:
> > On Wed, Feb 27, 2019 at 6:33 AM Yong Wu <yong.wu@mediatek.com> wrote:
> >>
> >> On Mon, 2019-02-25 at 15:53 -0800, Evan Green wrote:
> >>> On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >>>>
> >>>> DL_FLAG_AUTOREMOVE_CONSUMER/SUPPLIER means "Remove the link
> >>>> automatically on consumer/supplier driver unbind", that means we should
> >>>> remove whole the device_link when there is no this driver no matter what
> >>>> the ref_count of the link is.
> >>>>
> >>>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >>>> ---
> >>>> The ref_count of our device_link normally is over 1. When the consumer
> >>>> device driver is removed, whole the device_link should be removed.
> >>>> Thus, I add this patch.
> >>>> ---
> >>>
> >>> I will admit to reading about device links for the first time while
> >>> reviewing this patch, but I don't really get this. Why use a kref at
> >>> all if we're just going to ignore its value? For instance, I see that
> >>> if you call device_link_add() with the same supplier and consumer, it
> >>> uses the kref to return the same link. That machinery is broken with
> >>> your change. Although I don't see any uses of it, you might also
> >>> expect a supplier or consumer could do a kref_get() on the link it got
> >>> back from device_link_add(), and have a reasonable expectation that
> >>> the link wouldn't be freed out from under it. This would also be
> >>> broken.
> >>>
> >>> Can you explain why your device_links normally have a reference count
> >>>> 1,
> >>
> >> I use device link between the smi-larb device and the iommu-consumer
> >> device. Take a example, smi-larb1 have 4 VDEC ports. From 4/13 in this
> >> patchset, we use device_link to link the VDEC device and the smi-larb1
> >> device in the function(mtk_iommu_config). since there are 4 ports, it
> >> will call device_link_add 4 times.
> >>
> >>>
> >>> and why those additional references can't be cleaned up in an
> >>> orderly fashion?
> >>
> >> If the iommu-consume device(like VDEC above) is removed, It should enter
> >> device_links_driver_cleanup which only ref_put one time. I guess whole
> >> the link should be removed at that time.
> >
> > It seems like Robin had some suggestions about using
> > mtk_iommu_add_device() rather than the attach_dev() to set the links
> > up, and then track them for removal in the corresponding
> > remove_device() callback. Then you wouldn't need this change, right?
> >
>
> FYI, Evan the patch is queued for v5.1-rc1 as
> 0fe6f7874d46 ("driver core: Remove the link if there is no driver with AUTO flag")
>
> So if you think there is something wrong with it, then please provide a fix or
> raise awareness :)

Oh. Thanks for the heads-up Matthias. It's pretty weird that we have
the kref there whose count we just completely ignore. I'll try to find
some time to submit a patch.
-Evan
