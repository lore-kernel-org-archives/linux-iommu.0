From: Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
	ThunderX2 SMMUv3 model
Date: Tue, 20 Jun 2017 10:51:23 +0200
Message-ID: <20170620085123.GF16981@rric.localdomain>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
	<1496145821-3411-2-git-send-email-gakula@caviumnetworks.com>
	<20170620081943.GT658@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170620081943.GT658-vWBEXY7mpu582hYKe6nXyg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, sudeep.holla-5wv7dgnIgG8@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 20.06.17 10:19:43, Robert Richter wrote:
> On 30.05.17 17:33:39, Geetha sowjanya wrote:
> > From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

> > +	/*
> > +	 * Override the size, for Cavium ThunderX2 implementation
> > +	 * which doesn't support the page 1 SMMU register space.
> > +	 */
> > +	if (smmu->model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
> 
> Geetha,
> 
> please resubmit the series since the macro changed to
> ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
> 
>  https://github.com/acpica/acpica/commit/d00a4eb86e64bb4fa70f57ab5e5ca0a4ca2ad8ef#diff-a572aac2ccc26fe4a901616d7fdba859R1053

Rafael, Bob,

btw, I haven't seen

 https://github.com/acpica/acpica/commit/d00a4eb86e64

yet in linux-pm:linux-next. We would like to see this in 4.13 also. Is
it on the way already?

Thanks,

-Robert
