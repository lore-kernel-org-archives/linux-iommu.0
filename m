Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45882C35DF5
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 10:10:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1937721D7E
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 10:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxNo9rOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1937721D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBFAE868F3;
	Tue, 25 Feb 2020 10:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5jZLE0Da4zRi; Tue, 25 Feb 2020 10:10:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4E3C2868B5;
	Tue, 25 Feb 2020 10:10:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 387E3C089F;
	Tue, 25 Feb 2020 10:10:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12B3FC1D8E
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 10:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EF2208670F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 10:10:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I7R5uMZhhDJf for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 10:10:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C01CB84DBD
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 10:10:14 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id s1so6916756pfh.10
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 02:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DyMpEJKs+8inuT3JzdxHRTYW4XbPRxYmHFS7rJcMiTo=;
 b=FxNo9rOoXFWu5407FfbtyWpGIRbj9KKxjTY8RxTKLZ/mRamBivEBBBF8o7iguYZCS8
 o7FmpgVAUMoOvpOlaV53Ni+rnyeUxpEmSlCDQzAgq3EMp5LZgTchDOR4Rtbjchc0ShZA
 xPmjexB8VS+oFN3Szxr7y2OW1DzelczMzVdBWqwUAnW9cqWia+40vQjvQcPpzoTafSwj
 w2kkhPlcAJE/2wVnad5TQ6WRXyttnLoLu3HSQjyg4YU5qRw4xBJMHDlPb6lt1f80TGTK
 EF8lLM32t+LGLvX18eHSOWak+36hGKwbYTMWsfqp7yTAuT5LIeNmjg2MjynP5A+0ch8j
 3Sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DyMpEJKs+8inuT3JzdxHRTYW4XbPRxYmHFS7rJcMiTo=;
 b=hfMw6eIWhIMPFTRCLChFnulcu+MEGyHKjyV9YFkUm/OEw0hL4njCEHIA/YKLbWO7Sh
 wXgPs0k8JCM1aTSb2xHDrkOwpTwL76PLi7gOZfngrpAgQLSpfYLwYgmuVHTW9sx1o6XO
 91hGu1Sz5NtZVx8jATPo0cRdH4HkOoyPDrIhQbYZ1NG0MHHzq4svlyQ8Ft6q6pMhkKAz
 XWEhRp+gEf+KDaJ8YDDGz3ZObrNv1kIkN1XLdBmVJ1NerznlsJtEEMbgz0BKdrFJFzYb
 mPt3r/beQ8/IEFDZamneyOgFjx7yeIYaerTH7cl75oymmWFCepNGh5HX7mdP8Ddi7E8T
 N+6w==
X-Gm-Message-State: APjAAAUiwICgM7kzgtqgJaRzxUnBOL/o1oGluFtjOF2jpPHifWZOdCXJ
 htqFXNUBBvnHjctdCK9kYhU=
X-Google-Smtp-Source: APXvYqz0j531hOiU4KYMfzFOo5zoLMaozISOegwSY9/l8Sa7mBFi1nfsYrnWAhTfioijX7BIKX/e5g==
X-Received: by 2002:aa7:946b:: with SMTP id t11mr55120817pfq.57.1582625414317; 
 Tue, 25 Feb 2020 02:10:14 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
 by smtp.gmail.com with ESMTPSA id r7sm17083740pfg.34.2020.02.25.02.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 02:10:13 -0800 (PST)
Date: Tue, 25 Feb 2020 19:10:10 +0900
From: Stafford Horne <shorne@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] openrisc: use the generic in-place uncached DMA
 allocator
Message-ID: <20200225101010.GC7926@lianli.shorne-pla.net>
References: <20200220170139.387354-1-hch@lst.de>
 <20200220170139.387354-3-hch@lst.de>
 <20200221221447.GA7926@lianli.shorne-pla.net>
 <20200224194528.GA10155@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224194528.GA10155@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Cc: Jonas Bonn <jonas@southpole.se>, Mark Rutland <mark.rutland@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
 linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Feb 24, 2020 at 08:45:28PM +0100, Christoph Hellwig wrote:
> On Sat, Feb 22, 2020 at 07:14:47AM +0900, Stafford Horne wrote:
> > On Thu, Feb 20, 2020 at 09:01:39AM -0800, Christoph Hellwig wrote:
> > > Switch openrisc to use the dma-direct allocator and just provide the
> > > hooks for setting memory uncached or cached.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Reviewed-by: Stafford Horne <shorne@gmail.com>
> > 
> > Also, I test booted openrisc with linux 5.5 + these patches.  Thanks for
> > continuing to shrink my code base.
> 
> I just resent a new version that changes how the hooks work based on
> feedback from Robin.  Everything should work as-is, but if you have
> some time to retest that would be great.

No problem.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
