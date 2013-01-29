From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [v3 1/1] iommu/tegra: smmu: Support variable MMIO ranges/blocks
Date: Tue, 29 Jan 2013 10:58:41 -0700
Message-ID: <51080DD1.6050007@wwwdotorg.org>
References: <510800F7.7020507@wwwdotorg.org>
	<1359482169-26756-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1359482169-26756-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/29/2013 10:56 AM, Hiroshi Doyu wrote:
> Presently SMMU registers are located in discontiguous 3 blocks. They
> are interleaved by MC registers. Ideally SMMU register blocks should
> be in an independent one block, but it is too late to change this H/W
> design. In the future Tegra chips over some generations, it is
> expected that some of register block "size" can be extended towards
> the end and also more new register blocks will be added at most a few
> blocks. The starting address of each existing block won't change. This
> patch allocates multiple number of register blocks dynamically based
> on the info passed from DT. Those ranges are verified in the
> accessors{read,write}. This may sacrifice some performance because a
> new accessors prevents compiler optimization of a fixed size register
> offset calculation. Since SMMU register accesses are not so frequent,
> this would be acceptable. This patch is necessary to unify
> "tegra-smmu.ko" over some Tegra SoC generations.

Reviewed-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
