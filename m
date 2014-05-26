From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/5] AMD IOMMUv2 Cleanups and Fixes
Date: Mon, 26 May 2014 11:28:45 +0200
Message-ID: <20140526092843.GB11299@8bytes.org>
References: <1400620706-21031-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400620706-21031-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Jay.Cornwall@amd.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 20, 2014 at 11:18:21PM +0200, Joerg Roedel wrote:
> Joerg Roedel (5):
>       iommu/amd: Don't access IOMMUv2 state_table directly
>       iommu/amd: Convert IOMMUv2 state_table into state_list
>       iommu/amd: Implement mmu_notifier_release call-back
>       iommu/amd: Remove IOMMUv2 pasid_state_list
>       iommu/amd: Handle parallel invalidate_range_start/end calls correctly

Applied.
