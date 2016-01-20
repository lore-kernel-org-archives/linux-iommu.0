From: Huang Shijie <shijie.huang-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: add a shortcut when the @dev_node is NULL
Date: Wed, 20 Jan 2016 21:34:03 +0800
Message-ID: <20160120133401.GA3487@localhost.localdomain>
References: <1452564905-2662-1-git-send-email-shijie.huang@arm.com>
	<20160120120225.GD18805@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160120120225.GD18805-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, nd-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 20, 2016 at 01:02:25PM +0100, Joerg Roedel wrote:
> On Tue, Jan 12, 2016 at 10:15:05AM +0800, Huang Shijie wrote:
> > This patch adds a shortcut for the code when the @device_node is NULL.
> > In my juno-r1 board, the boot time can be faster by 0.004014s.
> 
> How have you made sure this number is reliable and not just noise in the
> boot process?
In the boot process, there are 5 or more modules whose @dev_node are
NULL. Without the patch, the kernel will waste some cycles to do the
meaningless calculations for all these modules. In theory, it is not noise.
If you have interest, I can send you the kernel boot logs. :)

Of course, the 0.004014s maybe not accurate enough, it is just an
approximate number.

Thanks
Huang Shijie
