From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 0/9] vfio/mdev: IOMMU aware mediated device
Date: Fri, 15 Feb 2019 18:46:04 +0000
Message-ID: <20e89cb0-b7ab-d0d7-8630-29ff512a4ef0@arm.com>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
	<20190214131456.3db38cdb@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190214131456.3db38cdb-DGNDKt5SQtizQB+pC5nmwQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 14/02/2019 20:14, Alex Williamson wrote:
>> This patch series extends both IOMMU and vfio components to support
>> mdev device passing through when it could be isolated and protected
>> by the IOMMU units. The first part of this series (PATCH 1/09~6/09)
>> adds the interfaces and implementation of the multiple domains per
>> device. The second part (PATCH 7/09~9/09) adds the iommu device
>> attribute to each mdev, determines isolation type according to the
>> existence of an iommu device when attaching group in vfio type1 iommu
>> module, and attaches the domain to iommu aware mediated devices.
>> =

>> References:
>> [1] https://software.intel.com/en-us/download/intel-virtualization-techn=
ology-for-directed-io-architecture-specification
>> [2] https://software.intel.com/en-us/download/intel-scalable-io-virtuali=
zation-technical-specification
>> [3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
>> =

>> Best regards,
>> Lu Baolu
>> =

>> Change log:
>>=A0=A0 v5->v6:
> =

> This looks pretty reasonable with Jean-Philippe's nit fixups.=A0 Where do
> we go from here?=A0 I think we need an ack from Kirti since they have an
> interest here.=A0 Presumably this looks ok to the ARM folks.

Looks great from my point of view. I focused on patch 1 since I'm
planning to reuse iommu_dev_features for SVA. I don't have time to test
auxd and mdev on SMMUv3 at the moment but I had a better look and, if it
helps, for patches 1 and 7-9:

Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>

That said, are you planning to add back the mdev_get_iommu_domain()
function, in a separate patch? Because I think the parent driver still
needs a way to retrieve the PASID for an mdev?

Thanks,
Jean

> Do we have
> any consumers of this code yet?=A0 Theoretically I think a vfio-pci-like
> meta driver could be written as an mdev vendor driver with this support
> (restricted to type1 iommu use cases).=A0 Thanks,
> =

> Alex
