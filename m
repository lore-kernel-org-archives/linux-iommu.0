From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH] iommu: create direct_mapping after device attached
Date: Wed, 20 Jul 2016 16:01:27 +0200
Message-ID: <20160720140127.GA3030@8bytes.org>
References: <1469018961-16367-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469018961-16367-1-git-send-email-honghui.zhang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: honghui.zhang@mediatek.com
Cc: treding@nvidia.com, mark.rutland@arm.com, matthias.bgg@gmail.com, robh@kernel.org, robin.murphy@arm.com, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pebolle@tiscali.nl, kendrick.hsu@mediatek.com, arnd@arndb.de, srv_heupstream@mediatek.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, tfiga@google.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, djkurtz@google.com, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, youlin.pei@mediatek.com, erin.lo@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 20, 2016 at 08:49:21PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> For mtk iommu, the domain_finalize was called in device attatch, the mtk
> iommu iopgt ops was allocated and initialized in domain_finalize, the
> iommu_group_create_direct_mappings would call the map interface to
> implement the map. If it's earlier than device attach, there would be NULL
> dereference. Move the iommu_group_create_direct_mappings call after device
> attached.

No, this would open a race window where the device is attached, but
doesn't have its unity-mappings in place. You should re-organize the mtk
driver instead, so that it works in this order too.



	Joerg
