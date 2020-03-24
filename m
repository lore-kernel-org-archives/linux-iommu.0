Return-Path: <SRS0=P7ka=5J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F7C10DCE
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 06:48:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616FB20719
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 06:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtNjrGJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616FB20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3BA57864D0;
	Tue, 24 Mar 2020 06:48:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zy9iG8Q4bzeF; Tue, 24 Mar 2020 06:48:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C097886008;
	Tue, 24 Mar 2020 06:48:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8459C1D7C;
	Tue, 24 Mar 2020 06:48:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 603CAC0177
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 06:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A5A02271F
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 06:48:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zDLZBkAR1J+D for <iommu@lists.linux-foundation.org>;
 Tue, 24 Mar 2020 06:48:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 361992041B
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 06:48:21 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id r7so1729510wmg.0
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 23:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pM79P8WLUvqTpjnBcVWxWm+du1cmnhFRqw1TS0kYTjU=;
 b=vtNjrGJ2nV7JntUhJh8mAha08p5hAxg0iZENC9BJ9ptrRCuc8l4oq4IKDFx3Ther+N
 8MDSzEgcpcUmDg2jLaoCaAZ4xMhLRsnqaXQbv6UMyIEgpuRzVGlF9c3NnkpPaz1jVHoo
 bPCLpN+aZbpT/1POqokaFP6aHNZmryOkvDp/mAHGztxhYgethYpzWfs4/xfgr52JHNO9
 CFFBSxKCw8IG//RB6MWn7Jd9XiyVvcYAqBIpiulsJkn/DochfYKLzDHCHCyyQvCX8mYs
 HsmoCZJDBLvICAdpAZOoGnic+yf9JoMkjBhb0Fq7QFPgUD25YAGV4cFWbALW7glduuL4
 +LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pM79P8WLUvqTpjnBcVWxWm+du1cmnhFRqw1TS0kYTjU=;
 b=WuNhqsRsqDxDE5+SQZhBxbs8kgfu692KxiTfli8OtNLq9qADy4+1I3t+u2tT9/r5Ip
 TqPdArzrm45m8F5vmFXS4/x3z6zfvzMQAf7CyAJ4RcuLpEQC7ujmqjq7tXDlleIn8ivu
 oXlfY2tPdS6Y7wmAu+QGhkKXZjtFE+gPOw7W3kI0gyoklZnQs4rVXj9QSJGkU5gg5UMx
 iqxC0vglyjYiskVoxXl9fi73UL1X6SowGNINrcEDaAz97ks0BJ1N7n+ffoZI8pFVka6J
 88EqTNMtfdsOT11eiIiEibWrmq4v7Vpb0Oac/q+Bqk/TWMJGGyJ6GrGm848UeDXBnX/B
 sIdQ==
X-Gm-Message-State: ANhLgQ07X6wMS6KI32csGm0hG6mIE/moWjwp03UKZ+jTmdNX5M0kBEnW
 GccZ1SfnjmEMlkJWdrabEbqs1Q==
X-Google-Smtp-Source: ADFU+vvXbZf7pds9tOsbx7NvWduS1GM+4eKvdA5SFYqYs8l7wPtutVQWw/JqWZa6EfWb8l/nwFtC+g==
X-Received: by 2002:a1c:4e0f:: with SMTP id g15mr3817814wmh.163.1585032499527; 
 Mon, 23 Mar 2020 23:48:19 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y5sm2905739wmi.34.2020.03.23.23.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 23:48:18 -0700 (PDT)
Date: Tue, 24 Mar 2020 07:48:11 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [EXT] Re: [PATCH RFC] iommu/virtio: Use page size bitmap
 supported by endpoint
Message-ID: <20200324064811.GA2173442@myrica>
References: <20200323084108.1721-1-bbhushan2@marvell.com>
 <20200323095943.GA2038940@myrica>
 <MWHPR1801MB1966865A8DE5AB8FFFAEC85FE3F00@MWHPR1801MB1966.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB1966865A8DE5AB8FFFAEC85FE3F00@MWHPR1801MB1966.namprd18.prod.outlook.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>
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

On Mon, Mar 23, 2020 at 06:04:37PM +0000, Bharat Bhushan wrote:
> > > -static int viommu_domain_finalise(struct viommu_dev *viommu,
> > > +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> > >  				  struct iommu_domain *domain)
> > >  {
> > >  	int ret;
> > >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > > +	struct viommu_dev *viommu = vdev->viommu;
> > >
> > >  	vdomain->viommu		= viommu;
> > >  	vdomain->map_flags	= viommu->map_flags;
> > >
> > > -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > > +	if (vdev->pgsize_bitmap)
> > > +		domain->pgsize_bitmap = vdev->pgsize_bitmap;
> > > +	else
> > > +		domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > > +
> > 
> > nit: it could be nicer to initialize vdev->pgsize_bitmap in add_device(),
> 
> To what size we should initialize in add_device, PAGE_SIZE?

No to viommu->pgsize_bitmap

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
