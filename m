From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 01/13] dt-binding: mediatek: Get rid of mediatek,larb for
 multimedia HW
Date: Fri, 11 Jan 2019 08:58:21 -0600
Message-ID: <20190111145821.GA32150@bogus>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, yingjoe.chen@mediatek.com, yong.wu@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 1 Jan 2019 12:51:04 +0800, Yong Wu wrote:
> After adding device_link between the consumer with the smi-larbs,
> if the consumer call its owner pm_runtime_get(_sync), the
> pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. Thus, the consumer don't need the property.
> 
> And IOMMU also know which larb this consumer connects with from
> iommu id in the "iommus=" property.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> I guess it should go through Matthias's tree if the patch is ok,
> thus I don't separate to different patches. If it's really needed,
> please feel free to tell me.
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt       | 9 ---------
>  .../devicetree/bindings/media/mediatek-jpeg-decoder.txt          | 4 ----
>  Documentation/devicetree/bindings/media/mediatek-mdp.txt         | 8 --------
>  Documentation/devicetree/bindings/media/mediatek-vcodec.txt      | 4 ----
>  4 files changed, 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
