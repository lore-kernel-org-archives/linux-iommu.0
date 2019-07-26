Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F83C7618B
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 12:00:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AA3218DA
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 12:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AA3218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6B177CA6;
	Fri, 26 Jul 2019 12:00:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 81F849EE
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 11:59:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id F1B30709
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 11:59:53 +0000 (UTC)
X-UUID: 7f884de187424569bf5cd7ef18904073-20190726
X-UUID: 7f884de187424569bf5cd7ef18904073-20190726
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
	mailgw02.mediatek.com (envelope-from <jungo.lin@mediatek.com>)
	(Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
	with ESMTP id 1644991987; Fri, 26 Jul 2019 19:59:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
	mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Fri, 26 Jul 2019 19:59:46 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Fri, 26 Jul 2019 19:59:46 +0800
Message-ID: <1564142386.1212.621.camel@mtksdccf07>
Subject: Re: [RFC, v3 9/9] media: platform: Add Mediatek ISP P1 shared
	memory device
From: Jungo Lin <jungo.lin@mediatek.com>
To: Robin Murphy <robin.murphy@arm.com>
Date: Fri, 26 Jul 2019 19:59:46 +0800
In-Reply-To: <4460bc91-352a-7f3a-cbed-1b95e743ca8c@arm.com>
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
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-Mailman-Approved-At: Fri, 26 Jul 2019 12:00:24 +0000
Cc: devicetree@vger.kernel.org,
	Sean Cheng =?UTF-8?Q?=28=E9=84=AD=E6=98=87=E5=BC=98=29?=
	<sean.cheng@mediatek.com>,
	Frederic Chen =?UTF-8?Q?=28=E9=99=B3=E4=BF=8A=E5=85=83=29?=
	<frederic.chen@mediatek.com>,
	Rynn Wu =?UTF-8?Q?=28=E5=90=B3=E8=82=B2=E6=81=A9=29?=
	<rynn.wu@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>,
	Rob Herring <robh@kernel.org>,
	Ryan Yu =?UTF-8?Q?=28=E4=BD=99=E5=AD=9F=E4=BF=AE=29?=
	<ryan.yu@mediatek.com>,
	Frankie Chiu =?UTF-8?Q?=28=E9=82=B1=E6=96=87=E5=87=B1=29?=
	<frankie.chiu@mediatek.com>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Matthias
	Brugger <matthias.bgg@gmail.com>, Sj Huang <sj.huang@mediatek.com>,
	"moderated list:ARM/Mediatek SoC support"
	<linux-mediatek@lists.infradead.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, ddavenport@chromium.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org, Linux
	Media Mailing List <linux-media@vger.kernel.org>
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

Hi Robin:

On Fri, 2019-07-26 at 12:04 +0100, Robin Murphy wrote:
> On 26/07/2019 08:42, Tomasz Figa wrote:
> > On Fri, Jul 26, 2019 at 4:41 PM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> On Fri, Jul 26, 2019 at 02:15:14PM +0900, Tomasz Figa wrote:
> >>> Could you try dma_get_sgtable() with the SCP struct device and then
> >>> dma_map_sg() with the P1 struct device?
> >>
> >> Please don't do that.  dma_get_sgtable is a pretty broken API (see
> >> the common near the arm implementation) and we should not add more
> >> users of it.  If you want a piece of memory that can be mapped to
> >> multiple devices allocate it using alloc_pages and then just map
> >> it to each device.
> > 
> > Thanks for taking a look at this thread.
> > 
> > Unfortunately that wouldn't work. We have a specific reserved memory
> > pool that is the only memory area accessible to one of the devices.
> > Any idea how to handle this?
> 
> If it's reserved in the sense of being outside struct-page-backed 
> "kernel memory", then provided you have a consistent CPU physical 
> address it might be reasonable for other devices to access it via 
> dma_map_resource().
> 
> Robin.

Thank you for your suggestion.

After revising to use dma_map_resource(), it is worked. Below is the
current implementation. Pleas kindly help us to check if there is any
misunderstanding.

#define MTK_ISP_COMPOSER_MEM_SIZE		0x200000

	/*
	 * Allocate coherent reserved memory for SCP firmware usage.
	 * The size of SCP composer's memory is fixed to 0x200000
	 * for the requirement of firmware.
	 */
	ptr = dma_alloc_coherent(p1_dev->cam_dev.smem_dev,
				 MTK_ISP_COMPOSER_MEM_SIZE, &addr, GFP_KERNEL);
	if (!ptr) {
		dev_err(dev, "failed to allocate compose memory\n");
		return -ENOMEM;
	}
	p1_dev->composer_scp_addr = addr;
	p1_dev->composer_virt_addr = ptr;
	dev_dbg(dev, "scp addr:%pad va:%pK\n", &addr, ptr);

	/*
	 * This reserved memory is also be used by ISP P1 HW.
	 * Need to get iova address for ISP P1 DMA.
	 */
	addr = dma_map_resource(dev, addr, MTK_ISP_COMPOSER_MEM_SIZE,
				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
	if (dma_mapping_error(dev, addr)) {
		dev_err(dev, "Failed to map scp iova\n");
		ret = -ENOMEM;
		goto fail_free_mem;
	}
	p1_dev->composer_iova = addr;
	dev_info(dev, "scp iova addr:%pad\n", &addr);

Moreover, appropriate Tomasz & Christoph's help on this issue.

Best regards,

Jungo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
