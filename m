Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF63C433FE
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 16:03:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF5861168
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 16:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BF5861168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5446F83529;
	Tue, 21 Sep 2021 16:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kzwEDmRP_gYA; Tue, 21 Sep 2021 16:03:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 082CA83506;
	Tue, 21 Sep 2021 16:03:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BE35C0020;
	Tue, 21 Sep 2021 16:03:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AEDDC000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 16:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED2EB403F5
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 16:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tN3MWOhRKf9m for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:03:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8F3C403F3
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 16:03:49 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id t7so7513396wrw.13
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=c9ydbvY8sDfCdxG0I7FnWgHTf3YXOLh553u7tDIhY7Q=;
 b=hOu9oqEpgRma4m5TwajhAd5E/ajA0+oK5Wilrodt3LT7oGNBQVS/alGR9wd4Vflv/v
 Jxp4GyJh+p4DoX7CDkqq4P9vJ/4OO/DUQQqOTCLQXw/iaOKndL3YBFu74cReCsa3WB85
 h2zl/fVWmaAyNvuPTxYcKdDgXat04zMpqmEvVr2eDR3XgdWLCKrz9ALQAw7Ae0CWv5Cf
 E82i7jMw1EoTdPtwkwPy85ocWzQsCVLxR6CLmAer6depp97ulfIRcVODaNsWq17W94tc
 8NTYrtEnImcl7CE8pLca0kYtxR0e6N6JjBfCnoBDqY57l9J6Z4XR9y/xi9jkDVCIFsUd
 8RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=c9ydbvY8sDfCdxG0I7FnWgHTf3YXOLh553u7tDIhY7Q=;
 b=1BC8+g6tyR+xE4sxQYBa/DI3ESwGX0qdF2DSzWJldIAQP7jWtuL11IfeZJ4dVYyfwN
 CM0JDSfqVzwG8tgOy5bd2X9oMUOH2S8NQNiMnpChL52/3EFG3HnlOC7/49Ec/M+Oy1fG
 qxbGVKHMgyGDLFmYRRxkC2JXgRmhWIWPXg4OEkN5RefCH+abPl89WtkEUbHKZDH3qo27
 0V2gSXBQP0OPKluyQRWKn95/ZDJrqHGQsWq0+FpxLxWjfW1ueVw+IBK2Q3BQ7VaFmkLY
 O9d/oW/gUlVgVqO241F18WYohc6yBGWQk8ReU33t3oaBoDTn5vtE9Ynn3BfApRSYSHDt
 uR8A==
X-Gm-Message-State: AOAM531LqHQiTmpQnpnjL69Id/K8yystRmy9/TX73w3t0A1e2K2rk/il
 hGgnyIn703T8dTj8faVRD1PXNg==
X-Google-Smtp-Source: ABdhPJzogdRHMobW1EV7gNAcIgxeJ8ugHZsaEOBpNSPLnWVSDi+WSM6RWXiAksaaRnOXJnSOuAd9Ug==
X-Received: by 2002:a05:600c:3209:: with SMTP id
 r9mr5445839wmp.35.1632240227704; 
 Tue, 21 Sep 2021 09:03:47 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id j20sm19907636wrb.5.2021.09.21.09.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 09:03:46 -0700 (PDT)
Date: Tue, 21 Sep 2021 17:03:25 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 03/11] iommu/virtio: Handle incoming page faults
Message-ID: <YUoCTV6WYxxE10qj@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-4-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-4-vivek.gautam@arm.com>
X-TUID: xnj50RSTlhls
Cc: kevin.tian@intel.com, mst@redhat.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Apr 23, 2021 at 03:21:39PM +0530, Vivek Gautam wrote:
> Redirect the incoming page faults to the registered fault handler
> that can take the fault information such as, pasid, page request
> group-id, address and pasid flags.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  drivers/iommu/virtio-iommu.c      | 80 ++++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_iommu.h |  1 +
>  2 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index c970f386f031..fd237cad1ce5 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -37,6 +37,13 @@
>  /* Some architectures need an Address Space ID for each page table */
>  DEFINE_XARRAY_ALLOC1(viommu_asid_xa);
>  
> +struct viommu_dev_pri_work {
> +	struct work_struct		work;
> +	struct viommu_dev		*dev;
> +	struct virtio_iommu_fault	*vfault;
> +	u32				endpoint;
> +};
> +
>  struct viommu_dev {
>  	struct iommu_device		iommu;
>  	struct device			*dev;
> @@ -49,6 +56,8 @@ struct viommu_dev {
>  	struct list_head		requests;
>  	void				*evts;
>  	struct list_head		endpoints;
> +	struct workqueue_struct		*pri_wq;
> +	struct viommu_dev_pri_work	*pri_work;

IOPF already has a workqueue, so the driver doesn't need one.
iommu_report_device_fault() should be fast enough to be called from the
event handler.

>  
>  	/* Device configuration */
>  	struct iommu_domain_geometry	geometry;
> @@ -666,6 +675,58 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  	return ret;
>  }
>  
> +static void viommu_handle_ppr(struct work_struct *work)
> +{
> +	struct viommu_dev_pri_work *pwork =
> +				container_of(work, struct viommu_dev_pri_work, work);
> +	struct viommu_dev *viommu = pwork->dev;
> +	struct virtio_iommu_fault *vfault = pwork->vfault;
> +	struct viommu_endpoint *vdev;
> +	struct viommu_ep_entry *ep;
> +	struct iommu_fault_event fault_evt = {
> +		.fault.type = IOMMU_FAULT_PAGE_REQ,
> +	};
> +	struct iommu_fault_page_request *prq = &fault_evt.fault.prm;
> +
> +	u32 flags	= le32_to_cpu(vfault->flags);
> +	u32 prq_flags	= le32_to_cpu(vfault->pr_evt_flags);
> +	u32 endpoint	= pwork->endpoint;
> +
> +	memset(prq, 0, sizeof(struct iommu_fault_page_request));

The fault_evt struct is already initialized

> +	prq->addr = le64_to_cpu(vfault->address);
> +
> +	if (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_LAST_PAGE)
> +		prq->flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +	if (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID) {
> +		prq->flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> +		prq->pasid = le32_to_cpu(vfault->pasid);
> +		prq->grpid = le32_to_cpu(vfault->grpid);
> +	}
> +
> +	if (flags & VIRTIO_IOMMU_FAULT_F_READ)
> +		prq->perm |= IOMMU_FAULT_PERM_READ;
> +	if (flags & VIRTIO_IOMMU_FAULT_F_WRITE)
> +		prq->perm |= IOMMU_FAULT_PERM_WRITE;
> +	if (flags & VIRTIO_IOMMU_FAULT_F_EXEC)
> +		prq->perm |= IOMMU_FAULT_PERM_EXEC;
> +	if (flags & VIRTIO_IOMMU_FAULT_F_PRIV)
> +		prq->perm |= IOMMU_FAULT_PERM_PRIV;
> +
> +	list_for_each_entry(ep, &viommu->endpoints, list) {
> +		if (ep->eid == endpoint) {
> +			vdev = ep->vdev;
> +			break;
> +		}
> +	}
> +
> +	if ((prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID) &&
> +	    (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_NEEDS_PASID))
> +		prq->flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
> +
> +	if (iommu_report_device_fault(vdev->dev, &fault_evt))
> +		dev_err(vdev->dev, "Couldn't handle page request\n");

An error likely means that nobody registered a fault handler, but we could
display a few more details about the fault that would help debug the
endpoint

> +}
> +
>  static int viommu_fault_handler(struct viommu_dev *viommu,
>  				struct virtio_iommu_fault *fault)
>  {
> @@ -679,7 +740,13 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
>  	u32 pasid	= le32_to_cpu(fault->pasid);
>  
>  	if (type == VIRTIO_IOMMU_FAULT_F_PAGE_REQ) {
> -		dev_info(viommu->dev, "Page request fault - unhandled\n");
> +		dev_info_ratelimited(viommu->dev,
> +				     "Page request fault from EP %u\n",
> +				     endpoint);

That's rather for debugging the virtio-iommu driver, so should be
dev_dbg() (or removed entirely)

> +
> +		viommu->pri_work->vfault = fault;
> +		viommu->pri_work->endpoint = endpoint;
> +		queue_work(viommu->pri_wq, &viommu->pri_work->work);
>  		return 0;
>  	}
>  
> @@ -1683,6 +1750,17 @@ static int viommu_probe(struct virtio_device *vdev)
>  		goto err_free_vqs;
>  	}
>  
> +	viommu->pri_work = kzalloc(sizeof(*viommu->pri_work), GFP_KERNEL);
> +	if (!viommu->pri_work)
> +		return -ENOMEM;
> +
> +	viommu->pri_work->dev = viommu;
> +
> +	INIT_WORK(&viommu->pri_work->work, viommu_handle_ppr);
> +	viommu->pri_wq = create_singlethread_workqueue("viommu-pri-wq");
> +	if (!viommu->pri_wq)
> +		return -ENOMEM;
> +
>  	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
>  	viommu->last_domain = ~0U;
>  
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index accc3318ce46..53aa88e6b077 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -302,6 +302,7 @@ struct virtio_iommu_req_invalidate {
>  #define VIRTIO_IOMMU_FAULT_F_READ		(1 << 0)
>  #define VIRTIO_IOMMU_FAULT_F_WRITE		(1 << 1)
>  #define VIRTIO_IOMMU_FAULT_F_EXEC		(1 << 2)
> +#define VIRTIO_IOMMU_FAULT_F_PRIV		(1 << 3)

Should go in the previous patch. (I'd also prefer 'privileged' because in
this context 'priv' is easily read as 'private')

Thanks,
Jean

>  #define VIRTIO_IOMMU_FAULT_F_ADDRESS		(1 << 8)
>  
>  #define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
