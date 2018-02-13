From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Don't use dev_data in irte_ga_set_affinity()
Date: Tue, 13 Feb 2018 14:19:19 +0100
Message-ID: <20180213131919.5vwvervbgi62cpjy@8bytes.org>
References: <20180128202219.27005-1-swood@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180128202219.27005-1-swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Jan 28, 2018 at 02:22:19PM -0600, Scott Wood wrote:
> search_dev_data() acquires a non-raw lock, which can't be done
> from atomic context on PREEMPT_RT.  There is no need to look at
> dev_data because guest_mode should never be set if use_vapic is
> not set.
> 
> Signed-off-by: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> This is a followup to the patches below:
> 
> https://patchwork.codeaurora.org/patch/433611/
> https://patchwork.codeaurora.org/patch/433613/
> 
>  drivers/iommu/amd_iommu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.
