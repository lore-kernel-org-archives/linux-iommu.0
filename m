From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu/amd: Set AMD iommu callbacks for platform bus
 driver
Date: Wed, 15 Jun 2016 12:00:48 +0200
Message-ID: <20160615100047.GA26566@8bytes.org>
References: <1462886461-3149-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462886461-3149-1-git-send-email-vincent.wan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vincent.wan@amd.com>
Cc: iommu@lists.linux-foundation.org, vw@iommu.org, mcuos.com@gmail.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 10, 2016 at 09:21:01AM -0400, Wan Zongshun wrote:
> From: Wan Zongshun <Vincent.Wan@amd.com>
> 
> AMD has more drivers will use ACPI to platform bus driver later,
> all those devices need iommu support, for example: eMMC driver.
> 
> For latest AMD eMMC controller, it will utilize sdhci-acpi.c driver,
> which will rely on platform bus to match device and driver, where we
> will set 'dev' of struct platform_device as map_sg parameter passing
> to iommu driver for DMA request, so the iommu-ops are needed on the
> platform bus.
> 
> Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>

Applied, thanks.
