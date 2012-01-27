From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/6] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Fri, 27 Jan 2012 09:08:44 +0200
Message-ID: <CAK=WgbbZB0hGRr84JV4a7c0KvW7VbVzsnCx1PGg=wjoB0OSrYw@mail.gmail.com>
References: <1327603257-17028-1-git-send-email-joerg.roedel@amd.com>
	<1327603257-17028-3-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1327603257-17028-3-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Thu, Jan 26, 2012 at 8:40 PM, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote:
> Implement the attribute itself and add the code for the
> AMD IOMMU driver.

It's somewhat non-intuitive to have the generic attribute code bundled
with the AMD implementation in the same patch (took me some time to
find it here :).

Maybe split this to two patches ?

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ef54718..3d0b0bf 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -345,10 +345,23 @@ EXPORT_SYMBOL_GPL(iommu_device_group);
> =A0int iommu_domain_get_attr(struct iommu_domain *domain,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum iommu_attr attr, =
void *data)
> =A0{
> - =A0 =A0 =A0 if (!domain->ops->domain_get_attr)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 struct iommu_domain_geometry *geometry;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 switch (attr) {
> + =A0 =A0 =A0 case DOMAIN_ATTR_GEOMETRY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 geometry =A0=3D data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *geometry =3D domain->geometry;

This is not type-safe and will surely bite someone some day.

Sure, we can't have type safety in a multi-purpose generic interface,
but I wonder whether this is the right interface for getting the
geometry ? I.e. why not have a dedicated API for this ?

Thanks,
Ohad.
