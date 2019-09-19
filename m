Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99723C4CEC4
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 20:34:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9E5207FC
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 20:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S3FWlmta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9E5207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0F079C3A;
	Thu, 19 Sep 2019 20:34:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 75BC9C37
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 20:34:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
	[209.85.167.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D47D2711
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 20:34:10 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id w67so3362477lff.4
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 13:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=6grpKTdDHfrbCxCmgX04tALzM2BaTcUONJxBFtS7/lc=;
	b=S3FWlmtalm02jQyJlhwBVUyRbo4LVnG04lBW17Zh/rM24U46hU9edZ8kfmA06+aF9P
	OCDHQuGS85M+r15ZS8w8p2AuuOaxpYBIEy7/K399Ohz2kO+HjNMiBSjs53Jhs8Tayd30
	RhVK3wUpwCIOZyzj1b4OwhDrWT6ry27EnqdWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=6grpKTdDHfrbCxCmgX04tALzM2BaTcUONJxBFtS7/lc=;
	b=Jo+DY67UDkiLxlpjmbxaEwHaxp4gR2gEWHReyh50LkR1mEdDf5vzAgmW9H6QgeOZOK
	16UOMuWlbE5fZRkKttunheEtPBX4iZAEJtozcA78agPqEPUsgjfWSt1N1sC9ZmSMBsCd
	13XFp7r6aGjwaoIsUOFoBmKjiYt6PFGI9adlB3p3AqhFzWzTfXN3og+LhgK+01mDRQsf
	Gmop3x5TpoP/2pH3oyPOPe/DG3FXVoLads92EGRnAzLETl2r/4IsDgbWcbNmotZbAzar
	JkYFKpD/gb6yKBR71TTsgtO0y4IAJ9OIKZ92y29SqV94neav4O8lCVSdofzPcxJFB3GQ
	9Lbw==
X-Gm-Message-State: APjAAAXrlamcBvbJF93GP3O9kuiY8yHb5UHVci7sIhPaHqwJEiqaV7xP
	DfI7VeRO0ZGFaZbFgxlxjYXL/yY2dOabow==
X-Google-Smtp-Source: APXvYqxUvSnKLSncKh+XfvausOwnslL7pjy+JBpIq4+u7j/c7b7T4cD6RDAxUdEfWuEgqGYVnp9egQ==
X-Received: by 2002:ac2:4a69:: with SMTP id q9mr5702655lfp.86.1568925248531;
	Thu, 19 Sep 2019 13:34:08 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com.
	[209.85.167.48])
	by smtp.gmail.com with ESMTPSA id s7sm1861112ljs.16.2019.09.19.13.34.07
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Thu, 19 Sep 2019 13:34:07 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u28so3351400lfc.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 13:34:07 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr6102537lfp.61.1568925247160; 
	Thu, 19 Sep 2019 13:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190918152748.GA21241@infradead.org>
In-Reply-To: <20190918152748.GA21241@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2019 13:33:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
Message-ID: <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping updates for 5.4
To: Christoph Hellwig <hch@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>
Cc: xen-devel@lists.xenproject.org, iommu <iommu@lists.linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Sep 18, 2019 at 8:27 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> please pull the dma-mapping updates for 5.4.

Pulled.

> In addition to the usual Kconfig conflics where you just want to keep
> both edits there are a few more interesting merge issues this time:
>
>  - most importanly powerpc and microblaze add new callers of
>    dma_atomic_pool_init, while this tree marks the function static
>    and calls it from a common postcore_initcall().  The trivial
>    functions added in powerpc and microblaze adding the calls
>    need to be removed for the code to compile.  This will not show up
>    as a merge conflict and needs to be dealt with manually!

So I haven't gotten the powerpc or microblaze pull requests yet, so
I'm not able to fix that part up yet.

Intead, I'm cc'ing Michael Ellerman and Michal Simek to ask them to
remind me when they _do_ send those pull requests, since otherwise I
may well forget and miss it. Without an actual data conflict, and
since this won't show up in my build tests either, it would be very
easy for me to forget.

Micha[e]l, can you both please make sure to remind me?

             Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
