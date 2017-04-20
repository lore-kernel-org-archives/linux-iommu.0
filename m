From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: make iommu_bus_notifier return NOTIFY_DONE rather
	than  error code
Date: Thu, 20 Apr 2017 16:43:44 +0200
Message-ID: <20170420144343.GB21305@8bytes.org>
References: <1492519908-65994-1-git-send-email-yuanzhichang@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1492519908-65994-1-git-send-email-yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: yankejian-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, huangdaode-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 18, 2017 at 08:51:48PM +0800, zhichang.yuan wrote:
> In iommu_bus_notifier(), when action is BUS_NOTIFY_ADD_DEVICE, it will return
> 'ops->add_device(dev)' directly. But ops->add_device will return ERR_VAL, such
> as -ENODEV. These value will make notifier_call_chain() not to traverse the
> remain nodes in struct notifier_block list.
> 
> This patch revises iommu_bus_notifier() to return NOTIFY_DONE when some errors
> heppened in ops->add_device().
> 
> Signed-off-by: zhichang.yuan <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>

Applied, thanks.
