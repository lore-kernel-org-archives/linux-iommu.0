From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Date: Fri, 27 Jul 2018 10:25:13 +0200
Message-ID: <20180727082512.lpvmeuvxnw3mpeym@8bytes.org>
References: <20180726231624.21084-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180726231624.21084-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <cyndis@kapsi.fi>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Nicolas Chauvet <kwizart@gmail.com>, devicetree@vger.kernel.org, nouveau@lists.freedesktop.org, iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 27, 2018 at 02:16:18AM +0300, Dmitry Osipenko wrote:
> The proposed solution adds a new option to the base device driver
> structure that allows device drivers to explicitly convey to the drivers
> core that the implicit IOMMU backing for devices must not happen.

Why is IOMMU mapping a problem for the Tegra GPU driver?

If we add something like this then it should not be the choice of the
device driver, but of the user and/or the firmware.


	Joerg
