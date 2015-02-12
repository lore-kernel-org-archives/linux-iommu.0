From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Kernel Oops: iommu related?
Date: Thu, 12 Feb 2015 22:08:46 +0100
Message-ID: <20150212210846.GE29106@8bytes.org>
References: <54DCE8A6.4000608@compro.net> <20150212180846.GD29106@8bytes.org>
	<54DCF024.30309@compro.net> <54DD00FE.2050009@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54DD00FE.2050009-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
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

On Thu, Feb 12, 2015 at 02:37:34PM -0500, Mark Hounschell wrote:
> I've cleaned the machine of all our drivers and also the nvidia
> driver. If the problem is as you say, it is an in-kernel driver.
> I've attached a dmesg taken after it started. I used the dgap driver
> from the staging directory to unload and trigger this as I have one.
> That driver does NO dma. I know because I'm one of the maintainers
> and have done lots of work on it.

I have seen reports before with IOMMU problems and the NVidia driver.
Can you reproduce the problem without any out-of-tree stuff and without
staging modules ever loaded after boot? The Tainted flags in the warning
should be empty then.

> [  122.810648] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x000000000007a260 flags=0x0020]

This indicates that the driver for device 0f:00.0 (or something behind
it if it is a bridge) could be the problem.


	Joerg
