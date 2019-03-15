From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RESEND][PATCH] iommu/amd: Fix NULL dereference bug in
 match_hid_uid
Date: Fri, 15 Mar 2019 16:24:47 +0100
Message-ID: <20190315152447.GA16974@8bytes.org>
References: <1552485204-11381-1-git-send-email-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552485204-11381-1-git-send-email-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 13, 2019 at 09:53:24PM +0800, Aaron Ma wrote:
> Add a non-NULL check to fix potential NULL pointer dereference
> Cleanup code to call function once.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/iommu/amd_iommu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied with cleaned-up coding style and a Fixes tag, thanks.
