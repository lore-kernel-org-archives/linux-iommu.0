Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B46C4727C
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 14:53:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580E120757
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 14:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX4Y+3jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580E120757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D5A09870B4;
	Tue, 29 Sep 2020 14:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pd-1IhoI4hNx; Tue, 29 Sep 2020 14:53:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61C3D87093;
	Tue, 29 Sep 2020 14:53:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F4B3C016F;
	Tue, 29 Sep 2020 14:53:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B682C0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 14:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4453F870B4
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 14:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8IcWvmjlm96q for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 14:53:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DCA15870B2
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 14:53:39 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id a4so3745449qth.0
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LxdLM+iHttbSOumhWDZv97egHmbUeQtF2b9Swdl0B60=;
 b=hX4Y+3jtPvmClo/JSzRgoXA7gAjY0UBMBegDnAUpaUUZ7Q0TCFt3Rbmkl9e7xFp03h
 8RrDQvip4qZZDm6p9y5GvJy67aDdmxQjqTE7g9ieImWJKEl8VeBCjiA9BP4ZEUbtvAW4
 mksZA6rG6G59SjA9ixhEV2oGgk2ayn5BlCQESHVEBZfgoxvEQ7lrj9uLsAX+LwH5REbL
 EMMRnX6vmW+F3Pj22TnZiHbIJiwkPW9TZRZGq+UK9OJ2hEmuFLUCISVsl7Xs9pEOrgpc
 skwvBWO7Fb5zomGupjbOUIUAXxGPqeje0IPbSJhKm6/deaEvFM/NFc/a2yKxsIbPhRv0
 jswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=LxdLM+iHttbSOumhWDZv97egHmbUeQtF2b9Swdl0B60=;
 b=BSUhdxAAQZzTr4iI4UhIh+0Jgsj6NOS+owjsn48fctYmzBXZXlR1aP9mElCmXEK6ah
 iJB5bV0bOcH2I/KBKk9XRvANSTOQsTE3QktUFV2XXVsFPfUxdJC5FFyEWAfUK4Ut2tXQ
 Um3UnZ/BH3M5g5aQyOEkdDUAULnEZyVr5j4VeGGEAN1r2hpyUbOTRgbfUFsOpS9xyu/3
 i6wfsa+pgtrV3hNLGstNusfsTj/8QskPPKH8a/XHE1RYHR8LET0cHDsPt8oddWABCE3g
 XwXQ2157aZOlgQzrrhJgnz7uf7crRSRFgOHqRJ0BRNT8FBLKsWN28zMnIqU7yjDU6doF
 59Vg==
X-Gm-Message-State: AOAM5316ZoadbFJygRNSConPstgwTdrvyvrx5IzOO3AivbT1Ma8JocOy
 G0Rtkgc3Ng+5/E0H3iAvrlk=
X-Google-Smtp-Source: ABdhPJymfyNEfxzlEcxwwnxSu38R7ekXhi2LVXO3vbzyz7NOzIeyRuscN1rfk14H6x5irwigFmaiaA==
X-Received: by 2002:ac8:6a06:: with SMTP id t6mr3700476qtr.1.1601391218859;
 Tue, 29 Sep 2020 07:53:38 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
 by smtp.gmail.com with ESMTPSA id 192sm4923961qkm.110.2020.09.29.07.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 07:53:38 -0700 (PDT)
From: Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date: Tue, 29 Sep 2020 10:53:35 -0400
To: Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20200929145335.GA2454775@rani.riverdale.lan>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 luto@amacapital.net, Arvind Sankar <nivedita@alum.mit.edu>, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, linux-integrity@vger.kernel.org,
 trenchboot-devel@googlegroups.com, tglx@linutronix.de
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

On Tue, Sep 29, 2020 at 10:03:47AM -0400, Ross Philipson wrote:
> On 9/25/20 3:18 PM, Arvind Sankar wrote:
> > You will also need to avoid initializing data with symbol addresses.
> > 
> > 	.long mle_header
> > 	.long sl_stub_entry
> > 	.long sl_gdt
> > 
...
> > 
> > The other two are more messy, unfortunately there is no easy way to tell
> > the linker what we want here. The other entry point addresses (for the
> > EFI stub) are populated in a post-processing step after the compressed
> > kernel has been linked, we could teach it to also update kernel_info.
> > 
> > Without that, for kernel_info, you could change it to store the offset
> > of the MLE header from kernel_info, instead of from the start of the
> > image.

Actually, kernel_info is currently placed inside .rodata, which is quite
a ways into the compressed kernel, so an offset from kernel_info would
end up having to be negative, which would be ugly. I'll see if I can
come up with some way to avoid this.

> > 
> > For the MLE header, it could be moved to .head.text in head_64.S, and
> > initialized with
> > 	.long rva(sl_stub)
> > This will also let it be placed at a fixed offset from startup_32, so
> > that kernel_info can just be populated with a constant.
> 
> Thank you for the detailed reply. I am going to start digging into this now.
> 
> Ross
> 
> > 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
