Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FF1C7618B
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 14:05:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7036D216B7
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 14:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aw5WQtbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7036D216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3043EDA4;
	Fri, 26 Jul 2019 14:05:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 016A2CDE
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 14:05:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B32A98A3
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 14:04:59 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id k8so53367072eds.7
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=h4O4z+O+RC1JwnWktDyaiJMFv2NH81YwETYIA8cC4R4=;
	b=aw5WQtbsqLZ0f8nctZ02nXZA/NLGPbLx7lFP0F/tGyj5eow+za6vJHr/9xIVsd7jnU
	ICYACBFD9ozBMsUnq5wBnpaA1P5MkvkEaMvwi/UUfWLl/NLvdQdq4mOOsEUKDqD1+dzu
	FW4cq5+prK2G5oYhDDqTLWI43JgEgs9ZbmDCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=h4O4z+O+RC1JwnWktDyaiJMFv2NH81YwETYIA8cC4R4=;
	b=CYBL7CXghfoTeu9lkD/BrQMN9f+eCxS7nUBD5fvk/n9xQbAdv4f5giK+zsYGmyVe5t
	E+bi6nlQaa2iY5NYp5X1ebtskvG9V17oMeiryu9w3cd3PYe9AOGxEpu5sKR2agW2Wqe3
	xJUW/vh82xnqZrI+EOV8ORSDxKyKykW4+WY0nYtI+bzqz+9e63B9NUkVld89ybcoX8Z8
	B1pcx91XbsWgghaHsj0Z1VMXiSGxi6w/f78b3Wyf7XQXcQxFGaikah1O8mkC80KLzB6M
	x2TS15i30tzbaKTjDoDOw3eZTIC4GseP11Y0rZ8Lr6oTUFDgl1GtSOonGdFuQDhO2ko9
	AfKQ==
X-Gm-Message-State: APjAAAWFSoP/uEDACPOfizwTBswF2uw2WdAJRXxJIxsqZy7M0AlJNx1h
	BHVxOEu5zyQii+5Edm7bx3VuZS382t/w8Q==
X-Google-Smtp-Source: APXvYqzwV/m9YHXIVUMGIRC1waarRToz8C2aR4J7IjviqfXkt0KpAKEPrL6eFN95EbOsLrkZDqnWsg==
X-Received: by 2002:a50:871c:: with SMTP id i28mr82985328edb.29.1564149897806; 
	Fri, 26 Jul 2019 07:04:57 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com.
	[209.85.221.49]) by smtp.gmail.com with ESMTPSA id
	br13sm10258764ejb.92.2019.07.26.07.04.55
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Jul 2019 07:04:55 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id f9so54540335wre.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 07:04:55 -0700 (PDT)
X-Received: by 2002:adf:ed41:: with SMTP id u1mr97366899wro.162.1564149894620; 
	Fri, 26 Jul 2019 07:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <jungo.lin@mediatek.com>
	<20190611035344.29814-1-jungo.lin@mediatek.com>
	<20190611035344.29814-10-jungo.lin@mediatek.com>
	<20190701072532.GB137710@chromium.org>
	<1562297618.1212.46.camel@mtksdccf07>
	<CAAFQd5BaTQ-Q7gsE0X+d4_81OZq9WHaCYkmALt7_4A1JFo=_8g@mail.gmail.com>
	<1562313579.1212.73.camel@mtksdccf07>
	<CAAFQd5AaNFpMGCVJREY85n8UetEwd99TOka8-ECoLzMbMkos_g@mail.gmail.com>
	<1563870117.1212.455.camel@mtksdccf07>
	<CAAFQd5Bh80N+cMhz=eyHUGJLaE5uuypOawQvHrTgGSMDvmcpLA@mail.gmail.com>
	<20190726074116.GA19745@infradead.org>
	<CAAFQd5CXwRm-3jD+rfNNDNLH=gT_i0QYSAG3XBo3SJnPTY56_w@mail.gmail.com>
	<4460bc91-352a-7f3a-cbed-1b95e743ca8c@arm.com>
	<1564142386.1212.621.camel@mtksdccf07>
In-Reply-To: <1564142386.1212.621.camel@mtksdccf07>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 26 Jul 2019 23:04:42 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BE1hAgYG-0OY_SEOcz2g4WLeCxP=6G=5xhLb++vewspw@mail.gmail.com>
Message-ID: <CAAFQd5BE1hAgYG-0OY_SEOcz2g4WLeCxP=6G=5xhLb++vewspw@mail.gmail.com>
Subject: Re: [RFC,
	v3 9/9] media: platform: Add Mediatek ISP P1 shared memory device
To: Jungo Lin <jungo.lin@mediatek.com>, Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org,
	=?UTF-8?B?U2VhbiBDaGVuZyAo6YSt5piH5byYKQ==?= <sean.cheng@mediatek.com>,
	=?UTF-8?B?RnJlZGVyaWMgQ2hlbiAo6Zmz5L+K5YWDKQ==?=
	<frederic.chen@mediatek.com>,
	=?UTF-8?B?UnlubiBXdSAo5ZCz6IKy5oGpKQ==?= <rynn.wu@mediatek.com>,
	srv_heupstream <srv_heupstream@mediatek.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?B?UnlhbiBZdSAo5L2Z5a2f5L+uKQ==?= <ryan.yu@mediatek.com>,
	=?UTF-8?B?RnJhbmtpZSBDaGl1ICjpgrHmloflh7Ep?= <frankie.chiu@mediatek.com>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sj Huang <sj.huang@mediatek.com>, "moderated list:ARM/Mediatek SoC support"
	<linux-mediatek@lists.infradead.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, ddavenport@chromium.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
	Linux Media Mailing List <linux-media@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Jul 26, 2019 at 8:59 PM Jungo Lin <jungo.lin@mediatek.com> wrote:
>
> Hi Robin:
>
> On Fri, 2019-07-26 at 12:04 +0100, Robin Murphy wrote:
> > On 26/07/2019 08:42, Tomasz Figa wrote:
> > > On Fri, Jul 26, 2019 at 4:41 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >>
> > >> On Fri, Jul 26, 2019 at 02:15:14PM +0900, Tomasz Figa wrote:
> > >>> Could you try dma_get_sgtable() with the SCP struct device and then
> > >>> dma_map_sg() with the P1 struct device?
> > >>
> > >> Please don't do that.  dma_get_sgtable is a pretty broken API (see
> > >> the common near the arm implementation) and we should not add more
> > >> users of it.  If you want a piece of memory that can be mapped to
> > >> multiple devices allocate it using alloc_pages and then just map
> > >> it to each device.
> > >
> > > Thanks for taking a look at this thread.
> > >
> > > Unfortunately that wouldn't work. We have a specific reserved memory
> > > pool that is the only memory area accessible to one of the devices.
> > > Any idea how to handle this?
> >
> > If it's reserved in the sense of being outside struct-page-backed
> > "kernel memory", then provided you have a consistent CPU physical
> > address it might be reasonable for other devices to access it via
> > dma_map_resource().
> >
> > Robin.
>
> Thank you for your suggestion.
>
> After revising to use dma_map_resource(), it is worked. Below is the
> current implementation. Pleas kindly help us to check if there is any
> misunderstanding.
>
> #define MTK_ISP_COMPOSER_MEM_SIZE               0x200000
>
>         /*
>          * Allocate coherent reserved memory for SCP firmware usage.
>          * The size of SCP composer's memory is fixed to 0x200000
>          * for the requirement of firmware.
>          */
>         ptr = dma_alloc_coherent(p1_dev->cam_dev.smem_dev,
>                                  MTK_ISP_COMPOSER_MEM_SIZE, &addr, GFP_KERNEL);
>         if (!ptr) {
>                 dev_err(dev, "failed to allocate compose memory\n");
>                 return -ENOMEM;
>         }
>         p1_dev->composer_scp_addr = addr;
>         p1_dev->composer_virt_addr = ptr;
>         dev_dbg(dev, "scp addr:%pad va:%pK\n", &addr, ptr);
>
>         /*
>          * This reserved memory is also be used by ISP P1 HW.
>          * Need to get iova address for ISP P1 DMA.
>          */
>         addr = dma_map_resource(dev, addr, MTK_ISP_COMPOSER_MEM_SIZE,
>                                 DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);

This is still incorrect, because addr is a DMA address, but the second
argument to dma_map_resource() is a physical address.

>         if (dma_mapping_error(dev, addr)) {
>                 dev_err(dev, "Failed to map scp iova\n");
>                 ret = -ENOMEM;
>                 goto fail_free_mem;
>         }
>         p1_dev->composer_iova = addr;
>         dev_info(dev, "scp iova addr:%pad\n", &addr);
>
> Moreover, appropriate Tomasz & Christoph's help on this issue.

Robin, the memory is specified using the reserved-memory DT binding
and managed by the coherent DMA pool framework. We can allocate from
it using dma_alloc_coherent(), which gives us a DMA address, not CPU
physial address (although in practice on this platform they are equal
numerically).

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
