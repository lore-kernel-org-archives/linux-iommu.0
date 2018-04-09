From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v11 0/4] iommu/arm-smmu: Add runtime pm/sleep support
Date: Mon, 09 Apr 2018 04:22:09 +0000
Message-ID: <CAAFQd5CDY5p8oBz4QC5f6GsKiiYqdenCHGCqKhuWn10JwKjOpw@mail.gmail.com>
References: <20180322102204.14760-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180322102204.14760-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will, Robin,

On Thu, Mar 22, 2018 at 7:22 PM Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
wrote:

> This series provides the support for turning on the arm-smmu's
> clocks/power domains using runtime pm. This is done using the
> recently introduced device links patches, which lets the smmu's
> runtime to follow the master's runtime pm, so the smmu remains
> powered only when the masters use it.
> As not all implementations support clock/power gating, we are checking
> for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
> power management for such smmu implementations that can support it.

> This series also adds support for Qcom's arm-smmu-v2 variant that
> has different clocks and power requirements.

> Took some reference from the exynos runtime patches [1].

> With conditional runtime pm now, we avoid touching dev->power.lock
> in fastpaths for smmu implementations that don't need to do anything
> useful with pm_runtime.
> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> calls in map/unmap callbacks so that the clients do not have to
> worry about handling any of the arm-smmu's power.

> Previous version of this patch series is @ [5].

> [v11]
>     * Some more cleanups for device link. We don't need an explicit
>       delete for device link from the driver, but just set the flag
>       DL_FLAG_AUTOREMOVE.
>       device_link_add() API description says -
>       "If the DL_FLAG_AUTOREMOVE is set, the link will be removed
>       automatically when the consumer device driver unbinds."
>     * Addressed the comments for 'smmu' in arm_smmu_map/unmap().
>     * Dropped the patch [10] that introduced device_link_del_dev() API.

As far as I can see, this version addresses all the earlier comments. Do
you think this is something that you could apply?

Best regards,
Tomasz
