From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: fix trace_unmap() to report original iova
Date: Mon, 19 Jan 2015 15:21:47 +0100
Message-ID: <20150119142147.GO6343@8bytes.org>
References: <1421452039-7646-1-git-send-email-shuahkh@osg.samsung.com>
 <20150119140400.GN6343@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150119140400.GN6343@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: alex.williamson@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 19, 2015 at 03:04:00PM +0100, Joerg Roedel wrote:
> Instead of adding another variable I think it is better to just move the
> trace_unmap call before the unmap loop. It can actually replace the
> pr_debug there.

Okay, forget this. I just noticed that your follow-on patch requires
the trace_unmap call to stay there. I applied both patches to my core
branch.


	Joerg
