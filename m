From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 01/13] dt-binding: mediatek: Get rid of mediatek,larb for
 multimedia HW
Date: Mon, 25 Feb 2019 15:54:08 -0800
Message-ID: <CAE=gft41kvHVY=QJCK7y7AUwPd=HQGHUKoDUAAk42bvBZMExvQ@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2018 at 8:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> After adding device_link between the consumer with the smi-larbs,
> if the consumer call its owner pm_runtime_get(_sync), the
> pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. Thus, the consumer don't need the property.
>
> And IOMMU also know which larb this consumer connects with from
> iommu id in the "iommus=" property.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
