From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu: Correctly program S2CR and SMR
	registers
Date: Mon, 4 Aug 2014 10:48:23 +0100
Message-ID: <20140804094823.GD15117@arm.com>
References: <1407113264-23426-1-git-send-email-ohaugan@codeaurora.org>
	<1407113264-23426-3-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407113264-23426-3-git-send-email-ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 04, 2014 at 01:47:44AM +0100, Olav Haugan wrote:
> When stream matching is supported by the hardware the S2CR is indexed
> by the stream matching register group index and not the stream id.
> Fix the programming of the S2CR register to ensure it is programmed
> correctly in both cases.
> 
> In addition, the SMR registers does not exist when stream matching is not
> supported by the hardware. Avoid writing to this register if not needed.

I've already fixed some/all of this in my iommu/pci branch:

  https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=iommu/pci&id=d4e46030b91367b50ecb544fee021b30e4ec4e9a

Can you try rebasing on that and see if there's anything left to do, please?

Once we get to -rc1, I'll sort out my branches so the iommu/devel branch
will contain stuff that I consider candidates for merging (since the
iommu/pci branch contains a bunch of WIP/RFC stuff too)

Cheers,

Will
