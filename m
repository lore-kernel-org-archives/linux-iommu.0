Return-Path: <SRS0=j+PZ=S5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05780C43219
	for <iommu@archiver.kernel.org>; Sat, 27 Apr 2019 16:20:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB72F206C1
	for <iommu@archiver.kernel.org>; Sat, 27 Apr 2019 16:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB72F206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8965E1A5A;
	Sat, 27 Apr 2019 16:20:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4821618B9
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 16:18:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from shards.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E63A7786
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 16:18:55 +0000 (UTC)
Received: from localhost (unknown [12.154.31.190])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: davem-davemloft)
	by shards.monkeyblade.net (Postfix) with ESMTPSA id 6471F14C711BA;
	Sat, 27 Apr 2019 09:18:54 -0700 (PDT)
Date: Sat, 27 Apr 2019 12:18:50 -0400 (EDT)
Message-Id: <20190427.121850.1265777273042838957.davem@davemloft.net>
To: laurentiu.tudor@nxp.com
Subject: Re: [PATCH v2 3/9] fsl/fman: backup and restore ICID registers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190427071031.6563-4-laurentiu.tudor@nxp.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
	<20190427071031.6563-4-laurentiu.tudor@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
	(shards.monkeyblade.net [149.20.54.216]);
	Sat, 27 Apr 2019 09:18:55 -0700 (PDT)
Cc: madalin.bucur@nxp.com, netdev@vger.kernel.org, roy.pledge@nxp.com,
	linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
	iommu@lists.linux-foundation.org, camelia.groza@nxp.com,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190427161850.5jJqmutcO1t4XArqYGMXzgdxKIPqb6SOwHYvSpIrAvc@z>

From: laurentiu.tudor@nxp.com
Date: Sat, 27 Apr 2019 10:10:25 +0300

> @@ -1914,7 +1936,10 @@ static int fman_reset(struct fman *fman)
>  static int fman_init(struct fman *fman)
>  {
>  	struct fman_cfg *cfg = NULL;
> -	int err = 0, i, count;
> +	int err = 0, count;
> +#ifdef CONFIG_PPC
> +	int i;
> +#endif
>  
>  	if (is_init_done(fman->cfg))
>  		return -EINVAL;
> @@ -1934,6 +1959,7 @@ static int fman_init(struct fman *fman)
>  	memset_io((void __iomem *)(fman->base_addr + CGP_OFFSET), 0,
>  		  fman->state->fm_port_num_of_cg);
>  
> +#ifdef CONFIG_PPC
>  	/* Save LIODN info before FMan reset
>  	 * Skipping non-existent port 0 (i = 1)
>  	 */

Sorry, I'm not OK with littering a networking driver with arch ifdefs
all over the place.

Please create a proper abstraction and set of interfaces.

Thank you.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
