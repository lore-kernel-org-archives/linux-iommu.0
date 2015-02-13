From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Kernel Oops: iommu related?
Date: Fri, 13 Feb 2015 23:27:01 +0100
Message-ID: <20150213222701.GH29106@8bytes.org>
References: <54DCE8A6.4000608@compro.net> <20150212180846.GD29106@8bytes.org>
	<54DCF024.30309@compro.net> <54DD00FE.2050009@compro.net>
	<20150212211340.GF29106@8bytes.org> <54DE07DA.9050703@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54DE07DA.9050703-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 13, 2015 at 09:19:06AM -0500, Mark Hounschell wrote:
> OK. Attached.

Thanks, the IVRS table looks good. Device 0f.00.0 is listed there as the
alias target for a group of other devices:

> [    1.405719] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 0f:01.0 flags: 00 devid_to: 0f:00.0
> [    1.405722] AMD-Vi:   DEV_RANGE_END		 devid: 12:1f.7

> BTW when I blacklist the aic7xxx driver [last
> unloaded: aic7xxx] I can load and unload any module all  day long.

Okay, this driver seems to be the problem, it has a bug somewhere in
using the DMA-API. This causes the iommu problems.

The device it serves is behind the alias range for 0f:00.0, so any
faults from that device will show up as coming from 0f:00.0, like in the
io-page-faults you see in dmesg.


	Joerg
