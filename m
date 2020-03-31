Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566CFC2D0E8
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 10:48:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19807208E4
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 10:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19807208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EB76286B12;
	Tue, 31 Mar 2020 10:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7g4QnIj7LLZN; Tue, 31 Mar 2020 10:48:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B279B86B26;
	Tue, 31 Mar 2020 10:48:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84872C1D7F;
	Tue, 31 Mar 2020 10:48:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 868CEC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 10:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 59D6D24C5E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 10:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N487Rqiq2Uu4 for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 10:48:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 06EF92010D
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 10:48:41 +0000 (UTC)
IronPort-SDR: 7J4iy/E3o/hjqmg6Kiqsc5+200TdwxPZyy+v8n8SNo0GPNY1pZSDv+q79tBIRwTv8AuaWSZW36
 UolUI1868+FA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 03:48:41 -0700
IronPort-SDR: /KxE8UaVN606pxVD82pMLbaBTRRjTyTVrnwsMDf2oRUpusKQ2fCmIBiu/rYtDf7mmYPvuWqPzq
 OXpLLRaayGGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="448624636"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga005.fm.intel.com with ESMTP; 31 Mar 2020 03:48:41 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 03:48:41 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 03:48:41 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 18:48:37 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Thread-Topic: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Thread-Index: AQHWAEUdcc1u01skwUmp6uBHREsZ66hh3P+AgACUz4A=
Date: Tue, 31 Mar 2020 10:48:36 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21ACC1@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
 <20200331075603.GB26583@infradead.org>
In-Reply-To: <20200331075603.GB26583@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Hi Hellwig,

Thanks for your review, Hellwig. :-) inline reply.

> From: Christoph Hellwig <hch@infradead.org>
> Sent: Tuesday, March 31, 2020 3:56 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
> 
> > @@ -2629,6 +2638,46 @@ static long vfio_iommu_type1_ioctl(void
> *iommu_data,
> >  		}
> >  		kfree(gbind_data);
> >  		return ret;
> > +	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {
> 
> Please refactor the spaghetti in this ioctl handler to use a switch statement and a
> helper function per command before growing it even more.

got it. I may get a separate refactor patch before adding my changes.

> 
> > +		/* Get the version of struct iommu_cache_invalidate_info */
> > +		if (copy_from_user(&version,
> > +			(void __user *) (arg + minsz), sizeof(version)))
> > +			return -EFAULT;
> > +
> > +		info_size = iommu_uapi_get_data_size(
> > +					IOMMU_UAPI_CACHE_INVAL, version);
> > +
> > +		cache_info = kzalloc(info_size, GFP_KERNEL);
> > +		if (!cache_info)
> > +			return -ENOMEM;
> > +
> > +		if (copy_from_user(cache_info,
> > +			(void __user *) (arg + minsz), info_size)) {
> 
> The user might have changed the version while you were allocating and
> freeing the
> memory, introducing potentially exploitable racing conditions.

yeah, I know the @version is not welcomed in the thread Jacob is driving.
I'll adjust the code here once the open in that thread has been solved.

But regardless of the version, I'm not sure if I 100% got your point.
Could you elaborate a bit? BTW. The code somehow referenced the code
below. The basic flow is copying partial data from __arg and then copy
the rest data after figuring out how much left. The difference betwen
below code and my code is just different way to figure out left data
size. Since I'm not sure if I got your point. If the racing is true in
such flow, I guess there are quite a few places need to enhance.

vfio_pci_ioctl(){
{
...
        } else if (cmd == VFIO_DEVICE_SET_IRQS) {
                struct vfio_irq_set hdr;
                u8 *data = NULL;
                int max, ret = 0;
                size_t data_size = 0;

                minsz = offsetofend(struct vfio_irq_set, count);

                if (copy_from_user(&hdr, (void __user *)arg, minsz))
                        return -EFAULT;

                max = vfio_pci_get_irq_count(vdev, hdr.index);

                ret = vfio_set_irqs_validate_and_prepare(&hdr, max,
                                                 VFIO_PCI_NUM_IRQS, &data_size);
                if (ret)
                        return ret;

                if (data_size) {
                        data = memdup_user((void __user *)(arg + minsz),
                                            data_size);
                        if (IS_ERR(data))
                                return PTR_ERR(data);
                }

                mutex_lock(&vdev->igate);

                ret = vfio_pci_set_irqs_ioctl(vdev, hdr.flags, hdr.index,
                                              hdr.start, hdr.count, data);

                mutex_unlock(&vdev->igate);
                kfree(data);

                return ret;

        } else if (cmd == VFIO_DEVICE_RESET) {
...
}

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
