From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 06/19] iommu/tegra: smmu: Select ARM_DMA_USE_IOMMU in
	Kconfig
Date: Fri, 01 Nov 2013 10:55:41 -0600
Message-ID: <5273DD0D.60206@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com><1382092020-13170-7-git-send-email-hdoyu@nvidia.com><527184E4.1070800@wwwdotorg.org>
	<20131031.101601.1966768312584871868.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131031.101601.1966768312584871868.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/31/2013 02:16 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 30 Oct 2013 23:15:00 +0100:
> 
>> On 10/18/2013 04:26 AM, Hiroshi Doyu wrote:
>>> SMMU expects ARM_DMA_USE_IOMMU to be enabled to use DMA mapping API by
>>> default.
>>
>> Is the select required for the driver to be useful at all (in which case
>> it's fine), or simply for things to work "better" (define "better"), in
>> which case perhaps leaving it optional is more correct.
> 
> Practically DMA API is the only interface for IOMMU(ARM_DMA_USE_IOMMU)
> for us, but technically they are/should be independent.

I would be tempted to deal with this in the defconfig, but I suppose
handling it as a Kconfig select is fine too; there's probably no real
disadvantage in doing so.
