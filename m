Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEEE3D92
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 04:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692159949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip39erQL05vM1EfoUzr0gxFHM5VqQHryueh/4GpGeoc=;
	b=TnV0arEm5+wBHJQWpADk4sa7Ge6mwSAS11Qka4LRBy2dnv0syUbrpj80cQpJ32sB5knIHm
	zqAq41BUdqJPyGAK2wG4M3np459WrrLIPDfawx9qv7ukCQ4YdaqTyEC+fzzIFDWTMZtBPc
	Ay+dz/xCsxOhBbM+gSXPbp+ZT6wS0Ok=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-NftykmbAMTemnkykzy8BLA-1; Wed, 16 Aug 2023 00:25:45 -0400
X-MC-Unique: NftykmbAMTemnkykzy8BLA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76d35f344b0so667162185a.0
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 21:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692159945; x=1692764745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip39erQL05vM1EfoUzr0gxFHM5VqQHryueh/4GpGeoc=;
        b=YvWMhRCKO9mxkox4lievnsS5w+I3jAWd8aych2Jb6urn15A30S4FwQKH+O5ASb9Ij8
         xpKiHAqx6JESj085N1Ou/Otwt9vC86ll5/eunlxLoKZvlA5n+Fy3j4Ea1oVxjPp3jkNo
         I9kFhC8s7LH/+weRAvcia5d+udCT6h+EZXJtxZpu4xZntJiMM8odTxyEhQ177K0IaKqN
         rBQjUDYvhGvkWMK2lfeUfDOP2/LT/lsJVkdx3unLvqVaiea05uEs+yKdgBBhKWzM6MnC
         fO9iit4XIa9BD7nAtW4ofKs2FGdDM68dsc/K/uXItq+malmRC3Km5ICjEKiUsubhqleH
         zNZw==
X-Gm-Message-State: AOJu0YyTFB3tpNoR+ld6A5/YpZvL2koWBGqF3yMrtlJUOYthqOVBQJCm
	vXl1gMsfpoQYMSFHhRe0/2EpfcOxuSlX31ak9WICC2PvVU/YHU4rBgb7itBKZHIUFj6tRxSSuyQ
	IjrqnFFsYzgsHzMc=
X-Received: by 2002:a05:620a:bc8:b0:76c:de57:7b61 with SMTP id s8-20020a05620a0bc800b0076cde577b61mr973673qki.25.1692159945123;
        Tue, 15 Aug 2023 21:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGr6aYlrh82DZ/hL7UsMEar2vLjwlrqUpt6dQpM33QY1109L6Qr9W32PzkRFKCPIldoiLtsQ==
X-Received: by 2002:a05:620a:bc8:b0:76c:de57:7b61 with SMTP id s8-20020a05620a0bc800b0076cde577b61mr973650qki.25.1692159944853;
        Tue, 15 Aug 2023 21:25:44 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id oq15-20020a05620a610f00b0076d4bb714afsm2579213qkn.50.2023.08.15.21.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 21:25:44 -0700 (PDT)
Date: Tue, 15 Aug 2023 21:25:42 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, john.g.garry@oracle.com, 
	joro@8bytes.org
Subject: Re: [PATCH 2/2] iommu/iova: Manage the depot list size
Message-ID: <2eq236vycub7mrxlxos2dnbzgqptkeclbprsh6rsml64eoapdx@xumsokaj6rfy>
References: <cover.1692033783.git.robin.murphy@arm.com>
 <abc5a322584f5c8a44f7a0a7f709899053c5df01.1692033783.git.robin.murphy@arm.com>
 <70e7dcc8-819f-d957-f43c-75b7818a3a96@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <70e7dcc8-819f-d957-f43c-75b7818a3a96@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Aug 15, 2023 at 10:11:51PM +0800, zhangzekun (A) wrote:
> 
> 
> 在 2023/8/15 1:53, Robin Murphy 写道:
> > Automatically scaling the depot up to suit the peak capacity of a
> > workload is all well and good, but it would be nice to have a way to
> > scale it back down again if the workload changes. To that end, add
> > automatic reclaim that will gradually free unused magazines if the
> > depot size remains above a reasonable threshold for long enough.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >   drivers/iommu/iova.c | 29 +++++++++++++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index d2de6fb0e9f4..76a7d694708e 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/smp.h>
> >   #include <linux/bitops.h>
> >   #include <linux/cpu.h>
> > +#include <linux/workqueue.h>
> >   /* The anchor node sits above the top of the usable address space */
> >   #define IOVA_ANCHOR	~0UL
> > @@ -626,6 +627,8 @@ EXPORT_SYMBOL_GPL(reserve_iova);
> >    */
> >   #define IOVA_MAG_SIZE 127
> > +#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
> > +
> >   struct iova_magazine {
> >   	/*
> >   	 * Only full magazines are inserted into the depot, so we can avoid
> > @@ -646,8 +649,11 @@ struct iova_cpu_rcache {
> >   struct iova_rcache {
> >   	spinlock_t lock;
> > +	unsigned int depot_size;
> >   	struct iova_magazine *depot;
> >   	struct iova_cpu_rcache __percpu *cpu_rcaches;
> > +	struct iova_domain *iovad;
> > +	struct delayed_work work;
> >   };
> >   static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
> > @@ -728,6 +734,7 @@ static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
> >   	rcache->depot = mag->next;
> >   	mag->size = IOVA_MAG_SIZE;
> > +	rcache->depot_size--;
> >   	return mag;
> >   }
> > @@ -735,6 +742,24 @@ static void iova_depot_push(struct iova_rcache *rcache, struct iova_magazine *ma
> >   {
> >   	mag->next = rcache->depot;
> >   	rcache->depot = mag;
> > +	rcache->depot_size++;
> > +}
> > +
> > +static void iova_depot_work_func(struct work_struct *work)
> > +{
> > +	struct iova_rcache *rcache = container_of(work, typeof(*rcache), work.work);
> > +	struct iova_magazine *mag = NULL;
> > +
> > +	spin_lock(&rcache->lock);
> > +	if (rcache->depot_size > num_online_cpus())
> > +		mag = iova_depot_pop(rcache);
> > +	spin_unlock(&rcache->lock);
> > +
> > +	if (mag) {
> > +		iova_magazine_free_pfns(mag, rcache->iovad);
> > +		iova_magazine_free(mag);
> > +		schedule_delayed_work(&rcache->work, msecs_to_jiffies(IOVA_DEPOT_DELAY));
> Hi, Robin,
> 
> I am a little confused why IOVA_DEPOT_DELAY need to be calculated twice in
> iova_depot_work_func(), as it already equals to "msecs_to_jiffies(100)".

I think it was a typo, and is meant to be IOVA_DEPOT_DELAY like it is in
__iova_rcache_insert.

Regards,
Jerry

> Besides, do we really need to invoke a delayed_work in
> iova_depot_work_func()? As each time we put a iova magazine to depot, a
> delayed_work will be invoked which is reponsible to free a iova magazine in
> depot if the depot size is greater than num_online_cpus().
> 
> Thanks,
> Zekun

