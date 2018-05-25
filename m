From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 05/17] media: rkisp1: add Rockchip ISP1 subdev driver
Date: Fri, 25 May 2018 13:35:45 +0900
Message-ID: <CAAFQd5B8DbnmmkKRb-2M7PFHDAKRFOA1Bnk-si_AZLjfzXOgPg@mail.gmail.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
	<20180308094807.9443-6-jacob-chen@iotwrt.com>
	<20180503090909.o3dyhukzs2y7em5z@tarshish>
	<CAAFQd5CvBv4hkE=PSHBJTYa9Lj0SyggxpMBEAYD=if0=T0uzHw@mail.gmail.com>
	<20180507063814.vweb4p3nfgnoc3td@tarshish>
	<CAAFQd5A7gAK4fXH9YVrobR5_QX_5f8xa272R_56v5YUghV6Sxw@mail.gmail.com>
	<20180524113012.mt5b2f2vrhfrn3d7@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180524113012.mt5b2f2vrhfrn3d7@tarshish>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eddie Cai <eddie.cai.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?6ZmI5Z+O?= <cc-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?B?6ZKf5Lul5bSH?= <zyc-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jacob Chen <jacob-chen-fyOeoxGR3m/QT0dZR+AlfA@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Allon Huang <allon.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, May 24, 2018 at 8:30 PM Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:

> Hi Tomasz,

> On Mon, May 07, 2018 at 06:41:50AM +0000, Tomasz Figa wrote:
> > On Mon, May 7, 2018 at 3:38 PM Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> > > On Mon, May 07, 2018 at 06:13:27AM +0000, Tomasz Figa wrote:
> > > > On Thu, May 3, 2018 at 6:09 PM Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
wrote:
> > > > > On Thu, Mar 08, 2018 at 05:47:55PM +0800, Jacob Chen wrote:
> > > > > > +static int rkisp1_isp_sd_s_power(struct v4l2_subdev *sd, int
on)
> > > > > > +{
> > > > > > +     struct rkisp1_device *isp_dev = sd_to_isp_dev(sd);
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     v4l2_dbg(1, rkisp1_debug, &isp_dev->v4l2_dev, "s_power:
%d\n",
> > > > on);
> > > > > > +
> > > > > > +     if (on) {
> > > > > > +             ret = pm_runtime_get_sync(isp_dev->dev);
> > > > > > +             if (ret < 0)
> > > > > > +                     return ret;
> > > > > > +
> > > > > > +             rkisp1_config_clk(isp_dev);
> > > > > > +     } else {
> > > > > > +             ret = pm_runtime_put(isp_dev->dev);
> > > >
> > > > > I commented this line out to make more than one STREAMON work.
> > Otherwise,
> > > > > the second STREAMON hangs. I guess the bug is not this driver.
> > Probably
> > > > > something in drivers/soc/rockchip/pm_domains.c. Just noting that
in
> > case
> > > > > you or someone on Cc would like to investigate it further.
> > > > >
> > > > > I tested v4.16-rc4 on the Tinkerboard.
> > > >
> > > > Looks like that version doesn't include the IOMMU PM and clock
handling
> > > > rework [1], which should fix a lot of runtime PM issues. FWIW,
> > linux-next
> > > > seems to already include it.
> > > >
> > > > [1] https://lkml.org/lkml/2018/3/23/44
> >
> > > Thanks for the reference.
> >
> > > It looks like the iommu driver part is in Linus' tree already. The DT
> > part is
> > > in the v4.18-armsoc/dts32 branch of Heiko's tree. Am I missing
anything?
> >
> > You're right, most of the series made it in time for 4.17. However, the
DT
> > part (precisely, the clocks properties added to IOMMU nodes) is crucial
for
> > the fixes to be effective.
> >
> > > Anyway, I'll take a look.
> >
> > Thanks for testing. :) (Forgot to mention in my previous email...)

> I finally got around to testing. Unfortunately, kernel v4.17-rc6 with
> cherry-pick of commit c78751f91c0b (ARM: dts: rockchip: add clocks in
iommu
> nodes) from Heiko's tree still exhibit the same problem. STREAMON hangs on
> second try. The same workaround "fixes" it.

Thanks for testing. I'm out of ideas, since the same code seems to work
fine for us in Chrome OS 4.4 kernel. Maybe we could have someone from RK
take a look.

Best regards,
Tomasz
