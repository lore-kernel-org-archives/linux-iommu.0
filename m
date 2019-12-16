Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5349C43603
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 14:24:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3862054F
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 14:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SjGlrLrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3862054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4609A874A7;
	Mon, 16 Dec 2019 14:24:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3qxgW9ygJE2Y; Mon, 16 Dec 2019 14:24:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9546A86D67;
	Mon, 16 Dec 2019 14:24:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7886BC18DD;
	Mon, 16 Dec 2019 14:24:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6285C077D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 14:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B4E0586D9A
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 14:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id euoVgbMpdWQ5 for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 14:24:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7369B86D67
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 14:24:31 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id z76so2317460qka.2
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 06:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=xH7Rh+Sv8Avz1lueVqDT1Yxv5WY/6i233yYPIKANZoU=;
 b=SjGlrLrVRpqctVtUTbJuGKVyM+K278q3lPCoB2cw5P3GsxKMy4XD8MLY73pfnypDyT
 UMiohqi+UiQKsTnSJXJqZCnuZmpHYCRs54eY2/jHTlV11oiTn3i40lYYJjgg4Upv9wQo
 OJCU44hoUhgInVlWVqi/B2/FgPacypA/X8QJGjhMKLEfoQ6ZW6SrItdQ6ptGiNQt1y08
 aabNxHzHkmB+/2QRYh7zN95D4AhdK1rGPDj+UAUAysbRw1kY59fI3sfFwP5o0VH47qf0
 yqoSek4eOmZipqQyrqu69FmEufjw+k82bS1zPax1jRsY4vJcTvlqJZZMzLrb0EE51add
 1i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=xH7Rh+Sv8Avz1lueVqDT1Yxv5WY/6i233yYPIKANZoU=;
 b=ZHz33tJhK8/ruI+ZdoY4f8AbgdRJtCa33Boq2EegVEYTEHD/gPhSzeaaQdNKcQUeQL
 v4ZP6uvUWrY6GZ6MvyScv5XtueAiXE6LitCbiC5qqSXKG/oKQTxm8mSJcPjedjw61kE0
 4zbaVxQW6azHoKH+VY8wXpqAY55vvSFIpvZCloCTCzW37j8w8NF5lEcFjI3JsiX/6CKv
 MvR+JpvZCYeYoU8/JUM5fYMEhZ/lfJkH4chMpUiSvi3Rwf5LLXC15CqIoN6Xt4AZRKex
 Sd35aFmF5zrGesDulDqTCb/w+0D9BiKGfvonxifpPCyl7u/V431KUIjN39afdr9jKZHF
 zrOA==
X-Gm-Message-State: APjAAAUPLfQyFCh19mdo0+ziunYmA5mDcNKJtLbm8ckD6faPTQPiqXL+
 qDIPQsd/BbH1SYgO9u5Vo3J7Tw==
X-Google-Smtp-Source: APXvYqyhRC8+rzu6pngzPj+vH8JcT9xSiO4b+vuls4qHAy8CsW5HgNQQyY5CoMVEWlfzrzmgIY5XUg==
X-Received: by 2002:a05:620a:218a:: with SMTP id
 g10mr27269472qka.351.1576506270435; 
 Mon, 16 Dec 2019 06:24:30 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id c8sm635244qtv.61.2019.12.16.06.24.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 06:24:29 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v3] iommu: fix KASAN use-after-free in
 iommu_insert_resv_region
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20191126102743.3269-1-eric.auger@redhat.com>
Date: Mon, 16 Dec 2019 09:24:28 -0500
Message-Id: <0DE725CD-01CD-4E01-B817-9CC7F4768FBC@lca.pw>
References: <20191126102743.3269-1-eric.auger@redhat.com>
To: Eric Auger <eric.auger@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Cc: linux-kernel@vger.kernel.org, hch@lst.de, iommu@lists.linux-foundation.org,
 eric.auger.pro@gmail.com
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



> On Nov 26, 2019, at 5:27 AM, Eric Auger <eric.auger@redhat.com> wrote:
> 
> In case the new region gets merged into another one, the nr
> list node is freed. Checking its type while completing the
> merge algorithm leads to a use-after-free. Use new->type
> instead.
> 
> Fixes: 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
> implementation")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Stable <stable@vger.kernel.org> #v5.3+


Looks like Joerg is away for a few weeks. Could Andrew or Linus pick up this 
use-after-free?

> 
> ---
> 
> v2 -> v3:
> - directly use new->type
> 
> v1 -> v2:
> - remove spurious new line
> ---
> drivers/iommu/iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d658c7c6a2ab..285ad4a4c7f2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -313,7 +313,7 @@ int iommu_insert_resv_region(struct iommu_resv_region *new,
> 		phys_addr_t top_end, iter_end = iter->start + iter->length - 1;
> 
> 		/* no merge needed on elements of different types than @nr */
> -		if (iter->type != nr->type) {
> +		if (iter->type != new->type) {
> 			list_move_tail(&iter->list, &stack);
> 			continue;
> 		}
> -- 
> 2.20.1
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
