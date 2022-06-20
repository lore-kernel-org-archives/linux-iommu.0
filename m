Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2729FC433EF
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 13:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93D258338B;
	Mon, 20 Jun 2022 13:38:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93D258338B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jFi9Z1e+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J7YfUiEoOxdM; Mon, 20 Jun 2022 13:38:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 64B258308B;
	Mon, 20 Jun 2022 13:38:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64B258308B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34185C0039;
	Mon, 20 Jun 2022 13:38:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9632EC002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 13:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D6FC8316F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 13:38:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D6FC8316F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MzEvRjuZo62x for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 13:38:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD7818308B
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD7818308B
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 13:38:53 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9B3C160A52;
 Mon, 20 Jun 2022 13:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A80AC3411B;
 Mon, 20 Jun 2022 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1655732332;
 bh=xeNQ0+6hDjpNvZkk4v9Q9lxDKoWOP3OWykh/y4PzEg4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jFi9Z1e+H3yTylWZ6HfCXs2xOcJteAbnw0pJcK11A8lNApLffBb7jaoxbtrdIB/dt
 JSKMgzhjwpHtnv0TyD1GSGaWsfl0TcZHgZrH+Fal+Dueu8QsDkGW31FQHq9eJYuOa8
 7njbVEtvUXZUBG1dmz638qYD4/HnGfoqevK+FSP0=
Date: Mon, 20 Jun 2022 15:36:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <YrB30M9yAbUbPFrG@kroah.com>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica>
 <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <YrB1D9rv9G4h/BYU@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YrB1D9rv9G4h/BYU@myrica>
Cc: Yang Shen <shenyang39@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org
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

On Mon, Jun 20, 2022 at 02:24:31PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Jun 17, 2022 at 02:05:21PM +0800, Zhangfei Gao wrote:
> > > The refcount only ensures that the uacce_device object is not freed as
> > > long as there are open fds. But uacce_remove() can run while there are
> > > open fds, or fds in the process of being opened. And atfer uacce_remove()
> > > runs, the uacce_device object still exists but is mostly unusable. For
> > > example once the module is freed, uacce->ops is not valid anymore. But
> > > currently uacce_fops_open() may dereference the ops in this case:
> > > 
> > > 	uacce_fops_open()
> > > 	 if (!uacce->parent->driver)
> > > 	 /* Still valid, keep going */		
> > > 	 ...					rmmod
> > > 						 uacce_remove()
> > > 	 ...					 free_module()
> > > 	 uacce->ops->get_queue() /* BUG */
> > 
> > uacce_remove should wait for uacce->queues_lock, until fops_open release the
> > lock.
> > If open happen just after the uacce_remove: unlock, uacce_bind_queue in open
> > should fail.
> 
> Ah yes sorry, I lost sight of what this patch was adding. But we could
> have the same issue with the patch, just in a different order, no?
> 
> 	uacce_fops_open()
> 	 uacce = xa_load()
> 	 ...					rmmod

Um, how is rmmod called if the file descriptor is open?

That should not be possible if the owner of the file descriptor is
properly set.  Please fix that up.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
