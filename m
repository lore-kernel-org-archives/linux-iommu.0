From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 05/12] memory: Add NVIDIA Tegra memory controller
	support
Date: Mon, 17 Nov 2014 14:47:07 +0100
Message-ID: <20141117134707.GA3762@8bytes.org>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
	<1415871157-21968-6-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415871157-21968-6-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 13, 2014 at 10:32:30AM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> The memory controller on NVIDIA Tegra exposes various knobs that can be
> used to tune the behaviour of the clients attached to it.
> 
> Currently this driver sets up the latency allowance registers to the HW
> defaults. Eventually an API should be exported by this driver (via a
> custom API or a generic subsystem) to allow clients to register latency
> requirements.
> 
> This driver also registers an IOMMU (SMMU) that's implemented by the
> memory controller. It is supported on Tegra30, Tegra114 and Tegra124
> currently. Tegra20 has a GART instead.
> 
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Hi Joerg,
> 
> As I mentioned in the cover-letter, I would like to take this whole series
> through the Tegra tree to simplify dependency handling. Can I have your
> Acked-by on this patch?

Sure!

>  drivers/iommu/Kconfig                    |   12 +-
>  drivers/iommu/tegra-smmu.c               | 1601 ++++++++++--------------------
>  drivers/memory/Kconfig                   |   12 +-
>  drivers/memory/Makefile                  |    3 +-
>  drivers/memory/tegra/Kconfig             |    7 +
>  drivers/memory/tegra/Makefile            |    7 +
>  drivers/memory/tegra/mc.c                |  301 ++++++
>  drivers/memory/tegra/mc.h                |   53 +
>  drivers/memory/tegra/tegra114.c          |  948 ++++++++++++++++++
>  drivers/memory/tegra/tegra124.c          |  995 +++++++++++++++++++
>  drivers/memory/tegra/tegra30.c           |  970 ++++++++++++++++++
>  drivers/memory/tegra30-mc.c              |  377 -------
>  include/dt-bindings/memory/tegra114-mc.h |   25 +
>  include/dt-bindings/memory/tegra124-mc.h |   31 +
>  include/dt-bindings/memory/tegra30-mc.h  |   24 +
>  include/soc/tegra/mc.h                   |  107 ++
>  16 files changed, 3992 insertions(+), 1481 deletions(-)

Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
