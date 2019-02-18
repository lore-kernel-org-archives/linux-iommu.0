From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
	consistent with kaslr
Date: Mon, 18 Feb 2019 09:48:20 +0800
Message-ID: <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
References: <20190125140823.GC27998@zn.tnic>
	<20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
	<20190131105732.GC6749@zn.tnic> <20190131222732.GA946@anatevka>
	<20190131234740.GO6749@zn.tnic> <20190204223016.GB11986@anatevka>
	<20190205081552.GG21801@zn.tnic>
	<20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
	<20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
	<20190215102458.GD10433@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190215102458.GD10433-Jj63ApZU6fQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jerry Hoemann <jerry.hoemann-ZPxbGqLxI0U@public.gmane.org>, Pingfan Liu <kernelfans-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mike Rapoport <rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/15/19 at 11:24am, Borislav Petkov wrote:
> On Tue, Feb 12, 2019 at 04:48:16AM +0800, Dave Young wrote:
> > Even we make it automatic in kernel, but we have to have some default
> > value for swiotlb in case crashkernel can not find a free region under 4G.
> > So this default value can not work for every use cases, people need 
> > manually use crashkernel=,low and crashkernel=,high in case
> > crashkernel=X does not work.
> 
> Why would the user need to find swiotlb range? The kernel has all the
> information it requires at its finger tips in order to decide properly.
> 
> The user wants a crashkernel range, the kernel tries the low range =>
> no workie, then it tries the next range => workie but needs to allocate
> swiotlb range so that DMA can happen too. Doh, then the kernel does
> allocate that too.

It is ideal if kernel can do it automatically, but I'm not sure if
kernel can predict the swiotlb reserved size automatically.

Let's add more people to seek for comments. 

> 
> Why would the user need to do anything here?!
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
