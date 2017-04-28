From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Don't print the failure message when
	booting non-kdump kernel
Date: Fri, 28 Apr 2017 23:39:00 +0200
Message-ID: <20170428213900.GA19756@8bytes.org>
References: <20170427171615.78999-1-qiuxu.zhuo@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170427171615.78999-1-qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 28, 2017 at 01:16:15AM +0800, Qiuxu Zhuo wrote:
> When booting a new non-kdump kernel, we have below failure message:
> 
> [    0.004000] DMAR-IR: IRQ remapping was enabled on dmar2 but we are not in kdump mode
> [    0.004000] DMAR-IR: Failed to copy IR table for dmar2 from previous kernel
> [    0.004000] DMAR-IR: IRQ remapping was enabled on dmar1 but we are not in kdump mode
> [    0.004000] DMAR-IR: Failed to copy IR table for dmar1 from previous kernel
> [    0.004000] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
> [    0.004000] DMAR-IR: Failed to copy IR table for dmar0 from previous kernel
> [    0.004000] DMAR-IR: IRQ remapping was enabled on dmar3 but we are not in kdump mode
> [    0.004000] DMAR-IR: Failed to copy IR table for dmar3 from previous kernel
> 
> For non-kdump case, we no need to copy IR table from previous kernel
> so it's nonthing actually failed. To be less alarming or misleading,
> do not print "DMAR-IR: Failed to copy IR table for dmar[0-9] from
> previous kernel" messages when booting non-kdump kernel.
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel_irq_remapping.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Applied, thanks.
