From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v5 04/20] memory: mtk-smi: Use a struct for the platform
 data for smi-common
Date: Wed, 30 Jan 2019 10:28:04 -0800
Message-ID: <CAE=gft5hkfwhKoxH0vZo54MqkF85-f7eKxY-DxkR29CBuBMJCw@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-5-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1546314952-15990-5-git-send-email-yong.wu@mediatek.com>
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
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Use a struct as the platform special data instead of the enumeration.
>
> Also there is a minor change that moving the position of
> "enum mtk_smi_gen" definition, this is because we expect define
> "struct mtk_smi_common_plat" before it is referred.
>
> This is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
