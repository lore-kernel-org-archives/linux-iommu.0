Return-Path: <SRS0=zJQD=YK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC27ECE58E
	for <iommu@archiver.kernel.org>; Thu, 17 Oct 2019 16:06:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209AC20640
	for <iommu@archiver.kernel.org>; Thu, 17 Oct 2019 16:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la2N7oWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209AC20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E01A4EF3;
	Thu, 17 Oct 2019 16:06:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 01FC5E24
	for <iommu@lists.linux-foundation.org>;
	Thu, 17 Oct 2019 15:55:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
	[209.85.160.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8C151828
	for <iommu@lists.linux-foundation.org>;
	Thu, 17 Oct 2019 15:55:19 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id c17so1281391qtn.8
	for <iommu@lists.linux-foundation.org>;
	Thu, 17 Oct 2019 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:date:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=v2tCNwGEk6Hjl0LVhFHVd3Y+5ewmpDEB16+jIqUYLmA=;
	b=la2N7oWBGDwB71vWDqJ0B6DpfSrpV/6/nxqHcXbWr9c5lMtwcdAm0qDsQ2fkOleyDm
	TnOLIGFe/xMF8FXyfRM+Fxkoib50RO3x6hnBqmju1HV3ySEy3CAAuAxvP9OXEkvL5tKc
	AEEEeeMA5LFLJjse3erMdt7lFnrEO9hD6r1lrozefqzkUpJuG0wUD0DOOlSexR2C4O0N
	xmkXhgtmUojqNjediux9Nj/2z1U4xiP0cxbc58uatUUxPwdKp7ke61LWkHA3VGw3z8Pj
	A0sSrGQc1p//YaK3OlG2kqqu10j/on8G86TiNKtKt36ix4qD6FsbJmmsVXwIotQxARPE
	/o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=v2tCNwGEk6Hjl0LVhFHVd3Y+5ewmpDEB16+jIqUYLmA=;
	b=M2LLMI+VN27uRuS1KgJzdX1JAjzEyal5Tvo+7KgAjiYqhSi0Nqe2h7av54+lY/FQ4Z
	C+ZeErO8jN5a68S6NtMbh/qKmRBc79QlavDXJTlXpzVRkfTx9NBgzQ7AtL2Ji8cNHFoO
	cgeM7OE8Sy58Gaeti2YmdM67bpbfn7kWmEBDyEGwajv0hdR4P6dL69thPYytgYzAea0H
	sB358IRmYDimW9roAqOxgOG+uIO2hDSF5qK2Lua5PN+17Tb3yz+7qf7o+saHiulv5SkW
	PlYF+Wbl+2TC8W53LbF9nXvaZT/CTUJrAgVtOeCJgYya13EXWNBeA3snmzKxGpiIAVsB
	YY+Q==
X-Gm-Message-State: APjAAAW/ZpI/9qmKLoUFwnujg7dO4xzOxOsCra2yN4vKgWPK5K/WbcPR
	9G+wKTTZpAHYZSItuSW9CNQ=
X-Google-Smtp-Source: APXvYqxYON5/T5tIf8O+GgRotfnKOER2WgXep3Qjk6LvCgXXSSZGdWVEmJHPRG4QuI/ba9RxX7xFMg==
X-Received: by 2002:ad4:4c8c:: with SMTP id bs12mr4484849qvb.171.1571327718324;
	Thu, 17 Oct 2019 08:55:18 -0700 (PDT)
Received: from rani ([2001:470:1f07:5f3:9e5c:8eff:fe50:ac29])
	by smtp.gmail.com with ESMTPSA id
	z46sm2019850qth.62.2019.10.17.08.55.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 17 Oct 2019 08:55:17 -0700 (PDT)
From: Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani>
Date: Thu, 17 Oct 2019 11:55:16 -0400
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
	bypassing the IOMMU
Message-ID: <20191017155515.GA3571354@rani>
References: <20191008143357.GA599223@rani.riverdale.lan>
	<85123533-2e9c-af73-3014-782dd6f925cb@linux.intel.com>
	<20191016191551.GA2692557@rani> <20191017070847.GA15037@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191017070847.GA15037@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Thu, 17 Oct 2019 16:06:48 +0000
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Arvind Sankar <nivedita@alum.mit.edu>,
	David Woodhouse <dwmw2@infradead.org>
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

On Thu, Oct 17, 2019 at 09:08:47AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 16, 2019 at 03:15:52PM -0400, Arvind Sankar wrote:
> > > > Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Tested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Originally-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > Fixed-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > 
> > > This patch looks good to me.
> > > 
> > > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > 
> > 
> > Hi Christoph, will you be taking this through your dma-mapping branch?
> 
> Given this is a patch to intel-iommu I expect Joerg to pick it up.
> But if he is fine with that I can also queue it up instead.

David Woodhouse is listed as maintainer for intel-iommu. Cc'ing him as
well.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
