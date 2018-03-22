From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH] iommu/mediatek: Fix protect memory setting
Date: Thu, 22 Mar 2018 09:13:04 +0800
Message-ID: <1521681184.583.2.camel@mhfsdcap03>
References: <1521337974-22112-1-git-send-email-yong.wu@mediatek.com>
         <20180320185716.ldxs2vvfcchznpnb@8bytes.org>
         <1521609504.24119.5.camel@mhfsdcap03>
         <20180321111455.djllpdsj35vu5cxc@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180321111455.djllpdsj35vu5cxc@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, honghui.zhang@mediatek.com, youlin.pei@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Wed, 2018-03-21 at 06:14 -0500, Joerg Roedel wrote:
> On Wed, Mar 21, 2018 at 01:18:24PM +0800, Yong Wu wrote:
> > On Tue, 2018-03-20 at 13:57 -0500, Joerg Roedel wrote:
> > > On Sun, Mar 18, 2018 at 09:52:54AM +0800, Yong Wu wrote:
> > > > To avoid adding this complex macro or a new function, I put
> > > > it in the code and backup its value in the suspend registers.
> > > 
> > > Missing Signed-off-by.
> > 
> > Signed-off-by and Reported-by have been added above.
> > 
> > ====
> > Reported-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ====
> 
> Right, sorry. I was in a hurry and missed it. Patch is now applied.

Thanks Joerg.

> 
> 
> Thanks,
> 
> 	Joerg
