From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [RFC PATCH 4/4] iommu/arm-smmu: Add support for specifying regulators
Date: Fri, 24 Jul 2015 17:58:20 +0530
Message-ID: <006001d0c60c$3d6d39e0$b847ada0$@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org> <1437152005-25092-5-git-send-email-sricharan@codeaurora.org> <55AE8CBA.90805@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <55AE8CBA.90805@codeaurora.org>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Stephen Boyd' <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, will.deacon@arm.com, iommu@lists.linux-foundation.org, mitchelh@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Stephen,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces@lists.infradead.org] On Behalf Of Stephen Boyd
> Sent: Tuesday, July 21, 2015 11:48 PM
> To: Sricharan R
> Cc: devicetree@vger.kernel.org; linux-arm-msm@vger.kernel.org;
> will.deacon@arm.com; iommu@lists.linux-foundation.org;
> mitchelh@codeaurora.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [RFC PATCH 4/4] iommu/arm-smmu: Add support for specifying
> regulators
> 
> On 07/17/2015 09:53 AM, Sricharan R wrote:
> > From: Mitchel Humpherys <mitchelh@codeaurora.org>
> >
> > This adds the support to turn on the regulators required for SMMUs. It
> > is turned on during the SMMU probe and remains 'on' till the device
> > exists.
> 
> The device always exists. Until the driver is removed perhaps?
> 
  Till the device exists.

> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> 
> We won't be using regulators. We'll be using power domains instead so
> please rewrite this patch accordingly.
> 
 Ok. Thanks for the direction.

Regards,
 Sricharan
