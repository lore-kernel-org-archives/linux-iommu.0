Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9128EB
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656079925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4yoKMHx8hwjlhiED35XD21wSiT8cy5Qt0nttKMguOFA=;
	b=c8nHUROhEKDTWTArVjucDTefGFE2VTQRvUh9quRpvn7UOsCKnz6FdMnBEL0eG4vDb7f8GB
	FvfsT5uX+mJcax0vGXRDwZHFKLCVColN9y4vWmM5qEWkHcZWLCmnOoMxI9KjMojL+RauVG
	gh5QwXWVUoA7EqyyZgyNM1qpYKopD90=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-ow0StBpfMtycfabVWYJmLw-1; Fri, 24 Jun 2022 10:12:02 -0400
X-MC-Unique: ow0StBpfMtycfabVWYJmLw-1
Received: by mail-il1-f197.google.com with SMTP id 3-20020a056e0220c300b002d3d7ebdfdeso1459323ilq.16
        for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 07:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=4yoKMHx8hwjlhiED35XD21wSiT8cy5Qt0nttKMguOFA=;
        b=jgOcqtjZTgUO8f1lk1VDD3b0zkWL4Pi2iD1C0Jlmit5dzm9e9pPMdAAPUZ4k67crIP
         wAcXtM4s9miZnIs21y6cUiL3DWZ/q4V2HGLv5xk1BaOk8UFOHgmIgkxOTOH7t/HTpuGj
         fr3GhDEJuTGBO7ylF0fimbdFnCh8hcr/AkHocjGxnC4lX0h0DTymVDgYQmZsk9cH9Z63
         ZuLe4maC2SiItRi3/1DkEBvOyUQU5/bsguf80numx44iEbi+BQmxjYzhOiUTlswpc3c+
         4IM6BsGSL3c+V7ing+wGSEe1TTiErfzP/VMKZFNRGy6bK/ybDoJc0mrFGLnTPnbTkS6/
         HWbw==
X-Gm-Message-State: AJIora8ezLeUXQP6pjfEkVeec/ALRIud8ynLwEJOsK518k70OsQAZsXZ
	3HsIYsNrTeTuJWbINRfp3MTkAwhka9nWhEJAgJquFpj8WdKMf+Wbq8J+vjfsdE8faUcH9F+gl51
	k0d6paea0rjp3C84=
X-Received: by 2002:a05:6e02:1a49:b0:2d9:500e:4a06 with SMTP id u9-20020a056e021a4900b002d9500e4a06mr5757822ilv.43.1656079921964;
        Fri, 24 Jun 2022 07:12:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1svZazEj69RanON2dp4ypTbHsA9NUh03zO72gJcjs8JfjOdXtOKKxzpMQNeXHU8+oJ9Wo4RqA==
X-Received: by 2002:a05:6e02:1a49:b0:2d9:500e:4a06 with SMTP id u9-20020a056e021a4900b002d9500e4a06mr5757804ilv.43.1656079921645;
        Fri, 24 Jun 2022 07:12:01 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t8-20020a5e9908000000b00674eedf7bbfsm1286144ioj.33.2022.06.24.07.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 07:12:00 -0700 (PDT)
Date: Fri, 24 Jun 2022 08:11:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, cohuck@redhat.com,
 iommu@lists.linux.dev, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220624081159.508baed3.alex.williamson@redhat.com>
In-Reply-To: <20220624015030.GJ4147@nvidia.com>
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
	<20220622161721.469fc9eb.alex.williamson@redhat.com>
	<68263bd7-4528-7acb-b11f-6b1c6c8c72ef@arm.com>
	<20220623170044.1757267d.alex.williamson@redhat.com>
	<20220624015030.GJ4147@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20220624141159.ETEldAyJlrNO4uLetX5Z-UYcH9o-x0wnf3-fCMwRoJ4@z>

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

