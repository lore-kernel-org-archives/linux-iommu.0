From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: Detach domain *only* from attached iommus
Date: Mon, 23 Mar 2015 15:24:15 +0100
Message-ID: <20150323142415.GB2226@8bytes.org>
References: <20150304182905.23660.81378.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150304182905.23660.81378.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org, jiang.liu@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 04, 2015 at 11:30:10AM -0700, Alex Williamson wrote:
>  drivers/iommu/intel-iommu.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to iommu/fixes, thanks Alex.
