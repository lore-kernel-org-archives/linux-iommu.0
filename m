Return-Path: <SRS0=VhPo=Y2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E265DCA9ECF
	for <iommu@archiver.kernel.org>; Sat,  2 Nov 2019 03:19:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958CE208E3
	for <iommu@archiver.kernel.org>; Sat,  2 Nov 2019 03:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXNpvQIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958CE208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4BE8FEB4;
	Sat,  2 Nov 2019 03:19:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 52D6EEB2
	for <iommu@lists.linux-foundation.org>;
	Sat,  2 Nov 2019 03:19:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com
	[209.85.161.49])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F12F263D
	for <iommu@lists.linux-foundation.org>;
	Sat,  2 Nov 2019 03:18:59 +0000 (UTC)
Received: by mail-yw1-f49.google.com with SMTP id z144so3017799ywd.1
	for <iommu@lists.linux-foundation.org>;
	Fri, 01 Nov 2019 20:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=XWouDuNtV+RDhaAG30q6oLZ0sfsZSnJ7v4vmZnTcjfA=;
	b=tXNpvQIThdErkOxKdvwj4upuqkPgYohpmkUu8+ubSCRSDZsgOa6TPjMItnAvpXvUJT
	9i3ap+UQryAGvMqftcy4AaLLA2v7rKcvLnaPATPpIuhp3HCV1rGvKQ84WgLXT+V3FEoZ
	zqrHfE6bPGyyMiGbl8NpOiX5YBBvItB/XRBEaGZT6bXf9Lf9f7u5nvdoAIBU3yrdTt5x
	m0q4KLg2IwXci6N7WMmQhK+Bevor+cz6bbpNhyJiBqIRDz6RR0gDR6UDeo/z7mNzz+B1
	FxTZ6R2SzRx27FVYXtPeDWDuVBvsl8RgBXLZdzSnH/PJT/NX706H9yE84cxwySCrfEOu
	Nq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=XWouDuNtV+RDhaAG30q6oLZ0sfsZSnJ7v4vmZnTcjfA=;
	b=PBPiihyZCkpWBMmCc83lEaiCykC0Z398DE32xUCasrrwNT3f47i3Bb0kVcRd8wE+DA
	3TEjLct3HsTE2L/lGxdY/7TIU+VBZFqlNZFjs8izG/pSbJSNNX5MPSnOiH9MDcttyPvB
	sEhR9T7mxAxmOYzVVzY62tIzQbg+abpjTQJU0nFp5Z3LBMIVQijcGmDGEJxrZeDToUt/
	2HYNhvxUBNusme5r4SZiProWFxZyoUKyr1k17f6uvasQFF77Grej90Ij9iIFqqOMBT4v
	MSW9CfdEk62gn1u7iDCkjqdbCchpVxBlmFqAtQYB2frCNvK9tj/Y/WLNUEQcgnZ0f6ul
	vDKw==
X-Gm-Message-State: APjAAAUOmxlx2McE6NEcvlzWXvBKuybWHFr+sKSNe6ogtEM84vaODtuI
	sg6QpkwvZEe+qDfe4vZEcGF735T8ujg8iGc1RN0=
X-Google-Smtp-Source: APXvYqz/vTyRv8Cpfcdwo79Mp38OZJMIk2+jn6NdV2t3BSMT5HGMV3seK5LqTkdWhhHRJUcCR4QF5FjPqFgbRY6jRJs=
X-Received: by 2002:a81:5b43:: with SMTP id p64mr11250421ywb.234.1572664739036;
	Fri, 01 Nov 2019 20:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191101220213.28949-1-hch@lst.de>
In-Reply-To: <20191101220213.28949-1-hch@lst.de>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 1 Nov 2019 20:18:49 -0700
Message-ID: <CAMo8Bf+ctQN405SLVAHmycFx7uQuUixE_cqm1idAV8ZrPkoZQg@mail.gmail.com>
Subject: Re: switch xtensa over to the generic DMA remap / uncached segment
	code
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Zankel <chris@zankel.net>, iommu@lists.linux-foundation.org,
	"open list:TENSILICA XTENSA PORT \(xtensa\)"
	<linux-xtensa@linux-xtensa.org>
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

On Fri, Nov 1, 2019 at 3:02 PM Christoph Hellwig <hch@lst.de> wrote:
> this series switches over xtensa to use the generic DMA remap and
> uncached code.  Xtensa is a little special because it uses an uncached
> segment by default, but can still use page table bits for remapping
> highmem.  To facilitate that there is some major refactoring in the
> common DMA code that merges the remapping code into the main direct
> mapping alloc / free routines.

For the whole series:
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
For the xtensa bits:
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
