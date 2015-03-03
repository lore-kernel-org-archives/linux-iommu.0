From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] CHROMIUM: iommu: rockchip: Make sure that page table
 state is coherent
Date: Tue, 3 Mar 2015 14:36:59 +0100
Message-ID: <20150303133659.GD10502@8bytes.org>
References: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 09, 2015 at 08:19:21PM +0900, Tomasz Figa wrote:
> Even though the code uses the dt_lock spin lock to serialize mapping
> operation from different threads, it does not protect from IOMMU
> accesses that might be already taking place and thus altering state
> of the IOTLB. This means that current mapping code which first zaps
> the page table and only then updates it with new mapping which is
> prone to mentioned race.

Could you elabortate a bit on the race and why it is sufficient to zap
only the first and the last iova? From the description and the comments
in the patch this is not clear to me.


	Joerg
