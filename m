From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/mediatek: fix leaked of_node references
Date: Fri, 26 Apr 2019 15:25:09 +0200
Message-ID: <20190426132509.GB24576@8bytes.org>
References: <1555468879-34684-1-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555468879-34684-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn, Matthias Brugger <matthias.bgg@gmail.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 17, 2019 at 10:41:19AM +0800, Wen Yang wrote:
>  drivers/iommu/mtk_iommu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.
