From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/5] iommu/ipmmu-vmsa: Add device tree bindings documentation
Date: Tue, 01 Apr 2014 15:57:23 +0200
Message-ID: <21849566.ZKDm3aBJbz@avalon>
References: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1396049781-12941-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <5336EBB8.8020204@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5336EBB8.8020204@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Sergei,

Thank you for the review.

On Saturday 29 March 2014 18:50:16 Sergei Shtylyov wrote:
> On 03/29/2014 02:36 AM, Laurent Pinchart wrote:
> > Cc: devicetree@vger.kernel.org
> > Cc: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  .../bindings/iommu/renesas,ipmmu-vmsa.txt          | 35 +++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644
> >  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt> 
> > diff --git
> > a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt new file
> > mode 100644
> > index 0000000..72e8590
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > @@ -0,0 +1,35 @@
> > +* Renesas VMSA-Compatible IOMMU
> > +
> > +The IPMMU is an IOMMU implementation compatible with the ARM VMSA page
> > tables.
> > +It provides address translation bus masters outside of the CPU, each
> > connected
>                                    ^ "for" missing?

Of course. I'll fix that.

-- 
Regards,

Laurent Pinchart

