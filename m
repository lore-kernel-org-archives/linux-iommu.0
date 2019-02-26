From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Check identity map for hot-added devices
Date: Tue, 26 Feb 2019 11:56:07 +0100
Message-ID: <20190226105607.GI20740@8bytes.org>
References: <20190225024636.32418-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225024636.32418-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: dwmw2@infradead.org, ashok.raj@intel.com, jacob.jun.pan@linux.intel.com, jisben@google.com, xmdong@google.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 25, 2019 at 10:46:36AM +0800, Lu Baolu wrote:
>  drivers/iommu/intel-iommu.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Added a Fixes: tag and applied the patch, thanks.
