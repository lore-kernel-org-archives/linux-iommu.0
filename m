Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C099AC43217
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 09:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 542C64062A;
	Mon, 28 Mar 2022 09:49:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9unwUiIcVcr; Mon, 28 Mar 2022 09:49:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1EE3404B4;
	Mon, 28 Mar 2022 09:49:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65DBBC001D;
	Mon, 28 Mar 2022 09:49:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 873BCC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5FAAA402C4
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sipsolutions.net
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z3byAXyVoCmG for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 09:49:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:191:4433::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC68F4032F
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=/93dChLt+Za1uKCUhSTu2aRMCha+vAJZKphFzk7McsE=; 
 t=1648460941; x=1649670541; b=f41zugckrB2OqXauAT9sfc852LXFz3Tai61DGZPQdaY13M1
 ogVz3Dp/nhTuxFsrIA3peAM4o5k1eDD1oFwi4GuL8vF/oOmAu/2t1KhUj/LXQRi2Rg4NVQgA8eXDV
 Zmou+4a6qfxPG/vQrsB/mhObs5uAvQ1ePo8biVx/TrxnDac1LPDj0AU4Fmt5JQiltkK+5SekPmnlg
 uoKhXAl5B2Xf2bjme0Brkj7kvjgKpTt0unHvVoHMIcEV73Rkq2OlUs1YmaaNN9eYjlg1Oi+knUpXl
 iP2gq2269xIymjVv2eqAP8baeEE7d4mVTV8F76dc/JOQZn4chb85oDWzrP/cVV4w==;
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.95) (envelope-from <johannes@sipsolutions.net>)
 id 1nYlzJ-001WuR-EZ; Mon, 28 Mar 2022 11:48:37 +0200
Message-ID: <f94c4fc26251262de0ecab003c74833617c1b305.camel@sipsolutions.net>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
From: Johannes Berg <johannes@sipsolutions.net>
To: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 28 Mar 2022 11:48:36 +0200
In-Reply-To: <20220327051502.63fde20a.pasic@linux.ibm.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com> <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
 <298f4f9ccad7c3308d3a1fd8b4b4740571305204.camel@sipsolutions.net>
 <CAHk-=whXAan2ExANMryPSFaBWeyzikPi+fPUseMoVhQAxR7cEA@mail.gmail.com>
 <e42e4c8bf35b62c671ec20ec6c21a43216e7daa6.camel@sipsolutions.net>
 <20220327051502.63fde20a.pasic@linux.ibm.com>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Cc: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Netdev <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, 2022-03-27 at 05:15 +0200, Halil Pasic wrote:

> 
> The key here is "sync_sg API, all the parameters must be the same
> as those passed into the single mapping API", but I have to admit,
> I don't understand the *single* in here.
> 

Hah. So I wasn't imagining things after all.

However, as the rest of the thread arrives, this still means it's all
broken ... :)

> The intended meaning of the
> last sentence is that one can do partial sync by choose 
> dma_hande_sync, size_sync such that dma_handle_mapping <= dma_handle_sync
> < dma_handle_mapping + size_mapping and dma_handle_sync + size_sync <=
> dma_handle_mapping + size_mapping. But the direction has to remain the
> same.

Right.

> BTW, the current documented definition of the direction is about the
> data transfer direction between memory and the device, and how the CPU
> is interacting with the memory is not in scope. A quote form the
> documentation.
> 
> """
> ======================= =============================================
> DMA_NONE                no direction (used for debugging)
> DMA_TO_DEVICE           data is going from the memory to the device
> DMA_FROM_DEVICE         data is coming from the device to the memory
> DMA_BIDIRECTIONAL       direction isn't known
> ======================= =============================================
> """
> (Documentation/core-api/dma-api.rst)
> 
> My feeling is, that re-defining the dma direction is not a good idea. But
> I don't think my opinion has much weight here.

However, this basically means that the direction argument to the flush
APIs are completely useless, and we do have to define something
new/else...

johannes
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
