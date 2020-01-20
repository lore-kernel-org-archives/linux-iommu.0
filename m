Return-Path: <SRS0=4rPt=3J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF306C32771
	for <iommu@archiver.kernel.org>; Mon, 20 Jan 2020 23:11:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDD3208E4
	for <iommu@archiver.kernel.org>; Mon, 20 Jan 2020 23:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7HdRjx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDD3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AEC28204AB;
	Mon, 20 Jan 2020 23:11:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fd2nj58c8SUH; Mon, 20 Jan 2020 23:11:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0DBAA1FF59;
	Mon, 20 Jan 2020 23:11:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E87C5C0176;
	Mon, 20 Jan 2020 23:11:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3143CC0174
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jan 2020 23:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 185F487404
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jan 2020 23:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0a+cuD8AvadO for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jan 2020 23:11:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D3F4087368
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jan 2020 23:11:09 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id r27so1261275otc.8
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jan 2020 15:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SKP8yEJvIPRamm38nq6sQHvFo27I9jjAhAnyLSp8Eqk=;
 b=Y7HdRjx/0l6IwR2zYR/jo0+1FnpycOhLEVpMVNTtZkLwJUCKY6np7xTsU+u6u8IP9X
 P0Q9lyDZ8MNaE6lAPyw2S2GMfYSBxUG4U5aQJeW6mjlopDYDiKvnjsKC//2++5jBo4Lh
 5cBvbbhmCLO71b6SPdHmQsNgPfQHfanCnji+xABCuJdiPWk9glXGjiXPR5SmorQPAWQi
 PFdJ8VY2/jFlrqhLgsuhGYuUYbKZlsvT9xXVIYvrRw1QsD0Cx1INkCRAmVgYC/4+nXm1
 OGqRp8TIZ/jeNLfUxmp5R4xXJfrjoSrykSYH9MKHGnHLj2DhTa5BTHJkin7iczp03Cpp
 TnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SKP8yEJvIPRamm38nq6sQHvFo27I9jjAhAnyLSp8Eqk=;
 b=jYCoQcCt3CtGPVEpKei9IfOfaEisZvotMwc9XMbvTaCeBeCyKRGLNPoOR/h2m+yLZM
 gvjcenqFq+t3ETSxSHfA3um5W5tHJZFMMEaAZGzDKJ0dZCXzO+dbo514Ov/QvILXTXJo
 +yPPo/eLAmFUbEFLQKKph7ry2jKTxbRLeUC6DQBSclHOGlKcgXMptbMvQS4/NZuTtnlY
 rsZnTBeddq/oNpTZmNEk+oKrl5Ve2iDnSXPZS0UcLebOKvUXyjWXQQ2jLwxWEy/6NuBw
 P8dWB33o+DJ0dbkBbXqQ97hBnb982RmJf3sX68vJRpRvZqZa8EWEbjiGM5P0Yf8bJevB
 xHZw==
X-Gm-Message-State: APjAAAUlCYOjNmWdfx4dMNo5TObaFDRqgOlZcfatd+wA3fUjvjsKiO1W
 3drbQBKFTK2EY0XfHlYyeP3AD17CHGRK5NnF5QPSPL5JFAY=
X-Google-Smtp-Source: APXvYqxxBZWfhkjN4YVm5NI7lG9BUUPEcKfenADjWPC3pOFkvl0dIBsvoXwj1dFzaaYrU70ZrtlGQ7wrF28XJJq66AQ=
X-Received: by 2002:a9d:da2:: with SMTP id 31mr1326815ots.319.1579561868762;
 Mon, 20 Jan 2020 15:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 20 Jan 2020 15:10:57 -0800
Message-ID: <CAM_iQpWw9udHY5A2Gaq7+2WN__SEY2+U12D78=fiJ2xig1HJBA@mail.gmail.com>
Subject: Re: [Patch v3 0/3] iommu: reduce spinlock contention on fast path
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>
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

On Tue, Dec 17, 2019 at 8:40 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> This patchset contains three small optimizations for the global spinlock
> contention in IOVA cache. Our memcache perf test shows this reduced its
> p999 latency down by 45% on AMD when IOMMU is enabled.
>
> (Resending v3 on Joerg's request.)

Hi, Joerg

Can you take these patches?

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
