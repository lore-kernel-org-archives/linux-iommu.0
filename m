From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm-smmu: Add binding doc for Qcom
 smmu-500
Date: Wed, 12 Dec 2018 14:11:02 +0000
Message-ID: <20181212141101.GD23641@edgewater-inn.cambridge.arm.com>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181011094930.17010-2-vivek.gautam@codeaurora.org>
 <20181011221630.GA5841@bogus>
 <9ca4bb4f-3e6e-21cc-819e-80b979b934d0@codeaurora.org>
 <CAFp+6iF80P-o=Z-aNOMQwWMTcO4jcgSR0wOzd4GvmB3zTvWZLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFp+6iF80P-o=Z-aNOMQwWMTcO4jcgSR0wOzd4GvmB3zTvWZLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, David Brown <david.brown@linaro.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, robh+dt <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 12, 2018 at 03:18:06PM +0530, Vivek Gautam wrote:
> On Fri, Oct 12, 2018 at 11:37 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> > On 10/12/2018 3:46 AM, Rob Herring wrote:
> > > On Thu, 11 Oct 2018 15:19:29 +0530, Vivek Gautam wrote:
> > >> Qcom's implementation of arm,mmu-500 works well with current
> > >> arm-smmu driver implementation. Adding a soc specific compatible
> > >> along with arm,mmu-500 makes the bindings future safe.
> > >>
> > >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > >> ---
> > >>
> > >> Changes since v3:
> > >>   - Refined language more to state things directly for the bindings
> > >>     description.
> > >>
> > >>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
> > >>   1 file changed, 4 insertions(+)
> > >>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Thank you Rob.
> >
> 
> Can you please pick this one as well to your tree? This goes on top of the
> bindings patch for "qcom,smmu-v2". So, it can't go through Andy's tree.
> Will ask Andy to pick the second patch of the series, that adds the dt node.
> 
> I guess as I sent this one along with the dt patch, I would have
> mistakenly added
> you to 'cc' list rather than 'to' list.
> Let me know if you would like me to resend it.

I've already sent my stuff to Joerg, so it's too late for 4.21.
Perhaps resend this patch standalone to Joerg with me on CC so that I can
ack it.

Will
