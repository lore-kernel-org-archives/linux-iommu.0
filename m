From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 00/20] iommu/amd: Use generic IOVA allocator
Date: Tue, 12 Jul 2016 12:55:33 +0200
Message-ID: <20160712105533.GE12639@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
 <5784B24C.60305@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5784B24C.60305@iommu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vw@iommu.org>
Cc: iommu@lists.linux-foundation.org, Vincent.Wan@amd.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Vincent,

On Tue, Jul 12, 2016 at 05:03:08PM +0800, Wan Zongshun wrote:
> Currently, those patches can not work at my eCarrizo board.
> When I merged your patches, boot failed, and no any info print to me.
> I set iommu=pt, it also does not work; set iommu=soft, boot ok.
> 
> When I removed those patches, kernel boot ok.
> 
> This eCarrizo board uart doesnot work, so I can not get useful
> information from kernel by uart console, I also set 'text' in boot
> option, but still cannot print any log.

Thanks for your testing. The issue turned out to be an older bug, which
just got uncovered by these patches. I updated the branch at

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git amd-iommu-iova

This branch boots now on my Kaveri and Carrizo system. Can you please
give it a test too?

Thanks,

	Joerg
