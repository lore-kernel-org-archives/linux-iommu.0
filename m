Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4091C433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 14:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EEA284856;
	Fri, 24 Jun 2022 14:12:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2EEA284856
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hwyM5prn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QS_Qe_x9u37m; Fri, 24 Jun 2022 14:12:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0B0AC83ED6;
	Fri, 24 Jun 2022 14:12:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B0AC83ED6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C570BC0039;
	Fri, 24 Jun 2022 14:12:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CC84C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 14:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FB938482B
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 14:12:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FB938482B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TUfxOMYkrzhp for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 14:12:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF3A483ED6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF3A483ED6
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656079923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yoKMHx8hwjlhiED35XD21wSiT8cy5Qt0nttKMguOFA=;
 b=hwyM5prnJ4E98em7IHXzqONlzC/8R0e/mA1TaqlpKcWSL/AvO1zZ55ozhYAJ3JksQoak7y
 cWdAliwaa6dZJvjM+LXccWNr2KsxWqAp5BollZNXw8uAlfAzyhBehZ429u/OgDObhSo8nQ
 9VJDy0UVhYhARMg8xrf6MbvzBsZDTKg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-wWnQ4OkIPUOzdxHgjHZ21g-1; Fri, 24 Jun 2022 10:12:02 -0400
X-MC-Unique: wWnQ4OkIPUOzdxHgjHZ21g-1
Received: by mail-io1-f69.google.com with SMTP id
 f1-20020a056602070100b00674f8035487so1346739iox.17
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 07:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=4yoKMHx8hwjlhiED35XD21wSiT8cy5Qt0nttKMguOFA=;
 b=SIR3TR9pGFmormSVRT2nN99xvLopk3FVVRlZsK/P/nZ81/VEJTAOcA2dGtnp03eEEl
 x/g7j0+vfqk/JY69jgzMlQyilgGcDCm2q3El1yYyHkATxxvj1SqO+D7YmwfxnxNLL+cT
 8mT8cXMVCINA94ucynoXZBsdBNWvfngYr1bFlzHsWtAdnGObzUFMQe7shtyZb6kFOSVA
 2RGVZpEl2gpSpqNtaM2cAEYUonRdAUVAujMMAijf7+v1cFxFgrptVobaT1RZY9r+e2j6
 dXrekFmmTZlqcHhLB8v8X1t5RhEQR4MUb2Lu+jj4H3MtFia86pziu0JYLV3tzXCLJ2Dk
 MMvg==
X-Gm-Message-State: AJIora8aBmhSDpyuVm2lEGIngEBv9rizh/XLun80G/goAalhlI8ItBII
 cX/CA65ClDsN0q2nPAXH+4KwJRy2MIWAvThv+Cb7WeBsSuVEFAam87UIhvqA5zdmSZaO88i2hmv
 BN0hgFWHzk9v/FZvddQbcrl46uskf3w==
X-Received: by 2002:a05:6e02:1a49:b0:2d9:500e:4a06 with SMTP id
 u9-20020a056e021a4900b002d9500e4a06mr5757818ilv.43.1656079921961; 
 Fri, 24 Jun 2022 07:12:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1svZazEj69RanON2dp4ypTbHsA9NUh03zO72gJcjs8JfjOdXtOKKxzpMQNeXHU8+oJ9Wo4RqA==
X-Received: by 2002:a05:6e02:1a49:b0:2d9:500e:4a06 with SMTP id
 u9-20020a056e021a4900b002d9500e4a06mr5757804ilv.43.1656079921645; 
 Fri, 24 Jun 2022 07:12:01 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 t8-20020a5e9908000000b00674eedf7bbfsm1286144ioj.33.2022.06.24.07.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 07:12:00 -0700 (PDT)
Date: Fri, 24 Jun 2022 08:11:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220624081159.508baed3.alex.williamson@redhat.com>
In-Reply-To: <20220624015030.GJ4147@nvidia.com>
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
 <20220622161721.469fc9eb.alex.williamson@redhat.com>
 <68263bd7-4528-7acb-b11f-6b1c6c8c72ef@arm.com>
 <20220623170044.1757267d.alex.williamson@redhat.com>
 <20220624015030.GJ4147@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>
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

On Thu, 23 Jun 2022 22:50:30 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Jun 23, 2022 at 05:00:44PM -0600, Alex Williamson wrote:
> 
> > > >> +struct vfio_device *vfio_device_get_from_iommu(struct iommu_group *iommu_group)
> > > >> +{
> > > >> +	struct vfio_group *group = vfio_group_get_from_iommu(iommu_group);
> > > >> +	struct vfio_device *device;    
> > > > 
> > > > Check group for NULL.    
> > > 
> > > OK - FWIW in context this should only ever make sense to call with an 
> > > iommu_group which has already been derived from a vfio_group, and I did 
> > > initially consider a check with a WARN_ON(), but then decided that the 
> > > unguarded dereference would be a sufficiently strong message. No problem 
> > > with bringing that back to make it more defensive if that's what you prefer.  
> > 
> > A while down the road, that's a bit too much implicit knowledge of the
> > intent and single purpose of this function just to simply avoid a test.  
> 
> I think we should just pass the 'struct vfio_group *' into the
> attach_group op and have this API take that type in and forget the
> vfio_group_get_from_iommu().

That's essentially what I'm suggesting, the vfio_group is passed as an
opaque pointer which type1 can use for a
vfio_group_for_each_vfio_device() type call.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
