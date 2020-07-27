Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_HEADERS,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC91C433E3
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 22:48:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B13020786
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 22:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WioTLJ76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B13020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CD30987A47;
	Mon, 27 Jul 2020 22:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 037owOnZpCO5; Mon, 27 Jul 2020 22:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5059A87A9D;
	Mon, 27 Jul 2020 22:48:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E4A5C0733;
	Mon, 27 Jul 2020 22:48:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16E22C004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 22:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F36AD87C57
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 22:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G67QRUKXBTTy for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 22:48:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3C24087C0A
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 22:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595890085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7DpUnhWTHsvoUdwqfxUUOMTIlMH+umWpPN0dIrg5X8=;
 b=WioTLJ76xxvXSfFEqqrUBWMP6hKk3GrSOf3Ci5JNLl9F819MFtpdvcsUrO98wI3aIxuKGU
 7UAbV3nCS+dCIjVL9Q/kUYiC4YCqTBkWrsHG0qB/5jRtTnU59ptE+Sej5Ampu+nG5ZcuxC
 JXUyxxZDqkd8vFPxmJifWxIG3IGRO9Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-gSe-Q6KLMc2q9sXe2tEsIQ-1; Mon, 27 Jul 2020 18:48:02 -0400
X-MC-Unique: gSe-Q6KLMc2q9sXe2tEsIQ-1
Received: by mail-qt1-f199.google.com with SMTP id h24so12497693qtk.18
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 15:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=g7DpUnhWTHsvoUdwqfxUUOMTIlMH+umWpPN0dIrg5X8=;
 b=qjVWHzU2oD9O9LpuBRwGiItAaeudfPcwi8G3fuMeYDmpsne3IJxdtaRB+h6eiUGBP0
 3yi7xSoFIuxFNbmHPZaYoV+QtBC0kveh+AKri/vCEbYGUD92oYpWCoQV7pvgAZDgALAZ
 DzBRuOk6oGR3/bArwphsysssc8K0lK7wZWIUH9j5Srm1f3BFPd1V2CA6h9p/ZMfKEepX
 vuPVGbzqWvaUuuPlnW+82SVhM2urcL58nDC1//WBJiDQ2FmebD+2fHK+CGd13itLK3sH
 N7XMSOVZaUwH+0PPNCE2awx/gYpH2OtvcaIovA3qYam8YfISf5+4lNZT4h+iHXYk16t0
 Rf+w==
X-Gm-Message-State: AOAM5312hZBg3ZM1WGdMriLSHIgfat4P9K0kGEqNR4IAqSZpTidHW8pr
 qEoHT1ZOjKPVAKTLDz8wbchmNeFQIiQMhizWSZDBKzHJDpl9tZBQbouQybfVuiW5TRs76L/j5aa
 0LQit7a1ZILMswLmBidR4sihv/85Xvw==
X-Received: by 2002:a05:620a:13c4:: with SMTP id
 g4mr25562807qkl.142.1595890080848; 
 Mon, 27 Jul 2020 15:48:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuYLocdQhO8B6g9jpDn6ppAm+zAIH12jWbEP9PdLioydEy0bF3tsSzbG4Iq7w9Rb/5kQHCNg==
X-Received: by 2002:a05:620a:13c4:: with SMTP id
 g4mr25562791qkl.142.1595890080542; 
 Mon, 27 Jul 2020 15:48:00 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id n85sm5167162qkn.80.2020.07.27.15.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 15:47:59 -0700 (PDT)
References: <20200630200636.48600-1-jsnitsel@redhat.com>
User-agent: mu4e 1.4.10; emacs 26.3
From: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v2 0/2] iommu: Move AMD and Intel Kconfig + Makefile bits
 into their directories
In-reply-to: <20200630200636.48600-1-jsnitsel@redhat.com>
Date: Mon, 27 Jul 2020 15:47:58 -0700
Message-ID: <87d04gshgh.fsf@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 2
X-Mimecast-Originator: redhat.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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


Jerry Snitselaar @ 2020-06-30 13:06 MST:

> This patchset imeplements the suggestion from Linus to move the
> Kconfig and Makefile bits for AMD and Intel into their respective
> directories.
>
> v2: Rebase against v5.8-rc3. Dropped ---help--- changes from Kconfig as that was
>     dealt with in systemwide cleanup.
>
> Jerry Snitselaar (2):
>       iommu/vt-d: Move Kconfig and Makefile bits down into intel directory
>       iommu/amd: Move Kconfig and Makefile bits down into amd directory
>
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

Hi Joerg,

Looks like I forgot to cc you on this cover letter for v2.
Does this work for you now?

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
