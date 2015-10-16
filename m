From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:14.0
	address=0x000000fdf9103300 flags=0x0600]
Date: Fri, 16 Oct 2015 11:02:54 +0200
Message-ID: <20151016090254.GU27420@8bytes.org>
References: <CADw2B2Mzo2DbMMiyTVjBGVc4-f6Koa6sWQjoLmfX7NZ3B4+saA@mail.gmail.com>
	<20151014090649.GI27420@8bytes.org>
	<CADw2B2MzAMhNX5x9kZ5MN0mAh24ttDu=23EGVLy2aq6Paik4tQ@mail.gmail.com>
	<20151014163338.GR27420@8bytes.org>
	<CADw2B2MnBKOMvXOFNKo0-awM5oA7aYnEz0JgCqqOToVYYuzjZQ@mail.gmail.com>
	<CADw2B2N3VZdXVWTtotomZ2pZ3xb8ZEot=TR7j1gUq7-FM_R41w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADw2B2N3VZdXVWTtotomZ2pZ3xb8ZEot=TR7j1gUq7-FM_R41w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "G. Richard Bellamy" <rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 15, 2015 at 11:28:03PM -0700, G. Richard Bellamy wrote:
> Applied the patch, and no longer receiving the kernel error messages. Haven't
> tried to do anything with my VMs yet, but thought you'd want to know sooner
> than later.

Okay, thanks. It is possible that the issue only happens when you start
a VM, so it would be great if you could test this too.


Thanks,

	Joerg
