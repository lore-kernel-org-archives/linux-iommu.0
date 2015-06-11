From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [patch -next] iommu: checking for NULL instead of IS_ERR
Date: Thu, 11 Jun 2015 09:43:53 +0200
Message-ID: <20150611074353.GH20384@8bytes.org>
References: <20150610105926.GA21772@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150610105926.GA21772@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 10, 2015 at 01:59:27PM +0300, Dan Carpenter wrote:
> The iommu_group_alloc() and iommu_group_get_for_dev() functions return
> error pointers, they never return NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.
