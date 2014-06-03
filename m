From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dma-mapping: Add devm_ interface for
	dma_map_single()
Date: Wed, 4 Jun 2014 01:39:07 +0200
Message-ID: <20140603233907.GB23880@8bytes.org>
References: <1401606077-1739-1-git-send-email-eli.billauer@gmail.com>
	<1401606077-1739-2-git-send-email-eli.billauer@gmail.com>
	<538E3D04.9060808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <538E3D04.9060808-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, discuss-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Eli Billauer <eli.billauer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 03, 2014 at 03:24:20PM -0600, Shuah Khan wrote:
> On 06/01/2014 01:01 AM, Eli Billauer wrote:
> I see the value of this interface in unmap case, this type of wrapper
> can release dma buffers, drivers neglected to release leaving dangling
> buffers.
> 
> However, driver writers should give it some thought before switching
> from conventional dma_map_*() interfaces to these proposed managed
> dma mapping interfaces. These new interfaces shouldn't be treated as
> drop in replacements to dma_map_*() interfaces.
> 
> The reasons are:
> 
> 1. This interface adds an overhead in allocation memory for devres to
>    compared to other dma_map_* wrappers. Users need to be aware of that.
>    This would be okay in the cases where a driver allocates several
>    buffers at init time and uses them. However, several drivers allocate
>    during run-time and release as soon as it is no longer needed. This
>    overhead is going to be in the performance path.
> 
> 2. It adds a failure case even when dma buffers are available. i.e if
>    if devres alloc fails, it will return failure even if dma map could
>    have succeeded. This is a new failure case for DMA-API.
> 
>    The reason dma_map_*() routines fail now is because there are no
>    buffers available. Drivers handle this error as a retry case.
> 
>    Drivers using dmam_map_single() will have to handle the failure
>    cases differently.
> 
>    Since the return values are different for dmam_map_*(), that is
>    plus that these interfaces can't be drop in replacements to the
>    dma_map_*() interfaces.
> 
> 3. Similarly, it adds an overhead in releasing memory for devres to
>    compared to other dma_unmap_* wrappers. Users need to be aware of
>    that. This overhead is going to be in the performance path when
>    drivers unmap buffers during run-time.

I fully agree with the points Shuah brought up here. I don't think it is
a good idea to add this kind of resource management to runtime-allocated
(and de-allocated) resources of device drivers.

Also DMA handles are not something that could be garbage collected at
driver unload time. They are a limited resource that may be used up at
some point. And the whole point of a devm-API is that code can be
simpler because we don't need to de-allocate everything on the
error-path or at unload time, no?

Besides that, we already have DMA-API debug to find drivers that do not
release all their DMA buffers.


	Joerg
