From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 19/20] iommu/mediatek: Add shutdown callback
Date: Thu, 31 Jan 2019 11:21:05 +0800
Message-ID: <1548904865.19710.37.camel@mhfsdcap03>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-20-git-send-email-yong.wu@mediatek.com>
         <CAE=gft4g4HbDG7shtiqUP5vw9tiyRr4VEheMGM2uhEL_65yYmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft4g4HbDG7shtiqUP5vw9tiyRr4VEheMGM2uhEL_65yYmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2019-01-30 at 11:12 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:00 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > In the reboot burning test, if some Multimedia HW has something wrong,
> > It may keep send the invalid request to IOMMU. In order to avoid
> > affect the reboot flow, we add the shutdown callback to disable
> > M4U HW when shutdown.
> 
> Sounds unpleasant. Hopefully the reboot flow still continues properly
> even in that case, since this shutdown code may not run during some
> rougher resets.

Thanks this hint. I will reword the comment avoid writing reboot.

> 
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks.
