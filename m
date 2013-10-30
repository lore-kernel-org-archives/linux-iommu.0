From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] iommu: shmobile: Enable the driver on all ARM
	platforms
Date: Wed, 30 Oct 2013 11:26:25 +0000
Message-ID: <20131030112625.GZ16735@n2100.arm.linux.org.uk>
References: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 30, 2013 at 12:20:43PM +0100, Laurent Pinchart wrote:
> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI and increase build testing coverage.
> 
> Don't enable COMPILE_TEST support as the driver doesn't compile on
> non-ARM platforms due to usage of the ARM DMA IOMMU API.

For similar reasons as x86, can we please think about using:

	depends on ARM
	depends on ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI || COMPILE_TEST

This way we don't end up polluting the configuration for non-shmobile
platforms.  Same goes for other ARM stuff... the number of options is
getting rather large and we need to think about keeping that in check
where its easily possible to do so.
