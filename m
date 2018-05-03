From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/amd - Update the PASID information printed to
	the system log
Date: Thu, 3 May 2018 15:57:07 +0200
Message-ID: <20180503135706.nypxlwlt7jhqhhum@8bytes.org>
References: <152520429853.30928.9793486018349326103.stgit@taos>
	<152520437211.30928.8410126837908568791.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <152520437211.30928.8410126837908568791.stgit@taos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 01, 2018 at 02:52:52PM -0500, Gary R Hook wrote:
> @@ -567,7 +567,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  	}
>  
>  	if (type == EVENT_TYPE_IO_FAULT) {
> -		amd_iommu_report_page_fault(devid, domid, address, flags);
> +		amd_iommu_report_page_fault(devid, pasid, address, flags);

According to the spec this could be a domid or a pasid, it would be good
to make that visible in the error message, depending on the value of the
GN flag in the event entry.

But that can be done in a separate patch, I applied these two, thanks.
