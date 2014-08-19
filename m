From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/vt-d : clear old root entry for dump kernel
Date: Tue, 19 Aug 2014 13:02:39 +0200
Message-ID: <20140819110239.GA16329@8bytes.org>
References: <1408352352-14449-1-git-send-email-zhen-hual@hp.com>
	<1267BB84A242B24E81E0C0C8955CFFC061A4BA26@G9W0343.americas.hpqcorp.net>
	<20140818232328.GK9809@8bytes.org>
	<1267BB84A242B24E81E0C0C8955CFFC061A4CA69@G9W0343.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1267BB84A242B24E81E0C0C8955CFFC061A4CA69-j39jTyOY9jISZAcGdq5asR6epYMZPwEe5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 18, 2014 at 11:27:01PM +0000, Li, Zhen-Hua wrote:
> : [fault reason 01] Present bit in root entry is clear
> It appears when iommu initializing in the kdump kernel.

Hmm, do you have an explanation how this can happen? From how I read the
code, the kdump kernel disables translation on the IOMMU, then sets a
new root entry, and then re-enabled translation. To me it looks like
there is no point in time where translation is enabled and the
root-entry is clear (present-bit==0).

But obviously I am missing something if you see the message above.

Btw, have you looked into this patch-set posted earlier this year:

	https://lkml.org/lkml/2014/4/24/836

It approaches the same problem-space, but also cares about in-flight
DMA.


	Joerg
