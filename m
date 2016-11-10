From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: Fix the size calculation of pasid table
Date: Thu, 10 Nov 2016 11:45:44 +0100
Message-ID: <20161110104544.GA2078@8bytes.org>
References: <1473648551-10025-1-git-send-email-xlpang@redhat.com>
 <20160919121827.GB3541@8bytes.org>
 <1476274674.16627.173.camel@infradead.org>
 <1477829902.4154.9.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477829902.4154.9.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Xunlei Pang <xlpang@redhat.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi David,

On Sun, Oct 30, 2016 at 06:18:22AM -0600, David Woodhouse wrote:
> +	/* Start at 2 because it's defined as 1^(1+PSS) */

This probably means 2^(1+PSS), right?

> +	iommu->pasid_max = 2 << ecap_pss(iommu->ecap);

Otherwise the patch looks good. Do you want to send it upstream yourself
or should I pick it up?



	Joerg
