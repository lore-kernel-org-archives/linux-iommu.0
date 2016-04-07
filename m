From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [patch] iommu/vt-d: silence an uninitialized variable warning
Date: Thu, 7 Apr 2016 14:52:24 +0200
Message-ID: <20160407125224.GC31146@8bytes.org>
References: <20160406183856.GB9593@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160406183856.GB9593@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 06, 2016 at 09:38:56PM +0300, Dan Carpenter wrote:
> My static checker complains that "dma_alias" is uninitialized unless we
> are dealing with a pci device.  This is true but harmless.  Anyway, we
> can flip the condition around to silence the warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.

