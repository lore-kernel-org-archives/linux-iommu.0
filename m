Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E28C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 08:11:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1455560F02
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 08:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1455560F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4E4D81069;
	Mon, 11 Oct 2021 08:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dK-2J2SE8mtg; Mon, 11 Oct 2021 08:11:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F3A581066;
	Mon, 11 Oct 2021 08:11:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C4ECC0011;
	Mon, 11 Oct 2021 08:11:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9E4FC000D;
 Mon, 11 Oct 2021 08:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABCBE81066;
 Mon, 11 Oct 2021 08:11:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zD5wwgsLyjGt; Mon, 11 Oct 2021 08:11:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44FA381069;
 Mon, 11 Oct 2021 08:11:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C4431063;
 Mon, 11 Oct 2021 01:11:23 -0700 (PDT)
Received: from mail-pj1-f48.google.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4739F3F66F;
 Mon, 11 Oct 2021 01:11:23 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id
 na16-20020a17090b4c1000b0019f5bb661f9so12917707pjb.0; 
 Mon, 11 Oct 2021 01:11:23 -0700 (PDT)
X-Gm-Message-State: AOAM530D8Mpy2Lx/vTiLKbYLfjwFe8cUdCbtV9QKvOGm56iSRWS1V9+Q
 Fydx1bhKb4fcCsDCeHnrXvWUVzqj9ngktiqc4z8=
X-Google-Smtp-Source: ABdhPJxpgWkq2JXuhyC5cSUsG8YBYjnxKFd9JFYfb0AdYL4fS13p9K2CJ10dWF5pg4KXSn5b2Uhp22eVuQguQX4tG9g=
X-Received: by 2002:a17:90a:46c2:: with SMTP id
 x2mr29707698pjg.207.1633939878591; 
 Mon, 11 Oct 2021 01:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-4-vivek.gautam@arm.com>
 <YUoCTV6WYxxE10qj@myrica>
In-Reply-To: <YUoCTV6WYxxE10qj@myrica>
From: Vivek Gautam <vivek.gautam@arm.com>
Date: Mon, 11 Oct 2021 13:41:15 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEM7K8YOnQ4vSNoM+HuHQ-7pr=G3aui-77dGipyJ0+RjQ@mail.gmail.com>
Message-ID: <CAFp+6iEM7K8YOnQ4vSNoM+HuHQ-7pr=G3aui-77dGipyJ0+RjQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 03/11] iommu/virtio: Handle incoming page faults
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, mst@redhat.com,
 Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,


On Tue, Sep 21, 2021 at 9:33 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Fri, Apr 23, 2021 at 03:21:39PM +0530, Vivek Gautam wrote:
> > Redirect the incoming page faults to the registered fault handler
> > that can take the fault information such as, pasid, page request
> > group-id, address and pasid flags.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> > ---
> >  drivers/iommu/virtio-iommu.c      | 80 ++++++++++++++++++++++++++++++-
> >  include/uapi/linux/virtio_iommu.h |  1 +
> >  2 files changed, 80 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index c970f386f031..fd237cad1ce5 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -37,6 +37,13 @@
> >  /* Some architectures need an Address Space ID for each page table */
> >  DEFINE_XARRAY_ALLOC1(viommu_asid_xa);
> >
> > +struct viommu_dev_pri_work {
> > +     struct work_struct              work;
> > +     struct viommu_dev               *dev;
> > +     struct virtio_iommu_fault       *vfault;
> > +     u32                             endpoint;
> > +};
> > +
> >  struct viommu_dev {
> >       struct iommu_device             iommu;
> >       struct device                   *dev;
> > @@ -49,6 +56,8 @@ struct viommu_dev {
> >       struct list_head                requests;
> >       void                            *evts;
> >       struct list_head                endpoints;
> > +     struct workqueue_struct         *pri_wq;
> > +     struct viommu_dev_pri_work      *pri_work;
>
> IOPF already has a workqueue, so the driver doesn't need one.
> iommu_report_device_fault() should be fast enough to be called from the
> event handler.

Sure, will call iommu_report_device_fault() directly from
viommu_fault_handler().

>
> >
> >       /* Device configuration */
> >       struct iommu_domain_geometry    geometry;
> > @@ -666,6 +675,58 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
> >       return ret;
> >  }
> >
> > +static void viommu_handle_ppr(struct work_struct *work)
> > +{
> > +     struct viommu_dev_pri_work *pwork =
> > +                             container_of(work, struct viommu_dev_pri_work, work);
> > +     struct viommu_dev *viommu = pwork->dev;
> > +     struct virtio_iommu_fault *vfault = pwork->vfault;
> > +     struct viommu_endpoint *vdev;
> > +     struct viommu_ep_entry *ep;
> > +     struct iommu_fault_event fault_evt = {
> > +             .fault.type = IOMMU_FAULT_PAGE_REQ,
> > +     };
> > +     struct iommu_fault_page_request *prq = &fault_evt.fault.prm;
> > +
> > +     u32 flags       = le32_to_cpu(vfault->flags);
> > +     u32 prq_flags   = le32_to_cpu(vfault->pr_evt_flags);
> > +     u32 endpoint    = pwork->endpoint;
> > +
> > +     memset(prq, 0, sizeof(struct iommu_fault_page_request));
>
> The fault_evt struct is already initialized

Right, I will remove this line.

>
> > +     prq->addr = le64_to_cpu(vfault->address);
> > +
> > +     if (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_LAST_PAGE)
> > +             prq->flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> > +     if (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID) {
> > +             prq->flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > +             prq->pasid = le32_to_cpu(vfault->pasid);
> > +             prq->grpid = le32_to_cpu(vfault->grpid);
> > +     }
> > +
> > +     if (flags & VIRTIO_IOMMU_FAULT_F_READ)
> > +             prq->perm |= IOMMU_FAULT_PERM_READ;
> > +     if (flags & VIRTIO_IOMMU_FAULT_F_WRITE)
> > +             prq->perm |= IOMMU_FAULT_PERM_WRITE;
> > +     if (flags & VIRTIO_IOMMU_FAULT_F_EXEC)
> > +             prq->perm |= IOMMU_FAULT_PERM_EXEC;
> > +     if (flags & VIRTIO_IOMMU_FAULT_F_PRIV)
> > +             prq->perm |= IOMMU_FAULT_PERM_PRIV;
> > +
> > +     list_for_each_entry(ep, &viommu->endpoints, list) {
> > +             if (ep->eid == endpoint) {
> > +                     vdev = ep->vdev;

I have a question here though -
Is endpoint-ID unique across all the endpoints available per 'viommu_dev' or
per 'viommu_domain'?
If it is per 'viommu_domain' then the above list is also incorrect.
As you pointed to in the patch [1] -
[PATCH RFC v1 02/11] iommu/virtio: Maintain a list of endpoints served
by viommu_dev
I am planning to add endpoint ID into a static global xarray in
viommu_probe_device() as below:

        vdev_for_each_id(i, eid, vdev) {
                ret = xa_insert(&viommu_ep_ids, eid, vdev, GFP_KERNEL);
                if (ret)
                        goto err_free_dev;
        }

and replace the above list traversal as below:

                xa_lock_irqsave(&viommu_ep_ids, flags);
                xa_for_each(&viommu_ep_ids, eid, vdev) {
                        if (eid == endpoint) {
                                ret =
iommu_report_device_fault(vdev->dev, &fault_evt);
                                if (ret)
                                        dev_err(vdev->dev, "Couldn't
handle page request\n");
                        }
                }
                xa_unlock_irqrestore(&viommu_ep_ids, flags);

But using a global xarray would also be incorrect if the endpointsID are global
across 'viommu_domain'.

I need to find the correct 'viommu_endpoint' to call iommu_report_device_fault()
with the correct device.

> > +                     break;
> > +             }
> > +     }
> > +
> > +     if ((prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID) &&
> > +         (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_NEEDS_PASID))
> > +             prq->flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
> > +
> > +     if (iommu_report_device_fault(vdev->dev, &fault_evt))
> > +             dev_err(vdev->dev, "Couldn't handle page request\n");
>
> An error likely means that nobody registered a fault handler, but we could
> display a few more details about the fault that would help debug the
> endpoint

Sure, will add more debug info to this log.

>
> > +}
> > +
> >  static int viommu_fault_handler(struct viommu_dev *viommu,
> >                               struct virtio_iommu_fault *fault)
> >  {
> > @@ -679,7 +740,13 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
> >       u32 pasid       = le32_to_cpu(fault->pasid);
> >
> >       if (type == VIRTIO_IOMMU_FAULT_F_PAGE_REQ) {
> > -             dev_info(viommu->dev, "Page request fault - unhandled\n");
> > +             dev_info_ratelimited(viommu->dev,
> > +                                  "Page request fault from EP %u\n",
> > +                                  endpoint);
>
> That's rather for debugging the virtio-iommu driver, so should be
> dev_dbg() (or removed entirely)

I will remove this log.

>
> > +
> > +             viommu->pri_work->vfault = fault;
> > +             viommu->pri_work->endpoint = endpoint;
> > +             queue_work(viommu->pri_wq, &viommu->pri_work->work);
> >               return 0;
> >       }
> >
> > @@ -1683,6 +1750,17 @@ static int viommu_probe(struct virtio_device *vdev)
> >               goto err_free_vqs;
> >       }
> >
> > +     viommu->pri_work = kzalloc(sizeof(*viommu->pri_work), GFP_KERNEL);
> > +     if (!viommu->pri_work)
> > +             return -ENOMEM;
> > +
> > +     viommu->pri_work->dev = viommu;
> > +
> > +     INIT_WORK(&viommu->pri_work->work, viommu_handle_ppr);
> > +     viommu->pri_wq = create_singlethread_workqueue("viommu-pri-wq");
> > +     if (!viommu->pri_wq)
> > +             return -ENOMEM;
> > +
> >       viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
> >       viommu->last_domain = ~0U;
> >
> > diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> > index accc3318ce46..53aa88e6b077 100644
> > --- a/include/uapi/linux/virtio_iommu.h
> > +++ b/include/uapi/linux/virtio_iommu.h
> > @@ -302,6 +302,7 @@ struct virtio_iommu_req_invalidate {
> >  #define VIRTIO_IOMMU_FAULT_F_READ            (1 << 0)
> >  #define VIRTIO_IOMMU_FAULT_F_WRITE           (1 << 1)
> >  #define VIRTIO_IOMMU_FAULT_F_EXEC            (1 << 2)
> > +#define VIRTIO_IOMMU_FAULT_F_PRIV            (1 << 3)
>
> Should go in the previous patch. (I'd also prefer 'privileged' because in
> this context 'priv' is easily read as 'private')

Sure, will move this to the previous patch.

Thanks & regards
Vivek

[1] https://lore.kernel.org/all/YUoBW13+CvIljUgc@myrica/#t

[snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
