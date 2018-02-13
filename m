From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4] iommu/mediatek: Move attach_device after iommu-group
 is ready for M4Uv1
Date: Tue, 13 Feb 2018 14:41:28 +0100
Message-ID: <20180213134128.nki33e2yljv7scis@8bytes.org>
References: <1516950688-28405-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516950688-28405-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, honghui.zhang@mediatek.com, Bibby Hsieh <bibby.hsieh@mediatek.com>, youlin.pei@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 26, 2018 at 03:11:28PM +0800, Yong Wu wrote:
> ---
>  drivers/iommu/mtk_iommu_v1.c | 54 +++++++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 33 deletions(-)

Applied, thanks.
