From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/4 v7] amd_iommu: remap the device table of IOMMU with
 the memory encryption mask for kdump
Date: Tue, 25 Sep 2018 14:04:42 +0200
Message-ID: <20180925120442.wmh6fjpdghxjyvio@8bytes.org>
References: <20180907081805.368-1-lijiang@redhat.com>
 <20180907081805.368-4-lijiang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180907081805.368-4-lijiang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lianbo Jiang <lijiang@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, thomas.lendacky@amd.com, dyoung@redhat.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, bhe@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 07, 2018 at 04:18:04PM +0800, Lianbo Jiang wrote:
> In kdump kernel, it will copy the device table of IOMMU from the old device
> table, which is encrypted when SME is enabled in the first kernel. So we
> have to remap the old device table with the memory encryption mask.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>

Please change the subject to:

	iommu/amd: Remap the device table of IOMMU with the memory encryption mask for kdump

With that you can add my:

Acked-by: Joerg Roedel <jroedel@suse.de>
