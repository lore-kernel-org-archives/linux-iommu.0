From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v8 0/5] iommu/arm-smmu: Add runtime pm/sleep support
Date: Mon, 5 Mar 2018 22:25:42 +0900
Message-ID: <CAAFQd5AZoCgVts=DOET7js5VPi4ONM2m9R-WM6pWHud26XDVfA@mail.gmail.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180302101050.6191-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Vivek,

On Fri, Mar 2, 2018 at 7:10 PM, Vivek Gautam
<vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> This series provides the support for turning on the arm-smmu's
> clocks/power domains using runtime pm. This is done using the
> recently introduced device links patches, which lets the smmu's
> runtime to follow the master's runtime pm, so the smmu remains
> powered only when the masters use it.
>
> It also adds support for Qcom's arm-smmu-v2 variant that
> has different clocks and power requirements.
>
> Took some reference from the exynos runtime patches [1].
>
> After another round of discussion [3], we now finally seem to be
> in agreement to add a flag based on compatible, a flag that would
> indicate if a particular implementation of arm-smmu supports
> runtime pm or not.
> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> calls in map/unmap callbacks so that the clients do not have to
> worry about handling any of the arm-smmu's power.
> The patch that exported couple of pm_runtime suppliers APIS, viz.
> pm_runtime_get_suppliers(), and pm_runtime_put_suppliers() can be
> dropped since we don't have a user now for these APIs.
> Thanks Rafael for reviewing the changes, but looks like we don't
> need to export those APIs for some more time. :)
>
> Previous version of this patch series is @ [5].

Thanks for addressing my comments. There is still a bit of space for
improving the granularity of power management, as far as I understood
how it works on SDM845 correctly, but as a first step, this should at
least let things work.

Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Best regards,
Tomasz
