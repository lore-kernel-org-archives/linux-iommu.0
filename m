From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2 0/4] iommu/rockchip: Runtime PM fixes
Date: Fri, 24 Aug 2018 20:08:22 +0200
Message-ID: <13492452.cxnNOAAFxb@phil>
References: <20180824150637.15316-1-marc.zyngier@arm.com>
	<20180824155059.qskwdxmc6ws3hwtv@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180824155059.qskwdxmc6ws3hwtv@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Am Freitag, 24. August 2018, 17:50:59 CEST schrieb Olof Johansson:
> On Fri, Aug 24, 2018 at 04:06:33PM +0100, Marc Zyngier wrote:
> > This small series addresses a couple of runtime PM issues I've spotted
> > while running 4.18 on a Chromebook Plus (kevin, rk3399) platform, and
> > specifically doing kexec.
> > 
> > In order to avoid making a complete mess of the IOMMU code, Heiko has
> > requested that all RK platforms would select CONFIG_PM, which
> > simplifies a lot of things. I've kept 32 and 64bit patches separate,
> > but feel free to squash them into on if that's more convenient.
> > 
> > Note that even with these patches, kexec is still fairly broken on
> > rk3399, as the VOP is never turned off (see [1] for a fix).
> > 
> > [1] https://www.spinics.net/lists/arm-kernel/msg670229.html
> > 
> > * From v1:
> >   - Collected RBs from Heiko
> >   - Added two patches forcing CONFIG_PM on all Rockchip platforms at
> >     Heiko's request, following the example set by Tegra platforms.
> 
> Thanks, applied to our next/late branch which I plan to send in tomorrow.

that was a quick turn around :-) .
Thanks for picking the series.

Heiko
