From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V4] IOMMU, AMD Family15h Model10-1Fh erratum 746
 Workaround
Date: Thu, 24 Jan 2013 21:00:34 +0100
Message-ID: <20130124200034.GM13463@pd.tnic>
References: <1359055073-29732-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359055073-29732-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: suravee.suthikulpanit@amd.com
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 24, 2013 at 01:17:53PM -0600, suravee.suthikulpanit@amd.com wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> The IOMMU may stop processing page translations due to a perceived lack
> of credits for writing upstream peripheral page service request (PPR)
> or event logs. If the L2B miscellaneous clock gating feature is enabled
> the IOMMU does not properly register credits after the log request has
> completed, leading to a potential system hang.
> 
> BIOSes are supposed to disable L2B micellaneous clock gating by setting
> L2_L2B_CK_GATE_CONTROL[CKGateL2BMiscDisable](D0F2xF4_x90[2]) = 1b. This
> patch corrects that for those which do not enable this workaround.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Acked-by: Borislav Petkov <bp@suse.de>

Thanks for the good work.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
