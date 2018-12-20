From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Date: Thu, 20 Dec 2018 10:13:09 +0100
Message-ID: <20181220091309.GZ16835@8bytes.org>
References: <20181211150513.15161-1-joro@8bytes.org>
 <CGME20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6@epcas5p4.samsung.com>
 <20181211150513.15161-4-joro@8bytes.org>
 <30d86186-e0a2-2be1-2295-20510fbd74ba@samsung.com>
 <20181219143451.GY16835@8bytes.org>
 <442867b9-2d36-4b14-56ee-b4bb8e6be4c0@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <442867b9-2d36-4b14-56ee-b4bb8e6be4c0@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jroedel@suse.de, Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On Wed, Dec 19, 2018 at 03:53:51PM +0100, Marek Szyprowski wrote:
> Yes, it fixes this issue.

Thanks a lot, patch is sent out and in iommu tree.

Regards,

	Joerg
