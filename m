From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 03/12] intel-ipu3: Add DMA API implementation
Date: Wed, 19 Jul 2017 09:24:41 +0200
Message-ID: <CAK8P3a0Muca-NB0+yuotTHEixhx8jG9Dytsd_wE9=SfNdGSGBg@mail.gmail.com>
References: <1500433978-2350-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1500433978-2350-1-git-send-email-yong.zhi@intel.com>
Sender: linux-media-owner@vger.kernel.org
To: Yong Zhi <yong.zhi@intel.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, jian.xu.zheng@intel.com, rajmohan.mani@intel.com, hyungwoo.yang@intel.com, jerry.w.hu@intel.com, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Tomasz Figa <tfiga@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 19, 2017 at 5:12 AM, Yong Zhi <yong.zhi@intel.com> wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> This patch adds support for the IPU3 DMA mapping API.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Zhi <yong.zhi@intel.com>

This needs some explanation on why you decided to go down the
route of adding your own dma_map_ops. It's not obvious at all,
and and I'm still concerned that this complicates things more than
it helps.

         Arnd
