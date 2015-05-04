From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Fix bug in put_pasid_state_wait
Date: Mon, 4 May 2015 13:21:53 +0200
Message-ID: <20150504112153.GG15736@8bytes.org>
References: <1429193324-20398-1-git-send-email-oded.gabbay@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429193324-20398-1-git-send-email-oded.gabbay@amd.com>
Sender: stable-owner@vger.kernel.org
To: Oded Gabbay <oded.gabbay@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 16, 2015 at 05:08:44PM +0300, Oded Gabbay wrote:
> This patch fixes a bug in put_pasid_state_wait that appeared in kernel 4.0
> The bug is that pasid_state->count wasn't decremented before entering the
> wait_event. Thus, the condition in wait_event will never be true.
> 
> The fix is to decrement (atomically) the pasid_state->count before the
> wait_event.

Gah! This issue was already pointed out in the original review of the
patch, looks like I applied the wrong version. Thanks for the fix, I
applied it to iommu/fixes.


	Joerg
