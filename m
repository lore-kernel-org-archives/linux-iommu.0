From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/dmar: Use struct_size() helper
Date: Fri, 26 Apr 2019 16:44:57 +0200
Message-ID: <20190426144457.GH24576@8bytes.org>
References: <20190418184624.GA17025@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190418184624.GA17025@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 18, 2019 at 01:46:24PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace code of the following form:
> 
> size = sizeof(*info) + level * sizeof(info->path[0]);
> 
> with:
> 
> size = struct_size(info, path, level);
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thanks.
