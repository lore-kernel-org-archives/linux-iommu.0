From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 05/19] iommu: shmobile: Enable the driver on all ARM
 platforms
Date: Fri, 1 Nov 2013 14:43:15 +0100
Message-ID: <20131101134313.GE3348@8bytes.org>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383086274-11049-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1383086274-11049-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Oct 29, 2013 at 11:37:40PM +0100, Laurent Pinchart wrote:
> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
> COMPILE_TEST.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied, thanks.


