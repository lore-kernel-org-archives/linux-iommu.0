From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [pull] iommu: qcom_iommu for v4.14
Date: Tue, 15 Aug 2017 17:42:33 +0200
Message-ID: <20170815154232.GB25618@8bytes.org>
References: <CAF6AEGuNqQtJBhLAFu3NdUAjKJrVvR9WtHL-eCRN0H1Di6_4mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGuNqQtJBhLAFu3NdUAjKJrVvR9WtHL-eCRN0H1Di6_4mQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Aug 13, 2017 at 10:27:36AM -0400, Rob Clark wrote:
> Hi Joerg,
> 
> These patches have been on list for quite some time now.  The bindings
> have r-b from Rob Herring, and the patch touching arm-smmu has Will's
> a-b.  And all the review comments on the driver patches have been
> addressed (despite no one stepping up w/ a r-b tag).  Please consider
> merging this pull request for v4.14

Okay, I applied it, not from this pull-request, but from your last
post. Some comments for the future below.

> Rob Clark (3):
>       Docs: dt: document qcom iommu bindings

This patch has no commit-message. Usually that is a reason for me to
reject the patch. I applied it anyway this time because it has an
Reviewed-By from a device-tree maintainer, and if its fine for him, I
can live with it.

For the other three patches I edited the Subject line to match the
convention of the iommu-tree, which is "iommu/<driver>: _Capital Letter_...

The patches below are now named:

>       iommu: arm-smmu: split out register defines
        iommu/arm-smmu: Split out register defines

>       iommu: add qcom_iommu
        iommu/qcom: Add qcom_iommu
> 
> Stanimir Varbanov (1):
>       iommu: qcom: initialize secure page table
        iommu/qcom: Initialize secure page table

Please follow that convention for future patches.


Thanks,

	Joerg
