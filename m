From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 01/10] iommu: Introduce Shared Virtual Addressing API
Date: Wed, 26 Sep 2018 11:14:58 +0100
Message-ID: <60a8a257-a283-421a-13a1-097e29d302cb@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-2-jean-philippe.brucker@arm.com>
	<f406bcf7-4e54-9f1b-88eb-03fc642ffede@linux.intel.com>
	<20180925131647.rygncwik5uszsm3n@8bytes.org>
	<20180925154642.18a98849@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180925154642.18a98849@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 25/09/2018 23:46, Jacob Pan wrote:
> On Tue, 25 Sep 2018 15:16:47 +0200
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> =

>> On Sun, Sep 23, 2018 at 10:39:25AM +0800, Lu Baolu wrote:
>> > > +int iommu_sva_init_device(struct device *dev, unsigned long
>> > > features,
>> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int min_pasi=
d, unsigned int
>> > > max_pasid) +{
>> > > + int ret;
>> > > + struct iommu_sva_param *param;
>> > > + struct iommu_domain *domain =3D
>> > > iommu_get_domain_for_dev(dev);=A0 =

>> > =

>> > This doesn't work for vt-d. The domains for host iova are
>> > self-managed by vt-d driver itself. Hence,
>> > iommu_get_domain_for_dev() will always return NULL unless an
>> > UNMANAGED domain is attached to the device.
>> > =

>> > How about
>> > =

>> >=A0=A0=A0=A0=A0=A0 const struct iommu_ops *ops =3D dev->bus->iommu_ops;
>> > =

>> > instead?=A0 =

>> =

>> The per-bus iommu-ops might go away sooner or later as we move to
>> per-device iommu-ops. How about fixing the VT-d driver to not keep
>> that domain internal to itself?
>> =

> Just to understand more specifically, you mean let VT-d driver also
> support IOMMU_DOMAIN_DMA as default domain?
> =

> But I think the ordering issue is still there in that the DOMAIN_DMA
> domain will not be created until DMA map call is invoked. I think
> sva_init_device should not depend on the default domain.

Normally the default domain is created when the .add_device() IOMMU op
calls iommu_group_get_for_dev(). That should happen before the driver
probe, so before it can call sva_init_device()

Thanks,
Jean
