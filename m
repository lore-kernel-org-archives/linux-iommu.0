Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B8C2D0F4
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 19:04:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A036F2075E
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 19:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ESq/rpL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A036F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5701720796;
	Wed,  8 Apr 2020 19:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CzSgsBkl111m; Wed,  8 Apr 2020 19:04:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AA3DB204DA;
	Wed,  8 Apr 2020 19:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D536C1D7E;
	Wed,  8 Apr 2020 19:04:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01397C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DFAEE8832C
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N+9-4mMYQFLf for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 19:04:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 41C5D88306
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:04:49 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id bu9so4224513qvb.13
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=q1dqht7/THs+Vaz6mW8IruPge4J7QbMMMIKzIMhHwmI=;
 b=ESq/rpL6ZbbyIcTZuRj3cGOrNurkH6+4f3l5mjMO+YpssxlILeJR8Ph5y6E6Cf29sI
 CNdWqt08/SQ2wQ61dGEZDnoHkpK0b1hGC6Em1Ksi9SQq+552o1PTL9KdnnFfiYX6rhqd
 N7wlaw+ApjgqKOEHgopdxtpYb7PSt53Vjxsgxe8YtZE4NL7w7CDJhphw0aFiXVcGoYhX
 1msrM1TgrDszJa13iMenJT8u97NNUjtLlnxwgiYe1TITkSWGq4OqMoTJKYdBgKCqieMO
 QVBBluUyqI6r3bJ85V74z6pCJDlyRQy7YXNUSY7QpK2qXY1mvhw4PuFKq0gusSbrzh4A
 sooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=q1dqht7/THs+Vaz6mW8IruPge4J7QbMMMIKzIMhHwmI=;
 b=Te+sCCDuRPLe0/H4epPAV1sL7N472YjhV5E7fZhaP1YQd7i+8PWmpEZdE4t62fp3Vn
 2xo28U9TozGvVxOp1uAdh9mzvSSklmNSXv20bfSWAtJAvvUBIyYdfEI6xvTx/SvnCOxp
 +0ZluwL+cLb/xtEvMXFIUVWC5gRQjyzn4YwqrKYzluxPuI8xQzVRMX6WoSZJuSetzQZV
 QpQbhRvUsi9nSEr3Szj07fIsJlRFPJQ9xRvzhsqfQ9QY1JwSsjiqzyMuABwxbQZeeTLD
 pQAVLPwQLcnnfEtd+becAu5D9yXnpJJVOtvytiYzT/2ae/j1IPpSjRYMuBKOTjrxDjUd
 NGbw==
X-Gm-Message-State: AGi0PuYCeaZhPxWyphrg4pNwpB9t2JxPsblpWfqV4GO+IpP8zQCp5WvE
 4lFCHur0IXZSXpITDaEDttbJEA==
X-Google-Smtp-Source: APiQypIariSX9Q3YZ6+VejX+Z63sZPQCZVX51ralHT7We0/LPZeiYdQyx6UX0zZ3LwM5rOPzf7TqVA==
X-Received: by 2002:a0c:b90a:: with SMTP id u10mr8939050qvf.92.1586372688273; 
 Wed, 08 Apr 2020 12:04:48 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id r34sm20670691qtk.89.2020.04.08.12.04.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 08 Apr 2020 12:04:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jMG0F-0000sf-9T; Wed, 08 Apr 2020 16:04:47 -0300
Date: Wed, 8 Apr 2020 16:04:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200408190447.GB11886@ziepe.ca>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408140427.212807-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, linux-accelerators@lists.ozlabs.org
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

On Wed, Apr 08, 2020 at 04:04:25PM +0200, Jean-Philippe Brucker wrote:
> The IOMMU SVA API currently requires device drivers to implement an
> mm_exit() callback, which stops device jobs that do DMA. This function
> is called in the release() MMU notifier, when an address space that is
> shared with a device exits.
> 
> It has been noted several time during discussions about SVA that
> cancelling DMA jobs can be slow and complex, and doing it in the
> release() notifier might cause synchronization issues (patch 2 has more
> background). Device drivers must in any case call unbind() to remove
> their bond, after stopping DMA from a more favorable context (release of
> a file descriptor).
> 
> So after mm exits, rather than notifying device drivers, we can hold on
> to the PASID until unbind(), ask IOMMU drivers to silently abort DMA and
> Page Requests in the meantime. This change should relieve the mmput()
> path.

At least all the patch comments look like they are on the right track
to me, thanks for doing this.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
