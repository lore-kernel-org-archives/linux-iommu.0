From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [RFC PATCH 10/11] powerpc/svm: Force the use of bounce buffers
Date: Fri, 24 Aug 2018 08:00:55 +0200
Message-ID: <20180824060055.GB13689@lst.de>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
	<20180824025933.24319-11-bauerman@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180824025933.24319-11-bauerman-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thiago Jung Bauermann <bauerman-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Cc: Anshuman Khandual <anshuman.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Mike Anderson <andmike-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Ram Pai <linuxram-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Anshuman Khandual <khandual-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 23, 2018 at 11:59:32PM -0300, Thiago Jung Bauermann wrote:
> From: Anshuman Khandual <khandual-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> 
> SWIOTLB checks range of incoming CPU addresses to be bounced and see if the
> device can access it through it's DMA window without requiring bouncing. In
> such cases it just chooses to skip bouncing. But for cases like secure
> guests on powerpc platform all addresses need to be bounced into the shared
> pool of memory because the host cannot access it otherwise. Hence the need
> to do the bouncing is not related to device's DMA window. Hence force the
> use of bouncing by setting the swiotlb_force variable on secure guests.
> 
> Signed-off-by: Anshuman Khandual <khandual-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Thiago Jung Bauermann <bauerman-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
> ---
>  arch/powerpc/kernel/svm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
> index 1af5caa955f5..f0576ad65cd0 100644
> --- a/arch/powerpc/kernel/svm.c
> +++ b/arch/powerpc/kernel/svm.c
> @@ -17,6 +17,7 @@ static int __init init_svm(void)
>  		return 0;
>  
>  	ppc_swiotlb_enable = 1;
> +	swiotlb_force = SWIOTLB_FORCE;
>  	swiotlb_update_mem_attributes();

This needs a comment.
