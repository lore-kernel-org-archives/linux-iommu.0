Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597ABC432C0
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 19:28:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5A420640
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 19:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBua2pl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5A420640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 31C0C877E7;
	Tue,  3 Dec 2019 19:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NXFp1eMPB9mn; Tue,  3 Dec 2019 19:28:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E832A852CB;
	Tue,  3 Dec 2019 19:28:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2351C1799;
	Tue,  3 Dec 2019 19:28:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04ACBC087F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 88B88852CB
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:28:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LV3egXLanEwN for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 19:28:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BBBE08768F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:28:36 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id x7so2084598pgl.11
 for <iommu@lists.linux-foundation.org>; Tue, 03 Dec 2019 11:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V8NL17ON/XicxfpTxuuNh/N53BkIMVDrR4l3b9XAw50=;
 b=DBua2pl6UC5qpJtQzjq+yHw5VLDF82o8M/HdpRyfjcqfq1N7V/z2IdQEM1QkuFQt/e
 H9l14xZSV09e1WNj6fni0dLH0JrTln7Q9sb9eifN2fMvpFXjiIOyy/fUQxvPUqlx+kr3
 PF0X7+UwHrNzUb40DKWYREz6vcIVZ5kWR8BTYwLnpgwD3L/QHc+L7LtwKCFriU0YsUeb
 xjGyaJvVOpPGeoBN7NI/4axq8L/VYXBsRdsfeIu/pxpaTvGJW0sIWy/pNEbXkmXSt/4J
 xdKEFJQ5jjK9SqIVejfRKnko0T0Helhy7PRuHMHOoxnSSWo6Od4KwwO51Kk9+Uilsy0L
 UR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V8NL17ON/XicxfpTxuuNh/N53BkIMVDrR4l3b9XAw50=;
 b=DJtuGcam/clgYgkqhOjk6WaJPNx+gicYLI1BLHgCY4HYNlIKWY/IasekC2Uh6ZJBPW
 2o7vWvXMY9DZHKc5qwsdLxxXhHOPzAdLK3lXa/hGh0ktELosYHc8/faf44jtuIrWtnIz
 TjXK4AoeljQ/unnvvWMGmjILIk3x8cNcVyZWDERL7sboitGJIY9skmc1CcPPlqiBcI/Y
 A7JOc0+njc8/1ThXtAojQDCE9pXatmxg/MLXM0u9MTRgW/quA1BWuyFUltfjKkXJarV2
 3VcjUB9WmLPOIweFfM8Je67UL+5MhOfrHCGXjzfggkN+h7FhvsMbKB3t8ZO5qB9vd8Vw
 yEWQ==
X-Gm-Message-State: APjAAAWXPKU+nLLTmfiL1UeK8c8pzCkCh0obshIxc4r2ytgvc/fFQ4ER
 qhfvgpQahQeKasIfWuBmCJskpH2rCz1YsKE0poU=
X-Google-Smtp-Source: APXvYqy4s4dfPk7xp2Ss+1hclHrZ6TwmfmX1otoaNzVldov/oHG+i44rkEm6Tq7d+xrqJkcj9Q+MvNI+CsRFw7hpZYA=
X-Received: by 2002:a62:2a4c:: with SMTP id q73mr6480011pfq.94.1575401315515; 
 Tue, 03 Dec 2019 11:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-3-xiyou.wangcong@gmail.com>
 <20191202165921.GB30032@infradead.org>
In-Reply-To: <20191202165921.GB30032@infradead.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 3 Dec 2019 11:28:24 -0800
Message-ID: <CAM_iQpUC0v=0BETLP0=9O89g38Crx5pMB9jcvx3cEkafT+vUkg@mail.gmail.com>
Subject: Re: [Patch v2 2/3] iommu: optimize iova_magazine_free_pfns()
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
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

On Mon, Dec 2, 2019 at 8:59 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +     return (mag && mag->size == IOVA_MAG_SIZE);
>
> > +     return (!mag || mag->size == 0);
>
> No need for the braces in both cases.

The current code is already this, I don't want to mix coding style
changes with a non-coding-style change. You can always remove
them in a separated patch if you feel necessary.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
