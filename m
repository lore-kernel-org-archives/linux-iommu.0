From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v8 11/14] iommu/rockchip: Use OF_IOMMU to attach devices
	automatically
Date: Mon, 26 Mar 2018 15:57:36 +0800
Message-ID: <5AB8A7F0.1090305@rock-chips.com>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
	<20180323073814.5802-12-jeffy.chen@rock-chips.com>
	<CAGS+omDUve9DTMJY8FdWBBxQgCOACLYLsRuzmQzd3Fh7TeekDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAGS+omDUve9DTMJY8FdWBBxQgCOACLYLsRuzmQzd3Fh7TeekDw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, open-Y9sIeH5OGRo@public.gmane.org, list-Y9sIeH5OGRo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Daniel,

Thanks for your reply.

On 03/26/2018 02:31 PM, Daniel Kurtz wrote:
>> >+struct rk_iommudata {
>> >+       struct rk_iommu *iommu;
>> >+};
> Why do we need this struct?  Can't we just assign a pointer to struct
> rk_iommu directly to dev->archdata.iommu?
>
hmmm, i was trying to add more device related data in patch[13]:

  struct rk_iommudata {
+	struct device_link *link; /* runtime PM link from IOMMU to master */
  	struct rk_iommu *iommu;
  };
>
