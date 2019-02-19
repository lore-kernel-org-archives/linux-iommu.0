From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6 17/22] memory: mtk-smi: Get rid of need_larbid
Date: Tue, 19 Feb 2019 15:32:04 -0800
Message-ID: <CAE=gft5uXTZJms62_M7=14E7sSNepyLt9CL1KbfD163DsxHHFA@mail.gmail.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-18-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550394300-17420-18-git-send-email-yong.wu@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>, Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> It's no need to parse it again in SMI driver. Only clean some codes.
> This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> and mt8183.
>
> After this patch, the "mediatek,larb-id" only be needed for mt2712
> which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> in which the larbs in the "mediatek,larbs" always are ordered.
>
> Correspondingly, the larb_nr in the "struct mtk_smi_iommu" could also
> be deleted.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Thanks for the cleanup.

Reviewed-by: Evan Green <evgreen@chromium.org>
