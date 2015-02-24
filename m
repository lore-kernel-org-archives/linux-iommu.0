From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 linux-next] iommu: Enable LPAE pagetable on ARM only
Date: Tue, 24 Feb 2015 02:02:57 +0200
Message-ID: <3203874.zEMjzr0PS0@avalon>
References: <2868840.GyWYJOzqWH@avalon>
	<1424735721-32313-1-git-send-email-vincent.stehle@laposte.net>
	<4372575.Lr7FssDpKu@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4372575.Lr7FssDpKu@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vincent =?ISO-8859-1?Q?Stehl=E9?= <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Vincent,

On Tuesday 24 February 2015 01:58:17 Laurent Pinchart wrote:
> On Tuesday 24 February 2015 00:55:21 Vincent Stehl=E9 wrote:
> > LPAE iommu page table makes sense only for ARM architecture. Add the
> > corresponding dependency in Kconfig (and enable for COMPILE_TEST, too, =
as
> > per Laurent's suggestion).
> > =

> > Signed-off-by: Vincent Stehl=E9 <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
> > Suggested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> =

> Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

And I of course spoke too soon :-/

> > ---
> > =

> > Changes since v1:
> > - Add condition on COMPILE_TEST
> > =

> >  drivers/iommu/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > =

> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index baa0d97..27cd88d 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -22,6 +22,7 @@ config IOMMU_IO_PGTABLE
> > =

> >  config IOMMU_IO_PGTABLE_LPAE
> >  	bool "ARMv7/v8 Long Descriptor Format"
> > +	depends on ARM || COMPILE_TEST

Shouldn't this be ARM || ARM64 || COMPILE_TEST ?

> >  	select IOMMU_IO_PGTABLE
> >  	help
> >  	  Enable support for the ARM long descriptor pagetable format.

-- =

Regards,

Laurent Pinchart
