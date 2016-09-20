From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH RESEND 4/4] iommu/amd: No need to wait iommu completion
 if no dte irq entry change
Date: Tue, 20 Sep 2016 11:56:32 +0200
Message-ID: <20160920095631.GA14627@8bytes.org>
References: <1473929453-3533-1-git-send-email-bhe@redhat.com>
 <1473929453-3533-5-git-send-email-bhe@redhat.com>
 <20160920010534.GA11495@x1.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160920010534.GA11495@x1.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dyoung@redhat.com, xlpang@redhat.com, Vincent.Wan@amd.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 20, 2016 at 09:05:34AM +0800, Baoquan He wrote:
> This is a clean up. In get_irq_table() only if DTE entry is changed
> iommu_completion_wait() need be called. Otherwise no need to do it.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  drivers/iommu/amd_iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.
