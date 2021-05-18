Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BBCC433ED
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 05:49:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6953D611AD
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 05:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6953D611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21FF34026F;
	Tue, 18 May 2021 05:49:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id obz4flzCHbnr; Tue, 18 May 2021 05:49:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBF6040253;
	Tue, 18 May 2021 05:49:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5A0CC000D;
	Tue, 18 May 2021 05:49:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7120AC0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 05:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E7B040145
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 05:49:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kroah.com header.b="e+QkxxAf";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="bN9fBnTb"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZjF56jHTb95q for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 05:49:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41194402E3
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 05:49:03 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 252145C019B;
 Tue, 18 May 2021 01:49:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 18 May 2021 01:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=m7L31pXv8sUiqNZeuzfEwawxBqG
 rTSV4u+sf5gf1YNE=; b=e+QkxxAfFRil7lwcA+jGvJDUxriEc7qIQ1FAoGh19p6
 FZ/OnISXvnggXoe2ghkpSQsCrJjMcvSjTSlUiDnpAGVZf0jiPvQWd4ZbL5CJyydh
 hETeHHqwtrvQeE8siu5fp1HSBeweF2+s5YIOjoXJ9akXeGWGgsN8r8Uz046G9gVF
 Z/LAH8+qYJYHSda31VcOjU+dxomWzr6UaRXxn73VK360sbl+w286y9FNqBpppDDV
 uNgIIKJn2i19bqxCGB9UIOd7xcGVJ+gCsEokj7MvxWWIqvCAVrBwB/ZExB+SU4CE
 Pl6yLmOOTI5yH7OnPjX+KRyNKv2plzPZHejql37TWPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=m7L31p
 Xv8sUiqNZeuzfEwawxBqGrTSV4u+sf5gf1YNE=; b=bN9fBnTbzdl9BIktvZh/H7
 I5SqxymyxOUe3UaM8IltZCZ1nv1Ld63xhWlaLdTijde9WayGmdZSkl6IEsDt73M8
 imhatS89crLqLzI01NoIsLgryQAPSikSWDGVXk8kBFPbOw9+lWu1/zeg6KxzkFWl
 qTU0uoxr0rdaOqrwJb7mh0DRiBIGl7FuQJCPJqUtmIGD6DBK9bkFDQ2Pz92EiHvL
 zY1Cj0Y643KltOVllMFB/P+LoAEvdf7KfymrZ0o2yAWMx13lPsIi5HOpQDJ0wftF
 vqJncRc+KgekzE+4Ekaiocf2pz52GKB6KaXtd7fJuzwWzLdPYVxOnBBJlJnJDm4Q
 ==
X-ME-Sender: <xms:S1WjYF6Vznf13AjBoubz8w-w9JRQq5ClNQkxfo88FTSV191JdZrxiQ>
 <xme:S1WjYC4pxhu7o4Y-j06Bbk72IiBnx94KDSCws2F6Dq1u-rKmSB4iRNWVrBk1UUNDO
 Hwbf-N71l4Yag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiiedgleegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
 dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
 necuggftrfgrthhtvghrnhepueelledtheekleethfeludduvdfhffeuvdffudevgeehke
 egieffveehgeeftefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeef
 rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:S1WjYMc0J64VQ1UarF-ymOHRXhG8zfs9cJj47xxl0ROugB_2bPI6Jg>
 <xmx:S1WjYOKuc94RU1seFUgW2HFvHBXm7jxG1yte2OB-q1v45sJiZkS4Og>
 <xmx:S1WjYJJG_BaXWRpjOTL_Bh42DDDSx0EwPH_s2Hr2kKbTqaiiOpg55w>
 <xmx:TFWjYHiKQz2gyBv0B3s1fEMzCWJ4nBjoPZbAyPYxOzy3eA3mNbjtFg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 by mail.messagingengine.com (Postfix) with ESMTPA;
 Tue, 18 May 2021 01:48:59 -0400 (EDT)
Date: Tue, 18 May 2021 07:48:53 +0200
From: Greg KH <greg@kroah.com>
To: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Subject: Re: 5.10.37 won't boot on my system, but 5.10.36 with same config does
Message-ID: <YKNVRUWNpN7mNTI3@kroah.com>
References: <e0e9ecf4-cfd7-b31a-29b0-ead4a6c0ee40@charleswright.co>
 <1621180418@msgid.manchmal.in-ulm.de> <YKI/D64ODBUEHO9M@kroah.com>
 <1621251453@msgid.manchmal.in-ulm.de>
 <1621251685@msgid.manchmal.in-ulm.de>
 <CA+res+RHyF22T-sGwCG5zA6EBrk_gWbnZETX_iAgdRdWaPLbfw@mail.gmail.com>
 <1621254246@msgid.manchmal.in-ulm.de>
 <CA+res+QRm3VyJSjMaKLYm=KY5+T5nX+6-QhOgrgBcP+d2Ganag@mail.gmail.com>
 <YKJ5ysGAuI32Jpn6@kroah.com> <1621290515@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1621290515@msgid.manchmal.in-ulm.de>
Cc: iommu@lists.linux-foundation.org, stable <stable@vger.kernel.org>
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

On Tue, May 18, 2021 at 12:30:15AM +0200, Christoph Biedl wrote:
> Greg KH wrote...
> 
> > On Mon, May 17, 2021 at 02:45:01PM +0200, Jack Wang wrote:
> 
> > > So it's caused by this commit[1], and it should be fixed by latest
> > > 5.10.38-rc1 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=linux-5.10.y
> > > [1]https://lore.kernel.org/stable/20210515132855.4bn7ve2ozvdhpnj4@nabokov.fritz.box/
> > 
> > Hopefully the "real" 5.10.38-rc1 release that is out now should fix
> > this.  If not, please let us know.
> 
> Good news: Fixed with that "real" 5.10.38-rc1.

Wonderful!  Thanks for testing and letting us know.

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
