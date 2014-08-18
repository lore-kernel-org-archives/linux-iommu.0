From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: RE: [PATCH 1/1] iommu/vt-d : clear old root entry for dump kernel
Date: Mon, 18 Aug 2014 23:47:37 +0000
Message-ID: <1267BB84A242B24E81E0C0C8955CFFC061A4CA86@G9W0343.americas.hpqcorp.net>
References: <1408352352-14449-1-git-send-email-zhen-hual@hp.com>
	<1267BB84A242B24E81E0C0C8955CFFC061A4BA26@G9W0343.americas.hpqcorp.net>
	<20140818232328.GK9809@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When the dump kernel boots, it will initialize iommu again, and the root entry will be allocted 
in another memory region.

That means, no matter kernel clears the old root entry table or not,  the dump kernel will use 
another memory region when iommu initializing.

-----Original Message-----
From: Li, Zhen-Hua 
Sent: Tuesday, August 19, 2014 7:27 AM
To: 'Joerg Roedel'
Cc: David Woodhouse; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: RE: [PATCH 1/1] iommu/vt-d : clear old root entry for dump kernel

: [fault reason 01] Present bit in root entry is clear
It appears when iommu initializing in the kdump kernel.

-----Original Message-----
From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org] 
Sent: Tuesday, August 19, 2014 7:23 AM
To: Li, Zhen-Hua
Cc: David Woodhouse; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH 1/1] iommu/vt-d : clear old root entry for dump kernel

On Mon, Aug 18, 2014 at 11:01:56PM +0000, Li, Zhen-Hua wrote:
> There is a bug when Linux running on an HP large system: 
> 	when kdump kernel runs, the hardware is still using the old 
> root entry. This causes error message when iommu not finished initialization.

What error message are you seeing? When the kdump kernel boots the iommu
should be still enabled from the old kernel with the old root-entry. So
any in-flight DMA initiated from the old kernel can still pass and there
should be no error messages.

When you clear the root-entry that in-flight DMA might go to another
random location in system memory or just fail, no?


	Joerg
