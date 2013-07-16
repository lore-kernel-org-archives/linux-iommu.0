From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 10/22] iommu/tegra: smmu: Move IOMMU to core_initcall
Date: Tue, 16 Jul 2013 17:21:58 -0600
Message-ID: <51E5D596.3030002@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
	<1373021097-32420-11-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1373021097-32420-11-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Move IOMMU to core_initcall in order to instanciate this device earlier
> than others since IOMMU driver needs to reigster other platform
> devices as IOMMU'able.

If both the AHB and SMMU driver are core_initcall, there's no guarantee
at all re: which order they'll get probed in. Deferred probe won't help
here, since I don't think it's guaranteed to be repeated, so if the
probe order is:

1) SMMU (fails since AHB isn't available)
2) AHB

... then the SMMU might not get probed until /much/ later; probably
after devices that are affected by the SMMU are probed.

However, it all works out if the probe order just accidentally happens
to be:

1) AHB
2) SMMU.

So, this really doesn't look like a viable solution.
