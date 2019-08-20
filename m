Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0939C3A5A0
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 02:30:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941A8218BA
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 02:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941A8218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6880EC00;
	Tue, 20 Aug 2019 02:30:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3D27DBE4
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 02:30:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn
	[202.108.3.166])
	by smtp1.linuxfoundation.org (Postfix) with SMTP id 6D49A89E
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 02:30:03 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([222.131.78.247])
	by sina.com with ESMTP
	id 5D5B5B1900024F9A; Tue, 20 Aug 2019 10:29:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 62385857940003
From: Hillf Danton <hdanton@sina.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: regression in ath10k dma allocation
Date: Tue, 20 Aug 2019 10:29:35 +0800
Message-Id: <20190820022935.7016-1-hdanton@sina.com>
MIME-Version: 1.0
Thread-Topic: Re: regression in ath10k dma allocation
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"tobias.klausmann@freenet.de" <tobias.klausmann@freenet.de>,
	Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kvalo@codeaurora.org" <kvalo@codeaurora.org>
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


On Tue, 20 Aug 2019 10:15:01 +0800 Christoph Hellwig wrote:
> On Mon, Aug 19, 2019 at 06:58:52PM -0700, Nicolin Chen wrote:
> > Right...the condition was in-between. However, not every caller
> > of dma_alloc_contiguous() is supposed to have a coherent check.
> > So we either add a 'bool coherent_ok' to the API or revert the
> > dma-direct part back to the original. Probably former option is
> > better?
> >
> > Thank you for the debugging. I have been a bit distracted, may
> > not be able to submit a fix very soon. Would you like to help?
> 
> Yeah, it turns out that while the idea for the dma_alloc_contiguous
> helper was neat it didn't work out at all, and me pushing Nicolin
> down that route was not a very smart idea.  Sorry for causing this
> mess.
> 
> I think we'll just need to open code it for dma-direct for 5.3.
> Hillf do you want to cook up a patch or should I do it?

Feel free to do that, Sir.

Thanks
Hillf

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
