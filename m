Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF8C43331
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 21:27:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B3521D79
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 21:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMxarZDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B3521D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0F3ACDB7;
	Thu,  7 Nov 2019 21:27:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 46D6ADB3
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 21:27:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E9A8F196
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 21:27:51 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id k1so3970534ioj.6
	for <iommu@lists.linux-foundation.org>;
	Thu, 07 Nov 2019 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eK6q6zrwrUz/2YQcdvxZ3HcYVjvB9LVJa0VW9PrlQgw=;
	b=aMxarZDMn8/+ZTwLmr9xiJrCEyYnzUCeulkISZ+VWIkgM2+Tvg/SIBgLvqCdvgYaro
	7TWwstCis8HR1f+02LH8TxqFrrnfPmbocmfts3bNK6vn+paq2D6upM3h2Dh8ESWimLfR
	7KDp2SG/mmMF+UO1dGo2RVWC0kCR+t0kBzEWplgAndmgir7SdBPEgg+suEYnDu/q2+9R
	Fxour4E/NUcSYDTcC8UOg8KfyYNM792kAl1V5PMVpJpul8vApR8iDeS3A864PM5hz26l
	ceuQ/OlYDJHb0383d+9hMlyudwSg14ciUZ763g7KhMhGHDfIGmhgqb6gfJ22vYJaSefe
	BYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eK6q6zrwrUz/2YQcdvxZ3HcYVjvB9LVJa0VW9PrlQgw=;
	b=e7rO2sA2+m5tKVxdQT+yJ1v5NK06NAZ+LPwg/N+7LmBQzhKHnVZM8qUf4DGhH3VrF+
	W6MzLDn7FZL09lUmp4YmocFLP/12Hi4+kpi0tmJkHWlsUgNC0Tz2u4THOeS8zXkPpKdy
	b8oPpp/22yzlUXQCfibpHtj2f9UlcyWVxiWhNjJ9YnTOBFl9C5CpqXwB0YzlwM6398Li
	+OxcOyWGvgbMFY4lb1uYhnEpswXXjYa5WNTcNf5IPErl1rMRIquz4ag2u2GQx5BybWJS
	eXNyq5icV31/1k2UglVtdlDbqWJBsgUVJ4BDj233hYwGw8cATyws0GxV4Yn541EsX2jG
	NeGQ==
X-Gm-Message-State: APjAAAVwKxwRb/i7s7GBz2v3Gw3pPZmQFFRJ9PWfRp0YDfP3OopFQDAO
	C7Cea0afhInhyT/bNgAJggE80/In7VW89ZxezKI=
X-Google-Smtp-Source: APXvYqwVNe1X+M1QlsTXNL6HXP3xspn+6r9ttBYU8x8guIj6e4OBIfBd4K2Rxf8NXF5PTW22eei0bYBqCz+ztKWoy7s=
X-Received: by 2002:a6b:e403:: with SMTP id u3mr6358356iog.130.1573162070942; 
	Thu, 07 Nov 2019 13:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
In-Reply-To: <20191107205914.10611-1-deepa.kernel@gmail.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Thu, 7 Nov 2019 13:27:35 -0800
Message-ID: <CABeXuvpYE9FCdX-FXTEg-rN_dtoxVn5+2psgU_AxPUPk38fQEw@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To: joro@8bytes.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Thu, Nov 7, 2019 at 12:59 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> +static void intel_iommu_shutdown(void)
> +       if (no_iommu || dmar_disabled)
> +               return;

This check is actually not required here, as the handler is only
installed after these have been checked in intel_iommu_init.
I can remove this in the next version of the patch, but I'll wait a
few days for comments.

-Deepa
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
