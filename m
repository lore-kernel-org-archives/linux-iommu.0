From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/4] iommu/amd: Clean up patches
Date: Mon, 19 Sep 2016 16:20:58 +0200
Message-ID: <20160919142058.GA7566@8bytes.org>
References: <1473929453-3533-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473929453-3533-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dyoung@redhat.com, xlpang@redhat.com, Vincent.Wan@amd.com
List-Id: iommu@lists.linux-foundation.org

Hi Baoquan,

On Thu, Sep 15, 2016 at 04:50:49PM +0800, Baoquan He wrote:
> These were found out when I tried to fix the kdump failure on system
> with AMD iommu. Pack them into this patchset since they are not related
> to the kdump issue and each other.
> 
> Baoquan He (4):
>   iommu/amd: clean up the cmpxchg64 invocation
>   iommu/amd: Use standard bitmap operation to set bitmap
>   iommu/amd: Free domain id when free a domain of struct dma_ops_domain
>   iommu/amd: No need to wait iommu completion if no dte irq entry change

I applied patches 1-3, but patch 4 had some conflicts. Can you please
rebase this patch to my x86/amd branch and resend?


Thanks,

	Joerg
