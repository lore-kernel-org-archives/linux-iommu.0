From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 7/7] iommu/arm-smmu: add support for dynamic domains
Date: Tue, 7 Mar 2017 18:11:38 +0000
Message-ID: <20170307181138.GF3514@leverpostej>
References: <1488904795-870-1-git-send-email-jcrouse@codeaurora.org>
	<1488904795-870-8-git-send-email-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1488904795-870-8-git-send-email-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 07, 2017 at 09:39:55AM -0700, Jordan Crouse wrote:
> Implement support for dynamic domain switching. This feature is
> only enabled when the qcom,dynamic device tree attribute for an smmu
> instance.
> 
> In order to use dynamic domains, a non-dynamic domain must first
> be created and attached.  The non-dynamic domain must remain
> attached while the device is in use.
> 
> The dynamic domain is cloned from the non-dynamic domain. Important
> configuration information is copied from the non-dynamic domain and
> the dynamic domain is automatically "attached" (though it doesn't
> program the hardware).
> 
> To switch domains dynamically the hardware must program the TTBR0 register
> with the value from the DOMAIN_ATTR_TTBR0 attribute for the dynamic domain.
> The upstream driver may also need to do other hardware specific register
> programming to properly synchronize the domain switch. It must ensure that
> all register state except for the TTBR0 register is restored
> at the end of the switch operation.

> +	{ ARM_SMMU_OPT_DYNAMIC, "qcom,dynamic" },

What *precisely* is the intended semantic of this property?

It's not clear to me what a dynamic domain is, there's no documentation
in this series for this property, and from a glance it sounds like a
pure SW detail rather than a hardware/system detail (i.e. it shouldn;t
be in the DT at all).

This needs documentation. In future, please also Cc the devicetree list
(devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) when adding new properties.

Thanks,
Mark.
