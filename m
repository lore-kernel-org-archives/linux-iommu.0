From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH 2/2] iommu/amd: Destroy api_lock mutex when freeing domain
Date: Wed, 15 Jun 2016 13:54:07 +0200
Message-ID: <20160615115406.GF26566@8bytes.org>
References: <1463854264-26445-1-git-send-email-jan.vesely@rutgers.edu>
 <1463854264-26445-2-git-send-email-jan.vesely@rutgers.edu>
 <1465487321.7114.0.camel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465487321.7114.0.camel@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Vesely, Jan" <Jan.Vesely@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 09, 2016 at 03:48:44PM +0000, Vesely, Jan wrote:
> On Sat, 2016-05-21 at 14:11 -0400, Jan Vesely wrote:
> > From: Jan Vesely <jan.vesely@amd.com>
> >=20
> > Signed-off-by: Jan Vesely <jan.vesely@amd.com>
> > ---
> > =A0drivers/iommu/amd_iommu.c | 1 +
> > =A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index 17c76f2..4ff5e40 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -3016,6 +3016,7 @@ static void protection_domain_free(struct
> > protection_domain *domain)
> > =A0
> > =A0	del_domain_from_list(domain);
> > =A0
> > +	mutex_destroy(&domain->api_lock);
> > =A0	if (domain->id)
> > =A0		domain_id_free(domain->id);
> > =A0
>=20
> ping

Your patches lack commit messages, please add a more detailed
description of what you are fixing and why. Please also add 'Fixes:'
tags when resubmitting. The changes itself look good to me.


	Joerg
