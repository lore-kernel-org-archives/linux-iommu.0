From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 0/4] Qcom smmu-500 TLB invalidation errata for sdm845
Date: Tue, 25 Sep 2018 17:39:30 +0100
Message-ID: <20180925163928.GA1839@brain-police>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180925120933.54xd72sv65d63tkl@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180925120933.54xd72sv65d63tkl@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, andy.gross@linaro.org, robin.murphy@arm.com, bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, david.brown@linaro.org, tfiga@chromium.org, swboyd@chromium.org, linux-kernel@vger.kernel.org, robdclark@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 25, 2018 at 02:09:34PM +0200, Joerg Roedel wrote:
> On Mon, Sep 10, 2018 at 11:55:47AM +0530, Vivek Gautam wrote:
> > Vivek Gautam (4):
> >   firmware: qcom_scm-64: Add atomic version of qcom_scm_call
> >   firmware/qcom_scm: Add atomic version of io read/write APIs
> >   firmware/qcom_scm: Add scm call to handle smmu errata
> >   iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
> > 
> >  drivers/firmware/qcom_scm-32.c |  17 ++++
> >  drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
> >  drivers/firmware/qcom_scm.c    |  18 ++++
> >  drivers/firmware/qcom_scm.h    |   9 ++
> >  drivers/iommu/arm-smmu-regs.h  |   2 +
> >  drivers/iommu/arm-smmu.c       | 133 +++++++++++++++++++++++++++++-
> >  include/linux/qcom_scm.h       |   6 ++
> >  7 files changed, 320 insertions(+), 46 deletions(-)
> 
> Should this go through the iommu-tree? In that case I need Acked-by's
> for the firmware code changes.

Yup, and I'd also like Robin's ack on the arm-smmu*.c changes (I see he has
some comments on the code as it stands).

Will
