Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B3EC07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 14:30:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEB961406
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 14:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEB961406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4639241D94;
	Fri,  4 Jun 2021 14:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U_Fc49nBGtOO; Fri,  4 Jun 2021 14:30:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3172B40632;
	Fri,  4 Jun 2021 14:30:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 146AEC000E;
	Fri,  4 Jun 2021 14:30:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EF62C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 14:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A35341D93
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 14:30:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uyXTmE3camoo for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 14:30:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF3E740632
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 14:30:47 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D22B11FD4A;
 Fri,  4 Jun 2021 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622817044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KoSBmFu0e8u3Vwxa9dkANJ68mh7Ai5k4cJWqI1vhM4Y=;
 b=JrFHksKTKLkUuIlW33u6X8mnJzyPXK4rlBWT8qwOMH0l4JyaE3C7PxaLMdrbu3Hoqjw7VL
 B2MtHAJEOb0wlZu6YTkUgswFSmNTGBQcXqxIG8jFgteZI0xzV0xXF6OJZZMygxRA2kuG4v
 a1u6RHGvtN5p3KycCUhL0sMCqY80Eug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622817044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KoSBmFu0e8u3Vwxa9dkANJ68mh7Ai5k4cJWqI1vhM4Y=;
 b=d1HGi28u8GY+RKDBFCUyofVLEi6kmT8WHt0OjXejBfLPkxNrFa5hfURR6Bn0pq4VR19ZrS
 pA7pxbgCbY9YjrAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 90C06118DD;
 Fri,  4 Jun 2021 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622817044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KoSBmFu0e8u3Vwxa9dkANJ68mh7Ai5k4cJWqI1vhM4Y=;
 b=JrFHksKTKLkUuIlW33u6X8mnJzyPXK4rlBWT8qwOMH0l4JyaE3C7PxaLMdrbu3Hoqjw7VL
 B2MtHAJEOb0wlZu6YTkUgswFSmNTGBQcXqxIG8jFgteZI0xzV0xXF6OJZZMygxRA2kuG4v
 a1u6RHGvtN5p3KycCUhL0sMCqY80Eug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622817044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KoSBmFu0e8u3Vwxa9dkANJ68mh7Ai5k4cJWqI1vhM4Y=;
 b=d1HGi28u8GY+RKDBFCUyofVLEi6kmT8WHt0OjXejBfLPkxNrFa5hfURR6Bn0pq4VR19ZrS
 pA7pxbgCbY9YjrAg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 5+OkIRQ5umDdcgAALh3uQQ
 (envelope-from <jroedel@suse.de>); Fri, 04 Jun 2021 14:30:44 +0000
Date: Fri, 4 Jun 2021 16:30:43 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [RESEND PATCH v2] iommu/amd: Fix extended features logging
Message-ID: <YLo5E61tDXG9B3+8@suse.de>
References: <20210504102220.1793-1-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210504102220.1793-1-amonakov@ispras.ru>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

On Tue, May 04, 2021 at 01:22:20PM +0300, Alexander Monakov wrote:
> Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix divergent log levels")
> Link: https://lore.kernel.org/lkml/alpine.LNX.2.20.13.2104112326460.11104@monopod.intra.ispras.ru
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
>  drivers/iommu/amd/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks. And sorry for the delay.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
