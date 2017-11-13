From: Bharat Kumar Gogada <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
Date: Mon, 13 Nov 2017 11:06:51 +0000
Message-ID: <SN1PR0201MB1518765CCEDD9B75119D6C63A52B0@SN1PR0201MB1518.namprd02.prod.outlook.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <BLUPR0201MB150538FDD455F6042803B54FA5560@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <16b6ba80-b15b-b278-0d06-350ae0201e82@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <16b6ba80-b15b-b278-0d06-350ae0201e82-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org" <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, gabriele.pao
List-Id: iommu@lists.linux-foundation.org

>       =20
> In this case even though hardware supports PASID, BIND flow fails.

It should fail, since we're reserving PASID 0 for non-PASID transactions wi=
th S1DSS=3D0b10. In addition, the SMMUv3 specification does not allow using=
 PASID with a single entry. See the description of S1CDMax in 5.2 Stream Ta=
ble Entry:

"when this field is 0, the substreams of the STE are disabled and one CD is=
 available. (The minimum useful number of substreams is 2.) Any transaction=
 with a SubstreamID will be terminated with an abort and a C_BAD_SUBSTREAMI=
D event recorded."

> Any reason why pasid allocation moved to idr allocations rather than=20
> bitmap allocations as in v1 patches ?

Yes, idr provides a convenient way to quickly retrieve the context associat=
ed with a PASID, when handling a fault. v1 had the allocation in a bitmap a=
nd storing in a rb-tree. By using an idr we combine both and rely on a well=
-tested infrastructure.

Note that in the future we might need to go back to handcrafting the PASID =
allocation, but it will probably still be based on idr.

Thanks for the clarification, Jean.=20
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
