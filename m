From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 12/20] memory: mtk-smi: Add gals support
Date: Mon, 14 Jan 2019 14:57:28 +0800
Message-ID: <1547449048.24830.15.camel@mhfsdcap03>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-13-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546314952-15990-13-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

Hi Matthias,

   Gentle ping about this and the other mtk-smi part in this patchset.

   The memory part don't have its specific maintainer, normally we need
SoC maintain's help. Thus, For this file(memory/mtk-smi.c), your review
is needed before Joerg accept it.

    Appreciate in advance.

On Tue, 2019-01-01 at 11:55 +0800, Yong Wu wrote:
> In some SoCs like mt8183, SMI add GALS(Global Async Local Sync) module
> which can help synchronize for the modules in different clock frequency.
> It can be seen as a "asynchronous fifo". This is a example diagram:
> 
>             M4U
>              |
>          ----------
>          |        |
>      gals0-rx   gals1-rx
>          |        |
>          |        |
>      gals0-tx   gals1-tx
>          |        |
>         ------------
>          SMI Common
>         ------------
>              |
>   +-----+--------+-----+- ...
>   |     |        |     |
>   |  gals-rx  gals-rx  |
>   |     |        |     |
>   |     |        |     |
>   |  gals-tx  gals-tx  |
>   |     |        |     |
> larb1 larb2   larb3  larb4
> 
> GALS only help transfer the command/data while it doesn't have the
> configuring register, thus it has the special "smi" clock and doesn't
> have the "apb" clock. From the diagram above, we add "gals0" and
> "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
> 
> This patch adds gals clock supporting in the SMI. Note that some larbs
> may still don't have the "gals" clock like larb1 and larb4 above.
> 
> This is also a preparing patch for mt8183 which has GALS.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
[...]
  
