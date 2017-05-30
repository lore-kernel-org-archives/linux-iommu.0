From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/2] ACPICA: IORT: Update SMMU models for IORT rev. C
Date: Tue, 30 May 2017 11:12:05 +0200
Message-ID: <20170530091205.GB2764@8bytes.org>
References: <11ef7d28c535c01d42b7b3c8e632934f0e0f1048.1495459319.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11ef7d28c535c01d42b7b3c8e632934f0e0f1048.1495459319.git.robin.murphy@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: will.deacon@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, gakula@caviumnetworks.com, linu.cherian@cavium.com, rrichter@cavium.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, john.garry@huawei.com, shameerali.kolothum.thodi@huawei.com, gabriele.paoloni@huawei.com, rjw@rjwysocki.net, robert.moore@intel.com, lv.zheng@intel.com
List-Id: iommu@lists.linux-foundation.org

On Mon, May 22, 2017 at 04:06:37PM +0100, Robin Murphy wrote:
> IORT revision C has been published with a number of new SMMU
> implementation identifiers. Since IORT doesn't have any way of falling
> back to a more generic model code, we really need Linux to know about
> these before vendors start updating their firmware tables to use them.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Robert Moore <robert.moore@intel.com>
> CC: Lv Zheng <lv.zheng@intel.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Update more comments, add Robert's tags.

I generally prefer 'Fixes'-tags, can you please add them too?

