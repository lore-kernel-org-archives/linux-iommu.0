From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V2 1/5] iommu/msm: Add DT adaptation
Date: Tue, 12 Apr 2016 21:04:28 +0530
Message-ID: <00a101d194d0$d22edcd0$768c9670$@codeaurora.org>
References: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org> <1459952975-1250-2-git-send-email-sricharan@codeaurora.org> <20160411134728.GA21468@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160411134728.GA21468@rob-hp-laptop>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Rob Herring' <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, robin.murphy@arm.com, robdclark@gmail.com, joro@8bytes.org, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, Will.Deacon@arm.com, stepanm@codeaurora.org, treding@nvidia.com
List-Id: iommu@lists.linux-foundation.org

Hi Rob,
 
> On Wed, Apr 06, 2016 at 07:59:31PM +0530, Sricharan R wrote:
> > The driver currently works based on platform data. Remove this and add
> > support for DT. A single master can have multiple ports connected to
> > more than one iommu.
> >
> > 	  	      master
> >         	        |
> > 	                |
> > 	                |
> > 	   ------------------------
> >            |  			  |
> > 	IOMMU0			IOMMU1
> 
> You've got mixtures of tabs and spaces here. Either fully use leading tabs
or
> use spaces everywhere.
   Ok, will change this properly.

> 
> >            |			  |
> >       ctx0   ctx1	     ctx0   ctx1
> >
> 
> It is preferred to split bindings to separate patch.
   Ok, will split it.

> > +The QCOM IOMMU is an implementation compatible with the ARM VMSA
> > +short descriptor page tables. It provides address translation for bus
> > +masters outside of the CPU, each connected to the IOMMU through a
> port called micro-TLB.
> > +
> > +Required Properties:
> > +
> > +  - compatible: Must contain "qcom,iommu-v0".
> 
> You need SoC specific compatible strings in addition.
> 
 Ok, will add it.

Regards,
  Sricharan
