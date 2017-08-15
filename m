From: Rob Clark <robdclark@gmail.com>
Subject: Re: [pull] iommu: qcom_iommu for v4.14
Date: Tue, 15 Aug 2017 12:52:11 -0400
Message-ID: <CAF6AEGtxmJUOKZpqMZfYkgP6Bs7mbGAzEtC8on8TkjdTU5pcFQ@mail.gmail.com>
References: <CAF6AEGuNqQtJBhLAFu3NdUAjKJrVvR9WtHL-eCRN0H1Di6_4mQ@mail.gmail.com>
 <20170815154232.GB25618@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170815154232.GB25618@8bytes.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 15, 2017 at 11:42 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Sun, Aug 13, 2017 at 10:27:36AM -0400, Rob Clark wrote:
>> Hi Joerg,
>>
>> These patches have been on list for quite some time now.  The bindings
>> have r-b from Rob Herring, and the patch touching arm-smmu has Will's
>> a-b.  And all the review comments on the driver patches have been
>> addressed (despite no one stepping up w/ a r-b tag).  Please consider
>> merging this pull request for v4.14
>
> Okay, I applied it, not from this pull-request, but from your last
> post. Some comments for the future below.

Thanks.  Patches from list are the same.

For future reference to you prefer to pick up patches from list?
(Dave prefers pull req's for drm, but I guess the volume of patches
for an iommu driver should be lower.)

>> Rob Clark (3):
>>       Docs: dt: document qcom iommu bindings
>
> This patch has no commit-message. Usually that is a reason for me to
> reject the patch. I applied it anyway this time because it has an
> Reviewed-By from a device-tree maintainer, and if its fine for him, I
> can live with it.
>
> For the other three patches I edited the Subject line to match the
> convention of the iommu-tree, which is "iommu/<driver>: _Capital Letter_...
>
> The patches below are now named:
>
>>       iommu: arm-smmu: split out register defines
>         iommu/arm-smmu: Split out register defines
>
>>       iommu: add qcom_iommu
>         iommu/qcom: Add qcom_iommu
>>
>> Stanimir Varbanov (1):
>>       iommu: qcom: initialize secure page table
>         iommu/qcom: Initialize secure page table
>
> Please follow that convention for future patches.
>

will do, thanks

BR,
-R

>
> Thanks,
>
>         Joerg
>
