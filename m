Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB953C3A59D
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 22:42:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5615206C1
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 22:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5615206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mni.thm.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9CC04BA9;
	Fri, 16 Aug 2019 22:42:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C6445B6C
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 22:42:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout2.fh-giessen.de (mout2.fh-giessen.de [212.201.18.46])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8A614786
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 22:42:53 +0000 (UTC)
Received: from mx1.fh-giessen.de ([212.201.18.40])
	by mout2.fh-giessen.de with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <tobias.johannes.klausmann@mni.thm.de>)
	id 1hykvq-0007N2-AQ; Sat, 17 Aug 2019 00:42:50 +0200
Received: from mailgate-2.its.fh-giessen.de ([212.201.18.14])
	by mx1.fh-giessen.de with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <tobias.johannes.klausmann@mni.thm.de>)
	id 1hykvq-008QGk-5h; Sat, 17 Aug 2019 00:42:50 +0200
Received: from p2e561b42.dip0.t-ipconnect.de ([46.86.27.66]
	helo=[192.168.1.24]) by mailgate-2.its.fh-giessen.de with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
	(envelope-from <tobias.johannes.klausmann@mni.thm.de>)
	id 1hykvp-000Exn-SB; Sat, 17 Aug 2019 00:42:49 +0200
Subject: Re: regression in ath10k dma allocation
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <8fe8b415-2d34-0a14-170b-dcb31c162e67@mni.thm.de>
	<20190816164301.GA3629@lst.de>
	<af96ea6a-2b17-9b66-7aba-b7dae5bcbba5@mni.thm.de>
	<20190816222506.GA24413@Asurada-Nvidia.nvidia.com>
From: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Message-ID: <3f7475e3-e27b-aca7-c21e-71cac6cafc1c@mni.thm.de>
Date: Sat, 17 Aug 2019 00:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101
	Thunderbird/70.0a1
MIME-Version: 1.0
In-Reply-To: <20190816222506.GA24413@Asurada-Nvidia.nvidia.com>
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
	davem@davemloft.net, iommu@lists.linux-foundation.org,
	tobias.klausmann@freenet.de, robin.murphy@arm.com,
	Christoph Hellwig <hch@lst.de>, kvalo@codeaurora.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Nicolin,

On 17.08.19 00:25, Nicolin Chen wrote:
> Hi Tobias
>
> On Fri, Aug 16, 2019 at 10:16:45PM +0200, Tobias Klausmann wrote:
>>> do you have CONFIG_DMA_CMA set in your config?  If not please make sure
>>> you have this commit in your testing tree, and if the problem still
>>> persists it would be a little odd and we'd have to dig deeper:
>>>
>>> commit dd3dcede9fa0a0b661ac1f24843f4a1b1317fdb6
>>> Author: Nicolin Chen <nicoleotsuka@gmail.com>
>>> Date:   Wed May 29 17:54:25 2019 -0700
>>>
>>>       dma-contiguous: fix !CONFIG_DMA_CMA version of dma_{alloc, free}_contiguous()
>> yes CONFIG_DMA_CMA is set (=y, see attached config), the commit you mention
>> above is included, if you have any hints how to go forward, please let me
>> know!
> For CONFIG_DMA_CMA=y, by judging the log with error code -12, I
> feel this one should work for you. Would you please check if it
> is included or try it out otherwise?
>
> dma-contiguous: do not overwrite align in dma_alloc_contiguous()
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c6622a425acd1d2f3a443cd39b490a8777b622d7


Thanks for the hint, yet the commit is included and does not fix the 
problem!

Greetings,

Tobias

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
