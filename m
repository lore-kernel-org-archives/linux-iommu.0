From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm-smmu: Add binding doc for Qcom
	smmu-500
Date: Wed, 12 Dec 2018 15:18:06 +0530
Message-ID: <CAFp+6iF80P-o=Z-aNOMQwWMTcO4jcgSR0wOzd4GvmB3zTvWZLw@mail.gmail.com>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
	<20181011094930.17010-2-vivek.gautam@codeaurora.org>
	<20181011221630.GA5841@bogus>
	<9ca4bb4f-3e6e-21cc-819e-80b979b934d0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9ca4bb4f-3e6e-21cc-819e-80b979b934d0-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Fri, Oct 12, 2018 at 11:37 AM Vivek Gautam
<vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
>
>
> On 10/12/2018 3:46 AM, Rob Herring wrote:
> > On Thu, 11 Oct 2018 15:19:29 +0530, Vivek Gautam wrote:
> >> Qcom's implementation of arm,mmu-500 works well with current
> >> arm-smmu driver implementation. Adding a soc specific compatible
> >> along with arm,mmu-500 makes the bindings future safe.
> >>
> >> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >> ---
> >>
> >> Changes since v3:
> >>   - Refined language more to state things directly for the bindings
> >>     description.
> >>
> >>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> > Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> Thank you Rob.
>

Can you please pick this one as well to your tree? This goes on top of the
bindings patch for "qcom,smmu-v2". So, it can't go through Andy's tree.
Will ask Andy to pick the second patch of the series, that adds the dt node.

I guess as I sent this one along with the dt patch, I would have
mistakenly added
you to 'cc' list rather than 'to' list.
Let me know if you would like me to resend it.

Thank
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
