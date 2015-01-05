From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iommu: Fix build of allmod/allyes config on ARMv8
	architecture
Date: Mon, 05 Jan 2015 12:09:03 +0100
Message-ID: <1420456143.31776.3.camel@AMDC1943>
References: <1417787257-10056-1-git-send-email-k.kozlowski@samsung.com>
	<20150105110347.GB19590@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20150105110347.GB19590-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On pon, 2015-01-05 at 12:03 +0100, Joerg Roedel wrote:
> On Fri, Dec 05, 2014 at 02:47:37PM +0100, Krzysztof Kozlowski wrote:
> >  drivers/iommu/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied to iommu/fixes, thanks.

Thanks, but... Few days after my patch Mark Brown posted something
similar:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310743.html

It was merged by Arnd Bergman and sent to Linus around 3.19-rc1. It is
merged in mainline now:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=20911ce6078fd1503dbf73f761316c66738bf83b

... so my patch can be dropped.

Best regards,
Krzysztof
