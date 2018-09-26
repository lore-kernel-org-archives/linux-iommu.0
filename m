From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Qcom smmu-500 TLB invalidation errata for sdm845
Date: Wed, 26 Sep 2018 11:53:49 +0530
Message-ID: <CAFp+6iEdyBKcQ=ikOaqJGHcmsjWJdDMWGgzFdW54aSqpQ-EE3Q@mail.gmail.com>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
	<20180925120933.54xd72sv65d63tkl@8bytes.org>
	<20180925163928.GA1839@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180925163928.GA1839@brain-police>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 25, 2018 at 10:09 PM Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>
> On Tue, Sep 25, 2018 at 02:09:34PM +0200, Joerg Roedel wrote:
> > On Mon, Sep 10, 2018 at 11:55:47AM +0530, Vivek Gautam wrote:
> > > Vivek Gautam (4):
> > >   firmware: qcom_scm-64: Add atomic version of qcom_scm_call
> > >   firmware/qcom_scm: Add atomic version of io read/write APIs
> > >   firmware/qcom_scm: Add scm call to handle smmu errata
> > >   iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
> > >
> > >  drivers/firmware/qcom_scm-32.c |  17 ++++
> > >  drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
> > >  drivers/firmware/qcom_scm.c    |  18 ++++
> > >  drivers/firmware/qcom_scm.h    |   9 ++
> > >  drivers/iommu/arm-smmu-regs.h  |   2 +
> > >  drivers/iommu/arm-smmu.c       | 133 +++++++++++++++++++++++++++++-
> > >  include/linux/qcom_scm.h       |   6 ++
> > >  7 files changed, 320 insertions(+), 46 deletions(-)
> >
> > Should this go through the iommu-tree? In that case I need Acked-by's
> > for the firmware code changes.
>
> Yup, and I'd also like Robin's ack on the arm-smmu*.c changes (I see he has
> some comments on the code as it stands).

Thanks Joerg, and Will for taking a look at it. I will answer and
address Robin's comments
for smmu part.

Best regards
Vivek

>
> Will
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
