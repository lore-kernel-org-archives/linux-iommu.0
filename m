Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0DAC2BB1D
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 18:40:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F43F20735
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 18:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GYgmJC/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F43F20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2CBA1893E7;
	Tue, 17 Mar 2020 18:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ykVfK-fI26Du; Tue, 17 Mar 2020 18:40:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 691D7893DA;
	Tue, 17 Mar 2020 18:40:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54D3DC1D74;
	Tue, 17 Mar 2020 18:40:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53AF6C013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 18:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2E1EB22FF0
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 18:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zZuVkvBRjN13 for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 18:40:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by silver.osuosl.org (Postfix) with ESMTPS id ADDDA22F4C
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 18:40:41 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id l13so18375947qtv.10
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 11:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VHKB5MBsrQc8nrjB6tUnlbV1kL4bZZjV/ANQdFM3zDk=;
 b=GYgmJC/1qoccDCyGB3v9AgtNVsE4IcW54DliKpkiU/8qcWTDdff956/y0JBhF6CoW+
 2AF3nNaAMz/neObEUtK5PPJVt6C6RgI8Mamly3muAOZNRXY+QQdadXK48Ee6KpqLHE8+
 2sRqltqPMbyl/9ocejJDj+1YnNKrMgk9wHeYF4k8oNhl0PT7yNA63RmZF0oQYwdNe+IK
 br+N+cfXCWnuHi3IfnIquqLO6xf4ZdjNCFFB2q07lTxjelyugkvRGj5+dyLWtOvVZ5hD
 xdec7OKSTTgRyouKPD5VyOUCJvSrHDwna0Y1VSUzlbHpyFDnaETsTzcMXknVS9MfUmor
 9n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VHKB5MBsrQc8nrjB6tUnlbV1kL4bZZjV/ANQdFM3zDk=;
 b=GFLF5v2OXxdMiIuup7ZXU4TgUowTCWb63qmXJEPqpffeamrKzKlQ/XVhXY2ulvvh6Y
 CUJtWURv6J/jeYkFwdDStsaFviln7GCFM0yuOs9sKhVuyGCGnVGKV/CaKw1AjdGOfk0M
 yqRoiK5Ikl0dGpm7EfG7rwmsjAOjDxq1xev9yMIdA4zNeghKDS6Hti8cJNICte3R6mlA
 U+aSxVZSttcYF3FdOTEPZa373fcCLRSvpbWfPyHKI9de2X1oQyuTr8OtHIjmHXpBjbGz
 jumvvcY9pSP/VYSbCAdXBDOhKuvWTgbwV+fF8lqDAhbg59YoT3XxjWoDKvfEkzn7wiGM
 Wlzg==
X-Gm-Message-State: ANhLgQ0gu8dqB3vEVLlEfCE2jT6q1aVmXwSFELam+5gJkX4FkU9hCO08
 jKiXztsLPMMhSAGH4E8pZBhNRA==
X-Google-Smtp-Source: ADFU+vugAiZdEw2sEZSIbJEAWeyFz2UbVwFEy00ld5KQjtHya0UyHyqsGI1Bsave1cDjhm+ecny+gg==
X-Received: by 2002:ac8:7b54:: with SMTP id m20mr566590qtu.92.1584470440664;
 Tue, 17 Mar 2020 11:40:40 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id 199sm2417617qkm.7.2020.03.17.11.40.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 17 Mar 2020 11:40:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jEH8p-00016b-OY; Tue, 17 Mar 2020 15:40:39 -0300
Date: Tue, 17 Mar 2020 15:40:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200317184039.GV20941@ziepe.ca>
References: <20200224190056.GT31668@ziepe.ca> <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca> <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca> <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca> <20200306095614.GA50020@myrica>
 <20200306130919.GJ31668@ziepe.ca>
 <20200316154659.GA18704@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200316154659.GA18704@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, Dimitri Sivanich <sivanich@sgi.com>,
 catalin.marinas@arm.com, Arnd Bergmann <arnd@arndb.de>,
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 will@kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-pci@vger.kernel.org, zhangfei.gao@linaro.org,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com,
 christian.koenig@amd.com, linux-arm-kernel@lists.infradead.org
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

On Mon, Mar 16, 2020 at 08:46:59AM -0700, Christoph Hellwig wrote:
> On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> > This is why release must do invalidate all - but it doesn't need to do
> > any more - as no SPTE can be established without a mmget() - and
> > mmget() is no longer possible past release.
> 
> Maybe we should rename the release method to invalidate_all?

It is a better name. The function it must also fence future access if
the mirror is not using mmget(), and stop using the pgd/etc pointer if
the page tables are accessed directly.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
