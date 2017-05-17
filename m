From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: intel: Flush the IOTLB to get rid of the initial
	kdump mappings
Date: Wed, 17 May 2017 14:46:30 +0200
Message-ID: <20170517124630.GC11068@8bytes.org>
References: <1494009599-20962-1-git-send-email-karahmed@amazon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1494009599-20962-1-git-send-email-karahmed-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: KarimAllah Ahmed <karahmed-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>, Anthony Liguori <aliguori-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 05, 2017 at 11:39:59AM -0700, KarimAllah Ahmed wrote:
> Ever since commit 091d42e43d ("iommu/vt-d: Copy translation tables from
> old kernel") 

Please put the commit-information into a Fixes: tag next time. I'll
added a Fixes tag to the commit this time.

> the kdump kernel copies the IOMMU context tables from the
> previous kernel. Each device mappings will be destroyed once the driver
> for the respective device takes over.
> 
> This unfortunately breaks the workflow of mapping and unmapping a new
> context to the IOMMU. The mapping function assumes that either:
> 
> 1) Unmapping did the proper IOMMU flushing and it only ever flush if the
>    IOMMU unit supports caching invalid entries.
> 2) The system just booted and the initialization code took care of
>    flushing all IOMMU caches.
> 
> This assumption is not true for the kdump kernel since the context
> tables have been copied from the previous kernel and translations could
> have been cached ever since. So make sure to flush the IOTLB as well
> when we destroy these old copied mappings.
> 
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: David Woodhouse <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>
> Cc: Anthony Liguori <aliguori-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: KarimAllah Ahmed <karahmed-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>

Applied to iommu/fixes, thanks.
