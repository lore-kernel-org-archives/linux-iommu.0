From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 00/12] NVIDIA Tegra memory controller and IOMMU support
Date: Mon, 10 Nov 2014 18:53:30 +0900
Message-ID: <54608B1A.3010001@nvidia.com>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415376063-17205-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/08/2014 01:00 AM, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> This is the sixth installment in the Tegra IOMMU and memory controller
> support series. This version addresses the final outstanding comments from
> Olof about using proper Kconfig symbols to track the dependencies. It also
> splits up the driver into one part that implements the memory controller
> only and a second part that implements the SMMU. This plays nicely with
> the new Kconfig options introduced.
>
> Patch 1 is a preparatory patch that exposes the memory controller clock.
>
> Patches 2 and 3 is a pair of precursory patches needed to make this all
> work on 64-bit ARM in the future.
>
> The device tree binding for the Tegra memory controller is added in patch
> 4 and patch 5 is the bulk of the series that move the existing memory
> controller and IOMMU drivers into the new unified driver that supports
> Tegra30, Tegra114 and Tegra124.
>
> Patches 6, 7 and 8 add the DT nodes for the memory controller/IOMMU on
> Tegra30, Tegra114 and Tegra124.
>
> IOMMU support is enabled for the display controllers in patches 9, 10 and
> 11. This will allow the display controllers to have their memory accesses
> translated by the SMMU, which will enable non-contiguous buffers to be
> used for scan-out.
>
> Finally patch 12 also adds support for Tegra132. It is kept separate because
> none of the other Tegra132 patches have been merged yet, but I've included
> it here for completeness.
>
> Because the patches are rather intertwined, I'd like to merge them all via
> the Tegra tree. For that I'll need Acked-bys from Mike, Russell and Joerg
> on patches 1, 2 and 3, and 5, respectively.

FWIW,

Tested-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Works nicely with both the display and GPU clients, which allows us to 
remove the need for CMA on Tegra.

Thanks,
Alex.
