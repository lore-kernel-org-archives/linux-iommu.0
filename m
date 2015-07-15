From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 3/4] arm64: Add IOMMU dma_ops
Date: Wed, 15 Jul 2015 17:53:16 +0100
Message-ID: <20150715165316.GG20186@e104818-lin.cambridge.arm.com>
References: <cover.1436552949.git.robin.murphy@arm.com>
	<a074dfeffc8c8168bef2668de2499f072fdcfac7.1436552949.git.robin.murphy@arm.com>
	<20150715093128.GA20186@e104818-lin.cambridge.arm.com>
	<55A689EA.8030306@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55A689EA.8030306-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 15, 2015 at 05:27:22PM +0100, Robin Murphy wrote:
> On 15/07/15 10:31, Catalin Marinas wrote:
> >On Fri, Jul 10, 2015 at 08:19:34PM +0100, Robin Murphy wrote:
> >>+			if (iommu_dma_mapping_error(dev, *handle)) {
> >>+				if (coherent)
> >>+					__free_pages(page, get_order(size));
> >>+				else
> >>+					__free_from_pool(addr, size);
> >>+				addr = NULL;
> >>+			}
> >>+		}
> >>+	}
> >>+	return addr;
> >>+}
> >
> >In the second case here (!__GFP_WAIT), do we do any cache maintenance? I
> >can't see it and it's needed for the !coherent case.
> 
> In the atomic non-coherent case, we're stealing from the atomic pool, so
> addr is already a non-cacheable alias (and alloc_from_pool does memset(0)
> through that). That shouldn't need anything extra, right?

You are right, we already flushed the cache for the atomic pool when we
allocated it in atomic_pool_init().

-- 
Catalin
