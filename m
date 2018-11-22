From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/tegra: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Thu, 22 Nov 2018 17:10:05 +0100
Message-ID: <20181122161005.aky663jcznm5nwg4@8bytes.org>
References: <20181122133047.24902-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122133047.24902-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 22, 2018 at 08:30:47AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)

Applied, thanks.
