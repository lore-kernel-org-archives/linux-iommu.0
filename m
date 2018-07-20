From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Remove redundant WARN_ON()
Date: Fri, 20 Jul 2018 14:36:42 +0200
Message-ID: <20180720123641.GE18541@8bytes.org>
References: <20180720084545.3284-1-anna-maria@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180720084545.3284-1-anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 20, 2018 at 10:45:45AM +0200, Anna-Maria Gleixner wrote:
> The WARN_ON() was introduced in commit 272e4f99e966 ("iommu/amd: WARN
> when __[attach|detach]_device are called with irqs enabled") to ensure
> that the domain->lock is taken in proper irqs disabled context. This
> is required, because the domain->lock is taken as well in irq
> context.
> 
> The proper context check by the WARN_ON() is redundant, because it is
> already covered by LOCKDEP. When working with locks and changing
> context, a run with LOCKDEP is required anyway and would detect the
> wrong lock context.
> 
> Furthermore all callers for those functions are within the same file
> and all callers acquire another lock which already disables interrupts.
> 
> Signed-off-by: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c | 12 ------------
>  1 file changed, 12 deletions(-)

Applied, thanks.
