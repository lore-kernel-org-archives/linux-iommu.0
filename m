From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Assign default IOMMU when there is only one
 IOMMU
Date: Mon, 14 Dec 2015 16:08:05 +0100
Message-ID: <20151214150805.GE11292@8bytes.org>
References: <1449874478-31770-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449874478-31770-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 11, 2015 at 04:54:38PM -0600, Suravee Suthikulpanit wrote:
> Current driver makes assumption that device with devid zero is always
> included in the range of devices to be managed by IOMMU. However,
> certain FW does not include devid zero in IVRS table.
> This has caused IOMMU perf driver to fail to initialize.

Hmm, this is a firmware bug. Is this bug seen in any systems that are
for sale?

> This patch implements a workaround for this case by always assign
> devid zero to be handled by the first IOMMU.

Otherwise its better to fix the firmware than to add workarounds.


	Joerg
