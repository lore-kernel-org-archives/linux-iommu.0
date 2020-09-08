Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C14C433E2
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 05:55:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECF72137B
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 05:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PwJlaz8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECF72137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 16FDA8682A;
	Tue,  8 Sep 2020 05:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FZ9bN8RjwvRf; Tue,  8 Sep 2020 05:55:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 663EF86815;
	Tue,  8 Sep 2020 05:55:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51783C0859;
	Tue,  8 Sep 2020 05:55:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B70BFC0859
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 05:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A6711860F0
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 05:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BJlswFXfi5E5 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 05:55:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 095798615E
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 05:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=S3ldECwV6aYVj8kFvW2tKZDE9/xw5MtcF6dMvAAzlgk=; b=PwJlaz8QSQA8PmEsdT/oEaZTXP
 ybFVlLL+6NodzFFNNFhCkvJoI/2GqgQmwf0qU3lL9ljNCgMfVnL+9OubVVmnvsaKQGiXmaOCmfykA
 6tyQ9TLS/LgF/mbnW8+YfiBKz8RdibDRYPaIdUsSX36o/zYxmUJijjHKll8nWoGOq6b0TD++EtI+j
 0U4SS7my6/Cah3C7yLeF3v2knnA3X9WwbpTiRr0rW5bFYo3UxCSdWrtBdJO/lacNS0WCm9RGY8PEK
 ZkEqbNlf9pFfq0IAtR3PK40VroF4oi20xKozo26cC8mqcPqXaqG/dDWKVgLzwIPQwgtnmJqgTXsE4
 L3M7KigA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kFWb0-00057I-8N; Tue, 08 Sep 2020 05:55:10 +0000
Date: Tue, 8 Sep 2020 06:55:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
Message-ID: <20200908055510.GA19078@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
 <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
 <20200908053619.GA15418@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908053619.GA15418@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Tue, Sep 08, 2020 at 06:36:19AM +0100, Christoph Hellwig wrote:
> On Mon, Sep 07, 2020 at 09:18:50PM +0100, Tom Murphy wrote:
> > Yeah we talked about passing an attr to map_sg to disable merging at
> > the following microconfernce:
> > https://linuxplumbersconf.org/event/7/contributions/846/
> > As far as I can remember everyone seemed happy with that solution. I
> > won't be working on this though as I don't have any more time to
> > dedicate to this. It seems Lu Baolu will take over this.
> 
> I'm absolutely again passing a flag.  Tha just invites further
> abuse.  We need a PCI ID based quirk or something else that can't
> be as easily abused.

Also, I looked at i915 and there are just three dma_map_sg callers.
The two dmabuf related ones are fixed by Marek in his series, leaving
just the one in i915_gem_gtt_prepare_pages, which does indeed look
very fishy.  But if that one is so hard to fix it can just be replaced
by an open coded for_each_sg loop that contains manual dma_map_page
calls.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
