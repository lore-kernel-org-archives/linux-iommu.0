From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/core: fix bus notifier breakage
Date: Thu, 25 Sep 2014 16:47:54 +0200
Message-ID: <20140925144754.GD8306@8bytes.org>
References: <1411322304-3925-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411322304-3925-1-git-send-email-msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Sep 21, 2014 at 01:58:24PM -0400, Mark Salter wrote:
> iommu_bus_init() registers a bus notifier on the given bus by using
> a statically defined notifier block:
> 
>   static struct notifier_block iommu_bus_nb = {
>           .notifier_call = iommu_bus_notifier,
>   };
> 
> This same notifier block is used for all busses. This causes a
> problem for notifiers registered after iommu has registered this
> callback on multiple busses. The problem is that a subsequent
> notifier being registered on a bus which has this iommu notifier
> will also get linked in to the notifier list of all other busses
> which have this iommu notifier.
> 
> This patch fixes this by allocating the notifier_block at runtime.
> Some error checking is also added to catch any allocation failure
> or notifier registration error.
> 
> Signed-off-by: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)

Makes sense, applied. Where have you hit this condition where IOMMUs for
different buses are registered?


	Joerg
