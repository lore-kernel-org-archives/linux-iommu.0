From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] iommu/rockchip: Only log stall errors when attaching
Date: Tue, 05 Apr 2016 09:48:15 -0700
Message-ID: <7194078.9M5myMDU4z@phil>
References: <1458659073-13553-1-git-send-email-tomeu.vizoso@collabora.com> <20160405145726.GD11519@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160405145726.GD11519@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Am Dienstag, 5. April 2016, 16:57:26 schrieb Joerg Roedel:
> On Tue, Mar 22, 2016 at 04:04:33PM +0100, Tomeu Vizoso wrote:
> > Move the logging of timeouts when stalling the MMU to
> > rk_iommu_attach_device, as it's expected that sometimes the MMU won't
> > get stalled when detaching a device, and it's not a real problem that
> > would need to be communicated to the user.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> Heiko, any opinion on this patch?

I don't know enough about iommus (and the rockchip implementation) to judge 
if this is correct. The reasoning sound right though and it seems to fix an 
issue for Tomeu.

One complaint would be that I'd expect the behaviour to match between the 
enable and disable functions. Meaning I'd want the error message from 
rk_iommu_disable_stall to also move rk_iommu_attach_device.


Heiko
